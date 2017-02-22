USE AdventureWorks2012; /*Set current database*/


/*1, Display the total amount collected from the orders for each order date. */ /*for aggreation function group by always end*/
Select orderdate, sum(totaldue) as total
from sales.SalesOrderHeader
Group by orderdate 
Order by sum(totaldue) desc;


/*2, Display the total amount collected from selling the products, 774 and 777. */
select productid, sum(linetotal) as total
from sales.salesorderdetail
where productid = 774 or productid = 777 /*before group by use where, after groupby use having*/
group by productid 
order by sum(linetotal) desc


/*3, Write a query to display the sales person BusinessEntityID, last name and first name of all the sales persons and the name of the territory to which they belong.*/
select sp.BusinessEntityID, p.FirstName, p.LastName, st.Name
from sales.salesperson as sp 
left outer join  person.person as p
on sp.businessentityid = p.BusinessEntityID
left outer join sales.SalesTerritory as st
on sp.TerritoryID = st.TerritoryID
order by sp.BusinessEntityID asc; 


/*4,  Write a query to display the Business Entities of the customers that have the 'Vista' credit card.*/
/* Tables: Sales.CreditCard, Sales.PersonCreditCard, Person.Person*/
select pcc.BusinessEntityID, p.FirstName, p.LastName, cc.CardType
from sales.PersonCreditCard as pcc
left outer join person.person as p
on pcc.BusinessEntityID = p.BusinessEntityID
left outer join sales.CreditCard as cc
on pcc.CreditCardID = cc.CreditCardID
where cc.CardType = 'Vista' and p.persontype = 'SC'
order by pcc.BusinessEntityID asc; 

/*Show the number of customers for each type of credit cards*/
select count(pcc.businessentityid) as numberofcustomer, cc.CardType
from sales.PersonCreditCard as pcc
left outer join person.person as p
on pcc.BusinessEntityID = p.BusinessEntityID
left outer join sales.CreditCard as cc
on pcc.CreditCardID = cc.CreditCardID
where p.persontype = 'SC'
group by cc.CardType; 


/*5, Write a query to display ALL the country region codes along with their corresponding territory IDs*/
/* tables: Sales.SalesTerritory*/
select c.countryregioncode, st.TerritoryID /*if territoryid is only present in one table, then dont have to put st. on it*/
from sales.SalesTerritory as st 
right outer join person.countryregion as c
on st.CountryRegionCode = c.CountryRegionCode;



/*6, Find out the average of the total dues of all the orders.*/
select avg (TotalDue) as Avg_due
from sales.SalesOrderHeader; 


/*7, Write a query to report the sales order ID of those orders where the total due is greater than the average of the total dues of all the orders*/
Select Salesorderid, Totaldue /*Use the concept of subquery*/
from sales.SalesOrderHeader
where totaldue > 
(Select avg (TotalDue)
from sales.SalesOrderHeader)
order by totaldue;




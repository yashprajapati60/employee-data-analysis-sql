
select* from sql__uber_ride_insights ; 
alter table sql__uber_ride_insights rename To uber;
select*from sql__uber1_ride_insights ;
alter table sql__uber1_ride_insights rename to driverside;
select*from sql__uber2_ride_insights  ;
alter table sql__uber2_ride_insights rename to driverdata;

#____----BASIC LEVEL----____#

#1.What are & how many unique pickup locations are there in the dataset?
select count(pickup_location) from uber;
select distinct (pickup_location) from uber;

#2.What is the total number of rides in the datase
select count(ride_id) from uber;

#3.Calculate the average ride duration.
select*from uber;
select avg(ride_duration) from uber;

#4.List the top 5 drivers based on their total earnings.
select *from uber;
select driver_id,sum(fare_amount) from uber group by driver_id order by sum(fare_amount) desc limit 5 ;

#5.Calculate the total number of rides for each payment method.
select payment_method,count(*)  from uber group by payment_metho d ;

#6.Retrieve rides with a fare amount greater than 20.
select ride_id,fare_amount from uber where fare_amount>20 order by fare_amount desc;

#7.Identify the most common pickup location.
select distinct(pickup_location),count(*) from uber group by pickup_location order by count(*) desc ;

#8.Calculate the average fare amount.
select avg(fare_amount) from uber;

#9.List the top 10 drivers with the highest average ratings.
select*from driverside ;
select passenger_name ,avg(rating)  from driverside group by passenger_name   order by avg(rating) desc limit 10;

#10.Calculate the total earnings for all drivers.
select sum(total_spent) from driverside;

#11.How many rides were paid using the "Cash" payment method?
select payment_method,count(*)  from uber where payment_method="cash";

#12.Calculate the number of rides & average ride distance for rides originating from the 'Dhanbad' pickup location.
select avg(ride_distance),pickup_location,count(*)  from uber where pickup_location ="dhanbad" group by pickup_location  ;

#13.Retrieve rides with a ride duration less than 10 minutes.
select *from uber;
select *from uber where ride_duration<10;

#14.List the passengers who have taken the most number of rides.
select *from driverside order by total_rides desc;

#15.Calculate the total number of rides for each driver in descending order.
select count(*),driver_id  from uber group by driver_id order by count(*) desc;

#16.Identify the payment methods used by passengers who took rides from the 'Gandhinagar' pickup location.
select payment_method,pickup_location from uber where pickup_location ="gandhinagar";

#17.Calculate the average fare amount for rides with a ride distance greater than 10.
select avg(fare_amount),ride_duration from uber where ride_duration>10 group by ride_duration order by ride_duration desc;

#18.List the drivers in descending order according to their total number of rides.
select driver_id,driver_name,total_rides from driverdata order by total_rides desc;

#19.Calculate the percentage distribution of rides for each pickup location.
select count(*),pickup_location,round(count(*) * 100.0/ (select count(*) from uber),3) as perct 
from uber group by pickup_location order by perct desc;

#20.Retrieve rides where both pickup and dropoff locations are the same.
select *from uber where pickup_location = dropoff_location ;

#____----INTERMEDIATE LEVEL----____#

#1.List the passengers who have taken rides from at least 300 different pickup locations.
select * from uber;
select passenger_id,count(distinct pickup_location)as dis_pl from uber group by passenger_id having dis_pl>=300 ;

#2.Calculate the average fare amount for rides taken on weekdays.
select avg(fare_amount) from 

#3.Identify the drivers who have taken rides with distances greater than 19.
select driver_id,ride_distance  from uber  where  ride_distance>=19 ;

#4.Calculate the total earnings for drivers who have completed more than 100 rides.
select *from driverdata;
select driver_id,sum(earnings) from driverdata 
where driver_id in(select driver_id from uber group by driver_id having count(*)>100)
group by driver_id ; 

#5.Retrieve rides where the fare amount is less than the average fare amount.
select*from uber where fare_amount<(select avg(fare_amount) from uber);

#6.Calculate the average rating of drivers who have driven rides with both 'Credit Card' and 'Cash' payment methods.
select avg(rating),driver_id from driverdata where driver_id in(select driver_id  from uber where payment_method 
in('credit Card','cash') group by driver_id  having count(distinct payment_method)=2) group by driver_id;

#7.List the top 3 passengers with the highest total spending.
select*from driverside d ;
select driverside.passenger_id,driverside.passenger_name,sum(uber.fare_amount) 
from driverside join uber on driverside.passenger_id=uber.passenger_id 
group by driverside.passenger_id,driverside.passenger_name order by sum(uber.fare_amount) desc limit 3;

#8.Calculate the average fare amount for rides taken during different months of the year.
select

#9.Identify the most common pair of pickup and dropoff locations.
select pickup_location,dropoff_location,count(*)  from uber group by pickup_location,dropoff_location order by count(*) desc limit 1; 

#10.Calculate the total earnings for each driver and order them by earnings in descending order.
select driver_id as x,sum(earnings) as y  from driverdata group by x order by y desc ;

#11.List the passengers who have taken rides on their signup date.
-- select passenger_name,signup_date,total_rides from driverside  ;
-- SELECT driverside.passenger_id, driverside.passenger_name
-- FROM driverside JOIN uber ON driverside.passenger_id = uber.passenger_id
-- WHERE DATE(driverside.signup_date)= date(uber.ride_timestamp);
SELECT driverside.passenger_id, driverside.passenger_name
FROM driverside
JOIN uber ON  uber.passenger_id = driverside.passenger_id 
WHERE 
DATE(STR_TO_DATE(driverside.signup_date, '%m/%d/%Y')) = DATE(STR_TO_DATE(uber.ride_timestamp, '%m/%d/%Y'));

select*from uber;
select*from driverside;

#12.Calculate the average earnings for each driver and order them by earnings in descending order.
select avg(earnings),driver_name 
from driverdata group by driver_name order by avg(earnings) desc;

#13.Retrieve rides with distances less than the average ride distance.
select *  from uber where ride_distance <(select avg(ride_distance)from uber);

#14.List the drivers who have completed the least number of rides.
select count(*)ride_count,driver_id  from driverdata group by driver_id  order by ride_count asc;

#15.Calculate the average fare amount for rides taken by passengers who have taken at least 20 rides.
select avg(fare_amount) from uber where passenger_id in(select passenger_id  from uber group by passenger_id having count(*)>=20);

#16.Identify the pickup location with the highest average fare amount.
select pickup_location,avg(fare_amount) from uber group by pickup_location order by avg(fare_amount) desc limit 3;

#17.Calculate the average rating of drivers who completed at least 100 rides.
select driver_name,avg(rating) from driverdata where total_rides>=100 group by driver_name order by avg(rating);

#18.List the passengers who have taken rides from at least 5 different pickup locations.
select*from driverside;
select passenger_id,count(distinct pickup_location) from uber group by passenger_id having count(distinct pickup_location)>=5;

#19.Calculate the average fare amount for rides taken by passengers with ratings above 4.
select avg(fare_amount) from uber where passenger_id in (select passenger_id from driverside where rating>4);

#20.Retrieve rides with the shortest ride duration in each pickup location.
select *from uber;
select distinct(pickup_location),ride_duration from uber where ride_duration=(select min(ride_duration) from uber);


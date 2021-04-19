DROP TABLE departments CASCADE;
DROP TABLE dept_emp CASCADE;
DROP TABLE dept_manager CASCADE;
DROP TABLE employees CASCADE;
DROP TABLE salaries CASCADE;
DROP TABLE titles CASCADE;


create table titles(
	title_id varchar not null,
	title varchar not null,
	primary key (title_id)
);

create table employees(
	emp_no integer not null,
	emp_title_id varchar not null,
	birth_date date not null,
	first_name varchar not null,
	last_name varchar not null,
	sex varchar not null,
	hire_date date not null,
	primary key(emp_no),
	foreign key(emp_title_id) references titles(title_id)
);

create table departments(
	dept_no varchar not null,
	dept_name varchar not null,
	primary key (dept_no)
);

create table dept_manager(
	dept_no varchar not null,
	emp_no integer not null, 
	foreign key (emp_no) references employees (emp_no),
	foreign key (dept_no) references departments (dept_no),
	primary key (dept_no, emp_no)
);

create table dept_emp(
	emp_no integer not null,
	dept_no varchar not null,
	foreign key (emp_no) references employees (emp_no),
	foreign key (dept_no) references departments (dept_no),
	primary key (emp_no, dept_no)
);

create table salaries(
	emp_no integer,
	salary integer,
	foreign key (emp_no) references employees (emp_no),
	primary key (emp_no)
);

select * from employees
--List the following details of each employee: employee number, last name, first name, 
--sex, and salary.

SELECT employees.emp_no, employees.first_name, employees.last_name, employees.sex, salaries.salary
FROM employees 
LEFT JOIN salaries ON
employees.emp_no=salaries.emp_no;

--List first name, last name, and hire date for employees who were hired in 1986.
SELECT e.first_name, e.last_name, e.hire_date
FROM employees as e
WHERE hire_date BETWEEN '1986-01-01' AND '1987-01-01'

--List the manager of each department with the following information: department number, 
--department name, the manager's employee number, last name, first name.

SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no;

--List the department of each employee with the following information: employee number, 
--last name, first name, and department name.

SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;

--List first name, last name, and sex for employees whose first name is "Hercules" 
--and last names begin with "B."
SELECT employees.first_name, employees.last_name, employees.sex
FROM employees
WHERE first_name = 'Hercules' 
	AND last_name LIKE 'B%'
	
--List all employees in the Sales department, including their employee number, last name, 
--first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales'

--List all employees in the Sales and Development departments, including their employee number
--last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales'
	OR departments.dept_name = 'Development'
	
--In descending order, list the frequency count of employee last names, i.e., how many 
--employees share each last name.

SELECT employees.last_name, COUNT(last_name)AS Frequency
FROM employees
GROUP BY last_name
ORDER BY
	COUNT(last_name) DESC

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5668770E352
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbjEWRXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbjEWRXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:23:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D292E65;
        Tue, 23 May 2023 10:23:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF74C63525;
        Tue, 23 May 2023 17:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0D7C433D2;
        Tue, 23 May 2023 17:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684862583;
        bh=p7ab7LGLVqL3lBwP75ITIw96hr6dcb5ZLaLjEH8zrnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MBlwwXDvsiXVoIp0RvSzKIKB+5VrBHVaYd9dJgv806xc6QwvqYYvpOCR6VRap+FIg
         MH5Bej9xaatEyY2RBPCLdfzQD5IWTm6rmOdBDzZjYxIXehPw+HkY5OhoUUnwVYBwhB
         6OiNr3aMx1FcXtKUKvyYPvqum0pe3airtYFLJnH8XalyTyQjxynAc+eSUi7OUBHL+c
         TAHbxZQPG9tfONRP0A+NMx0PnSJJNajEYtI5UX+FarkvwTwDs8kjRIonR8jPjXRbwP
         iZb6agnSTSRx7emenYwVPuC8zZ5nVyK7Jfx2DtJgRhy4xpOCPcGg3tnznWvbN8tEhv
         NrQ8wgAMeskpg==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH V2 3/3] tracing/timerlat: Add user-space interface
Date:   Tue, 23 May 2023 19:22:48 +0200
Message-Id: <a7b2c215c763e95a56fa1258743332b570c81c9d.1684860626.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1684860626.git.bristot@kernel.org>
References: <cover.1684860626.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Going a step further, we propose a way to use any user-space
workload as the task waiting for the timerlat timer. This is done
via a per-CPU file named osnoise/cpu$id/timerlat_fd file.

The tracef_fd allows a task to open at a time. When a task reads
the file, the timerlat timer is armed for future osnoise/timerlat_period_us
time. When the timer fires, it prints the IRQ latency and
wakes up the user-space thread waiting in the timerlat_fd.

The thread then starts to run, executes the timerlat measurement, prints
the thread scheduling latency and returns to user space.

When the thread rereads the timerlat_fd, the tracer will print the
user-ret(urn) latency, which is an additional metric.

This additional metric is also traced by the tracer and can be used, for
example of measuring the context switch overhead from kernel-to-user and
user-to-kernel, or the response time for an arbitrary execution in
user-space.

The tracer supports one thread per CPU, the thread must be pinned to
the CPU, and it cannot migrate while holding the timerlat_fd. The reason
is that the tracer is per CPU (nothing prohibits the tracer from
allowing migrations in the future). The tracer monitors the migration
of the thread and disables the tracer if detected.

The timerlat_fd is only available for opening/reading when timerlat
tracer is enabled, and NO_OSNOISE_WORKLOAD is set.

The simplest way to activate this feature from user-space is:

 -------------------------------- %< -----------------------------------
 int main(void)
 {
	char buffer[1024];
	int timerlat_fd;
	int retval;
	long cpu = 0;	/* place in CPU 0 */
	cpu_set_t set;

	CPU_ZERO(&set);
	CPU_SET(cpu, &set);

	if (sched_setaffinity(gettid(), sizeof(set), &set) == -1)
		return 1;

	snprintf(buffer, sizeof(buffer),
		"/sys/kernel/tracing/osnoise/per_cpu/cpu%ld/timerlat_fd",
		cpu);

	timerlat_fd = open(buffer, O_RDONLY);
	if (timerlat_fd < 0) {
		printf("error opening %s: %s\n", buffer, strerror(errno));
		exit(1);
	}

	for (;;) {
		retval = read(timerlat_fd, buffer, 1024);
		if (retval < 0)
			break;
	}

	close(timerlat_fd);
	exit(0);
}
 -------------------------------- >% -----------------------------------

When disabling timerlat, if there is a workload holding the timerlat_fd,
the SIGKILL will be sent to the thread.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 Documentation/trace/timerlat-tracer.rst |  78 ++++++
 kernel/trace/trace_osnoise.c            | 312 +++++++++++++++++++++++-
 kernel/trace/trace_output.c             |   4 +-
 3 files changed, 391 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/timerlat-tracer.rst b/Documentation/trace/timerlat-tracer.rst
index db17df312bc8..53a56823e903 100644
--- a/Documentation/trace/timerlat-tracer.rst
+++ b/Documentation/trace/timerlat-tracer.rst
@@ -180,3 +180,81 @@ dummy_load_1ms_pd_init, which had the following code (on purpose)::
 		return 0;
 
 	}
+
+User-space interface
+---------------------------
+
+Timerlat allows user-space threads to use timerlat infra-structure to
+measure scheduling latency. This interface is accessible via a per-CPU
+file descriptor inside $tracing_dir/osnoise/per_cpu/cpu$ID/timerlat_fd.
+
+This interface is accessible under the following conditions:
+
+ - timerlat tracer is enable
+ - osnoise workload option is set to NO_OSNOISE_WORKLOAD
+ - The user-space thread is affined to a single processor
+ - The thread opens the file associated with its single processor
+ - Only one thread can access the file at a time
+
+The open() syscall will fail if any of these conditions are not met.
+After opening the file descriptor, the user space can read from it.
+
+The read() system call will run a timerlat code that will arm the
+timer in the future and wait for it as the regular kernel thread does.
+
+When the timer IRQ fires, the timerlat IRQ will execute, report the
+IRQ latency and wake up the thread waiting in the read. The thread will be
+scheduled and report the thread latency via tracer - as for the kernel
+thread.
+
+The difference from the in-kernel timerlat is that, instead of re-arming
+the timer, timerlat will return to the read() system call. At this point,
+the user can run any code.
+
+If the application rereads the file timerlat file descriptor, the tracer
+will report the return from user-space latency, which is the total
+latency. If this is the end of the work, it can be interpreted as the
+response time for the request.
+
+After reporting the total latency, timerlat will restart the cycle, arm
+a timer, and go to sleep for the following activation.
+
+If at any time one of the conditions is broken, e.g., the thread migrates
+while in user space, or the timerlat tracer is disabled, the SIG_KILL
+signal will be sent to the user-space thread.
+
+Here is an basic example of user-space code for timerlat::
+
+ int main(void)
+ {
+	char buffer[1024];
+	int timerlat_fd;
+	int retval;
+	long cpu = 0;   /* place in CPU 0 */
+	cpu_set_t set;
+
+	CPU_ZERO(&set);
+	CPU_SET(cpu, &set);
+
+	if (sched_setaffinity(gettid(), sizeof(set), &set) == -1)
+		return 1;
+
+	snprintf(buffer, sizeof(buffer),
+		"/sys/kernel/tracing/osnoise/per_cpu/cpu%ld/timerlat_fd",
+		cpu);
+
+	timerlat_fd = open(buffer, O_RDONLY);
+	if (timerlat_fd < 0) {
+		printf("error opening %s: %s\n", buffer, strerror(errno));
+		exit(1);
+	}
+
+	for (;;) {
+		retval = read(timerlat_fd, buffer, 1024);
+		if (retval < 0)
+			break;
+	}
+
+	close(timerlat_fd);
+	exit(0);
+ }
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 220172cb874d..ec7576763704 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -181,6 +181,7 @@ struct osn_irq {
 
 #define IRQ_CONTEXT	0
 #define THREAD_CONTEXT	1
+#define THREAD_URET	2
 /*
  * sofirq runtime info.
  */
@@ -238,6 +239,7 @@ struct timerlat_variables {
 	u64			abs_period;
 	bool			tracing_thread;
 	u64			count;
+	bool			uthread_migrate;
 };
 
 static DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
@@ -1181,6 +1183,7 @@ thread_exit(struct osnoise_variables *osn_var, struct task_struct *t)
 	osn_var->thread.arrival_time = 0;
 }
 
+static void check_timerlat_user_migration(pid_t pid, long dest_cpu);
 /*
  * trace_sched_switch - sched:sched_switch trace event handler
  *
@@ -1196,6 +1199,9 @@ trace_sched_switch_callback(void *data, bool preempt,
 	struct osnoise_variables *osn_var = this_cpu_osn_var();
 	int workload = test_bit(OSN_WORKLOAD, &osnoise_options);
 
+	if (unlikely(workload && timerlat_enabled()))
+		check_timerlat_user_migration(n->pid, smp_processor_id());
+
 	if ((p->pid != osn_var->pid) || !workload)
 		thread_exit(osn_var, p);
 
@@ -1864,10 +1870,24 @@ static void stop_kthread(unsigned int cpu)
 
 	kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
 	if (kthread) {
-		kthread_stop(kthread);
+		if (test_bit(OSN_WORKLOAD, &osnoise_options)) {
+			kthread_stop(kthread);
+		} else {
+			/*
+			 * This is a user thread waiting on the timerlat_fd. We need
+			 * to close all users, and the best way to guarantee this is
+			 * by killing the thread. NOTE: this is a purpose specific file.
+			 */
+			kill_pid(kthread->thread_pid, SIGKILL, 1);
+			put_task_struct(kthread);
+		}
 		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
 	} else {
+		/* if no workload, just return */
 		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
+			/*
+			 * This is set in the osnoise tracer case.
+			 */
 			per_cpu(per_cpu_osnoise_var, cpu).sampling = false;
 			barrier();
 			return;
@@ -1912,7 +1932,6 @@ static int start_kthread(unsigned int cpu)
 			barrier();
 			return 0;
 		}
-
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
 
@@ -1941,6 +1960,11 @@ static int start_per_cpu_kthreads(void)
 	int retval = 0;
 	int cpu;
 
+	if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
+		if (timerlat_enabled())
+			return 0;
+	}
+
 	cpus_read_lock();
 	/*
 	 * Run only on online CPUs in which osnoise is allowed to run.
@@ -2281,6 +2305,238 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	return err;
 }
 
+static int timerlat_fd_open(struct inode *inode, struct file *file)
+{
+	struct osnoise_variables *osn_var;
+	struct timerlat_variables *tlat;
+	long cpu = (long) inode->i_cdev;
+
+	mutex_lock(&interface_lock);
+
+	/*
+	 * This file is accessible only if timerlat is enabled, and
+	 * NO_OSNOISE_WORKLOAD is set.
+	 */
+	if (!timerlat_enabled() || test_bit(OSN_WORKLOAD, &osnoise_options)) {
+		mutex_unlock(&interface_lock);
+		return -EINVAL;
+	}
+
+	migrate_disable();
+
+	osn_var = this_cpu_osn_var();
+
+	/*
+	 * The osn_var->pid holds the single access to this file.
+	 */
+	if (osn_var->pid) {
+		mutex_unlock(&interface_lock);
+		migrate_enable();
+		return -EBUSY;
+	}
+
+	/*
+	 * timerlat tracer is a per-cpu tracer. Check if the user-space too
+	 * is pinned to a single CPU. The tracer laters monitor if the task
+	 * migrates and then disables tracer if it does. However, it is
+	 * worth doing this basic acceptance test to avoid obviusly wrong
+	 * setup.
+	 */
+	if (current->nr_cpus_allowed > 1 ||  cpu != smp_processor_id()) {
+		mutex_unlock(&interface_lock);
+		migrate_enable();
+		return -EPERM;
+	}
+
+	/*
+	 * From now on, it is good to go.
+	 */
+	file->private_data = inode->i_cdev;
+
+	get_task_struct(current);
+
+	osn_var->kthread = current;
+	osn_var->pid = current->pid;
+
+	/*
+	 * Setup is done.
+	 */
+	mutex_unlock(&interface_lock);
+
+	tlat = this_cpu_tmr_var();
+	tlat->count = 0;
+
+	migrate_enable();
+	return 0;
+};
+
+/*
+ * timerlat_fd_read - Read function for "timerlat_fd" file
+ * @file: The active open file structure
+ * @ubuf: The userspace provided buffer to read value into
+ * @cnt: The maximum number of bytes to read
+ * @ppos: The current "file" position
+ *
+ * Prints 1 on timerlat, the number of interferences on osnoise, -1 on error.
+ */
+static ssize_t
+timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
+		  loff_t *ppos)
+{
+	long cpu = (long) file->private_data;
+	struct osnoise_variables *osn_var;
+	struct timerlat_variables *tlat;
+	struct timerlat_sample s;
+	s64 diff;
+	u64 now;
+
+	migrate_disable();
+
+	tlat = this_cpu_tmr_var();
+
+	/*
+	 * While in user-space, the thread is migratable. There is nothing
+	 * we can do about it.
+	 * So, if the thread is running on another CPU, stop the machinery.
+	 */
+	if (cpu == smp_processor_id()) {
+		if (tlat->uthread_migrate) {
+			migrate_enable();
+			return -EINVAL;
+		}
+	} else {
+		per_cpu_ptr(&per_cpu_timerlat_var, cpu)->uthread_migrate = 1;
+		osnoise_taint("timerlat user thread migrate\n");
+		osnoise_stop_tracing();
+		migrate_enable();
+		return -EINVAL;
+	}
+
+	osn_var = this_cpu_osn_var();
+
+	/*
+	 * The timerlat in user-space runs in a different order:
+	 * the read() starts from the execution of the previous occurrence,
+	 * sleeping for the next occurrence.
+	 *
+	 * So, skip if we are entering on read() before the first wakeup
+	 * from timerlat IRQ:
+	 */
+	if (likely(osn_var->sampling)) {
+		now = ktime_to_ns(hrtimer_cb_get_time(&tlat->timer));
+		diff = now - tlat->abs_period;
+
+		/*
+		 * it was not a timer firing, but some other signal?
+		 */
+		if (diff < 0)
+			goto out;
+
+		s.seqnum = tlat->count;
+		s.timer_latency = diff;
+		s.context = THREAD_URET;
+
+		trace_timerlat_sample(&s);
+
+		notify_new_max_latency(diff);
+
+		tlat->tracing_thread = false;
+		if (osnoise_data.stop_tracing_total)
+			if (time_to_us(diff) >= osnoise_data.stop_tracing_total)
+				osnoise_stop_tracing();
+	} else {
+		tlat->tracing_thread = false;
+		tlat->kthread = current;
+
+		hrtimer_init(&tlat->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
+		tlat->timer.function = timerlat_irq;
+
+		/* Annotate now to drift new period */
+		tlat->abs_period = hrtimer_cb_get_time(&tlat->timer);
+
+		osn_var->sampling = 1;
+	}
+
+	/* wait for the next period */
+	wait_next_period(tlat);
+
+	/* This is the wakeup from this cycle */
+	now = ktime_to_ns(hrtimer_cb_get_time(&tlat->timer));
+	diff = now - tlat->abs_period;
+
+	/*
+	 * it was not a timer firing, but some other signal?
+	 */
+	if (diff < 0)
+		goto out;
+
+	s.seqnum = tlat->count;
+	s.timer_latency = diff;
+	s.context = THREAD_CONTEXT;
+
+	trace_timerlat_sample(&s);
+
+	if (osnoise_data.stop_tracing_total) {
+		if (time_to_us(diff) >= osnoise_data.stop_tracing_total) {
+			timerlat_dump_stack(time_to_us(diff));
+			notify_new_max_latency(diff);
+			osnoise_stop_tracing();
+		}
+	}
+
+out:
+	migrate_enable();
+	return 0;
+}
+
+static int timerlat_fd_release(struct inode *inode, struct file *file)
+{
+	struct osnoise_variables *osn_var;
+	struct timerlat_variables *tlat_var;
+	long cpu = (long) file->private_data;
+
+	migrate_disable();
+	mutex_lock(&interface_lock);
+
+	osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
+	tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
+
+	hrtimer_cancel(&tlat_var->timer);
+	memset(tlat_var, 0, sizeof(*tlat_var));
+
+	osn_var->sampling = 0;
+	osn_var->pid = 0;
+
+	/*
+	 * We are leaving, not being stopped... see stop_kthread();
+	 */
+	if (osn_var->kthread) {
+		put_task_struct(osn_var->kthread);
+		osn_var->kthread = NULL;
+	}
+
+	mutex_unlock(&interface_lock);
+	migrate_enable();
+	return 0;
+}
+
+static void check_timerlat_user_migration(pid_t pid, long dest_cpu)
+{
+	struct osnoise_variables *osn_var;
+	long cpu;
+
+	for_each_possible_cpu(cpu) {
+		osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
+		if (osn_var->pid == pid && dest_cpu != cpu) {
+			per_cpu_ptr(&per_cpu_timerlat_var, cpu)->uthread_migrate = 1;
+			osnoise_taint("timerlat user thread migrate\n");
+			osnoise_stop_tracing();
+			break;
+		}
+	}
+}
+
+
 /*
  * osnoise/runtime_us: cannot be greater than the period.
  */
@@ -2361,6 +2617,13 @@ static const struct file_operations osnoise_options_fops = {
 	.write		= osnoise_options_write
 };
 
+static const struct file_operations timerlat_fd_fops = {
+	.open		= timerlat_fd_open,
+	.read		= timerlat_fd_read,
+	.release	= timerlat_fd_release,
+	.llseek		= generic_file_llseek,
+};
+
 #ifdef CONFIG_TIMERLAT_TRACER
 #ifdef CONFIG_STACKTRACE
 static int init_timerlat_stack_tracefs(struct dentry *top_dir)
@@ -2381,18 +2644,63 @@ static int init_timerlat_stack_tracefs(struct dentry *top_dir)
 }
 #endif /* CONFIG_STACKTRACE */
 
+int osnoise_create_cpu_timerlat_fd(struct dentry *top_dir)
+{
+	struct dentry *timerlat_fd;
+	struct dentry *per_cpu;
+	struct dentry *cpu_dir;
+	char cpu_str[30]; /* see trace.c: tracing_init_tracefs_percpu() */
+	long cpu;
+
+	/*
+	 * Why not using tracing instance per_cpu/ dir?
+	 *
+	 * Because osnoise/timerlat have a single workload, having
+	 * multiple files like these are wast of memory.
+	 */
+	per_cpu = tracefs_create_dir("per_cpu", top_dir);
+	if (!per_cpu)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		snprintf(cpu_str, 30, "cpu%ld", cpu);
+		cpu_dir = tracefs_create_dir(cpu_str, per_cpu);
+		if (!cpu_dir)
+			goto out_clean;
+
+		timerlat_fd = trace_create_file("timerlat_fd", TRACE_MODE_READ,
+						cpu_dir, NULL, &timerlat_fd_fops);
+		if (!timerlat_fd)
+			goto out_clean;
+
+		/* Record the CPU */
+		d_inode(timerlat_fd)->i_cdev = (void *)(cpu);
+	}
+
+	return 0;
+
+out_clean:
+	tracefs_remove(per_cpu);
+	return -ENOMEM;
+}
+
 /*
  * init_timerlat_tracefs - A function to initialize the timerlat interface files
  */
 static int init_timerlat_tracefs(struct dentry *top_dir)
 {
 	struct dentry *tmp;
+	int retval;
 
 	tmp = tracefs_create_file("timerlat_period_us", TRACE_MODE_WRITE, top_dir,
 				  &timerlat_period, &trace_min_max_fops);
 	if (!tmp)
 		return -ENOMEM;
 
+	retval = osnoise_create_cpu_timerlat_fd(top_dir);
+	if (retval)
+		return retval;
+
 	return init_timerlat_stack_tracefs(top_dir);
 }
 #else /* CONFIG_TIMERLAT_TRACER */
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 15f05faaae44..9f10c0071c4f 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1446,6 +1446,8 @@ static struct trace_event trace_osnoise_event = {
 };
 
 /* TRACE_TIMERLAT */
+
+static char *timerlat_lat_context[] = {"irq", "thread", "user-ret"};
 static enum print_line_t
 trace_timerlat_print(struct trace_iterator *iter, int flags,
 		     struct trace_event *event)
@@ -1458,7 +1460,7 @@ trace_timerlat_print(struct trace_iterator *iter, int flags,
 
 	trace_seq_printf(s, "#%-5u context %6s timer_latency %9llu ns\n",
 			 field->seqnum,
-			 field->context ? "thread" : "irq",
+			 timerlat_lat_context[field->context],
 			 field->timer_latency);
 
 	return trace_handle_return(s);
-- 
2.38.1


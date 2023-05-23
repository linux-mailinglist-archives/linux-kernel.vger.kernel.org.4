Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF46770E398
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbjEWRpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbjEWRpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D2DCA;
        Tue, 23 May 2023 10:45:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E41263570;
        Tue, 23 May 2023 17:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F64C433EF;
        Tue, 23 May 2023 17:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684863904;
        bh=PgLrm69OSx2CtUEesmsey3p+cELKenwN/934Wzsg0n8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/8mcTmd5F5LIxlDYG26+KEEn33fgYBhVZakDfmWH+rxT6XHeZfWRMnWD78aRsRC2
         jpyy0OHk/5m4cuMfiB0HUpOitdHae+/8FiHlbA6M2BUmSTqgk3WXhP/wiyecbd1XA2
         ZfZ4Tlb48SfPG7VmOhfn5gh7xfAcFYe2DsIlhHNPcy/ttdDP0IIkn3NDXdKmy4lLCx
         E2KVxZVZ4TVQYaagoNvlfYW2fZGldkww2B2EE3nOetHG9skIW6KlQqmd3yC2yOB+H1
         C5+QbjA+yVNrhB6BJ30aAQnsUyrrCog6BZ3Iey2GrVIL2awGI9ef0UrkAAqNDmUj0j
         Z+QG8AJDOAOsA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-doc@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH V2 9/9] rtla: Add timerlat user-space support for timerlat top
Date:   Tue, 23 May 2023 19:44:31 +0200
Message-Id: <95600d5039dbf0d83bd200176e81b3484e3e2c53.1684863094.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1684863094.git.bristot@kernel.org>
References: <cover.1684863094.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support for running timerlat threads in user-space. In this
mode, enabled with -u/--user-threads, timerlat dispatches user-space
processes that will loop in the timerlat_fd, measuring the overhead
for going to user-space and then returning to the kernel - in addition
to the existing measurements.

Here is one example of the tool's output with -u enabled:

[root@f34 rtla]# timerlat top -c 1-7 -q -u -d 60
                                     Timer Latency
  0 00:01:01   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)      |    Ret user Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max |      cur       min       avg       max
  1 #60003     |        1         1         6        41 |       11         7        18       367 |       14        10        22       372
  2 #60002     |        1         1         5        17 |       11         6        16        42 |       14         9        19        51
  3 #60001     |        1         1         5        41 |        9         7        16        66 |       12         9        20        75
  4 #60001     |        7         1         7        18 |       18        10        18        37 |       22        12        22        45
  5 #60000     |        1         1         5        26 |       10         5        15        45 |       13         7        18        51
  6 #59999     |        1         0         5        13 |        9         4        15        33 |       11         6        19        40
  7 #59999     |        2         1         5        34 |        9         5        16        52 |       12         7        20        59

The tuning setup like -p or -C work for the user-space threads as well.

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 .../tools/rtla/rtla-timerlat-top.rst          |   7 +
 tools/tracing/rtla/src/osnoise.c              |  65 +++++
 tools/tracing/rtla/src/osnoise.h              |   5 +
 tools/tracing/rtla/src/timerlat_top.c         | 108 ++++++++-
 tools/tracing/rtla/src/timerlat_u.c           | 224 ++++++++++++++++++
 tools/tracing/rtla/src/timerlat_u.h           |  18 ++
 tools/tracing/rtla/src/utils.c                |  58 +++++
 tools/tracing/rtla/src/utils.h                |   2 +
 8 files changed, 481 insertions(+), 6 deletions(-)
 create mode 100644 tools/tracing/rtla/src/timerlat_u.c
 create mode 100644 tools/tracing/rtla/src/timerlat_u.h

diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index 1b7cf4e3eafe..49fc7ac17814 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -39,6 +39,13 @@ OPTIONS
         is useful to reduce rtla timerlat CPU, enabling the debug without the overhead of
         collecting the statistics.
 
+**--user-threads**
+
+        Set timerlat to run without a workload, and then dispatches user-space workloads
+        to wait on the timerlat_fd. Once the workload is awakes, it goes to sleep again
+        adding so the measurement for the kernel-to-user and user-to-kernel to the tracer
+        output.
+
 EXAMPLE
 =======
 
diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 3ca7a3853943..245e9344932b 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -841,6 +841,67 @@ static void osnoise_put_irq_disable(struct osnoise_context *context)
 	context->orig_opt_irq_disable = OSNOISE_OPTION_INIT_VAL;
 }
 
+static int osnoise_get_workload(struct osnoise_context *context)
+{
+	if (context->opt_workload != OSNOISE_OPTION_INIT_VAL)
+		return context->opt_workload;
+
+	if (context->orig_opt_workload != OSNOISE_OPTION_INIT_VAL)
+		return context->orig_opt_workload;
+
+	context->orig_opt_workload = osnoise_options_get_option("OSNOISE_WORKLOAD");
+
+	return context->orig_opt_workload;
+}
+
+int osnoise_set_workload(struct osnoise_context *context, bool onoff)
+{
+	int opt_workload = osnoise_get_workload(context);
+	int retval;
+
+	if (opt_workload == OSNOISE_OPTION_INIT_VAL)
+		return -1;
+
+	if (opt_workload == onoff)
+		return 0;
+
+	retval = osnoise_options_set_option("OSNOISE_WORKLOAD", onoff);
+	if (retval < 0)
+		return -1;
+
+	context->opt_workload = onoff;
+
+	return 0;
+}
+
+static void osnoise_restore_workload(struct osnoise_context *context)
+{
+	int retval;
+
+	if (context->orig_opt_workload == OSNOISE_OPTION_INIT_VAL)
+		return;
+
+	if (context->orig_opt_workload == context->opt_workload)
+		goto out_done;
+
+	retval = osnoise_options_set_option("OSNOISE_WORKLOAD", context->orig_opt_workload);
+	if (retval < 0)
+		err_msg("Could not restore original OSNOISE_WORKLOAD option\n");
+
+out_done:
+	context->orig_opt_workload = OSNOISE_OPTION_INIT_VAL;
+}
+
+static void osnoise_put_workload(struct osnoise_context *context)
+{
+	osnoise_restore_workload(context);
+
+	if (context->orig_opt_workload == OSNOISE_OPTION_INIT_VAL)
+		return;
+
+	context->orig_opt_workload = OSNOISE_OPTION_INIT_VAL;
+}
+
 /*
  * enable_osnoise - enable osnoise tracer in the trace_instance
  */
@@ -908,6 +969,9 @@ struct osnoise_context *osnoise_context_alloc(void)
 	context->orig_opt_irq_disable	= OSNOISE_OPTION_INIT_VAL;
 	context->opt_irq_disable	= OSNOISE_OPTION_INIT_VAL;
 
+	context->orig_opt_workload	= OSNOISE_OPTION_INIT_VAL;
+	context->opt_workload		= OSNOISE_OPTION_INIT_VAL;
+
 	osnoise_get_context(context);
 
 	return context;
@@ -935,6 +999,7 @@ void osnoise_put_context(struct osnoise_context *context)
 	osnoise_put_print_stack(context);
 	osnoise_put_tracing_thresh(context);
 	osnoise_put_irq_disable(context);
+	osnoise_put_workload(context);
 
 	free(context);
 }
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index 4dcf22ccd704..555f4f4903cc 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -42,6 +42,10 @@ struct osnoise_context {
 	/* -1 as init value because 0 is off */
 	int			orig_opt_irq_disable;
 	int			opt_irq_disable;
+
+	/* -1 as init value because 0 is off */
+	int			orig_opt_workload;
+	int			opt_workload;
 };
 
 /*
@@ -84,6 +88,7 @@ int osnoise_set_print_stack(struct osnoise_context *context,
 			    long long print_stack);
 
 int osnoise_set_irq_disable(struct osnoise_context *context, bool onoff);
+int osnoise_set_workload(struct osnoise_context *context, bool onoff);
 
 /*
  * osnoise_tool -  osnoise based tool definition.
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 02cff4948981..1640f121baca 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -13,11 +13,13 @@
 #include <time.h>
 #include <errno.h>
 #include <sched.h>
+#include <pthread.h>
 
 #include "utils.h"
 #include "osnoise.h"
 #include "timerlat.h"
 #include "timerlat_aa.h"
+#include "timerlat_u.h"
 
 struct timerlat_top_params {
 	char			*cpus;
@@ -40,6 +42,7 @@ struct timerlat_top_params {
 	int			dump_tasks;
 	int			cgroup;
 	int			hk_cpus;
+	int			user_top;
 	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
@@ -48,6 +51,7 @@ struct timerlat_top_params {
 struct timerlat_top_cpu {
 	int			irq_count;
 	int			thread_count;
+	int			user_count;
 
 	unsigned long long	cur_irq;
 	unsigned long long	min_irq;
@@ -58,6 +62,11 @@ struct timerlat_top_cpu {
 	unsigned long long	min_thread;
 	unsigned long long	sum_thread;
 	unsigned long long	max_thread;
+
+	unsigned long long	cur_user;
+	unsigned long long	min_user;
+	unsigned long long	sum_user;
+	unsigned long long	max_user;
 };
 
 struct timerlat_top_data {
@@ -98,6 +107,7 @@ static struct timerlat_top_data *timerlat_alloc_top(int nr_cpus)
 	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		data->cpu_data[cpu].min_irq = ~0;
 		data->cpu_data[cpu].min_thread = ~0;
+		data->cpu_data[cpu].min_user = ~0;
 	}
 
 	return data;
@@ -124,12 +134,18 @@ timerlat_top_update(struct osnoise_tool *tool, int cpu,
 		update_min(&cpu_data->min_irq, &latency);
 		update_sum(&cpu_data->sum_irq, &latency);
 		update_max(&cpu_data->max_irq, &latency);
-	} else {
+	} else if (thread == 1) {
 		cpu_data->thread_count++;
 		cpu_data->cur_thread = latency;
 		update_min(&cpu_data->min_thread, &latency);
 		update_sum(&cpu_data->sum_thread, &latency);
 		update_max(&cpu_data->max_thread, &latency);
+	} else {
+		cpu_data->user_count++;
+		cpu_data->cur_user = latency;
+		update_min(&cpu_data->min_user, &latency);
+		update_sum(&cpu_data->sum_user, &latency);
+		update_max(&cpu_data->max_user, &latency);
 	}
 }
 
@@ -172,15 +188,25 @@ static void timerlat_top_header(struct osnoise_tool *top)
 
 	trace_seq_printf(s, "\033[2;37;40m");
 	trace_seq_printf(s, "                                     Timer Latency                                              ");
+	if (params->user_top)
+		trace_seq_printf(s, "                                         ");
 	trace_seq_printf(s, "\033[0;0;0m");
 	trace_seq_printf(s, "\n");
 
-	trace_seq_printf(s, "%-6s   |          IRQ Timer Latency (%s)        |         Thread Timer Latency (%s)\n", duration,
+	trace_seq_printf(s, "%-6s   |          IRQ Timer Latency (%s)        |         Thread Timer Latency (%s)", duration,
 			params->output_divisor == 1 ? "ns" : "us",
 			params->output_divisor == 1 ? "ns" : "us");
 
+	if (params->user_top) {
+		trace_seq_printf(s, "      |    Ret user Timer Latency (%s)",
+				params->output_divisor == 1 ? "ns" : "us");
+	}
+
+	trace_seq_printf(s, "\n");
 	trace_seq_printf(s, "\033[2;30;47m");
 	trace_seq_printf(s, "CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max");
+	if (params->user_top)
+		trace_seq_printf(s, " |      cur       min       avg       max");
 	trace_seq_printf(s, "\033[0;0;0m");
 	trace_seq_printf(s, "\n");
 }
@@ -233,7 +259,27 @@ static void timerlat_top_print(struct osnoise_tool *top, int cpu)
 		trace_seq_printf(s, "%9llu ", cpu_data->min_thread / divisor);
 		trace_seq_printf(s, "%9llu ",
 				(cpu_data->sum_thread / cpu_data->thread_count) / divisor);
-		trace_seq_printf(s, "%9llu\n", cpu_data->max_thread / divisor);
+		trace_seq_printf(s, "%9llu", cpu_data->max_thread / divisor);
+	}
+
+	if (!params->user_top) {
+		trace_seq_printf(s, "\n");
+		return;
+	}
+
+	trace_seq_printf(s, " |");
+
+	if (!cpu_data->user_count) {
+		trace_seq_printf(s, "        - ");
+		trace_seq_printf(s, "        - ");
+		trace_seq_printf(s, "        - ");
+		trace_seq_printf(s, "        -\n");
+	} else {
+		trace_seq_printf(s, "%9llu ", cpu_data->cur_user / divisor);
+		trace_seq_printf(s, "%9llu ", cpu_data->min_user / divisor);
+		trace_seq_printf(s, "%9llu ",
+				(cpu_data->sum_user / cpu_data->user_count) / divisor);
+		trace_seq_printf(s, "%9llu\n", cpu_data->max_user / divisor);
 	}
 }
 
@@ -288,7 +334,7 @@ static void timerlat_top_usage(char *usage)
 		"",
 		"  usage: rtla timerlat [top] [-h] [-q] [-a us] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] \\",
 		"	  [[-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
-		"	  [-P priority] [--dma-latency us] [--aa-only us] [-C[=cgroup_name]]",
+		"	  [-P priority] [--dma-latency us] [--aa-only us] [-C[=cgroup_name]] [-u]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -317,6 +363,7 @@ static void timerlat_top_usage(char *usage)
 		"		f:prio - use SCHED_FIFO with prio",
 		"		d:runtime[us|ms|s]:period[us|ms|s] - use SCHED_DEADLINE with runtime and period",
 		"						       in nanoseconds",
+		"	  -u/--user-threads: use rtla user-space threads instead of in-kernel timerlat threads",
 		NULL,
 	};
 
@@ -371,6 +418,7 @@ static struct timerlat_top_params
 			{"stack",		required_argument,	0, 's'},
 			{"thread",		required_argument,	0, 'T'},
 			{"trace",		optional_argument,	0, 't'},
+			{"user-threads",	no_argument,		0, 'u'},
 			{"trigger",		required_argument,	0, '0'},
 			{"filter",		required_argument,	0, '1'},
 			{"dma-latency",		required_argument,	0, '2'},
@@ -383,7 +431,7 @@ static struct timerlat_top_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:np:P:qs:t::T:0:1:2:345:",
+		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:np:P:qs:t::T:u0:1:2:345:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -498,6 +546,9 @@ static struct timerlat_top_params
 			else
 				params->trace_output = "timerlat_trace.txt";
 
+			break;
+		case 'u':
+			params->user_top = true;
 			break;
 		case '0': /* trigger */
 			if (params->events) {
@@ -563,6 +614,7 @@ static int
 timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_top_params *params)
 {
 	int retval;
+	int i;
 
 	if (!params->sleep_time)
 		params->sleep_time = 1;
@@ -573,6 +625,9 @@ timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_top_params *
 			err_msg("Failed to apply CPUs config\n");
 			goto out_err;
 		}
+	} else {
+		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
+			CPU_SET(i, &params->monitored_cpus);
 	}
 
 	if (params->stop_us) {
@@ -627,6 +682,14 @@ timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_top_params *
 		auto_house_keeping(&params->monitored_cpus);
 	}
 
+	if (params->user_top) {
+		retval = osnoise_set_workload(top->context, 0);
+		if (retval) {
+			err_msg("Failed to set OSNOISE_WORKLOAD option\n");
+			goto out_err;
+		}
+	}
+
 	return 0;
 
 out_err:
@@ -687,10 +750,12 @@ int timerlat_top_main(int argc, char *argv[])
 {
 	struct timerlat_top_params *params;
 	struct osnoise_tool *record = NULL;
+	struct timerlat_u_params params_u;
 	struct osnoise_tool *top = NULL;
 	struct osnoise_tool *aa = NULL;
 	struct trace_instance *trace;
 	int dma_latency_fd = -1;
+	pthread_t timerlat_u;
 	int return_value = 1;
 	char *max_lat;
 	int retval;
@@ -727,7 +792,7 @@ int timerlat_top_main(int argc, char *argv[])
 		}
 	}
 
-	if (params->cgroup) {
+	if (params->cgroup && !params->user_top) {
 		retval = set_comm_cgroup("timerlat/", params->cgroup_name);
 		if (!retval) {
 			err_msg("Failed to move threads to cgroup\n");
@@ -800,6 +865,25 @@ int timerlat_top_main(int argc, char *argv[])
 	top->start_time = time(NULL);
 	timerlat_top_set_signals(params);
 
+	if (params->user_top) {
+		/* rtla asked to stop */
+		params_u.should_run = 1;
+		/* all threads left */
+		params_u.stopped_running = 0;
+
+		params_u.set = &params->monitored_cpus;
+		if (params->set_sched)
+			params_u.sched_param = &params->sched_param;
+		else
+			params_u.sched_param = NULL;
+
+		params_u.cgroup_name = params->cgroup_name;
+
+		retval = pthread_create(&timerlat_u, NULL, timerlat_u_dispatcher, &params_u);
+		if (retval)
+			err_msg("Error creating timerlat user-space threads\n");
+	}
+
 	while (!stop_tracing) {
 		sleep(params->sleep_time);
 
@@ -823,6 +907,18 @@ int timerlat_top_main(int argc, char *argv[])
 		if (trace_is_off(&top->trace, &record->trace))
 			break;
 
+		/* is there still any user-threads ? */
+		if (params->user_top) {
+			if (params_u.stopped_running) {
+				debug_msg("timerlat user space threads stopped!\n");
+				break;
+			}
+		}
+	}
+
+	if (params->user_top && !params_u.stopped_running) {
+		params_u.should_run = 0;
+		sleep(1);
 	}
 
 	timerlat_print_stats(params, top);
diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
new file mode 100644
index 000000000000..05e310696dd5
--- /dev/null
+++ b/tools/tracing/rtla/src/timerlat_u.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
+ */
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <tracefs.h>
+#include <pthread.h>
+#include <sys/wait.h>
+#include <sys/prctl.h>
+
+#include "utils.h"
+#include "timerlat_u.h"
+
+/*
+ * This is the user-space main for the tool timerlatu/ threads.
+ *
+ * It is as simple as this:
+ *  - set affinity
+ *  - set priority
+ *  - open tracer fd
+ *  - spin
+ *  - close
+ */
+static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
+{
+	struct sched_param sp = { .sched_priority = 95 };
+	char buffer[1024];
+	int timerlat_fd;
+	cpu_set_t set;
+	int retval;
+
+	/*
+	 * This all is only setting up the tool.
+	 */
+	CPU_ZERO(&set);
+	CPU_SET(cpu, &set);
+
+	retval = sched_setaffinity(gettid(), sizeof(set), &set);
+	if (retval == -1) {
+		err_msg("Error setting user thread affinity\n");
+		exit(1);
+	}
+
+	if (!params->sched_param) {
+		retval = sched_setscheduler(0, SCHED_FIFO, &sp);
+		if (retval < 0) {
+			err_msg("Error setting timerlat u default priority: %s\n", strerror(errno));
+			exit(1);
+		}
+	} else {
+		retval = __set_sched_attr(getpid(), params->sched_param);
+		if (retval) {
+			/* __set_sched_attr prints an error message, so */
+			exit(0);
+		}
+	}
+
+	if (params->cgroup_name) {
+		retval = set_pid_cgroup(gettid(), params->cgroup_name);
+		if (!retval) {
+			err_msg("Error setting timerlat u cgroup pid\n");
+			pthread_exit(&retval);
+		}
+	}
+
+	/*
+	 * This is the tool's loop. If you want to use as base for your own tool...
+	 * go ahead.
+	 */
+	snprintf(buffer, sizeof(buffer), "osnoise/per_cpu/cpu%d/timerlat_fd", cpu);
+
+	timerlat_fd = tracefs_instance_file_open(NULL, buffer, O_RDONLY);
+	if (timerlat_fd < 0) {
+		err_msg("Error opening %s:%s\n", buffer, strerror(errno));
+		exit(1);
+	}
+
+	debug_msg("User-space timerlat pid %d on cpu %d\n", gettid(), cpu);
+
+	/* add should continue with a signal handler */
+	while (true) {
+		retval = read(timerlat_fd, buffer, 1024);
+		if (retval < 0)
+			break;
+	}
+
+	close(timerlat_fd);
+
+	debug_msg("Leaving timerlat pid %d on cpu %d\n", gettid(), cpu);
+	exit(0);
+}
+
+/*
+ * timerlat_u_send_kill - send a kill signal for all processes
+ *
+ * Return the number of processes that received the kill.
+ */
+static int timerlat_u_send_kill(pid_t *procs, int nr_cpus)
+{
+	int killed = 0;
+	int i, retval;
+
+	for (i = 0; i < nr_cpus; i++) {
+		if (!procs[i])
+			continue;
+		retval = kill(procs[i], SIGKILL);
+		if (!retval)
+			killed++;
+		else
+			err_msg("Error killing child process %d\n", procs[i]);
+	}
+
+	return killed;
+}
+
+/**
+ * timerlat_u_dispatcher - dispatch one timerlatu/ process per monitored CPU
+ *
+ * This is a thread main that will fork one new process for each monitored
+ * CPU. It will wait for:
+ *
+ *  - rtla to tell to kill the child processes
+ *  - some child process to die, and the cleanup all the processes
+ *
+ * whichever comes first.
+ *
+ */
+void *timerlat_u_dispatcher(void *data)
+{
+	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+	struct timerlat_u_params *params = data;
+	char proc_name[128];
+	int procs_count = 0;
+	int retval = 1;
+	pid_t *procs;
+	int wstatus;
+	pid_t pid;
+	int i;
+
+	debug_msg("Dispatching timerlat u procs\n");
+
+	procs = calloc(nr_cpus, sizeof(pid_t));
+	if (!procs)
+		pthread_exit(&retval);
+
+	for (i = 0; i < nr_cpus; i++) {
+		if (params->set && !CPU_ISSET(i, params->set))
+			continue;
+
+		pid = fork();
+
+		/* child */
+		if (!pid) {
+
+			/*
+			 * rename the process
+			 */
+			snprintf(proc_name, sizeof(proc_name), "timerlatu/%d", i);
+			pthread_setname_np(pthread_self(), proc_name);
+			prctl(PR_SET_NAME, (unsigned long)proc_name, 0, 0, 0);
+
+			timerlat_u_main(i, params);
+			/* timerlat_u_main should exit()! Anyways... */
+			pthread_exit(&retval);
+		}
+
+		/* parent */
+		if (pid == -1) {
+			timerlat_u_send_kill(procs, nr_cpus);
+			debug_msg("Failed to create child processes");
+			pthread_exit(&retval);
+		}
+
+		procs_count++;
+		procs[i] = pid;
+	}
+
+	while (params->should_run) {
+		/* check if processes died */
+		pid = waitpid(-1, &wstatus, WNOHANG);
+		if (pid != 0) {
+			for (i = 0; i < nr_cpus; i++) {
+				if (procs[i] == pid) {
+					procs[i] = 0;
+					procs_count--;
+				}
+			}
+			break;
+		}
+
+		sleep(1);
+	}
+
+	timerlat_u_send_kill(procs, nr_cpus);
+
+	while (procs_count) {
+		pid = waitpid(-1, &wstatus, 0);
+		if (pid == -1) {
+			err_msg("Failed to monitor child processes");
+			pthread_exit(&retval);
+		}
+		for (i = 0; i < nr_cpus; i++) {
+			if (procs[i] == pid) {
+				procs[i] = 0;
+				procs_count--;
+			}
+		}
+	}
+
+	params->stopped_running = 1;
+
+	free(procs);
+	retval = 0;
+	pthread_exit(&retval);
+
+}
diff --git a/tools/tracing/rtla/src/timerlat_u.h b/tools/tracing/rtla/src/timerlat_u.h
new file mode 100644
index 000000000000..661511908957
--- /dev/null
+++ b/tools/tracing/rtla/src/timerlat_u.h
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
+ */
+
+struct timerlat_u_params {
+	/* timerlat -> timerlat_u: user-space threads can keep running */
+	int should_run;
+	/* timerlat_u -> timerlat: all timerlat_u threads left, no reason to continue */
+	int stopped_running;
+
+	/* threads config */
+	cpu_set_t *set;
+	char *cgroup_name;
+	struct sched_attr *sched_param;
+};
+
+void *timerlat_u_dispatcher(void *data);
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 3e25f0277fb9..623a38908ed5 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -626,6 +626,64 @@ static int get_self_cgroup(char *self_cg, int sizeof_self_cg)
 	return 1;
 }
 
+/*
+ * set_comm_cgroup - Set cgroup to pid_t pid
+ *
+ * If cgroup argument is not NULL, the threads will move to the given cgroup.
+ * Otherwise, the cgroup of the calling, i.e., rtla, thread will be used.
+ *
+ * Supports cgroup v2.
+ *
+ * Returns 1 on success, 0 otherwise.
+ */
+int set_pid_cgroup(pid_t pid, const char *cgroup)
+{
+	char cgroup_path[MAX_PATH - strlen("/cgroup.procs")];
+	char cgroup_procs[MAX_PATH];
+	char pid_str[24];
+	int retval;
+	int cg_fd;
+
+	retval = find_mount("cgroup2", cgroup_path, sizeof(cgroup_path));
+	if (!retval) {
+		err_msg("Did not find cgroupv2 mount point\n");
+		return 0;
+	}
+
+	if (!cgroup) {
+		retval = get_self_cgroup(&cgroup_path[strlen(cgroup_path)],
+				sizeof(cgroup_path) - strlen(cgroup_path));
+		if (!retval) {
+			err_msg("Did not find self cgroup\n");
+			return 0;
+		}
+	} else {
+		snprintf(&cgroup_path[strlen(cgroup_path)],
+				sizeof(cgroup_path) - strlen(cgroup_path), "%s/", cgroup);
+	}
+
+	snprintf(cgroup_procs, MAX_PATH, "%s/cgroup.procs", cgroup_path);
+
+	debug_msg("Using cgroup path at: %s\n", cgroup_procs);
+
+	cg_fd = open(cgroup_procs, O_RDWR);
+	if (cg_fd < 0)
+		return 0;
+
+	snprintf(pid_str, sizeof(pid_str), "%d\n", pid);
+
+	retval = write(cg_fd, pid_str, strlen(pid_str));
+	if (retval < 0)
+		err_msg("Error setting cgroup attributes for pid:%s - %s\n",
+				pid_str, strerror(errno));
+	else
+		debug_msg("Set cgroup attributes for pid:%s\n", pid_str);
+
+	close(cg_fd);
+
+	return (retval >= 0);
+}
+
 /**
  * set_comm_cgroup - Set cgroup to threads starting with char *comm_prefix
  *
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index dec59163cfbc..04ed1e650495 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -57,8 +57,10 @@ struct sched_attr {
 
 int parse_prio(char *arg, struct sched_attr *sched_param);
 int parse_cpu_set(char *cpu_list, cpu_set_t *set);
+int __set_sched_attr(int pid, struct sched_attr *attr);
 int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr);
 int set_comm_cgroup(const char *comm_prefix, const char *cgroup);
+int set_pid_cgroup(pid_t pid, const char *cgroup);
 int set_cpu_dma_latency(int32_t latency);
 int auto_house_keeping(cpu_set_t *monitored_cpus);
 
-- 
2.38.1


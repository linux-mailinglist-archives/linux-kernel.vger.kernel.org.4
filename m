Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0335C6831B2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjAaPjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjAaPjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:39:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB4D30B22;
        Tue, 31 Jan 2023 07:39:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CBF261548;
        Tue, 31 Jan 2023 15:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D37DC433D2;
        Tue, 31 Jan 2023 15:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675179546;
        bh=WaSqk1FLOBOMjqTKxHeUohRehMxZOHjpD6N9dSa0h50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pcvYFHT9Ts0cjdHgZ/seQ7nStjClCo3DLykoCdYDaaATGiEaKnJcKq+7kR16uHOzb
         ja8gTsDd7XCgD6IYjmdjpbWE2i/YaZud3ontxTWSbWrwXCEhbIptiypUZoJbFeJheg
         4PMtszs6LdTNJ8lxSI6pKbDhkf3YcahUy3kabIcH0SE85k6Mp+UOje0dgMznGNyB9j
         MeFVQ2QAyJPnKTniwjtjIUgtoIiocMTJeLNtoQc5RqTiqRB4VR2NnD/8iy5Q0lO96d
         dLijxNxPI1b5s+SjLnWS2o1G+ZJCDGjRW9ejOJBGi0lVmkAt166HgSmJtvXe0h77Hd
         hE6+ll3Qp6p9Q==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] rtla/timerlat: Add auto-analysis support to timerlat top
Date:   Tue, 31 Jan 2023 16:38:54 +0100
Message-Id: <3d45f40e630317f51ac6d678e2d96d310e495729.1675179318.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1675179318.git.bristot@kernel.org>
References: <cover.1675179318.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, timerlat top displays the timerlat tracer latency results, saving
the intuitive timerlat trace for the developer to analyze.

This patch goes a step forward in the automaton of the scheduling latency
analysis by providing a summary of the root cause of a latency higher than
the passed "stop tracing" parameter if the trace stops.

The output is intuitive enough for non-expert users to have a general idea
of the root cause by looking at each factor's contribution percentage while
keeping the technical detail in the output for more expert users to start
an in dept debug or to correlate a root cause with an existing one.

The terminology is in line with recent industry and academic publications
to facilitate the understanding of both audiences.

Here is one example of tool output:
 ----------------------------------------- %< -----------------------------------------------------
  # taskset -c 0 timerlat -a 40 -c 1-23 -q
                                     Timer Latency
    0 00:00:12   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
  CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
    1 #12322     |        0         0         1        15 |       10         3         9        31
    2 #12322     |        3         0         1        12 |       10         3         9        23
    3 #12322     |        1         0         1        21 |        8         2         8        34
    4 #12322     |        1         0         1        17 |       10         2        11        33
    5 #12322     |        0         0         1        12 |        8         3         8        25
    6 #12322     |        1         0         1        14 |       16         3        11        35
    7 #12322     |        0         0         1        14 |        9         2         8        29
    8 #12322     |        1         0         1        22 |        9         3         9        34
    9 #12322     |        0         0         1        14 |        8         2         8        24
   10 #12322     |        1         0         0        12 |        9         3         8        24
   11 #12322     |        0         0         0        15 |        6         2         7        29
   12 #12321     |        1         0         0        13 |        5         3         8        23
   13 #12319     |        0         0         1        14 |        9         3         9        26
   14 #12321     |        1         0         0        13 |        6         2         8        24
   15 #12321     |        1         0         1        15 |       12         3        11        27
   16 #12318     |        0         0         1        13 |        7         3        10        24
   17 #12319     |        0         0         1        13 |       11         3         9        25
   18 #12318     |        0         0         0        12 |        8         2         8        20
   19 #12319     |        0         0         1        18 |       10         2         9        28
   20 #12317     |        0         0         0        20 |        9         3         8        34
   21 #12318     |        0         0         0        13 |        8         3         8        28
   22 #12319     |        0         0         1        11 |        8         3        10        22
   23 #12320     |       28         0         1        28 |       41         3        11        41
  rtla timerlat hit stop tracing
  ## CPU 23 hit stop tracing, analyzing it ##
  IRQ handler delay:				      	    27.49 us (65.52 %)
  IRQ latency:						    28.13 us
  Timerlat IRQ duration:				     9.59 us (22.85 %)
  Blocking thread:					     3.79 us (9.03 %)
			objtool:49256    		     3.79 us
    Blocking thread stacktrace
		-> timerlat_irq
		-> __hrtimer_run_queues
		-> hrtimer_interrupt
		-> __sysvec_apic_timer_interrupt
		-> sysvec_apic_timer_interrupt
		-> asm_sysvec_apic_timer_interrupt
		-> _raw_spin_unlock_irqrestore
		-> cgroup_rstat_flush_locked
		-> cgroup_rstat_flush_irqsafe
		-> mem_cgroup_flush_stats
		-> mem_cgroup_wb_stats
		-> balance_dirty_pages
		-> balance_dirty_pages_ratelimited_flags
		-> btrfs_buffered_write
		-> btrfs_do_write_iter
		-> vfs_write
		-> __x64_sys_pwrite64
		-> do_syscall_64
		-> entry_SYSCALL_64_after_hwframe
  ------------------------------------------------------------------------
    Thread latency:					    41.96 us (100%)

  The system has exit from idle latency!
    Max timerlat IRQ latency from idle: 17.48 us in cpu 4
  Saving trace to timerlat_trace.txt
 ----------------------------------------- >% -----------------------------------------------------

In this case, the major factor was the delay suffered by the IRQ handler
that handles timerlat wakeup: 65.52 %. This can be caused by the
current thread masking interrupts, which can be seen in the blocking
thread stacktrace: the current thread (objtool:49256) disabled interrupts
via raw spin lock operations inside mem cgroup, while doing write
syscall in a btrfs file system.

A simple search for the function name on Google shows that this is
a legit case for disabling the interrupts:

  cgroup: Use irqsave in cgroup_rstat_flush_locked()
  lore.kernel.org/linux-mm/20220301122143.1521823-2-bigeasy@linutronix.de/

The output also prints other reasons for the latency root cause, such as:

  - an IRQ that happened before the IRQ handler that caused delays
  - The interference from NMI, IRQ, Softirq, and Threads

The details about how these factors affect the scheduling latency
can be found here:

   https://bristot.me/demystifying-the-real-time-linux-latency/

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/timerlat_top.c | 46 +++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 334271935222..eea5b3357e27 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -10,10 +10,12 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <time.h>
+#include <errno.h>
 
 #include "utils.h"
 #include "osnoise.h"
 #include "timerlat.h"
+#include "timerlat_aa.h"
 
 struct timerlat_top_params {
 	char			*cpus;
@@ -30,6 +32,8 @@ struct timerlat_top_params {
 	int			quiet;
 	int			set_sched;
 	int			dma_latency;
+	int			no_aa;
+	int			dump_tasks;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
 };
@@ -130,17 +134,22 @@ timerlat_top_handler(struct trace_seq *s, struct tep_record *record,
 		     struct tep_event *event, void *context)
 {
 	struct trace_instance *trace = context;
+	struct timerlat_top_params *params;
 	unsigned long long latency, thread;
 	struct osnoise_tool *top;
 	int cpu = record->cpu;
 
 	top = container_of(trace, struct osnoise_tool, trace);
+	params = top->params;
 
 	tep_get_field_val(s, event, "context", record, &thread, 1);
 	tep_get_field_val(s, event, "timer_latency", record, &latency, 1);
 
 	timerlat_top_update(top, cpu, thread, latency);
 
+	if (!params->no_aa)
+		timerlat_aa_handler(s, record, event, context);
+
 	return 0;
 }
 
@@ -281,11 +290,13 @@ static void timerlat_top_usage(char *usage)
 		"	  -c/--cpus cpus: run the tracer only on the given cpus",
 		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
 		"	  -D/--debug: print debug info",
+		"	     --dump-tasks: prints the task running on all CPUs if stop conditions are met (depends on !--no-aa)",
 		"	  -t/--trace[=file]: save the stopped trace to [file|timerlat_trace.txt]",
 		"	  -e/--event <sys:event>: enable the <sys:event> in the trace instance, multiple -e are allowed",
 		"	     --filter <command>: enable a trace event filter to the previous -e event",
 		"	     --trigger <command>: enable a trace event trigger to the previous -e event",
 		"	  -n/--nano: display data in nanoseconds",
+		"	     --no-aa: disable auto-analysis, reducing rtla timerlat cpu usage",
 		"	  -q/--quiet print only a summary at the end",
 		"	     --dma-latency us: set /dev/cpu_dma_latency latency <us> to reduce exit from idle latency",
 		"	  -P/--priority o:prio|r:prio|f:prio|d:runtime:period : set scheduling parameters",
@@ -349,13 +360,15 @@ static struct timerlat_top_params
 			{"trigger",		required_argument,	0, '0'},
 			{"filter",		required_argument,	0, '1'},
 			{"dma-latency",		required_argument,	0, '2'},
+			{"no-aa",		no_argument,		0, '3'},
+			{"dump-tasks",		no_argument,		0, '4'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:d:De:hi:np:P:qs:t::T:0:1:2:",
+		c = getopt_long(argc, argv, "a:c:d:De:hi:np:P:qs:t::T:0:1:2:34",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -368,13 +381,13 @@ static struct timerlat_top_params
 
 			/* set thread stop to auto_thresh */
 			params->stop_total_us = auto_thresh;
+			params->stop_us = auto_thresh;
 
 			/* get stack trace */
 			params->print_stack = auto_thresh;
 
 			/* set trace */
 			params->trace_output = "timerlat_trace.txt";
-
 			break;
 		case 'c':
 			retval = parse_cpu_list(optarg, &params->monitored_cpus);
@@ -437,6 +450,7 @@ static struct timerlat_top_params
 				params->trace_output = &optarg[1];
 			else
 				params->trace_output = "timerlat_trace.txt";
+
 			break;
 		case '0': /* trigger */
 			if (params->events) {
@@ -467,6 +481,12 @@ static struct timerlat_top_params
 				exit(EXIT_FAILURE);
 			}
 			break;
+		case '3': /* no-aa */
+			params->no_aa = 1;
+			break;
+		case '4':
+			params->dump_tasks = 1;
+			break;
 		default:
 			timerlat_top_usage("Invalid option");
 		}
@@ -477,6 +497,12 @@ static struct timerlat_top_params
 		exit(EXIT_FAILURE);
 	}
 
+	/*
+	 * Auto analysis only happens if stop tracing, thus:
+	 */
+	if (!params->stop_us && !params->stop_total_us)
+		params->no_aa = 1;
+
 	return params;
 }
 
@@ -547,6 +573,7 @@ static struct osnoise_tool
 {
 	struct osnoise_tool *top;
 	int nr_cpus;
+	int retval;
 
 	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
@@ -563,6 +590,16 @@ static struct osnoise_tool
 	tep_register_event_handler(top->trace.tep, -1, "ftrace", "timerlat",
 				   timerlat_top_handler, top);
 
+	/*
+	 * If no auto analysis, we are ready.
+	 */
+	if (params->no_aa)
+		return top;
+
+	retval = timerlat_aa_init(top, nr_cpus, params->dump_tasks);
+	if (retval)
+		goto out_err;
+
 	return top;
 
 out_err:
@@ -688,6 +725,10 @@ int timerlat_top_main(int argc, char *argv[])
 
 	if (trace_is_off(&top->trace, &record->trace)) {
 		printf("rtla timerlat hit stop tracing\n");
+
+		if (!params->no_aa)
+			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
+
 		if (params->trace_output) {
 			printf("  Saving trace to %s\n", params->trace_output);
 			save_trace_to_file(record->trace.inst, params->trace_output);
@@ -701,6 +742,7 @@ int timerlat_top_main(int argc, char *argv[])
 	params->events = NULL;
 out_free:
 	timerlat_free_top(top->data);
+	timerlat_aa_destroy();
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(top);
 	free(params);
-- 
2.38.1


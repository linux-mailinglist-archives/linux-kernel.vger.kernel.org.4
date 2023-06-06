Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC1E7248AE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbjFFQNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238434AbjFFQNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:13:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83FD19A6;
        Tue,  6 Jun 2023 09:13:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF98462F4C;
        Tue,  6 Jun 2023 16:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B57CC433EF;
        Tue,  6 Jun 2023 16:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686067981;
        bh=vmyL9MyUu2hxplL8j6cHadIp1XaH4bM3tg8Zfm4bAdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eeMHycdW6LhGqBao2IbokXLHuYuPGYFiMSLoG8g33V3cxeGHTPbv5gA5HMGVxJ9IU
         Gjvz7F+22V33YFYGw9TYSKlSllpDMGk8ETQO3QhptkBbzjZ9P2Xf7GgNymZ8UAnaxp
         dmqrdURrkXayeULN93tEOBQizC3ckn72uty/xVd/WxB70D9llaDVszzlioU7iodz8v
         E6ecg3yIoAdFemEvMIW87+AeIXTbMe/wlwrd/3bqFCboP4thdBD0tF6HhHvXj58koA
         /X+5uLUPVYHRLKuo45eZzzyFQ6C0XoyH4lbb71hpmx9z+q3s90/lSUJ4Jqa8ZXZD4G
         DuB3W/EFmWk7w==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-doc@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH V3 10/11] rtla/timerlat_hist: Add timerlat user-space support
Date:   Tue,  6 Jun 2023 18:12:24 +0200
Message-Id: <b6a042d55003c4a67ff7dce28d96044b7044f00d.1686066600.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686066600.git.bristot@kernel.org>
References: <cover.1686066600.git.bristot@kernel.org>
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

  $ sudo timerlat  hist -u -c 1-3 -d 600
  # RTLA timerlat histogram
  # Time unit is microseconds (us)
  # Duration:   0 00:10:01
  Index   IRQ-001   Thr-001   Usr-001   IRQ-002   Thr-002   Usr-002   IRQ-003   Thr-003   Usr-003
  0        477555         0         0    425287         0         0    474357         0         0
  1        122385      7998         0    174616      1921         0    125412      3138         0
  2            47    587376    492150        89    594717    447830       147    593463    454872
  3            11      2549    101930         7      2682    145580        64      2530    138680
  4             3      1954      2833         1       463      4917        11       548      4656
  5             0        60      1037         0       138      1117         6       179      1130
  6             0        26      1837         0        38       277         1        76       339
  7             0        15       143         0        28       147         2        37       156
  8             0        10        23         0        11        75         0        12        80
  9             0         7        17         0         0        26         0        11        42
  10            0         2        11         0         0        18         0         2        20
  11            0         0         7         0         1         8         0         2        12
  12            0         0         6         0         1         4         0         2         8
  13            0         1         3         0         0         0         0         0         1
  14            0         1         0         0         0         1         0         0         2
  15            0         1         0         0         0         0         0         0         2
  16            0         1         2         0         0         0         0         0         0
  17            0         0         1         0         0         0         0         0         0
  19            0         0         1         0         0         0         0         0         0
  over:         0         0         0         0         0         0         0         0         0
  count:   600001    600001    600001    600000    600000    600000    600000    600000    600000
  min:          0         1         2         0         1         2         0         1         2
  avg:          0         1         2         0         2         2         0         2         2
  max:          4        16        19         4        12        14         7        12        15

The tuning setup like -p or -C work for the user-space threads as well.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/timerlat_hist.c | 129 ++++++++++++++++++++++---
 1 file changed, 118 insertions(+), 11 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index f431cf43246c..47d3d8b53cb2 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -12,11 +12,13 @@
 #include <stdio.h>
 #include <time.h>
 #include <sched.h>
+#include <pthread.h>
 
 #include "utils.h"
 #include "osnoise.h"
 #include "timerlat.h"
 #include "timerlat_aa.h"
+#include "timerlat_u.h"
 
 struct timerlat_hist_params {
 	char			*cpus;
@@ -37,6 +39,7 @@ struct timerlat_hist_params {
 	int			hk_cpus;
 	int			no_aa;
 	int			dump_tasks;
+	int			user_hist;
 	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
@@ -53,9 +56,11 @@ struct timerlat_hist_params {
 struct timerlat_hist_cpu {
 	int			*irq;
 	int			*thread;
+	int			*user;
 
 	int			irq_count;
 	int			thread_count;
+	int			user_count;
 
 	unsigned long long	min_irq;
 	unsigned long long	sum_irq;
@@ -64,6 +69,10 @@ struct timerlat_hist_cpu {
 	unsigned long long	min_thread;
 	unsigned long long	sum_thread;
 	unsigned long long	max_thread;
+
+	unsigned long long	min_user;
+	unsigned long long	sum_user;
+	unsigned long long	max_user;
 };
 
 struct timerlat_hist_data {
@@ -88,6 +97,10 @@ timerlat_free_histogram(struct timerlat_hist_data *data)
 
 		if (data->hist[cpu].thread)
 			free(data->hist[cpu].thread);
+
+		if (data->hist[cpu].user)
+			free(data->hist[cpu].user);
+
 	}
 
 	/* one set of histograms per CPU */
@@ -124,15 +137,21 @@ static struct timerlat_hist_data
 		data->hist[cpu].irq = calloc(1, sizeof(*data->hist->irq) * (entries + 1));
 		if (!data->hist[cpu].irq)
 			goto cleanup;
+
 		data->hist[cpu].thread = calloc(1, sizeof(*data->hist->thread) * (entries + 1));
 		if (!data->hist[cpu].thread)
 			goto cleanup;
+
+		data->hist[cpu].user = calloc(1, sizeof(*data->hist->user) * (entries + 1));
+		if (!data->hist[cpu].user)
+			goto cleanup;
 	}
 
 	/* set the min to max */
 	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		data->hist[cpu].min_irq = ~0;
 		data->hist[cpu].min_thread = ~0;
+		data->hist[cpu].min_user = ~0;
 	}
 
 	return data;
@@ -147,7 +166,7 @@ static struct timerlat_hist_data
  */
 static void
 timerlat_hist_update(struct osnoise_tool *tool, int cpu,
-		     unsigned long long thread,
+		     unsigned long long context,
 		     unsigned long long latency)
 {
 	struct timerlat_hist_params *params = tool->params;
@@ -162,18 +181,24 @@ timerlat_hist_update(struct osnoise_tool *tool, int cpu,
 	if (data->bucket_size)
 		bucket = latency / data->bucket_size;
 
-	if (!thread) {
+	if (!context) {
 		hist = data->hist[cpu].irq;
 		data->hist[cpu].irq_count++;
 		update_min(&data->hist[cpu].min_irq, &latency);
 		update_sum(&data->hist[cpu].sum_irq, &latency);
 		update_max(&data->hist[cpu].max_irq, &latency);
-	} else {
+	} else if (context == 1) {
 		hist = data->hist[cpu].thread;
 		data->hist[cpu].thread_count++;
 		update_min(&data->hist[cpu].min_thread, &latency);
 		update_sum(&data->hist[cpu].sum_thread, &latency);
 		update_max(&data->hist[cpu].max_thread, &latency);
+	} else { /* user */
+		hist = data->hist[cpu].user;
+		data->hist[cpu].user_count++;
+		update_min(&data->hist[cpu].min_user, &latency);
+		update_sum(&data->hist[cpu].sum_user, &latency);
+		update_max(&data->hist[cpu].max_user, &latency);
 	}
 
 	if (bucket < entries)
@@ -190,16 +215,16 @@ timerlat_hist_handler(struct trace_seq *s, struct tep_record *record,
 		     struct tep_event *event, void *data)
 {
 	struct trace_instance *trace = data;
-	unsigned long long thread, latency;
+	unsigned long long context, latency;
 	struct osnoise_tool *tool;
 	int cpu = record->cpu;
 
 	tool = container_of(trace, struct osnoise_tool, trace);
 
-	tep_get_field_val(s, event, "context", record, &thread, 1);
+	tep_get_field_val(s, event, "context", record, &context, 1);
 	tep_get_field_val(s, event, "timer_latency", record, &latency, 1);
 
-	timerlat_hist_update(tool, cpu, thread, latency);
+	timerlat_hist_update(tool, cpu, context, latency);
 
 	return 0;
 }
@@ -241,6 +266,9 @@ static void timerlat_hist_header(struct osnoise_tool *tool)
 
 		if (!params->no_thread)
 			trace_seq_printf(s, "   Thr-%03d", cpu);
+
+		if (params->user_hist)
+			trace_seq_printf(s, "   Usr-%03d", cpu);
 	}
 	trace_seq_printf(s, "\n");
 
@@ -279,6 +307,10 @@ timerlat_print_summary(struct timerlat_hist_params *params,
 		if (!params->no_thread)
 			trace_seq_printf(trace->seq, "%9d ",
 					data->hist[cpu].thread_count);
+
+		if (params->user_hist)
+			trace_seq_printf(trace->seq, "%9d ",
+					 data->hist[cpu].user_count);
 	}
 	trace_seq_printf(trace->seq, "\n");
 
@@ -299,6 +331,10 @@ timerlat_print_summary(struct timerlat_hist_params *params,
 		if (!params->no_thread)
 			trace_seq_printf(trace->seq, "%9llu ",
 					data->hist[cpu].min_thread);
+
+		if (params->user_hist)
+			trace_seq_printf(trace->seq, "%9llu ",
+					data->hist[cpu].min_user);
 	}
 	trace_seq_printf(trace->seq, "\n");
 
@@ -323,7 +359,15 @@ timerlat_print_summary(struct timerlat_hist_params *params,
 		if (!params->no_thread) {
 			if (data->hist[cpu].thread_count)
 				trace_seq_printf(trace->seq, "%9llu ",
-						data->hist[cpu].sum_thread / data->hist[cpu].thread_count);
+						 data->hist[cpu].sum_thread / data->hist[cpu].thread_count);
+			else
+				trace_seq_printf(trace->seq, "        - ");
+		}
+
+		if (params->user_hist) {
+			if (data->hist[cpu].user_count)
+				trace_seq_printf(trace->seq, "%9llu ",
+						 data->hist[cpu].sum_user / data->hist[cpu].user_count);
 			else
 				trace_seq_printf(trace->seq, "        - ");
 		}
@@ -347,6 +391,10 @@ timerlat_print_summary(struct timerlat_hist_params *params,
 		if (!params->no_thread)
 			trace_seq_printf(trace->seq, "%9llu ",
 					data->hist[cpu].max_thread);
+
+		if (params->user_hist)
+			trace_seq_printf(trace->seq, "%9llu ",
+					data->hist[cpu].max_user);
 	}
 	trace_seq_printf(trace->seq, "\n");
 	trace_seq_do_printf(trace->seq);
@@ -392,6 +440,12 @@ timerlat_print_stats(struct timerlat_hist_params *params, struct osnoise_tool *t
 						data->hist[cpu].thread[bucket]);
 			}
 
+			if (params->user_hist) {
+				total += data->hist[cpu].user[bucket];
+				trace_seq_printf(trace->seq, "%9d ",
+						data->hist[cpu].user[bucket]);
+			}
+
 		}
 
 		if (total == 0 && !params->with_zeros) {
@@ -421,6 +475,10 @@ timerlat_print_stats(struct timerlat_hist_params *params, struct osnoise_tool *t
 		if (!params->no_thread)
 			trace_seq_printf(trace->seq, "%9d ",
 					 data->hist[cpu].thread[data->entries]);
+
+		if (params->user_hist)
+			trace_seq_printf(trace->seq, "%9d ",
+					 data->hist[cpu].user[data->entries]);
 	}
 	trace_seq_printf(trace->seq, "\n");
 	trace_seq_do_printf(trace->seq);
@@ -441,7 +499,7 @@ static void timerlat_hist_usage(char *usage)
 		"  usage: [rtla] timerlat hist [-h] [-q] [-d s] [-D] [-n] [-a us] [-p us] [-i us] [-T us] [-s us] \\",
 		"         [-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
 		"	  [-P priority] [-E N] [-b N] [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
-		"	  [--no-index] [--with-zeros] [--dma-latency us] [-C[=cgroup_name]] [--no-aa] [--dump-task]",
+		"	  [--no-index] [--with-zeros] [--dma-latency us] [-C[=cgroup_name]] [--no-aa] [--dump-task] [-u]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -476,6 +534,7 @@ static void timerlat_hist_usage(char *usage)
 		"		f:prio - use SCHED_FIFO with prio",
 		"		d:runtime[us|ms|s]:period[us|ms|s] - use SCHED_DEADLINE with runtime and period",
 		"						       in nanoseconds",
+		"	  -u/--user-threads: use rtla user-space threads instead of in-kernel timerlat threads",
 		NULL,
 	};
 
@@ -532,6 +591,7 @@ static struct timerlat_hist_params
 			{"stack",		required_argument,	0, 's'},
 			{"thread",		required_argument,	0, 'T'},
 			{"trace",		optional_argument,	0, 't'},
+			{"user-threads",	no_argument,		0, 'u'},
 			{"event",		required_argument,	0, 'e'},
 			{"no-irq",		no_argument,		0, '0'},
 			{"no-thread",		no_argument,		0, '1'},
@@ -550,7 +610,7 @@ static struct timerlat_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:np:P:s:t::T:0123456:7:8:9\1",
+		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:np:P:s:t::T:u0123456:7:8:9\1",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -660,6 +720,9 @@ static struct timerlat_hist_params
 			else
 				params->trace_output = "timerlat_trace.txt";
 			break;
+		case 'u':
+			params->user_hist = 1;
+			break;
 		case '0': /* no irq */
 			params->no_irq = 1;
 			break;
@@ -744,7 +807,7 @@ static struct timerlat_hist_params
 static int
 timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_hist_params *params)
 {
-	int retval;
+	int retval, i;
 
 	if (!params->sleep_time)
 		params->sleep_time = 1;
@@ -755,6 +818,9 @@ timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_hist_param
 			err_msg("Failed to apply CPUs config\n");
 			goto out_err;
 		}
+	} else {
+		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
+			CPU_SET(i, &params->monitored_cpus);
 	}
 
 	if (params->stop_us) {
@@ -807,6 +873,14 @@ timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_hist_param
 		auto_house_keeping(&params->monitored_cpus);
 	}
 
+	if (params->user_hist) {
+		retval = osnoise_set_workload(tool->context, 0);
+		if (retval) {
+			err_msg("Failed to set OSNOISE_WORKLOAD option\n");
+			goto out_err;
+		}
+	}
+
 	return 0;
 
 out_err:
@@ -867,11 +941,13 @@ int timerlat_hist_main(int argc, char *argv[])
 {
 	struct timerlat_hist_params *params;
 	struct osnoise_tool *record = NULL;
+	struct timerlat_u_params params_u;
 	struct osnoise_tool *tool = NULL;
 	struct osnoise_tool *aa = NULL;
 	struct trace_instance *trace;
 	int dma_latency_fd = -1;
 	int return_value = 1;
+	pthread_t timerlat_u;
 	int retval;
 
 	params = timerlat_hist_parse_args(argc, argv);
@@ -906,7 +982,7 @@ int timerlat_hist_main(int argc, char *argv[])
 		}
 	}
 
-	if (params->cgroup) {
+	if (params->cgroup && !params->user_hist) {
 		retval = set_comm_cgroup("timerlat/", params->cgroup_name);
 		if (!retval) {
 			err_msg("Failed to move threads to cgroup\n");
@@ -970,6 +1046,25 @@ int timerlat_hist_main(int argc, char *argv[])
 	tool->start_time = time(NULL);
 	timerlat_hist_set_signals(params);
 
+	if (params->user_hist) {
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
 
@@ -986,6 +1081,18 @@ int timerlat_hist_main(int argc, char *argv[])
 
 		if (trace_is_off(&tool->trace, &record->trace))
 			break;
+
+		/* is there still any user-threads ? */
+		if (params->user_hist) {
+			if (params_u.stopped_running) {
+				debug_msg("timerlat user-space threads stopped!\n");
+				break;
+			}
+		}
+	}
+	if (params->user_hist && !params_u.stopped_running) {
+		params_u.should_run = 0;
+		sleep(1);
 	}
 
 	timerlat_print_stats(params, tool);
-- 
2.38.1


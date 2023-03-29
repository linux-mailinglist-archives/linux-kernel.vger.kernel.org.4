Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D226CEF42
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjC2QXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjC2QXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:23:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480375BA8;
        Wed, 29 Mar 2023 09:23:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6A9261D78;
        Wed, 29 Mar 2023 16:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC267C4339B;
        Wed, 29 Mar 2023 16:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680107017;
        bh=PCrr5jt4AnAzXp5itb2Q6Tj3UBoSqk87mhIIlfHJbz4=;
        h=From:To:Cc:Subject:Date:From;
        b=NY4x7K3GRB/3y/ReAu7adjWDRPBzL/v3p19DzlqSR4Q+v98WQihzgPEMLo7vjEGiC
         hUFCVmRQX7T6YQMSARHT4XAoR/5o3YW/HaxtHxOgiEXFcHJhXctGRmsvIfXSSKjLOF
         LNVL1asyt2VbuwwsE0PBjeBh2utYNTZRuWsGtwHCNomt5OGZJY1jC3qFoKWQzxFnCr
         i6IhCHklLvkz2hvADlk1Ti3DjaX2t+GRTNJO7HLyrZTMYBZ9sw6F0J+FGbHVYNkDrE
         fS1DiFRF4cZDyO10/w3IECsbdBUDpIsAqLT0h8iP3z6acYN26Z3VWy1cHH/OBxwpjP
         G7CchCAYVp8VA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] rtla/timerlat: Add auto-analysis only option
Date:   Wed, 29 Mar 2023 18:23:32 +0200
Message-Id: <4dc514d1d5dc353c537a466a9b5af44c266b6da2.1680106912.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parsing and formating timerlat data might consume a reasonable
amount of CPU time on very large systems, or when timerlat
has a too short period.

Add an option to run timerlat with auto-analysis enabled while
skipping the statistics parsing. In this mode, rtla timerlat
periodically checks if the tracing is on, going to sleep waiting
for the stop tracing condition to stop tracing, or for the
tracing session to finish.

If the stop tracing condition is hit, the tool prints the auto
analysis. Otherwise, the tool prints the max observed latency and
exit. The max observed latency is captured via tracing_max_latency.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 .../tools/rtla/common_timerlat_aa.rst         |  7 +++
 tools/tracing/rtla/src/timerlat_top.c         | 49 +++++++++++++++++--
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/Documentation/tools/rtla/common_timerlat_aa.rst b/Documentation/tools/rtla/common_timerlat_aa.rst
index 077029e6b289..795b9fbcbc6d 100644
--- a/Documentation/tools/rtla/common_timerlat_aa.rst
+++ b/Documentation/tools/rtla/common_timerlat_aa.rst
@@ -5,3 +5,10 @@
 **--no-aa**
 
         disable auto-analysis, reducing rtla timerlat cpu usage
+
+**--aa-only** *us*
+
+        Set stop tracing conditions and run without collecting and displaying statistics.
+        Print the auto-analysis if the system hits the stop tracing condition. This option
+        is useful to reduce rtla timerlat CPU, enabling the debug without the overhead of
+        collecting the statistics.
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index eea5b3357e27..92c658c64f28 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -33,6 +33,7 @@ struct timerlat_top_params {
 	int			set_sched;
 	int			dma_latency;
 	int			no_aa;
+	int			aa_only;
 	int			dump_tasks;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
@@ -142,10 +143,12 @@ timerlat_top_handler(struct trace_seq *s, struct tep_record *record,
 	top = container_of(trace, struct osnoise_tool, trace);
 	params = top->params;
 
-	tep_get_field_val(s, event, "context", record, &thread, 1);
-	tep_get_field_val(s, event, "timer_latency", record, &latency, 1);
+	if (!params->aa_only) {
+		tep_get_field_val(s, event, "context", record, &thread, 1);
+		tep_get_field_val(s, event, "timer_latency", record, &latency, 1);
 
-	timerlat_top_update(top, cpu, thread, latency);
+		timerlat_top_update(top, cpu, thread, latency);
+	}
 
 	if (!params->no_aa)
 		timerlat_aa_handler(s, record, event, context);
@@ -250,6 +253,9 @@ timerlat_print_stats(struct timerlat_top_params *params, struct osnoise_tool *to
 	static int nr_cpus = -1;
 	int i;
 
+	if (params->aa_only)
+		return;
+
 	if (nr_cpus == -1)
 		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
@@ -279,10 +285,11 @@ static void timerlat_top_usage(char *usage)
 		"",
 		"  usage: rtla timerlat [top] [-h] [-q] [-a us] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] \\",
 		"	  [[-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] \\",
-		"	  [-P priority] [--dma-latency us]",
+		"	  [-P priority] [--dma-latency us] [--aa-only us]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
+		"	     --aa-only us: stop if <us> latency is hit, only printing the auto analysis (reduces CPU usage)",
 		"	  -p/--period us: timerlat period in us",
 		"	  -i/--irq us: stop trace if the irq latency is higher than the argument in us",
 		"	  -T/--thread us: stop trace if the thread latency is higher than the argument in us",
@@ -362,13 +369,14 @@ static struct timerlat_top_params
 			{"dma-latency",		required_argument,	0, '2'},
 			{"no-aa",		no_argument,		0, '3'},
 			{"dump-tasks",		no_argument,		0, '4'},
+			{"aa-only",		required_argument,	0, '5'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:d:De:hi:np:P:qs:t::T:0:1:2:34",
+		c = getopt_long(argc, argv, "a:c:d:De:hi:np:P:qs:t::T:0:1:2:345:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -389,6 +397,20 @@ static struct timerlat_top_params
 			/* set trace */
 			params->trace_output = "timerlat_trace.txt";
 			break;
+		case '5':
+			/* it is here because it is similar to -a */
+			auto_thresh = get_llong_from_str(optarg);
+
+			/* set thread stop to auto_thresh */
+			params->stop_total_us = auto_thresh;
+			params->stop_us = auto_thresh;
+
+			/* get stack trace */
+			params->print_stack = auto_thresh;
+
+			/* set aa_only to avoid parsing the trace */
+			params->aa_only = 1;
+			break;
 		case 'c':
 			retval = parse_cpu_list(optarg, &params->monitored_cpus);
 			if (retval)
@@ -503,6 +525,9 @@ static struct timerlat_top_params
 	if (!params->stop_us && !params->stop_total_us)
 		params->no_aa = 1;
 
+	if (params->no_aa && params->aa_only)
+		timerlat_top_usage("--no-aa and --aa-only are mutually exclusive!");
+
 	return params;
 }
 
@@ -634,6 +659,7 @@ int timerlat_top_main(int argc, char *argv[])
 	struct trace_instance *trace;
 	int dma_latency_fd = -1;
 	int return_value = 1;
+	char *max_lat;
 	int retval;
 
 	params = timerlat_top_parse_args(argc, argv);
@@ -700,6 +726,9 @@ int timerlat_top_main(int argc, char *argv[])
 	while (!stop_tracing) {
 		sleep(params->sleep_time);
 
+		if (params->aa_only && !trace_is_off(&top->trace, &record->trace))
+			continue;
+
 		retval = tracefs_iterate_raw_events(trace->tep,
 						    trace->inst,
 						    NULL,
@@ -733,6 +762,16 @@ int timerlat_top_main(int argc, char *argv[])
 			printf("  Saving trace to %s\n", params->trace_output);
 			save_trace_to_file(record->trace.inst, params->trace_output);
 		}
+	} else if (params->aa_only) {
+		/*
+		 * If the trace did not stop with --aa-only, at least print the
+		 * max known latency.
+		 */
+		max_lat = tracefs_instance_file_read(trace->inst, "tracing_max_latency", NULL);
+		if (max_lat) {
+			printf("  Max latency was %s\n", max_lat);
+			free(max_lat);
+		}
 	}
 
 out_top:
-- 
2.38.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD9770E345
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbjEWRo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbjEWRop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:44:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E3390;
        Tue, 23 May 2023 10:44:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5F8263564;
        Tue, 23 May 2023 17:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7301BC433A0;
        Tue, 23 May 2023 17:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684863882;
        bh=GqGwUJmK+00qm/XGLk0blCn7F+e5m9X1lkv94QKTFSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hzT2n7ld2psl7mnk3vBE4tevlt8B8amLr6+5UeKAKKPuEam0H3dzs0QDrvRaKT14/
         48BGAQmIXDSCuVlj4ZhdN+MnVWwUiDg+17vEN6xQxZYl7IzaHobAXhDsVSJBnPbx4j
         NMJP5QqP4fTJao1sIrLXaFXqpBYcsQOiZn043SOAnahsEq7TL0OmuI2JTddi5pYVrP
         BkrN6xfcdxmb0KyDDBGXrt36VU1LMcja2Ip+OW+VDckFjGQ4mEwxre7hFOwC5+aAdm
         1o3tSmVX2Fuzg3Hzmrznvo4yiE/L0C4VyzP9nG+61sOPn/5Si6tUUC7lNtXz7pFvMt
         SUEsiXVZb6wqQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-doc@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH V2 1/9] rtla: Add -C cgroup support
Date:   Tue, 23 May 2023 19:44:23 +0200
Message-Id: <2a7e6ae482df4d5e2213e9050e42f94abd775c51.1684863094.git.bristot@kernel.org>
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

The -C option sets a cgroup to the tracer's threads. If the -C option is
passed without arguments, the tracer's thread will inherit rtla's
cgroup. Otherwise, the threads will be placed on the cgroup passed
to the option.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 Documentation/tools/rtla/common_options.rst |   4 +
 tools/tracing/rtla/src/osnoise_hist.c       |  26 ++-
 tools/tracing/rtla/src/osnoise_top.c        |  26 ++-
 tools/tracing/rtla/src/timerlat_hist.c      |  27 ++-
 tools/tracing/rtla/src/timerlat_top.c       |  26 ++-
 tools/tracing/rtla/src/utils.c              | 185 ++++++++++++++++++++
 tools/tracing/rtla/src/utils.h              |   1 +
 7 files changed, 286 insertions(+), 9 deletions(-)

diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/tools/rtla/common_options.rst
index af76df6205d4..ede07359d93c 100644
--- a/Documentation/tools/rtla/common_options.rst
+++ b/Documentation/tools/rtla/common_options.rst
@@ -42,6 +42,10 @@
         - *f:prio* - use SCHED_FIFO with *prio*;
         - *d:runtime[us|ms|s]:period[us|ms|s]* - use SCHED_DEADLINE with *runtime* and *period* in nanoseconds.
 
+**-C**, **--cgroup**\[*=cgroup*]
+
+        Set a *cgroup* to the tracer's threads. If the **-C** option is passed without arguments, the tracer's thread will inherit **rtla**'s *cgroup*. Otherwise, the threads will be placed on the *cgroup* passed to the option.
+
 **-h**, **--help**
 
         Print help menu.
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 13e1233690bb..076f4c6af3dd 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -19,6 +19,7 @@ struct osnoise_hist_params {
 	char			*cpus;
 	char			*monitored_cpus;
 	char			*trace_output;
+	char			*cgroup_name;
 	unsigned long long	runtime;
 	unsigned long long	period;
 	long long		threshold;
@@ -28,6 +29,7 @@ struct osnoise_hist_params {
 	int			duration;
 	int			set_sched;
 	int			output_divisor;
+	int			cgroup;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
 
@@ -433,7 +435,7 @@ static void osnoise_hist_usage(char *usage)
 		"  usage: rtla osnoise hist [-h] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
 		"	  [-T us] [-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] \\",
 		"	  [-c cpu-list] [-P priority] [-b N] [-E N] [--no-header] [--no-summary] [--no-index] \\",
-		"	  [--with-zeros]",
+		"	  [--with-zeros] [-C[=cgroup_name]]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
@@ -443,6 +445,7 @@ static void osnoise_hist_usage(char *usage)
 		"	  -S/--stop-total us: stop trace if the total sample is higher than the argument in us",
 		"	  -T/--threshold us: the minimum delta to be considered a noise",
 		"	  -c/--cpus cpu-list: list of cpus to run osnoise threads",
+		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
 		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[=file]: save the stopped trace to [file|osnoise_trace.txt]",
@@ -501,6 +504,7 @@ static struct osnoise_hist_params
 			{"bucket-size",		required_argument,	0, 'b'},
 			{"entries",		required_argument,	0, 'E'},
 			{"cpus",		required_argument,	0, 'c'},
+			{"cgroup",		optional_argument,	0, 'C'},
 			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
 			{"help",		no_argument,		0, 'h'},
@@ -524,7 +528,7 @@ static struct osnoise_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:b:d:e:E:Dhp:P:r:s:S:t::T:01234:5:",
+		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:Dhp:P:r:s:S:t::T:01234:5:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -554,6 +558,16 @@ static struct osnoise_hist_params
 				osnoise_hist_usage("\nInvalid -c cpu list\n");
 			params->cpus = optarg;
 			break;
+		case 'C':
+			params->cgroup = 1;
+			if (!optarg) {
+				/* will inherit this cgroup */
+				params->cgroup_name = NULL;
+			} else if (*optarg == '=') {
+				/* skip the = */
+				params->cgroup_name = ++optarg;
+			}
+			break;
 		case 'D':
 			config_debug = 1;
 			break;
@@ -816,6 +830,14 @@ int osnoise_hist_main(int argc, char *argv[])
 		}
 	}
 
+	if (params->cgroup) {
+		retval = set_comm_cgroup("timerlat/", params->cgroup_name);
+		if (!retval) {
+			err_msg("Failed to move threads to cgroup\n");
+			goto out_free;
+		}
+	}
+
 	trace_instance_start(trace);
 
 	if (params->trace_output) {
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 562f2e4b18c5..139d8d392540 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -26,6 +26,7 @@ struct osnoise_top_params {
 	char			*cpus;
 	char			*monitored_cpus;
 	char			*trace_output;
+	char			*cgroup_name;
 	unsigned long long	runtime;
 	unsigned long long	period;
 	long long		threshold;
@@ -35,6 +36,7 @@ struct osnoise_top_params {
 	int			duration;
 	int			quiet;
 	int			set_sched;
+	int			cgroup;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
 	enum osnoise_mode	mode;
@@ -276,7 +278,7 @@ static void osnoise_top_usage(struct osnoise_top_params *params, char *usage)
 	static const char * const msg[] = {
 		" [-h] [-q] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
 		"	  [-T us] [-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] \\",
-		"	  [-c cpu-list] [-P priority]",
+		"	  [-c cpu-list] [-P priority] [-C[=cgroup_name]]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
@@ -286,6 +288,7 @@ static void osnoise_top_usage(struct osnoise_top_params *params, char *usage)
 		"	  -S/--stop-total us: stop trace if the total sample is higher than the argument in us",
 		"	  -T/--threshold us: the minimum delta to be considered a noise",
 		"	  -c/--cpus cpu-list: list of cpus to run osnoise threads",
+		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
 		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[=file]: save the stopped trace to [file|osnoise_trace.txt]",
@@ -347,6 +350,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
 			{"cpus",		required_argument,	0, 'c'},
+			{"cgroup",		optional_argument,	0, 'C'},
 			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
 			{"event",		required_argument,	0, 'e'},
@@ -367,7 +371,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:d:De:hp:P:qr:s:S:t::T:0:1:",
+		c = getopt_long(argc, argv, "a:c:C::d:De:hp:P:qr:s:S:t::T:0:1:",
 				 long_options, &option_index);
 
 		/* Detect the end of the options. */
@@ -392,6 +396,16 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 				osnoise_top_usage(params, "\nInvalid -c cpu list\n");
 			params->cpus = optarg;
 			break;
+		case 'C':
+			params->cgroup = 1;
+			if (!optarg) {
+				/* will inherit this cgroup */
+				params->cgroup_name = NULL;
+			} else if (*optarg == '=') {
+				/* skip the = */
+				params->cgroup_name = ++optarg;
+			}
+			break;
 		case 'D':
 			config_debug = 1;
 			break;
@@ -643,6 +657,14 @@ int osnoise_top_main(int argc, char **argv)
 		}
 	}
 
+	if (params->cgroup) {
+		retval = set_comm_cgroup("osnoise/", params->cgroup_name);
+		if (!retval) {
+			err_msg("Failed to move threads to cgroup\n");
+			goto out_free;
+		}
+	}
+
 	trace_instance_start(trace);
 
 	if (params->trace_output) {
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 4b48af8a8309..459c159923e8 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -19,6 +19,7 @@ struct timerlat_hist_params {
 	char			*cpus;
 	char			*monitored_cpus;
 	char			*trace_output;
+	char			*cgroup_name;
 	unsigned long long	runtime;
 	long long		stop_us;
 	long long		stop_total_us;
@@ -29,9 +30,9 @@ struct timerlat_hist_params {
 	int			duration;
 	int			set_sched;
 	int			dma_latency;
+	int			cgroup;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
-
 	char			no_irq;
 	char			no_thread;
 	char			no_header;
@@ -433,7 +434,7 @@ static void timerlat_hist_usage(char *usage)
 		"  usage: [rtla] timerlat hist [-h] [-q] [-d s] [-D] [-n] [-a us] [-p us] [-i us] [-T us] [-s us] \\",
 		"         [-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] \\",
 		"	  [-P priority] [-E N] [-b N] [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
-		"	  [--no-index] [--with-zeros] [--dma-latency us]",
+		"	  [--no-index] [--with-zeros] [--dma-latency us] [-C[=cgroup_name]]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -442,6 +443,7 @@ static void timerlat_hist_usage(char *usage)
 		"	  -T/--thread us: stop trace if the thread latency is higher than the argument in us",
 		"	  -s/--stack us: save the stack trace at the IRQ if a thread latency is higher than the argument in us",
 		"	  -c/--cpus cpus: run the tracer only on the given cpus",
+		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
 		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[=file]: save the stopped trace to [file|timerlat_trace.txt]",
@@ -506,6 +508,7 @@ static struct timerlat_hist_params
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
 			{"cpus",		required_argument,	0, 'c'},
+			{"cgroup",		optional_argument,	0, 'C'},
 			{"bucket-size",		required_argument,	0, 'b'},
 			{"debug",		no_argument,		0, 'D'},
 			{"entries",		required_argument,	0, 'E'},
@@ -534,7 +537,7 @@ static struct timerlat_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:b:d:e:E:Dhi:np:P:s:t::T:0123456:7:8:",
+		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:Dhi:np:P:s:t::T:0123456:7:8:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -561,6 +564,16 @@ static struct timerlat_hist_params
 				timerlat_hist_usage("\nInvalid -c cpu list\n");
 			params->cpus = optarg;
 			break;
+		case 'C':
+			params->cgroup = 1;
+			if (!optarg) {
+				/* will inherit this cgroup */
+				params->cgroup_name = NULL;
+			} else if (*optarg == '=') {
+				/* skip the = */
+				params->cgroup_name = ++optarg;
+			}
+			break;
 		case 'b':
 			params->bucket_size = get_llong_from_str(optarg);
 			if ((params->bucket_size == 0) || (params->bucket_size >= 1000000))
@@ -840,6 +853,14 @@ int timerlat_hist_main(int argc, char *argv[])
 		}
 	}
 
+	if (params->cgroup) {
+		retval = set_comm_cgroup("timerlat/", params->cgroup_name);
+		if (!retval) {
+			err_msg("Failed to move threads to cgroup\n");
+			goto out_free;
+		}
+	}
+
 	if (params->dma_latency >= 0) {
 		dma_latency_fd = set_cpu_dma_latency(params->dma_latency);
 		if (dma_latency_fd < 0) {
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 92c658c64f28..a19cbc2aa1f4 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -21,6 +21,7 @@ struct timerlat_top_params {
 	char			*cpus;
 	char			*monitored_cpus;
 	char			*trace_output;
+	char			*cgroup_name;
 	unsigned long long	runtime;
 	long long		stop_us;
 	long long		stop_total_us;
@@ -35,6 +36,7 @@ struct timerlat_top_params {
 	int			no_aa;
 	int			aa_only;
 	int			dump_tasks;
+	int			cgroup;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
 };
@@ -285,7 +287,7 @@ static void timerlat_top_usage(char *usage)
 		"",
 		"  usage: rtla timerlat [top] [-h] [-q] [-a us] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] \\",
 		"	  [[-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] \\",
-		"	  [-P priority] [--dma-latency us] [--aa-only us]",
+		"	  [-P priority] [--dma-latency us] [--aa-only us] [-C[=cgroup_name]]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -295,6 +297,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -T/--thread us: stop trace if the thread latency is higher than the argument in us",
 		"	  -s/--stack us: save the stack trace at the IRQ if a thread latency is higher than the argument in us",
 		"	  -c/--cpus cpus: run the tracer only on the given cpus",
+		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
 		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
 		"	  -D/--debug: print debug info",
 		"	     --dump-tasks: prints the task running on all CPUs if stop conditions are met (depends on !--no-aa)",
@@ -352,6 +355,7 @@ static struct timerlat_top_params
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
 			{"cpus",		required_argument,	0, 'c'},
+			{"cgroup",		optional_argument,	0, 'C'},
 			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
 			{"event",		required_argument,	0, 'e'},
@@ -376,7 +380,7 @@ static struct timerlat_top_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:d:De:hi:np:P:qs:t::T:0:1:2:345:",
+		c = getopt_long(argc, argv, "a:c:C::d:De:hi:np:P:qs:t::T:0:1:2:345:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -417,6 +421,16 @@ static struct timerlat_top_params
 				timerlat_top_usage("\nInvalid -c cpu list\n");
 			params->cpus = optarg;
 			break;
+		case 'C':
+			params->cgroup = 1;
+			if (!optarg) {
+				/* will inherit this cgroup */
+				params->cgroup_name = NULL;
+			} else if (*optarg == '=') {
+				/* skip the = */
+				params->cgroup_name = ++optarg;
+			}
+			break;
 		case 'D':
 			config_debug = 1;
 			break;
@@ -694,6 +708,14 @@ int timerlat_top_main(int argc, char *argv[])
 		}
 	}
 
+	if (params->cgroup) {
+		retval = set_comm_cgroup("timerlat/", params->cgroup_name);
+		if (!retval) {
+			err_msg("Failed to move threads to cgroup\n");
+			goto out_free;
+		}
+	}
+
 	if (params->dma_latency >= 0) {
 		dma_latency_fd = set_cpu_dma_latency(params->dma_latency);
 		if (dma_latency_fd < 0) {
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 663a047f794d..bcc0a9f39cfe 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -529,3 +529,188 @@ int set_cpu_dma_latency(int32_t latency)
 
 	return fd;
 }
+
+#define _STR(x) #x
+#define STR(x) _STR(x)
+
+/*
+ * find_mount - find a the mount point of a given fs
+ *
+ * Returns 0 if mount is not found, otherwise return 1 and fill mp
+ * with the mount point.
+ */
+static const int find_mount(const char *fs, char *mp, int sizeof_mp)
+{
+	char mount_point[MAX_PATH];
+	char type[100];
+	int found;
+	FILE *fp;
+
+	fp = fopen("/proc/mounts", "r");
+	if (!fp)
+		return 0;
+
+	while (fscanf(fp, "%*s %" STR(MAX_PATH) "s %99s %*s %*d %*d\n",	mount_point, type) == 2) {
+		if (strcmp(type, fs) == 0) {
+			found = 1;
+			break;
+		}
+	}
+	fclose(fp);
+
+	if (!found)
+		return 0;
+
+	memset(mp, 0, sizeof_mp);
+	strncpy(mp, mount_point, sizeof_mp - 1);
+
+	debug_msg("Fs %s found at %s\n", fs, mp);
+	return 1;
+}
+
+/*
+ * get_self_cgroup - get the current thread cgroup path
+ *
+ * Parse /proc/$$/cgroup file to get the thread's cgroup. As an example of line to parse:
+ *
+ * 0::/user.slice/user-0.slice/session-3.scope'\n'
+ *
+ * This function is interested in the content after the second : and before the '\n'.
+ *
+ * Returns 1 if a string was found, 0 otherwise.
+ */
+static int get_self_cgroup(char *self_cg, int sizeof_self_cg)
+{
+	char path[MAX_PATH], *start;
+	int fd, retval;
+
+	snprintf(path, MAX_PATH, "/proc/%d/cgroup", getpid());
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return 0;
+
+	retval = read(fd, path, MAX_PATH);
+
+	close(fd);
+
+	if (retval <= 0)
+		return 0;
+
+	start = path;
+
+	start = strstr(start, ":");
+	if (!start)
+		return 0;
+
+	/* skip ":" */
+	start++;
+
+	start = strstr(start, ":");
+	if (!start)
+		return 0;
+
+	/* skip ":" */
+	start++;
+
+	if (strlen(start) >= sizeof_self_cg)
+		return 0;
+
+	snprintf(self_cg, sizeof_self_cg, "%s", start);
+
+	/* Swap '\n' with '\0' */
+	start = strstr(self_cg, "\n");
+
+	/* there must be '\n' */
+	if (!start)
+		return 0;
+
+	/* ok, it found a string after the second : and before the \n */
+	*start = '\0';
+
+	return 1;
+}
+
+/**
+ * set_comm_cgroup - Set cgroup to threads starting with char *comm_prefix
+ *
+ * If cgroup argument is not NULL, the threads will move to the given cgroup.
+ * Otherwise, the cgroup of the calling, i.e., rtla, thread will be used.
+ *
+ * Supports cgroup v2.
+ *
+ * Returns 1 on success, 0 otherwise.
+ */
+int set_comm_cgroup(const char *comm_prefix, const char *cgroup)
+{
+	char cgroup_path[MAX_PATH - strlen("/cgroup.procs")];
+	char cgroup_procs[MAX_PATH];
+	struct dirent *proc_entry;
+	DIR *procfs;
+	int retval;
+	int cg_fd;
+
+	if (strlen(comm_prefix) >= MAX_PATH) {
+		err_msg("Command prefix is too long: %d < strlen(%s)\n",
+			MAX_PATH, comm_prefix);
+		return 0;
+	}
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
+	procfs = opendir("/proc");
+	if (!procfs) {
+		err_msg("Could not open procfs\n");
+		goto out_cg;
+	}
+
+	while ((proc_entry = readdir(procfs))) {
+
+		retval = procfs_is_workload_pid(comm_prefix, proc_entry);
+		if (!retval)
+			continue;
+
+		retval = write(cg_fd, proc_entry->d_name, strlen(proc_entry->d_name));
+		if (retval < 0) {
+			err_msg("Error setting cgroup attributes for pid:%s - %s\n",
+				proc_entry->d_name, strerror(errno));
+			goto out_procfs;
+		}
+
+		debug_msg("Set cgroup attributes for pid:%s\n", proc_entry->d_name);
+	}
+
+	closedir(procfs);
+	close(cg_fd);
+	return 1;
+
+out_procfs:
+	closedir(procfs);
+out_cg:
+	close(cg_fd);
+	return 0;
+}
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 90e4f52a030b..42b6f099d10a 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -55,6 +55,7 @@ struct sched_attr {
 
 int parse_prio(char *arg, struct sched_attr *sched_param);
 int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr);
+int set_comm_cgroup(const char *comm_prefix, const char *cgroup);
 int set_cpu_dma_latency(int32_t latency);
 
 #define ns_to_usf(x) (((double)x/1000))
-- 
2.38.1


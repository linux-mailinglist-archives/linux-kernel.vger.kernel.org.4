Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A2770E353
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbjEWRpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238288AbjEWRos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:44:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E258E;
        Tue, 23 May 2023 10:44:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BD4163567;
        Tue, 23 May 2023 17:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC29C433EF;
        Tue, 23 May 2023 17:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684863884;
        bh=0ubVhPhyNbTPpZGTTaXHkR9+c1t8+bxgv6RbmWcdImM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bs9o9EYNAYAZu3TemcNSHeeysnqu2gBHSBUsIXdnCOQINB55isIV1KP3UCyN+5L5X
         EnrF9Z5zGe/xNBZoIlXo15iOC9KeppOlTM+StEU/Huvdzr594kiL38o1PLZb1djNwY
         q6wt+kmE/Ik3JMGhGhzc/V+SfPCeKZcB4qF3glNJ50ZE8POZdiZJqSoT66wx8+6h7o
         WPZq3V8V24tEnHdKq+f7WwHtKScactiIrbc7GrUlgenBBzrpG8UVlufAA9W+KwDr33
         4Zfuii9WNFWX86+J5bH/cGhbvL9+MDL78UiI1rQp7Gixk0WfD5p6dVycT/8KVeepvZ
         DgDoQYj8l6pmQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-doc@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH V2 2/9] rtla: Add --house-keeping option
Date:   Tue, 23 May 2023 19:44:24 +0200
Message-Id: <1069965ccc14b69e8ce8b3b8d1641aa90a2a95ff.1684863094.git.bristot@kernel.org>
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

To avoid having rtla interfering with the measurement threads, add an
option for the user to set the CPUs in which rtla should run. For
instance:

  # rtla timerlat top -H 0 -C 1-7

Will place rtla in the CPU 0, while running the measurement threads in
the CPU 1-7.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Suggested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 Documentation/tools/rtla/common_options.rst |  4 ++
 tools/tracing/rtla/src/osnoise_hist.c       | 29 +++++++++--
 tools/tracing/rtla/src/osnoise_top.c        | 27 +++++++++-
 tools/tracing/rtla/src/timerlat_hist.c      | 27 +++++++++-
 tools/tracing/rtla/src/timerlat_top.c       | 27 +++++++++-
 tools/tracing/rtla/src/utils.c              | 58 +++++++++++++++++++++
 tools/tracing/rtla/src/utils.h              |  3 ++
 7 files changed, 166 insertions(+), 9 deletions(-)

diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/tools/rtla/common_options.rst
index ede07359d93c..aeb91ff3bd68 100644
--- a/Documentation/tools/rtla/common_options.rst
+++ b/Documentation/tools/rtla/common_options.rst
@@ -2,6 +2,10 @@
 
         Set the osnoise tracer to run the sample threads in the cpu-list.
 
+**-H**, **--house-keeping** *cpu-list*
+
+        Run rtla control threads only on the given cpu-list.
+
 **-d**, **--duration** *time[s|m|h|d]*
 
         Set the duration of the session.
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 076f4c6af3dd..d2b68177ffac 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2021 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
  */
 
+#define _GNU_SOURCE
 #include <getopt.h>
 #include <stdlib.h>
 #include <string.h>
@@ -11,6 +12,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <time.h>
+#include <sched.h>
 
 #include "utils.h"
 #include "osnoise.h"
@@ -30,6 +32,8 @@ struct osnoise_hist_params {
 	int			set_sched;
 	int			output_divisor;
 	int			cgroup;
+	int			hk_cpus;
+	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
 
@@ -434,8 +438,8 @@ static void osnoise_hist_usage(char *usage)
 		"",
 		"  usage: rtla osnoise hist [-h] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
 		"	  [-T us] [-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] \\",
-		"	  [-c cpu-list] [-P priority] [-b N] [-E N] [--no-header] [--no-summary] [--no-index] \\",
-		"	  [--with-zeros] [-C[=cgroup_name]]",
+		"	  [-c cpu-list] [-H cpu-list] [-P priority] [-b N] [-E N] [--no-header] [--no-summary] \\",
+		"	  [--no-index] [--with-zeros] [-C[=cgroup_name]]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
@@ -445,6 +449,7 @@ static void osnoise_hist_usage(char *usage)
 		"	  -S/--stop-total us: stop trace if the total sample is higher than the argument in us",
 		"	  -T/--threshold us: the minimum delta to be considered a noise",
 		"	  -c/--cpus cpu-list: list of cpus to run osnoise threads",
+		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
 		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
 		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
@@ -507,6 +512,7 @@ static struct osnoise_hist_params
 			{"cgroup",		optional_argument,	0, 'C'},
 			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
+			{"house-keeping",	required_argument,		0, 'H'},
 			{"help",		no_argument,		0, 'h'},
 			{"period",		required_argument,	0, 'p'},
 			{"priority",		required_argument,	0, 'P'},
@@ -528,7 +534,7 @@ static struct osnoise_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:Dhp:P:r:s:S:t::T:01234:5:",
+		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -597,6 +603,14 @@ static struct osnoise_hist_params
 		case '?':
 			osnoise_hist_usage(NULL);
 			break;
+		case 'H':
+			params->hk_cpus = 1;
+			retval = parse_cpu_set(optarg, &params->hk_cpu_set);
+			if (retval) {
+				err_msg("Error parsing house keeping CPUs\n");
+				exit(EXIT_FAILURE);
+			}
+			break;
 		case 'p':
 			params->period = get_llong_from_str(optarg);
 			if (params->period > 10000000)
@@ -732,6 +746,15 @@ osnoise_hist_apply_config(struct osnoise_tool *tool, struct osnoise_hist_params
 		}
 	}
 
+	if (params->hk_cpus) {
+		retval = sched_setaffinity(getpid(), sizeof(params->hk_cpu_set),
+					   &params->hk_cpu_set);
+		if (retval == -1) {
+			err_msg("Failed to set rtla to the house keeping CPUs\n");
+			goto out_err;
+		}
+	}
+
 	return 0;
 
 out_err:
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 139d8d392540..fcf6c14ce1bc 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2021 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
  */
 
+#define _GNU_SOURCE
 #include <getopt.h>
 #include <stdlib.h>
 #include <string.h>
@@ -10,6 +11,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <time.h>
+#include <sched.h>
 
 #include "osnoise.h"
 #include "utils.h"
@@ -37,6 +39,8 @@ struct osnoise_top_params {
 	int			quiet;
 	int			set_sched;
 	int			cgroup;
+	int			hk_cpus;
+	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
 	enum osnoise_mode	mode;
@@ -278,7 +282,7 @@ static void osnoise_top_usage(struct osnoise_top_params *params, char *usage)
 	static const char * const msg[] = {
 		" [-h] [-q] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
 		"	  [-T us] [-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] \\",
-		"	  [-c cpu-list] [-P priority] [-C[=cgroup_name]]",
+		"	  [-c cpu-list] [-H cpu-list] [-P priority] [-C[=cgroup_name]]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
@@ -288,6 +292,7 @@ static void osnoise_top_usage(struct osnoise_top_params *params, char *usage)
 		"	  -S/--stop-total us: stop trace if the total sample is higher than the argument in us",
 		"	  -T/--threshold us: the minimum delta to be considered a noise",
 		"	  -c/--cpus cpu-list: list of cpus to run osnoise threads",
+		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
 		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
 		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
@@ -354,6 +359,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
 			{"event",		required_argument,	0, 'e'},
+			{"house-keeping",	required_argument,	0, 'H'},
 			{"help",		no_argument,		0, 'h'},
 			{"period",		required_argument,	0, 'p'},
 			{"priority",		required_argument,	0, 'P'},
@@ -371,7 +377,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::d:De:hp:P:qr:s:S:t::T:0:1:",
+		c = getopt_long(argc, argv, "a:c:C::d:De:hH:p:P:qr:s:S:t::T:0:1:",
 				 long_options, &option_index);
 
 		/* Detect the end of the options. */
@@ -430,6 +436,14 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		case '?':
 			osnoise_top_usage(params, NULL);
 			break;
+		case 'H':
+			params->hk_cpus = 1;
+			retval = parse_cpu_set(optarg, &params->hk_cpu_set);
+			if (retval) {
+				err_msg("Error parsing house keeping CPUs\n");
+				exit(EXIT_FAILURE);
+			}
+			break;
 		case 'p':
 			params->period = get_llong_from_str(optarg);
 			if (params->period > 10000000)
@@ -561,6 +575,15 @@ osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_top_params *p
 		}
 	}
 
+	if (params->hk_cpus) {
+		retval = sched_setaffinity(getpid(), sizeof(params->hk_cpu_set),
+					   &params->hk_cpu_set);
+		if (retval == -1) {
+			err_msg("Failed to set rtla to the house keeping CPUs\n");
+			goto out_err;
+		}
+	}
+
 	return 0;
 
 out_err:
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 459c159923e8..d48c05d238f9 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2021 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
  */
 
+#define _GNU_SOURCE
 #include <getopt.h>
 #include <stdlib.h>
 #include <string.h>
@@ -10,6 +11,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <time.h>
+#include <sched.h>
 
 #include "utils.h"
 #include "osnoise.h"
@@ -31,6 +33,8 @@ struct timerlat_hist_params {
 	int			set_sched;
 	int			dma_latency;
 	int			cgroup;
+	int			hk_cpus;
+	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
 	char			no_irq;
@@ -432,7 +436,7 @@ static void timerlat_hist_usage(char *usage)
 	char *msg[] = {
 		"",
 		"  usage: [rtla] timerlat hist [-h] [-q] [-d s] [-D] [-n] [-a us] [-p us] [-i us] [-T us] [-s us] \\",
-		"         [-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] \\",
+		"         [-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
 		"	  [-P priority] [-E N] [-b N] [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
 		"	  [--no-index] [--with-zeros] [--dma-latency us] [-C[=cgroup_name]]",
 		"",
@@ -443,6 +447,7 @@ static void timerlat_hist_usage(char *usage)
 		"	  -T/--thread us: stop trace if the thread latency is higher than the argument in us",
 		"	  -s/--stack us: save the stack trace at the IRQ if a thread latency is higher than the argument in us",
 		"	  -c/--cpus cpus: run the tracer only on the given cpus",
+		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
 		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
 		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
 		"	  -D/--debug: print debug info",
@@ -513,6 +518,7 @@ static struct timerlat_hist_params
 			{"debug",		no_argument,		0, 'D'},
 			{"entries",		required_argument,	0, 'E'},
 			{"duration",		required_argument,	0, 'd'},
+			{"house-keeping",	required_argument,	0, 'H'},
 			{"help",		no_argument,		0, 'h'},
 			{"irq",			required_argument,	0, 'i'},
 			{"nano",		no_argument,		0, 'n'},
@@ -537,7 +543,7 @@ static struct timerlat_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:Dhi:np:P:s:t::T:0123456:7:8:",
+		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:np:P:s:t::T:0123456:7:8:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -608,6 +614,14 @@ static struct timerlat_hist_params
 		case '?':
 			timerlat_hist_usage(NULL);
 			break;
+		case 'H':
+			params->hk_cpus = 1;
+			retval = parse_cpu_set(optarg, &params->hk_cpu_set);
+			if (retval) {
+				err_msg("Error parsing house keeping CPUs\n");
+				exit(EXIT_FAILURE);
+			}
+			break;
 		case 'i':
 			params->stop_us = get_llong_from_str(optarg);
 			break;
@@ -755,6 +769,15 @@ timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_hist_param
 		}
 	}
 
+	if (params->hk_cpus) {
+		retval = sched_setaffinity(getpid(), sizeof(params->hk_cpu_set),
+					   &params->hk_cpu_set);
+		if (retval == -1) {
+			err_msg("Failed to set rtla to the house keeping CPUs\n");
+			goto out_err;
+		}
+	}
+
 	return 0;
 
 out_err:
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index a19cbc2aa1f4..5395d1c5921e 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2021 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
  */
 
+#define _GNU_SOURCE
 #include <getopt.h>
 #include <stdlib.h>
 #include <string.h>
@@ -11,6 +12,7 @@
 #include <stdio.h>
 #include <time.h>
 #include <errno.h>
+#include <sched.h>
 
 #include "utils.h"
 #include "osnoise.h"
@@ -37,6 +39,8 @@ struct timerlat_top_params {
 	int			aa_only;
 	int			dump_tasks;
 	int			cgroup;
+	int			hk_cpus;
+	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
 };
@@ -286,7 +290,7 @@ static void timerlat_top_usage(char *usage)
 	static const char *const msg[] = {
 		"",
 		"  usage: rtla timerlat [top] [-h] [-q] [-a us] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] \\",
-		"	  [[-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] \\",
+		"	  [[-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
 		"	  [-P priority] [--dma-latency us] [--aa-only us] [-C[=cgroup_name]]",
 		"",
 		"	  -h/--help: print this menu",
@@ -297,6 +301,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -T/--thread us: stop trace if the thread latency is higher than the argument in us",
 		"	  -s/--stack us: save the stack trace at the IRQ if a thread latency is higher than the argument in us",
 		"	  -c/--cpus cpus: run the tracer only on the given cpus",
+		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
 		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
 		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
 		"	  -D/--debug: print debug info",
@@ -360,6 +365,7 @@ static struct timerlat_top_params
 			{"duration",		required_argument,	0, 'd'},
 			{"event",		required_argument,	0, 'e'},
 			{"help",		no_argument,		0, 'h'},
+			{"house-keeping",	required_argument,	0, 'H'},
 			{"irq",			required_argument,	0, 'i'},
 			{"nano",		no_argument,		0, 'n'},
 			{"period",		required_argument,	0, 'p'},
@@ -380,7 +386,7 @@ static struct timerlat_top_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::d:De:hi:np:P:qs:t::T:0:1:2:345:",
+		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:np:P:qs:t::T:0:1:2:345:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -454,6 +460,14 @@ static struct timerlat_top_params
 		case '?':
 			timerlat_top_usage(NULL);
 			break;
+		case 'H':
+			params->hk_cpus = 1;
+			retval = parse_cpu_set(optarg, &params->hk_cpu_set);
+			if (retval) {
+				err_msg("Error parsing house keeping CPUs\n");
+				exit(EXIT_FAILURE);
+			}
+			break;
 		case 'i':
 			params->stop_us = get_llong_from_str(optarg);
 			break;
@@ -598,6 +612,15 @@ timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_top_params *
 		}
 	}
 
+	if (params->hk_cpus) {
+		retval = sched_setaffinity(getpid(), sizeof(params->hk_cpu_set),
+					   &params->hk_cpu_set);
+		if (retval == -1) {
+			err_msg("Failed to set rtla to the house keeping CPUs\n");
+			goto out_err;
+		}
+	}
+
 	return 0;
 
 out_err:
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index bcc0a9f39cfe..ee6fab09acae 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2021 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
  */
 
+#define _GNU_SOURCE
 #include <dirent.h>
 #include <stdarg.h>
 #include <stdlib.h>
@@ -150,6 +151,63 @@ int parse_cpu_list(char *cpu_list, char **monitored_cpus)
 	return 1;
 }
 
+/*
+ * parse_cpu_set - parse a cpu_list filling cpu_set_t argument
+ *
+ * Receives a cpu list, like 1-3,5 (cpus 1, 2, 3, 5), and then set
+ * filling cpu_set_t argument.
+ *
+ * Returns 1 on success, 0 otherwise.
+ */
+int parse_cpu_set(char *cpu_list, cpu_set_t *set)
+{
+	const char *p;
+	int end_cpu;
+	int nr_cpus;
+	int cpu;
+	int i;
+
+	CPU_ZERO(set);
+
+	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+	for (p = cpu_list; *p; ) {
+		cpu = atoi(p);
+		if (cpu < 0 || (!cpu && *p != '0') || cpu >= nr_cpus)
+			goto err;
+
+		while (isdigit(*p))
+			p++;
+		if (*p == '-') {
+			p++;
+			end_cpu = atoi(p);
+			if (end_cpu < cpu || (!end_cpu && *p != '0') || end_cpu >= nr_cpus)
+				goto err;
+			while (isdigit(*p))
+				p++;
+		} else
+			end_cpu = cpu;
+
+		if (cpu == end_cpu) {
+			debug_msg("cpu_set: adding cpu %d\n", cpu);
+			CPU_SET(cpu, set);
+		} else {
+			for (i = cpu; i <= end_cpu; i++) {
+				debug_msg("cpu_set: adding cpu %d\n", i);
+				CPU_SET(i, set);
+			}
+		}
+
+		if (*p == ',')
+			p++;
+	}
+
+	return 0;
+err:
+	debug_msg("Error parsing the cpu set %s\n", cpu_list);
+	return 1;
+}
+
 /*
  * parse_duration - parse duration with s/m/h/d suffix converting it to seconds
  */
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 42b6f099d10a..9ab2f0d7bc1c 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
+
 #include <stdint.h>
 #include <time.h>
+#include <sched.h>
 
 /*
  * '18446744073709551615\0'
@@ -54,6 +56,7 @@ struct sched_attr {
 };
 
 int parse_prio(char *arg, struct sched_attr *sched_param);
+int parse_cpu_set(char *cpu_list, cpu_set_t *set);
 int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr);
 int set_comm_cgroup(const char *comm_prefix, const char *cgroup);
 int set_cpu_dma_latency(int32_t latency);
-- 
2.38.1


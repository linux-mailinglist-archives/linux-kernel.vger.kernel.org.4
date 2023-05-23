Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D9A70E3D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbjEWRpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbjEWRou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:44:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64CF97;
        Tue, 23 May 2023 10:44:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 341A763564;
        Tue, 23 May 2023 17:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642FBC433D2;
        Tue, 23 May 2023 17:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684863887;
        bh=ilvKubt4M+tI9BEkBeyxjS9nZpmPWWkvlzUOJ9vM89c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZzSwZSa5Lqj4f7mWfUTyrmcmMEFeZEvn3TBO1QGeDIO8D43r9UumEdCi6R7QugYKf
         yWjHnQD+isg8xnXGkehnZudSvIAxQJy0UQASb4cnqw6xyK3Dkw3wPWlZXyZqkLjao1
         GX+68n0B1W/+A67046dvZy99CID2cZYA7jRxHGKpNHuVTugULEh1ak3Dy/EUwgGZwc
         wM2yuL+SIDgj8KDXf26Ae10Q/ISyQ+ER3dGmkOwBvRr+bi+Msd3OxKQkg9w6wsVyCx
         6lPoVzfOmhzhj7ndJvsD6hcf8Wp3lBj+DP7gUoNProgqj11Z4Y6pF1llA6+nLQ/EVh
         0xH+sJ1gdPH0g==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-doc@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH V2 3/9] rtla: Change monitored_cpus from char * to cpu_set_t
Date:   Tue, 23 May 2023 19:44:25 +0200
Message-Id: <82b94186866ff109058c8d9b8154845fe3bc69b2.1684863094.git.bristot@kernel.org>
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

Use a cpumask instead of a char *, reducing memory footprint and code.

No functional change, and in preparation for auto house-keeping.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 18 ++++----
 tools/tracing/rtla/src/osnoise_top.c   |  6 +--
 tools/tracing/rtla/src/timerlat_hist.c | 18 ++++----
 tools/tracing/rtla/src/timerlat_top.c  |  6 +--
 tools/tracing/rtla/src/utils.c         | 63 --------------------------
 5 files changed, 24 insertions(+), 87 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index d2b68177ffac..b616a72d5c0a 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -19,7 +19,7 @@
 
 struct osnoise_hist_params {
 	char			*cpus;
-	char			*monitored_cpus;
+	cpu_set_t		monitored_cpus;
 	char			*trace_output;
 	char			*cgroup_name;
 	unsigned long long	runtime;
@@ -274,7 +274,7 @@ static void osnoise_hist_header(struct osnoise_tool *tool)
 		trace_seq_printf(s, "Index");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !params->monitored_cpus[cpu])
+		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].count)
@@ -305,7 +305,7 @@ osnoise_print_summary(struct osnoise_hist_params *params,
 		trace_seq_printf(trace->seq, "count:");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !params->monitored_cpus[cpu])
+		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].count)
@@ -319,7 +319,7 @@ osnoise_print_summary(struct osnoise_hist_params *params,
 		trace_seq_printf(trace->seq, "min:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !params->monitored_cpus[cpu])
+		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].count)
@@ -334,7 +334,7 @@ osnoise_print_summary(struct osnoise_hist_params *params,
 		trace_seq_printf(trace->seq, "avg:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !params->monitored_cpus[cpu])
+		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].count)
@@ -352,7 +352,7 @@ osnoise_print_summary(struct osnoise_hist_params *params,
 		trace_seq_printf(trace->seq, "max:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !params->monitored_cpus[cpu])
+		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].count)
@@ -387,7 +387,7 @@ osnoise_print_stats(struct osnoise_hist_params *params, struct osnoise_tool *too
 					 bucket * data->bucket_size);
 
 		for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-			if (params->cpus && !params->monitored_cpus[cpu])
+			if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
 				continue;
 
 			if (!data->hist[cpu].count)
@@ -411,7 +411,7 @@ osnoise_print_stats(struct osnoise_hist_params *params, struct osnoise_tool *too
 		trace_seq_printf(trace->seq, "over: ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !params->monitored_cpus[cpu])
+		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].count)
@@ -559,7 +559,7 @@ static struct osnoise_hist_params
 				osnoise_hist_usage("Bucket size needs to be > 0 and <= 1000000\n");
 			break;
 		case 'c':
-			retval = parse_cpu_list(optarg, &params->monitored_cpus);
+			retval = parse_cpu_set(optarg, &params->monitored_cpus);
 			if (retval)
 				osnoise_hist_usage("\nInvalid -c cpu list\n");
 			params->cpus = optarg;
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index fcf6c14ce1bc..0e2f3b216d34 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -26,7 +26,7 @@ enum osnoise_mode {
  */
 struct osnoise_top_params {
 	char			*cpus;
-	char			*monitored_cpus;
+	cpu_set_t		monitored_cpus;
 	char			*trace_output;
 	char			*cgroup_name;
 	unsigned long long	runtime;
@@ -263,7 +263,7 @@ osnoise_print_stats(struct osnoise_top_params *params, struct osnoise_tool *top)
 	osnoise_top_header(top);
 
 	for (i = 0; i < nr_cpus; i++) {
-		if (params->cpus && !params->monitored_cpus[i])
+		if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
 			continue;
 		osnoise_top_print(top, i);
 	}
@@ -397,7 +397,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 
 			break;
 		case 'c':
-			retval = parse_cpu_list(optarg, &params->monitored_cpus);
+			retval = parse_cpu_set(optarg, &params->monitored_cpus);
 			if (retval)
 				osnoise_top_usage(params, "\nInvalid -c cpu list\n");
 			params->cpus = optarg;
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index d48c05d238f9..00287e96f22e 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -19,7 +19,7 @@
 
 struct timerlat_hist_params {
 	char			*cpus;
-	char			*monitored_cpus;
+	cpu_set_t		monitored_cpus;
 	char			*trace_output;
 	char			*cgroup_name;
 	unsigned long long	runtime;
@@ -227,7 +227,7 @@ static void timerlat_hist_header(struct osnoise_tool *tool)
 		trace_seq_printf(s, "Index");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !params->monitored_cpus[cpu])
+		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -263,7 +263,7 @@ timerlat_print_summary(struct timerlat_hist_params *params,
 		trace_seq_printf(trace->seq, "count:");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !params->monitored_cpus[cpu])
+		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -283,7 +283,7 @@ timerlat_print_summary(struct timerlat_hist_params *params,
 		trace_seq_printf(trace->seq, "min:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !params->monitored_cpus[cpu])
+		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -303,7 +303,7 @@ timerlat_print_summary(struct timerlat_hist_params *params,
 		trace_seq_printf(trace->seq, "avg:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !params->monitored_cpus[cpu])
+		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -331,7 +331,7 @@ timerlat_print_summary(struct timerlat_hist_params *params,
 		trace_seq_printf(trace->seq, "max:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !params->monitored_cpus[cpu])
+		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -371,7 +371,7 @@ timerlat_print_stats(struct timerlat_hist_params *params, struct osnoise_tool *t
 					 bucket * data->bucket_size);
 
 		for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-			if (params->cpus && !params->monitored_cpus[cpu])
+			if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
 				continue;
 
 			if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -405,7 +405,7 @@ timerlat_print_stats(struct timerlat_hist_params *params, struct osnoise_tool *t
 		trace_seq_printf(trace->seq, "over: ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !params->monitored_cpus[cpu])
+		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -565,7 +565,7 @@ static struct timerlat_hist_params
 
 			break;
 		case 'c':
-			retval = parse_cpu_list(optarg, &params->monitored_cpus);
+			retval = parse_cpu_set(optarg, &params->monitored_cpus);
 			if (retval)
 				timerlat_hist_usage("\nInvalid -c cpu list\n");
 			params->cpus = optarg;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 5395d1c5921e..920f2f6ef842 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -21,7 +21,7 @@
 
 struct timerlat_top_params {
 	char			*cpus;
-	char			*monitored_cpus;
+	cpu_set_t		monitored_cpus;
 	char			*trace_output;
 	char			*cgroup_name;
 	unsigned long long	runtime;
@@ -271,7 +271,7 @@ timerlat_print_stats(struct timerlat_top_params *params, struct osnoise_tool *to
 	timerlat_top_header(top);
 
 	for (i = 0; i < nr_cpus; i++) {
-		if (params->cpus && !params->monitored_cpus[i])
+		if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
 			continue;
 		timerlat_top_print(top, i);
 	}
@@ -422,7 +422,7 @@ static struct timerlat_top_params
 			params->aa_only = 1;
 			break;
 		case 'c':
-			retval = parse_cpu_list(optarg, &params->monitored_cpus);
+			retval = parse_cpu_set(optarg, &params->monitored_cpus);
 			if (retval)
 				timerlat_top_usage("\nInvalid -c cpu list\n");
 			params->cpus = optarg;
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index ee6fab09acae..8f9ad8f01e0f 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -88,69 +88,6 @@ void get_duration(time_t start_time, char *output, int output_size)
 			tm_info->tm_sec);
 }
 
-/*
- * parse_cpu_list - parse a cpu_list filling a char vector with cpus set
- *
- * Receives a cpu list, like 1-3,5 (cpus 1, 2, 3, 5), and then set the char
- * in the monitored_cpus.
- *
- * XXX: convert to a bitmask.
- */
-int parse_cpu_list(char *cpu_list, char **monitored_cpus)
-{
-	char *mon_cpus;
-	const char *p;
-	int end_cpu;
-	int nr_cpus;
-	int cpu;
-	int i;
-
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
-	mon_cpus = calloc(nr_cpus, sizeof(char));
-	if (!mon_cpus)
-		goto err;
-
-	for (p = cpu_list; *p; ) {
-		cpu = atoi(p);
-		if (cpu < 0 || (!cpu && *p != '0') || cpu >= nr_cpus)
-			goto err;
-
-		while (isdigit(*p))
-			p++;
-		if (*p == '-') {
-			p++;
-			end_cpu = atoi(p);
-			if (end_cpu < cpu || (!end_cpu && *p != '0') || end_cpu >= nr_cpus)
-				goto err;
-			while (isdigit(*p))
-				p++;
-		} else
-			end_cpu = cpu;
-
-		if (cpu == end_cpu) {
-			debug_msg("cpu_list: adding cpu %d\n", cpu);
-			mon_cpus[cpu] = 1;
-		} else {
-			for (i = cpu; i <= end_cpu; i++) {
-				debug_msg("cpu_list: adding cpu %d\n", i);
-				mon_cpus[i] = 1;
-			}
-		}
-
-		if (*p == ',')
-			p++;
-	}
-
-	*monitored_cpus = mon_cpus;
-
-	return 0;
-
-err:
-	debug_msg("Error parsing the cpu list %s", cpu_list);
-	return 1;
-}
-
 /*
  * parse_cpu_set - parse a cpu_list filling cpu_set_t argument
  *
-- 
2.38.1


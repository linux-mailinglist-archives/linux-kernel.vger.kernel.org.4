Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DED629AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiKONpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiKONpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:45:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B083F1838D;
        Tue, 15 Nov 2022 05:44:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24F086178F;
        Tue, 15 Nov 2022 13:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2665DC433D7;
        Tue, 15 Nov 2022 13:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668519896;
        bh=y5gYHjiMbbRWfK9nAN52M9wgZxq9/z0gJlFPKxrb1ag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oy0q7KZDC+SKo4S3Uwk/GJjcyv6iPjgmj5kZpvKFLcyM//Fa2dOrXkzqhV86bbYlB
         53G4bbcbuf58TK42wc1TvUYhx96ogDjUHXOB1wH4CPSdadO3urw1fxuGJRiit4AxZ+
         MtiZmkG9OYtXvyrChj+BhtJ21MYKuIffJntgcLn0Fwy5N7R1ZNHl1NHOq8EtdbPml4
         EYQ9xdSwEy2kkYQrur10VXAgrSd1LEoSFHg7YSZuje4m0U6ZIOVdfvZRgLf8NxhqO2
         1ZtT6FnMh6vE9Oqzy9kXxSX/CM73FllpZcJGE+kDVbFifvpE8u/OkIZrCOz7HHtPI4
         wpydBeeCFKV8A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 10D5B4073B; Tue, 15 Nov 2022 10:44:54 -0300 (-03)
Date:   Tue, 15 Nov 2022 10:44:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 10/10] perf list: Add json output option
Message-ID: <Y3OX1pcclKCgbpeT@kernel.org>
References: <20221114210723.2749751-1-irogers@google.com>
 <20221114210723.2749751-11-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114210723.2749751-11-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 14, 2022 at 01:07:23PM -0800, Ian Rogers escreveu:
> Output events and metrics in a json format by overriding the print
> callbacks. Currently other command line options aren't supported and
> metrics are repeated once per metric group.

Applied the patch with a few fixes and added this to the last cset:

commit c9367a0658ebcfe8ab0bc4af2648f144c64b53a4
Author: Ian Rogers <irogers@google.com>
Date:   Mon Nov 14 13:07:23 2022 -0800

    perf list: Add JSON output option
    
    Output events and metrics in a JSON format by overriding the print
    callbacks. Currently other command line options aren't supported and
    metrics are repeated once per metric group.
    
    Committer testing:
    
      $ perf list cache
    
      List of pre-defined events (to be used in -e or -M):
    
        L1-dcache-load-misses                              [Hardware cache event]
        L1-dcache-loads                                    [Hardware cache event]
        L1-dcache-prefetches                               [Hardware cache event]
        L1-icache-load-misses                              [Hardware cache event]
        L1-icache-loads                                    [Hardware cache event]
        branch-load-misses                                 [Hardware cache event]
        branch-loads                                       [Hardware cache event]
        dTLB-load-misses                                   [Hardware cache event]
        dTLB-loads                                         [Hardware cache event]
        iTLB-load-misses                                   [Hardware cache event]
        iTLB-loads                                         [Hardware cache event]
      $ perf list --json cache
      [
      {
              "Unit": "cache",
              "EventName": "L1-dcache-load-misses",
              "EventType": "Hardware cache event"
      },
      {
              "Unit": "cache",
              "EventName": "L1-dcache-loads",
              "EventType": "Hardware cache event"
      },
      {
              "Unit": "cache",
              "EventName": "L1-dcache-prefetches",
              "EventType": "Hardware cache event"
      },
      {
              "Unit": "cache",
              "EventName": "L1-icache-load-misses",
              "EventType": "Hardware cache event"
      },
      {
              "Unit": "cache",
              "EventName": "L1-icache-loads",
              "EventType": "Hardware cache event"
      },
      {
              "Unit": "cache",
              "EventName": "branch-load-misses",
              "EventType": "Hardware cache event"
      },
      {
              "Unit": "cache",
              "EventName": "branch-loads",
              "EventType": "Hardware cache event"
      },
      {
              "Unit": "cache",
              "EventName": "dTLB-load-misses",
              "EventType": "Hardware cache event"
      },
      {
              "Unit": "cache",
              "EventName": "dTLB-loads",
              "EventType": "Hardware cache event"
      },
      {
              "Unit": "cache",
              "EventName": "iTLB-load-misses",
              "EventType": "Hardware cache event"
      },
      {
              "Unit": "cache",
              "EventName": "iTLB-loads",
              "EventType": "Hardware cache event"
      }
      ]
      $
    
    Signed-off-by: Ian Rogers <irogers@google.com>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Caleb Biggers <caleb.biggers@intel.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Kajol Jain <kjain@linux.ibm.com>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Leo Yan <leo.yan@linaro.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Perry Taylor <perry.taylor@intel.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Ravi Bangoria <ravi.bangoria@amd.com>
    Cc: Rob Herring <robh@kernel.org>
    Cc: Sandipan Das <sandipan.das@amd.com>
    Cc: Stephane Eranian <eranian@google.com>
    Cc: Weilin Wang <weilin.wang@intel.com>
    Cc: Xin Gao <gaoxin@cdjrlc.com>
    Cc: Xing Zhengjun <zhengjun.xing@linux.intel.com>
    Link: http://lore.kernel.org/lkml/20221114210723.2749751-11-irogers@google.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 44a819af573dea4c..c5a3cb0f57c7cb8b 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -43,6 +43,10 @@ Print deprecated events. By default the deprecated events are hidden.
 Print PMU events and metrics limited to the specific PMU name.
 (e.g. --unit cpu, --unit msr, --unit cpu_core, --unit cpu_atom)
 
+-j::
+--json::
+Output in JSON format.
+
 [[EVENT_MODIFIERS]]
 EVENT MODIFIERS
 ---------------
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 12811fc40a3067cc..aec139f7fbb2d558 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -19,6 +19,7 @@
 #include "util/strlist.h"
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
+#include <stdarg.h>
 #include <stdio.h>
 
 /**
@@ -228,10 +229,176 @@ static void default_print_metric(void *ps,
 	}
 }
 
+struct json_print_state {
+	/** Should a separator be printed prior to the next item? */
+	bool need_sep;
+};
+
+static void json_print_start(void *print_state __maybe_unused)
+{
+	printf("[\n");
+}
+
+static void json_print_end(void *ps)
+{
+	struct json_print_state *print_state = ps;
+
+	printf("%s]\n", print_state->need_sep ? "\n" : "");
+}
+
+static void fix_escape_printf(const char *fmt, ...)
+{
+	va_list args;
+	char buf[2048];
+	size_t buf_pos = 0;
+
+	va_start(args, fmt);
+	for (size_t fmt_pos = 0; fmt_pos < strlen(fmt); fmt_pos++) {
+		switch (fmt[fmt_pos]) {
+		case '%': {
+			const char *s = va_arg(args, const char*);
+
+			fmt_pos++;
+			assert(fmt[fmt_pos] == 's');
+			for (size_t s_pos = 0; s_pos < strlen(s); s_pos++) {
+				switch (s[s_pos]) {
+				case '\\':
+					__fallthrough;
+				case '\"':
+					buf[buf_pos++] = '\\';
+					assert(buf_pos < sizeof(buf));
+					__fallthrough;
+				default:
+					buf[buf_pos++] = s[s_pos];
+					assert(buf_pos < sizeof(buf));
+					break;
+				}
+			}
+			break;
+		}
+		default:
+			buf[buf_pos++] = fmt[fmt_pos];
+			assert(buf_pos < sizeof(buf));
+			break;
+		}
+	}
+	va_end(args);
+	buf[buf_pos] = '\0';
+	fputs(buf, stdout);
+}
+
+static void json_print_event(void *ps, const char *pmu_name, const char *topic,
+			     const char *event_name, const char *event_alias,
+			     const char *scale_unit,
+			     bool deprecated, const char *event_type_desc,
+			     const char *desc, const char *long_desc,
+			     const char *encoding_desc,
+			     const char *metric_name, const char *metric_expr)
+{
+	struct json_print_state *print_state = ps;
+	bool need_sep = false;
+
+	printf("%s{\n", print_state->need_sep ? ",\n" : "");
+	print_state->need_sep = true;
+	if (pmu_name) {
+		fix_escape_printf("\t\"Unit\": \"%s\"", pmu_name);
+		need_sep = true;
+	}
+	if (topic) {
+		fix_escape_printf("%s\t\"Topic\": \"%s\"", need_sep ? ",\n" : "", topic);
+		need_sep = true;
+	}
+	if (event_name) {
+		fix_escape_printf("%s\t\"EventName\": \"%s\"", need_sep ? ",\n" : "", event_name);
+		need_sep = true;
+	}
+	if (event_alias && strlen(event_alias)) {
+		fix_escape_printf("%s\t\"EventAlias\": \"%s\"", need_sep ? ",\n" : "", event_alias);
+		need_sep = true;
+	}
+	if (scale_unit && strlen(scale_unit)) {
+		fix_escape_printf("%s\t\"ScaleUnit\": \"%s\"", need_sep ? ",\n" : "",
+				  scale_unit);
+		need_sep = true;
+	}
+	if (event_type_desc) {
+		fix_escape_printf("%s\t\"EventType\": \"%s\"", need_sep ? ",\n" : "",
+				  event_type_desc);
+		need_sep = true;
+	}
+	if (deprecated) {
+		fix_escape_printf("%s\t\"Deprecated\": \"%s\"", need_sep ? ",\n" : "",
+				  deprecated ? "1" : "0");
+		need_sep = true;
+	}
+	if (desc) {
+		fix_escape_printf("%s\t\"BriefDescription\": \"%s\"", need_sep ? ",\n" : "", desc);
+		need_sep = true;
+	}
+	if (long_desc) {
+		fix_escape_printf("%s\t\"PublicDescription\": \"%s\"", need_sep ? ",\n" : "",
+				  long_desc);
+		need_sep = true;
+	}
+	if (encoding_desc) {
+		fix_escape_printf("%s\t\"Encoding\": \"%s\"", need_sep ? ",\n" : "", encoding_desc);
+		need_sep = true;
+	}
+	if (metric_name) {
+		fix_escape_printf("%s\t\"MetricName\": \"%s\"", need_sep ? ",\n" : "", metric_name);
+		need_sep = true;
+	}
+	if (metric_expr) {
+		fix_escape_printf("%s\t\"MetricExpr\": \"%s\"", need_sep ? ",\n" : "", metric_expr);
+		need_sep = true;
+	}
+	printf("%s}", need_sep ? "\n" : "");
+}
+
+static void json_print_metric(void *ps __maybe_unused, const char *group,
+			      const char *name, const char *desc,
+			      const char *long_desc, const char *expr,
+			      const char *unit)
+{
+	struct json_print_state *print_state = ps;
+	bool need_sep = false;
+
+	printf("%s{\n", print_state->need_sep ? ",\n" : "");
+	print_state->need_sep = true;
+	if (group) {
+		fix_escape_printf("\t\"MetricGroup\": \"%s\"", group);
+		need_sep = true;
+	}
+	if (name) {
+		fix_escape_printf("%s\t\"MetricName\": \"%s\"", need_sep ? ",\n" : "", name);
+		need_sep = true;
+	}
+	if (expr) {
+		fix_escape_printf("%s\t\"MetricExpr\": \"%s\"", need_sep ? ",\n" : "", expr);
+		need_sep = true;
+	}
+	if (unit) {
+		fix_escape_printf("%s\t\"ScaleUnit\": \"%s\"", need_sep ? ",\n" : "", unit);
+		need_sep = true;
+	}
+	if (desc) {
+		fix_escape_printf("%s\t\"BriefDescription\": \"%s\"", need_sep ? ",\n" : "", desc);
+		need_sep = true;
+	}
+	if (long_desc) {
+		fix_escape_printf("%s\t\"PublicDescription\": \"%s\"", need_sep ? ",\n" : "",
+				  long_desc);
+		need_sep = true;
+	}
+	printf("%s}", need_sep ? "\n" : "");
+}
+
 int cmd_list(int argc, const char **argv)
 {
 	int i, ret = 0;
-	struct print_state ps = {};
+	struct print_state default_ps = {};
+	struct print_state json_ps = {};
+	void *ps = &default_ps;
 	struct print_callbacks print_cb = {
 		.print_start = default_print_start,
 		.print_end = default_print_end,
@@ -240,15 +407,17 @@ int cmd_list(int argc, const char **argv)
 	};
 	const char *hybrid_name = NULL;
 	const char *unit_name = NULL;
+	bool json = false;
 	struct option list_options[] = {
-		OPT_BOOLEAN(0, "raw-dump", &ps.name_only, "Dump raw events"),
-		OPT_BOOLEAN('d', "desc", &ps.desc,
+		OPT_BOOLEAN(0, "raw-dump", &default_ps.name_only, "Dump raw events"),
+		OPT_BOOLEAN('j', "json", &json, "JSON encode events and metrics"),
+		OPT_BOOLEAN('d', "desc", &default_ps.desc,
 			    "Print extra event descriptions. --no-desc to not print."),
-		OPT_BOOLEAN('v', "long-desc", &ps.long_desc,
+		OPT_BOOLEAN('v', "long-desc", &default_ps.long_desc,
 			    "Print longer event descriptions."),
-		OPT_BOOLEAN(0, "details", &ps.detailed,
+		OPT_BOOLEAN(0, "details", &default_ps.detailed,
 			    "Print information on the perf event names and expressions used internally by events."),
-		OPT_BOOLEAN(0, "deprecated", &ps.deprecated,
+		OPT_BOOLEAN(0, "deprecated", &default_ps.deprecated,
 			    "Print deprecated events."),
 		OPT_STRING(0, "cputype", &hybrid_name, "hybrid cpu type",
 			   "Limit PMU or metric printing to the given hybrid PMU (e.g. core or atom)."),
@@ -272,28 +441,37 @@ int cmd_list(int argc, const char **argv)
 
 	setup_pager();
 
-	if (!ps.name_only)
+	if (!default_ps.name_only)
 		setup_pager();
 
-	ps.desc = !ps.long_desc;
-	ps.last_topic = strdup("");
-	assert(ps.last_topic);
-	ps.visited_metrics = strlist__new(NULL, NULL);
-	assert(ps.visited_metrics);
-	if (unit_name)
-		ps.pmu_glob = strdup(unit_name);
-	else if (hybrid_name) {
-		ps.pmu_glob = perf_pmu__hybrid_type_to_pmu(hybrid_name);
-		if (!ps.pmu_glob)
-			pr_warning("WARNING: hybrid cputype is not supported!\n");
+	if (json) {
+		print_cb = (struct print_callbacks){
+			.print_start = json_print_start,
+			.print_end = json_print_end,
+			.print_event = json_print_event,
+			.print_metric = json_print_metric,
+		};
+		ps = &json_ps;
+	} else {
+		default_ps.desc = !default_ps.long_desc;
+		default_ps.last_topic = strdup("");
+		assert(default_ps.last_topic);
+		default_ps.visited_metrics = strlist__new(NULL, NULL);
+		assert(default_ps.visited_metrics);
+		if (unit_name)
+			default_ps.pmu_glob = strdup(unit_name);
+		else if (hybrid_name) {
+			default_ps.pmu_glob = perf_pmu__hybrid_type_to_pmu(hybrid_name);
+			if (!default_ps.pmu_glob)
+				pr_warning("WARNING: hybrid cputype is not supported!\n");
+		}
 	}
-
 	print_cb.print_start(&ps);
 
 	if (argc == 0) {
-		ps.metrics = true;
-		ps.metricgroups = true;
-		print_events(&print_cb, &ps);
+		default_ps.metrics = true;
+		default_ps.metricgroups = true;
+		print_events(&print_cb, ps);
 		goto out;
 	}
 
@@ -301,32 +479,32 @@ int cmd_list(int argc, const char **argv)
 		char *sep, *s;
 
 		if (strcmp(argv[i], "tracepoint") == 0)
-			print_tracepoint_events(&print_cb, &ps);
+			print_tracepoint_events(&print_cb, ps);
 		else if (strcmp(argv[i], "hw") == 0 ||
 			 strcmp(argv[i], "hardware") == 0)
-			print_symbol_events(&print_cb, &ps, PERF_TYPE_HARDWARE,
+			print_symbol_events(&print_cb, ps, PERF_TYPE_HARDWARE,
 					event_symbols_hw, PERF_COUNT_HW_MAX);
 		else if (strcmp(argv[i], "sw") == 0 ||
 			 strcmp(argv[i], "software") == 0) {
-			print_symbol_events(&print_cb, &ps, PERF_TYPE_SOFTWARE,
+			print_symbol_events(&print_cb, ps, PERF_TYPE_SOFTWARE,
 					event_symbols_sw, PERF_COUNT_SW_MAX);
-			print_tool_events(&print_cb, &ps);
+			print_tool_events(&print_cb, ps);
 		} else if (strcmp(argv[i], "cache") == 0 ||
 			 strcmp(argv[i], "hwcache") == 0)
-			print_hwcache_events(&print_cb, &ps);
+			print_hwcache_events(&print_cb, ps);
 		else if (strcmp(argv[i], "pmu") == 0)
-			print_pmu_events(&print_cb, &ps);
+			print_pmu_events(&print_cb, ps);
 		else if (strcmp(argv[i], "sdt") == 0)
-			print_sdt_events(&print_cb, &ps);
+			print_sdt_events(&print_cb, ps);
 		else if (strcmp(argv[i], "metric") == 0 || strcmp(argv[i], "metrics") == 0) {
-			ps.metricgroups = false;
-			ps.metrics = true;
-			metricgroup__print(&print_cb, &ps);
+			default_ps.metricgroups = false;
+			default_ps.metrics = true;
+			metricgroup__print(&print_cb, ps);
 		} else if (strcmp(argv[i], "metricgroup") == 0 ||
 			   strcmp(argv[i], "metricgroups") == 0) {
-			ps.metricgroups = true;
-			ps.metrics = false;
-			metricgroup__print(&print_cb, &ps);
+			default_ps.metricgroups = true;
+			default_ps.metrics = false;
+			metricgroup__print(&print_cb, ps);
 		} else if ((sep = strchr(argv[i], ':')) != NULL) {
 			int sep_idx;
 
@@ -338,41 +516,41 @@ int cmd_list(int argc, const char **argv)
 			}
 
 			s[sep_idx] = '\0';
-			ps.pmu_glob = s;
-			ps.event_glob = s + sep_idx + 1;
-			print_tracepoint_events(&print_cb, &ps);
-			print_sdt_events(&print_cb, &ps);
-			ps.metrics = true;
-			ps.metricgroups = true;
-			metricgroup__print(&print_cb, &ps);
+			default_ps.pmu_glob = s;
+			default_ps.event_glob = s + sep_idx + 1;
+			print_tracepoint_events(&print_cb, ps);
+			print_sdt_events(&print_cb, ps);
+			default_ps.metrics = true;
+			default_ps.metricgroups = true;
+			metricgroup__print(&print_cb, ps);
 			free(s);
 		} else {
 			if (asprintf(&s, "*%s*", argv[i]) < 0) {
 				printf("Critical: Not enough memory! Trying to continue...\n");
 				continue;
 			}
-			ps.event_glob = s;
-			print_symbol_events(&print_cb, &ps, PERF_TYPE_HARDWARE,
+			default_ps.event_glob = s;
+			print_symbol_events(&print_cb, ps, PERF_TYPE_HARDWARE,
 					event_symbols_hw, PERF_COUNT_HW_MAX);
-			print_symbol_events(&print_cb, &ps, PERF_TYPE_SOFTWARE,
+			print_symbol_events(&print_cb, ps, PERF_TYPE_SOFTWARE,
 					event_symbols_sw, PERF_COUNT_SW_MAX);
-			print_tool_events(&print_cb, &ps);
-			print_hwcache_events(&print_cb, &ps);
-			print_pmu_events(&print_cb, &ps);
-			print_tracepoint_events(&print_cb, &ps);
-			print_sdt_events(&print_cb, &ps);
-			ps.metrics = true;
-			ps.metricgroups = true;
-			metricgroup__print(&print_cb, &ps);
+			print_tool_events(&print_cb, ps);
+			print_hwcache_events(&print_cb, ps);
+			print_pmu_events(&print_cb, ps);
+			print_tracepoint_events(&print_cb, ps);
+			print_sdt_events(&print_cb, ps);
+			default_ps.metrics = true;
+			default_ps.metricgroups = true;
+			metricgroup__print(&print_cb, ps);
 			free(s);
 		}
 	}
 
 out:
-	print_cb.print_end(&ps);
-	free(ps.pmu_glob);
-	free(ps.last_topic);
-	free(ps.last_metricgroups);
-	strlist__delete(ps.visited_metrics);
+	print_cb.print_end(ps);
+	free(default_ps.pmu_glob);
+	free(default_ps.last_topic);
+	free(default_ps.last_metricgroups);
+	strlist__delete(default_ps.visited_metrics);
 	return ret;
 }

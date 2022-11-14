Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D816276C9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbiKNHxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbiKNHxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:53:16 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB79192B8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:53:15 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id f132-20020a636a8a000000b00473d0b600ebso5512795pgc.14
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nAX60ecFtxgT+PDunRPYKAFBfhjC2kUCNn7e5xMw2JM=;
        b=buGqKnielvJwFkIZh5KnRlsCoQyiK3G1y/CNoBamUlBH5JV/Cifos89LeN123Ozmac
         axidpKkzBNDMZ8jNK7z1suD0cOyTqRSvsrcCILT79EzFnqwxip2ae74Mlq8BrSo5jcwI
         ZHsi2k1DudB15Aq/+cBACKSzIpjYKCt1MZhizZtuANMRZQSjSFNX2kXH3V5nt/FghEj0
         0WtRXgCbXKB+dwW9AxCJ/auGvTPBaEuNNNOgef9BYRY+5k6D1JQR5IzBwWEyJleInXvN
         jGjbQacFrVPHuduF3QhjeeQ5//PL3CFx/FQKlLU6I300gDhM/XAo/zWD9s/g4v+GNg2z
         qH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAX60ecFtxgT+PDunRPYKAFBfhjC2kUCNn7e5xMw2JM=;
        b=ix7TlGg6BA4rmAxoE6jLS2NpG05Ms5fz+fGn8/+NJAOJJRh1BLsr8A/tdnW3KUe3v4
         uwBz5G4EY31gSxRyu1Hewihhob7eiGAkBMmwHbjgPUFVj76G7cIrv9c+6M08o8WNmaSh
         EEpSFdsOZZp+NkcXlZDJmwXsE939KWzVmrpTCMVPzZMSLwacO2pRkLbfxY2iOi+ZHQJr
         SEd7U2UKV6m5qqbMTELzWTiZzie/xt5i1jcaB6eMgry8QQlWJ67QOIpyICojCcqCdBIn
         dv22YG//qSwYXsvjK5WPzaQBskxtt4q2Tww1Z6kCB7CCavf7sBbhstDbtBXcp1/oHIte
         Pnlg==
X-Gm-Message-State: ANoB5pn52nA4SOEEbhWSugn/mJvAV3Fy29I3q4SYw6kUGHVbsQr8/fyM
        UPXxkRD0SILK+POmw2NmDEwoK+w2TobX
X-Google-Smtp-Source: AA0mqf5LtZ/I3nyYUy9i7XP06eUtsBJJ2jH8YLuDJ+643JLOqdp4Fpwgv/Ycvqsz8UGnevFML5okx/OFKn5q
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cba6:8279:98e6:3d6e])
 (user=irogers job=sendgmr) by 2002:a62:442:0:b0:562:86a3:12fc with SMTP id
 63-20020a620442000000b0056286a312fcmr13130193pfe.8.1668412394679; Sun, 13 Nov
 2022 23:53:14 -0800 (PST)
Date:   Sun, 13 Nov 2022 23:51:27 -0800
In-Reply-To: <20221114075127.2650315-1-irogers@google.com>
Message-Id: <20221114075127.2650315-10-irogers@google.com>
Mime-Version: 1.0
References: <20221114075127.2650315-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 9/9] perf list: Add json output option
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Output events and metrics in a json format by overriding the print
callbacks. Currently other command line options aren't supported and
metrics are repeated once per metric group.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt |   4 +
 tools/perf/builtin-list.c              | 283 ++++++++++++++++++++-----
 2 files changed, 229 insertions(+), 58 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 44a819af573d..43263ca88ff7 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -43,6 +43,10 @@ Print deprecated events. By default the deprecated events are hidden.
 Print PMU events and metrics limited to the specific PMU name.
 (e.g. --unit cpu, --unit msr, --unit cpu_core, --unit cpu_atom)
 
+-j::
+--json::
+Output in json format.
+
 [[EVENT_MODIFIERS]]
 EVENT MODIFIERS
 ---------------
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 91e2b6f52548..910b5c3a7365 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -19,6 +19,7 @@
 #include "util/strlist.h"
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
+#include <stdarg.h>
 #include <stdio.h>
 
 struct print_state {
@@ -217,10 +218,165 @@ static void default_print_metric(void *ps,
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
+			      const char *long_desc, const char *expr)
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
@@ -229,15 +385,17 @@ int cmd_list(int argc, const char **argv)
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
@@ -261,28 +419,37 @@ int cmd_list(int argc, const char **argv)
 
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
 
@@ -290,32 +457,32 @@ int cmd_list(int argc, const char **argv)
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
 
@@ -327,41 +494,41 @@ int cmd_list(int argc, const char **argv)
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
-- 
2.38.1.431.g37b22c650d-goog


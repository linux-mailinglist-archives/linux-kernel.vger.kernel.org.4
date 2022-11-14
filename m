Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75356276C8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbiKNHx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236053AbiKNHxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:53:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D819D192BC
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:53:05 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e8-20020a5b0cc8000000b006bca0fa3ab6so9790776ybr.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P7CdsK7LKGmaK29paCv9s5r815Q4tV1Nmy/lNeV4sxg=;
        b=eWZQIXxY73fPABNoV2qENjPke7AOayGeJD07h8nWq9f/2Bf4UyYwnnBZab/qmyknVh
         i4PjxUYaw7PBRWbgfGhISMNCdGx0Co7sj3SLembWQWvvsPaGndP132LJrBmkL6S4rDRc
         uA0mGBqLmdH1FLyjkD2pYVTp0B9FKB3jYW69PL79Vmu2XZLmqXDlw5+sgTIh0Tel9g6K
         8+xAXyKlSN9NkdQvucx+9WN0Tfy+umxYmwA0wJgDEUObPxex23hAlSomsfVLbzSSTqrR
         mZIslosHxaa1GaCWLDXmdJ/yc7kZuos7YnmMpBC6bm4tJztnruZoDrJKgLd5g399v58D
         lHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7CdsK7LKGmaK29paCv9s5r815Q4tV1Nmy/lNeV4sxg=;
        b=E9sK65I89Dc01u+l2uq0iTgADZZi1X587mXEQR7O//aqmjOPbY2Yq46hWoh/y3ORq1
         a4cIPMlvWwmKsczz27/7+vYwRL+Ms7BoQTrqAXNgILJ1crrL28s+gPezZsq0ySfJtvFE
         BPKI/QvCkKQVBp0BBS/eN8GBAPNVl3SaA5o3IVVk15vWnLghqAhEec2jY8jeZ0Nity67
         oXrlds6r3aemaUPg2gqFvyg8Dl+Z7PI3tqLloCRrgHXkgPB4AB7ZAI6vhVaKrj/RzpRg
         43avzbBBuFGRP6NmMsgC/ZGBmKFcqcOMpo02eHu2aZZ+y18Cf2TayoaEhUEkfCH2t17w
         2bYA==
X-Gm-Message-State: ANoB5pnpSDo1FOqWoN5hweX9Wl0nxgAfry1uZsCgZenjOc1xaPrnGOYw
        NhKSI57wKSsEoNx5aHyGWP10Yd5OMWJw
X-Google-Smtp-Source: AA0mqf6XNMkvIuO/Xl03pMDPHJeay/bDsXGdGIUC/6U2/wE5RxZgXhk/80OwFT4XInEZ2vNqMjKnn6YUMCLF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cba6:8279:98e6:3d6e])
 (user=irogers job=sendgmr) by 2002:a5b:886:0:b0:6cb:7ce0:9e8e with SMTP id
 e6-20020a5b0886000000b006cb7ce09e8emr11220659ybq.55.1668412385156; Sun, 13
 Nov 2022 23:53:05 -0800 (PST)
Date:   Sun, 13 Nov 2022 23:51:26 -0800
In-Reply-To: <20221114075127.2650315-1-irogers@google.com>
Message-Id: <20221114075127.2650315-9-irogers@google.com>
Mime-Version: 1.0
References: <20221114075127.2650315-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 8/9] perf list: Reorganize to use callbacks
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than controlling the list output with passed flags, add
callbacks that are called when an event or metric are
encountered. State is passed to the callback so that command line
options can be respected, alternatively the callbacks can be changed.

Fix a few bugs:
 - wordwrap to columns metric descriptions and expressions;
 - remove unnecessary whitespace after PMU event names;
 - the metric filter is a glob but matched using strstr which will
   always fail, switch to using a proper globmatch,
 - the detail flag gives details for extra kernel PMU events like
   branch-instructions.

In metricgroup.c switch from struct mep being a rbtree of metricgroups
containing a list of metrics, to the tree directly containing all the
metrics. In general the alias for a name is passed to the print
routine rather than being contained in the name with OR.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c      | 320 ++++++++++++++++++++++++-----
 tools/perf/util/metricgroup.c  | 239 ++++++----------------
 tools/perf/util/metricgroup.h  |   4 +-
 tools/perf/util/pmu.c          | 137 ++++---------
 tools/perf/util/pmu.h          |   5 +-
 tools/perf/util/print-events.c | 355 +++++++++++++++++----------------
 tools/perf/util/print-events.h |  40 ++--
 7 files changed, 588 insertions(+), 512 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index cc84ced6da26..91e2b6f52548 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -15,31 +15,229 @@
 #include "util/pmu-hybrid.h"
 #include "util/debug.h"
 #include "util/metricgroup.h"
+#include "util/string2.h"
+#include "util/strlist.h"
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include <stdio.h>
 
-static bool desc_flag = true;
-static bool details_flag;
+struct print_state {
+	/**
+	 * Optionally restrict PMU and metric matching to PMU or debugfs
+	 * subsystem name.
+	 */
+	char *pmu_glob;
+	/** Optional pattern matching glob. */
+	char *event_glob;
+	/** Print event or metric names only. */
+	bool name_only;
+	/** Print the event or metric description. */
+	bool desc;
+	/** Print longer event or metric description. */
+	bool long_desc;
+	/** Print deprecated events or metrics. */
+	bool deprecated;
+	/**
+	 * Print extra information on the perf event such as names and
+	 * expressions used internally by events.
+	 */
+	bool detailed;
+	bool metrics;
+	bool metricgroups;
+	char *last_topic;
+	char *last_metricgroups;
+	struct strlist *visited_metrics;
+};
+
+static void default_print_start(void *ps)
+{
+	struct print_state *print_state = ps;
+
+	if (!print_state->name_only && pager_in_use())
+		printf("\nList of pre-defined events (to be used in -e or -M):\n\n");
+}
+
+static void default_print_end(void *print_state __maybe_unused) {}
+
+static void wordwrap(const char *s, int start, int max, int corr)
+{
+	int column = start;
+	int n;
+
+	while (*s) {
+		int wlen = strcspn(s, " \t");
+
+		if (column + wlen >= max && column > start) {
+			printf("\n%*s", start, "");
+			column = start + corr;
+		}
+		n = printf("%s%.*s", column > start ? " " : "", wlen, s);
+		if (n <= 0)
+			break;
+		s += wlen;
+		column += n;
+		s = skip_spaces(s);
+	}
+}
+
+static void default_print_event(void *ps, const char *pmu_name, const char *topic,
+				const char *event_name, const char *event_alias,
+				bool deprecated, const char *event_type_desc,
+				const char *desc, const char *long_desc,
+				const char *encoding_desc,
+				const char *metric_name, const char *metric_expr)
+{
+	struct print_state *print_state = ps;
+	int pos;
+
+	if (deprecated && !print_state->deprecated)
+		return;
+
+	if (print_state->pmu_glob && !strglobmatch(pmu_name, print_state->pmu_glob))
+		return;
+
+	if (print_state->event_glob &&
+	    (!event_name || !strglobmatch(event_name, print_state->event_glob)) &&
+	    (!event_alias || !strglobmatch(event_alias, print_state->event_glob)) &&
+	    (!topic || !strglobmatch_nocase(topic, print_state->event_glob)))
+		return;
+
+	if (print_state->name_only) {
+		if (event_alias && strlen(event_alias))
+			printf("%s ", event_alias);
+		else
+			printf("%s ", event_name);
+		return;
+	}
+
+	if (strcmp(print_state->last_topic, topic ?: "")) {
+		if (topic)
+			printf("\n%s:\n", topic);
+		free(print_state->last_topic);
+		print_state->last_topic = strdup(topic ?: "");
+	}
+
+	if (event_alias && strlen(event_alias))
+		pos = printf("  %s OR %s", event_name, event_alias);
+	else
+		pos = printf("  %s", event_name);
+
+	if (!topic && event_type_desc) {
+		for (; pos < 53; pos++)
+			putchar(' ');
+		printf("[%s]\n", event_type_desc);
+	} else
+		putchar('\n');
+
+	if (desc && print_state->desc) {
+		printf("%*s", 8, "[");
+		wordwrap(desc, 8, pager_get_columns(), 0);
+		printf("]\n");
+	}
+
+	if (long_desc && print_state->long_desc) {
+		printf("%*s", 8, "[");
+		wordwrap(long_desc, 8, pager_get_columns(), 0);
+		printf("]\n");
+	}
+
+	if (print_state->detailed && encoding_desc) {
+		printf("%*s%s", 8, "", encoding_desc);
+		if (metric_name)
+			printf(" MetricName: %s", metric_name);
+		if (metric_expr)
+			printf(" MetricExpr: %s", metric_expr);
+		putchar('\n');
+	}
+}
+
+static void default_print_metric(void *ps,
+				const char *group,
+				const char *name,
+				const char *desc,
+				const char *long_desc,
+				const char *expr)
+{
+	struct print_state *print_state = ps;
+
+	if (print_state->event_glob &&
+	    (!print_state->metrics || !name || !strglobmatch(name, print_state->event_glob)) &&
+	    (!print_state->metricgroups || !group || !strglobmatch(group, print_state->event_glob)))
+		return;
+
+	if (!print_state->name_only && !print_state->last_metricgroups) {
+		if (print_state->metricgroups) {
+			printf("\nMetric Groups:\n");
+			if (!print_state->metrics)
+				putchar('\n');
+		} else {
+			printf("\nMetrics:\n\n");
+		}
+	}
+	if (!print_state->last_metricgroups ||
+	    strcmp(print_state->last_metricgroups, group ?: "")) {
+		if (group && print_state->metricgroups) {
+			if (print_state->name_only)
+				printf("%s ", group);
+			else if (print_state->metrics)
+				printf("\n%s:\n", group);
+			else
+				printf("%s\n", group);
+		}
+		free(print_state->last_metricgroups);
+		print_state->last_metricgroups = strdup(group ?: "");
+	}
+	if (!print_state->metrics)
+		return;
+
+	if (print_state->name_only) {
+		if (print_state->metrics &&
+		    !strlist__has_entry(print_state->visited_metrics, name)) {
+			printf("%s ", name);
+			strlist__add(print_state->visited_metrics, name);
+		}
+		return;
+	}
+	printf("  %s\n", name);
+
+	if (desc && print_state->desc) {
+		printf("%*s", 8, "[");
+		wordwrap(desc, 8, pager_get_columns(), 0);
+		printf("]\n");
+	}
+	if (long_desc && print_state->long_desc) {
+		printf("%*s", 8, "[");
+		wordwrap(long_desc, 8, pager_get_columns(), 0);
+		printf("]\n");
+	}
+	if (expr && print_state->detailed) {
+		printf("%*s", 8, "[");
+		wordwrap(expr, 8, pager_get_columns(), 0);
+		printf("]\n");
+	}
+}
 
 int cmd_list(int argc, const char **argv)
 {
 	int i, ret = 0;
-	bool raw_dump = false;
-	bool long_desc_flag = false;
-	bool deprecated = false;
-	char *pmu_name = NULL;
+	struct print_state ps = {};
+	struct print_callbacks print_cb = {
+		.print_start = default_print_start,
+		.print_end = default_print_end,
+		.print_event = default_print_event,
+		.print_metric = default_print_metric,
+	};
 	const char *hybrid_name = NULL;
 	const char *unit_name = NULL;
 	struct option list_options[] = {
-		OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
-		OPT_BOOLEAN('d', "desc", &desc_flag,
+		OPT_BOOLEAN(0, "raw-dump", &ps.name_only, "Dump raw events"),
+		OPT_BOOLEAN('d', "desc", &ps.desc,
 			    "Print extra event descriptions. --no-desc to not print."),
-		OPT_BOOLEAN('v', "long-desc", &long_desc_flag,
+		OPT_BOOLEAN('v', "long-desc", &ps.long_desc,
 			    "Print longer event descriptions."),
-		OPT_BOOLEAN(0, "details", &details_flag,
+		OPT_BOOLEAN(0, "details", &ps.detailed,
 			    "Print information on the perf event names and expressions used internally by events."),
-		OPT_BOOLEAN(0, "deprecated", &deprecated,
+		OPT_BOOLEAN(0, "deprecated", &ps.deprecated,
 			    "Print deprecated events."),
 		OPT_STRING(0, "cputype", &hybrid_name, "hybrid cpu type",
 			   "Limit PMU or metric printing to the given hybrid PMU (e.g. core or atom)."),
@@ -63,20 +261,28 @@ int cmd_list(int argc, const char **argv)
 
 	setup_pager();
 
-	if (!raw_dump && pager_in_use())
-		printf("\nList of pre-defined events (to be used in -e or -M):\n\n");
+	if (!ps.name_only)
+		setup_pager();
 
+	ps.desc = !ps.long_desc;
+	ps.last_topic = strdup("");
+	assert(ps.last_topic);
+	ps.visited_metrics = strlist__new(NULL, NULL);
+	assert(ps.visited_metrics);
 	if (unit_name)
-		pmu_name = strdup(unit_name);
+		ps.pmu_glob = strdup(unit_name);
 	else if (hybrid_name) {
-		pmu_name = perf_pmu__hybrid_type_to_pmu(hybrid_name);
-		if (!pmu_name)
+		ps.pmu_glob = perf_pmu__hybrid_type_to_pmu(hybrid_name);
+		if (!ps.pmu_glob)
 			pr_warning("WARNING: hybrid cputype is not supported!\n");
 	}
 
+	print_cb.print_start(&ps);
+
 	if (argc == 0) {
-		print_events(NULL, raw_dump, !desc_flag, long_desc_flag,
-				details_flag, deprecated, pmu_name);
+		ps.metrics = true;
+		ps.metricgroups = true;
+		print_events(&print_cb, &ps);
 		goto out;
 	}
 
@@ -84,30 +290,33 @@ int cmd_list(int argc, const char **argv)
 		char *sep, *s;
 
 		if (strcmp(argv[i], "tracepoint") == 0)
-			print_tracepoint_events(NULL, NULL, raw_dump);
+			print_tracepoint_events(&print_cb, &ps);
 		else if (strcmp(argv[i], "hw") == 0 ||
 			 strcmp(argv[i], "hardware") == 0)
-			print_symbol_events(NULL, PERF_TYPE_HARDWARE,
-					event_symbols_hw, PERF_COUNT_HW_MAX, raw_dump);
+			print_symbol_events(&print_cb, &ps, PERF_TYPE_HARDWARE,
+					event_symbols_hw, PERF_COUNT_HW_MAX);
 		else if (strcmp(argv[i], "sw") == 0 ||
 			 strcmp(argv[i], "software") == 0) {
-			print_symbol_events(NULL, PERF_TYPE_SOFTWARE,
-					event_symbols_sw, PERF_COUNT_SW_MAX, raw_dump);
-			print_tool_events(NULL, raw_dump);
+			print_symbol_events(&print_cb, &ps, PERF_TYPE_SOFTWARE,
+					event_symbols_sw, PERF_COUNT_SW_MAX);
+			print_tool_events(&print_cb, &ps);
 		} else if (strcmp(argv[i], "cache") == 0 ||
 			 strcmp(argv[i], "hwcache") == 0)
-			print_hwcache_events(NULL, raw_dump);
+			print_hwcache_events(&print_cb, &ps);
 		else if (strcmp(argv[i], "pmu") == 0)
-			print_pmu_events(NULL, raw_dump, !desc_flag,
-						long_desc_flag, details_flag,
-						deprecated, pmu_name);
+			print_pmu_events(&print_cb, &ps);
 		else if (strcmp(argv[i], "sdt") == 0)
-			print_sdt_events(NULL, NULL, raw_dump);
-		else if (strcmp(argv[i], "metric") == 0 || strcmp(argv[i], "metrics") == 0)
-			metricgroup__print(true, false, NULL, raw_dump, details_flag, pmu_name);
-		else if (strcmp(argv[i], "metricgroup") == 0 || strcmp(argv[i], "metricgroups") == 0)
-			metricgroup__print(false, true, NULL, raw_dump, details_flag, pmu_name);
-		else if ((sep = strchr(argv[i], ':')) != NULL) {
+			print_sdt_events(&print_cb, &ps);
+		else if (strcmp(argv[i], "metric") == 0 || strcmp(argv[i], "metrics") == 0) {
+			ps.metricgroups = false;
+			ps.metrics = true;
+			metricgroup__print(&print_cb, &ps);
+		} else if (strcmp(argv[i], "metricgroup") == 0 ||
+			   strcmp(argv[i], "metricgroups") == 0) {
+			ps.metricgroups = true;
+			ps.metrics = false;
+			metricgroup__print(&print_cb, &ps);
+		} else if ((sep = strchr(argv[i], ':')) != NULL) {
 			int sep_idx;
 
 			sep_idx = sep - argv[i];
@@ -118,34 +327,41 @@ int cmd_list(int argc, const char **argv)
 			}
 
 			s[sep_idx] = '\0';
-			print_tracepoint_events(s, s + sep_idx + 1, raw_dump);
-			print_sdt_events(s, s + sep_idx + 1, raw_dump);
-			metricgroup__print(true, true, s, raw_dump, details_flag, pmu_name);
+			ps.pmu_glob = s;
+			ps.event_glob = s + sep_idx + 1;
+			print_tracepoint_events(&print_cb, &ps);
+			print_sdt_events(&print_cb, &ps);
+			ps.metrics = true;
+			ps.metricgroups = true;
+			metricgroup__print(&print_cb, &ps);
 			free(s);
 		} else {
 			if (asprintf(&s, "*%s*", argv[i]) < 0) {
 				printf("Critical: Not enough memory! Trying to continue...\n");
 				continue;
 			}
-			print_symbol_events(s, PERF_TYPE_HARDWARE,
-					    event_symbols_hw, PERF_COUNT_HW_MAX, raw_dump);
-			print_symbol_events(s, PERF_TYPE_SOFTWARE,
-					    event_symbols_sw, PERF_COUNT_SW_MAX, raw_dump);
-			print_tool_events(s, raw_dump);
-			print_hwcache_events(s, raw_dump);
-			print_pmu_events(s, raw_dump, !desc_flag,
-						long_desc_flag,
-						details_flag,
-						deprecated,
-						pmu_name);
-			print_tracepoint_events(NULL, s, raw_dump);
-			print_sdt_events(NULL, s, raw_dump);
-			metricgroup__print(true, true, s, raw_dump, details_flag, pmu_name);
+			ps.event_glob = s;
+			print_symbol_events(&print_cb, &ps, PERF_TYPE_HARDWARE,
+					event_symbols_hw, PERF_COUNT_HW_MAX);
+			print_symbol_events(&print_cb, &ps, PERF_TYPE_SOFTWARE,
+					event_symbols_sw, PERF_COUNT_SW_MAX);
+			print_tool_events(&print_cb, &ps);
+			print_hwcache_events(&print_cb, &ps);
+			print_pmu_events(&print_cb, &ps);
+			print_tracepoint_events(&print_cb, &ps);
+			print_sdt_events(&print_cb, &ps);
+			ps.metrics = true;
+			ps.metricgroups = true;
+			metricgroup__print(&print_cb, &ps);
 			free(s);
 		}
 	}
 
 out:
-	free(pmu_name);
+	print_cb.print_end(&ps);
+	free(ps.pmu_glob);
+	free(ps.last_topic);
+	free(ps.last_metricgroups);
+	strlist__delete(ps.visited_metrics);
 	return ret;
 }
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 1943fed9b6d9..4cb2a193c0f2 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -12,6 +12,7 @@
 #include "strbuf.h"
 #include "pmu.h"
 #include "pmu-hybrid.h"
+#include "print-events.h"
 #include "expr.h"
 #include "rblist.h"
 #include <string.h>
@@ -352,51 +353,63 @@ static bool match_pe_metric(const struct pmu_event *pe, const char *metric)
 	       match_metric(pe->metric_name, metric);
 }
 
+/** RB-tree node for building printing information. */
 struct mep {
 	struct rb_node nd;
-	const char *name;
-	struct strlist *metrics;
+	/** Owned metric group name, separated others with ';'. */
+	char *metric_group;
+	const char *metric_name;
+	const char *metric_desc;
+	const char *metric_long_desc;
+	const char *metric_expr;
 };
 
 static int mep_cmp(struct rb_node *rb_node, const void *entry)
 {
 	struct mep *a = container_of(rb_node, struct mep, nd);
 	struct mep *b = (struct mep *)entry;
+	int ret;
 
-	return strcmp(a->name, b->name);
+	ret = strcmp(a->metric_group, b->metric_group);
+	if (ret)
+		return ret;
+
+	return strcmp(a->metric_name, b->metric_name);
 }
 
-static struct rb_node *mep_new(struct rblist *rl __maybe_unused,
-					const void *entry)
+static struct rb_node *mep_new(struct rblist *rl __maybe_unused, const void *entry)
 {
 	struct mep *me = malloc(sizeof(struct mep));
 
 	if (!me)
 		return NULL;
+
 	memcpy(me, entry, sizeof(struct mep));
-	me->name = strdup(me->name);
-	if (!me->name)
-		goto out_me;
-	me->metrics = strlist__new(NULL, NULL);
-	if (!me->metrics)
-		goto out_name;
 	return &me->nd;
-out_name:
-	zfree(&me->name);
-out_me:
+}
+
+static void mep_delete(struct rblist *rl __maybe_unused,
+		       struct rb_node *nd)
+{
+	struct mep *me = container_of(nd, struct mep, nd);
+
+	zfree(&me->metric_group);
 	free(me);
-	return NULL;
 }
 
-static struct mep *mep_lookup(struct rblist *groups, const char *name)
+static struct mep *mep_lookup(struct rblist *groups, const char *metric_group,
+			      const char *metric_name)
 {
 	struct rb_node *nd;
 	struct mep me = {
-		.name = name
+		.metric_group = strdup(metric_group),
+		.metric_name = metric_name,
 	};
 	nd = rblist__find(groups, &me);
-	if (nd)
+	if (nd) {
+		free(me.metric_group);
 		return container_of(nd, struct mep, nd);
+	}
 	rblist__add_node(groups, &me);
 	nd = rblist__find(groups, &me);
 	if (nd)
@@ -404,107 +417,36 @@ static struct mep *mep_lookup(struct rblist *groups, const char *name)
 	return NULL;
 }
 
-static void mep_delete(struct rblist *rl __maybe_unused,
-		       struct rb_node *nd)
-{
-	struct mep *me = container_of(nd, struct mep, nd);
-
-	strlist__delete(me->metrics);
-	zfree(&me->name);
-	free(me);
-}
-
-static void metricgroup__print_strlist(struct strlist *metrics, bool raw)
-{
-	struct str_node *sn;
-	int n = 0;
-
-	strlist__for_each_entry (sn, metrics) {
-		if (raw)
-			printf("%s%s", n > 0 ? " " : "", sn->s);
-		else
-			printf("  %s\n", sn->s);
-		n++;
-	}
-	if (raw)
-		putchar('\n');
-}
-
-static int metricgroup__print_pmu_event(const struct pmu_event *pe,
-					bool metricgroups, char *filter,
-					bool raw, bool details,
-					struct rblist *groups,
-					struct strlist *metriclist)
+static int metricgroup__add_to_mep_groups(const struct pmu_event *pe,
+					struct rblist *groups)
 {
 	const char *g;
 	char *omg, *mg;
 
-	g = pe->metric_group;
-	if (!g && pe->metric_name) {
-		if (pe->name)
-			return 0;
-		g = "No_group";
-	}
-
-	if (!g)
-		return 0;
-
-	mg = strdup(g);
-
+	mg = strdup(pe->metric_group ?: "No_group");
 	if (!mg)
 		return -ENOMEM;
 	omg = mg;
 	while ((g = strsep(&mg, ";")) != NULL) {
 		struct mep *me;
-		char *s;
 
 		g = skip_spaces(g);
-		if (*g == 0)
-			g = "No_group";
-		if (filter && !strstr(g, filter))
-			continue;
-		if (raw)
-			s = (char *)pe->metric_name;
-		else {
-			if (asprintf(&s, "%s\n%*s%s]",
-				     pe->metric_name, 8, "[", pe->desc) < 0)
-				return -1;
-			if (details) {
-				if (asprintf(&s, "%s\n%*s%s]",
-					     s, 8, "[", pe->metric_expr) < 0)
-					return -1;
-			}
-		}
-
-		if (!s)
-			continue;
+		if (strlen(g))
+			me = mep_lookup(groups, g, pe->metric_name);
+		else
+			me = mep_lookup(groups, "No_group", pe->metric_name);
 
-		if (!metricgroups) {
-			strlist__add(metriclist, s);
-		} else {
-			me = mep_lookup(groups, g);
-			if (!me)
-				continue;
-			strlist__add(me->metrics, s);
+		if (me) {
+			me->metric_desc = pe->desc;
+			me->metric_long_desc = pe->long_desc;
+			me->metric_expr = pe->metric_expr;
 		}
-
-		if (!raw)
-			free(s);
 	}
 	free(omg);
 
 	return 0;
 }
 
-struct metricgroup_print_sys_idata {
-	struct strlist *metriclist;
-	char *filter;
-	struct rblist *groups;
-	bool metricgroups;
-	bool raw;
-	bool details;
-};
-
 struct metricgroup_iter_data {
 	pmu_event_iter_fn fn;
 	void *data;
@@ -527,61 +469,26 @@ static int metricgroup__sys_event_iter(const struct pmu_event *pe,
 
 		return d->fn(pe, table, d->data);
 	}
-
 	return 0;
 }
 
-static int metricgroup__print_sys_event_iter(const struct pmu_event *pe,
-					     const struct pmu_events_table *table __maybe_unused,
-					     void *data)
-{
-	struct metricgroup_print_sys_idata *d = data;
-
-	return metricgroup__print_pmu_event(pe, d->metricgroups, d->filter, d->raw,
-				     d->details, d->groups, d->metriclist);
-}
-
-struct metricgroup_print_data {
-	const char *pmu_name;
-	struct strlist *metriclist;
-	char *filter;
-	struct rblist *groups;
-	bool metricgroups;
-	bool raw;
-	bool details;
-};
-
-static int metricgroup__print_callback(const struct pmu_event *pe,
-				       const struct pmu_events_table *table __maybe_unused,
-				       void *vdata)
+static int metricgroup__add_to_mep_groups_callback(const struct pmu_event *pe,
+						const struct pmu_events_table *table __maybe_unused,
+						void *vdata)
 {
-	struct metricgroup_print_data *data = vdata;
-	const char *pmu = pe->pmu ?: "cpu";
+	struct rblist *groups = vdata;
 
-	if (!pe->metric_expr)
+	if (!pe->metric_name)
 		return 0;
 
-	if (data->pmu_name && strcmp(data->pmu_name, pmu))
-		return 0;
-
-	return metricgroup__print_pmu_event(pe, data->metricgroups, data->filter,
-					    data->raw, data->details, data->groups,
-					    data->metriclist);
+	return metricgroup__add_to_mep_groups(pe, groups);
 }
 
-void metricgroup__print(bool metrics, bool metricgroups, char *filter,
-			bool raw, bool details, const char *pmu_name)
+void metricgroup__print(const struct print_callbacks *print_cb, void *print_state)
 {
 	struct rblist groups;
-	struct rb_node *node, *next;
-	struct strlist *metriclist = NULL;
 	const struct pmu_events_table *table;
-
-	if (!metricgroups) {
-		metriclist = strlist__new(NULL, NULL);
-		if (!metriclist)
-			return;
-	}
+	struct rb_node *node, *next;
 
 	rblist__init(&groups);
 	groups.node_new = mep_new;
@@ -589,56 +496,30 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	groups.node_delete = mep_delete;
 	table = pmu_events_table__find();
 	if (table) {
-		struct metricgroup_print_data data = {
-			.pmu_name = pmu_name,
-			.metriclist = metriclist,
-			.metricgroups = metricgroups,
-			.filter = filter,
-			.raw = raw,
-			.details = details,
-			.groups = &groups,
-		};
-
 		pmu_events_table_for_each_event(table,
-						metricgroup__print_callback,
-						&data);
+						metricgroup__add_to_mep_groups_callback,
+						&groups);
 	}
 	{
 		struct metricgroup_iter_data data = {
-			.fn = metricgroup__print_sys_event_iter,
-			.data = (void *) &(struct metricgroup_print_sys_idata){
-				.metriclist = metriclist,
-				.metricgroups = metricgroups,
-				.filter = filter,
-				.raw = raw,
-				.details = details,
-				.groups = &groups,
-			},
+			.fn = metricgroup__add_to_mep_groups_callback,
+			.data = &groups,
 		};
-
 		pmu_for_each_sys_event(metricgroup__sys_event_iter, &data);
 	}
 
-	if (!filter || !rblist__empty(&groups)) {
-		if (metricgroups && !raw)
-			printf("\nMetric Groups:\n\n");
-		else if (metrics && !raw)
-			printf("\nMetrics:\n\n");
-	}
-
 	for (node = rb_first_cached(&groups.entries); node; node = next) {
 		struct mep *me = container_of(node, struct mep, nd);
 
-		if (metricgroups)
-			printf("%s%s%s", me->name, metrics && !raw ? ":" : "", raw ? " " : "\n");
-		if (metrics)
-			metricgroup__print_strlist(me->metrics, raw);
+		print_cb->print_metric(print_state,
+				me->metric_group,
+				me->metric_name,
+				me->metric_desc,
+				me->metric_long_desc,
+				me->metric_expr);
 		next = rb_next(node);
 		rblist__remove_node(&groups, node);
 	}
-	if (!metricgroups)
-		metricgroup__print_strlist(metriclist, raw);
-	strlist__delete(metriclist);
 }
 
 static const char *code_characters = ",-=@";
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 732d3a0d3334..0013cf582173 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -10,6 +10,7 @@
 struct evlist;
 struct evsel;
 struct option;
+struct print_callbacks;
 struct rblist;
 struct cgroup;
 
@@ -78,8 +79,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 				   bool metric_no_merge,
 				   struct rblist *metric_events);
 
-void metricgroup__print(bool metrics, bool groups, char *filter,
-			bool raw, bool details, const char *pmu_name);
+void metricgroup__print(const struct print_callbacks *print_cb, void *print_state);
 bool metricgroup__has_metric(const char *metric);
 int arch_get_runtimeparam(const struct pmu_event *pe __maybe_unused);
 void metricgroup__rblist_exit(struct rblist *metric_events);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8322395c9cf7..b7a34dd28875 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -23,6 +23,7 @@
 #include "evsel.h"
 #include "pmu.h"
 #include "parse-events.h"
+#include "print-events.h"
 #include "header.h"
 #include "string2.h"
 #include "strbuf.h"
@@ -1578,13 +1579,6 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 	return buf;
 }
 
-static char *format_alias_or(char *buf, int len, const struct perf_pmu *pmu,
-			     const struct perf_pmu_alias *alias)
-{
-	snprintf(buf, len, "%s OR %s/%s/", alias->name, pmu->name, alias->name);
-	return buf;
-}
-
 /** Struct for ordering events as output in perf list. */
 struct sevent {
 	/** PMU for event. */
@@ -1628,7 +1622,7 @@ static int cmp_sevent(const void *a, const void *b)
 
 	/* Order CPU core events to be first */
 	if (as->is_cpu != bs->is_cpu)
-		return bs->is_cpu - as->is_cpu;
+		return as->is_cpu ? -1 : 1;
 
 	/* Order by PMU name. */
 	a_pmu_name = as->pmu->name ?: "";
@@ -1641,27 +1635,6 @@ static int cmp_sevent(const void *a, const void *b)
 	return strcmp(a_name, b_name);
 }
 
-static void wordwrap(char *s, int start, int max, int corr)
-{
-	int column = start;
-	int n;
-
-	while (*s) {
-		int wlen = strcspn(s, " \t");
-
-		if (column + wlen >= max && column > start) {
-			printf("\n%*s", start, "");
-			column = start + corr;
-		}
-		n = printf("%s%.*s", column > start ? " " : "", wlen, s);
-		if (n <= 0)
-			break;
-		s += wlen;
-		column += n;
-		s = skip_spaces(s);
-	}
-}
-
 bool is_pmu_core(const char *name)
 {
 	return !strcmp(name, "cpu") || is_arm_pmu_core(name);
@@ -1684,24 +1657,19 @@ static bool pmu_alias_is_duplicate(struct sevent *alias_a,
 	return strcmp(a_pmu_name, b_pmu_name) == 0;
 }
 
-void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
-			bool long_desc, bool details_flag, bool deprecated,
-			const char *pmu_name)
+void print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
 {
 	struct perf_pmu *pmu;
-	struct perf_pmu_alias *alias;
+	struct perf_pmu_alias *event;
 	char buf[1024];
 	int printed = 0;
 	int len, j;
 	struct sevent *aliases;
-	int numdesc = 0;
-	int columns = pager_get_columns();
-	char *topic = NULL;
 
 	pmu = NULL;
 	len = 0;
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
-		list_for_each_entry(alias, &pmu->aliases, list)
+		list_for_each_entry(event, &pmu->aliases, list)
 			len++;
 		if (pmu->selectable)
 			len++;
@@ -1714,32 +1682,15 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 	pmu = NULL;
 	j = 0;
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
-		bool is_cpu;
+		bool is_cpu = is_pmu_core(pmu->name) || pmu->is_hybrid;
 
-		if (pmu_name && pmu->name && strcmp(pmu_name, pmu->name))
-			continue;
-
-		is_cpu = is_pmu_core(pmu->name) || pmu->is_hybrid;
-
-		list_for_each_entry(alias, &pmu->aliases, list) {
-			if (alias->deprecated && !deprecated)
-				continue;
-
-			if (event_glob != NULL &&
-			    !(strglobmatch_nocase(alias->name, event_glob) ||
-			      (!is_cpu &&
-			       strglobmatch_nocase(alias->name, event_glob)) ||
-			      (alias->topic &&
-			       strglobmatch_nocase(alias->topic, event_glob))))
-				continue;
-
-			aliases[j].event = alias;
+		list_for_each_entry(event, &pmu->aliases, list) {
+			aliases[j].event = event;
 			aliases[j].pmu = pmu;
 			aliases[j].is_cpu = is_cpu;
 			j++;
 		}
-		if (pmu->selectable &&
-		    (event_glob == NULL || strglobmatch(pmu->name, event_glob))) {
+		if (pmu->selectable) {
 			aliases[j].event = NULL;
 			aliases[j].pmu = pmu;
 			aliases[j].is_cpu = is_cpu;
@@ -1749,7 +1700,11 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 	len = j;
 	qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
 	for (j = 0; j < len; j++) {
-		char *name, *desc;
+		const char *name, *alias = NULL, *desc = NULL, *long_desc = NULL,
+			*encoding_desc = NULL, *topic = NULL,
+			*metric_name = NULL, *metric_expr = NULL;
+		bool deprecated = false;
+		size_t buf_used;
 
 		/* Skip duplicates */
 		if (j > 0 && pmu_alias_is_duplicate(&aliases[j], &aliases[j - 1]))
@@ -1757,48 +1712,44 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 
 		if (!aliases[j].event) {
 			/* A selectable event. */
-			snprintf(buf, sizeof(buf), "%s//", aliases[j].pmu->name);
+			buf_used = snprintf(buf, sizeof(buf), "%s//", aliases[j].pmu->name) + 1;
 			name = buf;
-		} else if (aliases[j].event->desc) {
-			name = aliases[j].event->name;
 		} else {
-			if (!name_only && aliases[j].is_cpu) {
-				name = format_alias_or(buf, sizeof(buf), aliases[j].pmu,
-						       aliases[j].event);
+			if (aliases[j].event->desc) {
+				name = aliases[j].event->name;
+				buf_used = 0;
 			} else {
 				name = format_alias(buf, sizeof(buf), aliases[j].pmu,
 						    aliases[j].event);
+				if (aliases[j].is_cpu) {
+					alias = name;
+					name = aliases[j].event->name;
+				}
+				buf_used = strlen(buf) + 1;
 			}
-		}
-		if (name_only) {
-			printf("%s ", name);
-			continue;
-		}
-		printed++;
-		if (!aliases[j].event || !aliases[j].event->desc || quiet_flag) {
-			printf("  %-50s [Kernel PMU event]\n", name);
-			continue;
-		}
-		if (numdesc++ == 0)
-			printf("\n");
-		if (aliases[j].event->topic && (!topic ||
-						strcmp(topic, aliases[j].event->topic))) {
-			printf("%s%s:\n", topic ? "\n" : "", aliases[j].event->topic);
+			desc = aliases[j].event->desc;
+			long_desc = aliases[j].event->long_desc;
 			topic = aliases[j].event->topic;
+			encoding_desc = buf + buf_used;
+			buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
+					"%s/%s/", aliases[j].pmu->name,
+					aliases[j].event->str) + 1;
+			metric_name = aliases[j].event->metric_name;
+			metric_expr = aliases[j].event->metric_expr;
+			deprecated = aliases[j].event->deprecated;
 		}
-		printf("  %-50s\n", name);
-		printf("%*s", 8, "[");
-		desc = long_desc ? aliases[j].event->long_desc : aliases[j].event->desc;
-		wordwrap(desc, 8, columns, 0);
-		printf("]\n");
-		if (details_flag) {
-			printf("%*s%s/%s/ ", 8, "", aliases[j].pmu->name, aliases[j].event->str);
-			if (aliases[j].event->metric_name)
-				printf(" MetricName: %s", aliases[j].event->metric_name);
-			if (aliases[j].event->metric_expr)
-				printf(" MetricExpr: %s", aliases[j].event->metric_expr);
-			putchar('\n');
-		}
+		print_cb->print_event(print_state,
+				aliases[j].pmu->name,
+				topic,
+				name,
+				alias,
+				deprecated,
+				"Kernel PMU event",
+				desc,
+				long_desc,
+				encoding_desc,
+				metric_name,
+				metric_expr);
 	}
 	if (printed && pager_in_use())
 		printf("\n");
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 29571c0f9d15..4f9b0202be2d 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -12,6 +12,7 @@
 
 struct evsel_config_term;
 struct perf_cpu_map;
+struct print_callbacks;
 
 enum {
 	PERF_PMU_FORMAT_VALUE_CONFIG,
@@ -209,9 +210,7 @@ void perf_pmu__del_formats(struct list_head *formats);
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 
 bool is_pmu_core(const char *name);
-void print_pmu_events(const char *event_glob, bool name_only, bool quiet,
-		      bool long_desc, bool details_flag,
-		      bool deprecated, const char *pmu_name);
+void print_pmu_events(const struct print_callbacks *print_cb, void *print_state);
 bool pmu_have_event(const char *pname, const char *name);
 
 int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt, ...) __scanf(3, 4);
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index d53dba033597..9aa53e43bda0 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -28,6 +28,7 @@
 
 #define MAX_NAME_LEN 100
 
+/** Strings corresponding to enum perf_type_id. */
 static const char * const event_type_descriptors[] = {
 	"Hardware event",
 	"Software event",
@@ -55,11 +56,9 @@ static const struct event_symbol event_symbols_tool[PERF_TOOL_MAX] = {
 /*
  * Print the events from <debugfs_mount_point>/tracing/events
  */
-void print_tracepoint_events(const char *subsys_glob,
-			     const char *event_glob, bool name_only)
+void print_tracepoint_events(const struct print_callbacks *print_cb, void *print_state)
 {
 	struct dirent **sys_namelist = NULL;
-	bool printed = false;
 	int sys_items = tracing_events__scandir_alphasort(&sys_namelist);
 
 	for (int i = 0; i < sys_items; i++) {
@@ -73,10 +72,6 @@ void print_tracepoint_events(const char *subsys_glob,
 		    !strcmp(sys_dirent->d_name, ".."))
 			continue;
 
-		if (subsys_glob != NULL &&
-		    !strglobmatch(sys_dirent->d_name, subsys_glob))
-			continue;
-
 		dir_path = get_events_file(sys_dirent->d_name);
 		if (!dir_path)
 			continue;
@@ -94,41 +89,40 @@ void print_tracepoint_events(const char *subsys_glob,
 			if (tp_event_has_id(dir_path, evt_dirent) != 0)
 				continue;
 
-			if (event_glob != NULL &&
-			    !strglobmatch(evt_dirent->d_name, event_glob))
-				continue;
-
 			snprintf(evt_path, MAXPATHLEN, "%s:%s",
 				 sys_dirent->d_name, evt_dirent->d_name);
-			if (name_only)
-				printf("%s ", evt_path);
-			else {
-				printf("  %-50s [%s]\n", evt_path,
-				       event_type_descriptors[PERF_TYPE_TRACEPOINT]);
-			}
-			printed = true;
+			print_cb->print_event(print_state,
+					/*topic=*/NULL,
+					/*pmu_name=*/NULL,
+					evt_path,
+					/*event_alias=*/NULL,
+					/*deprecated=*/false,
+					"Tracepoint event",
+					/*desc=*/NULL,
+					/*long_desc=*/NULL,
+					/*encoding_desc=*/NULL,
+					/*metric_name=*/NULL,
+					/*metric_expr=*/NULL);
 		}
 		free(dir_path);
 		free(evt_namelist);
 	}
 	free(sys_namelist);
-	if (printed && pager_in_use())
-		printf("\n");
 }
 
-void print_sdt_events(const char *subsys_glob, const char *event_glob,
-		      bool name_only)
+void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 {
-	struct probe_cache *pcache;
-	struct probe_cache_entry *ent;
 	struct strlist *bidlist, *sdtlist;
-	struct strlist_config cfg = {.dont_dupstr = true};
-	struct str_node *nd, *nd2;
-	char *buf, *path, *ptr = NULL;
-	bool show_detail = false;
-	int ret;
-
-	sdtlist = strlist__new(NULL, &cfg);
+	struct str_node *bid_nd, *sdt_name, *next_sdt_name;
+	const char *last_sdt_name = NULL;
+
+	/*
+	 * The implicitly sorted sdtlist will hold the tracepoint name followed
+	 * by @<buildid>. If the tracepoint name is unique (determined by
+	 * looking at the adjacent nodes) the @<buildid> is dropped otherwise
+	 * the executable path and buildid are added to the name.
+	 */
+	sdtlist = strlist__new(NULL, NULL);
 	if (!sdtlist) {
 		pr_debug("Failed to allocate new strlist for SDT\n");
 		return;
@@ -138,65 +132,76 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
 		pr_debug("Failed to get buildids: %d\n", errno);
 		return;
 	}
-	strlist__for_each_entry(nd, bidlist) {
-		pcache = probe_cache__new(nd->s, NULL);
+	strlist__for_each_entry(bid_nd, bidlist) {
+		struct probe_cache *pcache;
+		struct probe_cache_entry *ent;
+
+		pcache = probe_cache__new(bid_nd->s, NULL);
 		if (!pcache)
 			continue;
 		list_for_each_entry(ent, &pcache->entries, node) {
-			if (!ent->sdt)
-				continue;
-			if (subsys_glob &&
-			    !strglobmatch(ent->pev.group, subsys_glob))
-				continue;
-			if (event_glob &&
-			    !strglobmatch(ent->pev.event, event_glob))
-				continue;
-			ret = asprintf(&buf, "%s:%s@%s", ent->pev.group,
-					ent->pev.event, nd->s);
-			if (ret > 0)
-				strlist__add(sdtlist, buf);
+			char buf[1024];
+
+			snprintf(buf, sizeof(buf), "%s:%s@%s",
+				 ent->pev.group, ent->pev.event, bid_nd->s);
+			strlist__add(sdtlist, buf);
 		}
 		probe_cache__delete(pcache);
 	}
 	strlist__delete(bidlist);
 
-	strlist__for_each_entry(nd, sdtlist) {
-		buf = strchr(nd->s, '@');
-		if (buf)
-			*(buf++) = '\0';
-		if (name_only) {
-			printf("%s ", nd->s);
-			continue;
-		}
-		nd2 = strlist__next(nd);
-		if (nd2) {
-			ptr = strchr(nd2->s, '@');
-			if (ptr)
-				*ptr = '\0';
-			if (strcmp(nd->s, nd2->s) == 0)
-				show_detail = true;
+	strlist__for_each_entry(sdt_name, sdtlist) {
+		bool show_detail = false;
+		char *bid = strchr(sdt_name->s, '@');
+		char *evt_name = NULL;
+
+		if (bid)
+			*(bid++) = '\0';
+
+		if (last_sdt_name && !strcmp(last_sdt_name, sdt_name->s)) {
+			show_detail = true;
+		} else {
+			next_sdt_name = strlist__next(sdt_name);
+			if (next_sdt_name) {
+				char *bid2 = strchr(next_sdt_name->s, '@');
+
+				if (bid2)
+					*bid2 = '\0';
+				if (strcmp(sdt_name->s, next_sdt_name->s) == 0)
+					show_detail = true;
+				if (bid2)
+					*bid2 = '@';
+			}
 		}
+		last_sdt_name = sdt_name->s;
+
 		if (show_detail) {
-			path = build_id_cache__origname(buf);
-			ret = asprintf(&buf, "%s@%s(%.12s)", nd->s, path, buf);
-			if (ret > 0) {
-				printf("  %-50s [%s]\n", buf, "SDT event");
-				free(buf);
+			char *path = build_id_cache__origname(bid);
+
+			if (path) {
+				asprintf(&evt_name, "%s@%s(%.12s)", sdt_name->s, path, bid);
+				free(path);
 			}
-			free(path);
-		} else
-			printf("  %-50s [%s]\n", nd->s, "SDT event");
-		if (nd2) {
-			if (strcmp(nd->s, nd2->s) != 0)
-				show_detail = false;
-			if (ptr)
-				*ptr = '@';
 		}
+		print_cb->print_event(print_state,
+				/*topic=*/NULL,
+				/*pmu_name=*/NULL,
+				evt_name ?: sdt_name->s,
+				/*event_alias=*/NULL,
+				/*deprecated=*/false,
+				"SDT event",
+				/*desc=*/NULL,
+				/*long_desc=*/NULL,
+				/*encoding_desc=*/NULL,
+				/*metric_name=*/NULL,
+				/*metric_expr=*/NULL);
+
+		free(evt_name);
 	}
 	strlist__delete(sdtlist);
 }
 
-int print_hwcache_events(const char *event_glob, bool name_only)
+int print_hwcache_events(const struct print_callbacks *print_cb, void *print_state)
 {
 	struct strlist *evt_name_list = strlist__new(NULL, NULL);
 	struct str_node *nd;
@@ -216,9 +221,6 @@ int print_hwcache_events(const char *event_glob, bool name_only)
 				char name[64];
 
 				__evsel__hw_cache_type_op_res_name(type, op, i, name, sizeof(name));
-				if (event_glob != NULL && !strglobmatch(name, event_glob))
-					continue;
-
 				if (!perf_pmu__has_hybrid()) {
 					if (is_event_supported(PERF_TYPE_HW_CACHE,
 							       type | (op << 8) | (i << 16)))
@@ -240,55 +242,45 @@ int print_hwcache_events(const char *event_glob, bool name_only)
 	}
 
 	strlist__for_each_entry(nd, evt_name_list) {
-		if (name_only) {
-			printf("%s ", nd->s);
-			continue;
-		}
-		printf("  %-50s [%s]\n", nd->s, event_type_descriptors[PERF_TYPE_HW_CACHE]);
+		print_cb->print_event(print_state,
+				"cache",
+				/*pmu_name=*/NULL,
+				nd->s,
+				/*event_alias=*/NULL,
+				/*deprecated=*/false,
+				event_type_descriptors[PERF_TYPE_HW_CACHE],
+				/*desc=*/NULL,
+				/*long_desc=*/NULL,
+				/*encoding_desc=*/NULL,
+				/*metric_name=*/NULL,
+				/*metric_expr=*/NULL);
 	}
-	if (!strlist__empty(evt_name_list) && pager_in_use())
-		printf("\n");
-
 	strlist__delete(evt_name_list);
 	return 0;
 }
 
-static void print_tool_event(const struct event_symbol *syms, const char *event_glob,
-			     bool name_only)
-{
-	if (syms->symbol == NULL)
-		return;
-
-	if (event_glob && !(strglobmatch(syms->symbol, event_glob) ||
-	      (syms->alias && strglobmatch(syms->alias, event_glob))))
-		return;
-
-	if (name_only)
-		printf("%s ", syms->symbol);
-	else {
-		char name[MAX_NAME_LEN];
-
-		if (syms->alias && strlen(syms->alias))
-			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms->symbol, syms->alias);
-		else
-			strlcpy(name, syms->symbol, MAX_NAME_LEN);
-		printf("  %-50s [%s]\n", name, "Tool event");
-	}
-}
-
-void print_tool_events(const char *event_glob, bool name_only)
+void print_tool_events(const struct print_callbacks *print_cb, void *print_state)
 {
 	// Start at 1 because the first enum entry means no tool event.
-	for (int i = 1; i < PERF_TOOL_MAX; ++i)
-		print_tool_event(event_symbols_tool + i, event_glob, name_only);
-
-	if (pager_in_use())
-		printf("\n");
+	for (int i = 1; i < PERF_TOOL_MAX; ++i) {
+		print_cb->print_event(print_state,
+				"tool",
+				/*pmu_name=*/NULL,
+				event_symbols_tool[i].symbol,
+				event_symbols_tool[i].alias,
+				/*deprecated=*/false,
+				"Tool event",
+				/*desc=*/NULL,
+				/*long_desc=*/NULL,
+				/*encoding_desc=*/NULL,
+				/*metric_name=*/NULL,
+				/*metric_expr=*/NULL);
+	}
 }
 
-void print_symbol_events(const char *event_glob, unsigned int type,
-			 struct event_symbol *syms, unsigned int max,
-			 bool name_only)
+void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
+			 unsigned int type, const struct event_symbol *syms,
+			 unsigned int max)
 {
 	struct strlist *evt_name_list = strlist__new(NULL, NULL);
 	struct str_node *nd;
@@ -305,10 +297,6 @@ void print_symbol_events(const char *event_glob, unsigned int type,
 		if (syms[i].symbol == NULL)
 			continue;
 
-		if (event_glob != NULL && !(strglobmatch(syms[i].symbol, event_glob) ||
-		      (syms[i].alias && strglobmatch(syms[i].alias, event_glob))))
-			continue;
-
 		if (!is_event_supported(type, i))
 			continue;
 
@@ -322,63 +310,88 @@ void print_symbol_events(const char *event_glob, unsigned int type,
 	}
 
 	strlist__for_each_entry(nd, evt_name_list) {
-		if (name_only) {
-			printf("%s ", nd->s);
-			continue;
+		char *alias = strstr(nd->s, " OR ");
+
+		if (alias) {
+			*alias = '\0';
+			alias += 4;
 		}
-		printf("  %-50s [%s]\n", nd->s, event_type_descriptors[type]);
+		print_cb->print_event(print_state,
+				/*topic=*/NULL,
+				/*pmu_name=*/NULL,
+				nd->s,
+				alias,
+				/*deprecated=*/false,
+				event_type_descriptors[type],
+				/*desc=*/NULL,
+				/*long_desc=*/NULL,
+				/*encoding_desc=*/NULL,
+				/*metric_name=*/NULL,
+				/*metric_expr=*/NULL);
 	}
-	if (!strlist__empty(evt_name_list) && pager_in_use())
-		printf("\n");
-
 	strlist__delete(evt_name_list);
 }
 
 /*
  * Print the help text for the event symbols:
  */
-void print_events(const char *event_glob, bool name_only, bool quiet_flag,
-			bool long_desc, bool details_flag, bool deprecated,
-			const char *pmu_name)
+void print_events(const struct print_callbacks *print_cb, void *print_state)
 {
-	print_symbol_events(event_glob, PERF_TYPE_HARDWARE,
-			    event_symbols_hw, PERF_COUNT_HW_MAX, name_only);
-
-	print_symbol_events(event_glob, PERF_TYPE_SOFTWARE,
-			    event_symbols_sw, PERF_COUNT_SW_MAX, name_only);
-	print_tool_events(event_glob, name_only);
-
-	print_hwcache_events(event_glob, name_only);
-
-	print_pmu_events(event_glob, name_only, quiet_flag, long_desc,
-			details_flag, deprecated, pmu_name);
-
-	if (event_glob != NULL)
-		return;
-
-	if (!name_only) {
-		printf("  %-50s [%s]\n",
-		       "rNNN",
-		       event_type_descriptors[PERF_TYPE_RAW]);
-		printf("  %-50s [%s]\n",
-		       "cpu/t1=v1[,t2=v2,t3 ...]/modifier",
-		       event_type_descriptors[PERF_TYPE_RAW]);
-		if (pager_in_use())
-			printf("   (see 'man perf-list' on how to encode it)\n\n");
-
-		printf("  %-50s [%s]\n",
-		       "mem:<addr>[/len][:access]",
-			event_type_descriptors[PERF_TYPE_BREAKPOINT]);
-		if (pager_in_use())
-			printf("\n");
-	}
-
-	print_tracepoint_events(NULL, NULL, name_only);
-
-	print_sdt_events(NULL, NULL, name_only);
-
-	metricgroup__print(true, true, NULL, name_only, details_flag,
-			   pmu_name);
-
-	print_libpfm_events(name_only, long_desc);
+	print_symbol_events(print_cb, print_state, PERF_TYPE_HARDWARE,
+			event_symbols_hw, PERF_COUNT_HW_MAX);
+	print_symbol_events(print_cb, print_state, PERF_TYPE_SOFTWARE,
+			event_symbols_sw, PERF_COUNT_SW_MAX);
+
+	print_tool_events(print_cb, print_state);
+
+	print_hwcache_events(print_cb, print_state);
+
+	print_pmu_events(print_cb, print_state);
+
+	print_cb->print_event(print_state,
+			/*topic=*/NULL,
+			/*pmu_name=*/NULL,
+			"rNNN",
+			/*event_alias=*/NULL,
+			/*deprecated=*/false,
+			event_type_descriptors[PERF_TYPE_RAW],
+			/*desc=*/NULL,
+			/*long_desc=*/NULL,
+			/*encoding_desc=*/NULL,
+			/*metric_name=*/NULL,
+			/*metric_expr=*/NULL);
+
+	print_cb->print_event(print_state,
+			/*topic=*/NULL,
+			/*pmu_name=*/NULL,
+			"cpu/t1=v1[,t2=v2,t3 ...]/modifier",
+			/*event_alias=*/NULL,
+			/*deprecated=*/false,
+			event_type_descriptors[PERF_TYPE_RAW],
+			"(see 'man perf-list' on how to encode it)",
+			/*long_desc=*/NULL,
+			/*encoding_desc=*/NULL,
+			/*metric_name=*/NULL,
+			/*metric_expr=*/NULL);
+
+	print_cb->print_event(print_state,
+			/*topic=*/NULL,
+			/*pmu_name=*/NULL,
+			"mem:<addr>[/len][:access]",
+			/*event_alias=*/NULL,
+			/*deprecated=*/false,
+			event_type_descriptors[PERF_TYPE_BREAKPOINT],
+			/*desc=*/NULL,
+			/*long_desc=*/NULL,
+			/*encoding_desc=*/NULL,
+			/*metric_name=*/NULL,
+			/*metric_expr=*/NULL);
+
+	print_tracepoint_events(print_cb, print_state);
+
+	print_sdt_events(print_cb, print_state);
+
+	metricgroup__print(print_cb, print_state);
+
+	print_libpfm_events(print_cb, print_state);
 }
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index 1da9910d83a6..235c3e123079 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -2,21 +2,37 @@
 #ifndef __PERF_PRINT_EVENTS_H
 #define __PERF_PRINT_EVENTS_H
 
+#include <linux/perf_event.h>
 #include <stdbool.h>
 
 struct event_symbol;
 
-void print_events(const char *event_glob, bool name_only, bool quiet_flag,
-		  bool long_desc, bool details_flag, bool deprecated,
-		  const char *pmu_name);
-int print_hwcache_events(const char *event_glob, bool name_only);
-void print_sdt_events(const char *subsys_glob, const char *event_glob,
-		      bool name_only);
-void print_symbol_events(const char *event_glob, unsigned int type,
-			 struct event_symbol *syms, unsigned int max,
-			 bool name_only);
-void print_tool_events(const char *event_glob, bool name_only);
-void print_tracepoint_events(const char *subsys_glob, const char *event_glob,
-			     bool name_only);
+struct print_callbacks {
+	void (*print_start)(void *print_state);
+	void (*print_end)(void *print_state);
+	void (*print_event)(void *print_state, const char *topic,
+			const char *pmu_name,
+			const char *event_name, const char *event_alias,
+			bool deprecated, const char *event_type_desc,
+			const char *desc, const char *long_desc,
+			const char *encoding_desc,
+			const char *metric_name, const char *metric_expr);
+	void (*print_metric)(void *print_state,
+			const char *group,
+			const char *name,
+			const char *desc,
+			const char *long_desc,
+			const char *expr);
+};
+
+/** Print all events, the default when no options are specified. */
+void print_events(const struct print_callbacks *print_cb, void *print_state);
+int print_hwcache_events(const struct print_callbacks *print_cb, void *print_state);
+void print_sdt_events(const struct print_callbacks *print_cb, void *print_state);
+void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
+			 unsigned int type, const struct event_symbol *syms,
+			 unsigned int max);
+void print_tool_events(const struct print_callbacks *print_cb, void *print_state);
+void print_tracepoint_events(const struct print_callbacks *print_cb, void *print_state);
 
 #endif /* __PERF_PRINT_EVENTS_H */
-- 
2.38.1.431.g37b22c650d-goog


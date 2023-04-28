Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87696F12AD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345740AbjD1HpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345615AbjD1Ho3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:44:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB1465AE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:43:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-555d93630e7so134809807b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667750; x=1685259750;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2y4q2qf1jE1jVFV1Y6Jg7+4CKbDyf3jlrprDWOHxkBA=;
        b=OxW0zrHKzawxemcdCAvziAdk88NOkxEnYTZm+WCm2Dciji8WQU7ygxa+wlfZI3/FRr
         WTHQGaK+1TSQGvYqlBBMO2b1dxrOVByE3sBAP0BGX65zBJbC8EmOIbZ15rYIK6kmLy/d
         +3oMSGgK1+3M4jDNYvgXWxlnx6rG1TO2TyQWuP52lIx5iAb6Dr/sM6/qbAtj7dkxLity
         kxtH+4ca5bRrMx3hBBOo6v7URQJciIRbWtth9vgPe6e7kLTTp4IdDpBmJ3c0K5YAEyQN
         +c3gLLkrU1NksvckKqiBwEgCvX3qKOOuFpnqbl8ocrmMKrqK72sOZ15LG2P31pGZFb6E
         bBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667750; x=1685259750;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2y4q2qf1jE1jVFV1Y6Jg7+4CKbDyf3jlrprDWOHxkBA=;
        b=bF7rF60kNCYOmyUfEzDB1UkUO2NxdrdflPZ8tkZfSKA84qyDYi+Fc8PevTa7dH4/cd
         ImIEPXB+a5v4LopNpqNMC9sZqPpl/ab8AZro8Pu4cLzGq1gIHM0lExxfoQZuHLpxxx1r
         bcFevg5H6JrYc/FXafPDijFFLNSvDMoOz681C+T46jdV3UUwNAZdawmQB1v1UxLGMD6b
         w0qf5wWLGMNJM01V7JV9ca9vx3DpPvJgHxz7k43WqW8Jog/OvE8NaRLRTqNPrn0q2kJp
         SdPDcjhkv6uM2BJxr3j6ppLKBnKoCiKVKElECA1cOJ7b4ZPTBnfy+6C5FRRgxRQeT/9W
         SjWQ==
X-Gm-Message-State: AC+VfDwl3oVJtDnGJezfHAqzyf7kqtlRaRPkyHKt+gzhlmlbTFH0hJ1A
        Jb0Sb8RI4A5DH/PCjRszamBlh/XADyKJ
X-Google-Smtp-Source: ACHHUZ7NeUNgvFmkko1XW8WxSgk/9tn6tFkKyo/5Rky9YqPHpn1PrwOcY7lcXiy6s2ct4mobdMC3OQuYq6e9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a81:c444:0:b0:552:abfa:1e77 with SMTP id
 s4-20020a81c444000000b00552abfa1e77mr2561788ywj.5.1682667750117; Fri, 28 Apr
 2023 00:42:30 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:37:55 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-30-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 29/43] perf stat: Make cputype filter generic
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than limit the --cputype argument for "perf list" and "perf
stat" to hybrid PMUs of just cpu_atom and cpu_core, allow any PMU.

Note, that if cpu_atom isn't mounted but a filter of cpu_atom is
requested, then this will now fail. As such a filter would never
succeed, no events can come from that unmounted PMU, then this
behavior could never have been useful and failing is clearer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c    | 19 +++++++++++--------
 tools/perf/builtin-stat.c    | 12 +++++++-----
 tools/perf/util/pmu-hybrid.c | 20 --------------------
 tools/perf/util/pmu-hybrid.h |  1 -
 tools/perf/util/pmus.c       | 25 ++++++++++++++++++++++++-
 tools/perf/util/pmus.h       |  3 +++
 6 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 1f5dbd5f0ba4..1b48cf214b6e 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -11,8 +11,8 @@
 #include "builtin.h"
 
 #include "util/print-events.h"
+#include "util/pmus.h"
 #include "util/pmu.h"
-#include "util/pmu-hybrid.h"
 #include "util/debug.h"
 #include "util/metricgroup.h"
 #include "util/string2.h"
@@ -429,7 +429,7 @@ int cmd_list(int argc, const char **argv)
 		.print_event = default_print_event,
 		.print_metric = default_print_metric,
 	};
-	const char *hybrid_name = NULL;
+	const char *cputype = NULL;
 	const char *unit_name = NULL;
 	bool json = false;
 	struct option list_options[] = {
@@ -443,8 +443,8 @@ int cmd_list(int argc, const char **argv)
 			    "Print information on the perf event names and expressions used internally by events."),
 		OPT_BOOLEAN(0, "deprecated", &default_ps.deprecated,
 			    "Print deprecated events."),
-		OPT_STRING(0, "cputype", &hybrid_name, "hybrid cpu type",
-			   "Limit PMU or metric printing to the given hybrid PMU (e.g. core or atom)."),
+		OPT_STRING(0, "cputype", &cputype, "cpu type",
+			   "Limit PMU or metric printing to the given PMU (e.g. cpu, core or atom)."),
 		OPT_STRING(0, "unit", &unit_name, "PMU name",
 			   "Limit PMU or metric printing to the specified PMU."),
 		OPT_INCR(0, "debug", &verbose,
@@ -484,10 +484,13 @@ int cmd_list(int argc, const char **argv)
 		assert(default_ps.visited_metrics);
 		if (unit_name)
 			default_ps.pmu_glob = strdup(unit_name);
-		else if (hybrid_name) {
-			default_ps.pmu_glob = perf_pmu__hybrid_type_to_pmu(hybrid_name);
-			if (!default_ps.pmu_glob)
-				pr_warning("WARNING: hybrid cputype is not supported!\n");
+		else if (cputype) {
+			const struct perf_pmu *pmu = perf_pmus__pmu_for_pmu_filter(cputype);
+
+			if (!pmu)
+				pr_warning("WARNING: cputype is not supported!\n");
+
+			default_ps.pmu_glob = pmu->name;
 		}
 	}
 	print_cb.print_start(ps);
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3b25fcab5cd1..06a1d71a49a5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -44,6 +44,7 @@
 #include "util/cgroup.h"
 #include <subcmd/parse-options.h>
 #include "util/parse-events.h"
+#include "util/pmus.h"
 #include "util/pmu.h"
 #include "util/event.h"
 #include "util/evlist.h"
@@ -69,7 +70,6 @@
 #include "util/pfm.h"
 #include "util/bpf_counter.h"
 #include "util/iostat.h"
-#include "util/pmu-hybrid.h"
 #include "util/util.h"
 #include "asm/bug.h"
 
@@ -1089,10 +1089,11 @@ static int parse_stat_cgroups(const struct option *opt,
 	return parse_cgroups(opt, str, unset);
 }
 
-static int parse_hybrid_type(const struct option *opt,
+static int parse_cputype(const struct option *opt,
 			     const char *str,
 			     int unset __maybe_unused)
 {
+	const struct perf_pmu *pmu;
 	struct evlist *evlist = *(struct evlist **)opt->value;
 
 	if (!list_empty(&evlist->core.entries)) {
@@ -1100,11 +1101,12 @@ static int parse_hybrid_type(const struct option *opt,
 		return -1;
 	}
 
-	parse_events_option_args.pmu_filter = perf_pmu__hybrid_type_to_pmu(str);
-	if (!parse_events_option_args.pmu_filter) {
+	pmu = perf_pmus__pmu_for_pmu_filter(str);
+	if (!pmu) {
 		fprintf(stderr, "--cputype %s is not supported!\n", str);
 		return -1;
 	}
+	parse_events_option_args.pmu_filter = pmu->name;
 
 	return 0;
 }
@@ -1230,7 +1232,7 @@ static struct option stat_options[] = {
 	OPT_CALLBACK(0, "cputype", &evsel_list, "hybrid cpu type",
 		     "Only enable events on applying cpu with this type "
 		     "for hybrid platform (e.g. core or atom)",
-		     parse_hybrid_type),
+		     parse_cputype),
 #ifdef HAVE_LIBPFM
 	OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
 		"libpfm4 event selector. use 'perf list' to list available events",
diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
index 38628805a952..bc4cb0738c35 100644
--- a/tools/perf/util/pmu-hybrid.c
+++ b/tools/perf/util/pmu-hybrid.c
@@ -50,23 +50,3 @@ bool perf_pmu__is_hybrid(const char *name)
 {
 	return perf_pmu__find_hybrid_pmu(name) != NULL;
 }
-
-char *perf_pmu__hybrid_type_to_pmu(const char *type)
-{
-	char *pmu_name = NULL;
-
-	if (asprintf(&pmu_name, "cpu_%s", type) < 0)
-		return NULL;
-
-	if (perf_pmu__is_hybrid(pmu_name))
-		return pmu_name;
-
-	/*
-	 * pmu may be not scanned, check the sysfs.
-	 */
-	if (perf_pmu__hybrid_mounted(pmu_name))
-		return pmu_name;
-
-	free(pmu_name);
-	return NULL;
-}
diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybrid.h
index 2b186c26a43e..206b94931531 100644
--- a/tools/perf/util/pmu-hybrid.h
+++ b/tools/perf/util/pmu-hybrid.h
@@ -17,7 +17,6 @@ bool perf_pmu__hybrid_mounted(const char *name);
 
 struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name);
 bool perf_pmu__is_hybrid(const char *name);
-char *perf_pmu__hybrid_type_to_pmu(const char *type);
 
 static inline int perf_pmu__hybrid_pmu_num(void)
 {
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 7f3b93c4d229..140e11f00b29 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -1,5 +1,28 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/list.h>
-#include <pmus.h>
+#include <string.h>
+#include "pmus.h"
+#include "pmu.h"
 
 LIST_HEAD(pmus);
+
+const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
+{
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (!strcmp(pmu->name, str))
+			return pmu;
+		/* Ignore "uncore_" prefix. */
+		if (!strncmp(pmu->name, "uncore_", 7)) {
+			if (!strcmp(pmu->name + 7, str))
+				return pmu;
+		}
+		/* Ignore "cpu_" prefix on Intel hybrid PMUs. */
+		if (!strncmp(pmu->name, "cpu_", 4)) {
+			if (!strcmp(pmu->name + 4, str))
+				return pmu;
+		}
+	}
+	return NULL;
+}
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 5ec12007eb5c..d475e2960c10 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -3,7 +3,10 @@
 #define __PMUS_H
 
 extern struct list_head pmus;
+struct perf_pmu;
 
 #define perf_pmus__for_each_pmu(pmu) list_for_each_entry(pmu, &pmus, list)
 
+const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
+
 #endif /* __PMUS_H */
-- 
2.40.1.495.gc816e09b53d-goog


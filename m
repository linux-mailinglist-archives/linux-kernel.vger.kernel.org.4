Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93DC69BFC0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjBSJjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjBSJio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:38:44 -0500
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014E77ECD
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:37:47 -0800 (PST)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-53688fe539aso16853857b3.16
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWY19TSQgERdPbwErlbK0jtYxZSrTa14TWowXdbFFqA=;
        b=BCodiPm0UhrFbNnkmEiSM+MMtwfNo/m14XrQ3eMr4N7XoB1C0uGhfU8Ydpwlimt4q1
         PuZZluxQHIbtmW6GfZhwXyfvEEXJT1NZIsqObL68eINAqv9QwPI8uriBzqRT6OA0pB/6
         55DiiPo5KIVtWFlyjRYm4j9EQyviVMIfz03smYySOvvhY3imVAl+LL/03rNQZhxR4sC6
         FGdD+dvjr2vBC+9GKA+jKvuky1Yjs7Skzt6JTDcow7vOCHE8Gj3+KCnz+O6YCfuk7vp+
         L8FxI4VmvLraC2PA3Lz+qIyB6qVm8XjqNMNsd34o6RbgdCnZ8/aNtpS8kf8U7rOnHvV2
         doSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWY19TSQgERdPbwErlbK0jtYxZSrTa14TWowXdbFFqA=;
        b=IbubO3fDHMYXL1leAUahnwLrbqfQe2QxXVoy/jrcQWcNWzBG/m0kMs2WNsp/U/rdZR
         WBE0xxKosB+S9upb2ZtgcX6zM+8M9IBjYSevfDwPZf/9l5NFdQCrMxHfX97I5Q7EVcHo
         opXPFKLTLXTmMA5YkaFQDOF1/EaYcb9UcWFal0ITjdzzO5vZJ9Udh9w91PK65UxXnb0T
         MoAKj7V+taSxPaokKpAGOvlRrv+aOMQGNGQhsXHrUq4PWfG1QiICuR3v+ec3O59cAeIq
         g3wFY8hBgITXOJWHwlDnHwPyi5+0+XpbK8cZbVRUQlJUjMnK/wJIb06TQSPVyxew0Hwk
         AqgQ==
X-Gm-Message-State: AO0yUKUe8xxNCqptNUPPBZdQWjkXptnLNAvFLtNG4+MHij5T6XpdJRuA
        Jw2OPaxA0ho4vCnF7KejFNMp29hUGPmm
X-Google-Smtp-Source: AK7set9rJva9cLeQxanZ5aFkET6PRwbTcv5V3a0Htm36Z4OUpqspmPMNqBYJp+IqcMCZOY76ucCNTGru1uy4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a0d:f681:0:b0:52f:bc0:2164 with SMTP id
 g123-20020a0df681000000b0052f0bc02164mr1795352ywf.472.1676799276576; Sun, 19
 Feb 2023 01:34:36 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:37 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-41-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 40/51] perf stat: Implement --topdown using json metrics
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Request the topdown metric group of a level with the metrics in the
group 'TopdownL<level>' rather than through specific events. As more
topdown levels are supported this way, such as 6 on Intel Ice Lake,
default to just showing the level 1 metrics. This can be overridden
using '--td-level'. Rather than determine the maximum topdown level
from sysfs, use the metric group names. Remove some now unused topdown
code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/topdown.c |  48 +-----------
 tools/perf/builtin-stat.c          | 118 +++++------------------------
 tools/perf/util/metricgroup.c      |  31 ++++++++
 tools/perf/util/metricgroup.h      |   1 +
 tools/perf/util/topdown.c          |  68 +----------------
 tools/perf/util/topdown.h          |  11 +--
 6 files changed, 58 insertions(+), 219 deletions(-)

diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index eb3a7d9652ab..9ad5e5c7bd27 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -1,11 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
 #include "api/fs/fs.h"
+#include "util/evsel.h"
 #include "util/pmu.h"
 #include "util/topdown.h"
-#include "util/evlist.h"
-#include "util/debug.h"
-#include "util/pmu-hybrid.h"
 #include "topdown.h"
 #include "evsel.h"
 
@@ -33,30 +30,6 @@ bool topdown_sys_has_perf_metrics(void)
 	return has_perf_metrics;
 }
 
-/*
- * Check whether we can use a group for top down.
- * Without a group may get bad results due to multiplexing.
- */
-bool arch_topdown_check_group(bool *warn)
-{
-	int n;
-
-	if (sysctl__read_int("kernel/nmi_watchdog", &n) < 0)
-		return false;
-	if (n > 0) {
-		*warn = true;
-		return false;
-	}
-	return true;
-}
-
-void arch_topdown_group_warn(void)
-{
-	fprintf(stderr,
-		"nmi_watchdog enabled with topdown. May give wrong results.\n"
-		"Disable with echo 0 > /proc/sys/kernel/nmi_watchdog\n");
-}
-
 #define TOPDOWN_SLOTS		0x0400
 
 /*
@@ -65,7 +38,6 @@ void arch_topdown_group_warn(void)
  * Only Topdown metric supports sample-read. The slots
  * event must be the leader of the topdown group.
  */
-
 bool arch_topdown_sample_read(struct evsel *leader)
 {
 	if (!evsel__sys_has_perf_metrics(leader))
@@ -76,21 +48,3 @@ bool arch_topdown_sample_read(struct evsel *leader)
 
 	return false;
 }
-
-const char *arch_get_topdown_pmu_name(struct evlist *evlist, bool warn)
-{
-	const char *pmu_name;
-
-	if (!perf_pmu__has_hybrid())
-		return "cpu";
-
-	if (!evlist->hybrid_pmu_name) {
-		if (warn)
-			pr_warning("WARNING: default to use cpu_core topdown events\n");
-		evlist->hybrid_pmu_name = perf_pmu__hybrid_type_to_pmu("core");
-	}
-
-	pmu_name = evlist->hybrid_pmu_name;
-
-	return pmu_name;
-}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 796e98e453f6..bdb1ef4fc6ad 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -124,39 +124,6 @@ static const char * transaction_limited_attrs = {
 	"}"
 };
 
-static const char * topdown_attrs[] = {
-	"topdown-total-slots",
-	"topdown-slots-retired",
-	"topdown-recovery-bubbles",
-	"topdown-fetch-bubbles",
-	"topdown-slots-issued",
-	NULL,
-};
-
-static const char *topdown_metric_attrs[] = {
-	"slots",
-	"topdown-retiring",
-	"topdown-bad-spec",
-	"topdown-fe-bound",
-	"topdown-be-bound",
-	NULL,
-};
-
-static const char *topdown_metric_L2_attrs[] = {
-	"slots",
-	"topdown-retiring",
-	"topdown-bad-spec",
-	"topdown-fe-bound",
-	"topdown-be-bound",
-	"topdown-heavy-ops",
-	"topdown-br-mispredict",
-	"topdown-fetch-lat",
-	"topdown-mem-bound",
-	NULL,
-};
-
-#define TOPDOWN_MAX_LEVEL			2
-
 static const char *smi_cost_attrs = {
 	"{"
 	"msr/aperf/,"
@@ -1914,86 +1881,41 @@ static int add_default_attributes(void)
 	}
 
 	if (topdown_run) {
-		const char **metric_attrs = topdown_metric_attrs;
-		unsigned int max_level = 1;
-		char *str = NULL;
-		bool warn = false;
-		const char *pmu_name = arch_get_topdown_pmu_name(evsel_list, true);
+		unsigned int max_level = metricgroups__topdown_max_level();
+		char str[] = "TopdownL1";
 
 		if (!force_metric_only)
 			stat_config.metric_only = true;
 
-		if (pmu_have_event(pmu_name, topdown_metric_L2_attrs[5])) {
-			metric_attrs = topdown_metric_L2_attrs;
-			max_level = 2;
+		if (!max_level) {
+			pr_err("Topdown requested but the topdown metric groups aren't present.\n"
+				"(See perf list the metric groups have names like TopdownL1)");
+			return -1;
 		}
-
 		if (stat_config.topdown_level > max_level) {
 			pr_err("Invalid top-down metrics level. The max level is %u.\n", max_level);
 			return -1;
 		} else if (!stat_config.topdown_level)
-			stat_config.topdown_level = max_level;
+			stat_config.topdown_level = 1;
 
-		if (topdown_filter_events(metric_attrs, &str, 1, pmu_name) < 0) {
-			pr_err("Out of memory\n");
-			return -1;
-		}
-
-		if (metric_attrs[0] && str) {
-			if (!stat_config.interval && !stat_config.metric_only) {
-				fprintf(stat_config.output,
-					"Topdown accuracy may decrease when measuring long periods.\n"
-					"Please print the result regularly, e.g. -I1000\n");
-			}
-			goto setup_metrics;
-		}
-
-		zfree(&str);
-
-		if (stat_config.aggr_mode != AGGR_GLOBAL &&
-		    stat_config.aggr_mode != AGGR_CORE) {
-			pr_err("top down event configuration requires --per-core mode\n");
-			return -1;
-		}
-		stat_config.aggr_mode = AGGR_CORE;
-		if (nr_cgroups || !target__has_cpu(&target)) {
-			pr_err("top down event configuration requires system-wide mode (-a)\n");
-			return -1;
-		}
-
-		if (topdown_filter_events(topdown_attrs, &str,
-				arch_topdown_check_group(&warn),
-				pmu_name) < 0) {
-			pr_err("Out of memory\n");
-			return -1;
+		if (!stat_config.interval && !stat_config.metric_only) {
+			fprintf(stat_config.output,
+				"Topdown accuracy may decrease when measuring long periods.\n"
+				"Please print the result regularly, e.g. -I1000\n");
 		}
-
-		if (topdown_attrs[0] && str) {
-			struct parse_events_error errinfo;
-			if (warn)
-				arch_topdown_group_warn();
-setup_metrics:
-			parse_events_error__init(&errinfo);
-			err = parse_events(evsel_list, str, &errinfo);
-			if (err) {
-				fprintf(stderr,
-					"Cannot set up top down events %s: %d\n",
-					str, err);
-				parse_events_error__print(&errinfo, str);
-				parse_events_error__exit(&errinfo);
-				free(str);
-				return -1;
-			}
-			parse_events_error__exit(&errinfo);
-		} else {
-			fprintf(stderr, "System does not support topdown\n");
+		str[8] = stat_config.topdown_level + '0';
+		if (metricgroup__parse_groups(evsel_list, str,
+						/*metric_no_group=*/false,
+						/*metric_no_merge=*/false,
+						/*metric_no_threshold=*/true,
+						stat_config.user_requested_cpu_list,
+						stat_config.system_wide,
+						&stat_config.metric_events) < 0)
 			return -1;
-		}
-		free(str);
 	}
 
 	if (!stat_config.topdown_level)
-		stat_config.topdown_level = TOPDOWN_MAX_LEVEL;
+		stat_config.topdown_level = 1;
 
 	if (!evsel_list->core.nr_entries) {
 		/* No events so add defaults. */
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 64a35f2787dc..de6dd527a2ba 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1665,6 +1665,37 @@ bool metricgroup__has_metric(const char *metric)
 						(void *)metric) ? true : false;
 }
 
+static int metricgroup__topdown_max_level_callback(const struct pmu_metric *pm,
+					    const struct pmu_metrics_table *table __maybe_unused,
+					    void *data)
+{
+	unsigned int *max_level = data;
+	unsigned int level;
+	const char *p = strstr(pm->metric_group, "TopdownL");
+
+	if (!p || p[8] == '\0')
+		return 0;
+
+	level = p[8] - '0';
+	if (level > *max_level)
+		*max_level = level;
+
+	return 0;
+}
+
+unsigned int metricgroups__topdown_max_level(void)
+{
+	unsigned int max_level = 0;
+	const struct pmu_metrics_table *table = pmu_metrics_table__find();
+
+	if (!table)
+		return false;
+
+	pmu_metrics_table_for_each_metric(table, metricgroup__topdown_max_level_callback,
+					  &max_level);
+	return max_level;
+}
+
 int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 				    struct rblist *new_metric_events,
 				    struct rblist *old_metric_events)
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 8d50052c5b4c..77472e35705e 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -81,6 +81,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 
 void metricgroup__print(const struct print_callbacks *print_cb, void *print_state);
 bool metricgroup__has_metric(const char *metric);
+unsigned int metricgroups__topdown_max_level(void);
 int arch_get_runtimeparam(const struct pmu_metric *pm);
 void metricgroup__rblist_exit(struct rblist *metric_events);
 
diff --git a/tools/perf/util/topdown.c b/tools/perf/util/topdown.c
index 1090841550f7..18fd5fed5d1a 100644
--- a/tools/perf/util/topdown.c
+++ b/tools/perf/util/topdown.c
@@ -1,74 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include "pmu.h"
-#include "pmu-hybrid.h"
 #include "topdown.h"
-
-int topdown_filter_events(const char **attr, char **str, bool use_group,
-			  const char *pmu_name)
-{
-	int off = 0;
-	int i;
-	int len = 0;
-	char *s;
-	bool is_hybrid = perf_pmu__is_hybrid(pmu_name);
-
-	for (i = 0; attr[i]; i++) {
-		if (pmu_have_event(pmu_name, attr[i])) {
-			if (is_hybrid)
-				len += strlen(attr[i]) + strlen(pmu_name) + 3;
-			else
-				len += strlen(attr[i]) + 1;
-			attr[i - off] = attr[i];
-		} else
-			off++;
-	}
-	attr[i - off] = NULL;
-
-	*str = malloc(len + 1 + 2);
-	if (!*str)
-		return -1;
-	s = *str;
-	if (i - off == 0) {
-		*s = 0;
-		return 0;
-	}
-	if (use_group)
-		*s++ = '{';
-	for (i = 0; attr[i]; i++) {
-		if (!is_hybrid)
-			strcpy(s, attr[i]);
-		else
-			sprintf(s, "%s/%s/", pmu_name, attr[i]);
-		s += strlen(s);
-		*s++ = ',';
-	}
-	if (use_group) {
-		s[-1] = '}';
-		*s = 0;
-	} else
-		s[-1] = 0;
-	return 0;
-}
-
-__weak bool arch_topdown_check_group(bool *warn)
-{
-	*warn = false;
-	return false;
-}
-
-__weak void arch_topdown_group_warn(void)
-{
-}
+#include <linux/kernel.h>
 
 __weak bool arch_topdown_sample_read(struct evsel *leader __maybe_unused)
 {
 	return false;
 }
-
-__weak const char *arch_get_topdown_pmu_name(struct evlist *evlist
-					     __maybe_unused,
-					     bool warn __maybe_unused)
-{
-	return "cpu";
-}
diff --git a/tools/perf/util/topdown.h b/tools/perf/util/topdown.h
index f9531528c559..1996c5fedcd7 100644
--- a/tools/perf/util/topdown.h
+++ b/tools/perf/util/topdown.h
@@ -1,14 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef TOPDOWN_H
 #define TOPDOWN_H 1
-#include "evsel.h"
-#include "evlist.h"
 
-bool arch_topdown_check_group(bool *warn);
-void arch_topdown_group_warn(void);
+#include <stdbool.h>
+
+struct evsel;
+
 bool arch_topdown_sample_read(struct evsel *leader);
-const char *arch_get_topdown_pmu_name(struct evlist *evlist, bool warn);
-int topdown_filter_events(const char **attr, char **str, bool use_group,
-			  const char *pmu_name);
 
 #endif
-- 
2.39.2.637.g21b0678d19-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9F067C241
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 02:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbjAZBUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 20:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbjAZBUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 20:20:03 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29B565ECA
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:19:46 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 2-20020a250b02000000b0080b9a77383fso308781ybl.22
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZE9RIC7RyAmkUhdpIM/73Cg+F1xdulHeeW/50qQvxg=;
        b=T9dqkcpOGmQYjNjO3zs7fWbeZ5UKZMDK+0oYbR4xoKmTcaqkO64Y/m3Eql3G1t7knl
         COKHbWtjdmqI/HAoK9kG0jEsctbCqdy/bGY4fBNdLSZmAFG+bKDYSW89B1NGtM89ZO7u
         dniZavSNjMyXekTA0y/iYXHblUlnMl+WkQ/XG3YZFsR0b9Ov7AalTBdm27WkwQU+D26q
         SU9trgw4qq+CWplmG1zXASsItwi5V2rrVLiN8w11kvOjxLc/xZr0z++xweMdRuIXlwcg
         09c/RVJcK1J7tvDiw5GdwV1C/c9P0dVxa8G2PHap/M8ZMFw14fMiDO1uBlxQIpSKb3FQ
         D+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZE9RIC7RyAmkUhdpIM/73Cg+F1xdulHeeW/50qQvxg=;
        b=X/qBsAUbvXAkr6WT+9T1Tc/IArzKNghNQXQkFDreqUU0Octu/DjHJaNMZjYpiT3U9k
         A10vIPEAqz0Efq3R43dzQM65AimW1vX39Km4krz9udEHFTiGLXskinrc4p5rEgl0i56b
         CXn2GyKzYC/xBm25MjcUgERquht/8QJdnAv6NZFnsLtQ7iPoLQUu/1GdbTcdRKfCKL0m
         DDz7hys7KBrluDxJ4uTyYQcvKXr3YZL5POBpebPsyQrn1JolRaf8oPIky7rEvCXSzh+v
         RB25dZnZGL2ylLKNBrWarMGRMfEb4AEC9T/QzKagPvVdj9sMJ6pj2PwxvRWl6ghO3mPM
         55wQ==
X-Gm-Message-State: AFqh2krV8BTzwO314vqea6saA5+3Y+CepDGlajydhZeJ69X1MqHgB67I
        UJ1B14Sg3fNshZKdJVEpUFQmA8DNweYh
X-Google-Smtp-Source: AMrXdXsMUZOqBWecBMHGtFCKQpBS2mPiPRZXdyAstRgv3Wj8cgn4svftkv50YULmV0dFxfb7Wv9dcRNGh/DQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:568d:4d98:b468:b025])
 (user=irogers job=sendgmr) by 2002:a25:9291:0:b0:799:6d5f:d851 with SMTP id
 y17-20020a259291000000b007996d5fd851mr4340401ybl.537.1674695986150; Wed, 25
 Jan 2023 17:19:46 -0800 (PST)
Date:   Wed, 25 Jan 2023 17:18:47 -0800
In-Reply-To: <20230126011854.198243-1-irogers@google.com>
Message-Id: <20230126011854.198243-6-irogers@google.com>
Mime-Version: 1.0
References: <20230126011854.198243-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v4 05/12] perf pmu-events: Separate the metrics from events
 for no jevents
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
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

Separate the event and metric table when building without jevents. Add
find_core_metrics_table and perf_pmu__find_metrics_table while
renaming existing utilities to be event specific, so that users can
find the right table for their need.

Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 88 ++++++++++++++++++------
 tools/perf/pmu-events/jevents.py         |  7 +-
 tools/perf/pmu-events/pmu-events.h       |  4 +-
 tools/perf/tests/expand-cgroup.c         |  2 +-
 tools/perf/tests/parse-metric.c          |  2 +-
 tools/perf/util/pmu.c                    |  4 +-
 6 files changed, 79 insertions(+), 28 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 4e39d1a8d6d6..10bd4943ebf8 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -11,7 +11,7 @@
 #include <string.h>
 #include <stddef.h>
 
-static const struct pmu_event pme_test_soc_cpu[] = {
+static const struct pmu_event pmu_events__test_soc_cpu[] = {
 	{
 		.name = "l3_cache_rd",
 		.event = "event=0x40",
@@ -105,6 +105,14 @@ static const struct pmu_event pme_test_soc_cpu[] = {
 		.desc = "L2 BTB Correction",
 		.topic = "branch",
 	},
+	{
+		.name = 0,
+		.event = 0,
+		.desc = 0,
+	},
+};
+
+static const struct pmu_metric pmu_metrics__test_soc_cpu[] = {
 	{
 		.metric_expr	= "1 / IPC",
 		.metric_name	= "CPI",
@@ -170,9 +178,8 @@ static const struct pmu_event pme_test_soc_cpu[] = {
 		.metric_name	= "L1D_Cache_Fill_BW",
 	},
 	{
-		.name = 0,
-		.event = 0,
-		.desc = 0,
+		.metric_expr = 0,
+		.metric_name = 0,
 	},
 };
 
@@ -197,7 +204,8 @@ struct pmu_metrics_table {
 struct pmu_events_map {
 	const char *arch;
 	const char *cpuid;
-	const struct pmu_events_table table;
+	const struct pmu_events_table event_table;
+	const struct pmu_metrics_table metric_table;
 };
 
 /*
@@ -208,12 +216,14 @@ static const struct pmu_events_map pmu_events_map[] = {
 	{
 		.arch = "testarch",
 		.cpuid = "testcpu",
-		.table = { pme_test_soc_cpu },
+		.event_table = { pmu_events__test_soc_cpu },
+		.metric_table = { pmu_metrics__test_soc_cpu },
 	},
 	{
 		.arch = 0,
 		.cpuid = 0,
-		.table = { 0 },
+		.event_table = { 0 },
+		.metric_table = { 0 },
 	},
 };
 
@@ -259,12 +269,9 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
 int pmu_events_table_for_each_event(const struct pmu_events_table *table, pmu_event_iter_fn fn,
 				    void *data)
 {
-	for (const struct pmu_event *pe = &table->entries[0]; pe->name || pe->metric_expr; pe++) {
-		int ret;
+	for (const struct pmu_event *pe = &table->entries[0]; pe->name; pe++) {
+		int ret = fn(pe, table, data);
 
-		if (!pe->name)
-			continue;
-		ret = fn(pe, table, data);
 		if (ret)
 			return ret;
 	}
@@ -276,19 +283,44 @@ int pmu_events_table_for_each_metric(const struct pmu_events_table *etable, pmu_
 {
 	struct pmu_metrics_table *table = (struct pmu_metrics_table *)etable;
 
-	for (const struct pmu_metric *pm = &table->entries[0]; pm->name || pm->metric_expr; pm++) {
-		int ret;
+	for (const struct pmu_metric *pm = &table->entries[0]; pm->metric_expr; pm++) {
+		int ret = fn(pm, etable, data);
 
-		if (!pm->metric_expr)
-			continue;
-		ret = fn(pm, etable, data);
 		if (ret)
 			return ret;
 	}
 	return 0;
 }
 
-const struct pmu_events_table *perf_pmu__find_table(struct perf_pmu *pmu)
+const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
+{
+	const struct pmu_events_table *table = NULL;
+	char *cpuid = perf_pmu__getcpuid(pmu);
+	int i;
+
+	/* on some platforms which uses cpus map, cpuid can be NULL for
+	 * PMUs other than CORE PMUs.
+	 */
+	if (!cpuid)
+		return NULL;
+
+	i = 0;
+	for (;;) {
+		const struct pmu_events_map *map = &pmu_events_map[i++];
+
+		if (!map->cpuid)
+			break;
+
+		if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
+			table = &map->event_table;
+			break;
+		}
+	}
+	free(cpuid);
+	return table;
+}
+
+const struct pmu_events_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu)
 {
 	const struct pmu_events_table *table = NULL;
 	char *cpuid = perf_pmu__getcpuid(pmu);
@@ -308,7 +340,7 @@ const struct pmu_events_table *perf_pmu__find_table(struct perf_pmu *pmu)
 			break;
 
 		if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
-			table = &map->table;
+			table = (const struct pmu_events_table *)&map->metric_table;
 			break;
 		}
 	}
@@ -322,7 +354,18 @@ const struct pmu_events_table *find_core_events_table(const char *arch, const ch
 	     tables->arch;
 	     tables++) {
 		if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpuid))
-			return &tables->table;
+			return &tables->event_table;
+	}
+	return NULL;
+}
+
+const struct pmu_events_table *find_core_metrics_table(const char *arch, const char *cpuid)
+{
+	for (const struct pmu_events_map *tables = &pmu_events_map[0];
+	     tables->arch;
+	     tables++) {
+		if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpuid))
+			return (const struct pmu_events_table *)&tables->metric_table;
 	}
 	return NULL;
 }
@@ -330,7 +373,7 @@ const struct pmu_events_table *find_core_events_table(const char *arch, const ch
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
 {
 	for (const struct pmu_events_map *tables = &pmu_events_map[0]; tables->arch; tables++) {
-		int ret = pmu_events_table_for_each_event(&tables->table, fn, data);
+		int ret = pmu_events_table_for_each_event(&tables->event_table, fn, data);
 
 		if (ret)
 			return ret;
@@ -343,7 +386,8 @@ int pmu_for_each_core_metric(pmu_metric_iter_fn fn, void *data)
 	for (const struct pmu_events_map *tables = &pmu_events_map[0];
 	     tables->arch;
 	     tables++) {
-		int ret = pmu_events_table_for_each_metric(&tables->table, fn, data);
+		int ret = pmu_events_table_for_each_metric(
+			(const struct pmu_events_table *)&tables->metric_table, fn, data);
 
 		if (ret)
 			return ret;
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 858787a12302..8df14ab14fcf 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -625,7 +625,7 @@ int pmu_events_table_for_each_metric(const struct pmu_events_table *table,
         return 0;
 }
 
-const struct pmu_events_table *perf_pmu__find_table(struct perf_pmu *pmu)
+const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
 {
         const struct pmu_events_table *table = NULL;
         char *cpuid = perf_pmu__getcpuid(pmu);
@@ -663,6 +663,11 @@ const struct pmu_events_table *find_core_events_table(const char *arch, const ch
         return NULL;
 }
 
+const struct pmu_events_table *find_core_metrics_table(const char *arch, const char *cpuid)
+{
+        return (struct pmu_events_table *)find_core_events_table(arch, cpuid);
+}
+
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
 {
         for (const struct pmu_events_map *tables = &pmu_events_map[0];
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 45c0f508af23..e2cd3e61acef 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -63,8 +63,10 @@ int pmu_events_table_for_each_event(const struct pmu_events_table *table, pmu_ev
 int pmu_events_table_for_each_metric(const struct pmu_events_table *table, pmu_metric_iter_fn fn,
 				     void *data);
 
-const struct pmu_events_table *perf_pmu__find_table(struct perf_pmu *pmu);
+const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu);
+const struct pmu_events_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu);
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid);
+const struct pmu_events_table *find_core_metrics_table(const char *arch, const char *cpuid);
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data);
 int pmu_for_each_core_metric(pmu_metric_iter_fn fn, void *data);
 
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index 51fb5f34c1dd..4f3195b84463 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -186,7 +186,7 @@ static int expand_metric_events(void)
 	TEST_ASSERT_VAL("failed to get evlist", evlist);
 
 	rblist__init(&metric_events);
-	pme_test = find_core_events_table("testarch", "testcpu");
+	pme_test = find_core_metrics_table("testarch", "testcpu");
 	ret = metricgroup__parse_groups_test(evlist, pme_test, metric_str,
 					     false, false, &metric_events);
 	if (ret < 0) {
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 21b7ac00d798..6c527cd805fe 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -96,7 +96,7 @@ static int __compute_metric(const char *name, struct value *vals,
 	runtime_stat__init(&st);
 
 	/* Parse the metric into metric_events list. */
-	pme_test = find_core_events_table("testarch", "testcpu");
+	pme_test = find_core_metrics_table("testarch", "testcpu");
 	err = metricgroup__parse_groups_test(evlist, pme_test, name,
 					     false, false,
 					     &metric_events);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8abf5b8439a7..3a67b17b4a16 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -663,7 +663,7 @@ char *perf_pmu__getcpuid(struct perf_pmu *pmu)
 
 __weak const struct pmu_events_table *pmu_events_table__find(void)
 {
-	return perf_pmu__find_table(NULL);
+	return perf_pmu__find_events_table(NULL);
 }
 
 /*
@@ -794,7 +794,7 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 {
 	const struct pmu_events_table *table;
 
-	table = perf_pmu__find_table(pmu);
+	table = perf_pmu__find_events_table(pmu);
 	if (!table)
 		return;
 
-- 
2.39.1.456.gfc5497dd1b-goog


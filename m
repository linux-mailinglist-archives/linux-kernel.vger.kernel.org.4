Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC5969BFBD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjBSJiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjBSJiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:38:11 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D9012BE1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:37:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o14-20020a25730e000000b009419f64f6afso2226981ybc.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W35JnUyB9F6OBcA0PUDeFeV51mTDn0RBQpIJeigYK+U=;
        b=CmrQbZnohetBBAm9AiARnIjs80kPdkPczowAQqWob0gZ6l+Q70jedRKRcgTRMb6G8g
         qqMY0EQyJw3Wdgz1zX44m5fF3RbqjAwLQ8Mo0f9BU2Y5tH3Gls7Zi6Q2VpaFmzbrmXvF
         rc2hfAh8O6ceIE+qMSb0k0OQgqBDHHxKjKvpWipx9nIy65oL1Innd1aqUQRbD4FZyiYj
         WjYBvrf5VpkaiQmHJXnnYZt8HcDNBshmDfHqUcQILbHwDomIGn7WkF2vAkx4Zzm1hfFp
         eL6kz2f6MqFwiqIpuWGBPltCloj1hmjmiMxkXwiVnXR0xbusmve7xv4RhJaxWkN+cwbv
         wyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W35JnUyB9F6OBcA0PUDeFeV51mTDn0RBQpIJeigYK+U=;
        b=MUlX4g+8Y9ubpoxJMwxa1Fb7HQY+84M6GJT/GSErpr+j00VxyXSaKcAVp41cxQP5ze
         uec2sbhpAYoLwCpKe8Q6ebYVnApWYg/8Q5iW/HHa4x07wwL3YgDVVeXR+C8WClemQvuO
         ojDBmHqmFVeDMezKJa6kc9/QrvD1XwAFmjSYVA2f6r4m/CIQ0ONlMKDi5grgBOma6pRl
         iWHTMLJN2z7Dw8M1uU2tdzIHF6u7sIsYoxFanFlDJ2WVgL4Dikq3QcbuTM8J3QgXPtLT
         ryCBrvsvTsw7gNy8HT6fSgboC9FFCgpN2oM9X606gtTgUjs90G1IOO8k6s6uEYDC7pWT
         BzhA==
X-Gm-Message-State: AO0yUKW/XsjZ8rOG9ybRhz6armyiHPsrMyRx0QJQ1aOpisCTsywmxql3
        GwM6whfGCMnbo4nQ1PDmub4NOusnABi4
X-Google-Smtp-Source: AK7set+LAVl/3qKBN/ZScFuuk6zKLCv0PTqAm1ZptFybknFuRlkBFKQ8eTtWXFEq5dad/Qo9ajwEObEdHBXg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a81:6c97:0:b0:52e:df8d:45f4 with SMTP id
 h145-20020a816c97000000b0052edf8d45f4mr2294792ywc.218.1676799336588; Sun, 19
 Feb 2023 01:35:36 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:44 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-48-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 47/51] perf stat: Hide runtime_stat
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

runtime_stat is only shared for the sake of tests that don't care
about its value. Move the definition into stat-shadow.c and have the
tests also use the global version.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c     |   6 +-
 tools/perf/builtin-stat.c       |   4 +-
 tools/perf/tests/parse-metric.c |  19 ++--
 tools/perf/tests/pmu-events.c   |   8 +-
 tools/perf/util/stat-display.c  |   5 +-
 tools/perf/util/stat-shadow.c   | 165 +++++++++++++-------------------
 tools/perf/util/stat.c          |   2 +-
 tools/perf/util/stat.h          |  17 +---
 8 files changed, 90 insertions(+), 136 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a792214d1af8..e9b5387161df 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2074,8 +2074,7 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 	val = sample->period * evsel->scale;
 	perf_stat__update_shadow_stats(evsel,
 				       val,
-				       sample->cpu,
-				       &rt_stat);
+				       sample->cpu);
 	evsel_script(evsel)->val = val;
 	if (evsel_script(leader)->gnum == leader->core.nr_members) {
 		for_each_group_member (ev2, leader) {
@@ -2083,8 +2082,7 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 						      evsel_script(ev2)->val,
 						      sample->cpu,
 						      &ctx,
-						      NULL,
-						      &rt_stat);
+						      NULL);
 		}
 		evsel_script(leader)->gnum = 0;
 	}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 9c1fbf154ee3..619387459914 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -434,7 +434,7 @@ static void process_interval(void)
 	clock_gettime(CLOCK_MONOTONIC, &ts);
 	diff_timespec(&rs, &ts, &ref_time);
 
-	perf_stat__reset_shadow_per_stat(&rt_stat);
+	perf_stat__reset_shadow_per_stat();
 	evlist__reset_aggr_stats(evsel_list);
 
 	if (read_counters(&rs) == 0)
@@ -910,7 +910,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		evlist__copy_prev_raw_counts(evsel_list);
 		evlist__reset_prev_raw_counts(evsel_list);
 		evlist__reset_aggr_stats(evsel_list);
-		perf_stat__reset_shadow_per_stat(&rt_stat);
+		perf_stat__reset_shadow_per_stat();
 	} else {
 		update_stats(&walltime_nsecs_stats, t1 - t0);
 		update_rusage_stats(&ru_stats, &stat_config.ru_data);
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 132c9b945a42..37e3371d978e 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -30,8 +30,7 @@ static u64 find_value(const char *name, struct value *values)
 	return 0;
 }
 
-static void load_runtime_stat(struct runtime_stat *st, struct evlist *evlist,
-			      struct value *vals)
+static void load_runtime_stat(struct evlist *evlist, struct value *vals)
 {
 	struct evsel *evsel;
 	u64 count;
@@ -39,14 +38,14 @@ static void load_runtime_stat(struct runtime_stat *st, struct evlist *evlist,
 	perf_stat__reset_shadow_stats();
 	evlist__for_each_entry(evlist, evsel) {
 		count = find_value(evsel->name, vals);
-		perf_stat__update_shadow_stats(evsel, count, 0, st);
+		perf_stat__update_shadow_stats(evsel, count, 0);
 		if (!strcmp(evsel->name, "duration_time"))
 			update_stats(&walltime_nsecs_stats, count);
 	}
 }
 
 static double compute_single(struct rblist *metric_events, struct evlist *evlist,
-			     struct runtime_stat *st, const char *name)
+			     const char *name)
 {
 	struct metric_expr *mexp;
 	struct metric_event *me;
@@ -58,7 +57,7 @@ static double compute_single(struct rblist *metric_events, struct evlist *evlist
 			list_for_each_entry (mexp, &me->head, nd) {
 				if (strcmp(mexp->metric_name, name))
 					continue;
-				return test_generic_metric(mexp, 0, st);
+				return test_generic_metric(mexp, 0);
 			}
 		}
 	}
@@ -74,7 +73,6 @@ static int __compute_metric(const char *name, struct value *vals,
 	};
 	const struct pmu_metrics_table *pme_test;
 	struct perf_cpu_map *cpus;
-	struct runtime_stat st;
 	struct evlist *evlist;
 	int err;
 
@@ -93,7 +91,6 @@ static int __compute_metric(const char *name, struct value *vals,
 	}
 
 	perf_evlist__set_maps(&evlist->core, cpus, NULL);
-	runtime_stat__init(&st);
 
 	/* Parse the metric into metric_events list. */
 	pme_test = find_core_metrics_table("testarch", "testcpu");
@@ -107,18 +104,17 @@ static int __compute_metric(const char *name, struct value *vals,
 		goto out;
 
 	/* Load the runtime stats with given numbers for events. */
-	load_runtime_stat(&st, evlist, vals);
+	load_runtime_stat(evlist, vals);
 
 	/* And execute the metric */
 	if (name1 && ratio1)
-		*ratio1 = compute_single(&metric_events, evlist, &st, name1);
+		*ratio1 = compute_single(&metric_events, evlist, name1);
 	if (name2 && ratio2)
-		*ratio2 = compute_single(&metric_events, evlist, &st, name2);
+		*ratio2 = compute_single(&metric_events, evlist, name2);
 
 out:
 	/* ... cleanup. */
 	metricgroup__rblist_exit(&metric_events);
-	runtime_stat__exit(&st);
 	evlist__free_stats(evlist);
 	perf_cpu_map__put(cpus);
 	evlist__delete(evlist);
@@ -300,6 +296,7 @@ static int test_metric_group(void)
 
 static int test__parse_metric(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
+	perf_stat__init_shadow_stats();
 	TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
 	TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
 	TEST_ASSERT_VAL("DCache_L2 failed", test_dcache_l2() == 0);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 50b99a0f8f59..122e74c282a7 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -816,7 +816,6 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 	int k;
 	struct evlist *evlist;
 	struct perf_cpu_map *cpus;
-	struct runtime_stat st;
 	struct evsel *evsel;
 	struct rblist metric_events = {
 		.nr_entries = 0,
@@ -844,7 +843,6 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 	}
 
 	perf_evlist__set_maps(&evlist->core, cpus, NULL);
-	runtime_stat__init(&st);
 
 	err = metricgroup__parse_groups_test(evlist, table, pm->metric_name, &metric_events);
 	if (err) {
@@ -867,7 +865,7 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 	k = 1;
 	perf_stat__reset_shadow_stats();
 	evlist__for_each_entry(evlist, evsel) {
-		perf_stat__update_shadow_stats(evsel, k, 0, &st);
+		perf_stat__update_shadow_stats(evsel, k, 0);
 		if (!strcmp(evsel->name, "duration_time"))
 			update_stats(&walltime_nsecs_stats, k);
 		k++;
@@ -881,7 +879,7 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 			list_for_each_entry (mexp, &me->head, nd) {
 				if (strcmp(mexp->metric_name, pm->metric_name))
 					continue;
-				pr_debug("Result %f\n", test_generic_metric(mexp, 0, &st));
+				pr_debug("Result %f\n", test_generic_metric(mexp, 0));
 				err = 0;
 				(*failures)--;
 				goto out_err;
@@ -896,7 +894,6 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 
 	/* ... cleanup. */
 	metricgroup__rblist_exit(&metric_events);
-	runtime_stat__exit(&st);
 	evlist__free_stats(evlist);
 	perf_cpu_map__put(cpus);
 	evlist__delete(evlist);
@@ -908,6 +905,7 @@ static int test__parsing(struct test_suite *test __maybe_unused,
 {
 	int failures = 0;
 
+	perf_stat__init_shadow_stats();
 	pmu_for_each_core_metric(test__parsing_callback, &failures);
 	pmu_for_each_sys_metric(test__parsing_callback, &failures);
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 1b5cb20efd23..6c065d0624c3 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -729,7 +729,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 
 	if (ok) {
 		perf_stat__print_shadow_stats(config, counter, uval, map_idx,
-					      &out, &config->metric_events, &rt_stat);
+					      &out, &config->metric_events);
 	} else {
 		pm(config, os, /*color=*/NULL, /*format=*/NULL, /*unit=*/"", /*val=*/0);
 	}
@@ -1089,8 +1089,7 @@ static void print_metric_headers(struct perf_stat_config *config,
 		perf_stat__print_shadow_stats(config, counter, 0,
 					      0,
 					      &out,
-					      &config->metric_events,
-					      &rt_stat);
+					      &config->metric_events);
 	}
 
 	if (!config->json_output)
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index fc948a7e83b7..f80be6abac90 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -25,10 +25,13 @@
  * AGGR_THREAD: Not supported?
  */
 
-struct runtime_stat rt_stat;
 struct stats walltime_nsecs_stats;
 struct rusage_stats ru_stats;
 
+static struct runtime_stat {
+	struct rblist value_list;
+} rt_stat;
+
 enum {
 	CTX_BIT_USER	= 1 << 0,
 	CTX_BIT_KERNEL	= 1 << 1,
@@ -125,7 +128,6 @@ static struct saved_value *saved_value_lookup(struct evsel *evsel,
 					      bool create,
 					      enum stat_type type,
 					      int ctx,
-					      struct runtime_stat *st,
 					      struct cgroup *cgrp)
 {
 	struct rblist *rblist;
@@ -138,7 +140,7 @@ static struct saved_value *saved_value_lookup(struct evsel *evsel,
 		.cgrp = cgrp,
 	};
 
-	rblist = &st->value_list;
+	rblist = &rt_stat.value_list;
 
 	/* don't use context info for clock events */
 	if (type == STAT_NSECS)
@@ -156,9 +158,9 @@ static struct saved_value *saved_value_lookup(struct evsel *evsel,
 	return NULL;
 }
 
-void runtime_stat__init(struct runtime_stat *st)
+void perf_stat__init_shadow_stats(void)
 {
-	struct rblist *rblist = &st->value_list;
+	struct rblist *rblist = &rt_stat.value_list;
 
 	rblist__init(rblist);
 	rblist->node_cmp = saved_value_cmp;
@@ -166,16 +168,6 @@ void runtime_stat__init(struct runtime_stat *st)
 	rblist->node_delete = saved_value_delete;
 }
 
-void runtime_stat__exit(struct runtime_stat *st)
-{
-	rblist__exit(&st->value_list);
-}
-
-void perf_stat__init_shadow_stats(void)
-{
-	runtime_stat__init(&rt_stat);
-}
-
 static int evsel_context(struct evsel *evsel)
 {
 	int ctx = 0;
@@ -194,12 +186,12 @@ static int evsel_context(struct evsel *evsel)
 	return ctx;
 }
 
-static void reset_stat(struct runtime_stat *st)
+void perf_stat__reset_shadow_per_stat(void)
 {
 	struct rblist *rblist;
 	struct rb_node *pos, *next;
 
-	rblist = &st->value_list;
+	rblist = &rt_stat.value_list;
 	next = rb_first_cached(&rblist->entries);
 	while (next) {
 		pos = next;
@@ -212,28 +204,22 @@ static void reset_stat(struct runtime_stat *st)
 
 void perf_stat__reset_shadow_stats(void)
 {
-	reset_stat(&rt_stat);
+	perf_stat__reset_shadow_per_stat();
 	memset(&walltime_nsecs_stats, 0, sizeof(walltime_nsecs_stats));
 	memset(&ru_stats, 0, sizeof(ru_stats));
 }
 
-void perf_stat__reset_shadow_per_stat(struct runtime_stat *st)
-{
-	reset_stat(st);
-}
-
 struct runtime_stat_data {
 	int ctx;
 	struct cgroup *cgrp;
 };
 
-static void update_runtime_stat(struct runtime_stat *st,
-				enum stat_type type,
+static void update_runtime_stat(enum stat_type type,
 				int map_idx, u64 count,
 				struct runtime_stat_data *rsd)
 {
 	struct saved_value *v = saved_value_lookup(NULL, map_idx, true, type,
-						   rsd->ctx, st, rsd->cgrp);
+						   rsd->ctx, rsd->cgrp);
 
 	if (v)
 		update_stats(&v->stats, count);
@@ -245,7 +231,7 @@ static void update_runtime_stat(struct runtime_stat *st,
  * instruction rates, etc:
  */
 void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
-				    int map_idx, struct runtime_stat *st)
+				    int map_idx)
 {
 	u64 count_ns = count;
 	struct saved_value *v;
@@ -253,43 +239,42 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 		.ctx = evsel_context(counter),
 		.cgrp = counter->cgrp,
 	};
-
 	count *= counter->scale;
 
 	if (evsel__is_clock(counter))
-		update_runtime_stat(st, STAT_NSECS, map_idx, count_ns, &rsd);
+		update_runtime_stat(STAT_NSECS, map_idx, count_ns, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
-		update_runtime_stat(st, STAT_CYCLES, map_idx, count, &rsd);
+		update_runtime_stat(STAT_CYCLES, map_idx, count, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
-		update_runtime_stat(st, STAT_STALLED_CYCLES_FRONT,
+		update_runtime_stat(STAT_STALLED_CYCLES_FRONT,
 				    map_idx, count, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_BACKEND))
-		update_runtime_stat(st, STAT_STALLED_CYCLES_BACK,
+		update_runtime_stat(STAT_STALLED_CYCLES_BACK,
 				    map_idx, count, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_BRANCH_INSTRUCTIONS))
-		update_runtime_stat(st, STAT_BRANCHES, map_idx, count, &rsd);
+		update_runtime_stat(STAT_BRANCHES, map_idx, count, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_CACHE_REFERENCES))
-		update_runtime_stat(st, STAT_CACHEREFS, map_idx, count, &rsd);
+		update_runtime_stat(STAT_CACHEREFS, map_idx, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1D))
-		update_runtime_stat(st, STAT_L1_DCACHE, map_idx, count, &rsd);
+		update_runtime_stat(STAT_L1_DCACHE, map_idx, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1I))
-		update_runtime_stat(st, STAT_L1_ICACHE, map_idx, count, &rsd);
+		update_runtime_stat(STAT_L1_ICACHE, map_idx, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_LL))
-		update_runtime_stat(st, STAT_LL_CACHE, map_idx, count, &rsd);
+		update_runtime_stat(STAT_LL_CACHE, map_idx, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_DTLB))
-		update_runtime_stat(st, STAT_DTLB_CACHE, map_idx, count, &rsd);
+		update_runtime_stat(STAT_DTLB_CACHE, map_idx, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_ITLB))
-		update_runtime_stat(st, STAT_ITLB_CACHE, map_idx, count, &rsd);
+		update_runtime_stat(STAT_ITLB_CACHE, map_idx, count, &rsd);
 
 	if (counter->collect_stat) {
-		v = saved_value_lookup(counter, map_idx, true, STAT_NONE, 0, st,
+		v = saved_value_lookup(counter, map_idx, true, STAT_NONE, 0,
 				       rsd.cgrp);
 		update_stats(&v->stats, count);
 		if (counter->metric_leader)
 			v->metric_total += count;
 	} else if (counter->metric_leader && !counter->merged_stat) {
 		v = saved_value_lookup(counter->metric_leader,
-				       map_idx, true, STAT_NONE, 0, st, rsd.cgrp);
+				       map_idx, true, STAT_NONE, 0, rsd.cgrp);
 		v->metric_total += count;
 		v->metric_other++;
 	}
@@ -322,26 +307,24 @@ static const char *get_ratio_color(enum grc_type type, double ratio)
 	return color;
 }
 
-static double runtime_stat_avg(struct runtime_stat *st,
-			       enum stat_type type, int map_idx,
+static double runtime_stat_avg(enum stat_type type, int map_idx,
 			       struct runtime_stat_data *rsd)
 {
 	struct saved_value *v;
 
-	v = saved_value_lookup(NULL, map_idx, false, type, rsd->ctx, st, rsd->cgrp);
+	v = saved_value_lookup(NULL, map_idx, false, type, rsd->ctx, rsd->cgrp);
 	if (!v)
 		return 0.0;
 
 	return avg_stats(&v->stats);
 }
 
-static double runtime_stat_n(struct runtime_stat *st,
-			     enum stat_type type, int map_idx,
+static double runtime_stat_n(enum stat_type type, int map_idx,
 			     struct runtime_stat_data *rsd)
 {
 	struct saved_value *v;
 
-	v = saved_value_lookup(NULL, map_idx, false, type, rsd->ctx, st, rsd->cgrp);
+	v = saved_value_lookup(NULL, map_idx, false, type, rsd->ctx, rsd->cgrp);
 	if (!v)
 		return 0.0;
 
@@ -351,13 +334,12 @@ static double runtime_stat_n(struct runtime_stat *st,
 static void print_stalled_cycles_frontend(struct perf_stat_config *config,
 					  int map_idx, double avg,
 					  struct perf_stat_output_ctx *out,
-					  struct runtime_stat *st,
 					  struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(st, STAT_CYCLES, map_idx, rsd);
+	total = runtime_stat_avg(STAT_CYCLES, map_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -374,13 +356,12 @@ static void print_stalled_cycles_frontend(struct perf_stat_config *config,
 static void print_stalled_cycles_backend(struct perf_stat_config *config,
 					 int map_idx, double avg,
 					 struct perf_stat_output_ctx *out,
-					 struct runtime_stat *st,
 					 struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(st, STAT_CYCLES, map_idx, rsd);
+	total = runtime_stat_avg(STAT_CYCLES, map_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -393,13 +374,12 @@ static void print_stalled_cycles_backend(struct perf_stat_config *config,
 static void print_branch_misses(struct perf_stat_config *config,
 				int map_idx, double avg,
 				struct perf_stat_output_ctx *out,
-				struct runtime_stat *st,
 				struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(st, STAT_BRANCHES, map_idx, rsd);
+	total = runtime_stat_avg(STAT_BRANCHES, map_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -412,13 +392,12 @@ static void print_branch_misses(struct perf_stat_config *config,
 static void print_l1_dcache_misses(struct perf_stat_config *config,
 				   int map_idx, double avg,
 				   struct perf_stat_output_ctx *out,
-				   struct runtime_stat *st,
 				   struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(st, STAT_L1_DCACHE, map_idx, rsd);
+	total = runtime_stat_avg(STAT_L1_DCACHE, map_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -431,13 +410,12 @@ static void print_l1_dcache_misses(struct perf_stat_config *config,
 static void print_l1_icache_misses(struct perf_stat_config *config,
 				   int map_idx, double avg,
 				   struct perf_stat_output_ctx *out,
-				   struct runtime_stat *st,
 				   struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(st, STAT_L1_ICACHE, map_idx, rsd);
+	total = runtime_stat_avg(STAT_L1_ICACHE, map_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -449,13 +427,12 @@ static void print_l1_icache_misses(struct perf_stat_config *config,
 static void print_dtlb_cache_misses(struct perf_stat_config *config,
 				    int map_idx, double avg,
 				    struct perf_stat_output_ctx *out,
-				    struct runtime_stat *st,
 				    struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(st, STAT_DTLB_CACHE, map_idx, rsd);
+	total = runtime_stat_avg(STAT_DTLB_CACHE, map_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -467,13 +444,12 @@ static void print_dtlb_cache_misses(struct perf_stat_config *config,
 static void print_itlb_cache_misses(struct perf_stat_config *config,
 				    int map_idx, double avg,
 				    struct perf_stat_output_ctx *out,
-				    struct runtime_stat *st,
 				    struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(st, STAT_ITLB_CACHE, map_idx, rsd);
+	total = runtime_stat_avg(STAT_ITLB_CACHE, map_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -485,13 +461,12 @@ static void print_itlb_cache_misses(struct perf_stat_config *config,
 static void print_ll_cache_misses(struct perf_stat_config *config,
 				  int map_idx, double avg,
 				  struct perf_stat_output_ctx *out,
-				  struct runtime_stat *st,
 				  struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(st, STAT_LL_CACHE, map_idx, rsd);
+	total = runtime_stat_avg(STAT_LL_CACHE, map_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -503,8 +478,7 @@ static void print_ll_cache_misses(struct perf_stat_config *config,
 static int prepare_metric(struct evsel **metric_events,
 			  struct metric_ref *metric_refs,
 			  struct expr_parse_ctx *pctx,
-			  int map_idx,
-			  struct runtime_stat *st)
+			  int map_idx)
 {
 	double scale;
 	char *n;
@@ -543,7 +517,7 @@ static int prepare_metric(struct evsel **metric_events,
 			}
 		} else {
 			v = saved_value_lookup(metric_events[i], map_idx, false,
-					       STAT_NONE, 0, st,
+					       STAT_NONE, 0,
 					       metric_events[i]->cgrp);
 			if (!v)
 				break;
@@ -587,8 +561,7 @@ static void generic_metric(struct perf_stat_config *config,
 			   const char *metric_unit,
 			   int runtime,
 			   int map_idx,
-			   struct perf_stat_output_ctx *out,
-			   struct runtime_stat *st)
+			   struct perf_stat_output_ctx *out)
 {
 	print_metric_t print_metric = out->print_metric;
 	struct expr_parse_ctx *pctx;
@@ -605,7 +578,7 @@ static void generic_metric(struct perf_stat_config *config,
 		pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
 	pctx->sctx.runtime = runtime;
 	pctx->sctx.system_wide = config->system_wide;
-	i = prepare_metric(metric_events, metric_refs, pctx, map_idx, st);
+	i = prepare_metric(metric_events, metric_refs, pctx, map_idx);
 	if (i < 0) {
 		expr__ctx_free(pctx);
 		return;
@@ -657,7 +630,7 @@ static void generic_metric(struct perf_stat_config *config,
 	expr__ctx_free(pctx);
 }
 
-double test_generic_metric(struct metric_expr *mexp, int map_idx, struct runtime_stat *st)
+double test_generic_metric(struct metric_expr *mexp, int map_idx)
 {
 	struct expr_parse_ctx *pctx;
 	double ratio = 0.0;
@@ -666,7 +639,7 @@ double test_generic_metric(struct metric_expr *mexp, int map_idx, struct runtime
 	if (!pctx)
 		return NAN;
 
-	if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx, map_idx, st) < 0)
+	if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx, map_idx) < 0)
 		goto out;
 
 	if (expr__parse(&ratio, pctx, mexp->metric_expr))
@@ -681,8 +654,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct evsel *evsel,
 				   double avg, int map_idx,
 				   struct perf_stat_output_ctx *out,
-				   struct rblist *metric_events,
-				   struct runtime_stat *st)
+				   struct rblist *metric_events)
 {
 	void *ctxp = out->ctx;
 	print_metric_t print_metric = out->print_metric;
@@ -697,7 +669,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	if (config->iostat_run) {
 		iostat_print_metric(config, evsel, out);
 	} else if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
-		total = runtime_stat_avg(st, STAT_CYCLES, map_idx, &rsd);
+		total = runtime_stat_avg(STAT_CYCLES, map_idx, &rsd);
 
 		if (total) {
 			ratio = avg / total;
@@ -707,10 +679,9 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			print_metric(config, ctxp, NULL, NULL, "insn per cycle", 0);
 		}
 
-		total = runtime_stat_avg(st, STAT_STALLED_CYCLES_FRONT, map_idx, &rsd);
+		total = runtime_stat_avg(STAT_STALLED_CYCLES_FRONT, map_idx, &rsd);
 
-		total = max(total, runtime_stat_avg(st,
-						    STAT_STALLED_CYCLES_BACK,
+		total = max(total, runtime_stat_avg(STAT_STALLED_CYCLES_BACK,
 						    map_idx, &rsd));
 
 		if (total && avg) {
@@ -721,8 +692,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					ratio);
 		}
 	} else if (evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
-		if (runtime_stat_n(st, STAT_BRANCHES, map_idx, &rsd) != 0)
-			print_branch_misses(config, map_idx, avg, out, st, &rsd);
+		if (runtime_stat_n(STAT_BRANCHES, map_idx, &rsd) != 0)
+			print_branch_misses(config, map_idx, avg, out, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all branches", 0);
 	} else if (
@@ -731,8 +702,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_L1_DCACHE, map_idx, &rsd) != 0)
-			print_l1_dcache_misses(config, map_idx, avg, out, st, &rsd);
+		if (runtime_stat_n(STAT_L1_DCACHE, map_idx, &rsd) != 0)
+			print_l1_dcache_misses(config, map_idx, avg, out, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache accesses", 0);
 	} else if (
@@ -741,8 +712,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_L1_ICACHE, map_idx, &rsd) != 0)
-			print_l1_icache_misses(config, map_idx, avg, out, st, &rsd);
+		if (runtime_stat_n(STAT_L1_ICACHE, map_idx, &rsd) != 0)
+			print_l1_icache_misses(config, map_idx, avg, out, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all L1-icache accesses", 0);
 	} else if (
@@ -751,8 +722,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_DTLB_CACHE, map_idx, &rsd) != 0)
-			print_dtlb_cache_misses(config, map_idx, avg, out, st, &rsd);
+		if (runtime_stat_n(STAT_DTLB_CACHE, map_idx, &rsd) != 0)
+			print_dtlb_cache_misses(config, map_idx, avg, out, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache accesses", 0);
 	} else if (
@@ -761,8 +732,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_ITLB_CACHE, map_idx, &rsd) != 0)
-			print_itlb_cache_misses(config, map_idx, avg, out, st, &rsd);
+		if (runtime_stat_n(STAT_ITLB_CACHE, map_idx, &rsd) != 0)
+			print_itlb_cache_misses(config, map_idx, avg, out, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache accesses", 0);
 	} else if (
@@ -771,27 +742,27 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_LL_CACHE, map_idx, &rsd) != 0)
-			print_ll_cache_misses(config, map_idx, avg, out, st, &rsd);
+		if (runtime_stat_n(STAT_LL_CACHE, map_idx, &rsd) != 0)
+			print_ll_cache_misses(config, map_idx, avg, out, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all LL-cache accesses", 0);
 	} else if (evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
-		total = runtime_stat_avg(st, STAT_CACHEREFS, map_idx, &rsd);
+		total = runtime_stat_avg(STAT_CACHEREFS, map_idx, &rsd);
 
 		if (total)
 			ratio = avg * 100 / total;
 
-		if (runtime_stat_n(st, STAT_CACHEREFS, map_idx, &rsd) != 0)
+		if (runtime_stat_n(STAT_CACHEREFS, map_idx, &rsd) != 0)
 			print_metric(config, ctxp, NULL, "%8.3f %%",
 				     "of all cache refs", ratio);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all cache refs", 0);
 	} else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND)) {
-		print_stalled_cycles_frontend(config, map_idx, avg, out, st, &rsd);
+		print_stalled_cycles_frontend(config, map_idx, avg, out, &rsd);
 	} else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND)) {
-		print_stalled_cycles_backend(config, map_idx, avg, out, st, &rsd);
+		print_stalled_cycles_backend(config, map_idx, avg, out, &rsd);
 	} else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
-		total = runtime_stat_avg(st, STAT_NSECS, map_idx, &rsd);
+		total = runtime_stat_avg(STAT_NSECS, map_idx, &rsd);
 
 		if (total) {
 			ratio = avg / total;
@@ -805,11 +776,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				     avg / (ratio * evsel->scale));
 		else
 			print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
-	} else if (runtime_stat_n(st, STAT_NSECS, map_idx, &rsd) != 0) {
+	} else if (runtime_stat_n(STAT_NSECS, map_idx, &rsd) != 0) {
 		char unit = ' ';
 		char unit_buf[10] = "/sec";
 
-		total = runtime_stat_avg(st, STAT_NSECS, map_idx, &rsd);
+		total = runtime_stat_avg(STAT_NSECS, map_idx, &rsd);
 		if (total)
 			ratio = convert_unit_double(1000000000.0 * avg / total, &unit);
 
@@ -829,7 +800,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			generic_metric(config, mexp->metric_expr, mexp->metric_threshold,
 				       mexp->metric_events, mexp->metric_refs, evsel->name,
 				       mexp->metric_name, mexp->metric_unit, mexp->runtime,
-				       map_idx, out, st);
+				       map_idx, out);
 		}
 	}
 	if (num == 0)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 8d83d2f4a082..0d7538670d67 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -659,7 +659,7 @@ static void evsel__update_shadow_stats(struct evsel *evsel)
 	for (i = 0; i < ps->nr_aggr; i++) {
 		struct perf_counts_values *aggr_counts = &ps->aggr[i].counts;
 
-		perf_stat__update_shadow_stats(evsel, aggr_counts->val, i, &rt_stat);
+		perf_stat__update_shadow_stats(evsel, aggr_counts->val, i);
 	}
 }
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 215c0f5c4db7..09975e098bd0 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -55,10 +55,6 @@ enum aggr_mode {
 	AGGR_MAX
 };
 
-struct runtime_stat {
-	struct rblist value_list;
-};
-
 struct rusage_stats {
 	struct stats ru_utime_usec_stat;
 	struct stats ru_stime_usec_stat;
@@ -153,7 +149,6 @@ static inline void update_rusage_stats(struct rusage_stats *ru_stats, struct rus
 struct evsel;
 struct evlist;
 
-extern struct runtime_stat rt_stat;
 extern struct stats walltime_nsecs_stats;
 extern struct rusage_stats ru_stats;
 
@@ -162,13 +157,10 @@ typedef void (*print_metric_t)(struct perf_stat_config *config,
 			       const char *fmt, double val);
 typedef void (*new_line_t)(struct perf_stat_config *config, void *ctx);
 
-void runtime_stat__init(struct runtime_stat *st);
-void runtime_stat__exit(struct runtime_stat *st);
 void perf_stat__init_shadow_stats(void);
 void perf_stat__reset_shadow_stats(void);
-void perf_stat__reset_shadow_per_stat(struct runtime_stat *st);
-void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
-				    int map_idx, struct runtime_stat *st);
+void perf_stat__reset_shadow_per_stat(void);
+void perf_stat__update_shadow_stats(struct evsel *counter, u64 count, int map_idx);
 struct perf_stat_output_ctx {
 	void *ctx;
 	print_metric_t print_metric;
@@ -180,8 +172,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct evsel *evsel,
 				   double avg, int map_idx,
 				   struct perf_stat_output_ctx *out,
-				   struct rblist *metric_events,
-				   struct runtime_stat *st);
+				   struct rblist *metric_events);
 
 int evlist__alloc_stats(struct perf_stat_config *config,
 			struct evlist *evlist, bool alloc_raw);
@@ -220,5 +211,5 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 			    struct target *_target, struct timespec *ts, int argc, const char **argv);
 
 struct metric_expr;
-double test_generic_metric(struct metric_expr *mexp, int map_idx, struct runtime_stat *st);
+double test_generic_metric(struct metric_expr *mexp, int map_idx);
 #endif
-- 
2.39.2.637.g21b0678d19-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E390369BFBF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjBSJio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBSJil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:38:41 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD26C12BC1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:37:42 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5368a9902d0so14232857b3.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWbhNdODInNmkKhRE1J16fJdDjqDUBwLENwO3W9vuiU=;
        b=Pm859wysWzwzMi1q3PqzD+ne5cXUtXcBdKyZ0RS1dnxvqc3OaHp8DhL81ofEGYOgyI
         L5IQIUgDp0VOypIYOXzLORvQ8rsun/udjxKhuATtxbN3onPcIRK5hjIiBs6kOb6UyhPu
         jQuiF01vyuV9aBbDnpjIIgSILCRwX6F5MWuKOHlsyDoDqHN0LdEVSQrp9hBJ/m6KYVni
         iYurqb7fJVAn6qXnKcJb2No+8gTYalxOJk4e0xCvES+dUhxkkykpJpF8WSCYQnmmkKcF
         2YZi+Kuqk7+q7PLIuUiD4DtSXzRupWNlCokHZfTMqJ88/DyhTR0Lsu0EZMX1oRjJSn2P
         lzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWbhNdODInNmkKhRE1J16fJdDjqDUBwLENwO3W9vuiU=;
        b=KQEYgjPkp84L+2rWR2d2uzLZ89KNpwkY5v9pJf19EX48vTH2ot9n4DDOmCBzKpRXhn
         mvom5vaXdIqRCarf7L50L+/Ct6jy/2ROegg//zA1JlqsYQt265HyFGS+uBM4kPXrKQRc
         D69ZM5TfbUuSVGUninaV4DoyzuDHTZPRPIcOZCO7cghjpd9vNvaO9zAjAZJTjDujP7Gx
         cgHy5ndkttkQp95VtDTWSlMC1LlUkUsINa5iAaOOA8K68l74e7sFB7Tz9daYJK5g0h+B
         gHqdw1dv9cPJ0+UwhAZ/osc6iqrAFu4Mf0u+ZtMAtvgBs3jbJoeCVQujzAWCe9lHW6s7
         UKAw==
X-Gm-Message-State: AO0yUKU8zgiLhPmR49Q52jo3LvvHbeE50HbEpPKql7lSDkaO5jasGvMq
        F+BUdsAbxpl0+vtgc6Qk37S15buyIZGJ
X-Google-Smtp-Source: AK7set8YqgO/ol8bai9joW9tiv/vzRHWjDm3VMhOIPq5xrBsNspbbJh5PV/rW1OqBHmfh9XKebzqmWulRZtt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a05:6902:12c5:b0:8d9:7d26:d690 with SMTP
 id j5-20020a05690212c500b008d97d26d690mr156747ybu.1.1676799370473; Sun, 19
 Feb 2023 01:36:10 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:48 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-52-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 51/51] perf stat: Remove saved_value/runtime_stat
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As saved_value/runtime_stat are only written to and not read, remove
the associated logic and writes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c     |   5 -
 tools/perf/builtin-stat.c       |   6 -
 tools/perf/tests/parse-metric.c |   1 -
 tools/perf/tests/pmu-events.c   |   1 -
 tools/perf/util/stat-shadow.c   | 198 --------------------------------
 tools/perf/util/stat.c          |  24 ----
 tools/perf/util/stat.h          |   4 -
 7 files changed, 239 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e9b5387161df..522226114263 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2072,9 +2072,6 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 	if (evsel_script(leader)->gnum++ == 0)
 		perf_stat__reset_shadow_stats();
 	val = sample->period * evsel->scale;
-	perf_stat__update_shadow_stats(evsel,
-				       val,
-				       sample->cpu);
 	evsel_script(evsel)->val = val;
 	if (evsel_script(leader)->gnum == leader->core.nr_members) {
 		for_each_group_member (ev2, leader) {
@@ -2792,8 +2789,6 @@ static int __cmd_script(struct perf_script *script)
 
 	signal(SIGINT, sig_handler);
 
-	perf_stat__init_shadow_stats();
-
 	/* override event processing functions */
 	if (script->show_task_events) {
 		script->tool.comm = process_comm_event;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 619387459914..d70b1ec88594 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -424,7 +424,6 @@ static void process_counters(void)
 
 	perf_stat_merge_counters(&stat_config, evsel_list);
 	perf_stat_process_percore(&stat_config, evsel_list);
-	perf_stat_process_shadow_stats(&stat_config, evsel_list);
 }
 
 static void process_interval(void)
@@ -434,7 +433,6 @@ static void process_interval(void)
 	clock_gettime(CLOCK_MONOTONIC, &ts);
 	diff_timespec(&rs, &ts, &ref_time);
 
-	perf_stat__reset_shadow_per_stat();
 	evlist__reset_aggr_stats(evsel_list);
 
 	if (read_counters(&rs) == 0)
@@ -910,7 +908,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		evlist__copy_prev_raw_counts(evsel_list);
 		evlist__reset_prev_raw_counts(evsel_list);
 		evlist__reset_aggr_stats(evsel_list);
-		perf_stat__reset_shadow_per_stat();
 	} else {
 		update_stats(&walltime_nsecs_stats, t1 - t0);
 		update_rusage_stats(&ru_stats, &stat_config.ru_data);
@@ -2132,8 +2129,6 @@ static int __cmd_report(int argc, const char **argv)
 			input_name = "perf.data";
 	}
 
-	perf_stat__init_shadow_stats();
-
 	perf_stat.data.path = input_name;
 	perf_stat.data.mode = PERF_DATA_MODE_READ;
 
@@ -2413,7 +2408,6 @@ int cmd_stat(int argc, const char **argv)
 					&stat_config.metric_events);
 		zfree(&metrics);
 	}
-	perf_stat__init_shadow_stats();
 
 	if (add_default_attributes())
 		goto out;
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index b9b8a48289c4..c43b056f9fa3 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -296,7 +296,6 @@ static int test_metric_group(void)
 
 static int test__parse_metric(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	perf_stat__init_shadow_stats();
 	TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
 	TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
 	TEST_ASSERT_VAL("DCache_L2 failed", test_dcache_l2() == 0);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 4ec2a4ca1a82..6ccd413b5983 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -905,7 +905,6 @@ static int test__parsing(struct test_suite *test __maybe_unused,
 {
 	int failures = 0;
 
-	perf_stat__init_shadow_stats();
 	pmu_for_each_core_metric(test__parsing_callback, &failures);
 	pmu_for_each_sys_metric(test__parsing_callback, &failures);
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 9d22cde09dc9..ef85f1ae1ab2 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -16,22 +16,9 @@
 #include "iostat.h"
 #include "util/hashmap.h"
 
-/*
- * AGGR_GLOBAL: Use CPU 0
- * AGGR_SOCKET: Use first CPU of socket
- * AGGR_DIE: Use first CPU of die
- * AGGR_CORE: Use first CPU of core
- * AGGR_NONE: Use matching CPU
- * AGGR_THREAD: Not supported?
- */
-
 struct stats walltime_nsecs_stats;
 struct rusage_stats ru_stats;
 
-static struct runtime_stat {
-	struct rblist value_list;
-} rt_stat;
-
 enum {
 	CTX_BIT_USER	= 1 << 0,
 	CTX_BIT_KERNEL	= 1 << 1,
@@ -65,117 +52,6 @@ enum stat_type {
 	STAT_MAX
 };
 
-struct saved_value {
-	struct rb_node rb_node;
-	struct evsel *evsel;
-	enum stat_type type;
-	int ctx;
-	int map_idx;  /* cpu or thread map index */
-	struct cgroup *cgrp;
-	struct stats stats;
-	u64 metric_total;
-	int metric_other;
-};
-
-static int saved_value_cmp(struct rb_node *rb_node, const void *entry)
-{
-	struct saved_value *a = container_of(rb_node,
-					     struct saved_value,
-					     rb_node);
-	const struct saved_value *b = entry;
-
-	if (a->map_idx != b->map_idx)
-		return a->map_idx - b->map_idx;
-
-	/*
-	 * Previously the rbtree was used to link generic metrics.
-	 * The keys were evsel/cpu. Now the rbtree is extended to support
-	 * per-thread shadow stats. For shadow stats case, the keys
-	 * are cpu/type/ctx/stat (evsel is NULL). For generic metrics
-	 * case, the keys are still evsel/cpu (type/ctx/stat are 0 or NULL).
-	 */
-	if (a->type != b->type)
-		return a->type - b->type;
-
-	if (a->ctx != b->ctx)
-		return a->ctx - b->ctx;
-
-	if (a->cgrp != b->cgrp)
-		return (char *)a->cgrp < (char *)b->cgrp ? -1 : +1;
-
-	if (a->evsel == b->evsel)
-		return 0;
-	if ((char *)a->evsel < (char *)b->evsel)
-		return -1;
-	return +1;
-}
-
-static struct rb_node *saved_value_new(struct rblist *rblist __maybe_unused,
-				     const void *entry)
-{
-	struct saved_value *nd = malloc(sizeof(struct saved_value));
-
-	if (!nd)
-		return NULL;
-	memcpy(nd, entry, sizeof(struct saved_value));
-	return &nd->rb_node;
-}
-
-static void saved_value_delete(struct rblist *rblist __maybe_unused,
-			       struct rb_node *rb_node)
-{
-	struct saved_value *v;
-
-	BUG_ON(!rb_node);
-	v = container_of(rb_node, struct saved_value, rb_node);
-	free(v);
-}
-
-static struct saved_value *saved_value_lookup(struct evsel *evsel,
-					      int map_idx,
-					      bool create,
-					      enum stat_type type,
-					      int ctx,
-					      struct cgroup *cgrp)
-{
-	struct rblist *rblist;
-	struct rb_node *nd;
-	struct saved_value dm = {
-		.map_idx = map_idx,
-		.evsel = evsel,
-		.type = type,
-		.ctx = ctx,
-		.cgrp = cgrp,
-	};
-
-	rblist = &rt_stat.value_list;
-
-	/* don't use context info for clock events */
-	if (type == STAT_NSECS)
-		dm.ctx = 0;
-
-	nd = rblist__find(rblist, &dm);
-	if (nd)
-		return container_of(nd, struct saved_value, rb_node);
-	if (create) {
-		rblist__add_node(rblist, &dm);
-		nd = rblist__find(rblist, &dm);
-		if (nd)
-			return container_of(nd, struct saved_value, rb_node);
-	}
-	return NULL;
-}
-
-void perf_stat__init_shadow_stats(void)
-{
-	struct rblist *rblist = &rt_stat.value_list;
-
-	rblist__init(rblist);
-	rblist->node_cmp = saved_value_cmp;
-	rblist->node_new = saved_value_new;
-	rblist->node_delete = saved_value_delete;
-}
-
 static int evsel_context(const struct evsel *evsel)
 {
 	int ctx = 0;
@@ -194,86 +70,12 @@ static int evsel_context(const struct evsel *evsel)
 	return ctx;
 }
 
-void perf_stat__reset_shadow_per_stat(void)
-{
-	struct rblist *rblist;
-	struct rb_node *pos, *next;
-
-	rblist = &rt_stat.value_list;
-	next = rb_first_cached(&rblist->entries);
-	while (next) {
-		pos = next;
-		next = rb_next(pos);
-		memset(&container_of(pos, struct saved_value, rb_node)->stats,
-		       0,
-		       sizeof(struct stats));
-	}
-}
-
 void perf_stat__reset_shadow_stats(void)
 {
-	perf_stat__reset_shadow_per_stat();
 	memset(&walltime_nsecs_stats, 0, sizeof(walltime_nsecs_stats));
 	memset(&ru_stats, 0, sizeof(ru_stats));
 }
 
-struct runtime_stat_data {
-	int ctx;
-	struct cgroup *cgrp;
-};
-
-static void update_runtime_stat(enum stat_type type,
-				int map_idx, u64 count,
-				struct runtime_stat_data *rsd)
-{
-	struct saved_value *v = saved_value_lookup(NULL, map_idx, true, type,
-						   rsd->ctx, rsd->cgrp);
-
-	if (v)
-		update_stats(&v->stats, count);
-}
-
-/*
- * Update various tracking values we maintain to print
- * more semantic information such as miss/hit ratios,
- * instruction rates, etc:
- */
-void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
-				    int aggr_idx)
-{
-	u64 count_ns = count;
-	struct runtime_stat_data rsd = {
-		.ctx = evsel_context(counter),
-		.cgrp = counter->cgrp,
-	};
-	count *= counter->scale;
-
-	if (evsel__is_clock(counter))
-		update_runtime_stat(STAT_NSECS, aggr_idx, count_ns, &rsd);
-	else if (evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
-		update_runtime_stat(STAT_CYCLES, aggr_idx, count, &rsd);
-	else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
-		update_runtime_stat(STAT_STALLED_CYCLES_FRONT,
-				    aggr_idx, count, &rsd);
-	else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_BACKEND))
-		update_runtime_stat(STAT_STALLED_CYCLES_BACK,
-				    aggr_idx, count, &rsd);
-	else if (evsel__match(counter, HARDWARE, HW_BRANCH_INSTRUCTIONS))
-		update_runtime_stat(STAT_BRANCHES, aggr_idx, count, &rsd);
-	else if (evsel__match(counter, HARDWARE, HW_CACHE_REFERENCES))
-		update_runtime_stat(STAT_CACHE_REFS, aggr_idx, count, &rsd);
-	else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1D))
-		update_runtime_stat(STAT_L1_DCACHE, aggr_idx, count, &rsd);
-	else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1I))
-		update_runtime_stat(STAT_L1_ICACHE, aggr_idx, count, &rsd);
-	else if (evsel__match(counter, HW_CACHE, HW_CACHE_LL))
-		update_runtime_stat(STAT_LL_CACHE, aggr_idx, count, &rsd);
-	else if (evsel__match(counter, HW_CACHE, HW_CACHE_DTLB))
-		update_runtime_stat(STAT_DTLB_CACHE, aggr_idx, count, &rsd);
-	else if (evsel__match(counter, HW_CACHE, HW_CACHE_ITLB))
-		update_runtime_stat(STAT_ITLB_CACHE, aggr_idx, count, &rsd);
-}
-
 static enum stat_type evsel__stat_type(const struct evsel *evsel)
 {
 	/* Fake perf_hw_cache_op_id values for use with evsel__match. */
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 83dc4c1f4b12..4abfd87c5352 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -648,30 +648,6 @@ void perf_stat_process_percore(struct perf_stat_config *config, struct evlist *e
 		evsel__process_percore(evsel);
 }
 
-static void evsel__update_shadow_stats(struct evsel *evsel)
-{
-	struct perf_stat_evsel *ps = evsel->stats;
-	int aggr_idx;
-
-	if (ps->aggr == NULL)
-		return;
-
-	for (aggr_idx = 0; aggr_idx < ps->nr_aggr; aggr_idx++) {
-		struct perf_counts_values *aggr_counts = &ps->aggr[aggr_idx].counts;
-
-		perf_stat__update_shadow_stats(evsel, aggr_counts->val, aggr_idx);
-	}
-}
-
-void perf_stat_process_shadow_stats(struct perf_stat_config *config __maybe_unused,
-				    struct evlist *evlist)
-{
-	struct evsel *evsel;
-
-	evlist__for_each_entry(evlist, evsel)
-		evsel__update_shadow_stats(evsel);
-}
-
 int perf_event__process_stat_event(struct perf_session *session,
 				   union perf_event *event)
 {
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index b01c828c3799..41204547b76b 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -157,10 +157,7 @@ typedef void (*print_metric_t)(struct perf_stat_config *config,
 			       const char *fmt, double val);
 typedef void (*new_line_t)(struct perf_stat_config *config, void *ctx);
 
-void perf_stat__init_shadow_stats(void);
 void perf_stat__reset_shadow_stats(void);
-void perf_stat__reset_shadow_per_stat(void);
-void perf_stat__update_shadow_stats(struct evsel *counter, u64 count, int aggr_idx);
 struct perf_stat_output_ctx {
 	void *ctx;
 	print_metric_t print_metric;
@@ -189,7 +186,6 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter);
 void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *evlist);
 void perf_stat_process_percore(struct perf_stat_config *config, struct evlist *evlist);
-void perf_stat_process_shadow_stats(struct perf_stat_config *config, struct evlist *evlist);
 
 struct perf_tool;
 union perf_event;
-- 
2.39.2.637.g21b0678d19-goog


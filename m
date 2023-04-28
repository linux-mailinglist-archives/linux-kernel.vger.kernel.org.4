Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D056F12B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345862AbjD1HqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345860AbjD1Hpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:45:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868D65BAD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:44:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f6bef3d4aso18080116276.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667816; x=1685259816;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+u0fif1vqEW0/J+d1lw722skZP4Uon5UbkaqbwSy+30=;
        b=UgOOUrCvBfPI8luxVGI4aO+kBrf3ML377I9mEugMqCXV486aeJxDe9E6OyAGbUaCr5
         yda0r9sp1MoDx2yU5bTaX23all07//3N/iMW0vUYVr8wztuKsnr9bIwZfJt12R6DxU3e
         v9Xx8LxTic2YJmyWGxyC/EmY4cT0yjggsDAIOrXkuX3Aia++FGfoIsCpqRTRato88UOU
         V1z7UMf53C1PEICYMknIGg2dvk7wDJsC6+mTydYI9Q1ZKqOfNyJi7mU32UpEM0dKqV+a
         yjsGHTjftecPEALakzEKdC/ffuyUY8fsrWgU4WAtiSR/5O29pnNUc9eDlUlNhCtGaMTM
         6ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667816; x=1685259816;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+u0fif1vqEW0/J+d1lw722skZP4Uon5UbkaqbwSy+30=;
        b=DMrftN6nK1T+NGYn07gMvdnFyw7dQRT1+GR4kC/czrTteUZ6+A0TU7BeuTCdNIT/R0
         8/T7KitR+mos3xu1ihiXapvgtKcY8Nv8Dr0T2TowOO1i7ep9/Cq1JDoGu51vka+KkKrl
         xSBa30sOxFrx95G5n6gf69I/uKEv4WMIta9op53JHw0eWBfoIqJE1ehFuF5Ub2JoHx8c
         P9wxZ2ATWfxZox1PgDRzeSmmtuQx+VdZw+wd4I1Da09GFEQ36VGk59xjJbJRFIcyX0OR
         2PcL/1Bjpelc2vyJAV6b97GMr9wt+TwKOOt9LUoxKwMSFBnaH3/Uo0n3UAxOkwyPLOEQ
         lcmg==
X-Gm-Message-State: AC+VfDzMALdnw6l34VzJfEHkcEavq+z5zsr3RB1h5b9pDf/6u39q5uTc
        zR6DDrJt8O4mvZ+ami9cD4BL7xDzJMqo
X-Google-Smtp-Source: ACHHUZ6WMEN7idXnU/VWHASHeISuEfNCCm7PXy0MZqrOn2a71/vb5gooPGjkgo7nl4VEEiYzf+C85byzoPvG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a25:ada7:0:b0:b95:8a6b:da93 with SMTP id
 z39-20020a25ada7000000b00b958a6bda93mr2261581ybi.9.1682667816111; Fri, 28 Apr
 2023 00:43:36 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:38:03 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-38-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 37/43] perf metrics: Be PMU specific for referenced metrics.
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hybrid systems may define the same metric for different PMUs, this can
cause confusion of events. To avoid this make the referenced metric
searches PMU specific, matching that in the table.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c          |  6 +-
 tools/perf/pmu-events/jevents.py   |  4 +-
 tools/perf/pmu-events/pmu-events.h |  1 +
 tools/perf/util/metricgroup.c      | 94 +++++++++++++++++++++---------
 tools/perf/util/metricgroup.h      |  2 +-
 5 files changed, 75 insertions(+), 32 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 06a1d71a49a5..bb1a4ecd7558 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1794,7 +1794,7 @@ static int add_default_attributes(void)
 		 * will use this approach. To determine transaction support
 		 * on an architecture test for such a metric name.
 		 */
-		if (!metricgroup__has_metric("transaction")) {
+		if (!metricgroup__has_metric("all", "transaction")) {
 			pr_err("Missing transaction metrics");
 			return -1;
 		}
@@ -1823,7 +1823,7 @@ static int add_default_attributes(void)
 			smi_reset = true;
 		}
 
-		if (!metricgroup__has_metric("smi")) {
+		if (!metricgroup__has_metric("all", "smi")) {
 			pr_err("Missing smi metrics");
 			return -1;
 		}
@@ -1903,7 +1903,7 @@ static int add_default_attributes(void)
 		 * caused by exposing latent bugs. This is fixed properly in:
 		 * https://lore.kernel.org/lkml/bff481ba-e60a-763f-0aa0-3ee53302c480@linux.intel.com/
 		 */
-		if (metricgroup__has_metric("TopdownL1") && !perf_pmu__has_hybrid()) {
+		if (metricgroup__has_metric("all", "TopdownL1") && !perf_pmu__has_hybrid()) {
 			struct evlist *metric_evlist = evlist__new();
 			struct evsel *metric_evsel;
 
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index f57a8f274025..b18dd2fcbf04 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -51,8 +51,8 @@ _json_event_attributes = [
 
 # Attributes that are in pmu_metric rather than pmu_event.
 _json_metric_attributes = [
-    'metric_name', 'metric_group', 'metric_expr', 'metric_threshold', 'desc',
-    'long_desc', 'unit', 'compat', 'metricgroup_no_group', 'aggr_mode',
+    'pmu', 'metric_name', 'metric_group', 'metric_expr', 'metric_threshold',
+    'desc', 'long_desc', 'unit', 'compat', 'metricgroup_no_group', 'aggr_mode',
     'event_grouping'
 ]
 # Attributes that are bools or enum int values, encoded as '0', '1',...
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 80349685cf4d..3549e6971a4d 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -51,6 +51,7 @@ struct pmu_event {
 };
 
 struct pmu_metric {
+	const char *pmu;
 	const char *metric_name;
 	const char *metric_group;
 	const char *metric_expr;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 1afc8d7a5838..17478eb33bdc 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -123,6 +123,7 @@ struct metric {
 	 * within the expression.
 	 */
 	struct expr_parse_ctx *pctx;
+	const char *pmu;
 	/** The name of the metric such as "IPC". */
 	const char *metric_name;
 	/** Modifier on the metric such as "u" or NULL for none. */
@@ -216,6 +217,7 @@ static struct metric *metric__new(const struct pmu_metric *pm,
 	if (!m->pctx)
 		goto out_err;
 
+	m->pmu = pm->pmu ?: "cpu";
 	m->metric_name = pm->metric_name;
 	m->modifier = NULL;
 	if (modifier) {
@@ -259,11 +261,12 @@ static bool contains_metric_id(struct evsel **metric_events, int num_events,
 /**
  * setup_metric_events - Find a group of events in metric_evlist that correspond
  *                       to the IDs from a parsed metric expression.
+ * @pmu: The PMU for the IDs.
  * @ids: the metric IDs to match.
  * @metric_evlist: the list of perf events.
  * @out_metric_events: holds the created metric events array.
  */
-static int setup_metric_events(struct hashmap *ids,
+static int setup_metric_events(const char *pmu, struct hashmap *ids,
 			       struct evlist *metric_evlist,
 			       struct evsel ***out_metric_events)
 {
@@ -271,6 +274,7 @@ static int setup_metric_events(struct hashmap *ids,
 	const char *metric_id;
 	struct evsel *ev;
 	size_t ids_size, matched_events, i;
+	bool all_pmus = !strcmp(pmu, "all");
 
 	*out_metric_events = NULL;
 	ids_size = hashmap__size(ids);
@@ -283,6 +287,8 @@ static int setup_metric_events(struct hashmap *ids,
 	evlist__for_each_entry(metric_evlist, ev) {
 		struct expr_id_data *val_ptr;
 
+		if (!all_pmus && strcmp(ev->pmu_name, pmu))
+			continue;
 		/*
 		 * Check for duplicate events with the same name. For
 		 * example, uncore_imc/cas_count_read/ will turn into 6
@@ -355,8 +361,13 @@ static bool match_metric(const char *n, const char *list)
 	return false;
 }
 
-static bool match_pm_metric(const struct pmu_metric *pm, const char *metric)
+static bool match_pm_metric(const struct pmu_metric *pm, const char *pmu, const char *metric)
 {
+	const char *pm_pmu = pm->pmu ?: "cpu";
+
+	if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu))
+		return false;
+
 	return match_metric(pm->metric_group, metric) ||
 	       match_metric(pm->metric_name, metric);
 }
@@ -766,6 +777,7 @@ struct visited_metric {
 
 struct metricgroup_add_iter_data {
 	struct list_head *metric_list;
+	const char *pmu;
 	const char *metric_name;
 	const char *modifier;
 	int *ret;
@@ -779,7 +791,8 @@ struct metricgroup_add_iter_data {
 	const struct pmu_metrics_table *table;
 };
 
-static bool metricgroup__find_metric(const char *metric,
+static bool metricgroup__find_metric(const char *pmu,
+				     const char *metric,
 				     const struct pmu_metrics_table *table,
 				     struct pmu_metric *pm);
 
@@ -798,6 +811,7 @@ static int add_metric(struct list_head *metric_list,
  * resolve_metric - Locate metrics within the root metric and recursively add
  *                    references to them.
  * @metric_list: The list the metric is added to.
+ * @pmu: The PMU name to resolve metrics on, or "all" for all PMUs.
  * @modifier: if non-null event modifiers like "u".
  * @metric_no_group: Should events written to events be grouped "{}" or
  *                   global. Grouping is the default but due to multiplexing the
@@ -813,6 +827,7 @@ static int add_metric(struct list_head *metric_list,
  *       architecture perf is running upon.
  */
 static int resolve_metric(struct list_head *metric_list,
+			  const char *pmu,
 			  const char *modifier,
 			  bool metric_no_group,
 			  bool metric_no_threshold,
@@ -842,7 +857,7 @@ static int resolve_metric(struct list_head *metric_list,
 	hashmap__for_each_entry(root_metric->pctx->ids, cur, bkt) {
 		struct pmu_metric pm;
 
-		if (metricgroup__find_metric(cur->pkey, table, &pm)) {
+		if (metricgroup__find_metric(pmu, cur->pkey, table, &pm)) {
 			pending = realloc(pending,
 					(pending_cnt + 1) * sizeof(struct to_resolve));
 			if (!pending)
@@ -993,9 +1008,12 @@ static int __add_metric(struct list_head *metric_list,
 	}
 	if (!ret) {
 		/* Resolve referenced metrics. */
-		ret = resolve_metric(metric_list, modifier, metric_no_group,
+		const char *pmu = pm->pmu ?: "cpu";
+
+		ret = resolve_metric(metric_list, pmu, modifier, metric_no_group,
 				     metric_no_threshold, user_requested_cpu_list,
-				     system_wide, root_metric, &visited_node, table);
+				     system_wide, root_metric, &visited_node,
+				     table);
 	}
 	if (ret) {
 		if (is_root)
@@ -1008,6 +1026,7 @@ static int __add_metric(struct list_head *metric_list,
 }
 
 struct metricgroup__find_metric_data {
+	const char *pmu;
 	const char *metric;
 	struct pmu_metric *pm;
 };
@@ -1017,6 +1036,10 @@ static int metricgroup__find_metric_callback(const struct pmu_metric *pm,
 					     void *vdata)
 {
 	struct metricgroup__find_metric_data *data = vdata;
+	const char *pm_pmu = pm->pmu ?: "cpu";
+
+	if (strcmp(data->pmu, "all") && strcmp(pm_pmu, data->pmu))
+		return 0;
 
 	if (!match_metric(pm->metric_name, data->metric))
 		return 0;
@@ -1025,11 +1048,13 @@ static int metricgroup__find_metric_callback(const struct pmu_metric *pm,
 	return 1;
 }
 
-static bool metricgroup__find_metric(const char *metric,
+static bool metricgroup__find_metric(const char *pmu,
+				     const char *metric,
 				     const struct pmu_metrics_table *table,
 				     struct pmu_metric *pm)
 {
 	struct metricgroup__find_metric_data data = {
+		.pmu = pmu,
 		.metric = metric,
 		.pm = pm,
 	};
@@ -1083,7 +1108,7 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_metric *pm,
 	struct metricgroup_add_iter_data *d = data;
 	int ret;
 
-	if (!match_pm_metric(pm, d->metric_name))
+	if (!match_pm_metric(pm, d->pmu, d->metric_name))
 		return 0;
 
 	ret = add_metric(d->metric_list, pm, d->modifier, d->metric_no_group,
@@ -1128,6 +1153,7 @@ static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
 
 struct metricgroup__add_metric_data {
 	struct list_head *list;
+	const char *pmu;
 	const char *metric_name;
 	const char *modifier;
 	const char *user_requested_cpu_list;
@@ -1144,7 +1170,7 @@ static int metricgroup__add_metric_callback(const struct pmu_metric *pm,
 	struct metricgroup__add_metric_data *data = vdata;
 	int ret = 0;
 
-	if (pm->metric_expr && match_pm_metric(pm, data->metric_name)) {
+	if (pm->metric_expr && match_pm_metric(pm, data->pmu, data->metric_name)) {
 		bool metric_no_group = data->metric_no_group ||
 			match_metric(data->metric_name, pm->metricgroup_no_group);
 
@@ -1159,6 +1185,7 @@ static int metricgroup__add_metric_callback(const struct pmu_metric *pm,
 
 /**
  * metricgroup__add_metric - Find and add a metric, or a metric group.
+ * @pmu: The PMU name to search for metrics on, or "all" for all PMUs.
  * @metric_name: The name of the metric or metric group. For example, "IPC"
  *               could be the name of a metric and "TopDownL1" the name of a
  *               metric group.
@@ -1172,7 +1199,7 @@ static int metricgroup__add_metric_callback(const struct pmu_metric *pm,
  * @table: The table that is searched for metrics, most commonly the table for the
  *       architecture perf is running upon.
  */
-static int metricgroup__add_metric(const char *metric_name, const char *modifier,
+static int metricgroup__add_metric(const char *pmu, const char *metric_name, const char *modifier,
 				   bool metric_no_group, bool metric_no_threshold,
 				   const char *user_requested_cpu_list,
 				   bool system_wide,
@@ -1186,6 +1213,7 @@ static int metricgroup__add_metric(const char *metric_name, const char *modifier
 	{
 		struct metricgroup__add_metric_data data = {
 			.list = &list,
+			.pmu = pmu,
 			.metric_name = metric_name,
 			.modifier = modifier,
 			.metric_no_group = metric_no_group,
@@ -1210,6 +1238,7 @@ static int metricgroup__add_metric(const char *metric_name, const char *modifier
 			.fn = metricgroup__add_metric_sys_event_iter,
 			.data = (void *) &(struct metricgroup_add_iter_data) {
 				.metric_list = &list,
+				.pmu = pmu,
 				.metric_name = metric_name,
 				.modifier = modifier,
 				.metric_no_group = metric_no_group,
@@ -1239,6 +1268,7 @@ static int metricgroup__add_metric(const char *metric_name, const char *modifier
 /**
  * metricgroup__add_metric_list - Find and add metrics, or metric groups,
  *                                specified in a list.
+ * @pmu: A pmu to restrict the metrics to, or "all" for all PMUS.
  * @list: the list of metrics or metric groups. For example, "IPC,CPI,TopDownL1"
  *        would match the IPC and CPI metrics, and TopDownL1 would match all
  *        the metrics in the TopDownL1 group.
@@ -1251,7 +1281,8 @@ static int metricgroup__add_metric(const char *metric_name, const char *modifier
  * @table: The table that is searched for metrics, most commonly the table for the
  *       architecture perf is running upon.
  */
-static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
+static int metricgroup__add_metric_list(const char *pmu, const char *list,
+					bool metric_no_group,
 					bool metric_no_threshold,
 					const char *user_requested_cpu_list,
 					bool system_wide, struct list_head *metric_list,
@@ -1270,7 +1301,7 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 		if (modifier)
 			*modifier++ = '\0';
 
-		ret = metricgroup__add_metric(metric_name, modifier,
+		ret = metricgroup__add_metric(pmu, metric_name, modifier,
 					      metric_no_group, metric_no_threshold,
 					      user_requested_cpu_list,
 					      system_wide, metric_list, table);
@@ -1460,7 +1491,8 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 	return ret;
 }
 
-static int parse_groups(struct evlist *perf_evlist, const char *str,
+static int parse_groups(struct evlist *perf_evlist,
+			const char *pmu, const char *str,
 			bool metric_no_group,
 			bool metric_no_merge,
 			bool metric_no_threshold,
@@ -1478,7 +1510,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 
 	if (metric_events_list->nr_entries == 0)
 		metricgroup__rblist_init(metric_events_list);
-	ret = metricgroup__add_metric_list(str, metric_no_group, metric_no_threshold,
+	ret = metricgroup__add_metric_list(pmu, str, metric_no_group, metric_no_threshold,
 					   user_requested_cpu_list,
 					   system_wide, &metric_list, table);
 	if (ret)
@@ -1535,6 +1567,11 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 					    strcmp(m->modifier, n->modifier)))
 					continue;
 
+				if ((!m->pmu && n->pmu) ||
+				    (m->pmu && !n->pmu) ||
+				    (m->pmu && n->pmu && strcmp(m->pmu, n->pmu)))
+					continue;
+
 				if (expr__subset_of_ids(n->pctx, m->pctx)) {
 					pr_debug("Events in '%s' fully contained within '%s'\n",
 						 m->metric_name, n->metric_name);
@@ -1552,7 +1589,8 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 
 			metric_evlist = m->evlist;
 		}
-		ret = setup_metric_events(m->pctx->ids, metric_evlist, &metric_events);
+		ret = setup_metric_events(fake_pmu ? "all" : m->pmu, m->pctx->ids,
+					  metric_evlist, &metric_events);
 		if (ret) {
 			pr_debug("Cannot resolve IDs for %s: %s\n",
 				m->metric_name, m->metric_expr);
@@ -1623,7 +1661,7 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 	if (!table)
 		return -EINVAL;
 
-	return parse_groups(perf_evlist, str, metric_no_group, metric_no_merge,
+	return parse_groups(perf_evlist, "all", str, metric_no_group, metric_no_merge,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
 			    /*fake_pmu=*/NULL, metric_events, table);
 }
@@ -1633,7 +1671,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 				   const char *str,
 				   struct rblist *metric_events)
 {
-	return parse_groups(evlist, str,
+	return parse_groups(evlist, "all", str,
 			    /*metric_no_group=*/false,
 			    /*metric_no_merge=*/false,
 			    /*metric_no_threshold=*/false,
@@ -1642,28 +1680,32 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 			    &perf_pmu__fake, metric_events, table);
 }
 
+struct metricgroup__has_metric_data {
+	const char *pmu;
+	const char *metric;
+};
 static int metricgroup__has_metric_callback(const struct pmu_metric *pm,
 					    const struct pmu_metrics_table *table __maybe_unused,
 					    void *vdata)
 {
-	const char *metric = vdata;
-
-	if (match_metric(pm->metric_name, metric) ||
-	    match_metric(pm->metric_group, metric))
-		return 1;
+	struct metricgroup__has_metric_data *data = vdata;
 
-	return 0;
+	return match_pm_metric(pm, data->pmu, data->metric) ? 1 : 0;
 }
 
-bool metricgroup__has_metric(const char *metric)
+bool metricgroup__has_metric(const char *pmu, const char *metric)
 {
 	const struct pmu_metrics_table *table = pmu_metrics_table__find();
+	struct metricgroup__has_metric_data data = {
+		.pmu = pmu,
+		.metric = metric,
+	};
 
 	if (!table)
 		return false;
 
-	return pmu_metrics_table_for_each_metric(table, metricgroup__has_metric_callback,
-						(void *)metric) ? true : false;
+	return pmu_metrics_table_for_each_metric(table, metricgroup__has_metric_callback, &data)
+		? true : false;
 }
 
 static int metricgroup__topdown_max_level_callback(const struct pmu_metric *pm,
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 77472e35705e..08e9b9e953ec 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -80,7 +80,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 				   struct rblist *metric_events);
 
 void metricgroup__print(const struct print_callbacks *print_cb, void *print_state);
-bool metricgroup__has_metric(const char *metric);
+bool metricgroup__has_metric(const char *pmu, const char *metric);
 unsigned int metricgroups__topdown_max_level(void);
 int arch_get_runtimeparam(const struct pmu_metric *pm);
 void metricgroup__rblist_exit(struct rblist *metric_events);
-- 
2.40.1.495.gc816e09b53d-goog


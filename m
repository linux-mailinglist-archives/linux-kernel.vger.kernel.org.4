Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317E87265E3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjFGQ1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjFGQ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:27:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9549D1BF9;
        Wed,  7 Jun 2023 09:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686155245; x=1717691245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2C7aCX6G2hhSoQAmNKGVuPpL/IuHX6KOy5Rdk4ABEOg=;
  b=cRph+muB+AaRpZho2OlaIW41cA1IYQg0nb1QzUL6I1Xa2bNfqI/QhVHZ
   DcF5OLy6JEclw5rzzI/75WctVh2q4JKaKKnrL2W/m5iD8+HGMr3hM27QA
   kBL5dHsIPTt/v2/FMj7hqQ/02IPU+19383XqEVfnTITVf/wTlt6rLHqka
   1pt0+jWXiZToosqOMmyuPYCTwd3XBusXsFtti5M1MRUpUs6w+H2LoMjMt
   n6d5JeteQ3AtNhhHS9nRhcm/1BkP8ksJ3tC92JVHO3seQTQwnx4BK4MU9
   qQevtMgZHMpb6vQPYdhfBcuwhuKE63J7X3EaDbUoEVfai+6XC8gc4RZE3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="355892666"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="355892666"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 09:27:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="774697678"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="774697678"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jun 2023 09:27:22 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        irogers@google.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 6/8] perf stat,metrics: New metricgroup output for the default mode
Date:   Wed,  7 Jun 2023 09:26:58 -0700
Message-Id: <20230607162700.3234712-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230607162700.3234712-1-kan.liang@linux.intel.com>
References: <20230607162700.3234712-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

In the default mode, the current output of the metricgroup include both
events and metrics, which is not necessary and just makes the output
hard to read. Since different ARCHs (even different generations in the
same ARCH) may use different events. The output also vary on different
platforms.

For a metricgroup, only outputting the value of each metric is good
enough.

Current perf may append different metric groups to the same leader
event, or append the metrics from the same metricgroup to different
events. That could bring confusion when perf only prints the
metricgroup output mode. For example, print the same metricgroup name
several times.
Reorganize metricgroup for the default mode and make sure that
a metricgroup can only be appended to one event.
Sort the metricgroup for the default mode by the name of the
metricgroup.

Add a new field default_metricgroup in evsel to indicate an event of
the default metricgroup. For those events, printout() should print
the metricgroup name rather than events.

Add print_metricgroup_header() to print out the metricgroup name in
different output formats.

On SPR
Before:

 ./perf_old stat sleep 1

 Performance counter stats for 'sleep 1':

              0.54 msec task-clock:u                     #    0.001 CPUs utilized
                 0      context-switches:u               #    0.000 /sec
                 0      cpu-migrations:u                 #    0.000 /sec
                68      page-faults:u                    #  125.445 K/sec
           540,970      cycles:u                         #    0.998 GHz
           556,325      instructions:u                   #    1.03  insn per cycle
           123,602      branches:u                       #  228.018 M/sec
             6,889      branch-misses:u                  #    5.57% of all branches
         3,245,820      TOPDOWN.SLOTS:u                  #     18.4 %  tma_backend_bound
                                                  #     17.2 %  tma_retiring
                                                  #     23.1 %  tma_bad_speculation
                                                  #     41.4 %  tma_frontend_bound
           564,859      topdown-retiring:u
         1,370,999      topdown-fe-bound:u
           603,271      topdown-be-bound:u
           744,874      topdown-bad-spec:u
            12,661      INT_MISC.UOP_DROPPING:u          #   23.357 M/sec

       1.001798215 seconds time elapsed

       0.000193000 seconds user
       0.001700000 seconds sys

After:

$ ./perf stat sleep 1

 Performance counter stats for 'sleep 1':

              0.51 msec task-clock:u                     #    0.001 CPUs utilized
                 0      context-switches:u               #    0.000 /sec
                 0      cpu-migrations:u                 #    0.000 /sec
                68      page-faults:u                    #  132.683 K/sec
           545,228      cycles:u                         #    1.064 GHz
           555,509      instructions:u                   #    1.02  insn per cycle
           123,574      branches:u                       #  241.120 M/sec
             6,957      branch-misses:u                  #    5.63% of all branches
                        TopdownL1                 #     17.5 %  tma_backend_bound
                                                  #     22.6 %  tma_bad_speculation
                                                  #     42.7 %  tma_frontend_bound
                                                  #     17.1 %  tma_retiring
                        TopdownL2                 #     21.8 %  tma_branch_mispredicts
                                                  #     11.5 %  tma_core_bound
                                                  #     13.4 %  tma_fetch_bandwidth
                                                  #     29.3 %  tma_fetch_latency
                                                  #      2.7 %  tma_heavy_operations
                                                  #     14.5 %  tma_light_operations
                                                  #      0.8 %  tma_machine_clears
                                                  #      6.1 %  tma_memory_bound

       1.001712086 seconds time elapsed

       0.000151000 seconds user
       0.001618000 seconds sys


Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-stat.c      |   1 +
 tools/perf/util/evsel.h        |   1 +
 tools/perf/util/metricgroup.c  | 106 ++++++++++++++++++++++++++++++++-
 tools/perf/util/metricgroup.h  |   1 +
 tools/perf/util/stat-display.c |  69 ++++++++++++++++++++-
 5 files changed, 172 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2269b3e90e9b..b274cc264d56 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2172,6 +2172,7 @@ static int add_default_attributes(void)
 
 			evlist__for_each_entry(metric_evlist, metric_evsel) {
 				metric_evsel->skippable = true;
+				metric_evsel->default_metricgroup = true;
 			}
 			evlist__splice_list_tail(evsel_list, &metric_evlist->core.entries);
 			evlist__delete(metric_evlist);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 36a32e4ca168..61b1385108f4 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -130,6 +130,7 @@ struct evsel {
 	bool			reset_group;
 	bool			errored;
 	bool			needs_auxtrace_mmap;
+	bool			default_metricgroup;
 	struct hashmap		*per_pkg_mask;
 	int			err;
 	struct {
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index efafa02db5e5..22181ce4f27f 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -79,6 +79,7 @@ static struct rb_node *metric_event_new(struct rblist *rblist __maybe_unused,
 		return NULL;
 	memcpy(me, entry, sizeof(struct metric_event));
 	me->evsel = ((struct metric_event *)entry)->evsel;
+	me->default_metricgroup_name = NULL;
 	INIT_LIST_HEAD(&me->head);
 	return &me->nd;
 }
@@ -1133,14 +1134,19 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_metric *pm,
 /**
  * metric_list_cmp - list_sort comparator that sorts metrics with more events to
  *                   the front. tool events are excluded from the count.
+ *                   For the default metrics, sort them by metricgroup name.
  */
-static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
+static int metric_list_cmp(void *priv, const struct list_head *l,
 			   const struct list_head *r)
 {
 	const struct metric *left = container_of(l, struct metric, nd);
 	const struct metric *right = container_of(r, struct metric, nd);
 	struct expr_id_data *data;
 	int i, left_count, right_count;
+	bool is_default = *(bool *)priv;
+
+	if (is_default && left->default_metricgroup_name && right->default_metricgroup_name)
+		return strcmp(left->default_metricgroup_name, right->default_metricgroup_name);
 
 	left_count = hashmap__size(left->pctx->ids);
 	perf_tool_event__for_each_event(i) {
@@ -1497,6 +1503,91 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 	return ret;
 }
 
+static struct metric_event *
+metricgroup__lookup_default_metricgroup(struct rblist *metric_events,
+					struct evsel *evsel,
+					struct metric *m)
+{
+	struct metric_event *me;
+	char *name;
+	int err;
+
+	me = metricgroup__lookup(metric_events, evsel, true);
+	if (!me->default_metricgroup_name) {
+		if (m->pmu && strcmp(m->pmu, "cpu"))
+			err = asprintf(&name, "%s (%s)", m->default_metricgroup_name, m->pmu);
+		else
+			err = asprintf(&name, "%s", m->default_metricgroup_name);
+		if (err < 0)
+			return NULL;
+		me->default_metricgroup_name = name;
+	}
+	if (!strncmp(m->default_metricgroup_name,
+		     me->default_metricgroup_name,
+		     strlen(m->default_metricgroup_name)))
+		return me;
+
+	return NULL;
+}
+
+static struct metric_event *
+metricgroup__lookup_create(struct rblist *metric_events,
+			   struct evsel **evsel,
+			   struct list_head *metric_list,
+			   struct metric *m,
+			   bool is_default)
+{
+	struct metric_event *me;
+	struct metric *cur;
+	struct evsel *ev;
+	size_t i;
+
+	if (!is_default)
+		return metricgroup__lookup(metric_events, evsel[0], true);
+
+	/*
+	 * If the metric group has been attached to a previous
+	 * event/metric, use that metric event.
+	 */
+	list_for_each_entry(cur, metric_list, nd) {
+		if (cur == m)
+			break;
+		if (cur->pmu && strcmp(m->pmu, cur->pmu))
+			continue;
+		if (strncmp(m->default_metricgroup_name,
+			    cur->default_metricgroup_name,
+			    strlen(m->default_metricgroup_name)))
+			continue;
+		if (!cur->evlist)
+			continue;
+		evlist__for_each_entry(cur->evlist, ev) {
+			me = metricgroup__lookup(metric_events, ev, false);
+			if (!strncmp(m->default_metricgroup_name,
+				     me->default_metricgroup_name,
+				     strlen(m->default_metricgroup_name)))
+				return me;
+		}
+	}
+
+	/*
+	 * Different metric groups may append to the same leader event.
+	 * For example, TopdownL1 and TopdownL2 are appended to the
+	 * TOPDOWN.SLOTS event.
+	 * Split it and append the new metric group to the next available
+	 * event.
+	 */
+	me = metricgroup__lookup_default_metricgroup(metric_events, evsel[0], m);
+	if (me)
+		return me;
+
+	for (i = 1; i < hashmap__size(m->pctx->ids); i++) {
+		me = metricgroup__lookup_default_metricgroup(metric_events, evsel[i], m);
+		if (me)
+			return me;
+	}
+	return NULL;
+}
+
 static int parse_groups(struct evlist *perf_evlist,
 			const char *pmu, const char *str,
 			bool metric_no_group,
@@ -1512,6 +1603,7 @@ static int parse_groups(struct evlist *perf_evlist,
 	LIST_HEAD(metric_list);
 	struct metric *m;
 	bool tool_events[PERF_TOOL_MAX] = {false};
+	bool is_default = !strcmp(str, "Default");
 	int ret;
 
 	if (metric_events_list->nr_entries == 0)
@@ -1523,7 +1615,7 @@ static int parse_groups(struct evlist *perf_evlist,
 		goto out;
 
 	/* Sort metrics from largest to smallest. */
-	list_sort(NULL, &metric_list, metric_list_cmp);
+	list_sort((void *)&is_default, &metric_list, metric_list_cmp);
 
 	if (!metric_no_merge) {
 		struct expr_parse_ctx *combined = NULL;
@@ -1603,7 +1695,15 @@ static int parse_groups(struct evlist *perf_evlist,
 			goto out;
 		}
 
-		me = metricgroup__lookup(metric_events_list, metric_events[0], true);
+		me = metricgroup__lookup_create(metric_events_list,
+						metric_events,
+						&metric_list, m,
+						is_default);
+		if (!me) {
+			pr_err("Cannot create metric group for default!\n");
+			ret = -EINVAL;
+			goto out;
+		}
 
 		expr = malloc(sizeof(struct metric_expr));
 		if (!expr) {
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index bf18274c15df..e3609b853213 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -22,6 +22,7 @@ struct cgroup;
 struct metric_event {
 	struct rb_node nd;
 	struct evsel *evsel;
+	char *default_metricgroup_name;
 	struct list_head head; /* list of metric_expr */
 };
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index a2bbdc25d979..efe5fd04c033 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -21,10 +21,12 @@
 #include "iostat.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "metricgroup.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
 
+#define MGROUP_LEN   50
 #define METRIC_LEN   38
 #define EVNAME_LEN   32
 #define COUNTS_LEN   18
@@ -707,6 +709,55 @@ static bool evlist__has_hybrid(struct evlist *evlist)
 	return false;
 }
 
+static void print_metricgroup_header_json(struct perf_stat_config *config,
+					  struct outstate *os __maybe_unused,
+					  const char *metricgroup_name)
+{
+	fprintf(config->output, "\"metricgroup\" : \"%s\"}", metricgroup_name);
+	new_line_json(config, (void *)os);
+}
+
+static void print_metricgroup_header_csv(struct perf_stat_config *config,
+					 struct outstate *os,
+					 const char *metricgroup_name)
+{
+	int i;
+
+	for (i = 0; i < os->nfields; i++)
+		fputs(config->csv_sep, os->fh);
+	fprintf(config->output, "%s", metricgroup_name);
+	new_line_csv(config, (void *)os);
+}
+
+static void print_metricgroup_header_std(struct perf_stat_config *config,
+					 struct outstate *os __maybe_unused,
+					 const char *metricgroup_name)
+{
+	int n = fprintf(config->output, " %*s", EVNAME_LEN, metricgroup_name);
+
+	fprintf(config->output, "%*s", MGROUP_LEN - n - 1, "");
+}
+
+static void print_metricgroup_header(struct perf_stat_config *config,
+				     struct outstate *os,
+				     struct evsel *counter,
+				     double noise, u64 run, u64 ena,
+				     const char *metricgroup_name)
+{
+	aggr_printout(config, os->evsel, os->id, os->aggr_nr);
+
+	print_noise(config, counter, noise, /*before_metric=*/true);
+	print_running(config, run, ena, /*before_metric=*/true);
+
+	if (config->json_output) {
+		print_metricgroup_header_json(config, os, metricgroup_name);
+	} else if (config->csv_output) {
+		print_metricgroup_header_csv(config, os, metricgroup_name);
+	} else
+		print_metricgroup_header_std(config, os, metricgroup_name);
+
+}
+
 static void printout(struct perf_stat_config *config, struct outstate *os,
 		     double uval, u64 run, u64 ena, double noise, int aggr_idx)
 {
@@ -751,10 +802,17 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 	out.force_header = false;
 
 	if (!config->metric_only) {
-		abs_printout(config, os->id, os->aggr_nr, counter, uval, ok);
+		if (counter->default_metricgroup) {
+			struct metric_event *me;
 
-		print_noise(config, counter, noise, /*before_metric=*/true);
-		print_running(config, run, ena, /*before_metric=*/true);
+			me = metricgroup__lookup(&config->metric_events, counter, false);
+			print_metricgroup_header(config, os, counter, noise, run, ena,
+						 me->default_metricgroup_name);
+		} else {
+			abs_printout(config, os->id, os->aggr_nr, counter, uval, ok);
+			print_noise(config, counter, noise, /*before_metric=*/true);
+			print_running(config, run, ena, /*before_metric=*/true);
+		}
 	}
 
 	if (ok) {
@@ -883,6 +941,11 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	if (counter->merged_stat)
 		return;
 
+	/* Only print the metric group for the default mode */
+	if (counter->default_metricgroup &&
+	    !metricgroup__lookup(&config->metric_events, counter, false))
+		return;
+
 	uniquify_counter(config, counter);
 
 	val = aggr->counts.val;
-- 
2.35.1


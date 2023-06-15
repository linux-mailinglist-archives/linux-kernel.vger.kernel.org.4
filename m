Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C65731A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344738AbjFONzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344623AbjFONyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:54:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902B81FC3;
        Thu, 15 Jun 2023 06:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686837281; x=1718373281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/FnJZdMwlQQZIUSxTi3LJ8ojDm8gHHob8sQIkP1gAag=;
  b=LyZmty9MGohiP+kj4x6TqcaMTKzHx5exVHfIMY6v1NBygjFjSsKQfJ9T
   aOCTcByaJv5w+ANfudbJud4OUQrn6X6CUfX4Zw8oF0/7hRyGrVa97vbMZ
   97UwgoUbgFqignrUII1cuLcBTxkc933WZH4BrBme5tcYC9bl9g1e/zH5B
   6aXTKwHgU5cWYFL8MA5uKHLN2+lGlDmOOg8Zngkmw89ApiWrVs4DMxoHS
   ZlnlqwfRQGw4tkcOAPWY4azHDVDYL2uMgxQv4FW4tVaXFjp0tcfbDOFn2
   Sw3hJwhP9qb4rrBVSXPH/i7UG3FtaFxhPwM2tNRMHXR7oOQGvrpYgANYR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356411411"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="356411411"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 06:54:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="782527063"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="782527063"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2023 06:54:40 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        irogers@google.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 5/8] perf stat: New metricgroup output for the default mode
Date:   Thu, 15 Jun 2023 06:53:12 -0700
Message-Id: <20230615135315.3662428-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230615135315.3662428-1-kan.liang@linux.intel.com>
References: <20230615135315.3662428-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Add a new field default_metricgroup in evsel to indicate an event of
the default metricgroup. For those events, printout() should print
the metricgroup name rather than each event.

Add perf_stat__skip_metric_event() to skip the evsel in the Default
metricgroup, if it's not running or not the metric event.

Add print_metricgroup_header_t to pass the functions which print the
display name of each metricgroup in the Default metricgroup. Support
all three output methods.

Factor out perf_stat__print_shadow_stats_metricgroup() to print out
each metrics.

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

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-stat.c      |   1 +
 tools/perf/util/evsel.h        |   1 +
 tools/perf/util/stat-display.c | 108 ++++++++++++++++++++++++++++++---
 tools/perf/util/stat-shadow.c  | 108 +++++++++++++++++++++++++++++----
 tools/perf/util/stat.h         |  15 +++++
 5 files changed, 211 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 55601b4b5c34..3f4e76f76f94 100644
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
index cc6fb3049b99..9f06d6cd5379 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -131,6 +131,7 @@ struct evsel {
 	bool			reset_group;
 	bool			errored;
 	bool			needs_auxtrace_mmap;
+	bool			default_metricgroup; /* A member of the Default metricgroup */
 	struct hashmap		*per_pkg_mask;
 	int			err;
 	struct {
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index a2bbdc25d979..7329b3340f88 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -25,6 +25,7 @@
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
 
+#define MGROUP_LEN   50
 #define METRIC_LEN   38
 #define EVNAME_LEN   32
 #define COUNTS_LEN   18
@@ -364,16 +365,27 @@ static void new_line_std(struct perf_stat_config *config __maybe_unused,
 	os->newline = true;
 }
 
-static void do_new_line_std(struct perf_stat_config *config,
-			    struct outstate *os)
+static inline void __new_line_std_csv(struct perf_stat_config *config,
+				      struct outstate *os)
 {
 	fputc('\n', os->fh);
 	if (os->prefix)
 		fputs(os->prefix, os->fh);
 	aggr_printout(config, os->evsel, os->id, os->aggr_nr);
+}
+
+static inline void __new_line_std(struct outstate *os)
+{
+	fprintf(os->fh, "                                                 ");
+}
+
+static void do_new_line_std(struct perf_stat_config *config,
+			    struct outstate *os)
+{
+	__new_line_std_csv(config, os);
 	if (config->aggr_mode == AGGR_NONE)
 		fprintf(os->fh, "        ");
-	fprintf(os->fh, "                                                 ");
+	__new_line_std(os);
 }
 
 static void print_metric_std(struct perf_stat_config *config,
@@ -408,10 +420,7 @@ static void new_line_csv(struct perf_stat_config *config, void *ctx)
 	struct outstate *os = ctx;
 	int i;
 
-	fputc('\n', os->fh);
-	if (os->prefix)
-		fprintf(os->fh, "%s", os->prefix);
-	aggr_printout(config, os->evsel, os->id, os->aggr_nr);
+	__new_line_std_csv(config, os);
 	for (i = 0; i < os->nfields; i++)
 		fputs(config->csv_sep, os->fh);
 }
@@ -462,6 +471,54 @@ static void new_line_json(struct perf_stat_config *config, void *ctx)
 	aggr_printout(config, os->evsel, os->id, os->aggr_nr);
 }
 
+static void print_metricgroup_header_json(struct perf_stat_config *config,
+					  void *ctx,
+					  const char *metricgroup_name)
+{
+	if (!metricgroup_name)
+		return;
+
+	fprintf(config->output, "\"metricgroup\" : \"%s\"}", metricgroup_name);
+	new_line_json(config, ctx);
+}
+
+static void print_metricgroup_header_csv(struct perf_stat_config *config,
+					 void *ctx,
+					 const char *metricgroup_name)
+{
+	struct outstate *os = ctx;
+	int i;
+
+	if (!metricgroup_name) {
+		/* Leave space for running and enabling */
+		for (i = 0; i < os->nfields - 2; i++)
+			fputs(config->csv_sep, os->fh);
+		return;
+	}
+
+	for (i = 0; i < os->nfields; i++)
+		fputs(config->csv_sep, os->fh);
+	fprintf(config->output, "%s", metricgroup_name);
+	new_line_csv(config, ctx);
+}
+
+static void print_metricgroup_header_std(struct perf_stat_config *config,
+					 void *ctx,
+					 const char *metricgroup_name)
+{
+	struct outstate *os = ctx;
+	int n;
+
+	if (!metricgroup_name) {
+		__new_line_std(os);
+		return;
+	}
+
+	n = fprintf(config->output, " %*s", EVNAME_LEN, metricgroup_name);
+
+	fprintf(config->output, "%*s", MGROUP_LEN - n - 1, "");
+}
+
 /* Filter out some columns that don't work well in metrics only mode */
 
 static bool valid_only_metric(const char *unit)
@@ -713,19 +770,23 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 	struct perf_stat_output_ctx out;
 	print_metric_t pm;
 	new_line_t nl;
+	print_metricgroup_header_t pmh;
 	bool ok = true;
 	struct evsel *counter = os->evsel;
 
 	if (config->csv_output) {
 		pm = config->metric_only ? print_metric_only_csv : print_metric_csv;
 		nl = config->metric_only ? new_line_metric : new_line_csv;
+		pmh = print_metricgroup_header_csv;
 		os->nfields = 4 + (counter->cgrp ? 1 : 0);
 	} else if (config->json_output) {
 		pm = config->metric_only ? print_metric_only_json : print_metric_json;
 		nl = config->metric_only ? new_line_metric : new_line_json;
+		pmh = print_metricgroup_header_json;
 	} else {
 		pm = config->metric_only ? print_metric_only : print_metric_std;
 		nl = config->metric_only ? new_line_metric : new_line_std;
+		pmh = print_metricgroup_header_std;
 	}
 
 	if (run == 0 || ena == 0 || counter->counts->scaled == -1) {
@@ -747,10 +808,11 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 
 	out.print_metric = pm;
 	out.new_line = nl;
+	out.print_metricgroup_header = pmh;
 	out.ctx = os;
 	out.force_header = false;
 
-	if (!config->metric_only) {
+	if (!config->metric_only && !counter->default_metricgroup) {
 		abs_printout(config, os->id, os->aggr_nr, counter, uval, ok);
 
 		print_noise(config, counter, noise, /*before_metric=*/true);
@@ -758,8 +820,31 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 	}
 
 	if (ok) {
-		perf_stat__print_shadow_stats(config, counter, uval, aggr_idx,
-					      &out, &config->metric_events);
+		if (!config->metric_only && counter->default_metricgroup) {
+			void *from = NULL;
+
+			aggr_printout(config, os->evsel, os->id, os->aggr_nr);
+			/* Print out all the metricgroup with the same metric event. */
+			do {
+				int num = 0;
+
+				/* Print out the new line for the next new metricgroup. */
+				if (from) {
+					if (config->json_output)
+						new_line_json(config, (void *)os);
+					else
+						__new_line_std_csv(config, os);
+				}
+
+				print_noise(config, counter, noise, /*before_metric=*/true);
+				print_running(config, run, ena, /*before_metric=*/true);
+				from = perf_stat__print_shadow_stats_metricgroup(config, counter, aggr_idx,
+										 &num, from, &out,
+										 &config->metric_events);
+			} while (from != NULL);
+		} else
+			perf_stat__print_shadow_stats(config, counter, uval, aggr_idx,
+						      &out, &config->metric_events);
 	} else {
 		pm(config, os, /*color=*/NULL, /*format=*/NULL, /*unit=*/"", /*val=*/0);
 	}
@@ -889,6 +974,9 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	ena = aggr->counts.ena;
 	run = aggr->counts.run;
 
+	if (perf_stat__skip_metric_event(counter, &config->metric_events, ena, run))
+		return;
+
 	if (val == 0 && should_skip_zero_counter(config, counter, &id))
 		return;
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 1566a206ba42..b25974670d30 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -539,6 +539,83 @@ double test_generic_metric(struct metric_expr *mexp, int aggr_idx)
 	return ratio;
 }
 
+/**
+ * perf_stat__print_shadow_stats_metricgroup - Print out metrics associated with the evsel
+ *					       For the non-default, all metrics associated
+ *					       with the evsel are printed.
+ *					       For the default mode, only the metrics from
+ *					       the same metricgroup and the name of the
+ *					       metricgroup are printed. To print the metrics
+ *					       from the next metricgroup (if available),
+ *					       invoke the function with correspoinding
+ *					       metric_expr.
+ */
+void *perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config *config,
+						struct evsel *evsel,
+						int aggr_idx,
+						int *num,
+						void *from,
+						struct perf_stat_output_ctx *out,
+						struct rblist *metric_events)
+{
+	struct metric_event *me;
+	struct metric_expr *mexp = from;
+	void *ctxp = out->ctx;
+	bool header_printed = false;
+	const char *name = NULL;
+	static const char *last_name;
+
+	me = metricgroup__lookup(metric_events, evsel, false);
+	if (me == NULL)
+		return NULL;
+
+	if (!mexp)
+		mexp = list_first_entry(&me->head, typeof(*mexp), nd);
+
+	list_for_each_entry_from(mexp, &me->head, nd) {
+		/* Print the display name of the Default metricgroup */
+		if (me->is_default) {
+			if (!name)
+				name = mexp->default_metricgroup_name;
+			/*
+			 * Two or more metricgroup may share the same metric
+			 * event, e.g., TopdownL1 and TopdownL2 on SPR.
+			 * Return and print the prefix, e.g., noise, running
+			 * for the next metricgroup.
+			 */
+			if (strcmp(name, mexp->default_metricgroup_name))
+				return (void *)mexp;
+			/* Only print the name of the metricgroup once */
+			if (!header_printed) {
+				header_printed = true;
+				if (!last_name || strcmp(last_name, name)) {
+					/* Print out the name for the new metricgroup. */
+					out->print_metricgroup_header(config, ctxp, name);
+					last_name = name;
+				} else if (!strcmp(last_name, name)) {
+					/*
+					 * A metricgroup may have several metric events,
+					 * e.g.,TopdownL1 on e-core of ADL.
+					 * The name has been output by the first metric
+					 * event. Only align with other metics from
+					 * different metric events.
+					 */
+					out->print_metricgroup_header(config, ctxp, NULL);
+				}
+			}
+		}
+
+		if ((*num)++ > 0)
+			out->new_line(config, ctxp);
+		generic_metric(config, mexp->metric_expr, mexp->metric_threshold,
+			       mexp->metric_events, mexp->metric_refs, evsel->name,
+			       mexp->metric_name, mexp->metric_unit, mexp->runtime,
+			       aggr_idx, out);
+	}
+
+	return NULL;
+}
+
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct evsel *evsel,
 				   double avg, int aggr_idx,
@@ -565,7 +642,6 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	};
 	print_metric_t print_metric = out->print_metric;
 	void *ctxp = out->ctx;
-	struct metric_event *me;
 	int num = 1;
 
 	if (config->iostat_run) {
@@ -592,18 +668,26 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		}
 	}
 
-	if ((me = metricgroup__lookup(metric_events, evsel, false)) != NULL) {
-		struct metric_expr *mexp;
+	perf_stat__print_shadow_stats_metricgroup(config, evsel, aggr_idx,
+						  &num, NULL, out, metric_events);
 
-		list_for_each_entry (mexp, &me->head, nd) {
-			if (num++ > 0)
-				out->new_line(config, ctxp);
-			generic_metric(config, mexp->metric_expr, mexp->metric_threshold,
-				       mexp->metric_events, mexp->metric_refs, evsel->name,
-				       mexp->metric_name, mexp->metric_unit, mexp->runtime,
-				       aggr_idx, out);
-		}
-	}
 	if (num == 0)
 		print_metric(config, ctxp, NULL, NULL, NULL, 0);
 }
+
+/**
+ * perf_stat__skip_metric_event - Skip the evsel in the Default metricgroup,
+ *				  if it's not running or not the metric event.
+ */
+bool perf_stat__skip_metric_event(struct evsel *evsel,
+				  struct rblist *metric_events,
+				  u64 ena, u64 run)
+{
+	if (!evsel->default_metricgroup)
+		return false;
+
+	if (!ena || !run)
+		return true;
+
+	return !metricgroup__lookup(metric_events, evsel, false);
+}
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 7abff7cbb5a1..934f79778cea 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -158,11 +158,16 @@ typedef void (*print_metric_t)(struct perf_stat_config *config,
 			       const char *fmt, double val);
 typedef void (*new_line_t)(struct perf_stat_config *config, void *ctx);
 
+/* Used to print the display name of the Default metricgroup for now. */
+typedef void (*print_metricgroup_header_t)(struct perf_stat_config *config,
+					   void *ctx, const char *metricgroup_name);
+
 void perf_stat__reset_shadow_stats(void);
 struct perf_stat_output_ctx {
 	void *ctx;
 	print_metric_t print_metric;
 	new_line_t new_line;
+	print_metricgroup_header_t print_metricgroup_header;
 	bool force_header;
 };
 
@@ -171,6 +176,16 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   double avg, int aggr_idx,
 				   struct perf_stat_output_ctx *out,
 				   struct rblist *metric_events);
+bool perf_stat__skip_metric_event(struct evsel *evsel,
+				  struct rblist *metric_events,
+				  u64 ena, u64 run);
+void *perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config *config,
+						struct evsel *evsel,
+						int aggr_idx,
+						int *num,
+						void *from,
+						struct perf_stat_output_ctx *out,
+						struct rblist *metric_events);
 
 int evlist__alloc_stats(struct perf_stat_config *config,
 			struct evlist *evlist, bool alloc_raw);
-- 
2.35.1


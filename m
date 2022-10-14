Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4FF5FE8D0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJNGRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJNGQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:16:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7555D1740E;
        Thu, 13 Oct 2022 23:16:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a6-20020a17090abe0600b0020d7c0c6650so7034097pjs.0;
        Thu, 13 Oct 2022 23:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TpYGmLjxsoDh71AysgWMehQSciwSLZiLMMGzRGki0c=;
        b=CrmmEIvb9J1RibS5N4QEGMIgjYQgp+0QH59nuiepx7vpzAJyt907ojP5AsHPYVsGPm
         1SiArCisL33YkwcYBAJqEVja9pgqts7dWxz2RHE/JDOs3cNAdYOKDTPRJBGN+WAcPWy0
         jCLMTaJVASNNFq4jOsmsQ9kuysg2VbLTXtYVzpS9A4+0MHV1q01dUMbrxjQugoQginE1
         Y6q267REA7/UvcHZFg046isN3I/azV+CO6NdBJYqBGLJJY/D49HDaFEf+XV5e4VClRS3
         +3vjwV6Oaj3la2lGigtkdaMLuTRCeZo6Ta1iv6QMSbSDIyg17dOi6fMWC3QztXmCL1q2
         FodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0TpYGmLjxsoDh71AysgWMehQSciwSLZiLMMGzRGki0c=;
        b=RVkjCg4qP+xoJxTSq5xTXEV70s3m8AcxP+BGsBxBdcwhP9lmxANztKrCPuxLDNTHHg
         vtZDXrY+FlVxxDDO7J77qutJaDHpBpAeyxW3EWoI2o5pbTg7AtprfEaTVeY1T772qy4V
         uPaa1p4A9jNzCF9yTE72ShNPt33cgSKTAdGJJRXD3JU+ZX1GTEkTXvw7F8Js9Xd1Pp30
         /1mml3vJWt8sQLv01Trcd2Vq00M9wgC5I/CeGUMlHyHXAi34oGdQHczXbVcIMCuHaPyv
         fIEGGsPMqnltwJXl0es9UXfZisXZdLN64gqmFk4Op93afY2tq8Sx14X3yZveCFQCTjTs
         XAAg==
X-Gm-Message-State: ACrzQf3Osv563gIgaZo4fEQIJQuzGirW8Jm5cdxRPKEWYr0epZgjGaiW
        dh7eEIBDqB0KoAgkZa5GI+A=
X-Google-Smtp-Source: AMsMyM5toQB7ZRZlrA3UWLd6XDpqrZDXzGObHJkKu8Y3LLg47WlfxyJzfTDvqEWi+jRM8quxcXJ82A==
X-Received: by 2002:a17:902:d58c:b0:17f:998a:76cd with SMTP id k12-20020a170902d58c00b0017f998a76cdmr3765902plh.155.1665728180342;
        Thu, 13 Oct 2022 23:16:20 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:630:195c:38a7:a411])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b0020af2411721sm721942pjo.34.2022.10.13.23.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:16:19 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: [PATCH 17/19] perf stat: Display event stats using aggr counts
Date:   Thu, 13 Oct 2022 23:15:48 -0700
Message-Id: <20221014061550.463644-18-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221014061550.463644-1-namhyung@kernel.org>
References: <20221014061550.463644-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now aggr counts are ready for use.  Convert the display routines to use
the aggr counts and update the shadow stat with them.  It doesn't need
to aggregate counts or collect aliases anymore during the display.  Get
rid of now unused struct perf_aggr_thread_value.

Note that there's a difference in the display order among the aggr mode.
For per-core/die/socket/node aggregation, it shows relevant events in
the same unit together, whereas global/thread/no aggregation it shows
the same events for different units together.  So it still uses separate
codes to display them due to the ordering.

One more thing to note is that it breaks per-core event display for now.
The next patch will fix it to have identical output as of now.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 421 ++++-----------------------------
 tools/perf/util/stat.c         |   5 -
 tools/perf/util/stat.h         |   9 -
 3 files changed, 49 insertions(+), 386 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 4113aa86772f..d9cd2db1398b 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -442,31 +442,6 @@ static void print_metric_header(struct perf_stat_config *config,
 		fprintf(os->fh, "%*s ", config->metric_only_len, unit);
 }
 
-static int first_shadow_map_idx(struct perf_stat_config *config,
-				struct evsel *evsel, const struct aggr_cpu_id *id)
-{
-	struct perf_cpu_map *cpus = evsel__cpus(evsel);
-	struct perf_cpu cpu;
-	int idx;
-
-	if (config->aggr_mode == AGGR_NONE)
-		return perf_cpu_map__idx(cpus, id->cpu);
-
-	if (config->aggr_mode == AGGR_THREAD)
-		return id->thread_idx;
-
-	if (!config->aggr_get_id)
-		return 0;
-
-	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
-		struct aggr_cpu_id cpu_id = config->aggr_get_id(config, cpu);
-
-		if (aggr_cpu_id__equal(&cpu_id, id))
-			return idx;
-	}
-	return 0;
-}
-
 static void abs_printout(struct perf_stat_config *config,
 			 struct aggr_cpu_id id, int nr, struct evsel *evsel, double avg)
 {
@@ -537,7 +512,7 @@ static bool is_mixed_hw_group(struct evsel *counter)
 static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int nr,
 		     struct evsel *counter, double uval,
 		     char *prefix, u64 run, u64 ena, double noise,
-		     struct runtime_stat *st)
+		     struct runtime_stat *st, int map_idx)
 {
 	struct perf_stat_output_ctx out;
 	struct outstate os = {
@@ -648,8 +623,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 		print_running(config, run, ena);
 	}
 
-	perf_stat__print_shadow_stats(config, counter, uval,
-				first_shadow_map_idx(config, counter, &id),
+	perf_stat__print_shadow_stats(config, counter, uval, map_idx,
 				&out, &config->metric_events, st);
 	if (!config->csv_output && !config->metric_only && !config->json_output) {
 		print_noise(config, counter, noise);
@@ -657,34 +631,6 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 	}
 }
 
-static void aggr_update_shadow(struct perf_stat_config *config,
-			       struct evlist *evlist)
-{
-	int idx, s;
-	struct perf_cpu cpu;
-	struct aggr_cpu_id s2, id;
-	u64 val;
-	struct evsel *counter;
-	struct perf_cpu_map *cpus;
-
-	for (s = 0; s < config->aggr_map->nr; s++) {
-		id = config->aggr_map->map[s];
-		evlist__for_each_entry(evlist, counter) {
-			cpus = evsel__cpus(counter);
-			val = 0;
-			perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
-				s2 = config->aggr_get_id(config, cpu);
-				if (!aggr_cpu_id__equal(&s2, &id))
-					continue;
-				val += perf_counts(counter->counts, idx, 0)->val;
-			}
-			perf_stat__update_shadow_stats(counter, val,
-					first_shadow_map_idx(config, counter, &id),
-					&rt_stat);
-		}
-	}
-}
-
 static void uniquify_event_name(struct evsel *counter)
 {
 	char *new_name;
@@ -721,137 +667,51 @@ static void uniquify_event_name(struct evsel *counter)
 	counter->uniquified_name = true;
 }
 
-static void collect_all_aliases(struct perf_stat_config *config, struct evsel *counter,
-			    void (*cb)(struct perf_stat_config *config, struct evsel *counter, void *data,
-				       bool first),
-			    void *data)
+static bool hybrid_uniquify(struct evsel *evsel, struct perf_stat_config *config)
 {
-	struct evlist *evlist = counter->evlist;
-	struct evsel *alias;
-
-	alias = list_prepare_entry(counter, &(evlist->core.entries), core.node);
-	list_for_each_entry_continue (alias, &evlist->core.entries, core.node) {
-		/* Merge events with the same name, etc. but on different PMUs. */
-		if (!strcmp(evsel__name(alias), evsel__name(counter)) &&
-			alias->scale == counter->scale &&
-			alias->cgrp == counter->cgrp &&
-			!strcmp(alias->unit, counter->unit) &&
-			evsel__is_clock(alias) == evsel__is_clock(counter) &&
-			strcmp(alias->pmu_name, counter->pmu_name)) {
-			alias->merged_stat = true;
-			cb(config, alias, data, false);
-		}
-	}
+	return evsel__is_hybrid(evsel) && !config->hybrid_merge;
 }
 
-static bool hybrid_merge(struct evsel *counter, struct perf_stat_config *config,
-			 bool check)
+static void uniquify_counter(struct perf_stat_config *config, struct evsel *counter)
 {
-	if (evsel__is_hybrid(counter)) {
-		if (check)
-			return config->hybrid_merge;
-		else
-			return !config->hybrid_merge;
-	}
-
-	return false;
-}
-
-static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
-			    void (*cb)(struct perf_stat_config *config, struct evsel *counter, void *data,
-				       bool first),
-			    void *data)
-{
-	if (counter->merged_stat)
-		return false;
-	cb(config, counter, data, true);
-	if (config->no_merge || hybrid_merge(counter, config, false))
+	if (config->no_merge || hybrid_uniquify(counter, config))
 		uniquify_event_name(counter);
-	else if (counter->auto_merge_stats || hybrid_merge(counter, config, true))
-		collect_all_aliases(config, counter, cb, data);
-	return true;
-}
-
-struct aggr_data {
-	u64 ena, run, val;
-	struct aggr_cpu_id id;
-	int nr;
-	int cpu_map_idx;
-};
-
-static void aggr_cb(struct perf_stat_config *config,
-		    struct evsel *counter, void *data, bool first)
-{
-	struct aggr_data *ad = data;
-	int idx;
-	struct perf_cpu cpu;
-	struct perf_cpu_map *cpus;
-	struct aggr_cpu_id s2;
-
-	cpus = evsel__cpus(counter);
-	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
-		struct perf_counts_values *counts;
-
-		s2 = config->aggr_get_id(config, cpu);
-		if (!aggr_cpu_id__equal(&s2, &ad->id))
-			continue;
-		if (first)
-			ad->nr++;
-		counts = perf_counts(counter->counts, idx, 0);
-		/*
-		 * When any result is bad, make them all to give
-		 * consistent output in interval mode.
-		 */
-		if (counts->ena == 0 || counts->run == 0 ||
-		    counter->counts->scaled == -1) {
-			ad->ena = 0;
-			ad->run = 0;
-			break;
-		}
-		ad->val += counts->val;
-		ad->ena += counts->ena;
-		ad->run += counts->run;
-	}
 }
 
 static void print_counter_aggrdata(struct perf_stat_config *config,
 				   struct evsel *counter, int s,
 				   char *prefix, bool metric_only,
-				   bool *first, struct perf_cpu cpu)
+				   bool *first)
 {
-	struct aggr_data ad;
 	FILE *output = config->output;
 	u64 ena, run, val;
-	int nr;
-	struct aggr_cpu_id id;
 	double uval;
+	struct perf_stat_evsel *ps = counter->stats;
+	struct perf_stat_aggr *aggr = &ps->aggr[s];
+	struct aggr_cpu_id id = config->aggr_map->map[s];
+	double avg = aggr->counts.val;
 
-	ad.id = id = config->aggr_map->map[s];
-	ad.val = ad.ena = ad.run = 0;
-	ad.nr = 0;
-	if (!collect_data(config, counter, aggr_cb, &ad))
+	if (aggr->nr == 0)
 		return;
 
-	if (perf_pmu__has_hybrid() && ad.ena == 0)
-		return;
+	uniquify_counter(config, counter);
+
+	val = aggr->counts.val;
+	ena = aggr->counts.ena;
+	run = aggr->counts.run;
 
-	nr = ad.nr;
-	ena = ad.ena;
-	run = ad.run;
-	val = ad.val;
 	if (*first && metric_only) {
 		*first = false;
-		aggr_printout(config, counter, id, nr);
+		aggr_printout(config, counter, id, aggr->nr);
 	}
 	if (prefix && !metric_only)
 		fprintf(output, "%s", prefix);
 
 	uval = val * counter->scale;
-	if (cpu.cpu != -1)
-		id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
 
-	printout(config, id, nr, counter, uval,
-		 prefix, run, ena, 1.0, &rt_stat);
+	printout(config, id, aggr->nr, counter, uval,
+		 prefix, run, ena, avg, &rt_stat, s);
+
 	if (!metric_only)
 		fputc('\n', output);
 }
@@ -869,8 +729,6 @@ static void print_aggr(struct perf_stat_config *config,
 	if (!config->aggr_map || !config->aggr_get_id)
 		return;
 
-	aggr_update_shadow(config, evlist);
-
 	/*
 	 * With metric_only everything is on a single line.
 	 * Without each counter has its own line.
@@ -881,188 +739,36 @@ static void print_aggr(struct perf_stat_config *config,
 
 		first = true;
 		evlist__for_each_entry(evlist, counter) {
+			if (counter->merged_stat)
+				continue;
+
 			print_counter_aggrdata(config, counter, s,
-					prefix, metric_only,
-					&first, (struct perf_cpu){ .cpu = -1 });
+					       prefix, metric_only,
+					       &first);
 		}
 		if (metric_only)
 			fputc('\n', output);
 	}
 }
 
-static int cmp_val(const void *a, const void *b)
-{
-	return ((struct perf_aggr_thread_value *)b)->val -
-		((struct perf_aggr_thread_value *)a)->val;
-}
-
-static struct perf_aggr_thread_value *sort_aggr_thread(
-					struct evsel *counter,
-					int *ret,
-					struct target *_target)
-{
-	int nthreads = perf_thread_map__nr(counter->core.threads);
-	int i = 0;
-	double uval;
-	struct perf_aggr_thread_value *buf;
-
-	buf = calloc(nthreads, sizeof(struct perf_aggr_thread_value));
-	if (!buf)
-		return NULL;
-
-	for (int thread = 0; thread < nthreads; thread++) {
-		int idx;
-		u64 ena = 0, run = 0, val = 0;
-
-		perf_cpu_map__for_each_idx(idx, evsel__cpus(counter)) {
-			struct perf_counts_values *counts =
-				perf_counts(counter->counts, idx, thread);
-
-			val += counts->val;
-			ena += counts->ena;
-			run += counts->run;
-		}
-
-		uval = val * counter->scale;
-
-		/*
-		 * Skip value 0 when enabling --per-thread globally,
-		 * otherwise too many 0 output.
-		 */
-		if (uval == 0.0 && target__has_per_thread(_target))
-			continue;
-
-		buf[i].counter = counter;
-		buf[i].id = aggr_cpu_id__empty();
-		buf[i].id.thread_idx = thread;
-		buf[i].uval = uval;
-		buf[i].val = val;
-		buf[i].run = run;
-		buf[i].ena = ena;
-		i++;
-	}
-
-	qsort(buf, i, sizeof(struct perf_aggr_thread_value), cmp_val);
-
-	if (ret)
-		*ret = i;
-
-	return buf;
-}
-
-static void print_aggr_thread(struct perf_stat_config *config,
-			      struct target *_target,
-			      struct evsel *counter, char *prefix)
-{
-	FILE *output = config->output;
-	int thread, sorted_threads;
-	struct aggr_cpu_id id;
-	struct perf_aggr_thread_value *buf;
-
-	buf = sort_aggr_thread(counter, &sorted_threads, _target);
-	if (!buf) {
-		perror("cannot sort aggr thread");
-		return;
-	}
-
-	for (thread = 0; thread < sorted_threads; thread++) {
-		if (prefix)
-			fprintf(output, "%s", prefix);
-
-		id = buf[thread].id;
-		printout(config, id, 0, buf[thread].counter, buf[thread].uval,
-			 prefix, buf[thread].run, buf[thread].ena, 1.0,
-			 &rt_stat);
-		fputc('\n', output);
-	}
-
-	free(buf);
-}
-
-struct caggr_data {
-	double avg, avg_enabled, avg_running;
-};
-
-static void counter_aggr_cb(struct perf_stat_config *config __maybe_unused,
-			    struct evsel *counter, void *data,
-			    bool first __maybe_unused)
-{
-	struct caggr_data *cd = data;
-	struct perf_counts_values *aggr = &counter->counts->aggr;
-
-	cd->avg += aggr->val;
-	cd->avg_enabled += aggr->ena;
-	cd->avg_running += aggr->run;
-}
-
-/*
- * Print out the results of a single counter:
- * aggregated counts in system-wide mode
- */
-static void print_counter_aggr(struct perf_stat_config *config,
-			       struct evsel *counter, char *prefix)
-{
-	bool metric_only = config->metric_only;
-	FILE *output = config->output;
-	double uval;
-	struct caggr_data cd = { .avg = 0.0 };
-
-	if (!collect_data(config, counter, counter_aggr_cb, &cd))
-		return;
-
-	if (prefix && !metric_only)
-		fprintf(output, "%s", prefix);
-
-	uval = cd.avg * counter->scale;
-	printout(config, aggr_cpu_id__empty(), 0, counter, uval, prefix, cd.avg_running,
-		 cd.avg_enabled, cd.avg, &rt_stat);
-	if (!metric_only)
-		fprintf(output, "\n");
-}
-
-static void counter_cb(struct perf_stat_config *config __maybe_unused,
-		       struct evsel *counter, void *data,
-		       bool first __maybe_unused)
-{
-	struct aggr_data *ad = data;
-
-	ad->val += perf_counts(counter->counts, ad->cpu_map_idx, 0)->val;
-	ad->ena += perf_counts(counter->counts, ad->cpu_map_idx, 0)->ena;
-	ad->run += perf_counts(counter->counts, ad->cpu_map_idx, 0)->run;
-}
-
-/*
- * Print out the results of a single counter:
- * does not use aggregated count in system-wide
- */
 static void print_counter(struct perf_stat_config *config,
 			  struct evsel *counter, char *prefix)
 {
-	FILE *output = config->output;
-	u64 ena, run, val;
-	double uval;
-	int idx;
-	struct perf_cpu cpu;
-	struct aggr_cpu_id id;
-
-	perf_cpu_map__for_each_cpu(cpu, idx, evsel__cpus(counter)) {
-		struct aggr_data ad = { .cpu_map_idx = idx };
-
-		if (!collect_data(config, counter, counter_cb, &ad))
-			return;
-		val = ad.val;
-		ena = ad.ena;
-		run = ad.run;
+	bool metric_only = config->metric_only;
+	bool first = false;
+	int s;
 
-		if (prefix)
-			fprintf(output, "%s", prefix);
+	/* AGGR_THREAD doesn't have config->aggr_get_id */
+	if (!config->aggr_map)
+		return;
 
-		uval = val * counter->scale;
-		id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
-		printout(config, id, 0, counter, uval, prefix,
-			 run, ena, 1.0, &rt_stat);
+	if (counter->merged_stat)
+		return;
 
-		fputc('\n', output);
+	for (s = 0; s < config->aggr_map->nr; s++) {
+		print_counter_aggrdata(config, counter, s,
+				       prefix, metric_only,
+				       &first);
 	}
 }
 
@@ -1081,6 +787,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 			u64 ena, run, val;
 			double uval;
 			struct aggr_cpu_id id;
+			struct perf_stat_evsel *ps = counter->stats;
 			int counter_idx = perf_cpu_map__idx(evsel__cpus(counter), cpu);
 
 			if (counter_idx < 0)
@@ -1093,13 +800,13 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 				aggr_printout(config, counter, id, 0);
 				first = false;
 			}
-			val = perf_counts(counter->counts, counter_idx, 0)->val;
-			ena = perf_counts(counter->counts, counter_idx, 0)->ena;
-			run = perf_counts(counter->counts, counter_idx, 0)->run;
+			val = ps->aggr[counter_idx].counts.val;
+			ena = ps->aggr[counter_idx].counts.ena;
+			run = ps->aggr[counter_idx].counts.run;
 
 			uval = val * counter->scale;
 			printout(config, id, 0, counter, uval, prefix,
-				 run, ena, 1.0, &rt_stat);
+				 run, ena, 1.0, &rt_stat, counter_idx);
 		}
 		if (!first)
 			fputc('\n', config->output);
@@ -1135,8 +842,8 @@ static void print_metric_headers(struct perf_stat_config *config,
 	};
 	bool first = true;
 
-		if (config->json_output && !config->interval)
-			fprintf(config->output, "{");
+	if (config->json_output && !config->interval)
+		fprintf(config->output, "{");
 
 	if (prefix && !config->json_output)
 		fprintf(config->output, "%s", prefix);
@@ -1379,31 +1086,6 @@ static void print_footer(struct perf_stat_config *config)
 			"the same PMU. Try reorganizing the group.\n");
 }
 
-static void print_percore_thread(struct perf_stat_config *config,
-				 struct evsel *counter, char *prefix)
-{
-	int s;
-	struct aggr_cpu_id s2, id;
-	struct perf_cpu_map *cpus;
-	bool first = true;
-	int idx;
-	struct perf_cpu cpu;
-
-	cpus = evsel__cpus(counter);
-	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
-		s2 = config->aggr_get_id(config, cpu);
-		for (s = 0; s < config->aggr_map->nr; s++) {
-			id = config->aggr_map->map[s];
-			if (aggr_cpu_id__equal(&s2, &id))
-				break;
-		}
-
-		print_counter_aggrdata(config, counter, s,
-				       prefix, false,
-				       &first, cpu);
-	}
-}
-
 static void print_percore(struct perf_stat_config *config,
 			  struct evsel *counter, char *prefix)
 {
@@ -1416,15 +1098,14 @@ static void print_percore(struct perf_stat_config *config,
 		return;
 
 	if (config->percore_show_thread)
-		return print_percore_thread(config, counter, prefix);
+		return print_counter(config, counter, prefix);
 
 	for (s = 0; s < config->aggr_map->nr; s++) {
 		if (prefix && metric_only)
 			fprintf(output, "%s", prefix);
 
 		print_counter_aggrdata(config, counter, s,
-				prefix, metric_only,
-				&first, (struct perf_cpu){ .cpu = -1 });
+				       prefix, metric_only, &first);
 	}
 
 	if (metric_only)
@@ -1469,17 +1150,13 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		print_aggr(config, evlist, prefix);
 		break;
 	case AGGR_THREAD:
-		evlist__for_each_entry(evlist, counter) {
-			print_aggr_thread(config, _target, counter, prefix);
-		}
-		break;
 	case AGGR_GLOBAL:
 		if (config->iostat_run)
 			iostat_print_counters(evlist, config, ts, prefix = buf,
-					      print_counter_aggr);
+					      print_counter);
 		else {
 			evlist__for_each_entry(evlist, counter) {
-				print_counter_aggr(config, counter, prefix);
+				print_counter(config, counter, prefix);
 			}
 			if (metric_only)
 				fputc('\n', config->output);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index d51ba63b9ab2..14c45f4cfdd3 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -547,11 +547,6 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 			evsel__name(counter), count[0], count[1], count[2]);
 	}
 
-	/*
-	 * Save the full runtime - to allow normalization during printout:
-	 */
-	perf_stat__update_shadow_stats(counter, *count, 0, &rt_stat);
-
 	return 0;
 }
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 3d413ba8c68a..382a1ab92ce1 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -224,15 +224,6 @@ static inline void update_rusage_stats(struct rusage_stats *ru_stats, struct rus
 struct evsel;
 struct evlist;
 
-struct perf_aggr_thread_value {
-	struct evsel *counter;
-	struct aggr_cpu_id id;
-	double uval;
-	u64 val;
-	u64 run;
-	u64 ena;
-};
-
 bool __perf_stat_evsel__is(struct evsel *evsel, enum perf_stat_evsel_id id);
 
 #define perf_stat_evsel__is(evsel, id) \
-- 
2.38.0.413.g74048e4d9e-goog


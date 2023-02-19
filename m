Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67CE69BFC5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjBSJjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjBSJjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:39:19 -0500
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD98B1117A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:38:22 -0800 (PST)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5369e5f7913so1149257b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/y7SWHTUkfrtXB6+Nyg9zBpnl23ivOFDADIaKoe8cgw=;
        b=iH7Yk8ZgXy+D6RWwLGF5Fea/CxfUBXBWWaJTGGLOaD3q0mPtVxy87WyEw1kDXvTs8N
         lVs/8gn3d9xyHWfONVRA4PnFDLyL+j2HaxjoWqsZ4cVF51kSMNi0W/SKen7hmzU52zwp
         VVn0eX2Kh1EQUjLisJYaA7huB27zZN6I2vuBrfTyBAd22Wuz4jYjc53371S41SDo6ZIz
         q4HjKc4jHYhXbS47kZnTyg8rlJoqgQ8U4oHn34uWMwSwSK/SvJO7P3UiqNvSmwtKs8xZ
         NWdNCLIAYUg4Hb1Gpe59FDXDn6ABHPblT6huaDvP2xhkKsnOFy7QJeRV0n6+AixmvJEP
         PqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/y7SWHTUkfrtXB6+Nyg9zBpnl23ivOFDADIaKoe8cgw=;
        b=ZXyU81RtMHJz/CawmUVZQ2bDPvtsZMkT8mTKKxkvqrvCaNfq9GLpwMMmQ4Kb9lQIkS
         cJRrb1ldJRtaDDmx6BHv4bGaM1CCbKH0neWpkC6k2CxhqIt490cd0aHiSHz+QSXU9LyB
         QjjxX1M/p8Z2bNm4GBz1g8W1oZY6IU/pA4HnrXON8ONod7CT+7BA4O9LfSAvFDn2LqEx
         Xqww02Yeyyy9KWuyi317HD5btsiyr+/EdIXSsZAlR4nofSPPtSXXmVmmQ01wGTa4UKMO
         LwMjKjR0rQaLXPKWN5Sr9Po3zGhOtXrwc88H+bg5Ftw0v2AMvxxfI8ZLfE/sD5833MA5
         azKw==
X-Gm-Message-State: AO0yUKXLTTCodPh4O+nJjcff6h/NDTuSnZUgA8DJkXTeQzRQjcqB/wf3
        swW90oZnXdaL7/1EDAKmud8jbadKj0Ld
X-Google-Smtp-Source: AK7set+SDwSFsi7O/fo64NsxVt/D+12xPBeJw6GMKN+lVo6XjuPcDJt1aO99H9SPG2oJ8vHQrF/a450gGlng
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a5b:cc7:0:b0:7d1:87e:1713 with SMTP id
 e7-20020a5b0cc7000000b007d1087e1713mr1553569ybr.102.1676799345329; Sun, 19
 Feb 2023 01:35:45 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:45 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-49-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 48/51] perf stat: Add cpu_aggr_map for loop
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variables, add a comment and add a cpu_aggr_map__for_each_idx
to aid the readability of the stat-display code. In particular, try to
make sure aggr_idx is used consistently to differentiate from other
kinds of index.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.h       |   3 +
 tools/perf/util/stat-display.c | 112 +++++++++++++++--------------
 tools/perf/util/stat-shadow.c  | 128 ++++++++++++++++-----------------
 tools/perf/util/stat.c         |   8 +--
 tools/perf/util/stat.h         |   6 +-
 5 files changed, 132 insertions(+), 125 deletions(-)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index c2f5824a3a22..e3426541e0aa 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -35,6 +35,9 @@ struct cpu_aggr_map {
 	struct aggr_cpu_id map[];
 };
 
+#define cpu_aggr_map__for_each_idx(idx, aggr_map)				\
+	for ((idx) = 0; (idx) < aggr_map->nr; (idx)++)
+
 struct perf_record_cpu_map_data;
 
 bool perf_record_cpu_map_data__test_bit(int i, const struct perf_record_cpu_map_data *data);
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 6c065d0624c3..e6035ecbeee8 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -183,7 +183,7 @@ static void print_cgroup(struct perf_stat_config *config, struct cgroup *cgrp)
 }
 
 static void print_aggr_id_std(struct perf_stat_config *config,
-			      struct evsel *evsel, struct aggr_cpu_id id, int nr)
+			      struct evsel *evsel, struct aggr_cpu_id id, int aggr_nr)
 {
 	FILE *output = config->output;
 	int idx = config->aggr_mode;
@@ -225,11 +225,11 @@ static void print_aggr_id_std(struct perf_stat_config *config,
 		return;
 	}
 
-	fprintf(output, "%-*s %*d ", aggr_header_lens[idx], buf, 4, nr);
+	fprintf(output, "%-*s %*d ", aggr_header_lens[idx], buf, 4, aggr_nr);
 }
 
 static void print_aggr_id_csv(struct perf_stat_config *config,
-			      struct evsel *evsel, struct aggr_cpu_id id, int nr)
+			      struct evsel *evsel, struct aggr_cpu_id id, int aggr_nr)
 {
 	FILE *output = config->output;
 	const char *sep = config->csv_sep;
@@ -237,19 +237,19 @@ static void print_aggr_id_csv(struct perf_stat_config *config,
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
 		fprintf(output, "S%d-D%d-C%d%s%d%s",
-			id.socket, id.die, id.core, sep, nr, sep);
+			id.socket, id.die, id.core, sep, aggr_nr, sep);
 		break;
 	case AGGR_DIE:
 		fprintf(output, "S%d-D%d%s%d%s",
-			id.socket, id.die, sep, nr, sep);
+			id.socket, id.die, sep, aggr_nr, sep);
 		break;
 	case AGGR_SOCKET:
 		fprintf(output, "S%d%s%d%s",
-			id.socket, sep, nr, sep);
+			id.socket, sep, aggr_nr, sep);
 		break;
 	case AGGR_NODE:
 		fprintf(output, "N%d%s%d%s",
-			id.node, sep, nr, sep);
+			id.node, sep, aggr_nr, sep);
 		break;
 	case AGGR_NONE:
 		if (evsel->percore && !config->percore_show_thread) {
@@ -275,26 +275,26 @@ static void print_aggr_id_csv(struct perf_stat_config *config,
 }
 
 static void print_aggr_id_json(struct perf_stat_config *config,
-			       struct evsel *evsel, struct aggr_cpu_id id, int nr)
+			       struct evsel *evsel, struct aggr_cpu_id id, int aggr_nr)
 {
 	FILE *output = config->output;
 
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
 		fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-number\" : %d, ",
-			id.socket, id.die, id.core, nr);
+			id.socket, id.die, id.core, aggr_nr);
 		break;
 	case AGGR_DIE:
 		fprintf(output, "\"die\" : \"S%d-D%d\", \"aggregate-number\" : %d, ",
-			id.socket, id.die, nr);
+			id.socket, id.die, aggr_nr);
 		break;
 	case AGGR_SOCKET:
 		fprintf(output, "\"socket\" : \"S%d\", \"aggregate-number\" : %d, ",
-			id.socket, nr);
+			id.socket, aggr_nr);
 		break;
 	case AGGR_NODE:
 		fprintf(output, "\"node\" : \"N%d\", \"aggregate-number\" : %d, ",
-			id.node, nr);
+			id.node, aggr_nr);
 		break;
 	case AGGR_NONE:
 		if (evsel->percore && !config->percore_show_thread) {
@@ -319,14 +319,14 @@ static void print_aggr_id_json(struct perf_stat_config *config,
 }
 
 static void aggr_printout(struct perf_stat_config *config,
-			  struct evsel *evsel, struct aggr_cpu_id id, int nr)
+			  struct evsel *evsel, struct aggr_cpu_id id, int aggr_nr)
 {
 	if (config->json_output)
-		print_aggr_id_json(config, evsel, id, nr);
+		print_aggr_id_json(config, evsel, id, aggr_nr);
 	else if (config->csv_output)
-		print_aggr_id_csv(config, evsel, id, nr);
+		print_aggr_id_csv(config, evsel, id, aggr_nr);
 	else
-		print_aggr_id_std(config, evsel, id, nr);
+		print_aggr_id_std(config, evsel, id, aggr_nr);
 }
 
 struct outstate {
@@ -335,7 +335,7 @@ struct outstate {
 	bool first;
 	const char *prefix;
 	int  nfields;
-	int  nr;
+	int  aggr_nr;
 	struct aggr_cpu_id id;
 	struct evsel *evsel;
 	struct cgroup *cgrp;
@@ -355,7 +355,7 @@ static void do_new_line_std(struct perf_stat_config *config,
 	fputc('\n', os->fh);
 	if (os->prefix)
 		fputs(os->prefix, os->fh);
-	aggr_printout(config, os->evsel, os->id, os->nr);
+	aggr_printout(config, os->evsel, os->id, os->aggr_nr);
 	if (config->aggr_mode == AGGR_NONE)
 		fprintf(os->fh, "        ");
 	fprintf(os->fh, "                                                 ");
@@ -396,7 +396,7 @@ static void new_line_csv(struct perf_stat_config *config, void *ctx)
 	fputc('\n', os->fh);
 	if (os->prefix)
 		fprintf(os->fh, "%s", os->prefix);
-	aggr_printout(config, os->evsel, os->id, os->nr);
+	aggr_printout(config, os->evsel, os->id, os->aggr_nr);
 	for (i = 0; i < os->nfields; i++)
 		fputs(config->csv_sep, os->fh);
 }
@@ -444,7 +444,7 @@ static void new_line_json(struct perf_stat_config *config, void *ctx)
 	fputs("\n{", os->fh);
 	if (os->prefix)
 		fprintf(os->fh, "%s", os->prefix);
-	aggr_printout(config, os->evsel, os->id, os->nr);
+	aggr_printout(config, os->evsel, os->id, os->aggr_nr);
 }
 
 /* Filter out some columns that don't work well in metrics only mode */
@@ -645,10 +645,10 @@ static void print_counter_value(struct perf_stat_config *config,
 }
 
 static void abs_printout(struct perf_stat_config *config,
-			 struct aggr_cpu_id id, int nr,
+			 struct aggr_cpu_id id, int aggr_nr,
 			 struct evsel *evsel, double avg, bool ok)
 {
-	aggr_printout(config, evsel, id, nr);
+	aggr_printout(config, evsel, id, aggr_nr);
 	print_counter_value(config, evsel, avg, ok);
 	print_cgroup(config, evsel->cgrp);
 }
@@ -678,7 +678,7 @@ static bool is_mixed_hw_group(struct evsel *counter)
 }
 
 static void printout(struct perf_stat_config *config, struct outstate *os,
-		     double uval, u64 run, u64 ena, double noise, int map_idx)
+		     double uval, u64 run, u64 ena, double noise, int aggr_idx)
 {
 	struct perf_stat_output_ctx out;
 	print_metric_t pm;
@@ -721,14 +721,14 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 	out.force_header = false;
 
 	if (!config->metric_only) {
-		abs_printout(config, os->id, os->nr, counter, uval, ok);
+		abs_printout(config, os->id, os->aggr_nr, counter, uval, ok);
 
 		print_noise(config, counter, noise, /*before_metric=*/true);
 		print_running(config, run, ena, /*before_metric=*/true);
 	}
 
 	if (ok) {
-		perf_stat__print_shadow_stats(config, counter, uval, map_idx,
+		perf_stat__print_shadow_stats(config, counter, uval, aggr_idx,
 					      &out, &config->metric_events);
 	} else {
 		pm(config, os, /*color=*/NULL, /*format=*/NULL, /*unit=*/"", /*val=*/0);
@@ -833,20 +833,20 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 }
 
 static void print_counter_aggrdata(struct perf_stat_config *config,
-				   struct evsel *counter, int s,
+				   struct evsel *counter, int aggr_idx,
 				   struct outstate *os)
 {
 	FILE *output = config->output;
 	u64 ena, run, val;
 	double uval;
 	struct perf_stat_evsel *ps = counter->stats;
-	struct perf_stat_aggr *aggr = &ps->aggr[s];
-	struct aggr_cpu_id id = config->aggr_map->map[s];
+	struct perf_stat_aggr *aggr = &ps->aggr[aggr_idx];
+	struct aggr_cpu_id id = config->aggr_map->map[aggr_idx];
 	double avg = aggr->counts.val;
 	bool metric_only = config->metric_only;
 
 	os->id = id;
-	os->nr = aggr->nr;
+	os->aggr_nr = aggr->nr;
 	os->evsel = counter;
 
 	/* Skip already merged uncore/hybrid events */
@@ -874,7 +874,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 
 	uval = val * counter->scale;
 
-	printout(config, os, uval, run, ena, avg, s);
+	printout(config, os, uval, run, ena, avg, aggr_idx);
 
 	if (!metric_only)
 		fputc('\n', output);
@@ -925,7 +925,7 @@ static void print_aggr(struct perf_stat_config *config,
 		       struct outstate *os)
 {
 	struct evsel *counter;
-	int s;
+	int aggr_idx;
 
 	if (!config->aggr_map || !config->aggr_get_id)
 		return;
@@ -934,11 +934,11 @@ static void print_aggr(struct perf_stat_config *config,
 	 * With metric_only everything is on a single line.
 	 * Without each counter has its own line.
 	 */
-	for (s = 0; s < config->aggr_map->nr; s++) {
-		print_metric_begin(config, evlist, os, s);
+	cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
+		print_metric_begin(config, evlist, os, aggr_idx);
 
 		evlist__for_each_entry(evlist, counter) {
-			print_counter_aggrdata(config, counter, s, os);
+			print_counter_aggrdata(config, counter, aggr_idx, os);
 		}
 		print_metric_end(config, os);
 	}
@@ -949,7 +949,7 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
 			      struct outstate *os)
 {
 	struct evsel *counter, *evsel;
-	int s;
+	int aggr_idx;
 
 	if (!config->aggr_map || !config->aggr_get_id)
 		return;
@@ -960,14 +960,14 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
 
 		os->cgrp = evsel->cgrp;
 
-		for (s = 0; s < config->aggr_map->nr; s++) {
-			print_metric_begin(config, evlist, os, s);
+		cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
+			print_metric_begin(config, evlist, os, aggr_idx);
 
 			evlist__for_each_entry(evlist, counter) {
 				if (counter->cgrp != os->cgrp)
 					continue;
 
-				print_counter_aggrdata(config, counter, s, os);
+				print_counter_aggrdata(config, counter, aggr_idx, os);
 			}
 			print_metric_end(config, os);
 		}
@@ -977,14 +977,14 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
 static void print_counter(struct perf_stat_config *config,
 			  struct evsel *counter, struct outstate *os)
 {
-	int s;
+	int aggr_idx;
 
 	/* AGGR_THREAD doesn't have config->aggr_get_id */
 	if (!config->aggr_map)
 		return;
 
-	for (s = 0; s < config->aggr_map->nr; s++) {
-		print_counter_aggrdata(config, counter, s, os);
+	cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
+		print_counter_aggrdata(config, counter, aggr_idx, os);
 	}
 }
 
@@ -1003,23 +1003,23 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 			u64 ena, run, val;
 			double uval;
 			struct perf_stat_evsel *ps = counter->stats;
-			int counter_idx = perf_cpu_map__idx(evsel__cpus(counter), cpu);
+			int aggr_idx = perf_cpu_map__idx(evsel__cpus(counter), cpu);
 
-			if (counter_idx < 0)
+			if (aggr_idx < 0)
 				continue;
 
 			os->evsel = counter;
 			os->id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
 			if (first) {
-				print_metric_begin(config, evlist, os, counter_idx);
+				print_metric_begin(config, evlist, os, aggr_idx);
 				first = false;
 			}
-			val = ps->aggr[counter_idx].counts.val;
-			ena = ps->aggr[counter_idx].counts.ena;
-			run = ps->aggr[counter_idx].counts.run;
+			val = ps->aggr[aggr_idx].counts.val;
+			ena = ps->aggr[aggr_idx].counts.ena;
+			run = ps->aggr[aggr_idx].counts.run;
 
 			uval = val * counter->scale;
-			printout(config, os, uval, run, ena, 1.0, counter_idx);
+			printout(config, os, uval, run, ena, 1.0, aggr_idx);
 		}
 		if (!first)
 			print_metric_end(config, os);
@@ -1338,7 +1338,7 @@ static void print_percore(struct perf_stat_config *config,
 	bool metric_only = config->metric_only;
 	FILE *output = config->output;
 	struct cpu_aggr_map *core_map;
-	int s, c, i;
+	int aggr_idx, core_map_len = 0;
 
 	if (!config->aggr_map || !config->aggr_get_id)
 		return;
@@ -1346,18 +1346,22 @@ static void print_percore(struct perf_stat_config *config,
 	if (config->percore_show_thread)
 		return print_counter(config, counter, os);
 
+	/*
+	 * core_map will hold the aggr_cpu_id for the cores that have been
+	 * printed so that each core is printed just once.
+	 */
 	core_map = cpu_aggr_map__empty_new(config->aggr_map->nr);
 	if (core_map == NULL) {
 		fprintf(output, "Cannot allocate per-core aggr map for display\n");
 		return;
 	}
 
-	for (s = 0, c = 0; s < config->aggr_map->nr; s++) {
-		struct perf_cpu curr_cpu = config->aggr_map->map[s].cpu;
+	cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
+		struct perf_cpu curr_cpu = config->aggr_map->map[aggr_idx].cpu;
 		struct aggr_cpu_id core_id = aggr_cpu_id__core(curr_cpu, NULL);
 		bool found = false;
 
-		for (i = 0; i < c; i++) {
+		for (int i = 0; i < core_map_len; i++) {
 			if (aggr_cpu_id__equal(&core_map->map[i], &core_id)) {
 				found = true;
 				break;
@@ -1366,9 +1370,9 @@ static void print_percore(struct perf_stat_config *config,
 		if (found)
 			continue;
 
-		print_counter_aggrdata(config, counter, s, os);
+		print_counter_aggrdata(config, counter, aggr_idx, os);
 
-		core_map->map[c++] = core_id;
+		core_map->map[core_map_len++] = core_id;
 	}
 	free(core_map);
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index f80be6abac90..7b48e2bd3ba1 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -231,7 +231,7 @@ static void update_runtime_stat(enum stat_type type,
  * instruction rates, etc:
  */
 void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
-				    int map_idx)
+				    int aggr_idx)
 {
 	u64 count_ns = count;
 	struct saved_value *v;
@@ -242,39 +242,39 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 	count *= counter->scale;
 
 	if (evsel__is_clock(counter))
-		update_runtime_stat(STAT_NSECS, map_idx, count_ns, &rsd);
+		update_runtime_stat(STAT_NSECS, aggr_idx, count_ns, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
-		update_runtime_stat(STAT_CYCLES, map_idx, count, &rsd);
+		update_runtime_stat(STAT_CYCLES, aggr_idx, count, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
 		update_runtime_stat(STAT_STALLED_CYCLES_FRONT,
-				    map_idx, count, &rsd);
+				    aggr_idx, count, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_BACKEND))
 		update_runtime_stat(STAT_STALLED_CYCLES_BACK,
-				    map_idx, count, &rsd);
+				    aggr_idx, count, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_BRANCH_INSTRUCTIONS))
-		update_runtime_stat(STAT_BRANCHES, map_idx, count, &rsd);
+		update_runtime_stat(STAT_BRANCHES, aggr_idx, count, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_CACHE_REFERENCES))
-		update_runtime_stat(STAT_CACHEREFS, map_idx, count, &rsd);
+		update_runtime_stat(STAT_CACHEREFS, aggr_idx, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1D))
-		update_runtime_stat(STAT_L1_DCACHE, map_idx, count, &rsd);
+		update_runtime_stat(STAT_L1_DCACHE, aggr_idx, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1I))
-		update_runtime_stat(STAT_L1_ICACHE, map_idx, count, &rsd);
+		update_runtime_stat(STAT_L1_ICACHE, aggr_idx, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_LL))
-		update_runtime_stat(STAT_LL_CACHE, map_idx, count, &rsd);
+		update_runtime_stat(STAT_LL_CACHE, aggr_idx, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_DTLB))
-		update_runtime_stat(STAT_DTLB_CACHE, map_idx, count, &rsd);
+		update_runtime_stat(STAT_DTLB_CACHE, aggr_idx, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_ITLB))
-		update_runtime_stat(STAT_ITLB_CACHE, map_idx, count, &rsd);
+		update_runtime_stat(STAT_ITLB_CACHE, aggr_idx, count, &rsd);
 
 	if (counter->collect_stat) {
-		v = saved_value_lookup(counter, map_idx, true, STAT_NONE, 0,
+		v = saved_value_lookup(counter, aggr_idx, true, STAT_NONE, 0,
 				       rsd.cgrp);
 		update_stats(&v->stats, count);
 		if (counter->metric_leader)
 			v->metric_total += count;
 	} else if (counter->metric_leader && !counter->merged_stat) {
 		v = saved_value_lookup(counter->metric_leader,
-				       map_idx, true, STAT_NONE, 0, rsd.cgrp);
+				       aggr_idx, true, STAT_NONE, 0, rsd.cgrp);
 		v->metric_total += count;
 		v->metric_other++;
 	}
@@ -307,24 +307,24 @@ static const char *get_ratio_color(enum grc_type type, double ratio)
 	return color;
 }
 
-static double runtime_stat_avg(enum stat_type type, int map_idx,
+static double runtime_stat_avg(enum stat_type type, int aggr_idx,
 			       struct runtime_stat_data *rsd)
 {
 	struct saved_value *v;
 
-	v = saved_value_lookup(NULL, map_idx, false, type, rsd->ctx, rsd->cgrp);
+	v = saved_value_lookup(NULL, aggr_idx, false, type, rsd->ctx, rsd->cgrp);
 	if (!v)
 		return 0.0;
 
 	return avg_stats(&v->stats);
 }
 
-static double runtime_stat_n(enum stat_type type, int map_idx,
+static double runtime_stat_n(enum stat_type type, int aggr_idx,
 			     struct runtime_stat_data *rsd)
 {
 	struct saved_value *v;
 
-	v = saved_value_lookup(NULL, map_idx, false, type, rsd->ctx, rsd->cgrp);
+	v = saved_value_lookup(NULL, aggr_idx, false, type, rsd->ctx, rsd->cgrp);
 	if (!v)
 		return 0.0;
 
@@ -332,14 +332,14 @@ static double runtime_stat_n(enum stat_type type, int map_idx,
 }
 
 static void print_stalled_cycles_frontend(struct perf_stat_config *config,
-					  int map_idx, double avg,
+					  int aggr_idx, double avg,
 					  struct perf_stat_output_ctx *out,
 					  struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(STAT_CYCLES, map_idx, rsd);
+	total = runtime_stat_avg(STAT_CYCLES, aggr_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -354,14 +354,14 @@ static void print_stalled_cycles_frontend(struct perf_stat_config *config,
 }
 
 static void print_stalled_cycles_backend(struct perf_stat_config *config,
-					 int map_idx, double avg,
+					 int aggr_idx, double avg,
 					 struct perf_stat_output_ctx *out,
 					 struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(STAT_CYCLES, map_idx, rsd);
+	total = runtime_stat_avg(STAT_CYCLES, aggr_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -372,14 +372,14 @@ static void print_stalled_cycles_backend(struct perf_stat_config *config,
 }
 
 static void print_branch_misses(struct perf_stat_config *config,
-				int map_idx, double avg,
+				int aggr_idx, double avg,
 				struct perf_stat_output_ctx *out,
 				struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(STAT_BRANCHES, map_idx, rsd);
+	total = runtime_stat_avg(STAT_BRANCHES, aggr_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -390,14 +390,14 @@ static void print_branch_misses(struct perf_stat_config *config,
 }
 
 static void print_l1_dcache_misses(struct perf_stat_config *config,
-				   int map_idx, double avg,
+				   int aggr_idx, double avg,
 				   struct perf_stat_output_ctx *out,
 				   struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(STAT_L1_DCACHE, map_idx, rsd);
+	total = runtime_stat_avg(STAT_L1_DCACHE, aggr_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -408,14 +408,14 @@ static void print_l1_dcache_misses(struct perf_stat_config *config,
 }
 
 static void print_l1_icache_misses(struct perf_stat_config *config,
-				   int map_idx, double avg,
+				   int aggr_idx, double avg,
 				   struct perf_stat_output_ctx *out,
 				   struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(STAT_L1_ICACHE, map_idx, rsd);
+	total = runtime_stat_avg(STAT_L1_ICACHE, aggr_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -425,14 +425,14 @@ static void print_l1_icache_misses(struct perf_stat_config *config,
 }
 
 static void print_dtlb_cache_misses(struct perf_stat_config *config,
-				    int map_idx, double avg,
+				    int aggr_idx, double avg,
 				    struct perf_stat_output_ctx *out,
 				    struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(STAT_DTLB_CACHE, map_idx, rsd);
+	total = runtime_stat_avg(STAT_DTLB_CACHE, aggr_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -442,14 +442,14 @@ static void print_dtlb_cache_misses(struct perf_stat_config *config,
 }
 
 static void print_itlb_cache_misses(struct perf_stat_config *config,
-				    int map_idx, double avg,
+				    int aggr_idx, double avg,
 				    struct perf_stat_output_ctx *out,
 				    struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(STAT_ITLB_CACHE, map_idx, rsd);
+	total = runtime_stat_avg(STAT_ITLB_CACHE, aggr_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -459,14 +459,14 @@ static void print_itlb_cache_misses(struct perf_stat_config *config,
 }
 
 static void print_ll_cache_misses(struct perf_stat_config *config,
-				  int map_idx, double avg,
+				  int aggr_idx, double avg,
 				  struct perf_stat_output_ctx *out,
 				  struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(STAT_LL_CACHE, map_idx, rsd);
+	total = runtime_stat_avg(STAT_LL_CACHE, aggr_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -478,7 +478,7 @@ static void print_ll_cache_misses(struct perf_stat_config *config,
 static int prepare_metric(struct evsel **metric_events,
 			  struct metric_ref *metric_refs,
 			  struct expr_parse_ctx *pctx,
-			  int map_idx)
+			  int aggr_idx)
 {
 	double scale;
 	char *n;
@@ -516,7 +516,7 @@ static int prepare_metric(struct evsel **metric_events,
 				abort();
 			}
 		} else {
-			v = saved_value_lookup(metric_events[i], map_idx, false,
+			v = saved_value_lookup(metric_events[i], aggr_idx, false,
 					       STAT_NONE, 0,
 					       metric_events[i]->cgrp);
 			if (!v)
@@ -560,7 +560,7 @@ static void generic_metric(struct perf_stat_config *config,
 			   const char *metric_name,
 			   const char *metric_unit,
 			   int runtime,
-			   int map_idx,
+			   int aggr_idx,
 			   struct perf_stat_output_ctx *out)
 {
 	print_metric_t print_metric = out->print_metric;
@@ -578,7 +578,7 @@ static void generic_metric(struct perf_stat_config *config,
 		pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
 	pctx->sctx.runtime = runtime;
 	pctx->sctx.system_wide = config->system_wide;
-	i = prepare_metric(metric_events, metric_refs, pctx, map_idx);
+	i = prepare_metric(metric_events, metric_refs, pctx, aggr_idx);
 	if (i < 0) {
 		expr__ctx_free(pctx);
 		return;
@@ -630,7 +630,7 @@ static void generic_metric(struct perf_stat_config *config,
 	expr__ctx_free(pctx);
 }
 
-double test_generic_metric(struct metric_expr *mexp, int map_idx)
+double test_generic_metric(struct metric_expr *mexp, int aggr_idx)
 {
 	struct expr_parse_ctx *pctx;
 	double ratio = 0.0;
@@ -639,7 +639,7 @@ double test_generic_metric(struct metric_expr *mexp, int map_idx)
 	if (!pctx)
 		return NAN;
 
-	if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx, map_idx) < 0)
+	if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx, aggr_idx) < 0)
 		goto out;
 
 	if (expr__parse(&ratio, pctx, mexp->metric_expr))
@@ -652,7 +652,7 @@ double test_generic_metric(struct metric_expr *mexp, int map_idx)
 
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct evsel *evsel,
-				   double avg, int map_idx,
+				   double avg, int aggr_idx,
 				   struct perf_stat_output_ctx *out,
 				   struct rblist *metric_events)
 {
@@ -669,7 +669,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	if (config->iostat_run) {
 		iostat_print_metric(config, evsel, out);
 	} else if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
-		total = runtime_stat_avg(STAT_CYCLES, map_idx, &rsd);
+		total = runtime_stat_avg(STAT_CYCLES, aggr_idx, &rsd);
 
 		if (total) {
 			ratio = avg / total;
@@ -679,10 +679,10 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			print_metric(config, ctxp, NULL, NULL, "insn per cycle", 0);
 		}
 
-		total = runtime_stat_avg(STAT_STALLED_CYCLES_FRONT, map_idx, &rsd);
+		total = runtime_stat_avg(STAT_STALLED_CYCLES_FRONT, aggr_idx, &rsd);
 
 		total = max(total, runtime_stat_avg(STAT_STALLED_CYCLES_BACK,
-						    map_idx, &rsd));
+						    aggr_idx, &rsd));
 
 		if (total && avg) {
 			out->new_line(config, ctxp);
@@ -692,8 +692,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					ratio);
 		}
 	} else if (evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
-		if (runtime_stat_n(STAT_BRANCHES, map_idx, &rsd) != 0)
-			print_branch_misses(config, map_idx, avg, out, &rsd);
+		if (runtime_stat_n(STAT_BRANCHES, aggr_idx, &rsd) != 0)
+			print_branch_misses(config, aggr_idx, avg, out, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all branches", 0);
 	} else if (
@@ -702,8 +702,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(STAT_L1_DCACHE, map_idx, &rsd) != 0)
-			print_l1_dcache_misses(config, map_idx, avg, out, &rsd);
+		if (runtime_stat_n(STAT_L1_DCACHE, aggr_idx, &rsd) != 0)
+			print_l1_dcache_misses(config, aggr_idx, avg, out, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache accesses", 0);
 	} else if (
@@ -712,8 +712,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(STAT_L1_ICACHE, map_idx, &rsd) != 0)
-			print_l1_icache_misses(config, map_idx, avg, out, &rsd);
+		if (runtime_stat_n(STAT_L1_ICACHE, aggr_idx, &rsd) != 0)
+			print_l1_icache_misses(config, aggr_idx, avg, out, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all L1-icache accesses", 0);
 	} else if (
@@ -722,8 +722,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(STAT_DTLB_CACHE, map_idx, &rsd) != 0)
-			print_dtlb_cache_misses(config, map_idx, avg, out, &rsd);
+		if (runtime_stat_n(STAT_DTLB_CACHE, aggr_idx, &rsd) != 0)
+			print_dtlb_cache_misses(config, aggr_idx, avg, out, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache accesses", 0);
 	} else if (
@@ -732,8 +732,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(STAT_ITLB_CACHE, map_idx, &rsd) != 0)
-			print_itlb_cache_misses(config, map_idx, avg, out, &rsd);
+		if (runtime_stat_n(STAT_ITLB_CACHE, aggr_idx, &rsd) != 0)
+			print_itlb_cache_misses(config, aggr_idx, avg, out, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache accesses", 0);
 	} else if (
@@ -742,27 +742,27 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(STAT_LL_CACHE, map_idx, &rsd) != 0)
-			print_ll_cache_misses(config, map_idx, avg, out, &rsd);
+		if (runtime_stat_n(STAT_LL_CACHE, aggr_idx, &rsd) != 0)
+			print_ll_cache_misses(config, aggr_idx, avg, out, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all LL-cache accesses", 0);
 	} else if (evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
-		total = runtime_stat_avg(STAT_CACHEREFS, map_idx, &rsd);
+		total = runtime_stat_avg(STAT_CACHEREFS, aggr_idx, &rsd);
 
 		if (total)
 			ratio = avg * 100 / total;
 
-		if (runtime_stat_n(STAT_CACHEREFS, map_idx, &rsd) != 0)
+		if (runtime_stat_n(STAT_CACHEREFS, aggr_idx, &rsd) != 0)
 			print_metric(config, ctxp, NULL, "%8.3f %%",
 				     "of all cache refs", ratio);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all cache refs", 0);
 	} else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND)) {
-		print_stalled_cycles_frontend(config, map_idx, avg, out, &rsd);
+		print_stalled_cycles_frontend(config, aggr_idx, avg, out, &rsd);
 	} else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND)) {
-		print_stalled_cycles_backend(config, map_idx, avg, out, &rsd);
+		print_stalled_cycles_backend(config, aggr_idx, avg, out, &rsd);
 	} else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
-		total = runtime_stat_avg(STAT_NSECS, map_idx, &rsd);
+		total = runtime_stat_avg(STAT_NSECS, aggr_idx, &rsd);
 
 		if (total) {
 			ratio = avg / total;
@@ -776,11 +776,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				     avg / (ratio * evsel->scale));
 		else
 			print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
-	} else if (runtime_stat_n(STAT_NSECS, map_idx, &rsd) != 0) {
+	} else if (runtime_stat_n(STAT_NSECS, aggr_idx, &rsd) != 0) {
 		char unit = ' ';
 		char unit_buf[10] = "/sec";
 
-		total = runtime_stat_avg(STAT_NSECS, map_idx, &rsd);
+		total = runtime_stat_avg(STAT_NSECS, aggr_idx, &rsd);
 		if (total)
 			ratio = convert_unit_double(1000000000.0 * avg / total, &unit);
 
@@ -800,7 +800,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			generic_metric(config, mexp->metric_expr, mexp->metric_threshold,
 				       mexp->metric_events, mexp->metric_refs, evsel->name,
 				       mexp->metric_name, mexp->metric_unit, mexp->runtime,
-				       map_idx, out);
+				       aggr_idx, out);
 		}
 	}
 	if (num == 0)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 0d7538670d67..83dc4c1f4b12 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -651,15 +651,15 @@ void perf_stat_process_percore(struct perf_stat_config *config, struct evlist *e
 static void evsel__update_shadow_stats(struct evsel *evsel)
 {
 	struct perf_stat_evsel *ps = evsel->stats;
-	int i;
+	int aggr_idx;
 
 	if (ps->aggr == NULL)
 		return;
 
-	for (i = 0; i < ps->nr_aggr; i++) {
-		struct perf_counts_values *aggr_counts = &ps->aggr[i].counts;
+	for (aggr_idx = 0; aggr_idx < ps->nr_aggr; aggr_idx++) {
+		struct perf_counts_values *aggr_counts = &ps->aggr[aggr_idx].counts;
 
-		perf_stat__update_shadow_stats(evsel, aggr_counts->val, i);
+		perf_stat__update_shadow_stats(evsel, aggr_counts->val, aggr_idx);
 	}
 }
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 09975e098bd0..b01c828c3799 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -160,7 +160,7 @@ typedef void (*new_line_t)(struct perf_stat_config *config, void *ctx);
 void perf_stat__init_shadow_stats(void);
 void perf_stat__reset_shadow_stats(void);
 void perf_stat__reset_shadow_per_stat(void);
-void perf_stat__update_shadow_stats(struct evsel *counter, u64 count, int map_idx);
+void perf_stat__update_shadow_stats(struct evsel *counter, u64 count, int aggr_idx);
 struct perf_stat_output_ctx {
 	void *ctx;
 	print_metric_t print_metric;
@@ -170,7 +170,7 @@ struct perf_stat_output_ctx {
 
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct evsel *evsel,
-				   double avg, int map_idx,
+				   double avg, int aggr_idx,
 				   struct perf_stat_output_ctx *out,
 				   struct rblist *metric_events);
 
@@ -211,5 +211,5 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 			    struct target *_target, struct timespec *ts, int argc, const char **argv);
 
 struct metric_expr;
-double test_generic_metric(struct metric_expr *mexp, int map_idx);
+double test_generic_metric(struct metric_expr *mexp, int aggr_idx);
 #endif
-- 
2.39.2.637.g21b0678d19-goog


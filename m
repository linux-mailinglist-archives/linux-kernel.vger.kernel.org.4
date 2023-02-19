Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9536769BFC1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjBSJjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjBSJjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:39:00 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D087D59E3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:38:07 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k131-20020a256f89000000b0074747131938so226261ybc.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GaAtWKR9dpkXeAR2EgXOT4Jdr/WSY94NBCFSvIpDY1I=;
        b=VylUNAn6gHel5Js0dIwjbwarkGvBURpX13yLOd3CW4OTRSkRMUf8XHI2zSpfzbjBTl
         SB510gQdp40gx0uSZZLIgNNz4Kd88eaHe+lh/k2K9tn4l3KLtbeqrchgwWNAhiazTwQd
         Br7tiZX8fDhfDJ0Iq88Ivllx+3qI5YH0zvu/svcdpjZ+dbPcW5Wtvl4LbHk7hp38hz9C
         M0sCu7FAudJGP8OO1fJYzQVounuONNh5bliMIXH5XMWyetj1YHZsu5e4XHxoyfX1tq//
         75Z0Ygyq+8zK+P+XGK8lDR+F98LErBncmwBRFxwIQT5kmERsmDNZl+uUm2HDhfD5Bwu/
         7Mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GaAtWKR9dpkXeAR2EgXOT4Jdr/WSY94NBCFSvIpDY1I=;
        b=mFtFl5mFVKveobuxkt6VNXqPv8+QAxMk+Yeb3AVroUoQibbisOn2Jg7NVbubxNv/13
         DfJ8GwH0lASkw4BnhYYZOZ1UTHtCo4UFiJgJxAraJswI97j53p2zouzDFU+wpmNMwTxg
         xPUBIanri5mTbGBGaCbIC56HJngy0tIkful9R4HJ28cleGYhhva4RMixmlCkpxHiO00V
         i9H7l03YsNnuXhwO3rhAbWwZqmCqHPHcG4GIhdOzRTlx+XpOUMKmgTUzdLP04JehQuQH
         DKhj6FC5xNxkRQzwbXddgaKMk7v+jTx6H8WN8U5lixkV0rnrqgjDpptH+gOXNl4f+Zc1
         MnuA==
X-Gm-Message-State: AO0yUKXx967UPB3d2GyPh2UAli4vSfXD2pLXI/bxkZOYhDDYECJoPp5j
        FIXH/dTRh9yMY1aEmdgt6oiXzS7gPsB5
X-Google-Smtp-Source: AK7set8kPIXJz7JjvYoQFNFQqaZ1LyPc80VR3m+dsyBFK1HRmpLa0UEcK2ME+rxn30fnLOQdRJdH4tRDGizS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a05:6902:11cd:b0:90d:a6c0:6870 with SMTP
 id n13-20020a05690211cd00b0090da6c06870mr391638ybu.2.1676799362330; Sun, 19
 Feb 2023 01:36:02 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:47 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-51-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 50/51] perf stat: Use counts rather than saved_value
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

Switch the hard coded metrics to use the aggregate value rather than
from saved_value. When computing a metric like IPC the aggregate count
comes from instructions then cycles is looked up and if present IPC
computed. Rather than lookup from the saved_value rbtree, search the
counter's evlist for the desired counter.

A new helper evsel__stat_type is used to both quickly find a metric
function and to identify when a counter is the one being sought. So
that both total and miss counts can be sought, the stat_type enum is
expanded. The ratio functions are rewritten to share a common helper
with the ratios being directly passed rather than computed from an
enum value.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.h       |   2 +-
 tools/perf/util/stat-shadow.c | 534 +++++++++++++++++-----------------
 2 files changed, 270 insertions(+), 266 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 24cb807ef6ce..814a49ebb7e3 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -436,7 +436,7 @@ static inline bool evsel__is_bpf_output(struct evsel *evsel)
 	return evsel__match(evsel, SOFTWARE, SW_BPF_OUTPUT);
 }
 
-static inline bool evsel__is_clock(struct evsel *evsel)
+static inline bool evsel__is_clock(const struct evsel *evsel)
 {
 	return evsel__match(evsel, SOFTWARE, SW_CPU_CLOCK) ||
 	       evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK);
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index eba98520cea2..9d22cde09dc9 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -45,15 +45,23 @@ enum stat_type {
 	STAT_NONE = 0,
 	STAT_NSECS,
 	STAT_CYCLES,
+	STAT_INSTRUCTIONS,
 	STAT_STALLED_CYCLES_FRONT,
 	STAT_STALLED_CYCLES_BACK,
 	STAT_BRANCHES,
-	STAT_CACHEREFS,
+	STAT_BRANCH_MISS,
+	STAT_CACHE_REFS,
+	STAT_CACHE_MISSES,
 	STAT_L1_DCACHE,
 	STAT_L1_ICACHE,
 	STAT_LL_CACHE,
 	STAT_ITLB_CACHE,
 	STAT_DTLB_CACHE,
+	STAT_L1D_MISS,
+	STAT_L1I_MISS,
+	STAT_LL_MISS,
+	STAT_DTLB_MISS,
+	STAT_ITLB_MISS,
 	STAT_MAX
 };
 
@@ -168,7 +176,7 @@ void perf_stat__init_shadow_stats(void)
 	rblist->node_delete = saved_value_delete;
 }
 
-static int evsel_context(struct evsel *evsel)
+static int evsel_context(const struct evsel *evsel)
 {
 	int ctx = 0;
 
@@ -253,7 +261,7 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 	else if (evsel__match(counter, HARDWARE, HW_BRANCH_INSTRUCTIONS))
 		update_runtime_stat(STAT_BRANCHES, aggr_idx, count, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_CACHE_REFERENCES))
-		update_runtime_stat(STAT_CACHEREFS, aggr_idx, count, &rsd);
+		update_runtime_stat(STAT_CACHE_REFS, aggr_idx, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1D))
 		update_runtime_stat(STAT_L1_DCACHE, aggr_idx, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1I))
@@ -266,199 +274,283 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 		update_runtime_stat(STAT_ITLB_CACHE, aggr_idx, count, &rsd);
 }
 
-/* used for get_ratio_color() */
-enum grc_type {
-	GRC_STALLED_CYCLES_FE,
-	GRC_STALLED_CYCLES_BE,
-	GRC_CACHE_MISSES,
-	GRC_MAX_NR
-};
+static enum stat_type evsel__stat_type(const struct evsel *evsel)
+{
+	/* Fake perf_hw_cache_op_id values for use with evsel__match. */
+	u64 PERF_COUNT_hw_cache_l1d_miss = PERF_COUNT_HW_CACHE_L1D |
+		((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
+		((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16);
+	u64 PERF_COUNT_hw_cache_l1i_miss = PERF_COUNT_HW_CACHE_L1I |
+		((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
+		((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16);
+	u64 PERF_COUNT_hw_cache_ll_miss = PERF_COUNT_HW_CACHE_LL |
+		((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
+		((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16);
+	u64 PERF_COUNT_hw_cache_dtlb_miss = PERF_COUNT_HW_CACHE_DTLB |
+		((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
+		((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16);
+	u64 PERF_COUNT_hw_cache_itlb_miss = PERF_COUNT_HW_CACHE_ITLB |
+		((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
+		((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16);
+
+	if (evsel__is_clock(evsel))
+		return STAT_NSECS;
+	else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES))
+		return STAT_CYCLES;
+	else if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS))
+		return STAT_INSTRUCTIONS;
+	else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
+		return STAT_STALLED_CYCLES_FRONT;
+	else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND))
+		return STAT_STALLED_CYCLES_BACK;
+	else if (evsel__match(evsel, HARDWARE, HW_BRANCH_INSTRUCTIONS))
+		return STAT_BRANCHES;
+	else if (evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES))
+		return STAT_BRANCH_MISS;
+	else if (evsel__match(evsel, HARDWARE, HW_CACHE_REFERENCES))
+		return STAT_CACHE_REFS;
+	else if (evsel__match(evsel, HARDWARE, HW_CACHE_MISSES))
+		return STAT_CACHE_MISSES;
+	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_L1D))
+		return STAT_L1_DCACHE;
+	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_L1I))
+		return STAT_L1_ICACHE;
+	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_LL))
+		return STAT_LL_CACHE;
+	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_DTLB))
+		return STAT_DTLB_CACHE;
+	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_ITLB))
+		return STAT_ITLB_CACHE;
+	else if (evsel__match(evsel, HW_CACHE, hw_cache_l1d_miss))
+		return STAT_L1D_MISS;
+	else if (evsel__match(evsel, HW_CACHE, hw_cache_l1i_miss))
+		return STAT_L1I_MISS;
+	else if (evsel__match(evsel, HW_CACHE, hw_cache_ll_miss))
+		return STAT_LL_MISS;
+	else if (evsel__match(evsel, HW_CACHE, hw_cache_dtlb_miss))
+		return STAT_DTLB_MISS;
+	else if (evsel__match(evsel, HW_CACHE, hw_cache_itlb_miss))
+		return STAT_ITLB_MISS;
+	return STAT_NONE;
+}
 
-static const char *get_ratio_color(enum grc_type type, double ratio)
+static const char *get_ratio_color(const double ratios[3], double val)
 {
-	static const double grc_table[GRC_MAX_NR][3] = {
-		[GRC_STALLED_CYCLES_FE] = { 50.0, 30.0, 10.0 },
-		[GRC_STALLED_CYCLES_BE] = { 75.0, 50.0, 20.0 },
-		[GRC_CACHE_MISSES] 	= { 20.0, 10.0, 5.0 },
-	};
 	const char *color = PERF_COLOR_NORMAL;
 
-	if (ratio > grc_table[type][0])
+	if (val > ratios[0])
 		color = PERF_COLOR_RED;
-	else if (ratio > grc_table[type][1])
+	else if (val > ratios[1])
 		color = PERF_COLOR_MAGENTA;
-	else if (ratio > grc_table[type][2])
+	else if (val > ratios[2])
 		color = PERF_COLOR_YELLOW;
 
 	return color;
 }
 
-static double runtime_stat_avg(enum stat_type type, int aggr_idx,
-			       struct runtime_stat_data *rsd)
+static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type type)
 {
-	struct saved_value *v;
-
-	v = saved_value_lookup(NULL, aggr_idx, false, type, rsd->ctx, rsd->cgrp);
-	if (!v)
-		return 0.0;
-
-	return avg_stats(&v->stats);
+	const struct evsel *cur;
+	int evsel_ctx = evsel_context(evsel);
+
+	evlist__for_each_entry(evsel->evlist, cur) {
+		struct perf_stat_aggr *aggr;
+
+		/* Ignore the evsel that is being searched from. */
+		if (evsel == cur)
+			continue;
+
+		/* Ignore evsels that are part of different groups. */
+		if (evsel->core.leader->nr_members &&
+		    evsel->core.leader != cur->core.leader)
+			continue;
+		/* Ignore evsels with mismatched modifiers. */
+		if (evsel_ctx != evsel_context(cur))
+			continue;
+		/* Ignore if not the cgroup we're looking for. */
+		if (evsel->cgrp != cur->cgrp)
+			continue;
+		/* Ignore if not the stat we're looking for. */
+		if (type != evsel__stat_type(cur))
+			continue;
+
+		aggr = &cur->stats->aggr[aggr_idx];
+		if (type == STAT_NSECS)
+			return aggr->counts.val;
+		return aggr->counts.val * cur->scale;
+	}
+	return 0.0;
 }
 
-static double runtime_stat_n(enum stat_type type, int aggr_idx,
-			     struct runtime_stat_data *rsd)
+static void print_ratio(struct perf_stat_config *config,
+			const struct evsel *evsel, int aggr_idx,
+			double numerator, struct perf_stat_output_ctx *out,
+			enum stat_type denominator_type,
+			const double color_ratios[3], const char *unit)
 {
-	struct saved_value *v;
+	double denominator = find_stat(evsel, aggr_idx, denominator_type);
 
-	v = saved_value_lookup(NULL, aggr_idx, false, type, rsd->ctx, rsd->cgrp);
-	if (!v)
-		return 0.0;
+	if (numerator && denominator) {
+		double ratio = numerator / denominator * 100.0;
+		const char *color = get_ratio_color(color_ratios, ratio);
 
-	return v->stats.n;
+		out->print_metric(config, out->ctx, color, "%7.2f%%", unit, ratio);
+	} else
+		out->print_metric(config, out->ctx, NULL, NULL, unit, 0);
 }
 
-static void print_stalled_cycles_frontend(struct perf_stat_config *config,
-					  int aggr_idx, double avg,
-					  struct perf_stat_output_ctx *out,
-					  struct runtime_stat_data *rsd)
+static void print_stalled_cycles_front(struct perf_stat_config *config,
+				const struct evsel *evsel,
+				int aggr_idx, double stalled,
+				struct perf_stat_output_ctx *out)
 {
-	double total, ratio = 0.0;
-	const char *color;
-
-	total = runtime_stat_avg(STAT_CYCLES, aggr_idx, rsd);
-
-	if (total)
-		ratio = avg / total * 100.0;
+	static const double color_ratios[3] = {50.0, 30.0, 10.0};
 
-	color = get_ratio_color(GRC_STALLED_CYCLES_FE, ratio);
-
-	if (ratio)
-		out->print_metric(config, out->ctx, color, "%7.2f%%", "frontend cycles idle",
-				  ratio);
-	else
-		out->print_metric(config, out->ctx, NULL, NULL, "frontend cycles idle", 0);
+	print_ratio(config, evsel, aggr_idx, stalled, out, STAT_CYCLES, color_ratios,
+		    "frontend cycles idle");
 }
 
-static void print_stalled_cycles_backend(struct perf_stat_config *config,
-					 int aggr_idx, double avg,
-					 struct perf_stat_output_ctx *out,
-					 struct runtime_stat_data *rsd)
+static void print_stalled_cycles_back(struct perf_stat_config *config,
+				const struct evsel *evsel,
+				int aggr_idx, double stalled,
+				struct perf_stat_output_ctx *out)
 {
-	double total, ratio = 0.0;
-	const char *color;
-
-	total = runtime_stat_avg(STAT_CYCLES, aggr_idx, rsd);
-
-	if (total)
-		ratio = avg / total * 100.0;
+	static const double color_ratios[3] = {75.0, 50.0, 20.0};
 
-	color = get_ratio_color(GRC_STALLED_CYCLES_BE, ratio);
-
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "backend cycles idle", ratio);
+	print_ratio(config, evsel, aggr_idx, stalled, out, STAT_CYCLES, color_ratios,
+		    "backend cycles idle");
 }
 
-static void print_branch_misses(struct perf_stat_config *config,
-				int aggr_idx, double avg,
-				struct perf_stat_output_ctx *out,
-				struct runtime_stat_data *rsd)
+static void print_branch_miss(struct perf_stat_config *config,
+			const struct evsel *evsel,
+			int aggr_idx, double misses,
+			struct perf_stat_output_ctx *out)
 {
-	double total, ratio = 0.0;
-	const char *color;
-
-	total = runtime_stat_avg(STAT_BRANCHES, aggr_idx, rsd);
-
-	if (total)
-		ratio = avg / total * 100.0;
+	static const double color_ratios[3] = {20.0, 10.0, 5.0};
 
-	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all branches", ratio);
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_BRANCHES, color_ratios,
+		    "of all branches");
 }
 
-static void print_l1_dcache_misses(struct perf_stat_config *config,
-				   int aggr_idx, double avg,
-				   struct perf_stat_output_ctx *out,
-				   struct runtime_stat_data *rsd)
+static void print_l1d_miss(struct perf_stat_config *config,
+			const struct evsel *evsel,
+			int aggr_idx, double misses,
+			struct perf_stat_output_ctx *out)
 {
-	double total, ratio = 0.0;
-	const char *color;
-
-	total = runtime_stat_avg(STAT_L1_DCACHE, aggr_idx, rsd);
+	static const double color_ratios[3] = {20.0, 10.0, 5.0};
 
-	if (total)
-		ratio = avg / total * 100.0;
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_L1_DCACHE, color_ratios,
+		    "of all L1-dcache accesses");
+}
 
-	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
+static void print_l1i_miss(struct perf_stat_config *config,
+			const struct evsel *evsel,
+			int aggr_idx, double misses,
+			struct perf_stat_output_ctx *out)
+{
+	static const double color_ratios[3] = {20.0, 10.0, 5.0};
 
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-dcache accesses", ratio);
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_L1_ICACHE, color_ratios,
+		    "of all L1-icache accesses");
 }
 
-static void print_l1_icache_misses(struct perf_stat_config *config,
-				   int aggr_idx, double avg,
-				   struct perf_stat_output_ctx *out,
-				   struct runtime_stat_data *rsd)
+static void print_ll_miss(struct perf_stat_config *config,
+			const struct evsel *evsel,
+			int aggr_idx, double misses,
+			struct perf_stat_output_ctx *out)
 {
-	double total, ratio = 0.0;
-	const char *color;
+	static const double color_ratios[3] = {20.0, 10.0, 5.0};
 
-	total = runtime_stat_avg(STAT_L1_ICACHE, aggr_idx, rsd);
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_LL_CACHE, color_ratios,
+		    "of all L1-icache accesses");
+}
 
-	if (total)
-		ratio = avg / total * 100.0;
+static void print_dtlb_miss(struct perf_stat_config *config,
+			const struct evsel *evsel,
+			int aggr_idx, double misses,
+			struct perf_stat_output_ctx *out)
+{
+	static const double color_ratios[3] = {20.0, 10.0, 5.0};
 
-	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-icache accesses", ratio);
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_DTLB_CACHE, color_ratios,
+		    "of all dTLB cache accesses");
 }
 
-static void print_dtlb_cache_misses(struct perf_stat_config *config,
-				    int aggr_idx, double avg,
-				    struct perf_stat_output_ctx *out,
-				    struct runtime_stat_data *rsd)
+static void print_itlb_miss(struct perf_stat_config *config,
+			const struct evsel *evsel,
+			int aggr_idx, double misses,
+			struct perf_stat_output_ctx *out)
 {
-	double total, ratio = 0.0;
-	const char *color;
+	static const double color_ratios[3] = {20.0, 10.0, 5.0};
 
-	total = runtime_stat_avg(STAT_DTLB_CACHE, aggr_idx, rsd);
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_ITLB_CACHE, color_ratios,
+		    "of all iTLB cache accesses");
+}
 
-	if (total)
-		ratio = avg / total * 100.0;
+static void print_cache_miss(struct perf_stat_config *config,
+			const struct evsel *evsel,
+			int aggr_idx, double misses,
+			struct perf_stat_output_ctx *out)
+{
+	static const double color_ratios[3] = {20.0, 10.0, 5.0};
 
-	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all dTLB cache accesses", ratio);
+	print_ratio(config, evsel, aggr_idx, misses, out, STAT_CACHE_REFS, color_ratios,
+		    "of all cache refs");
 }
 
-static void print_itlb_cache_misses(struct perf_stat_config *config,
-				    int aggr_idx, double avg,
-				    struct perf_stat_output_ctx *out,
-				    struct runtime_stat_data *rsd)
+static void print_instructions(struct perf_stat_config *config,
+			const struct evsel *evsel,
+			int aggr_idx, double instructions,
+			struct perf_stat_output_ctx *out)
 {
-	double total, ratio = 0.0;
-	const char *color;
+	print_metric_t print_metric = out->print_metric;
+	void *ctxp = out->ctx;
+	double cycles = find_stat(evsel, aggr_idx, STAT_CYCLES);
+	double max_stalled = max(find_stat(evsel, aggr_idx, STAT_STALLED_CYCLES_FRONT),
+				find_stat(evsel, aggr_idx, STAT_STALLED_CYCLES_BACK));
+
+	if (cycles) {
+		print_metric(config, ctxp, NULL, "%7.2f ", "insn per cycle",
+			instructions / cycles);
+	} else
+		print_metric(config, ctxp, NULL, NULL, "insn per cycle", 0);
+
+	if (max_stalled && instructions) {
+		out->new_line(config, ctxp);
+		print_metric(config, ctxp, NULL, "%7.2f ", "stalled cycles per insn",
+			max_stalled / instructions);
+	}
+}
 
-	total = runtime_stat_avg(STAT_ITLB_CACHE, aggr_idx, rsd);
+static void print_cycles(struct perf_stat_config *config,
+			const struct evsel *evsel,
+			int aggr_idx, double cycles,
+			struct perf_stat_output_ctx *out)
+{
+	double nsecs = find_stat(evsel, aggr_idx, STAT_NSECS);
 
-	if (total)
-		ratio = avg / total * 100.0;
+	if (cycles && nsecs) {
+		double ratio = cycles / nsecs;
 
-	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all iTLB cache accesses", ratio);
+		out->print_metric(config, out->ctx, NULL, "%8.3f", "GHz", ratio);
+	} else
+		out->print_metric(config, out->ctx, NULL, NULL, "GHz", 0);
 }
 
-static void print_ll_cache_misses(struct perf_stat_config *config,
-				  int aggr_idx, double avg,
-				  struct perf_stat_output_ctx *out,
-				  struct runtime_stat_data *rsd)
+static void print_nsecs(struct perf_stat_config *config,
+			const struct evsel *evsel,
+			int aggr_idx __maybe_unused, double nsecs,
+			struct perf_stat_output_ctx *out)
 {
-	double total, ratio = 0.0;
-	const char *color;
-
-	total = runtime_stat_avg(STAT_LL_CACHE, aggr_idx, rsd);
-
-	if (total)
-		ratio = avg / total * 100.0;
+	print_metric_t print_metric = out->print_metric;
+	void *ctxp = out->ctx;
+	double wall_time = avg_stats(&walltime_nsecs_stats);
 
-	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all LL-cache accesses", ratio);
+	if (wall_time) {
+		print_metric(config, ctxp, NULL, "%8.3f", "CPUs utilized",
+			nsecs / (wall_time * evsel->scale));
+	} else
+		print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
 }
 
 static int prepare_metric(struct evsel **metric_events,
@@ -638,139 +730,51 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct perf_stat_output_ctx *out,
 				   struct rblist *metric_events)
 {
-	void *ctxp = out->ctx;
-	print_metric_t print_metric = out->print_metric;
-	double total, ratio = 0.0;
-	struct runtime_stat_data rsd = {
-		.ctx = evsel_context(evsel),
-		.cgrp = evsel->cgrp,
+	typedef void (*stat_print_function_t)(struct perf_stat_config *config,
+					const struct evsel *evsel,
+					int aggr_idx, double misses,
+					struct perf_stat_output_ctx *out);
+	static const stat_print_function_t stat_print_function[STAT_MAX] = {
+		[STAT_INSTRUCTIONS] = print_instructions,
+		[STAT_BRANCH_MISS] = print_branch_miss,
+		[STAT_L1D_MISS] = print_l1d_miss,
+		[STAT_L1I_MISS] = print_l1i_miss,
+		[STAT_DTLB_MISS] = print_dtlb_miss,
+		[STAT_ITLB_MISS] = print_itlb_miss,
+		[STAT_LL_MISS] = print_ll_miss,
+		[STAT_CACHE_MISSES] = print_cache_miss,
+		[STAT_STALLED_CYCLES_FRONT] = print_stalled_cycles_front,
+		[STAT_STALLED_CYCLES_BACK] = print_stalled_cycles_back,
+		[STAT_CYCLES] = print_cycles,
+		[STAT_NSECS] = print_nsecs,
 	};
+	print_metric_t print_metric = out->print_metric;
+	void *ctxp = out->ctx;
 	struct metric_event *me;
 	int num = 1;
 
 	if (config->iostat_run) {
 		iostat_print_metric(config, evsel, out);
-	} else if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
-		total = runtime_stat_avg(STAT_CYCLES, aggr_idx, &rsd);
-
-		if (total) {
-			ratio = avg / total;
-			print_metric(config, ctxp, NULL, "%7.2f ",
-					"insn per cycle", ratio);
-		} else {
-			print_metric(config, ctxp, NULL, NULL, "insn per cycle", 0);
-		}
-
-		total = runtime_stat_avg(STAT_STALLED_CYCLES_FRONT, aggr_idx, &rsd);
-
-		total = max(total, runtime_stat_avg(STAT_STALLED_CYCLES_BACK,
-						    aggr_idx, &rsd));
-
-		if (total && avg) {
-			out->new_line(config, ctxp);
-			ratio = total / avg;
-			print_metric(config, ctxp, NULL, "%7.2f ",
-					"stalled cycles per insn",
-					ratio);
-		}
-	} else if (evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
-		if (runtime_stat_n(STAT_BRANCHES, aggr_idx, &rsd) != 0)
-			print_branch_misses(config, aggr_idx, avg, out, &rsd);
-		else
-			print_metric(config, ctxp, NULL, NULL, "of all branches", 0);
-	} else if (
-		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
-		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_L1D |
-					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
-					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
-
-		if (runtime_stat_n(STAT_L1_DCACHE, aggr_idx, &rsd) != 0)
-			print_l1_dcache_misses(config, aggr_idx, avg, out, &rsd);
-		else
-			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache accesses", 0);
-	} else if (
-		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
-		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_L1I |
-					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
-					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
-
-		if (runtime_stat_n(STAT_L1_ICACHE, aggr_idx, &rsd) != 0)
-			print_l1_icache_misses(config, aggr_idx, avg, out, &rsd);
-		else
-			print_metric(config, ctxp, NULL, NULL, "of all L1-icache accesses", 0);
-	} else if (
-		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
-		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_DTLB |
-					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
-					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
-
-		if (runtime_stat_n(STAT_DTLB_CACHE, aggr_idx, &rsd) != 0)
-			print_dtlb_cache_misses(config, aggr_idx, avg, out, &rsd);
-		else
-			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache accesses", 0);
-	} else if (
-		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
-		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_ITLB |
-					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
-					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
-
-		if (runtime_stat_n(STAT_ITLB_CACHE, aggr_idx, &rsd) != 0)
-			print_itlb_cache_misses(config, aggr_idx, avg, out, &rsd);
-		else
-			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache accesses", 0);
-	} else if (
-		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
-		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_LL |
-					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
-					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
-
-		if (runtime_stat_n(STAT_LL_CACHE, aggr_idx, &rsd) != 0)
-			print_ll_cache_misses(config, aggr_idx, avg, out, &rsd);
-		else
-			print_metric(config, ctxp, NULL, NULL, "of all LL-cache accesses", 0);
-	} else if (evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
-		total = runtime_stat_avg(STAT_CACHEREFS, aggr_idx, &rsd);
-
-		if (total)
-			ratio = avg * 100 / total;
-
-		if (runtime_stat_n(STAT_CACHEREFS, aggr_idx, &rsd) != 0)
-			print_metric(config, ctxp, NULL, "%8.3f %%",
-				     "of all cache refs", ratio);
-		else
-			print_metric(config, ctxp, NULL, NULL, "of all cache refs", 0);
-	} else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND)) {
-		print_stalled_cycles_frontend(config, aggr_idx, avg, out, &rsd);
-	} else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND)) {
-		print_stalled_cycles_backend(config, aggr_idx, avg, out, &rsd);
-	} else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
-		total = runtime_stat_avg(STAT_NSECS, aggr_idx, &rsd);
-
-		if (total) {
-			ratio = avg / total;
-			print_metric(config, ctxp, NULL, "%8.3f", "GHz", ratio);
-		} else {
-			print_metric(config, ctxp, NULL, NULL, "Ghz", 0);
-		}
-	} else if (evsel__is_clock(evsel)) {
-		if ((ratio = avg_stats(&walltime_nsecs_stats)) != 0)
-			print_metric(config, ctxp, NULL, "%8.3f", "CPUs utilized",
-				     avg / (ratio * evsel->scale));
-		else
-			print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
-	} else if (runtime_stat_n(STAT_NSECS, aggr_idx, &rsd) != 0) {
-		char unit = ' ';
-		char unit_buf[10] = "/sec";
-
-		total = runtime_stat_avg(STAT_NSECS, aggr_idx, &rsd);
-		if (total)
-			ratio = convert_unit_double(1000000000.0 * avg / total, &unit);
-
-		if (unit != ' ')
-			snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
-		print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
 	} else {
-		num = 0;
+		stat_print_function_t fn = stat_print_function[evsel__stat_type(evsel)];
+
+		if (fn)
+			fn(config, evsel, aggr_idx, avg, out);
+		else {
+			double nsecs =	find_stat(evsel, aggr_idx, STAT_NSECS);
+
+			if (nsecs) {
+				char unit = ' ';
+				char unit_buf[10] = "/sec";
+				double ratio = convert_unit_double(1000000000.0 * avg / nsecs,
+								   &unit);
+
+				if (unit != ' ')
+					snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
+				print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
+			} else
+				num = 0;
+		}
 	}
 
 	if ((me = metricgroup__lookup(metric_events, evsel, false)) != NULL) {
-- 
2.39.2.637.g21b0678d19-goog


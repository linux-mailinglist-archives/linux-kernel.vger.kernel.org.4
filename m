Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A065F97DA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiJJFgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiJJFgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:36:23 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2376F3FD79;
        Sun,  9 Oct 2022 22:36:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i6so4387008pli.12;
        Sun, 09 Oct 2022 22:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJaczI01tyhdsGxfV4ZkIGHj2qd4LfWM2bLmZxZZHts=;
        b=nk3X740jKAZbMf+AR5jkaRRjDsadWtSrq20Al665qy1uS2mBc1qKSDeHBbiKyIz+F7
         3zo11JUKxWcCEn6PVuojgZS1p5zzyXtsHkRinbX05N2qh080eaEnEwzoIiuCbuIKc4J8
         ckJxYmNQWZY5mlJn1vHUE7QPHsc0V/nukHD7ND/5nP2CIx4HqeKU9V9Nu/brBCF8px91
         i6okCsOco2G2/IJdTC0d4BjKNrSpvKBs0u1+oCEtGtdTTb3WUwk71KzfSu/0iPxbcpfn
         X89PHrsyrfncV1kYPEs48Lu+kSi49lrn/EeMrlrGWKthp5e4rYR/Lx3mMjqYSP6lJdp+
         e/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OJaczI01tyhdsGxfV4ZkIGHj2qd4LfWM2bLmZxZZHts=;
        b=F+ru6+OPGu+JhmiD1q9q3qaN+sSlM0qxzEmCIi1Pltwad6OttYfG4CfGxDUEIcVIBv
         YcIHecJs4oPRvJPwGS3ZUKcSIVPRZqewdyF1MeE0tSMneL6MlViPrrBB8eEReINOdOUD
         rcYU4yLFx1lQfrNSn7ntJKiMQBCR4LvmuOuPWq52i8PutkS1JUnzoe/s7FONDb16Zpsg
         YgUJKApleuqFWT6bEEuUhENnUl3sHBbkiMSl1fj8Yl7k7GmXBChWV+uNoO5M1cIM32s7
         bKFTkDdemXMJXnbBeWZOlnG17c1EfBVnhZj7XhnU3BNNWTNQGwwXOQzEhaCUFs4GVxjb
         wlUg==
X-Gm-Message-State: ACrzQf14g/M14mWP/klqKZrzZE5DN54n/x4rUuJNtD5GYBtocl8p5KJB
        LIno6nK+ti+MNUAEi2duIms=
X-Google-Smtp-Source: AMsMyM5svQlZr2RkMAU9666Asp1XQlAel36qJdXTH7aWxlc18XZP0OhoEAXMjmt4nSih1Co0XcAXkQ==
X-Received: by 2002:a17:90b:3b47:b0:202:a81f:4059 with SMTP id ot7-20020a17090b3b4700b00202a81f4059mr30292837pjb.150.1665380176544;
        Sun, 09 Oct 2022 22:36:16 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:862f:cd0e:bf30:6d69])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0017f7e0f4a4esm5667594plg.35.2022.10.09.22.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:16 -0700 (PDT)
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
Subject: [PATCH 09/19] perf stat: Aggregate events using evsel->stats->aggr
Date:   Sun,  9 Oct 2022 22:35:50 -0700
Message-Id: <20221010053600.272854-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221010053600.272854-1-namhyung@kernel.org>
References: <20221010053600.272854-1-namhyung@kernel.org>
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

Add a logic to aggregate counter values to the new evsel->stats->aggr.
This is not used yet so shadow stats are not updated.  But later patch
will convert the existing code to use it.

With that, we don't need to handle AGGR_GLOBAL specially anymore.  It
can use the same logic with counts, prev_counts and aggr_counts.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c                     |  3 --
 tools/perf/util/evsel.c                       |  9 +---
 .../scripting-engines/trace-event-python.c    |  6 ---
 tools/perf/util/stat.c                        | 46 ++++++++++++++++---
 4 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index eaddafbd7ff2..139e35ed68d3 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -963,9 +963,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		init_stats(&walltime_nsecs_stats);
 		update_stats(&walltime_nsecs_stats, t1 - t0);
 
-		if (stat_config.aggr_mode == AGGR_GLOBAL)
-			evlist__save_aggr_prev_raw_counts(evsel_list);
-
 		evlist__copy_prev_raw_counts(evsel_list);
 		evlist__reset_prev_raw_counts(evsel_list);
 		perf_stat__reset_shadow_per_stat(&rt_stat);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a6ea91c72659..a1fcb3166149 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1526,13 +1526,8 @@ void evsel__compute_deltas(struct evsel *evsel, int cpu_map_idx, int thread,
 	if (!evsel->prev_raw_counts)
 		return;
 
-	if (cpu_map_idx == -1) {
-		tmp = evsel->prev_raw_counts->aggr;
-		evsel->prev_raw_counts->aggr = *count;
-	} else {
-		tmp = *perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
-		*perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread) = *count;
-	}
+	tmp = *perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
+	*perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread) = *count;
 
 	count->val = count->val - tmp.val;
 	count->ena = count->ena - tmp.ena;
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 1f2040f36d4e..7bc8559dce6a 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1653,12 +1653,6 @@ static void python_process_stat(struct perf_stat_config *config,
 	struct perf_cpu_map *cpus = counter->core.cpus;
 	int cpu, thread;
 
-	if (config->aggr_mode == AGGR_GLOBAL) {
-		process_stat(counter, (struct perf_cpu){ .cpu = -1 }, -1, tstamp,
-			     &counter->counts->aggr);
-		return;
-	}
-
 	for (thread = 0; thread < threads->nr; thread++) {
 		for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
 			process_stat(counter, perf_cpu_map__cpu(cpus, cpu),
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 374149628507..99874254809d 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -387,6 +387,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		       struct perf_counts_values *count)
 {
 	struct perf_counts_values *aggr = &evsel->counts->aggr;
+	struct perf_stat_evsel *ps = evsel->stats;
 	static struct perf_counts_values zero;
 	bool skip = false;
 
@@ -398,6 +399,44 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 	if (skip)
 		count = &zero;
 
+	if (!evsel->snapshot)
+		evsel__compute_deltas(evsel, cpu_map_idx, thread, count);
+	perf_counts_values__scale(count, config->scale, NULL);
+
+	if (ps->aggr) {
+		struct perf_cpu cpu = perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx);
+		struct aggr_cpu_id aggr_id = config->aggr_get_id(config, cpu);
+		struct perf_stat_aggr *ps_aggr;
+		int i;
+
+		for (i = 0; i < ps->nr_aggr; i++) {
+			if (!aggr_cpu_id__equal(&aggr_id, &config->aggr_map->map[i]))
+				continue;
+
+			ps_aggr = &ps->aggr[i];
+			ps_aggr->nr++;
+
+			/*
+			 * When any result is bad, make them all to give
+			 * consistent output in interval mode.
+			 */
+			if (count->ena == 0 || count->run == 0 ||
+			    evsel->counts->scaled == -1) {
+				ps_aggr->counts.val = 0;
+				ps_aggr->counts.ena = 0;
+				ps_aggr->counts.run = 0;
+				ps_aggr->failed = true;
+			}
+
+			if (!ps_aggr->failed) {
+				ps_aggr->counts.val += count->val;
+				ps_aggr->counts.ena += count->ena;
+				ps_aggr->counts.run += count->run;
+			}
+			break;
+		}
+	}
+
 	switch (config->aggr_mode) {
 	case AGGR_THREAD:
 	case AGGR_CORE:
@@ -405,9 +444,6 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 	case AGGR_SOCKET:
 	case AGGR_NODE:
 	case AGGR_NONE:
-		if (!evsel->snapshot)
-			evsel__compute_deltas(evsel, cpu_map_idx, thread, count);
-		perf_counts_values__scale(count, config->scale, NULL);
 		if ((config->aggr_mode == AGGR_NONE) && (!evsel->percore)) {
 			perf_stat__update_shadow_stats(evsel, count->val,
 						       cpu_map_idx, &rt_stat);
@@ -469,10 +505,6 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 	if (config->aggr_mode != AGGR_GLOBAL)
 		return 0;
 
-	if (!counter->snapshot)
-		evsel__compute_deltas(counter, -1, -1, aggr);
-	perf_counts_values__scale(aggr, config->scale, &counter->counts->scaled);
-
 	update_stats(&ps->res_stats, *count);
 
 	if (verbose > 0) {
-- 
2.38.0.rc1.362.ged0d419d3c-goog


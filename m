Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B925FE8C7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJNGQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiJNGQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:16:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8A817414;
        Thu, 13 Oct 2022 23:16:08 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 204so3997025pfx.10;
        Thu, 13 Oct 2022 23:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xwiX9ikbazKVy6BuloKenXceW5yARy9JMuN2/w1Xq0=;
        b=disYc/44Yz0x0FeK2k4NIIzBi4ECqUdBJMwzsGzIJR/S6zLTSTIx0Wq1otNQ5jJwbj
         Ky4mFUADNHjYajOI6sd3j+LReOA/e435xteN8+CcRbVHMeMtVyCtRFOAIKUSnlJ/aIbJ
         kkULMBFrA8bvpSElA+mUdhgMcq7tJQZWVL19+5nzL5YVSh8QGodalUjws4nCpAgG77ZF
         UhClLXV357uG1ktv1mZMCQqZikOaIjjWp0cL7nW/79CLMwC8I/RQGqessfFkGjsf3r6G
         LhwRQENsJ0ysAeTA3/jwDW9UMHmIXkf0wqMwupySGaY6Jq2yklcUOcnfB+CtmKL2lw+U
         PDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4xwiX9ikbazKVy6BuloKenXceW5yARy9JMuN2/w1Xq0=;
        b=AZJ/QkfNMZxdfO9Lvb14GgpyXZnORUs36Q7qXV+SHoqejNZVD8SMY/sAJ/mwJMjfGB
         wMyZCQ8nEPe6kYsUu+xNbchoUwFF8YJr3ohwnD44Pg9Xuxq0wrIjDdTzxKNEC6CoXcDS
         DucRt5ZQ97+nV5g6qa6n7DoQm4mO+g9nGImZoUEeFjmO5233CEaoPLac4wtNrjOhTUYf
         cml0yzXxEQ8CBH8SAz5xvK/EwFK95xE1gUCGSN37IUAHDFnKJRQMVuUaraPZpcyyCvu6
         dWs5JvjIRIGbbrfPYD4Os3QAJ8CDrlT4AkTBnWKMf9I08nj9b15hOmmGwnAqMMwLfNx4
         KLnw==
X-Gm-Message-State: ACrzQf2YoOK913j7Q6h8vzas4CRvSJ9Gc6WeGqpDu8n/pYsWfapRohY0
        0KeiDnIYPXaAVWx6GBqyaLg=
X-Google-Smtp-Source: AMsMyM5TK5UWmoAamg/++tL0iZUrmytHVlWBauonJRvvohPv4bFULoynKeLsRZ+lnokpAKoOaslSFw==
X-Received: by 2002:a63:5322:0:b0:44e:11f7:b414 with SMTP id h34-20020a635322000000b0044e11f7b414mr3187757pgb.226.1665728167437;
        Thu, 13 Oct 2022 23:16:07 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:630:195c:38a7:a411])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b0020af2411721sm721942pjo.34.2022.10.13.23.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:16:06 -0700 (PDT)
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
Date:   Thu, 13 Oct 2022 23:15:40 -0700
Message-Id: <20221014061550.463644-10-namhyung@kernel.org>
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
index 92a8e4512f98..abede56d79b6 100644
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
2.38.0.413.g74048e4d9e-goog


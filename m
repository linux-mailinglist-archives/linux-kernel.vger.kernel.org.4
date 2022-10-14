Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5915FE8C8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiJNGQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJNGQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:16:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E838517423;
        Thu, 13 Oct 2022 23:16:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pq16so4046038pjb.2;
        Thu, 13 Oct 2022 23:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJyT/jhQLO0o6wsISkqr66GasnJPnHjtYGimcC6nrmI=;
        b=RlaMO08oW0Y/4ls0tD3F9i8Ffvq6PcyYUdkqEBiT+Nq8vy7gqVceZf2G4GZ5l18tde
         Ox0Vha0o0+aaUCGznLuwuGG65al57mrPWGxNizDW1mWEwsyEYjjMkY/0PQCeHcT4othb
         nawh0We3wf9UvtgKXVsvheJiEjLsJRMnj9PivffA1EiZ0frZU0Dq4jWmdVoXe+W7KDz6
         cwEV2DOGrv7r1DnX8lXjU0hQEVVayAyZdAlKyYsn0MDYXrz4tZPfvjnPlG8fzFMNCGoH
         iEw4c/WIBiDYbYon8yOUwUyBpbHpSrk7QWfPqogQJCVtga018vkKqDYkOIpu3YvBMXNx
         kJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NJyT/jhQLO0o6wsISkqr66GasnJPnHjtYGimcC6nrmI=;
        b=xy4ga/3yUHtitwmiCS5zsPMDFibl2u8vB1i3dTRUueF/istKr6cudwEYduv3DHE0j6
         H0FPIoPbWldRGUQMfiq6lpYG4thWZvE0/xeWHjSG2pjteXlWV7/AeiG4Om4BcP44xpA6
         iT2JF3hg08l1EMIIAoZwscHLXN7j7Y94hlLEXnVWqaHdAEOwhUk2IUcHKZjSEzIXg0Xd
         AiKb3cjHrNeNW5jtyrPV5Hwh49C00Uqcql7qXPcjBjlmWbs+9S/Ap2Wkaiy26wdTTj6/
         NyPqCMlT5ipITfWI7Zy6GDQQpsBK/aEawZ5+dVvHSXgpnF7qS/wHWTF/7N3ibTto/uiw
         AI9w==
X-Gm-Message-State: ACrzQf0HkDARc6Vu4rjy9JWnP35JTpJZ71T3OMhgsxKHVXdu5JePza88
        Z7/70KeABSLi4JTgtXYTFrM++J8Wn+k=
X-Google-Smtp-Source: AMsMyM4ig4FqLQ0L0m477qqwvYx+B31XfNHEi6YEK348iLBqB2g2QEVLxDV48l8MJJLkdepqav1WIw==
X-Received: by 2002:a17:903:1207:b0:185:4042:23d2 with SMTP id l7-20020a170903120700b00185404223d2mr2852807plh.143.1665728168967;
        Thu, 13 Oct 2022 23:16:08 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:630:195c:38a7:a411])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b0020af2411721sm721942pjo.34.2022.10.13.23.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:16:08 -0700 (PDT)
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
Subject: [PATCH 10/19] perf stat: Aggregate per-thread stats using evsel->stats->aggr
Date:   Thu, 13 Oct 2022 23:15:41 -0700
Message-Id: <20221014061550.463644-11-namhyung@kernel.org>
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

Per-thread aggregation doesn't use the CPU numbers but the logic should
be the same.  Initialize cpu_aggr_map separately for AGGR_THREAD and use
thread map idx to aggregate counter values.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/stat.c    | 26 +++++++++++++++++++++++---
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index abede56d79b6..6777fef0d56c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1465,6 +1465,21 @@ static int perf_stat_init_aggr_mode(void)
 		stat_config.aggr_get_id = aggr_mode__get_id(stat_config.aggr_mode);
 	}
 
+	if (stat_config.aggr_mode == AGGR_THREAD) {
+		nr = perf_thread_map__nr(evsel_list->core.threads);
+		stat_config.aggr_map = cpu_aggr_map__empty_new(nr);
+		if (stat_config.aggr_map == NULL)
+			return -ENOMEM;
+
+		for (int s = 0; s < nr; s++) {
+			struct aggr_cpu_id id = aggr_cpu_id__empty();
+
+			id.thread_idx = s;
+			stat_config.aggr_map->map[s] = id;
+		}
+		return 0;
+	}
+
 	/*
 	 * The evsel_list->cpus is the base we operate on,
 	 * taking the highest cpu number to be the size of
@@ -1674,6 +1689,22 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 	aggr_cpu_id_get_t get_id = aggr_mode__get_aggr_file(stat_config.aggr_mode);
 	bool needs_sort = stat_config.aggr_mode != AGGR_NONE;
 
+	if (stat_config.aggr_mode == AGGR_THREAD) {
+		int nr = perf_thread_map__nr(evsel_list->core.threads);
+
+		stat_config.aggr_map = cpu_aggr_map__empty_new(nr);
+		if (stat_config.aggr_map == NULL)
+			return -ENOMEM;
+
+		for (int s = 0; s < nr; s++) {
+			struct aggr_cpu_id id = aggr_cpu_id__empty();
+
+			id.thread_idx = s;
+			stat_config.aggr_map->map[s] = id;
+		}
+		return 0;
+	}
+
 	if (!get_id)
 		return 0;
 
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 99874254809d..3593af403188 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -403,6 +403,24 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		evsel__compute_deltas(evsel, cpu_map_idx, thread, count);
 	perf_counts_values__scale(count, config->scale, NULL);
 
+	if (config->aggr_mode == AGGR_THREAD) {
+		struct perf_counts_values *aggr_counts = &ps->aggr[thread].counts;
+
+		/*
+		 * Skip value 0 when enabling --per-thread globally,
+		 * otherwise too many 0 output.
+		 */
+		if (count->val == 0 && config->system_wide)
+			return 0;
+
+		ps->aggr[thread].nr++;
+
+		aggr_counts->val += count->val;
+		aggr_counts->ena += count->ena;
+		aggr_counts->run += count->run;
+		goto update;
+	}
+
 	if (ps->aggr) {
 		struct perf_cpu cpu = perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx);
 		struct aggr_cpu_id aggr_id = config->aggr_get_id(config, cpu);
@@ -417,10 +435,11 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 			ps_aggr->nr++;
 
 			/*
-			 * When any result is bad, make them all to give
-			 * consistent output in interval mode.
+			 * When any result is bad, make them all to give consistent output
+			 * in interval mode.  But per-task counters can have 0 enabled time
+			 * when some tasks are idle.
 			 */
-			if (count->ena == 0 || count->run == 0 ||
+			if (((count->ena == 0 || count->run == 0) && cpu.cpu != -1) ||
 			    evsel->counts->scaled == -1) {
 				ps_aggr->counts.val = 0;
 				ps_aggr->counts.ena = 0;
@@ -437,6 +456,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		}
 	}
 
+update:
 	switch (config->aggr_mode) {
 	case AGGR_THREAD:
 	case AGGR_CORE:
-- 
2.38.0.413.g74048e4d9e-goog


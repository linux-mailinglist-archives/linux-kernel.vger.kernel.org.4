Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4286E6020C8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiJRCD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiJRCDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:03:05 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6FD8D0D1;
        Mon, 17 Oct 2022 19:02:51 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e129so12045281pgc.9;
        Mon, 17 Oct 2022 19:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFSeqc5wPOk9fULwPnm3VQika9Wjm0SthcR5M/scKqk=;
        b=VmAnUG4z5Z6AXUZcsN63rFYP0NsmchwMa/HFryoXD/HSSq+dJkary9Gg70Qt/685tH
         vkCaJWXPzwUIXlSLJOjXBEDrKoJMFdIn1xAKZFBVTM8qzEh0gdwBDO4SHGQIe49GHq25
         lqZzKmBlf0+p9gxmZVNll8zaogCh86p/9dUCbhO4mHBRWlnbVqvXQENR6b2zGnbRV+RT
         nYPT8l84baJ/Iq06t0knKxAbL7G8a3giP3F/2JOZsHh8ihibt3LPGBlT4OeLNVsKoa7l
         CXG/pFXRdoVeK/EBbRFvDyFqJVZ/5TyHYrzwBUGg86VR1QhTc0CX33ttMl2N33BADo5b
         Z+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OFSeqc5wPOk9fULwPnm3VQika9Wjm0SthcR5M/scKqk=;
        b=Hvtv+xLFjXcDi+FcEZLv7OGJPlFQlch7eS6fMDtIpvhHd4MzwfRs3W4HY6kchtjlbj
         EDQ/+mS+5QyxcG+f3Vvka2xPo016J8jUuVNSOZkVz36c+st5v6ue7gia1+Xtu9tApytT
         LHjyAXre2s7k9GxzwSLuXiQEAmMVRpktyefFgmsLkLqRTuNzcCeA/f3j4zVCRqEPSwKw
         HjrN2LqynXdKXWaBpi7sP2zJcvTmrQN+ZDZosSxlv2OkvhDBdxGV9Jso2IW+hcuWjpMR
         TkpdjP0sFqIechTBP35Uwi5ruNUELLglXTc6PcQ6hLwO7JLgTONougVsL2I5NPwB7l/c
         d2yw==
X-Gm-Message-State: ACrzQf1XSQB6/sfFejAzDg0FmNscjnxsSKOCL9cz7pp4H7C5AJKd9bfc
        jOfvgA/N6bD23q0OEE6T41g=
X-Google-Smtp-Source: AMsMyM4yD48AE8JV8Xed0sgMmQEhec6Zxn1GnHEAMBKzu5nqy7KhmQxs7Jyumo9FziS1YsPdnRSXqg==
X-Received: by 2002:a63:6a48:0:b0:43a:18ce:4e08 with SMTP id f69-20020a636a48000000b0043a18ce4e08mr670865pgc.432.1666058570704;
        Mon, 17 Oct 2022 19:02:50 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1f90:85c4:58f0:7a81:6bb5])
        by smtp.gmail.com with ESMTPSA id t4-20020a655544000000b00464858cf6b0sm6851564pgr.54.2022.10.17.19.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:02:50 -0700 (PDT)
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
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 11/20] perf stat: Aggregate per-thread stats using evsel->stats->aggr
Date:   Mon, 17 Oct 2022 19:02:18 -0700
Message-Id: <20221018020227.85905-12-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221018020227.85905-1-namhyung@kernel.org>
References: <20221018020227.85905-1-namhyung@kernel.org>
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
 tools/perf/util/stat.c    | 24 ++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 2 deletions(-)

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
index dc075d5a0f72..5b04c9d16156 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -422,6 +422,24 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
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
@@ -436,8 +454,9 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 			ps_aggr->nr++;
 
 			/*
-			 * When any result is bad, make them all to give
-			 * consistent output in interval mode.
+			 * When any result is bad, make them all to give consistent output
+			 * in interval mode.  But per-task counters can have 0 enabled time
+			 * when some tasks are idle.
 			 */
 			if (evsel__count_has_error(evsel, count, config) && !ps_aggr->failed) {
 				ps_aggr->counts.val = 0;
@@ -455,6 +474,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		}
 	}
 
+update:
 	switch (config->aggr_mode) {
 	case AGGR_THREAD:
 	case AGGR_CORE:
-- 
2.38.0.413.g74048e4d9e-goog


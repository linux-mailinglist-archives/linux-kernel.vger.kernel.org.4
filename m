Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C156D5F97E5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiJJFht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiJJFhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:37:02 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF52D52FCF;
        Sun,  9 Oct 2022 22:36:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 10so9519297pli.0;
        Sun, 09 Oct 2022 22:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZRfNgpH8+QQskCftYrV3a1L7cFwkrDDjN2C/btv0xM=;
        b=CrjTwzbv9QdU2O7HOgqcbEbr5SNOMwRCiDybfIdwVA3jgqwRcXmdSXWb0DQCBW/Sxe
         eqTYvbHUsVnKe/L8fhHLAFZw8fwhA6S6JhuSNC27IHjtLrNqBeqJjd9u7p1+NOrQCBvT
         IpxYeteOBkWsC5We+9IZnybLpUppKes+ly0ctN9jyknoDHFAOa+qpGlC8IWkeDk7X+V4
         YTTjJPIYHr1ybPw6YmMCzIulCk10lu6ZO8MdbG7iMPRhhbA/uz0dGbTPkjMuxOd5dbTL
         BoVHwynWGBk4fVfLqLUAZZpu2kNFdtHBppPd3i1djVKhJ6obWbGJnCvpPKEtZ/bh3MIw
         q2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ZRfNgpH8+QQskCftYrV3a1L7cFwkrDDjN2C/btv0xM=;
        b=dFxORnZ4XMGhflqFMSOrCD/ZHQvpeTpxSZL+dPquDpdXD2vZ5zetwuCe5hAt6iZGyI
         q5njF7CMbWhKQtv0aaT3P4Jm2M8UF/V9RhuyF2pPjIXgu8ylybHEJa9SiqbYVkqutkcM
         VQXxFeDjq4PqFizxXvPz/j5ndUwTKBYYAW7rVB1bfuAgLh3La3ZL53R8OprJxIgqBhGw
         PahTiSAHeXA3Uiz/Go+OeFZEBe7UYahB5Nr3/7wgmK1oeYhJzenqHNah2SQ7NWTSUcv8
         42oACwY/Wcs7sOVBE1sj1zAw8vIc8k4kWhjj0tJ6Kboi5YwWWtHGnPgNZs7JuOeepkl4
         MiKA==
X-Gm-Message-State: ACrzQf1WH9W28DFdKFKqGqCKmmp+ZtMhT58mQiJWbYXA73G39MzQBDSQ
        szdn5Q5UB961I2EU766jpV0=
X-Google-Smtp-Source: AMsMyM4tcmbSFEYk6C7wDIQIZtfrOgXnBkkUnsAPW/oelNBgiQNT6rPdzE+wyVgY/YothJXFb72nvw==
X-Received: by 2002:a17:902:8bc3:b0:178:8563:8e42 with SMTP id r3-20020a1709028bc300b0017885638e42mr17096014plo.0.1665380191303;
        Sun, 09 Oct 2022 22:36:31 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:862f:cd0e:bf30:6d69])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0017f7e0f4a4esm5667594plg.35.2022.10.09.22.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:30 -0700 (PDT)
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
Subject: [PATCH 19/19] perf stat: Remove unused perf_counts.aggr field
Date:   Sun,  9 Oct 2022 22:36:00 -0700
Message-Id: <20221010053600.272854-20-namhyung@kernel.org>
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

The aggr field in the struct perf_counts is to keep the aggregated value
in the AGGR_GLOBAL for the old code.  But it's not used anymore.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/counts.c |  1 -
 tools/perf/util/counts.h |  1 -
 tools/perf/util/stat.c   | 35 ++---------------------------------
 3 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
index 7a447d918458..11cd85b278a6 100644
--- a/tools/perf/util/counts.c
+++ b/tools/perf/util/counts.c
@@ -48,7 +48,6 @@ void perf_counts__reset(struct perf_counts *counts)
 {
 	xyarray__reset(counts->loaded);
 	xyarray__reset(counts->values);
-	memset(&counts->aggr, 0, sizeof(struct perf_counts_values));
 }
 
 void evsel__reset_counts(struct evsel *evsel)
diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
index 5de275194f2b..42760242e0df 100644
--- a/tools/perf/util/counts.h
+++ b/tools/perf/util/counts.h
@@ -11,7 +11,6 @@ struct evsel;
 
 struct perf_counts {
 	s8			  scaled;
-	struct perf_counts_values aggr;
 	struct xyarray		  *values;
 	struct xyarray		  *loaded;
 };
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 1652586a4925..0dccfa273fa7 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -307,8 +307,6 @@ static void evsel__copy_prev_raw_counts(struct evsel *evsel)
 				*perf_counts(evsel->prev_raw_counts, idx, thread);
 		}
 	}
-
-	evsel->counts->aggr = evsel->prev_raw_counts->aggr;
 }
 
 void evlist__copy_prev_raw_counts(struct evlist *evlist)
@@ -319,26 +317,6 @@ void evlist__copy_prev_raw_counts(struct evlist *evlist)
 		evsel__copy_prev_raw_counts(evsel);
 }
 
-void evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
-{
-	struct evsel *evsel;
-
-	/*
-	 * To collect the overall statistics for interval mode,
-	 * we copy the counts from evsel->prev_raw_counts to
-	 * evsel->counts. The perf_stat_process_counter creates
-	 * aggr values from per cpu values, but the per cpu values
-	 * are 0 for AGGR_GLOBAL. So we use a trick that saves the
-	 * previous aggr value to the first member of perf_counts,
-	 * then aggr calculation in process_counter_values can work
-	 * correctly.
-	 */
-	evlist__for_each_entry(evlist, evsel) {
-		*perf_counts(evsel->prev_raw_counts, 0, 0) =
-			evsel->prev_raw_counts->aggr;
-	}
-}
-
 static size_t pkg_id_hash(const void *__key, void *ctx __maybe_unused)
 {
 	uint64_t *key = (uint64_t *) __key;
@@ -422,7 +400,6 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		       int cpu_map_idx, int thread,
 		       struct perf_counts_values *count)
 {
-	struct perf_counts_values *aggr = &evsel->counts->aggr;
 	struct perf_stat_evsel *ps = evsel->stats;
 	static struct perf_counts_values zero;
 	bool skip = false;
@@ -491,12 +468,6 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		}
 	}
 
-	if (config->aggr_mode == AGGR_GLOBAL) {
-		aggr->val += count->val;
-		aggr->ena += count->ena;
-		aggr->run += count->run;
-	}
-
 	return 0;
 }
 
@@ -521,13 +492,10 @@ static int process_counter_maps(struct perf_stat_config *config,
 int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter)
 {
-	struct perf_counts_values *aggr = &counter->counts->aggr;
 	struct perf_stat_evsel *ps = counter->stats;
-	u64 *count = counter->counts->aggr.values;
+	u64 *count;
 	int ret;
 
-	aggr->val = aggr->ena = aggr->run = 0;
-
 	if (counter->per_pkg)
 		evsel__zero_per_pkg(counter);
 
@@ -538,6 +506,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 	if (config->aggr_mode != AGGR_GLOBAL)
 		return 0;
 
+	count = ps->aggr[0].counts.values;
 	update_stats(&ps->res_stats, *count);
 
 	if (verbose > 0) {
-- 
2.38.0.rc1.362.ged0d419d3c-goog


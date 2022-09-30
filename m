Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513575F138B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiI3UVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiI3UV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:21:29 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A7E16F870;
        Fri, 30 Sep 2022 13:21:24 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id b2so6106plc.7;
        Fri, 30 Sep 2022 13:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=gaKVcdg7nG01aH0xPvFxnu6z2t5ABFSyWMEd87RCeYs=;
        b=YCCod0UwySnssFIEfMtfvjP10JCgu8WMu8rtHlIuVYORIuX5YEIVZiq2nrroAn/CUK
         nbpBVrQO4R2uqPx67/kOKoOkZ0wC3rhPwka962/4gvm65eFuI909gg/gG15YepQkYmj0
         FoyXyd8QiMlvGf+QRP2XoRz3Hrz31R36DFJdLPUZVS9E9G3McpYCjKALo7cYpG3jPvxu
         9Esti7f56mmZOmgvxi8EibcsfEVP41Fju8zZtKS8iJ0Rrn9ifyBJE+81P91Sl9BvE4M1
         J7NciwfV9+qvMiXnFnugXzTpF05ClkqPGXxewq1j8J3M3hJfOoCSjnhHt5cZ6/H+MEfJ
         Xr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=gaKVcdg7nG01aH0xPvFxnu6z2t5ABFSyWMEd87RCeYs=;
        b=0sYGUmiy2DiZQPxqBk2Wz2sHkIMpnx6VAafgRfIDCkQwiXmKDZPkiBRB8fDw3vfpHM
         12X5QSjRS8oJLMxGP2g490noS6XCzhIZEg7r4N0KpXEA48fEAqNU8yzEZqQgCO6Cfzrw
         GtVj2V2mdQA6uh27XV98GSVHpnnlcBQ26XDP985eWRc9pf2LvtlugbWo2C4gTYo+9ZdH
         pUX/yGtfTb091BKV4xC/Ahwp7Yf9LNmr7GXMCZr73BwJ8l9aXjBU0gkRj7pnv4v+e0C7
         QqoaBJBLyUnyf1ZqvkJn4yQJ/955DjM/d/fgC/od5IfT2UPAx6IyDnExHZIMwpCYOlVg
         eo0w==
X-Gm-Message-State: ACrzQf3vN+eHFefA0p6qqcJuC+qUYHfJDqsk8bJKU1SE821NDBrMMQPS
        GWzMr4PhyLH/afYjruxBfl0=
X-Google-Smtp-Source: AMsMyM5OpnGXwipU9JFa2X6RaYbHbXEoJQlgfwdlAVFhMgbV1ny+0nVSMXasBQKPZuCGL0PrUtsLlA==
X-Received: by 2002:a17:902:9b88:b0:17c:97d6:5e78 with SMTP id y8-20020a1709029b8800b0017c97d65e78mr4074655plp.62.1664569282769;
        Fri, 30 Sep 2022 13:21:22 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:4075:4245:762c:e746])
        by smtp.gmail.com with ESMTPSA id s10-20020a63e80a000000b0042fe1914e26sm2105540pgh.37.2022.09.30.13.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:21:22 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Subject: [PATCH 1/7] perf stat: Convert perf_stat_evsel.res_stats array
Date:   Fri, 30 Sep 2022 13:21:04 -0700
Message-Id: <20220930202110.845199-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220930202110.845199-1-namhyung@kernel.org>
References: <20220930202110.845199-1-namhyung@kernel.org>
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

It uses only one member, no need to have it as an array.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c |  2 +-
 tools/perf/util/stat.c         | 10 +++-------
 tools/perf/util/stat.h         |  2 +-
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index b82844cb0ce7..234491f43c36 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -67,7 +67,7 @@ static void print_noise(struct perf_stat_config *config,
 		return;
 
 	ps = evsel->stats;
-	print_noise_pct(config, stddev_stats(&ps->res_stats[0]), avg);
+	print_noise_pct(config, stddev_stats(&ps->res_stats), avg);
 }
 
 static void print_cgroup(struct perf_stat_config *config, struct evsel *evsel)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index ce5e9e372fc4..6bcd3dc32a71 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -132,12 +132,9 @@ static void perf_stat_evsel_id_init(struct evsel *evsel)
 
 static void evsel__reset_stat_priv(struct evsel *evsel)
 {
-	int i;
 	struct perf_stat_evsel *ps = evsel->stats;
 
-	for (i = 0; i < 3; i++)
-		init_stats(&ps->res_stats[i]);
-
+	init_stats(&ps->res_stats);
 	perf_stat_evsel_id_init(evsel);
 }
 
@@ -440,7 +437,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 	struct perf_counts_values *aggr = &counter->counts->aggr;
 	struct perf_stat_evsel *ps = counter->stats;
 	u64 *count = counter->counts->aggr.values;
-	int i, ret;
+	int ret;
 
 	aggr->val = aggr->ena = aggr->run = 0;
 
@@ -458,8 +455,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 		evsel__compute_deltas(counter, -1, -1, aggr);
 	perf_counts_values__scale(aggr, config->scale, &counter->counts->scaled);
 
-	for (i = 0; i < 3; i++)
-		update_stats(&ps->res_stats[i], count[i]);
+	update_stats(&ps->res_stats, *count);
 
 	if (verbose > 0) {
 		fprintf(config->output, "%s: %" PRIu64 " %" PRIu64 " %" PRIu64 "\n",
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 72713b344b79..3eba38a1a149 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -43,7 +43,7 @@ enum perf_stat_evsel_id {
 };
 
 struct perf_stat_evsel {
-	struct stats		 res_stats[3];
+	struct stats		 res_stats;
 	enum perf_stat_evsel_id	 id;
 	u64			*group_data;
 };
-- 
2.38.0.rc1.362.ged0d419d3c-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F475EB1CE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiIZUIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiIZUIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:08:04 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174C465649;
        Mon, 26 Sep 2022 13:08:02 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id b21so7224313plz.7;
        Mon, 26 Sep 2022 13:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=Y8C8oz+huARdrMZgl9qptQi98PJBj+1V0jnBMtVXEHc=;
        b=oIFsN6ZpRJ9RlO4+FgFopaehngnc+SMKCc9/qz8xJY2oGvri/GfyRfZw4pjG6Ru2J/
         9KTGKLC4MPZvuoIbYeziEiWgES76R5amclyIuvqH7ycO8IATwTdk/SF1aCpODl3TcEE6
         eo3VAiUcRMkKZhu6LueGpbyKuhXi5c3NwtD30+DD5BHZ7Db5iOqR0jIEgu+EuxTp0doe
         zGdPPnGSsIQFHM1Oz6HpO7t518TWGVOY27uLfV36zjxcIbwiWKY09ShwfWJxLOG8nx4X
         dVHVy0QAScNA6M+Tvche0s8ZtATctXyJnTLq+v2QlAssbBdzvtFXyeAluA8BttkrQHLn
         w/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=Y8C8oz+huARdrMZgl9qptQi98PJBj+1V0jnBMtVXEHc=;
        b=a9i8vubNqwu+BvUc78U7p09P+2Di/Kq9SoT1LjxswPZZv7gk4y0prEBsbruQgMEn5F
         n+ig4xAPHsHynuTKVd/3Mob/nND9US1ERFGQrJv+/5wGr8ZnmsHco9/S7hSNZDCjyr4M
         Nzk8rbzOe1BNcDnGyHI2FGaUzeN/vOA1n76BS4O4kC0sk91Oh19cwvEcNC6Zy6CKVT4N
         VgJ6EOGNkEoAOJPmOJBJIehkcvdkt9rVDiQ1NouTxdOU//5SWXDN9o60U/KYiVsdTE5z
         NwbVF8vi42gniCaJ0Hh4SeDmSSil/dX2vV6mOtA07Etm20mcvCniJ8q6c37RVz+fcBXy
         4yiw==
X-Gm-Message-State: ACrzQf2ScwIrxN9FIc1N7LFBB7ikXspkdBVp3XYECz4bpdIOyjEiDJMv
        MeeOrRcddf+SAZvwIdlpbBU=
X-Google-Smtp-Source: AMsMyM4cVqm+vOFXLn3YmloxorW5nhHq4yqmkJ4Xp+oG8SjrdHMuDcclWwioApBWL6wJzELflhfqsQ==
X-Received: by 2002:a17:902:848e:b0:178:54ce:c108 with SMTP id c14-20020a170902848e00b0017854cec108mr24307924plo.134.1664222881536;
        Mon, 26 Sep 2022 13:08:01 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:2d32:19ce:817e:166])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78bd5000000b00540c24ba181sm12510148pfd.120.2022.09.26.13.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:08:01 -0700 (PDT)
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
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: [PATCH 1/6] perf stat: Convert perf_stat_evsel.res_stats array
Date:   Mon, 26 Sep 2022 13:07:52 -0700
Message-Id: <20220926200757.1161448-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220926200757.1161448-1-namhyung@kernel.org>
References: <20220926200757.1161448-1-namhyung@kernel.org>
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
2.37.3.998.g577e59143f-goog


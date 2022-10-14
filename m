Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D7C5FE8C9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJNGQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiJNGQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:16:22 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C1C17434;
        Thu, 13 Oct 2022 23:16:11 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id i3so3998913pfk.9;
        Thu, 13 Oct 2022 23:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bVysEQHf7eswq/CEhQ6wbCV3Rg3qd7TUjqKNRIeNeE=;
        b=GUH+jcz2YrnwSsaJtxMkbKTcBz74pdxJwwFX8CexctZBDJc5Hh9YB3avVH6EZd33Em
         w2cBjLSRGRLgwGDCAO5RbiSEsmKFEvw+VsRir4V3rm8yJ+x+6349eTltQJG7XyENc2Gu
         pCb5dQ9d1O7ZQq17D7t6oBIG50I0fYkf3Ne4ExVT6V3cYPRldrqr4n9npruaCGt3aSWa
         8NFoZrCLppFPjVpcPZSxw2XO7OglEfZzYYS0GGupH5Lav15TtXBWO2aikd6koAidrxnr
         t5crTOcNK9xYWh+2TsisSaf8golRNtwWfmQPJhb5spvb809lb2RLHhb4f/PdJdf7Do9K
         WDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1bVysEQHf7eswq/CEhQ6wbCV3Rg3qd7TUjqKNRIeNeE=;
        b=RN75FvixC6Qxwx3/ukaQ/qHk0HWXG7g4J/Ev+rzy37F6FV5GtuRSEg+LryCqjtWkJ2
         LJ3e0JtSGSdlwIpukRzAhQU5voarbVNfgf4tsuwR/hD9UNf6SrZuffEFRYTG4Y6iUNmn
         S01MR1mDVEbTED+iQ4GYu6UDNV/yv9Jqp8ouBymc/xR9a+98pIIYsv/UF9joSaHPR1GH
         Se+6b6kN4o/BwhaV0tNEA43HXiWuExFJZbvY1m9wixOTt2a7RoBzlP1qr4/zBVjrDabV
         OBf/K4I8RSLHvWppPbZ+i/DIqHVrqXwvEbt03mIpz4I2Cn+RtG/U7BAXv+xlOXLfq6AO
         s3IA==
X-Gm-Message-State: ACrzQf2cYR5oi6sQLzRtqBW1H0IUZihTHpCjprGNHIRJT5nltXBN8Cc8
        sjZ1Q7Frp52kxLJ+uoEE4X8=
X-Google-Smtp-Source: AMsMyM77gWM2jS2vuCpjUZLZg0pA7po+ChrNGOqwYD8nCKV5xCflPpDezpxC20iCytVeaaLd1S+MLw==
X-Received: by 2002:a63:534e:0:b0:44e:12bf:2df8 with SMTP id t14-20020a63534e000000b0044e12bf2df8mr3205202pgl.143.1665728170544;
        Thu, 13 Oct 2022 23:16:10 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:630:195c:38a7:a411])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b0020af2411721sm721942pjo.34.2022.10.13.23.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:16:10 -0700 (PDT)
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
Subject: [PATCH 11/19] perf stat: Allocate aggr counts for recorded data
Date:   Thu, 13 Oct 2022 23:15:42 -0700
Message-Id: <20221014061550.463644-12-namhyung@kernel.org>
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

In the process_stat_config_event() it sets the aggr_mode that means the
earlier evlist__alloc_stats() cannot allocate the aggr counts due to the
missing aggr_mode.

Do it after setting the aggr_map using evlist__alloc_aggr_stats().

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 20 +++++++++++++++-----
 tools/perf/util/stat.c    | 39 +++++++++++++++++++++++++++++++--------
 tools/perf/util/stat.h    |  2 ++
 3 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6777fef0d56c..2a6a5d0c5563 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1342,7 +1342,11 @@ static struct aggr_cpu_id perf_stat__get_cpu(struct perf_stat_config *config __m
 static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
 					      aggr_get_id_t get_id, struct perf_cpu cpu)
 {
-	struct aggr_cpu_id id = aggr_cpu_id__empty();
+	struct aggr_cpu_id id;
+
+	/* per-process mode - should use global aggr mode */
+	if (cpu.cpu == -1)
+		return get_id(config, cpu);
 
 	if (aggr_cpu_id__is_empty(&config->cpus_aggr_map->map[cpu.cpu]))
 		config->cpus_aggr_map->map[cpu.cpu] = get_id(config, cpu);
@@ -2125,17 +2129,23 @@ int process_stat_config_event(struct perf_session *session,
 	if (perf_cpu_map__empty(st->cpus)) {
 		if (st->aggr_mode != AGGR_UNSET)
 			pr_warning("warning: processing task data, aggregation mode not set\n");
-		return 0;
-	}
-
-	if (st->aggr_mode != AGGR_UNSET)
+	} else if (st->aggr_mode != AGGR_UNSET) {
 		stat_config.aggr_mode = st->aggr_mode;
+	}
 
 	if (perf_stat.data.is_pipe)
 		perf_stat_init_aggr_mode();
 	else
 		perf_stat_init_aggr_mode_file(st);
 
+	if (stat_config.aggr_map) {
+		int nr_aggr = stat_config.aggr_map->nr;
+
+		if (evlist__alloc_aggr_stats(session->evlist, nr_aggr) < 0) {
+			pr_err("cannot allocate aggr counts\n");
+			return -1;
+		}
+	}
 	return 0;
 }
 
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 3593af403188..d0e5c4c402aa 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -141,6 +141,31 @@ static void evsel__reset_stat_priv(struct evsel *evsel)
 		memset(aggr, 0, sizeof(*aggr) * ps->nr_aggr);
 }
 
+static int evsel__alloc_aggr_stats(struct evsel *evsel, int nr_aggr)
+{
+	struct perf_stat_evsel *ps = evsel->stats;
+
+	if (ps == NULL)
+		return 0;
+
+	ps->nr_aggr = nr_aggr;
+	ps->aggr = calloc(nr_aggr, sizeof(*ps->aggr));
+	if (ps->aggr == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int evlist__alloc_aggr_stats(struct evlist *evlist, int nr_aggr)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__alloc_aggr_stats(evsel, nr_aggr) < 0)
+			return -1;
+	}
+	return 0;
+}
 
 static int evsel__alloc_stat_priv(struct evsel *evsel, int nr_aggr)
 {
@@ -150,16 +175,14 @@ static int evsel__alloc_stat_priv(struct evsel *evsel, int nr_aggr)
 	if (ps == NULL)
 		return -ENOMEM;
 
-	if (nr_aggr) {
-		ps->nr_aggr = nr_aggr;
-		ps->aggr = calloc(nr_aggr, sizeof(*ps->aggr));
-		if (ps->aggr == NULL) {
-			free(ps);
-			return -ENOMEM;
-		}
+	evsel->stats = ps;
+
+	if (nr_aggr && evsel__alloc_aggr_stats(evsel, nr_aggr) < 0) {
+		evsel->stats = NULL;
+		free(ps);
+		return -ENOMEM;
 	}
 
-	evsel->stats = ps;
 	perf_stat_evsel_id_init(evsel);
 	evsel__reset_stat_priv(evsel);
 	return 0;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 0980875b9be1..4c00f814bd79 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -275,6 +275,8 @@ void evlist__reset_prev_raw_counts(struct evlist *evlist);
 void evlist__copy_prev_raw_counts(struct evlist *evlist);
 void evlist__save_aggr_prev_raw_counts(struct evlist *evlist);
 
+int evlist__alloc_aggr_stats(struct evlist *evlist, int nr_aggr);
+
 int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter);
 struct perf_tool;
-- 
2.38.0.413.g74048e4d9e-goog


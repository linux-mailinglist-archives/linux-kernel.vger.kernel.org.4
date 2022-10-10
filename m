Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF465F97E4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiJJFho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiJJFgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:36:52 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E224652E76;
        Sun,  9 Oct 2022 22:36:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 10so9519250pli.0;
        Sun, 09 Oct 2022 22:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mgckiuZT4A5S64HSxdgHY7ssWz/sSATAtHWII5EHdg=;
        b=Vy7s3LMBzsCQi1pvo1KCGVbtQixJ6/DV0AR6Ho4xfI9lMn+I4Mnosps8acKkdwj0bV
         HJaTe3JgFtgrDp/XtY1OhZKKfPghIOl3r3NgOZmfa9bZsqf3av1v+GqJ2IN+O8kVKjZy
         MDW+IpovNwmstHT2QPboonSMA7SlmwvZhDRQq36UM8JNL9rct6+2yZews+F9CMhX2zXH
         mR+eqPgsWvxXPA1HxO5YI+rfodWoFoRnFEC0LzI+7IHESTinV1HzKGih9S3R5G57WU6B
         JYscyhDEhn7R+sHy0EjW1KpOsBhnev4IH3OQenFa3SpxSD9LpoGjDt59WQnGm6tz6mIi
         b9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4mgckiuZT4A5S64HSxdgHY7ssWz/sSATAtHWII5EHdg=;
        b=mHJltm88aW+HjHHbZpAm33BEUwXV9vLtX4EAGa7Dr7f2vJIo1CVRVVtRiYeDtDuxUQ
         iiwa0b5spgSR3EYuU+Sv8SEM7/si7il4cQfxPvqAxMBjqGUmNOMRUiVbnGDkIjjJzA/B
         vh5pt6mWYrM0Lw3fxlxy9OUIhK4SonM2+ty10mMF9zQfefQVhahsGkqtprmuFJ+zqGa9
         r+HOb725gS8HUF/f5G7twmiwe5uFQOjWFlVFDB0aRwNLJa9l+VhVsCrdrSiCRcvV9f6x
         g13W2HumGfVhvA0oC2A6laqT9mrFUsdwsrPaIATqyj7r3RqIEtY6AdBKolOFQFhVkOQV
         pbAQ==
X-Gm-Message-State: ACrzQf2m+0Tz95CEBjBo3zMMJd8Ro9uiDjlNJMb7U+GdRYIpH2E1K15R
        p+VB8AjAqxzXNgDRbbzj03Q=
X-Google-Smtp-Source: AMsMyM6KwCbUS9PDxMSrCENO26i0cdMxC0eSlCpmiStV4WMFZjAjJvAnGulkoJ4XUD/pzgr/eOKxKQ==
X-Received: by 2002:a17:90a:4607:b0:202:e22d:489c with SMTP id w7-20020a17090a460700b00202e22d489cmr30248410pjg.80.1665380189868;
        Sun, 09 Oct 2022 22:36:29 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:862f:cd0e:bf30:6d69])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0017f7e0f4a4esm5667594plg.35.2022.10.09.22.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:29 -0700 (PDT)
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
Subject: [PATCH 18/19] perf stat: Display percore events properly
Date:   Sun,  9 Oct 2022 22:35:59 -0700
Message-Id: <20221010053600.272854-19-namhyung@kernel.org>
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

The recent change in the perf stat broke the percore event display.
Note that the aggr counts are already processed so that the every
sibling thread in the same core will get the per-core counter values.

Check percore evsels and skip the sibling threads in the display.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c      | 16 ----------------
 tools/perf/util/stat-display.c | 27 +++++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d92815f4eae0..b3a39d4c86a7 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1403,18 +1403,6 @@ static struct aggr_cpu_id perf_stat__get_cpu_cached(struct perf_stat_config *con
 	return perf_stat__get_aggr(config, perf_stat__get_cpu, cpu);
 }
 
-static bool term_percore_set(void)
-{
-	struct evsel *counter;
-
-	evlist__for_each_entry(evsel_list, counter) {
-		if (counter->percore)
-			return true;
-	}
-
-	return false;
-}
-
 static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
 {
 	switch (aggr_mode) {
@@ -1427,8 +1415,6 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
 	case AGGR_NODE:
 		return aggr_cpu_id__node;
 	case AGGR_NONE:
-		if (term_percore_set())
-			return aggr_cpu_id__core;
 		return aggr_cpu_id__cpu;;
 	case AGGR_GLOBAL:
 		return aggr_cpu_id__global;
@@ -1452,8 +1438,6 @@ static aggr_get_id_t aggr_mode__get_id(enum aggr_mode aggr_mode)
 	case AGGR_NODE:
 		return perf_stat__get_node_cached;
 	case AGGR_NONE:
-		if (term_percore_set())
-			return perf_stat__get_core_cached;
 		return perf_stat__get_cpu_cached;
 	case AGGR_GLOBAL:
 		return perf_stat__get_global_cached;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 0c0e22c175a1..e0c0df99d40d 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1094,7 +1094,8 @@ static void print_percore(struct perf_stat_config *config,
 {
 	bool metric_only = config->metric_only;
 	FILE *output = config->output;
-	int s;
+	struct cpu_aggr_map *core_map;
+	int s, c, i;
 	bool first = true;
 
 	if (!config->aggr_map || !config->aggr_get_id)
@@ -1103,13 +1104,35 @@ static void print_percore(struct perf_stat_config *config,
 	if (config->percore_show_thread)
 		return print_counter(config, counter, prefix);
 
-	for (s = 0; s < config->aggr_map->nr; s++) {
+	core_map = cpu_aggr_map__empty_new(config->aggr_map->nr);
+	if (core_map == NULL) {
+		fprintf(output, "Cannot allocate per-core aggr map for display\n");
+		return;
+	}
+
+	for (s = 0, c = 0; s < config->aggr_map->nr; s++) {
+		struct perf_cpu curr_cpu = config->aggr_map->map[s].cpu;
+		struct aggr_cpu_id core_id = aggr_cpu_id__core(curr_cpu, NULL);
+		bool found = false;
+
+		for (i = 0; i < c; i++) {
+			if (aggr_cpu_id__equal(&core_map->map[i], &core_id)) {
+				found = true;
+				break;
+			}
+		}
+		if (found)
+			continue;
+
 		if (prefix && metric_only)
 			fprintf(output, "%s", prefix);
 
 		print_counter_aggrdata(config, counter, s,
 				       prefix, metric_only, &first);
+
+		core_map->map[c++] = core_id;
 	}
+	free(core_map);
 
 	if (metric_only)
 		fputc('\n', output);
-- 
2.38.0.rc1.362.ged0d419d3c-goog


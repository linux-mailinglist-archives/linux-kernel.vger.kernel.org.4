Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5421B6020D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiJRCEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiJRCDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:03:52 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B1C8E709;
        Mon, 17 Oct 2022 19:03:07 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h185so12041730pgc.10;
        Mon, 17 Oct 2022 19:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOCN0yzE3IzitqInAT6jHn/hIk/AewZCdKuWlAq5o8w=;
        b=QFMbmLS0UBISIKTM+y6Oi/q4ytSvyFzHWqzFqiH7fU0HbmXjN17XFMfh9L2HnYAYh6
         8TSe6TGD3mk5/Uz4D0a2kLGqvl8LcqRJU26M9rOF8fJBA91kcWUg6MD1WMRSnIGHjIHM
         0Jv0cRzmbySKpqeDvI9aKpQy34mg08BVifHhVr9sL92l9sc6KLTPof11tlxR+rJbz4HS
         aj/YaPs5+eBVgpj0G/IYnaFucZzHfBnso6iWgmKXTeqfW7tAuMonbr/fbtWwgYgPVBnm
         Dc3pDZw6SxkwEAXOcBoMsRGZ+XjUi41aX0+3LdbVcA/GMD4tnjRQQiluHl2kK6uDcnI+
         HWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OOCN0yzE3IzitqInAT6jHn/hIk/AewZCdKuWlAq5o8w=;
        b=bTpgwnAz7Rqmn1Pjg8vqAwVAjoVRFsO6PzEioesfPCYfjjIyAm9gfpfuzup4tgGfrD
         zaVUPyG8MHrG5qOqtYQCm77xYMzc478TeDfGNTDE+CxEJ5TN6qnjHk2LQYIhN2aquVnB
         6iuwDokR1rEQ4i4PP7ugG67yxRFjCpKW280IM6870UQi4p+l/tCpxop1d/DthJcEPrvI
         zGlb7ZE2k3iEVTmb8zL+n+p5p4v7AzCrPxsytobWOTenRWt+Wlp6ifnggngRCaT4GIet
         hNmlue9Yb8iugU/HfII9tNxULBytQWBtrvuwpzgDYpmiEZQ1IqjBL5KZk4EUK3EUycCW
         92Hg==
X-Gm-Message-State: ACrzQf1PMaYkdvvR+59rREM27ov5PNOwCzk8cIswUxfq4jTCh3y8JnKp
        b4i2XfQXylc2ePlIM+jk25w=
X-Google-Smtp-Source: AMsMyM4aqhTJyC9E9vV/Kmd3koMxXA4XaBo1cfHtHdy7Sb5afK7/BUdzPA7aVmARORpVM/r5+OrXCg==
X-Received: by 2002:a63:5a44:0:b0:431:fa3a:f92c with SMTP id k4-20020a635a44000000b00431fa3af92cmr636401pgm.471.1666058585500;
        Mon, 17 Oct 2022 19:03:05 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1f90:85c4:58f0:7a81:6bb5])
        by smtp.gmail.com with ESMTPSA id t4-20020a655544000000b00464858cf6b0sm6851564pgr.54.2022.10.17.19.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:03:04 -0700 (PDT)
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
Subject: [PATCH 19/20] perf stat: Display percore events properly
Date:   Mon, 17 Oct 2022 19:02:26 -0700
Message-Id: <20221018020227.85905-20-namhyung@kernel.org>
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

The recent change in the perf stat broke the percore event display.
Note that the aggr counts are already processed so that the every
sibling thread in the same core will get the per-core counter values.

Check percore evsels and skip the sibling threads in the display.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c      | 16 ----------------
 tools/perf/util/stat-display.c | 27 +++++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d7c52cef70a3..9d35a3338976 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1404,18 +1404,6 @@ static struct aggr_cpu_id perf_stat__get_cpu_cached(struct perf_stat_config *con
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
@@ -1428,8 +1416,6 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
 	case AGGR_NODE:
 		return aggr_cpu_id__node;
 	case AGGR_NONE:
-		if (term_percore_set())
-			return aggr_cpu_id__core;
 		return aggr_cpu_id__cpu;
 	case AGGR_GLOBAL:
 		return aggr_cpu_id__global;
@@ -1453,8 +1439,6 @@ static aggr_get_id_t aggr_mode__get_id(enum aggr_mode aggr_mode)
 	case AGGR_NODE:
 		return perf_stat__get_node_cached;
 	case AGGR_NONE:
-		if (term_percore_set())
-			return perf_stat__get_core_cached;
 		return perf_stat__get_cpu_cached;
 	case AGGR_GLOBAL:
 		return perf_stat__get_global_cached;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index bfae2784609c..657434cd29ee 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1091,7 +1091,8 @@ static void print_percore(struct perf_stat_config *config,
 {
 	bool metric_only = config->metric_only;
 	FILE *output = config->output;
-	int s;
+	struct cpu_aggr_map *core_map;
+	int s, c, i;
 	bool first = true;
 
 	if (!config->aggr_map || !config->aggr_get_id)
@@ -1100,13 +1101,35 @@ static void print_percore(struct perf_stat_config *config,
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
2.38.0.413.g74048e4d9e-goog


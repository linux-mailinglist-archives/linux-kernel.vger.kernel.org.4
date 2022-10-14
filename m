Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89815FE8D1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJNGR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJNGQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:16:42 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1DD17404;
        Thu, 13 Oct 2022 23:16:24 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 129so3494496pgc.5;
        Thu, 13 Oct 2022 23:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yu3prLTu/0wI4ZAj0BQDozCdKSFjzz2EwrQUPjw2yl8=;
        b=p0wbLICet0xmjRTI26DrsdMAyYXjDIpbrzhLgPVgYyOq1HJB7ARzIjSXPU/njCdeQU
         K/G1HsDb3gu6aWFc0yL7SUSWM8aTjy4Rrjx3E8OpZBSLxcbrIOhly1H6sFxIfotNhLwD
         aHJKeOqH1dEMPQEikmSICxqaTGOvuL9206L7AvgAXPMd9ehkj63Bwb/5aDBgtlt6znaR
         imN37iU680rjvHxp9fMuXmjxaJjF7rcII+K5rvridUjzmXbwJps9Hc5YL2Ui1gdeJrJi
         lRc85aQmF+SDXevgNk3oo61n5gsY63Sv6DXWMmWB0bYpCPMgBATabqrlSySu0Z4O7TOk
         0uUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yu3prLTu/0wI4ZAj0BQDozCdKSFjzz2EwrQUPjw2yl8=;
        b=0gu3aXcuM7FK1IWn42q72Q/or1bOr0JyhzPF5Q9dfjyqzvIIrUt0AKVrSf4A22r7hF
         339VsHf+iUcOSwHBQZrWiBFg/kfnXqLsy1o3T1mrNk1tIcSZAFayhq0eGoxh6hgTFh4i
         87Idfb60j/bKGraX4jXBaXF2ncO0ZmrnJ4ETPQznuMRSeMwmGGtQoMAFJkidwLnDMsCN
         ChTK/uHPKUUU1ek1rlkPHtZ15UxMowztrLIpLw5vqlkBUTH8jhFY1xeluam/FoKkvgg7
         My6uhZY4s0BWQ5DPdRTtxxmL5i2nM+zEzl0SBmz7LVSPRb59xzfCfdxK/1hjlD2c7DQ1
         0U5g==
X-Gm-Message-State: ACrzQf030NIYxZCP4ZbBQz2pOgDbCnsya7aWnlU7mzKggsksEd4ttkDP
        pp1Tl4bptjzmRENHps8+0ps=
X-Google-Smtp-Source: AMsMyM57iS4MfOB+CEZeC/RntQ/U9djjg+gdyU4i6lXialqbXH5Ejxv/SMa87awNPfapoRRX9vjvgg==
X-Received: by 2002:a05:6a00:acc:b0:530:e79e:fc27 with SMTP id c12-20020a056a000acc00b00530e79efc27mr3533437pfl.61.1665728181904;
        Thu, 13 Oct 2022 23:16:21 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:630:195c:38a7:a411])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b0020af2411721sm721942pjo.34.2022.10.13.23.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:16:21 -0700 (PDT)
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
Date:   Thu, 13 Oct 2022 23:15:49 -0700
Message-Id: <20221014061550.463644-19-namhyung@kernel.org>
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
index d9cd2db1398b..acdd14ac26db 100644
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


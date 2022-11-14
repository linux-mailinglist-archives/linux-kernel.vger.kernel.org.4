Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2035628D12
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238159AbiKNXEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbiKNXDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:03:35 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447811D0CD;
        Mon, 14 Nov 2022 15:02:55 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p21so11501317plr.7;
        Mon, 14 Nov 2022 15:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUGjDewK+aO2x22NgTca81ezePEJqtKcnqIInofdYc0=;
        b=Nu1quPwZo1yskrgF1eihnt838Q1iJxTsfR0lpStvoCZMAAgPmUIgVkd1k1KcgLgAkr
         f21vl7mchsZgmLpmX0aduzqWhm4RT+0+VLzULdPpqBDFrNv/BI2jbKD/+klBga6OChVG
         qCBTd/hkERzdD3v40/UCAxekt5ZTWI2TecbhyDNEumYwGGHG/5+86TZSjF+K02ZHHJmU
         d1eLy3HMcawQkybqryqw2gwg2Ajd35BoXbWZo84bv2ewx7OPzQfllhVD0tbqB1BxjQY8
         jiq2qCq3WmRpFclNN5CApsOjI7BzeLLQMvm3KvBRP1WHu8rerOHZHU4T3/kIXsST9del
         NuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QUGjDewK+aO2x22NgTca81ezePEJqtKcnqIInofdYc0=;
        b=CM33V1ezY/lifA+gH4la0V7cw1NrRNfHjQP5VUGtbW7f9oRyP8UsxGDpbTSxXmUpqv
         7zdeyF9AyFhh+b3cJoYuMiXGwkmRKdZ5P79v9uVCvyBnwTmJ7iM9xhT8HOQFY7e0UVUA
         OzRME6s4V59F285zpAPGNpn8KUMZacgKV5hs0k+nhNpLt6E38Wtcobdspxcee8/CRo3y
         ALWY0mk3d9R+ZI7v6YpqUW+rFnUAiDFUUmizfKBOVI9FOluJ58XgCy7n0L2qPSy/UZBC
         /KYjKxkqyC9bIGXQg2x/5+r4CdJtNVe6n3RkU9woiXzgOS8TVCnLx0ExA6gmCIKO/4t+
         QdmQ==
X-Gm-Message-State: ANoB5pm0u0BdV3MfP+HAntsVSxlSNn4pNZf3xlP3EsBVXMgB8sD/HoMz
        yM3un6uHYb/zjmNUMlUq8G5Gpsno8bU=
X-Google-Smtp-Source: AA0mqf4TeGPWXbefMuXS+vF94hu7/u9p+O+HDYKF6VxGZlrfDx32liLURHX3wfvph+Psoxl/cvmabg==
X-Received: by 2002:a17:90a:4003:b0:212:deef:a087 with SMTP id u3-20020a17090a400300b00212deefa087mr15837374pjc.77.1668466974859;
        Mon, 14 Nov 2022 15:02:54 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:54 -0800 (PST)
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
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 16/19] perf stat: Factor out prefix display
Date:   Mon, 14 Nov 2022 15:02:24 -0800
Message-Id: <20221114230227.1255976-17-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
In-Reply-To: <20221114230227.1255976-1-namhyung@kernel.org>
References: <20221114230227.1255976-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prefix is needed for interval mode to print timestamp at the
beginning of each line.  But the it's tricky for the metric only
mode since it doesn't print every evsel and combines the metrics
into a single line.

So it needed to pass 'first' argument to print_counter_aggrdata()
to determine if the current event is being printed at first.  This
makes the code hard to read.

Let's move the logic out of the function and do it in the outer
print loop.  This would enable further cleanups later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 43 ++++++++++++----------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 73cf898060c0..bb40ed29300d 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -805,8 +805,7 @@ static void uniquify_counter(struct perf_stat_config *config, struct evsel *coun
 
 static void print_counter_aggrdata(struct perf_stat_config *config,
 				   struct evsel *counter, int s,
-				   char *prefix, bool metric_only,
-				   bool *first)
+				   char *prefix, bool metric_only)
 {
 	FILE *output = config->output;
 	u64 ena, run, val;
@@ -825,10 +824,6 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	ena = aggr->counts.ena;
 	run = aggr->counts.run;
 
-	if (*first && metric_only) {
-		*first = false;
-		aggr_printout(config, counter, id, aggr->nr);
-	}
 	if (prefix && !metric_only)
 		fprintf(output, "%s", prefix);
 
@@ -849,7 +844,6 @@ static void print_aggr(struct perf_stat_config *config,
 	FILE *output = config->output;
 	struct evsel *counter;
 	int s;
-	bool first;
 
 	if (!config->aggr_map || !config->aggr_get_id)
 		return;
@@ -860,21 +854,23 @@ static void print_aggr(struct perf_stat_config *config,
 	 */
 	for (s = 0; s < config->aggr_map->nr; s++) {
 		if (metric_only) {
+			struct perf_stat_aggr *aggr;
+			struct aggr_cpu_id id = config->aggr_map->map[s];
+
 			if (prefix)
 				fprintf(output, "%s", prefix);
-			else if (config->summary && !config->no_csv_summary &&
-				 config->csv_output && !config->interval)
-				fprintf(output, "%16s%s", "summary", config->csv_sep);
+
+			counter = evlist__first(evlist);
+			aggr = &counter->stats->aggr[s];
+			aggr_printout(config, counter, id, aggr->nr);
 		}
 
-		first = true;
 		evlist__for_each_entry(evlist, counter) {
 			if (counter->merged_stat)
 				continue;
 
-			print_counter_aggrdata(config, counter, s,
-					       prefix, metric_only,
-					       &first);
+			print_counter_aggrdata(config, counter, s, prefix,
+					       metric_only);
 		}
 		if (metric_only)
 			fputc('\n', output);
@@ -885,7 +881,6 @@ static void print_counter(struct perf_stat_config *config,
 			  struct evsel *counter, char *prefix)
 {
 	bool metric_only = config->metric_only;
-	bool first = false;
 	int s;
 
 	/* AGGR_THREAD doesn't have config->aggr_get_id */
@@ -896,9 +891,8 @@ static void print_counter(struct perf_stat_config *config,
 		return;
 
 	for (s = 0; s < config->aggr_map->nr; s++) {
-		print_counter_aggrdata(config, counter, s,
-				       prefix, metric_only,
-				       &first);
+		print_counter_aggrdata(config, counter, s, prefix,
+				       metric_only);
 	}
 }
 
@@ -1260,7 +1254,6 @@ static void print_percore(struct perf_stat_config *config,
 	FILE *output = config->output;
 	struct cpu_aggr_map *core_map;
 	int s, c, i;
-	bool first = true;
 
 	if (!config->aggr_map || !config->aggr_get_id)
 		return;
@@ -1288,11 +1281,7 @@ static void print_percore(struct perf_stat_config *config,
 		if (found)
 			continue;
 
-		if (prefix && metric_only)
-			fprintf(output, "%s", prefix);
-
-		print_counter_aggrdata(config, counter, s,
-				       prefix, metric_only, &first);
+		print_counter_aggrdata(config, counter, s, prefix, metric_only);
 
 		core_map->map[c++] = core_id;
 	}
@@ -1319,10 +1308,6 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 	}
 
 	print_header(config, _target, evlist, argc, argv);
-	if (metric_only) {
-		if (config->aggr_mode == AGGR_GLOBAL && prefix && !config->iostat_run)
-			fprintf(config->output, "%s", prefix);
-	}
 
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
@@ -1337,6 +1322,8 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 			iostat_print_counters(evlist, config, ts, prefix = buf,
 					      print_counter);
 		else {
+			if (prefix && metric_only)
+				fprintf(config->output, "%s", prefix);
 			evlist__for_each_entry(evlist, counter) {
 				print_counter(config, counter, prefix);
 			}
-- 
2.38.1.493.g58b659f92b-goog


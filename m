Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F05628D16
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbiKNXEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237958AbiKNXEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:04:15 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0111D30B;
        Mon, 14 Nov 2022 15:02:56 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so12198522pjk.1;
        Mon, 14 Nov 2022 15:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EneTTOLEdeiyFEwMJVIPNECCRgEct82mU8+e7v3Zlys=;
        b=LFq6cFJtg2P710jiZO6bIVou2ZNEO4AESaORpocvfA/UUJuKdgj6gUyNVdUKvsfhWc
         6u+9Q+mw69rIGUy7wcWhROO+I8MsdRv4jW2MfrY27GpqiKs+/UJZ2LcxBWp6SiCCzaT9
         3yiQLe3G66UbZ4QuIGFFt8MDRD1uqNLB3mvjDCoQiwXscdQusreG9K1NTHozdj10errI
         ebbSuNawM/05piAOzulh3DwPSbWw4w+StNuhRs/vttfy3gOKmpbH5SrN9lnStIw6bxZr
         Wc69w41xMY90eVTxEmGMpsu8uQOyWIU64JxeKi7tVYZUJZIg9osT4Az1RPMFMlMGmvhs
         hHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EneTTOLEdeiyFEwMJVIPNECCRgEct82mU8+e7v3Zlys=;
        b=BSkagjWqVLwtSncqd8IeunFSQuJ5luwTOZDroipBCt736Np1VPnf0HI09Zh6SjHCkK
         jdROA0mGMAV/9q0P3JrNrbb0Tku6kP8x8SNYylY7fYXezcsWntoQiWhuBOOKg8ax7Z4X
         UQ81nXr4GPSX+mAYZZPnMgeii1BARbkBFr+m/hETg5UAk7CqPs1IMs0ud4qGGMtNj28h
         gzl02R8zIG/+DZ07hnQAyopbd/vUEvVYzn04DHlKPqAgoDiM6oevPq1TiZWhv9ZtiAGf
         vpxWidP7zqh8bqkq7FZydHAuWpsRa4GK7zIqF/vZoG8nBYQBAN2Hd/bAx8HUWSSMtHpJ
         fGTQ==
X-Gm-Message-State: ANoB5pkk5zxVY7wIXlZuo0II8C+Txp81OyU2FMvPuwoL4Iryrjhz0K3m
        9UAhCgqtKHweD5cMoH8iliE=
X-Google-Smtp-Source: AA0mqf6ozSfPXQEIVthvBeZL0zRv94HYK17dLhH/hEfRhdmmWqupwglu2Z5lcv1UWLYQqDh7B2kvqg==
X-Received: by 2002:a17:90a:d14d:b0:213:36b6:f9ff with SMTP id t13-20020a17090ad14d00b0021336b6f9ffmr15894806pjw.144.1668466976229;
        Mon, 14 Nov 2022 15:02:56 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:55 -0800 (PST)
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
Subject: [PATCH 17/19] perf stat: Factor out print_metric_{begin,end}()
Date:   Mon, 14 Nov 2022 15:02:25 -0800
Message-Id: <20221114230227.1255976-18-namhyung@kernel.org>
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

For the metric-only case, add new functions to handle the start and the
end of each metric display.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 56 +++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index bb40ed29300d..7a0673be720b 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -836,12 +836,39 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 		fputc('\n', output);
 }
 
+static void print_metric_begin(struct perf_stat_config *config,
+			       struct evlist *evlist,
+			       char *prefix, int aggr_idx)
+{
+	struct perf_stat_aggr *aggr;
+	struct aggr_cpu_id id;
+	struct evsel *evsel;
+
+	if (!config->metric_only)
+		return;
+
+	if (prefix)
+		fprintf(config->output, "%s", prefix);
+
+	evsel = evlist__first(evlist);
+	id = config->aggr_map->map[aggr_idx];
+	aggr = &evsel->stats->aggr[aggr_idx];
+	aggr_printout(config, evsel, id, aggr->nr);
+}
+
+static void print_metric_end(struct perf_stat_config *config)
+{
+	if (!config->metric_only)
+		return;
+
+	fputc('\n', config->output);
+}
+
 static void print_aggr(struct perf_stat_config *config,
 		       struct evlist *evlist,
 		       char *prefix)
 {
 	bool metric_only = config->metric_only;
-	FILE *output = config->output;
 	struct evsel *counter;
 	int s;
 
@@ -853,17 +880,7 @@ static void print_aggr(struct perf_stat_config *config,
 	 * Without each counter has its own line.
 	 */
 	for (s = 0; s < config->aggr_map->nr; s++) {
-		if (metric_only) {
-			struct perf_stat_aggr *aggr;
-			struct aggr_cpu_id id = config->aggr_map->map[s];
-
-			if (prefix)
-				fprintf(output, "%s", prefix);
-
-			counter = evlist__first(evlist);
-			aggr = &counter->stats->aggr[s];
-			aggr_printout(config, counter, id, aggr->nr);
-		}
+		print_metric_begin(config, evlist, prefix, s);
 
 		evlist__for_each_entry(evlist, counter) {
 			if (counter->merged_stat)
@@ -872,8 +889,7 @@ static void print_aggr(struct perf_stat_config *config,
 			print_counter_aggrdata(config, counter, s, prefix,
 					       metric_only);
 		}
-		if (metric_only)
-			fputc('\n', output);
+		print_metric_end(config);
 	}
 }
 
@@ -919,9 +935,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 
 			id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
 			if (first) {
-				if (prefix)
-					fputs(prefix, config->output);
-				aggr_printout(config, counter, id, 0);
+				print_metric_begin(config, evlist, prefix, counter_idx);
 				first = false;
 			}
 			val = ps->aggr[counter_idx].counts.val;
@@ -933,7 +947,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 				 run, ena, 1.0, &rt_stat, counter_idx);
 		}
 		if (!first)
-			fputc('\n', config->output);
+			print_metric_end(config);
 	}
 }
 
@@ -1322,13 +1336,11 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 			iostat_print_counters(evlist, config, ts, prefix = buf,
 					      print_counter);
 		else {
-			if (prefix && metric_only)
-				fprintf(config->output, "%s", prefix);
+			print_metric_begin(config, evlist, prefix, /*aggr_idx=*/0);
 			evlist__for_each_entry(evlist, counter) {
 				print_counter(config, counter, prefix);
 			}
-			if (metric_only)
-				fputc('\n', config->output);
+			print_metric_end(config);
 		}
 		break;
 	case AGGR_NONE:
-- 
2.38.1.493.g58b659f92b-goog


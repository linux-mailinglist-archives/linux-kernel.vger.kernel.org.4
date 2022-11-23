Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDF0636817
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbiKWSCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239358AbiKWSCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:20 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0708C7AC;
        Wed, 23 Nov 2022 10:02:20 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id z26so18043996pff.1;
        Wed, 23 Nov 2022 10:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPQ8P3nU21IfgJbVSUsmZkRPaAsgEAfzrcAmOBgJcJc=;
        b=XodpcMZ2oWHY0XKzWbfgqlzj29kXT6pHHoRLdtKPChW+Bzhl9tjvrT0tTwqi0oNGPx
         9MAF3k8QiymFCay7KPLBLyWvoWWPB3bYGghigHjQhEqKuuu9uwbqhMP+b3TBvx/xM8Ct
         jxe05iIi9y/4gevIheL02YEAfO/rf6JGx5Kmv59J7ZHy/UKRpGHc5I1F0DrYe18iMvHZ
         4ldG+Y0s1boJ98+mydOrshVX/mc8vKcNrF4hezJvgYsTd69GAvoCUeXqFKW1PwsXgIGT
         RO+EydA415QIBSO7jXa5PQBVejL7TWtHQtH6nzi5DNdPQCm79ClI5tKWuy0aYqbv99cm
         apqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wPQ8P3nU21IfgJbVSUsmZkRPaAsgEAfzrcAmOBgJcJc=;
        b=BVGRgXm6maPlf1qcyPxHIHQdh/4pfoVDtfkqcgoWH6U/GysbjtcV3h+t2MYwaxJTMW
         BEfptCrsE3sZYYLyYgHChsLOzZDX45ED/4wiStLimB6+Hu5OslNQ+94eWL53eXPIYTCc
         15qphgDzsXvkKhUaNcCCJyZsvO5S41weyRm/HCwZ+lWsHYgPZmL+tKouRdzbk7piEiVq
         nF1mqlmWQ6zTI2QEh8YcCKjgyKF+vef986KYoVChPCJoQxubMZQy9A6yT5z9TEc94eaV
         ud3EFHv3ve+MeAk7L9iPnp5xfcH6xbxoi86rTFCU/nFNIfr69oF3Xr7kmIZ+7VqRAv85
         qL4Q==
X-Gm-Message-State: ANoB5pk4eVVjMcHjJKpXf2dAKWuofFXvPRvl+7SbKuYa8PwkldmJD3MC
        +2uQEBla9qoUOpxU+bdRgCY=
X-Google-Smtp-Source: AA0mqf5dclZWwTMqoseQ8ry80PeIOlzMrLlj3NgnhFpjx0vU9FXQjaHcNX0fVxyI2wbw+BTun1W88Q==
X-Received: by 2002:a65:5541:0:b0:476:759b:7952 with SMTP id t1-20020a655541000000b00476759b7952mr8798859pgr.316.1669226539497;
        Wed, 23 Nov 2022 10:02:19 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:c968:76:254b:3790])
        by smtp.gmail.com with ESMTPSA id i15-20020a655b8f000000b00470275c8d6dsm10792364pgr.10.2022.11.23.10.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:02:19 -0800 (PST)
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
Subject: [PATCH 06/15] perf stat: Remove metric_only argument in print_counter_aggrdata()
Date:   Wed, 23 Nov 2022 10:01:59 -0800
Message-Id: <20221123180208.2068936-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221123180208.2068936-1-namhyung@kernel.org>
References: <20221123180208.2068936-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It already passes the stat_config argument, then it can find the value in the
config.  No need to pass it separately.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index deed6ccf072f..b8432c0a0ec3 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -804,7 +804,7 @@ static void uniquify_counter(struct perf_stat_config *config, struct evsel *coun
 
 static void print_counter_aggrdata(struct perf_stat_config *config,
 				   struct evsel *counter, int s,
-				   char *prefix, bool metric_only)
+				   char *prefix)
 {
 	FILE *output = config->output;
 	u64 ena, run, val;
@@ -813,6 +813,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	struct perf_stat_aggr *aggr = &ps->aggr[s];
 	struct aggr_cpu_id id = config->aggr_map->map[s];
 	double avg = aggr->counts.val;
+	bool metric_only = config->metric_only;
 
 	if (counter->supported && aggr->nr == 0)
 		return;
@@ -875,7 +876,6 @@ static void print_aggr(struct perf_stat_config *config,
 		       struct evlist *evlist,
 		       char *prefix)
 {
-	bool metric_only = config->metric_only;
 	struct evsel *counter;
 	int s;
 
@@ -893,8 +893,7 @@ static void print_aggr(struct perf_stat_config *config,
 			if (counter->merged_stat)
 				continue;
 
-			print_counter_aggrdata(config, counter, s, prefix,
-					       metric_only);
+			print_counter_aggrdata(config, counter, s, prefix);
 		}
 		print_metric_end(config);
 	}
@@ -904,7 +903,6 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
 			      struct evlist *evlist,
 			      char *prefix)
 {
-	bool metric_only = config->metric_only;
 	struct evsel *counter, *evsel;
 	struct cgroup *cgrp = NULL;
 	int s;
@@ -928,8 +926,7 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
 				if (counter->cgrp != cgrp)
 					continue;
 
-				print_counter_aggrdata(config, counter, s, prefix,
-						       metric_only);
+				print_counter_aggrdata(config, counter, s, prefix);
 			}
 			print_metric_end(config);
 		}
@@ -939,7 +936,6 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
 static void print_counter(struct perf_stat_config *config,
 			  struct evsel *counter, char *prefix)
 {
-	bool metric_only = config->metric_only;
 	int s;
 
 	/* AGGR_THREAD doesn't have config->aggr_get_id */
@@ -950,8 +946,7 @@ static void print_counter(struct perf_stat_config *config,
 		return;
 
 	for (s = 0; s < config->aggr_map->nr; s++) {
-		print_counter_aggrdata(config, counter, s, prefix,
-				       metric_only);
+		print_counter_aggrdata(config, counter, s, prefix);
 	}
 }
 
@@ -1339,7 +1334,7 @@ static void print_percore(struct perf_stat_config *config,
 		if (found)
 			continue;
 
-		print_counter_aggrdata(config, counter, s, prefix, metric_only);
+		print_counter_aggrdata(config, counter, s, prefix);
 
 		core_map->map[c++] = core_id;
 	}
-- 
2.38.1.584.g0f3c55d4c2-goog


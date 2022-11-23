Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4F863684B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239642AbiKWSF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbiKWSDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:03:10 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7371B86B;
        Wed, 23 Nov 2022 10:02:32 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id io19so17330837plb.8;
        Wed, 23 Nov 2022 10:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gWMIg8ivBELEJG/R0PKwrUC/7uMdDKInwMAEQaG27g=;
        b=qke1to8QicpmSPkYhan1X5ZD1RXagJ2z9CmBhlLxQnhfXiTNJv8xxwutR/52394kes
         /01n7X41yjZGds2kUIu5G9xg2YM8+VDjSESa6fAiTsGHXfgO3j6QTC5HJDSwJN4E7eKH
         1maVXeqsL+OzSug7BaPNpHQw+lJLgtlPWzSpJQrhtBCxCto4yLKv3yA+j0tGTV2Xf0zH
         XuELKUdwLzl+JQqJ5qv1xzNITBfylJFCh3RO/44/tN61UNXshv+B4U2FF4CwgHGR2MuW
         OvkT+rhMS0TMFgvbe2U5+6lolArOc4uY0IKRs67Sutu0wItPk0E03j9nrsqC5gsTvG6O
         Hqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5gWMIg8ivBELEJG/R0PKwrUC/7uMdDKInwMAEQaG27g=;
        b=CSgyiyVa/M7uRk7X2k+g6+qsCIc11Q8TFlMn46yfxaa+tABOZhOPSZhBbarrbq6xj7
         vHrw+xmuv8XZz4r6tntEDE/v3kGo0An2SD8Vui1+4gfsGO8VDVARN90xzbpv+jW5Auv5
         ULERn1XPRSatCXCFGRw7YB0RSuUowJk4o++IKx+IqnjVil3ZXth8E8CrRGMc8hQ8qlT0
         KuLVS+Yps21Y2Kcx9+OVesgbJFmU0vdSUi80mHmXEjg26ms3lljbrBmslDMWuF7emB3u
         H+NVpDjYwqAm2LhRyEiFG9mK8DCvg6IRRe6FCr8BzifLh5NOVyRroPpdQLw6GS7Bnv29
         6aFQ==
X-Gm-Message-State: ANoB5plyjAtva/h0YfG9QYiKimb/znui+sBSaeo0ua0luyiFY7XWWj47
        rfG4B//Apn4DuaW7SKWQw6w=
X-Google-Smtp-Source: AA0mqf4xZ5Y7E2KNh89B4QFT2XJ7+bbx0UghsjM6tXas+Zl8Eyd1Eui7nsyNb9KnfRXIcrOl4GcCWA==
X-Received: by 2002:a17:903:3311:b0:186:d5b9:fbcd with SMTP id jk17-20020a170903331100b00186d5b9fbcdmr12767970plb.64.1669226552177;
        Wed, 23 Nov 2022 10:02:32 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:c968:76:254b:3790])
        by smtp.gmail.com with ESMTPSA id i15-20020a655b8f000000b00470275c8d6dsm10792364pgr.10.2022.11.23.10.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:02:31 -0800 (PST)
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
Subject: [PATCH 15/15] perf stat: Tidy up JSON metric-only output when no metrics
Date:   Wed, 23 Nov 2022 10:02:08 -0800
Message-Id: <20221123180208.2068936-16-namhyung@kernel.org>
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

It printed empty strings for each metric.  I guess it's needed for CSV
output to match the column number.  We could just ignore the empty
metrics in JSON but it ended up with a broken JSON object with a
trailing comma.

So I added a dummy '"metric-value" : "none"' part.  To do that, it
needs to pass struct outstate to print_metric_end() to check if any
metric value is printed or not.

Before:
  # perf stat -aj --metric-only --per-socket --for-each-cgroup system.slice true
  {"socket" : "S0", "cpu-count" : 8, "cgroup" : "system.slice", "" : "", "" : "", "" : "", "" : "", "" : "", "" : "", "" : "", "" : ""}

After:
  # perf stat -aj --metric-only --per-socket --for-each-cgroup system.slice true
  {"socket" : "S0", "cpu-count" : 8, "cgroup" : "system.slice", "metric-value" : "none"}

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 7a39a1a7261d..847acdb5dc40 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -532,6 +532,8 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
 	while (isdigit(*ends) || *ends == '.')
 		ends++;
 	*ends = 0;
+	if (!unit[0] || !vals[0])
+		return;
 	fprintf(out, "%s\"%s\" : \"%s\"", os->first ? "" : ", ", unit, vals);
 	os->first = false;
 }
@@ -864,14 +866,19 @@ static void print_metric_begin(struct perf_stat_config *config,
 	print_cgroup(config, os->cgrp ? : evsel->cgrp);
 }
 
-static void print_metric_end(struct perf_stat_config *config)
+static void print_metric_end(struct perf_stat_config *config, struct outstate *os)
 {
+	FILE *output = config->output;
+
 	if (!config->metric_only)
 		return;
 
-	if (config->json_output)
-		fputc('}', config->output);
-	fputc('\n', config->output);
+	if (config->json_output) {
+		if (os->first)
+			fputs("\"metric-value\" : \"none\"", output);
+		fputc('}', output);
+	}
+	fputc('\n', output);
 }
 
 static void print_aggr(struct perf_stat_config *config,
@@ -897,7 +904,7 @@ static void print_aggr(struct perf_stat_config *config,
 
 			print_counter_aggrdata(config, counter, s, os);
 		}
-		print_metric_end(config);
+		print_metric_end(config, os);
 	}
 }
 
@@ -929,7 +936,7 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
 
 				print_counter_aggrdata(config, counter, s, os);
 			}
-			print_metric_end(config);
+			print_metric_end(config, os);
 		}
 	}
 }
@@ -985,7 +992,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 			printout(config, os, uval, run, ena, 1.0, counter_idx);
 		}
 		if (!first)
-			print_metric_end(config);
+			print_metric_end(config, os);
 	}
 }
 
@@ -1348,7 +1355,7 @@ static void print_cgroup_counter(struct perf_stat_config *config, struct evlist
 	evlist__for_each_entry(evlist, counter) {
 		if (os->cgrp != counter->cgrp) {
 			if (os->cgrp != NULL)
-				print_metric_end(config);
+				print_metric_end(config, os);
 
 			os->cgrp = counter->cgrp;
 			print_metric_begin(config, evlist, os, /*aggr_idx=*/0);
@@ -1357,7 +1364,7 @@ static void print_cgroup_counter(struct perf_stat_config *config, struct evlist
 		print_counter(config, counter, os);
 	}
 	if (os->cgrp)
-		print_metric_end(config);
+		print_metric_end(config, os);
 }
 
 void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *config,
@@ -1405,7 +1412,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 			evlist__for_each_entry(evlist, counter) {
 				print_counter(config, counter, &os);
 			}
-			print_metric_end(config);
+			print_metric_end(config, &os);
 		}
 		break;
 	case AGGR_NONE:
-- 
2.38.1.584.g0f3c55d4c2-goog


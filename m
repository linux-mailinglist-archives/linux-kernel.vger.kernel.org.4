Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10F4628D09
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238102AbiKNXDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238013AbiKNXDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:03:17 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6F81C404;
        Mon, 14 Nov 2022 15:02:42 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso15264562pjc.0;
        Mon, 14 Nov 2022 15:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uteOdCyPFJuZ4/e8j5gcW2AzjfSkGz9Zxx29RYucpO4=;
        b=HVi8Rv+UWBkOa6K+PUWXuEzMDbI6BtLoh3Oq2fntXUP6ypJC4PvNlE0K/kdltKDsxS
         fMN7KFT2bvNpKYPcY6ZtsAmU2veGc6xhhVFXmS2sH5mcbMj963Rofu1blZMcseuYSMzN
         fHSkX+WmS6m/D6OeQBA2LK1Q2rtHWqO80iC0xGdd60cjuyYWDyZqpwd7nDF3qOVS8JET
         7ZVSp3hHH1M0SeTe57ZLidj51N8oE3VW0xm3MtsX2N9CpSUEcYyIvWmTbb8neQmLA5NQ
         i5NO9wwmxvEjFKDi3c3AIPXHclLtW4mZnGppyGJqA5/RdrJwnp5rZmunDsH6pT5QFdiY
         hw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uteOdCyPFJuZ4/e8j5gcW2AzjfSkGz9Zxx29RYucpO4=;
        b=kkOd6jYkNpS4KCNKlqTzm6TVT43AkziUkCMz4Y3Vu+0bn7ZEUUZ3gaxb5ec4C5q4hn
         aDeWiuCdV/lgDLCHw7dMjF0i6gv1OpPZ+5eqBrEnTivmuClSUjDt+k36+MGCCfVwqCBF
         6za6CsPEHj0zaT3ZUs0OdFXjKF34XQxTEhF3fcAQuUzhAW4wg55cV/hw/GPGqixhc8Vg
         mqQp/U85lcDRRA/rrTA5erb5WmWLmTA/K2bsQlS6KcW0isgnu9NCXC5Xf6I2uhBOJfLl
         s3e7StCuOk85yjj0QuIcVhu+eGPSOpAR3GDHH/89GV28TVX46RnXkCI6SS2d/pA9I09G
         lB6Q==
X-Gm-Message-State: ANoB5pmFYydA6i5BBqyEchkT/5OZIjzyLzf2T+YHcvKtnuT8Lw5vFA5H
        V2QXmNTkDi74pH+PI6Q91ds=
X-Google-Smtp-Source: AA0mqf57TdOotLS5/t1jTGV9T0g4kmp/gKY3hikcoESVvD2GMZRvy5XF92B8CBrLxmYOVW0fQJGA1A==
X-Received: by 2002:a17:902:8647:b0:17f:63a3:cb48 with SMTP id y7-20020a170902864700b0017f63a3cb48mr1315614plt.123.1668466962130;
        Mon, 14 Nov 2022 15:02:42 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:41 -0800 (PST)
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
Subject: [PATCH 08/19] perf stat: Add before_metric argument
Date:   Mon, 14 Nov 2022 15:02:16 -0800
Message-Id: <20221114230227.1255976-9-namhyung@kernel.org>
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

Unfortunately, event running time, percentage and noise data are printed
in different positions in normal output than CSV/JSON.  I think it's
better to put such details in where it actually prints.

So add before_metric argument to print_noise() and print_running() and
call them twice before and after the metric.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 82 +++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index fe5483893289..bf3f2f9d5dee 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -52,14 +52,18 @@ static void print_running_json(struct perf_stat_config *config, u64 run, u64 ena
 }
 
 static void print_running(struct perf_stat_config *config,
-			  u64 run, u64 ena)
+			  u64 run, u64 ena, bool before_metric)
 {
-	if (config->json_output)
-		print_running_json(config, run, ena);
-	else if (config->csv_output)
-		print_running_csv(config, run, ena);
-	else
-		print_running_std(config, run, ena);
+	if (config->json_output) {
+		if (before_metric)
+			print_running_json(config, run, ena);
+	} else if (config->csv_output) {
+		if (before_metric)
+			print_running_csv(config, run, ena);
+	} else {
+		if (!before_metric)
+			print_running_std(config, run, ena);
+	}
 }
 
 static void print_noise_pct_std(struct perf_stat_config *config,
@@ -82,20 +86,24 @@ static void print_noise_pct_json(struct perf_stat_config *config,
 }
 
 static void print_noise_pct(struct perf_stat_config *config,
-			    double total, double avg)
+			    double total, double avg, bool before_metric)
 {
 	double pct = rel_stddev_stats(total, avg);
 
-	if (config->json_output)
-		print_noise_pct_json(config, pct);
-	else if (config->csv_output)
-		print_noise_pct_csv(config, pct);
-	else
-		print_noise_pct_std(config, pct);
+	if (config->json_output) {
+		if (before_metric)
+			print_noise_pct_json(config, pct);
+	} else if (config->csv_output) {
+		if (before_metric)
+			print_noise_pct_csv(config, pct);
+	} else {
+		if (!before_metric)
+			print_noise_pct_std(config, pct);
+	}
 }
 
 static void print_noise(struct perf_stat_config *config,
-			struct evsel *evsel, double avg)
+			struct evsel *evsel, double avg, bool before_metric)
 {
 	struct perf_stat_evsel *ps;
 
@@ -103,7 +111,7 @@ static void print_noise(struct perf_stat_config *config,
 		return;
 
 	ps = evsel->stats;
-	print_noise_pct(config, stddev_stats(&ps->res_stats), avg);
+	print_noise_pct(config, stddev_stats(&ps->res_stats), avg, before_metric);
 }
 
 static void print_cgroup_std(struct perf_stat_config *config, const char *cgrp_name)
@@ -637,6 +645,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 	};
 	print_metric_t pm;
 	new_line_t nl;
+	bool ok = true;
 
 	if (config->csv_output) {
 		static const int aggr_fields[AGGR_MAX] = {
@@ -672,7 +681,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 			return;
 		}
 
-		abs_printout(config, id, nr, counter, uval, /*ok=*/false);
+		ok = false;
 
 		if (counter->supported) {
 			if (!evlist__has_hybrid(counter->evlist)) {
@@ -681,37 +690,30 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 					config->print_mixed_hw_group_error = 1;
 			}
 		}
-
-		if (!config->csv_output && !config->json_output)
-			pm(config, &os, NULL, NULL, "", 0);
-		print_noise(config, counter, noise);
-		print_running(config, run, ena);
-		if (config->csv_output || config->json_output)
-			pm(config, &os, NULL, NULL, "", 0);
-		return;
 	}
 
-	if (!config->metric_only)
-		abs_printout(config, id, nr, counter, uval, /*ok=*/true);
-
 	out.print_metric = pm;
 	out.new_line = nl;
 	out.ctx = &os;
 	out.force_header = false;
 
-	if (config->csv_output && !config->metric_only) {
-		print_noise(config, counter, noise);
-		print_running(config, run, ena);
-	} else if (config->json_output && !config->metric_only) {
-		print_noise(config, counter, noise);
-		print_running(config, run, ena);
+	if (!config->metric_only) {
+		abs_printout(config, id, nr, counter, uval, ok);
+
+		print_noise(config, counter, noise, /*before_metric=*/true);
+		print_running(config, run, ena, /*before_metric=*/true);
+	}
+
+	if (ok) {
+		perf_stat__print_shadow_stats(config, counter, uval, map_idx,
+					      &out, &config->metric_events, st);
+	} else {
+		pm(config, &os, /*color=*/NULL, /*format=*/NULL, /*unit=*/"", /*val=*/0);
 	}
 
-	perf_stat__print_shadow_stats(config, counter, uval, map_idx,
-				&out, &config->metric_events, st);
-	if (!config->csv_output && !config->metric_only && !config->json_output) {
-		print_noise(config, counter, noise);
-		print_running(config, run, ena);
+	if (!config->metric_only) {
+		print_noise(config, counter, noise, /*before_metric=*/false);
+		print_running(config, run, ena, /*before_metric=*/false);
 	}
 }
 
@@ -1151,7 +1153,7 @@ static void print_footer(struct perf_stat_config *config)
 		fprintf(output, " %17.*f +- %.*f seconds time elapsed",
 			precision, avg, precision, sd);
 
-		print_noise_pct(config, sd, avg);
+		print_noise_pct(config, sd, avg, /*before_metric=*/false);
 	}
 	fprintf(output, "\n\n");
 
-- 
2.38.1.493.g58b659f92b-goog


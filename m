Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B228628CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbiKNXDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237878AbiKNXCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:02:36 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E861B9C0;
        Mon, 14 Nov 2022 15:02:33 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id w23so5069001ply.12;
        Mon, 14 Nov 2022 15:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9gVgzaugGBijq/uNgO/XLVSIa4Ghp/O4hPteTZwehU=;
        b=P8ggZH5FleD5Kv20TgngyEO98qnMIP+IsgWyIAedDwGn9PltGQOruty/I/EBflF9jY
         Y9aAWqJGxZ6sYB/SEl+gL4P753EPvL+bZd2ZG2uWnEHn9GSH8nezaQ/1rJJeMjR9T91S
         K91fp0aQN/6P8jV8qiuaqS6vqfU3ODpplDsCgKJu/3zYjBWxIqa+310hRfF+hDGIYv2E
         OEMVFoY95QIowZI04HJaFiQ7ixcLAgPKGj1crbjaUUN211lBL0y2ZlJT3ZdaLvqrEM1P
         HOLZYpkKRhZZLjYY7KuYHKzlcaigqUeDzJzq2xm/VRPvZc5Tsmc0i5nFx74APmrLeRoi
         KSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g9gVgzaugGBijq/uNgO/XLVSIa4Ghp/O4hPteTZwehU=;
        b=CdmM80VIuA/zy0NsrWqAnyKenwrBS+ryRwn4E1gshzCkTQRndZeo60R8cn7OkmUW/m
         CZDHLcMXG9djTtFbmGB2Ex6XAJc4wUMXGSgOkM+RMhgCF8/ynUrcAi4p4pqPcikWFUk7
         RQEY6ym1g3hKGpiKeXpa1zLL1WMqxi7kohGnVecNVvMlUsDS9WVLl9HF6O759P1TyywR
         D/CAheNCkWIP2x5SL683Hi9PLhDcHim3rbT3FoeHaLvIKvQbZAg4Rt2EcvKOPkWe7yu3
         utDTLC6VoAHZPLhla14uSkR0ZVBqOG0221rmylxWQ4btwe4tf3PD59k5QmCqaTdgdmME
         nwHQ==
X-Gm-Message-State: ANoB5pksApLHw4rzxGgJ5a5pdU9vD4JAh583bwbHIiDwk+CVhZN7ACXW
        EplVbBR6P1uXqjiR5CZiivA=
X-Google-Smtp-Source: AA0mqf64F2Fj3Bopi8BvuDD2bkX3oy8KcRyoLZlIeOj49Xu6dyfm61qDLkDodFQ9wyIE5xiIRR9jHA==
X-Received: by 2002:a17:90a:fa11:b0:212:6a0b:7d55 with SMTP id cm17-20020a17090afa1100b002126a0b7d55mr15484594pjb.16.1668466953078;
        Mon, 14 Nov 2022 15:02:33 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:32 -0800 (PST)
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
Subject: [PATCH 02/19] perf stat: Split print_running() function
Date:   Mon, 14 Nov 2022 15:02:10 -0800
Message-Id: <20221114230227.1255976-3-namhyung@kernel.org>
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

To make the code more obvious and hopefully simpler, factor out the
code for each output mode - stdio, CSV, JSON.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 37 +++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 2a3c1e0098b9..281b811f8574 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -25,24 +25,41 @@
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
 
-static void print_running(struct perf_stat_config *config,
-			  u64 run, u64 ena)
+static void print_running_std(struct perf_stat_config *config, u64 run, u64 ena)
+{
+	if (run != ena)
+		fprintf(config->output, "  (%.2f%%)", 100.0 * run / ena);
+}
+
+static void print_running_csv(struct perf_stat_config *config, u64 run, u64 ena)
 {
+	double enabled_percent = 100;
+
+	if (run != ena)
+		enabled_percent = 100 * run / ena;
+	fprintf(config->output, "%s%" PRIu64 "%s%.2f",
+		config->csv_sep, run, config->csv_sep, enabled_percent);
+}
 
+static void print_running_json(struct perf_stat_config *config, u64 run, u64 ena)
+{
 	double enabled_percent = 100;
 
 	if (run != ena)
 		enabled_percent = 100 * run / ena;
+	fprintf(config->output, "\"event-runtime\" : %" PRIu64 ", \"pcnt-running\" : %.2f, ",
+		run, enabled_percent);
+}
+
+static void print_running(struct perf_stat_config *config,
+			  u64 run, u64 ena)
+{
 	if (config->json_output)
-		fprintf(config->output,
-			"\"event-runtime\" : %" PRIu64 ", \"pcnt-running\" : %.2f, ",
-			run, enabled_percent);
+		print_running_json(config, run, ena);
 	else if (config->csv_output)
-		fprintf(config->output,
-			"%s%" PRIu64 "%s%.2f", config->csv_sep,
-			run, config->csv_sep, enabled_percent);
-	else if (run != ena)
-		fprintf(config->output, "  (%.2f%%)", 100.0 * run / ena);
+		print_running_csv(config, run, ena);
+	else
+		print_running_std(config, run, ena);
 }
 
 static void print_noise_pct(struct perf_stat_config *config,
-- 
2.38.1.493.g58b659f92b-goog


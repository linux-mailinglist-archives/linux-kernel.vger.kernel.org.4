Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A21E628D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbiKNXDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbiKNXDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:03:22 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7CA1C904;
        Mon, 14 Nov 2022 15:02:47 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p12so11509682plq.4;
        Mon, 14 Nov 2022 15:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5Jzh6xalJKHBu39qwvImNFihPE1DfayGCHE+NYMErs=;
        b=BQkSJKUwTi3w4+6vF2KUK9j1JRRPBKnfMOpf4q31cAzr29yOk6gZguFvhDSadkNUhP
         cDGuNd9lFQpCM9jKDxrUo4txRdOQ0xCylzVfYxevtOROAFYx7/cO/fQKq8mYXRqXM/DG
         TeImU0q6xxpYr4ti2BgY95DZX81ZztgvZS3Ws+vntjmPMsasyxCcOZe6OcM0T5WgENYs
         bZ0I4yA9ipVzadswHXhPNy0utjeJ3wa8iu4DvFOyNK1A2Mqz9NCmfLdoGDc4gdZDgAUH
         TP3D8g+gKcWNkgYvli/4FaO3h26pUdayh0+Q9jQjdpCNv7IFabFxCdM7sqO32fnodgjU
         egCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p5Jzh6xalJKHBu39qwvImNFihPE1DfayGCHE+NYMErs=;
        b=uFKPL1LIbkKd+SSclxe8Md4XRknXoPlXfPFTvkHxBPJcpjJDvqBGQ5jNVta37pfzvC
         f/RxBFAbHjgqxQwB5EPWHesCP8l2Halg+lB3nJOLYOBMLQyoaR73ij1MVnsA9DRv0Kuv
         nLg7ZF0qR/5V3pSaYAHNexP9b/nnF/pDVn3UtLn0LKnWpXJ7qjwfR/51ksB479Hp/gPI
         IiMnC7+dHvnItvNSYNlsy3JIMAIdU2ZI/hBvkMwhS18iP5j1/XMpclWxX3GAmQ0uGRyA
         /WujRNNUyLDYJvjR2c2LeeDlvbrz/M+DMI6Anu65aC7HyshzaotOfety9mBLLhs1/CAj
         B3Bw==
X-Gm-Message-State: ANoB5pkDN22T8/4/t0OCJpnnAWALqJR3LrBSFDZK0aRG1kn4ot7akU++
        CRJ3ZHQeJMonEpXvC7sXAsc=
X-Google-Smtp-Source: AA0mqf5gvzG2kf+vWmHVL0H+lmqdGnWDCl8xsQw+SJzii3bk5vanT1jA+zLyR3n22Q3rTP2FkyyXKw==
X-Received: by 2002:a17:903:428d:b0:186:a98c:4ab8 with SMTP id ju13-20020a170903428d00b00186a98c4ab8mr1292923plb.118.1668466966879;
        Mon, 14 Nov 2022 15:02:46 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:46 -0800 (PST)
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
Subject: [PATCH 11/19] perf stat: Factor out prepare_interval()
Date:   Mon, 14 Nov 2022 15:02:19 -0800
Message-Id: <20221114230227.1255976-12-namhyung@kernel.org>
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

This logic does not print the time directly, but it just puts the
timestamp in the buffer as a prefix.  To reduce the confusion, factor
out the code into a separate function.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 39 +++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index bb2791459f5f..c234be656db9 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -993,9 +993,25 @@ static void print_metric_headers(struct perf_stat_config *config,
 	fputc('\n', config->output);
 }
 
+static void prepare_interval(struct perf_stat_config *config,
+			     char *prefix, struct timespec *ts)
+{
+	if (config->iostat_run)
+		return;
+
+	if (!config->json_output)
+		sprintf(prefix, "%6lu.%09lu%s", (unsigned long) ts->tv_sec,
+				 ts->tv_nsec, config->csv_sep);
+	else if (!config->metric_only)
+		sprintf(prefix, "{\"interval\" : %lu.%09lu, ", (unsigned long)
+				 ts->tv_sec, ts->tv_nsec);
+	else
+		sprintf(prefix, "{\"interval\" : %lu.%09lu}", (unsigned long)
+				 ts->tv_sec, ts->tv_nsec);
+}
+
 static void print_interval(struct perf_stat_config *config,
-			   struct evlist *evlist,
-			   char *prefix, struct timespec *ts)
+			   struct evlist *evlist)
 {
 	bool metric_only = config->metric_only;
 	unsigned int unit_width = config->unit_width;
@@ -1005,16 +1021,6 @@ static void print_interval(struct perf_stat_config *config,
 	if (config->interval_clear && isatty(fileno(output)))
 		puts(CONSOLE_CLEAR);
 
-	if (!config->iostat_run && !config->json_output)
-		sprintf(prefix, "%6lu.%09lu%s", (unsigned long) ts->tv_sec,
-				 ts->tv_nsec, config->csv_sep);
-	if (!config->iostat_run && config->json_output && !config->metric_only)
-		sprintf(prefix, "{\"interval\" : %lu.%09lu, ", (unsigned long)
-				 ts->tv_sec, ts->tv_nsec);
-	if (!config->iostat_run && config->json_output && config->metric_only)
-		sprintf(prefix, "{\"interval\" : %lu.%09lu}", (unsigned long)
-				 ts->tv_sec, ts->tv_nsec);
-
 	if ((num_print_interval == 0 || config->interval_clear) &&
 			!config->csv_output && !config->json_output) {
 		switch (config->aggr_mode) {
@@ -1252,10 +1258,13 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 	if (config->iostat_run)
 		evlist->selected = evlist__first(evlist);
 
-	if (interval)
-		print_interval(config, evlist, prefix = buf, ts);
-	else
+	if (interval) {
+		prefix = buf;
+		prepare_interval(config, prefix, ts);
+		print_interval(config, evlist);
+	} else {
 		print_header(config, _target, argc, argv);
+	}
 
 	if (metric_only) {
 		static int num_print_iv;
-- 
2.38.1.493.g58b659f92b-goog


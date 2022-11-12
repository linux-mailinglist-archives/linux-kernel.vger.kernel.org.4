Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2CC626699
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbiKLDXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiKLDXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:23:03 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAA273418;
        Fri, 11 Nov 2022 19:23:02 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 130so5804418pgc.5;
        Fri, 11 Nov 2022 19:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwipktzA369UTkHqB7XVTQckcETl9zD+7fptBSB2IMc=;
        b=Cs3rBx7uZU3XflfJGaDVjl1h0Fq4A3Vrrpp++T5K5t7Y1Ye75JN54ZBFPyDJH0ddxP
         RL7eM52OiLookCa/VVTSdytmb32vlJ8f3Bzwh6yv0qYFsZSkQUCd7E6XhIkrd5i6zNdL
         t/PD+DZBVYMECmKOkwO/72Jr8dP5Av6uUvGcz0Zkqb40hGebKcyEtFn3lSM/CHHuaFRX
         Ucc1eWlaA/C2zVg7O/BAnVHSqw1u1ZDV6zsWnHhiScg/4KObBNmbRk9kM3ziMRTmZw7g
         oDgxAxmPY7q9hlZ19xb7cBryLv0lDKHv8n2OaN2eMvS/lIjRihr3kmyhQUBrPFLv3UPT
         pCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cwipktzA369UTkHqB7XVTQckcETl9zD+7fptBSB2IMc=;
        b=0r7+64sV4GbOi+jnXw9vey9tfOltM8yL6jn6+GGZ2uZwQLizaBW/WXi+DcXO0hDu2x
         EhprgdcWGgQwnTH7nwGlYaT58Cwcgwof6ltCsgJerKEYasNu3MigGPjiWep5TOGWgX8r
         1XnAA/CYE2aXqHZL73ikXLchmwX6OCX8EKQKrOD4osxBzLyKpFuKwlxp2wIl0HGgeeU7
         AloJ2WMwHX2sQbocw/TcGTAtDSgSwbEwb/yzgM9yyrFaFkjgFob/LmXnSi146xI8avP2
         C7AvkaRG/3wbrzQ8xWI10xKeMKVJgAD4Ef0TxixwLXjlkpzckbUgmlmQhXuqr0HEbgIO
         h16w==
X-Gm-Message-State: ANoB5pkSEBS+z+9IFp8YOiXE6tNnK+4Iau1sSfbHeZzwjDMTnHJgDfBA
        QuN7jEYg+BxNf/pWqFPTt4Y=
X-Google-Smtp-Source: AA0mqf7FPkep82zxD1KgpghBxuk8F1jni6b0M2ihZyLCVMwD1SYpi6V6QdAhEWQS0qQAxamHYny2uw==
X-Received: by 2002:aa7:8e59:0:b0:56c:12c0:a89b with SMTP id d25-20020aa78e59000000b0056c12c0a89bmr5296830pfr.40.1668223382290;
        Fri, 11 Nov 2022 19:23:02 -0800 (PST)
Received: from balhae.roam.corp.google.com ([2607:fb90:27dc:8408:33d7:3b01:eee1:84b])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b00186f0f59d1esm2434552plb.192.2022.11.11.19.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 19:23:01 -0800 (PST)
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
        James Clark <james.clark@arm.com>
Subject: [PATCH 08/11] perf stat: Fix condition in print_interval()
Date:   Fri, 11 Nov 2022 19:22:41 -0800
Message-Id: <20221112032244.1077370-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
In-Reply-To: <20221112032244.1077370-1-namhyung@kernel.org>
References: <20221112032244.1077370-1-namhyung@kernel.org>
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

The num_print_interval and config->interval_clear should be checked
together like other places like later in the function.  Otherwise,
the --interval-clear option could print the headers for the CSV or
JSON output unnecessarily.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 03d58277e8d6..5f4fb0bd4037 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -902,8 +902,8 @@ static void print_interval(struct perf_stat_config *config,
 		sprintf(prefix, "{\"interval\" : %lu.%09lu}", (unsigned long)
 				 ts->tv_sec, ts->tv_nsec);
 
-	if ((num_print_interval == 0 && !config->csv_output && !config->json_output)
-			 || config->interval_clear) {
+	if ((num_print_interval == 0 || config->interval_clear) &&
+			!config->csv_output && !config->json_output) {
 		switch (config->aggr_mode) {
 		case AGGR_NODE:
 			fprintf(output, "#           time node   cpus");
-- 
2.38.1.493.g58b659f92b-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37556367FE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbiKWSC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239322AbiKWSCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:15 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9691D60F9;
        Wed, 23 Nov 2022 10:02:14 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id q96-20020a17090a1b6900b00218b8f9035cso2515525pjq.5;
        Wed, 23 Nov 2022 10:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45F31ZAKNk8FjxfLJ7aVBA4PDnBSPJi7ky7zRGdUzFI=;
        b=A5Kp6O7NIwwxm+NlPeHqQK8k67Rp3gtP6R4NLbBAN6zHWomk59ocTMCp8ZCGZR84Py
         5Xex6u2PjfMaCO4Gm3suerJ3ahPPh5kbLV1ZF0HO4F1w5t7ChgnduQReHwebROXb2Ury
         k8Czk2pBAMyjT79W9dcTPKW1fAZtJ5QSnAYCro53YfEDZVB53C8rjsdabKCfQvhRD0mg
         9QA+CvPdO9EOVMM6T/5/0IBblqneH5kPG3urNQR1Mx/zuYgunjjNRpjatnqnqs2WYm87
         qjl9JY0GNwSQGwUgdDUEG2twvB6kkW8xLKEZ18nHrXw8DdSNUTBIMiL+56A6H3idxnv2
         701Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=45F31ZAKNk8FjxfLJ7aVBA4PDnBSPJi7ky7zRGdUzFI=;
        b=k/0p3njLyku/hfSwUslqrFE9hte5tyVP4hUzdLkUJyqA8C3FT6tetbuARAjZjOUa+l
         jgse/Wa5ssklMuGna8s2STXoHhyGSfLSl9TXN/DNfIHvJP8i/d9JpGovQYKkQejBLWTo
         H6Avt9EURDzI02eLp8QHWCnaTBpH1MQlTgm1LJq26SDReY/2KbxB2QSRniVwbJMA2bcO
         hqQ3fHr8IeKCh7coBaXzB8vGI6BLX9DyxYfiZtwx0iyX4ugGmURWnsJAGhHAtEousoWV
         OcW8MP7d+FNdQl0/OGOc5HbGKOJkLNnQvOJJkfo9bH5vsT7MVYjI1ursPa5tvPhaTbBu
         LQgQ==
X-Gm-Message-State: ANoB5pnH2lTrhAUAA/WsteqH+ylm98RDdTUPYpDglBEtGMsm/FahY348
        R80F2Ld5PN43GG86WuCA38isgtTAiu0=
X-Google-Smtp-Source: AA0mqf7A0Wurp+z5/B6FPm63hwNHINx+U2XZWJ1NuzbbRGRxPI18ywWjNjSy4vZpAoZL7nC0iK8Hrw==
X-Received: by 2002:a17:903:1106:b0:189:528b:7a14 with SMTP id n6-20020a170903110600b00189528b7a14mr1809147plh.62.1669226534043;
        Wed, 23 Nov 2022 10:02:14 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:c968:76:254b:3790])
        by smtp.gmail.com with ESMTPSA id i15-20020a655b8f000000b00470275c8d6dsm10792364pgr.10.2022.11.23.10.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:02:13 -0800 (PST)
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
Subject: [PATCH 02/15] perf stat: Move summary prefix printing logic in CSV output
Date:   Wed, 23 Nov 2022 10:01:55 -0800
Message-Id: <20221123180208.2068936-3-namhyung@kernel.org>
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

It matches to the prefix (interval timestamp), so better to have them together.
No functional change intended.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 46e90f0bb423..d86f2f8e020d 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -713,11 +713,6 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 		nl = config->metric_only ? new_line_metric : new_line_std;
 	}
 
-	if (!config->no_csv_summary && config->csv_output &&
-	    config->summary && !config->interval && !config->metric_only) {
-		fprintf(config->output, "%16s%s", "summary", config->csv_sep);
-	}
-
 	if (run == 0 || ena == 0 || counter->counts->scaled == -1) {
 		if (config->metric_only) {
 			pm(config, &os, NULL, "", "", 0);
@@ -828,8 +823,13 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	ena = aggr->counts.ena;
 	run = aggr->counts.run;
 
-	if (prefix && !metric_only)
-		fprintf(output, "%s", prefix);
+	if (!metric_only) {
+		if (prefix)
+			fprintf(output, "%s", prefix);
+		else if (config->summary && config->csv_output &&
+			 !config->no_csv_summary && !config->interval)
+			fprintf(output, "%16s%s", "summary", config->csv_sep);
+	}
 
 	uval = val * counter->scale;
 
-- 
2.38.1.584.g0f3c55d4c2-goog


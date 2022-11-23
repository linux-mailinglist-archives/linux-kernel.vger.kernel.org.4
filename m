Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE38636843
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbiKWSE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239439AbiKWSCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:38 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BF45FA6;
        Wed, 23 Nov 2022 10:02:27 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d20so17310802plr.10;
        Wed, 23 Nov 2022 10:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i58ch+3MvSovbxgHuPI+VzjhA43rzCO6VyOVuXc7lHM=;
        b=FfVOR/9WaGv3WxhuuUQHJxjW/D1aSEBu4+EtTJgE50WZYia6oDCf4kd0Kz3jliWGnq
         3DzdvlZqj7jehx/mNc6CNbouCeQOFRw+taifsc0WfwnYLdH6gplhgNpOTDCfk1d9xmXI
         6qORHso09UzO2W+VoHwTKpurA9d07uLIdKgdn8VaE0DV+N2Pdo3sd6QrigCfPt+YXMUL
         jX7esb+h0WGEisVeZjCuykJsodrhvOpP/tBopASz11Ey2tVEt+h5SKOtgbkD4HIP9wzT
         Ehxd7B7EUtqBMi1PAZCZOV5aLJFnfOE2QEMf7j0E6vGK2scDNC9VWRvE6KMa88+Iy4Bd
         Bw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i58ch+3MvSovbxgHuPI+VzjhA43rzCO6VyOVuXc7lHM=;
        b=NSqa1wK+Mql7VczFQlf4Ylpjfq+sz34lwL61c7Epf/zJ0aeZYENDjsQAKnyvolLsvW
         An4+OB9/MbJh/Swg4PgvwjIoNsRKB9bVGgbRqMFnFSdRpyP4B6g8XbtixeeV14Gb2Fon
         IkrHWAtSrjn2f+d5qlm+AfrTAsg5ZWgHp7QQMUMVWoBXODiixJnARlOCM/09qp7z7JFG
         0z5SV5NZ3Fl7CB3EJT6wxQEgi5SFKaDtSoaFL576GFLPEVWKHVwzfTtXhUzbjvs66c9n
         /PVzPUpmYquLQNN2BVwjbe7Ajam9dqwnJTRr5ISqw3M3bO95wJnCiSLPLuDGs9n0q3F7
         orSg==
X-Gm-Message-State: ANoB5pmfTCqXmmC72McCtKNRCVcJih45y3BgyVDCEfBZowZ4L9huaGXF
        x+LgQ/AEv54djdpfyYVwMa0=
X-Google-Smtp-Source: AA0mqf7MlQCCN6EWtDUF8eC2YMoh7Z1sJoRGD+pQXenhtyjVd3FIQETT3CKwN2qjnyW3c8+0GhCnlA==
X-Received: by 2002:a17:902:9686:b0:189:24b3:c54 with SMTP id n6-20020a170902968600b0018924b30c54mr9943652plp.96.1669226546627;
        Wed, 23 Nov 2022 10:02:26 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:c968:76:254b:3790])
        by smtp.gmail.com with ESMTPSA id i15-20020a655b8f000000b00470275c8d6dsm10792364pgr.10.2022.11.23.10.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:02:26 -0800 (PST)
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
Subject: [PATCH 11/15] perf stat: Do not pass runtime_stat to printout()
Date:   Wed, 23 Nov 2022 10:02:04 -0800
Message-Id: <20221123180208.2068936-12-namhyung@kernel.org>
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

It always passes a pointer to rt_stat as it's the only one.  Let's not
pass it and directly refer it in the printout().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index dd190f71e933..cdf4ca7f6e3a 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -674,8 +674,7 @@ static bool is_mixed_hw_group(struct evsel *counter)
 }
 
 static void printout(struct perf_stat_config *config, struct outstate *os,
-		     double uval, u64 run, u64 ena, double noise,
-		     struct runtime_stat *st, int map_idx)
+		     double uval, u64 run, u64 ena, double noise, int map_idx)
 {
 	struct perf_stat_output_ctx out;
 	print_metric_t pm;
@@ -737,7 +736,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 
 	if (ok) {
 		perf_stat__print_shadow_stats(config, counter, uval, map_idx,
-					      &out, &config->metric_events, st);
+					      &out, &config->metric_events, &rt_stat);
 	} else {
 		pm(config, &os, /*color=*/NULL, /*format=*/NULL, /*unit=*/"", /*val=*/0);
 	}
@@ -834,7 +833,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 
 	uval = val * counter->scale;
 
-	printout(config, &os, uval, run, ena, avg, &rt_stat, s);
+	printout(config, &os, uval, run, ena, avg, s);
 
 	if (!metric_only)
 		fputc('\n', output);
@@ -987,7 +986,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 			run = ps->aggr[counter_idx].counts.run;
 
 			uval = val * counter->scale;
-			printout(config, &os, uval, run, ena, 1.0, &rt_stat, counter_idx);
+			printout(config, &os, uval, run, ena, 1.0, counter_idx);
 		}
 		if (!first)
 			print_metric_end(config);
-- 
2.38.1.584.g0f3c55d4c2-goog


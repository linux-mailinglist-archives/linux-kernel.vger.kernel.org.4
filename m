Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67F0636815
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbiKWSCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239331AbiKWSCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:16 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0143260F9;
        Wed, 23 Nov 2022 10:02:16 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so2788706pjs.4;
        Wed, 23 Nov 2022 10:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+TpuAANzcP9G4GqFnOlMV6rE/MSCSJ6k6rsAEAM1JY=;
        b=Qckf1AShYdSF9G+SM4znSrGcL1PG0FNywXkO2Cibdzj4VjnLMOACwa0J68haTtg1HK
         SWmpNPJbu8jZWhj5SySKAYCrNWg4RxlUf1SpWQkIl9u5w3Ety/IzEeZxQNkEQQEYx7Qj
         7Xk9/WxFT2hht4RZZV9fXwQB50IApNNyMILgEFU9Cun1jGmH/ouMDyiPwJ6cxc+kW3sT
         wCiraHoERWTJgIgSqe0lsndPeA+LLpgmIT3UVnL6FD2cOo7n7v4iQKLkGdK5opPsZFnp
         KFEGP6llqvyDSPtsPWle7Ioym2OTOWOhuU5c5WouuINBgmqmRkuBzJ4UOdIFg4q2/22y
         /opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2+TpuAANzcP9G4GqFnOlMV6rE/MSCSJ6k6rsAEAM1JY=;
        b=f2nfvIWj4XwB19/9wUmCwqMyVRSN197yQa4vxf9tB+F4Wf9KzbLQsDVbbafH4e62vW
         i8f46Mrp2IXEeKxiC8wz5F34BC4n0Rw+XHm3usOBp3g5AU+jtxgd38qd/0QqrWyI2o7n
         AM5cnikX+ziLH4EmGsqIe5q3mpWrC4uk32FZUYoNu22D4RxNP2rGO6eivtyRUjS5KtYS
         hicz0QWQYNniO7zjZR7YlCP3QJ1wNrhBdzv04+4M+OsWah5wW/iAPBjqUs/416P+3v+e
         hjYAFVfbIZTQBk+ix3Nn60GpYEvOgFKzUQDPkMYGxAdBLpoXbernKRzXzGEpkkbYA1V2
         vI1A==
X-Gm-Message-State: ANoB5pnJqaerenHVK6Oz6U6/MlObf/bCDXqTihBmPQPAFIurRd3MDMeG
        0VlFeNTy+ZgbpFV7pP6Ae5U=
X-Google-Smtp-Source: AA0mqf4XROR4yKoJqyQlP+SkUdpP7f9C/BdD+BhjRpiQ+BCRmabrmydXcmgfIOsRyZclW/+xXhoPEA==
X-Received: by 2002:a17:902:8212:b0:186:85c3:98b7 with SMTP id x18-20020a170902821200b0018685c398b7mr10562086pln.31.1669226535358;
        Wed, 23 Nov 2022 10:02:15 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:c968:76:254b:3790])
        by smtp.gmail.com with ESMTPSA id i15-20020a655b8f000000b00470275c8d6dsm10792364pgr.10.2022.11.23.10.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:02:15 -0800 (PST)
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
Subject: [PATCH 03/15] perf stat: Do not align time prefix in CSV output
Date:   Wed, 23 Nov 2022 10:01:56 -0800
Message-Id: <20221123180208.2068936-4-namhyung@kernel.org>
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

We don't care about the alignment in the CSV output as it's intended for machine
processing.  Let's get rid of it to make the output more compact.

Before:
  # perf stat -a --summary -I 1 -x, true
       0.001149309,219.20,msec,cpu-clock,219322251,100.00,219.200,CPUs utilized
       0.001149309,144,,context-switches,219241902,100.00,656.935,/sec
       0.001149309,38,,cpu-migrations,219173705,100.00,173.358,/sec
       0.001149309,61,,page-faults,219093635,100.00,278.285,/sec
       0.001149309,10679310,,cycles,218746228,100.00,0.049,GHz
       0.001149309,6288296,,instructions,218589869,100.00,0.59,insn per cycle
       0.001149309,1386904,,branches,218428851,100.00,6.327,M/sec
       0.001149309,56863,,branch-misses,218219951,100.00,4.10,of all branches
           summary,219.20,msec,cpu-clock,219322251,100.00,20.025,CPUs utilized
           summary,144,,context-switches,219241902,100.00,656.935,/sec
           summary,38,,cpu-migrations,219173705,100.00,173.358,/sec
           summary,61,,page-faults,219093635,100.00,278.285,/sec
           summary,10679310,,cycles,218746228,100.00,0.049,GHz
           summary,6288296,,instructions,218589869,100.00,0.59,insn per cycle
           summary,1386904,,branches,218428851,100.00,6.327,M/sec
           summary,56863,,branch-misses,218219951,100.00,4.10,of all branches

After:
  0.001148449,224.75,msec,cpu-clock,224870589,100.00,224.747,CPUs utilized
  0.001148449,176,,context-switches,224775564,100.00,783.103,/sec
  0.001148449,38,,cpu-migrations,224707428,100.00,169.079,/sec
  0.001148449,61,,page-faults,224629326,100.00,271.416,/sec
  0.001148449,12172071,,cycles,224266368,100.00,0.054,GHz
  0.001148449,6901907,,instructions,224108764,100.00,0.57,insn per cycle
  0.001148449,1515655,,branches,223946693,100.00,6.744,M/sec
  0.001148449,70027,,branch-misses,223735385,100.00,4.62,of all branches
  summary,224.75,msec,cpu-clock,224870589,100.00,21.066,CPUs utilized
  summary,176,,context-switches,224775564,100.00,783.103,/sec
  summary,38,,cpu-migrations,224707428,100.00,169.079,/sec
  summary,61,,page-faults,224629326,100.00,271.416,/sec
  summary,12172071,,cycles,224266368,100.00,0.054,GHz
  summary,6901907,,instructions,224108764,100.00,0.57,insn per cycle
  summary,1515655,,branches,223946693,100.00,6.744,M/sec
  summary,70027,,branch-misses,223735385,100.00,4.62,of all branches

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index d86f2f8e020d..15c88b9b5aa3 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -828,7 +828,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 			fprintf(output, "%s", prefix);
 		else if (config->summary && config->csv_output &&
 			 !config->no_csv_summary && !config->interval)
-			fprintf(output, "%16s%s", "summary", config->csv_sep);
+			fprintf(output, "%s%s", "summary", config->csv_sep);
 	}
 
 	uval = val * counter->scale;
@@ -1078,9 +1078,12 @@ static void prepare_interval(struct perf_stat_config *config,
 	if (config->iostat_run)
 		return;
 
-	if (!config->json_output)
-		sprintf(prefix, "%6lu.%09lu%s", (unsigned long) ts->tv_sec,
+	if (config->csv_output)
+		sprintf(prefix, "%lu.%09lu%s", (unsigned long) ts->tv_sec,
 				 ts->tv_nsec, config->csv_sep);
+	else if (!config->json_output)
+		sprintf(prefix, "%6lu.%09lu ", (unsigned long) ts->tv_sec,
+				 ts->tv_nsec);
 	else if (!config->metric_only)
 		sprintf(prefix, "{\"interval\" : %lu.%09lu, ", (unsigned long)
 				 ts->tv_sec, ts->tv_nsec);
-- 
2.38.1.584.g0f3c55d4c2-goog


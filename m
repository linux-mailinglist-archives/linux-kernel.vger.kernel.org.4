Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A93A620139
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiKGVds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbiKGVd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:33:28 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59BAB1B;
        Mon,  7 Nov 2022 13:33:26 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b21so12303325plc.9;
        Mon, 07 Nov 2022 13:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEwG62U2ocTRAE+zcAm5Rx1np9/Wr63UQVaH+5ioR9I=;
        b=Hc+KCEIHI0yjOOxQWtJwjkjcfiZXxl/jTVZifw/Fon9yqTKXtKv5u4DbvdbdDg7b0G
         kG8o1emeN56chtVXqrb982qGiSNzp6P3NbXfUnbckq0ANeuDN0wppNwD3xQ8hwOtMNNP
         jwLuRjW0Jab1wVy26+mMwtVkZWLgj8c/5rtJ2OB2wJc/HT7E/JOe9wAXDm3ZTXd7mZKC
         kATtnMx12FaYWV0jgws7UYZWrWyxSZNjbVW6m3EaXFE+58au9jrY1kz0hkdR+tDplIDh
         4kKLsAadGt7rZXfbu1QFAbgkvLbeUVLIFa1aHcdq9aDMZmqGE9m+/XC6BMp2PlomTXff
         Bwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uEwG62U2ocTRAE+zcAm5Rx1np9/Wr63UQVaH+5ioR9I=;
        b=VwnpDz7gviu5bMT5MQ4ANzsk1SfuyKfqbWY0UeZ5ZX5TyT9b9ArFhMBnRTPXkjXoe6
         xdVnCafIM4ozPsp63rXmVvKUL44hEBWMEY+uYYWLWEMJpxpxYnIZLL4wg7ktH36lFV+f
         Deprk4l3OKl0NYw8TtevbSxrFJxmvs/YjUjQbrIRDCH4B353GMvb0zz5me9bVgtCT1fd
         k+5onsCND3m/UNLeJx8Iue8HnKexYjIVmH0LixKPANRh182no98OAGAyx0WKUnj4GvSZ
         qNnzkf9BLNR+Jw8cCG0WR4seh2wgyJz35DPIu0AzS3jUqRT4Hx6TK6E/1olrYHP8Wi6p
         l6wA==
X-Gm-Message-State: ACrzQf3I52dlikkKv/1pbCAfnYH4KYGpY69szDPERkuMWyZiMbXPTdXj
        JkrXneT6dtkvC+fuqoevOro=
X-Google-Smtp-Source: AMsMyM5n/dzXkOfJeTpeQ97B/T0IHKk094vL/ofETPkyF4jUeyUS3qx/VwbZwR6AO8iNAdaFHXqQvg==
X-Received: by 2002:a17:902:9a41:b0:188:50c2:89cf with SMTP id x1-20020a1709029a4100b0018850c289cfmr27538355plv.34.1667856806361;
        Mon, 07 Nov 2022 13:33:26 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5850:5958:9c77:f623])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b0017f5ba1fffasm5366413pln.297.2022.11.07.13.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:33:26 -0800 (PST)
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
Subject: [PATCH 6/9] perf stat: Do not indent headers for JSON
Date:   Mon,  7 Nov 2022 13:33:11 -0800
Message-Id: <20221107213314.3239159-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221107213314.3239159-1-namhyung@kernel.org>
References: <20221107213314.3239159-1-namhyung@kernel.org>
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

Currently --metric-only with --json indents header lines.  This is not
needed for JSON.

  $ perf stat -aA --metric-only -j true
        {"unit" : "GHz"}{"unit" : "insn per cycle"}{"unit" : "branch-misses of all branches"}
  {"cpu" : "0", {"metric-value" : "0.101"}{"metric-value" : "0.86"}{"metric-value" : "1.91"}
  {"cpu" : "1", {"metric-value" : "0.102"}{"metric-value" : "0.87"}{"metric-value" : "2.02"}
  {"cpu" : "2", {"metric-value" : "0.085"}{"metric-value" : "1.02"}{"metric-value" : "1.69"}
  ...

Note that the other lines are broken JSON, but it will be handled later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 515fb6db3d67..25f67fb37f6d 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -851,7 +851,7 @@ static void print_metric_headers(struct perf_stat_config *config,
 	if (prefix && !config->json_output)
 		fprintf(config->output, "%s", prefix);
 
-	if (!config->csv_output && !no_indent)
+	if (!config->csv_output && !config->json_output && !no_indent)
 		fprintf(config->output, "%*s",
 			aggr_header_lens[config->aggr_mode], "");
 	if (config->csv_output) {
-- 
2.38.1.431.g37b22c650d-goog


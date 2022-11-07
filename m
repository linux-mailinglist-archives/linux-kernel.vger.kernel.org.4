Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2270162013A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiKGVdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiKGVd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:33:29 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A39FDA2;
        Mon,  7 Nov 2022 13:33:24 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id v3so11629342pgh.4;
        Mon, 07 Nov 2022 13:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIzOeW4bqFAI0ZH2XjiJS5dG7CBesFCQCZcY4ffv/5k=;
        b=Rdq9AtpQ8XqcN3B/WunTUwRM/esIVOLGUjjW0IkrxsTEQDcHBwSY2wQIXEWg/sdJS5
         rarfpDM9YCvt5+LMJohUnxBSQXo6pgGP2kxUFXcwA0cj408Z5u2TR9GedsgRndqnO79I
         9REV/ya38OwppOAY5PKuKzVk4GTzrm1DTfk07FRrzUeKtLqaV8kS3aY31LXl3O3Ik8a/
         E1y0DdGllTSXmnh/wit5D7kyii3XanD79Voxw+NqwLlGvlRrF9it3SKKBOJ3NWl8vvGd
         vQc8upcdNm8xB9fdsed8VEbpGlDKGHtjeFC8p8nM0b7mlHivMZfn9G1F0QpPektOlTsn
         59lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AIzOeW4bqFAI0ZH2XjiJS5dG7CBesFCQCZcY4ffv/5k=;
        b=QBWJISr+Etq3HBF+F6pMPoC7gBY4Gy13pTJ3Mo4e6ynOJPD094G/DIq2K3pE+X57dZ
         sYTzfPwqdBtz87wZrpjfjdCn01J3CXEq93HA1gcmrgpqrzBeRlYeVTjoh54uR/1s0e9n
         +nhAzI2zlLRXTFdWs0ZiruGJJLSxrAFUFRkaOcNB0CyYUQjtDxaDiZBwUFASogKEyQ3N
         K3fYiXJUYQqzmgm5hLpo9xv/G/8wwyA+kR1jrX2a6+i5QSOJFzrl8YgXWSo+CS9Hps7a
         RWC5oS1JzZVG/HWb1UZ7HxR7WSvZH7X5ECoeGLfY312nec3r9yDjI+yMX2YDUKcgNzMg
         2Abw==
X-Gm-Message-State: ACrzQf1kv48I5JoI21YX8J+ZFM9b0N4iaLiXT63UEnPoWnEu6jjwE5Ug
        cNSoev++4WxzDssYtp2a6ySrLdxMsqE=
X-Google-Smtp-Source: AMsMyM4Ryq09UYPfCZ5YqDppNoZLZOICO2oqCN2VSHAs0RRj9xSG3jBA1+bYKUeEOYeVLMZR3osqdA==
X-Received: by 2002:a05:6a00:240b:b0:56c:f55a:65b4 with SMTP id z11-20020a056a00240b00b0056cf55a65b4mr887433pfh.35.1667856803802;
        Mon, 07 Nov 2022 13:33:23 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5850:5958:9c77:f623])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b0017f5ba1fffasm5366413pln.297.2022.11.07.13.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:33:23 -0800 (PST)
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
Subject: [PATCH 4/9] perf stat: Move common code in print_metric_headers()
Date:   Mon,  7 Nov 2022 13:33:09 -0800
Message-Id: <20221107213314.3239159-5-namhyung@kernel.org>
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

The struct perf_stat_output_ctx is set in a loop with the same values.
Move the code out of the loop and keep the loop minimal.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index d4936a502560..115477461224 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -837,11 +837,16 @@ static void print_metric_headers(struct perf_stat_config *config,
 				 struct evlist *evlist,
 				 const char *prefix, bool no_indent)
 {
-	struct perf_stat_output_ctx out;
 	struct evsel *counter;
 	struct outstate os = {
 		.fh = config->output
 	};
+	struct perf_stat_output_ctx out = {
+		.ctx = &os,
+		.print_metric = print_metric_header,
+		.new_line = new_line_metric,
+		.force_header = true,
+	};
 	bool first = true;
 
 	if (config->json_output && !config->interval)
@@ -865,13 +870,11 @@ static void print_metric_headers(struct perf_stat_config *config,
 	/* Print metrics headers only */
 	evlist__for_each_entry(evlist, counter) {
 		os.evsel = counter;
-		out.ctx = &os;
-		out.print_metric = print_metric_header;
+
 		if (!first && config->json_output)
 			fprintf(config->output, ", ");
 		first = false;
-		out.new_line = new_line_metric;
-		out.force_header = true;
+
 		perf_stat__print_shadow_stats(config, counter, 0,
 					      0,
 					      &out,
-- 
2.38.1.431.g37b22c650d-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE8B62013B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiKGVdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiKGVdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:33:40 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D567DD2DE;
        Mon,  7 Nov 2022 13:33:30 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gw22so11861576pjb.3;
        Mon, 07 Nov 2022 13:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWKNNag4dwKiJExBOGweLXLb/8nFtKqU9STsZaykkGI=;
        b=nGjJh+u1cT5OcLzNsc5z5NXn3K+ih9o0FvHL2x/uWnazjn2jGmuuTlQD3O1KmcteJm
         UygjpYZP8GJ+VoNgshCb4dvhzIir2Je/de7WZhyGFrQyAIEE9M6Jr+G7IxwS8kVsgE2U
         3CGxv/94tzRcBIgMzedh6NJctPvssF7nWKmVLVecWLC3HiPSpLMG+VDinxKsId/26+KK
         5OG5//yDxHa507fdLJo7f9lHIZpl5/dPWVy5Id9vnAC+8IRRjFKnJyMqqS7O/LcU2oTY
         HumI4hF0T6ie/juL1fKJVCJ9R36t8HNl8I7vfyKEjGhiWLRt4szY+KnbANh1IL3pn4Ew
         aDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tWKNNag4dwKiJExBOGweLXLb/8nFtKqU9STsZaykkGI=;
        b=kUB09Y9nXnBqTv8Hx+TZY2gl39BbaKWXm6ptpTtUFhKJXy+Yw3BvBRLA4uXzRgV/S8
         YNNavW2sUHcxq0LYS/G7GJufJmN++WluXO1xKBq+Y1NGhkSMDIOnqy0i8AC8AjCpeBcd
         mpGItqNbJfIe+XNP8DhGKz7tL4Gg2glpi5Dd0uExvNrrbq0+TWGOPLV2wYQ14kefjQl4
         YB2VUkPYEwrjhJHVWXNQqMXaq69dfLYjwh2cRZL4VU35nkw+8MBnoS8Vn7+/3fmkaR4g
         xHPHd6Jc3GywxtXpI0e5JDodrUCPLVH8EQHYFUYsb875qkxZif3ZkT4lB67J7+D75jn2
         GWAg==
X-Gm-Message-State: ACrzQf20+4OvLtXvMVpKeeHcRwwtrTwj3BjiXE5s9vsWcUVf2+NukjfZ
        hJRDKP5ATo5KgipkA/z1Zjo=
X-Google-Smtp-Source: AMsMyM41ctb7Hr22501NqnEn20K0yT4jjisnCMVEgyoJZpBbz/PcJV1E1aUzzIdC6tnWR8ZB8l0bIg==
X-Received: by 2002:a17:90b:84:b0:213:de0c:1253 with SMTP id bb4-20020a17090b008400b00213de0c1253mr45777292pjb.74.1667856810221;
        Mon, 07 Nov 2022 13:33:30 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5850:5958:9c77:f623])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b0017f5ba1fffasm5366413pln.297.2022.11.07.13.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:33:29 -0800 (PST)
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
Subject: [PATCH 9/9] perf stat: Consolidate condition to print metrics
Date:   Mon,  7 Nov 2022 13:33:14 -0800
Message-Id: <20221107213314.3239159-10-namhyung@kernel.org>
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

The pm variable holds an appropriate function to print metrics for CSV
anf JSON already.  So we can combine the if statement to simplify the
code a little bit.  This also matches to the above condition for non-CSV
and non-JSON case.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index a10af26c26ab..4d3999673dde 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -600,9 +600,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 			pm(config, &os, NULL, NULL, "", 0);
 		print_noise(config, counter, noise);
 		print_running(config, run, ena);
-		if (config->csv_output)
-			pm(config, &os, NULL, NULL, "", 0);
-		else if (config->json_output)
+		if (config->csv_output || config->json_output)
 			pm(config, &os, NULL, NULL, "", 0);
 		return;
 	}
-- 
2.38.1.431.g37b22c650d-goog


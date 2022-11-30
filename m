Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B9F63E0D3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 20:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiK3TgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 14:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiK3TgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:36:18 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA4089AFE;
        Wed, 30 Nov 2022 11:36:17 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id s7so1959675plk.5;
        Wed, 30 Nov 2022 11:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fyG8WvkPMaea4/Z35OOcdALNhvtYUcjAcZOj1KR+VQ4=;
        b=kTuBUGuWT1T5EiBXVPP90GRGXROkfO1Lcxj+dxMPRnM+Po6lvjemlajHY81b8cmng1
         Unz7b75KPYUDSNPmetr8diP2hmLKeNT6mRCgEooL/X1alxrz2kAsQOphtQzcvkp/lVFd
         DAcyfgtC3KG1QKwEJCA4W4ucmh4GNaDNQDzgnYfWeuh76Sgh7YA+jMrNBcZFVwZcgSXT
         SAvSfPI4vv2cHAdlrnmyyNZRBDXb9+dOBhQSCX8wLzxO0vLBoe7OUilwgTZA15heUdS8
         m7KWrBIeG6cx+qOUk18qsnQa/CkBDIg3jExA+S77nCzzl80A0qtdnCJuEyWXe69M+FQu
         I4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyG8WvkPMaea4/Z35OOcdALNhvtYUcjAcZOj1KR+VQ4=;
        b=WFKMWXHWXmNLVQQjgVDNLOLXtL48my6caMLaXRu7v13jEm1t6pUGqGwPhz8KielrKq
         8buzjG0BgeeY6hy86KqAW/+5SfQOa+lOnjtnF2wWM+nwgu3WTkOChBVGrAYopWHndS1n
         PnwD9uUKLDYeev5BA6ZyA7+oq97F3yfyYUi710lkRyukWEs6zw8IlMY+5jTewEXCdd3J
         83MDNlcxZQJOIkHOT40Q/GH1XeBCTFq7ZEJkdkaq4fSxn/0p5meB3taxxrOwMcP5DC24
         QvMPuIwIM03eNwrU9xcwvBJTcdVaONjHk2sZDH3LzZ9pPRMq8HcYIQjkUAaJ60eAy8H7
         rIGA==
X-Gm-Message-State: ANoB5plKHQrS0aSTvGK6I6sNWrM/sJC7SIQnEWJEbnjoLMjrw0/vEsse
        ETm32JTMWYEOb4hkTnMPinZ7WqshYRU=
X-Google-Smtp-Source: AA0mqf61fXrIlPncmomHPQnlQZs+TDlmDe/+xABJjuH7pad2RvQZlQVgHgqw9OQCsHt0bY8XCjXx4A==
X-Received: by 2002:a17:902:d4c5:b0:189:5e92:d457 with SMTP id o5-20020a170902d4c500b001895e92d457mr29960801plg.166.1669836976603;
        Wed, 30 Nov 2022 11:36:16 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b6d7:38d3:afe2:969f])
        by smtp.gmail.com with ESMTPSA id k9-20020a63ff09000000b0044046aec036sm1297683pgi.81.2022.11.30.11.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 11:36:15 -0800 (PST)
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
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] Revert "perf stat: Rename "aggregate-number" to "cpu-count" in JSON"
Date:   Wed, 30 Nov 2022 11:36:13 -0800
Message-Id: <20221130193613.1046804-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
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

This reverts commit c4b41b83c25073c09bfcc4e5ec496c9dd316656b.

As Ian said, the "cpu-count" is not appropriate for uncore events, also it
caused a perf test failure.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 847acdb5dc40..f1ee4b052198 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -281,19 +281,19 @@ static void print_aggr_id_json(struct perf_stat_config *config,
 
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
-		fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"cpu-count\" : %d, ",
+		fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-number\" : %d, ",
 			id.socket, id.die, id.core, nr);
 		break;
 	case AGGR_DIE:
-		fprintf(output, "\"die\" : \"S%d-D%d\", \"cpu-count\" : %d, ",
+		fprintf(output, "\"die\" : \"S%d-D%d\", \"aggregate-number\" : %d, ",
 			id.socket, id.die, nr);
 		break;
 	case AGGR_SOCKET:
-		fprintf(output, "\"socket\" : \"S%d\", \"cpu-count\" : %d, ",
+		fprintf(output, "\"socket\" : \"S%d\", \"aggregate-number\" : %d, ",
 			id.socket, nr);
 		break;
 	case AGGR_NODE:
-		fprintf(output, "\"node\" : \"N%d\", \"cpu-count\" : %d, ",
+		fprintf(output, "\"node\" : \"N%d\", \"aggregate-number\" : %d, ",
 			id.node, nr);
 		break;
 	case AGGR_NONE:
-- 
2.38.1.584.g0f3c55d4c2-goog


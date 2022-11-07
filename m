Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8C6620135
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbiKGVdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiKGVdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:33:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFAB2EF69;
        Mon,  7 Nov 2022 13:33:20 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso15944550pjg.5;
        Mon, 07 Nov 2022 13:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/+ttTXlN3qSbb6UdL+RVJy8YHaKz6aK11BAwI0KhZk=;
        b=bT85bhI6QB9lAe+cK/rigjb/ajLGDmXBUw0hdSD22wbGr/UQY/Mminlke55bRAebf7
         0+IuVaLVLgYwYqGGpeBn0Tv1LbZ8F04Cs8ihKMzCoi6Uk9YWxKvPweSbFSjOUGe4k1/L
         BfzY1VyP5MLjC2fwDRYhYiDHNnwboMZEe7+bI2nY9xKPzWJjwMterMehmFHve1RYabZl
         V1SylFJDb6sXgEBSdkOBwZf0CFxMwxKPCHUGMa4sZJKch/D/tOHGoY3nZkm9Spd4bsy7
         z28nkpTYHByNuIxG8vQ+lBb4oe2JzIBHfk7emsPRTkroltTHnR0UPE/W9QjlPA0Y6yNx
         /fwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P/+ttTXlN3qSbb6UdL+RVJy8YHaKz6aK11BAwI0KhZk=;
        b=rBINTWAlOFLhyq/HfW2K1DagS+fEIVV7o5qQsPWuTU4ZZzuCSYvasH0r5Ciopw0BsQ
         Ov2OjKmFMphkgRZMCP8MBoypy1VGHG71nFJCbSqV3a+WaZE85tGN3cWHksyScZrgJbk6
         a9XxRR+Z6qLVmBm1fYLgR3yK51sfDselwT/3GMS26FBVWBTkiltG/FiLtEWQTOJ3txIP
         HhEFPpB7HihZs+7d2kkSiALlMp/A/OdYsa0ChGgAbODhj2gXfRj3lG0f3Gm9rNqEqW2h
         v9sHlrNh0YfCd6U3QL2mLW1S6wcLzO/PqRAa/NuxKDBjZEt+rx9wRo9BYhpkaU6iK+RM
         5HbQ==
X-Gm-Message-State: ACrzQf0TVjtW2XBIENEn6W3aeK9LBH2wOhnBWsQWMphaN7Sf2uVt8XzK
        ckXMAMfA2Xv++ycIBRZsAq8=
X-Google-Smtp-Source: AMsMyM7t6jdCbHFngz6P451f81KbVjyB8yzw1r0FD0YXCKbFAuyxzS8wxkgsrpqunc0bq0s/cCp9pQ==
X-Received: by 2002:a17:902:d38d:b0:186:9fc5:6c13 with SMTP id e13-20020a170902d38d00b001869fc56c13mr52726184pld.73.1667856799881;
        Mon, 07 Nov 2022 13:33:19 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5850:5958:9c77:f623])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b0017f5ba1fffasm5366413pln.297.2022.11.07.13.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:33:19 -0800 (PST)
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
Subject: [PATCH 1/9] perf stat: Fix crash with --per-node --metric-only in CSV mode
Date:   Mon,  7 Nov 2022 13:33:06 -0800
Message-Id: <20221107213314.3239159-2-namhyung@kernel.org>
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

The following command will get segfault due to missing aggr_header_csv
for AGGR_NODE:

  $ sudo perf stat -a --per-node -x, --metric-only true

Fixes: 86895b480a2f ("perf stat: Add --per-node agregation support")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 657434cd29ee..ea41e6308c50 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -534,7 +534,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 			[AGGR_CORE] = 2,
 			[AGGR_THREAD] = 1,
 			[AGGR_UNSET] = 0,
-			[AGGR_NODE] = 0,
+			[AGGR_NODE] = 1,
 		};
 
 		pm = config->metric_only ? print_metric_only_csv : print_metric_csv;
@@ -819,6 +819,7 @@ static int aggr_header_lens[] = {
 	[AGGR_SOCKET] = 12,
 	[AGGR_NONE] = 6,
 	[AGGR_THREAD] = 24,
+	[AGGR_NODE] = 6,
 	[AGGR_GLOBAL] = 0,
 };
 
@@ -828,6 +829,7 @@ static const char *aggr_header_csv[] = {
 	[AGGR_SOCKET] 	= 	"socket,cpus",
 	[AGGR_NONE] 	= 	"cpu,",
 	[AGGR_THREAD] 	= 	"comm-pid,",
+	[AGGR_NODE] 	= 	"node,",
 	[AGGR_GLOBAL] 	=	""
 };
 
-- 
2.38.1.431.g37b22c650d-goog


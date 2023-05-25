Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EE9710C72
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbjEYMyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjEYMyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:54:18 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D241187
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:54:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjSJ3fp_1685019252;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VjSJ3fp_1685019252)
          by smtp.aliyun-inc.com;
          Thu, 25 May 2023 20:54:13 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] mm: compaction: change fast_isolate_freepages() to void type
Date:   Thu, 25 May 2023 20:53:57 +0800
Message-Id: <759fca20b22ebf4c81afa30496837b9e0fb2e53b.1685018752.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1685018752.git.baolin.wang@linux.alibaba.com>
References: <cover.1685018752.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No caller cares about the return value of fast_isolate_freepages(),
void it.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 426bb6ce070b..3737c6591bfb 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1435,8 +1435,7 @@ static int next_search_order(struct compact_control *cc, int order)
 	return order;
 }
 
-static unsigned long
-fast_isolate_freepages(struct compact_control *cc)
+static void fast_isolate_freepages(struct compact_control *cc)
 {
 	unsigned int limit = max(1U, freelist_scan_limit(cc) >> 1);
 	unsigned int nr_scanned = 0;
@@ -1449,7 +1448,7 @@ fast_isolate_freepages(struct compact_control *cc)
 
 	/* Full compaction passes in a negative order */
 	if (cc->order <= 0)
-		return cc->free_pfn;
+		return;
 
 	/*
 	 * If starting the scan, use a deeper search and use the highest
@@ -1588,11 +1587,10 @@ fast_isolate_freepages(struct compact_control *cc)
 
 	cc->total_free_scanned += nr_scanned;
 	if (!page)
-		return cc->free_pfn;
+		return;
 
 	low_pfn = page_to_pfn(page);
 	fast_isolate_around(cc, low_pfn);
-	return low_pfn;
 }
 
 /*
-- 
2.27.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A71673CE3C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 05:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjFYDRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 23:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjFYDRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 23:17:14 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51E28E79
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 20:17:11 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.188:58134.1536611199
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.85 (unknown [172.18.0.188])
        by chinatelecom.cn (HERMES) with SMTP id B9DB32800C3;
        Sun, 25 Jun 2023 11:17:05 +0800 (CST)
X-189-SAVE-TO-SEND: +liuq131@chinatelecom.cn
Received: from  ([36.111.64.85])
        by app0023 with ESMTP id 5532cf49ba864d7eb912378703cac591 for ying.huang@intel.com;
        Sun, 25 Jun 2023 11:17:09 CST
X-Transaction-ID: 5532cf49ba864d7eb912378703cac591
X-Real-From: liuq131@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
Sender: liuq131@chinatelecom.cn
From:   liuq <liuq131@chinatelecom.cn>
To:     ying.huang@intel.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, liuq <liuq131@chinatelecom.cn>
Subject: [PATCH v5] mm/page_alloc: fix min_free_kbytes calculation regarding ZONE_MOVABLE
Date:   Sun, 25 Jun 2023 11:16:56 +0800
Message-Id: <20230625031656.23941-1-liuq131@chinatelecom.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current calculation of min_free_kbytes only uses ZONE_DMA and
ZONE_NORMAL pages,but the ZONE_MOVABLE zone->_watermark[WMARK_MIN]
will also divide part of min_free_kbytes.This will cause the min
watermark of ZONE_NORMAL to be too small in the presence of ZONE_MOVEABLE.

__GFP_HIGH and PF_MEMALLOC allocations usually don't need movable
zone pages, so just like ZONE_HIGHMEM, cap pages_min to a small
value in __setup_per_zone_wmarks().

On my testing machine with 16GB of memory (transparent hugepage is
turned off by default, and movablecore=12G is configured)
The following is a comparative test data of watermark_min

		no patch	add patch
ZONE_DMA	1		8
ZONE_DMA32	151		709
ZONE_NORMAL	233		1113
ZONE_MOVABLE	1434		128
min_free_kbytes	7288		7326

Signed-off-by: liuq <liuq131@chinatelecom.cn>
---
 mm/page_alloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 47421bedc12b..590ed8725e09 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6362,9 +6362,9 @@ static void __setup_per_zone_wmarks(void)
 	struct zone *zone;
 	unsigned long flags;
 
-	/* Calculate total number of !ZONE_HIGHMEM pages */
+	/* Calculate total number of !ZONE_HIGHMEM and !ZONE_MOVABLE pages */
 	for_each_zone(zone) {
-		if (!is_highmem(zone))
+		if (!is_highmem(zone) && zone_idx(zone) != ZONE_MOVABLE)
 			lowmem_pages += zone_managed_pages(zone);
 	}
 
@@ -6374,15 +6374,15 @@ static void __setup_per_zone_wmarks(void)
 		spin_lock_irqsave(&zone->lock, flags);
 		tmp = (u64)pages_min * zone_managed_pages(zone);
 		do_div(tmp, lowmem_pages);
-		if (is_highmem(zone)) {
+		if (is_highmem(zone) || zone_idx(zone) == ZONE_MOVABLE) {
 			/*
 			 * __GFP_HIGH and PF_MEMALLOC allocations usually don't
-			 * need highmem pages, so cap pages_min to a small
-			 * value here.
+			 * need highmem and movable zones pages, so cap pages_min
+			 * to a small  value here.
 			 *
 			 * The WMARK_HIGH-WMARK_LOW and (WMARK_LOW-WMARK_MIN)
 			 * deltas control async page reclaim, and so should
-			 * not be capped for highmem.
+			 * not be capped for highmem and movable zones.
 			 */
 			unsigned long min_pages;
 
-- 
2.27.0


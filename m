Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB317385A0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjFUNsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFUNsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:48:12 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C230919C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:48:10 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.48:59213.1763852642
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-111.9.1.183 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id AFB71280090;
        Wed, 21 Jun 2023 21:48:03 +0800 (CST)
X-189-SAVE-TO-SEND: +liuq131@chinatelecom.cn
Received: from  ([111.9.1.183])
        by app0024 with ESMTP id 706fd4b5277744c0892d36d6ca274296 for akpm@linux-foundation.org;
        Wed, 21 Jun 2023 21:48:08 CST
X-Transaction-ID: 706fd4b5277744c0892d36d6ca274296
X-Real-From: liuq131@chinatelecom.cn
X-Receive-IP: 111.9.1.183
X-MEDUSA-Status: 0
Sender: liuq131@chinatelecom.cn
Message-ID: <37d8c6c3-0dd1-94b1-19cd-4743968b0fce@chinatelecom.cn>
Date:   Wed, 21 Jun 2023 21:48:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     akpm@linux-foundation.org, liuq131@chinatelecom.cn
Cc:     "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
From:   liuq <liuq131@chinatelecom.cn>
Subject: [PATCH v4] mm/page_alloc: fix min_free_kbytes calculation regarding
 ZONE_MOVABLE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
value in __setup_per_zone_wmarks.

On my testing machine with 16GB of memory (transparent hugepage is
turned off by default, and movablecore=12G is configured)
The following is a comparative test data of watermark_min

		no patch	add patch
ZONE_DMA	1		8
ZONE_DMA32	151		709
ZONE_NORMAL	233		1113
ZONE_MOVABLE	1434		128
min_free_kbytes	7288		7326

Signed-off-by: liuq<liuq131@chinatelecom.cn>
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
+			 * to a small value here.
  			 *
  			 * The WMARK_HIGH-WMARK_LOW and (WMARK_LOW-WMARK_MIN)
  			 * deltas control async page reclaim, and so should
-			 * not be capped for highmem.
+			 * not be capped for highmem and movable zones.
  			 */
  			unsigned long min_pages;
  
-- 2.27.0


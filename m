Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DFB6F1648
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345519AbjD1LBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjD1LBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:01:43 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88882706
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:01:40 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 33SB17r7034907;
        Fri, 28 Apr 2023 19:01:07 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 28 Apr 2023 19:01:01 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: [PATCH] mm: optimization on page allocation when CMA enabled
Date:   Fri, 28 Apr 2023 19:00:41 +0800
Message-ID: <1682679641-13652-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 33SB17r7034907
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Please be notice bellowing typical scenario that commit 168676649 introduce,
that is, 12MB free cma pages 'help' GFP_MOVABLE to keep draining/fragmenting
U&R page blocks until they shrink to 12MB without enter slowpath which against
current reclaiming policy. This commit change the criteria from hard coded '1/2'
to watermark check which leave U&R free pages stay around WMARK_LOW when being
fallback.

DMA32 free:25900kB boost:0kB min:4176kB low:25856kB high:29516kB

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/page_alloc.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0745aed..97768fe 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3071,6 +3071,39 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 
 }
 
+#ifdef CONFIG_CMA
+static bool __if_use_cma_first(struct zone *zone, unsigned int order, unsigned int alloc_flags)
+{
+	unsigned long cma_proportion = 0;
+	unsigned long cma_free_proportion = 0;
+	unsigned long watermark = 0;
+	unsigned long wm_fact[ALLOC_WMARK_MASK] = {1, 1, 2};
+	long count = 0;
+	bool cma_first = false;
+
+	watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
+	/*check if GFP_MOVABLE pass previous watermark check via the help of CMA*/
+	if (!zone_watermark_ok(zone, order, watermark, 0, alloc_flags & (~ALLOC_CMA)))
+	{
+		alloc_flags &= ALLOC_WMARK_MASK;
+		/* WMARK_LOW failed lead to using cma first, this helps U&R stay
+		 * around low when being drained by GFP_MOVABLE
+		 */
+		if (alloc_flags <= ALLOC_WMARK_LOW)
+			cma_first = true;
+		/*check proportion for WMARK_HIGH*/
+		else {
+			count = atomic_long_read(&zone->managed_pages);
+			cma_proportion = zone->cma_pages * 100 / count;
+			cma_free_proportion = zone_page_state(zone, NR_FREE_CMA_PAGES) * 100
+				/  zone_page_state(zone, NR_FREE_PAGES);
+			cma_first = (cma_free_proportion >= wm_fact[alloc_flags] * cma_proportion
+					|| cma_free_proportion >= 50);
+		}
+	}
+	return cma_first;
+}
+#endif
 /*
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
@@ -3087,10 +3120,9 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 		 * allocating from CMA when over half of the zone's free memory
 		 * is in the CMA area.
 		 */
-		if (alloc_flags & ALLOC_CMA &&
-		    zone_page_state(zone, NR_FREE_CMA_PAGES) >
-		    zone_page_state(zone, NR_FREE_PAGES) / 2) {
-			page = __rmqueue_cma_fallback(zone, order);
+		if (migratetype == MIGRATE_MOVABLE) {
+			bool cma_first = __if_use_cma_first(zone, order, alloc_flags);
+			page = cma_first ? __rmqueue_cma_fallback(zone, order) : NULL;
 			if (page)
 				return page;
 		}
-- 
1.9.1


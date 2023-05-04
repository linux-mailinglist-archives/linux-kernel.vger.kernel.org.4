Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295506F68EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjEDKNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEDKNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:13:23 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7FA49EC
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 03:13:16 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 344AAIsq063681;
        Thu, 4 May 2023 18:10:18 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 4 May 2023 18:10:11 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: [PATCHv2] mm: optimization on page allocation when CMA enabled
Date:   Thu, 4 May 2023 18:09:54 +0800
Message-ID: <1683194994-3070-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 344AAIsq063681
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Let us look at the series of scenarios below with WMARK_LOW=25MB,WMARK_MIN=5MB
(managed pages 1.9GB). We can know that current 'fixed 1/2 ratio' start to use
CMA since C which actually has caused U&R lower than WMARK_LOW (this should be
deemed as against current memory policy, that is, U&R should either stay around
WATERMARK_LOW when no allocation or do reclaim via enter slowpath)

free_cma/free_pages(MB)      A(12/30)     B(12/25)     C(12/20)
fixed 1/2 ratio                 N             N           Y
this commit                     Y             Y           Y

Suggested-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v2: do proportion check when zone_watermark_ok, update commit message
---
---
 mm/page_alloc.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0745aed..d0baeab 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3071,6 +3071,34 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 
 }
 
+#ifdef CONFIG_CMA
+static bool __if_use_cma_first(struct zone *zone, unsigned int order, unsigned int alloc_flags)
+{
+	unsigned long cma_proportion = 0;
+	unsigned long cma_free_proportion = 0;
+	unsigned long watermark = 0;
+	long count = 0;
+	bool cma_first = false;
+
+	watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
+	/*check if GFP_MOVABLE pass previous watermark check via the help of CMA*/
+	if (!zone_watermark_ok(zone, order, watermark, 0, alloc_flags & (~ALLOC_CMA)))
+		/* WMARK_LOW failed lead to using cma first, this helps U&R stay
+		 * around low when being drained by GFP_MOVABLE
+		 */
+		cma_first = true;
+	else {
+		/*check proportion when zone_watermark_ok*/
+		count = atomic_long_read(&zone->managed_pages);
+		cma_proportion = zone->cma_pages * 100 / count;
+		cma_free_proportion = zone_page_state(zone, NR_FREE_CMA_PAGES) * 100
+			/  zone_page_state(zone, NR_FREE_PAGES);
+		cma_first = (cma_free_proportion >= cma_proportion * 2
+				|| cma_free_proportion >= 50);
+	}
+	return cma_first;
+}
+#endif
 /*
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
@@ -3087,10 +3115,10 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 		 * allocating from CMA when over half of the zone's free memory
 		 * is in the CMA area.
 		 */
-		if (alloc_flags & ALLOC_CMA &&
-		    zone_page_state(zone, NR_FREE_CMA_PAGES) >
-		    zone_page_state(zone, NR_FREE_PAGES) / 2) {
-			page = __rmqueue_cma_fallback(zone, order);
+		if (migratetype == MIGRATE_MOVABLE) {
+			bool cma_first = __if_use_cma_first(zone, order, alloc_flags);
+
+			page = cma_first ? __rmqueue_cma_fallback(zone, order) : NULL;
 			if (page)
 				return page;
 		}
-- 
1.9.1


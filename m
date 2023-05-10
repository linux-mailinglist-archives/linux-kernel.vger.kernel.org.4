Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A14F6FD3D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 04:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjEJCWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 22:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbjEJCWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 22:22:00 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ED3118
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 19:21:54 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 34A2L8Yv001544;
        Wed, 10 May 2023 10:21:08 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 10 May 2023 10:21:06 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: [PATCHv4] mm: optimization on page allocation when CMA enabled
Date:   Wed, 10 May 2023 10:20:51 +0800
Message-ID: <1683685251-2059-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 34A2L8Yv001544
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
deemed as against current memory policy, that is, UNMOVABLE & RECLAIMABLE should
either stay around WATERMARK_LOW when no allocation or do reclaim via entering
slowpath)

-- Free_pages
|
|
-- WMARK_LOW
|
-- Free_CMA
|
|
--

Free_CMA/Free_pages(MB)      A(12/30)     B(12/25)     C(12/20)
fixed 1/2 ratio                 N             N           Y
this commit                     Y             Y           Y

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v2: do proportion check when zone_watermark_ok, update commit message
v3: update coding style and simplify the logic when zone_watermark_ok
v4: code update according to Roman's suggest
---
---
 mm/page_alloc.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0745aed..4719800 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3071,6 +3071,43 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 
 }
 
+#ifdef CONFIG_CMA
+/*
+ * GFP_MOVABLE allocation could drain UNMOVABLE & RECLAIMABLE page blocks via
+ * the help of CMA which makes GFP_KERNEL failed. Checking if zone_watermark_ok
+ * again without ALLOC_CMA to see if to use CMA first.
+ */
+static bool use_cma_first(struct zone *zone, unsigned int order, unsigned int alloc_flags)
+{
+	unsigned long watermark;
+	bool cma_first = false;
+
+	watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
+	/* check if GFP_MOVABLE pass previous zone_watermark_ok via the help of CMA */
+	if (zone_watermark_ok(zone, order, watermark, 0, alloc_flags & (~ALLOC_CMA))) {
+		/*
+		 * Balance movable allocations between regular and CMA areas by
+		 * allocating from CMA when over half of the zone's free memory
+		 * is in the CMA area.
+		 */
+		cma_first = (zone_page_state(zone, NR_FREE_CMA_PAGES) >
+				zone_page_state(zone, NR_FREE_PAGES) / 2);
+	} else {
+		/*
+		 * watermark failed means UNMOVABLE & RECLAIMBLE is not enough
+		 * now, we should use cma first to keep them stay around the
+		 * corresponding watermark
+		 */
+		cma_first = true;
+	}
+	return cma_first;
+}
+#else
+static bool use_cma_first(struct zone *zone, unsigned int order, unsigned int alloc_flags)
+{
+	return false;
+}
+#endif
 /*
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
@@ -3084,12 +3121,11 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 	if (IS_ENABLED(CONFIG_CMA)) {
 		/*
 		 * Balance movable allocations between regular and CMA areas by
-		 * allocating from CMA when over half of the zone's free memory
-		 * is in the CMA area.
+		 * allocating from CMA base on judging zone_watermark_ok again
+		 * to see if the latest check got pass via the help of CMA
 		 */
 		if (alloc_flags & ALLOC_CMA &&
-		    zone_page_state(zone, NR_FREE_CMA_PAGES) >
-		    zone_page_state(zone, NR_FREE_PAGES) / 2) {
+			use_cma_first(zone, order, alloc_flags)) {
 			page = __rmqueue_cma_fallback(zone, order);
 			if (page)
 				return page;
-- 
1.9.1


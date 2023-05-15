Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7BD70296A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbjEOJpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239812AbjEOJon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:44:43 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B511BDF
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:42:14 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 34F9cZ6P075415;
        Mon, 15 May 2023 17:38:35 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 15 May 2023 17:38:31 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: [Resend PATCHv2] mm: skip CMA pages when they are not available
Date:   Mon, 15 May 2023 17:38:15 +0800
Message-ID: <1684143495-12872-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 34F9cZ6P075415
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

This patch fixes unproductive reclaiming of CMA pages by skipping them when they
are not available for current context. It is arise from bellowing OOM issue, which
caused by large proportion of MIGRATE_CMA pages among free pages. There has been
commit(168676649) to fix it by trying CMA pages first instead of fallback in
rmqueue. I would like to propose another one from reclaiming perspective.

04166 < 4> [   36.172486] [03-19 10:05:52.172] ActivityManager: page allocation failure: order:0, mode:0xc00(GFP_NOIO), nodemask=(null),cpuset=foreground,mems_allowed=0
0419C < 4> [   36.189447] [03-19 10:05:52.189] DMA32: 0*4kB 447*8kB (C) 217*16kB (C) 124*32kB (C) 136*64kB (C) 70*128kB (C) 22*256kB (C) 3*512kB (C) 0*1024kB 0*2048kB 0*4096kB = 35848kB
0419D < 4> [   36.193125] [03-19 10:05:52.193] Normal: 231*4kB (UMEH) 49*8kB (MEH) 14*16kB (H) 13*32kB (H) 8*64kB (H) 2*128kB (H) 0*256kB 1*512kB (H) 0*1024kB 0*2048kB 0*4096kB = 3236kB
	......
041EA < 4> [   36.234447] [03-19 10:05:52.234] SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
041EB < 4> [   36.234455] [03-19 10:05:52.234] cache: ext4_io_end, object size: 64, buffer size: 64, default order: 0, min order: 0
041EC < 4> [   36.234459] [03-19 10:05:52.234] node 0: slabs: 53,objs: 3392, free: 0

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v2: update commit message and fix build error when CONFIG_CMA is not set
---
---
 mm/vmscan.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bd6637f..19fb445 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2225,10 +2225,16 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 	unsigned long nr_skipped[MAX_NR_ZONES] = { 0, };
 	unsigned long skipped = 0;
 	unsigned long scan, total_scan, nr_pages;
+	bool cma_cap = true;
+	struct page *page;
 	LIST_HEAD(folios_skipped);
 
 	total_scan = 0;
 	scan = 0;
+	if ((IS_ENABLED(CONFIG_CMA)) && !current_is_kswapd()
+		&& (gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE))
+		cma_cap = false;
+
 	while (scan < nr_to_scan && !list_empty(src)) {
 		struct list_head *move_to = src;
 		struct folio *folio;
@@ -2239,12 +2245,17 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 		nr_pages = folio_nr_pages(folio);
 		total_scan += nr_pages;
 
-		if (folio_zonenum(folio) > sc->reclaim_idx) {
+		page = &folio->page;
+
+		if ((folio_zonenum(folio) > sc->reclaim_idx)
+#ifdef CONFIG_CMA
+			|| (get_pageblock_migratetype(page) == MIGRATE_CMA && !cma_cap)
+#endif
+		) {
 			nr_skipped[folio_zonenum(folio)] += nr_pages;
 			move_to = &folios_skipped;
 			goto move;
 		}
-
 		/*
 		 * Do not count skipped folios because that makes the function
 		 * return with no isolated folios if the LRU mostly contains
-- 
1.9.1


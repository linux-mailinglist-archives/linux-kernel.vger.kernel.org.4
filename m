Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C9A70B529
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjEVGgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEVGgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:36:44 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0880FCF
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:36:39 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 34M6aJ7n021937;
        Mon, 22 May 2023 14:36:19 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.73.76) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 22 May 2023 14:36:18 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: [PATCHv4] mm: skip CMA pages when they are not available
Date:   Mon, 22 May 2023 14:36:03 +0800
Message-ID: <1684737363-31554-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.73.76]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 34M6aJ7n021937
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
caused by large proportion of MIGRATE_CMA pages among free pages.

[   36.172486] [03-19 10:05:52.172] ActivityManager: page allocation failure: order:0, mode:0xc00(GFP_NOIO), nodemask=(null),cpuset=foreground,mems_allowed=0
[   36.189447] [03-19 10:05:52.189] DMA32: 0*4kB 447*8kB (C) 217*16kB (C) 124*32kB (C) 136*64kB (C) 70*128kB (C) 22*256kB (C) 3*512kB (C) 0*1024kB 0*2048kB 0*4096kB = 35848kB
[   36.193125] [03-19 10:05:52.193] Normal: 231*4kB (UMEH) 49*8kB (MEH) 14*16kB (H) 13*32kB (H) 8*64kB (H) 2*128kB (H) 0*256kB 1*512kB (H) 0*1024kB 0*2048kB 0*4096kB = 3236kB
...
[   36.234447] [03-19 10:05:52.234] SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
[   36.234455] [03-19 10:05:52.234] cache: ext4_io_end, object size: 64, buffer size: 64, default order: 0, min order: 0
[   36.234459] [03-19 10:05:52.234] node 0: slabs: 53,objs: 3392, free: 0

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v2: update commit message and fix build error when CONFIG_CMA is not set
v3,v4: update code and comments
---
---
 mm/vmscan.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bd6637f..20facec 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2193,6 +2193,26 @@ static __always_inline void update_lru_sizes(struct lruvec *lruvec,
 
 }
 
+#ifdef CONFIG_CMA
+/*
+ * It is waste of effort to scan and reclaim CMA pages if it is not available
+ * for current allocation context
+ */
+static bool skip_cma(struct folio *folio, struct scan_control *sc)
+{
+	if (!current_is_kswapd() &&
+			gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE &&
+			get_pageblock_migratetype(&folio->page) == MIGRATE_CMA)
+		return true;
+	return false;
+}
+#else
+static bool skip_cma(struct folio *folio, struct scan_control *sc)
+{
+	return false;
+}
+#endif
+
 /*
  * Isolating page from the lruvec to fill in @dst list by nr_to_scan times.
  *
@@ -2239,7 +2259,8 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 		nr_pages = folio_nr_pages(folio);
 		total_scan += nr_pages;
 
-		if (folio_zonenum(folio) > sc->reclaim_idx) {
+		if (folio_zonenum(folio) > sc->reclaim_idx ||
+				skip_cma(folio, sc)) {
 			nr_skipped[folio_zonenum(folio)] += nr_pages;
 			move_to = &folios_skipped;
 			goto move;
-- 
1.9.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D775BF43C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiIUDUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIUDUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:20:01 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34435101E5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 20:19:57 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 28L3HnXk067053
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Wed, 21 Sep 2022 11:17:50 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 21 Sep 2022 11:17:49 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        <steve.kang@unisoc.com>
Subject: [PATCHv2] mm: introduce NR_BAD_PAGES and track them via kmemleak
Date:   Wed, 21 Sep 2022 11:17:26 +0800
Message-ID: <1663730246-11968-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 28L3HnXk067053
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Bad pages could be introduced by extra reference among high order pages or compound
tail pages which cause the pages failed go back to allocator and leaved as orphan
pages. Booking them down and tracking them via kmemleak.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
change of v2: add booking for bad pages
---
---
 include/linux/mmzone.h |  1 +
 mm/page_alloc.c        | 13 ++++++++++---
 mm/vmstat.c            |  1 +
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index e24b40c..11c1422 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -166,6 +166,7 @@ enum zone_stat_item {
 	NR_ZSPAGES,		/* allocated in zsmalloc */
 #endif
 	NR_FREE_CMA_PAGES,
+	NR_BAD_PAGES,
 	NR_VM_ZONE_STAT_ITEMS };
 
 enum node_stat_item {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e5486d4..a3768c96 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1408,7 +1408,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 			__memcg_kmem_uncharge_page(page, order);
 		reset_page_owner(page, order);
 		page_table_check_free(page, order);
-		return false;
+		goto err;
 	}
 
 	/*
@@ -1442,7 +1442,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	if (check_free)
 		bad += check_free_page(page);
 	if (bad)
-		return false;
+		goto err;
 
 	page_cpupid_reset_last(page);
 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
@@ -1486,6 +1486,11 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	debug_pagealloc_unmap_pages(page, 1 << order);
 
 	return true;
+err:
+	__mod_zone_page_state(page_zone(page), NR_BAD_PAGES, 1 << order);
+	kmemleak_alloc(page_address(page), PAGE_SIZE << order, 1, GFP_KERNEL);
+	return false;
+
 }
 
 #ifdef CONFIG_DEBUG_VM
@@ -1587,8 +1592,10 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			count -= nr_pages;
 			pcp->count -= nr_pages;
 
-			if (bulkfree_pcp_prepare(page))
+			if (bulkfree_pcp_prepare(page)) {
+				__mod_zone_page_state(page_zone(page), NR_BAD_PAGES, 1 << order);
 				continue;
+			}
 
 			/* MIGRATE_ISOLATE page should not go to pcplists */
 			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 90af9a8..d391352 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1193,6 +1193,7 @@ int fragmentation_index(struct zone *zone, unsigned int order)
 	"nr_zspages",
 #endif
 	"nr_free_cma",
+	"nr_bad_pages",
 
 	/* enum numa_stat_item counters */
 #ifdef CONFIG_NUMA
-- 
1.9.1


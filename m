Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EE372C8DC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbjFLOmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239376AbjFLOka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:40:30 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE21BD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:40:27 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QftwP2VmGz18M14;
        Mon, 12 Jun 2023 22:14:13 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 22:19:07 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <jgowans@amazon.com>, <yuzhao@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 1/2] mm: compaction: convert to use a folio in isolate_migratepages_block()
Date:   Mon, 12 Jun 2023 22:34:13 +0800
Message-ID: <20230612143414.186389-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Directly use a folio instead of page_folio() when page successfully
isolated (hugepage and movable page) and after folio_get_nontail_page(),
which removes several calls to compound_head(). 

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/compaction.c | 71 ++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 3398ef3a55fe..5d3f0aaa6785 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -831,6 +831,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	struct lruvec *lruvec;
 	unsigned long flags = 0;
 	struct lruvec *locked = NULL;
+	struct folio *folio = NULL;
 	struct page *page = NULL, *valid_page = NULL;
 	struct address_space *mapping;
 	unsigned long start_pfn = low_pfn;
@@ -927,7 +928,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (!valid_page && pageblock_aligned(low_pfn)) {
 			if (!isolation_suitable(cc, page)) {
 				low_pfn = end_pfn;
-				page = NULL;
+				folio = NULL;
 				goto isolate_abort;
 			}
 			valid_page = page;
@@ -959,7 +960,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 				 * Hugepage was successfully isolated and placed
 				 * on the cc->migratepages list.
 				 */
-				low_pfn += compound_nr(page) - 1;
+				folio = page_folio(page);
+				low_pfn += folio_nr_pages(folio) - 1;
 				goto isolate_success_no_list;
 			}
 
@@ -1027,8 +1029,10 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 					locked = NULL;
 				}
 
-				if (isolate_movable_page(page, mode))
+				if (isolate_movable_page(page, mode)) {
+					folio = page_folio(page);
 					goto isolate_success;
+				}
 			}
 
 			goto isolate_fail;
@@ -1039,7 +1043,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 * sure the page is not being freed elsewhere -- the
 		 * page release code relies on it.
 		 */
-		if (unlikely(!get_page_unless_zero(page)))
+		folio = folio_get_nontail_page(page);
+		if (unlikely(!folio))
 			goto isolate_fail;
 
 		/*
@@ -1047,7 +1052,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 * from long term pinning preventing it from migrating,
 		 * so avoid taking lru_lock and isolating it unnecessarily.
 		 */
-		mapping = page_mapping(page);
+		mapping = folio_mapping(folio);
 		if (!cc->alloc_contig && page_has_extra_refs(page, mapping))
 			goto isolate_fail_put;
 
@@ -1063,7 +1068,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			goto isolate_fail_put;
 
 		/* Compaction might skip unevictable pages but CMA takes them */
-		if (!(mode & ISOLATE_UNEVICTABLE) && PageUnevictable(page))
+		if (!(mode & ISOLATE_UNEVICTABLE) && folio_test_unevictable(folio))
 			goto isolate_fail_put;
 
 		/*
@@ -1072,10 +1077,10 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 * it will be able to migrate without blocking - clean pages
 		 * for the most part.  PageWriteback would require blocking.
 		 */
-		if ((mode & ISOLATE_ASYNC_MIGRATE) && PageWriteback(page))
+		if ((mode & ISOLATE_ASYNC_MIGRATE) && folio_test_writeback(folio))
 			goto isolate_fail_put;
 
-		if ((mode & ISOLATE_ASYNC_MIGRATE) && PageDirty(page)) {
+		if ((mode & ISOLATE_ASYNC_MIGRATE) && folio_test_dirty(folio)) {
 			bool migrate_dirty;
 
 			/*
@@ -1087,22 +1092,22 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			 * the page lock until after the page is removed
 			 * from the page cache.
 			 */
-			if (!trylock_page(page))
+			if (!folio_trylock(folio))
 				goto isolate_fail_put;
 
-			mapping = page_mapping(page);
+			mapping = folio_mapping(folio);
 			migrate_dirty = !mapping ||
 					mapping->a_ops->migrate_folio;
-			unlock_page(page);
+			folio_unlock(folio);
 			if (!migrate_dirty)
 				goto isolate_fail_put;
 		}
 
 		/* Try isolate the page */
-		if (!TestClearPageLRU(page))
+		if (!folio_test_clear_lru(folio))
 			goto isolate_fail_put;
 
-		lruvec = folio_lruvec(page_folio(page));
+		lruvec = folio_lruvec(folio);
 
 		/* If we already hold the lock, we can skip some rechecking */
 		if (lruvec != locked) {
@@ -1112,7 +1117,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
 			locked = lruvec;
 
-			lruvec_memcg_debug(lruvec, page_folio(page));
+			lruvec_memcg_debug(lruvec, folio);
 
 			/*
 			 * Try get exclusive access under lock. If marked for
@@ -1132,30 +1137,30 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			 * and it's on LRU. It can only be a THP so the order
 			 * is safe to read and it's 0 for tail pages.
 			 */
-			if (unlikely(PageCompound(page) && !cc->alloc_contig)) {
-				low_pfn += compound_nr(page) - 1;
-				nr_scanned += compound_nr(page) - 1;
-				SetPageLRU(page);
+			if (unlikely(folio_test_large(folio) && !cc->alloc_contig)) {
+				low_pfn += folio_nr_pages(folio) - 1;
+				nr_scanned += folio_nr_pages(folio) - 1;
+				folio_set_lru(folio);
 				goto isolate_fail_put;
 			}
 		}
 
 		/* The whole page is taken off the LRU; skip the tail pages. */
-		if (PageCompound(page))
-			low_pfn += compound_nr(page) - 1;
+		if (folio_test_large(folio))
+			low_pfn += folio_nr_pages(folio) - 1;
 
 		/* Successfully isolated */
-		del_page_from_lru_list(page, lruvec);
-		mod_node_page_state(page_pgdat(page),
-				NR_ISOLATED_ANON + page_is_file_lru(page),
-				thp_nr_pages(page));
+		lruvec_del_folio(lruvec, folio);
+		mod_node_page_state(folio_pgdat(folio),
+				NR_ISOLATED_ANON + folio_is_file_lru(folio),
+				folio_nr_pages(folio));
 
 isolate_success:
-		list_add(&page->lru, &cc->migratepages);
+		list_add(&folio->lru, &cc->migratepages);
 isolate_success_no_list:
-		cc->nr_migratepages += compound_nr(page);
-		nr_isolated += compound_nr(page);
-		nr_scanned += compound_nr(page) - 1;
+		cc->nr_migratepages += folio_nr_pages(folio);
+		nr_isolated += folio_nr_pages(folio);
+		nr_scanned += folio_nr_pages(folio) - 1;
 
 		/*
 		 * Avoid isolating too much unless this block is being
@@ -1177,7 +1182,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			unlock_page_lruvec_irqrestore(locked, flags);
 			locked = NULL;
 		}
-		put_page(page);
+		folio_put(folio);
 
 isolate_fail:
 		if (!skip_on_failure && ret != -ENOMEM)
@@ -1218,14 +1223,14 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	if (unlikely(low_pfn > end_pfn))
 		low_pfn = end_pfn;
 
-	page = NULL;
+	folio = NULL;
 
 isolate_abort:
 	if (locked)
 		unlock_page_lruvec_irqrestore(locked, flags);
-	if (page) {
-		SetPageLRU(page);
-		put_page(page);
+	if (folio) {
+		folio_set_lru(folio);
+		folio_put(folio);
 	}
 
 	/*
-- 
2.35.3


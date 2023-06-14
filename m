Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D425D73019B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245532AbjFNOVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbjFNOVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:21:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDFCCD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:21:00 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qh6yf60RmzTkfs;
        Wed, 14 Jun 2023 22:20:26 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 22:20:57 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>, <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: kill lock|unlock_page_memcg()
Date:   Wed, 14 Jun 2023 22:36:12 +0800
Message-ID: <20230614143612.62575-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Since commit c7c3dec1c9db ("mm: rmap: remove lock_page_memcg()"),
no more user, kill lock_page_memcg() and unlock_page_memcg().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst |  2 +-
 include/linux/memcontrol.h                     | 12 +-----------
 mm/filemap.c                                   |  2 +-
 mm/memcontrol.c                                | 18 ++++--------------
 mm/page-writeback.c                            |  6 +++---
 5 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 47d1d7d932a8..fabaad3fd9c2 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -297,7 +297,7 @@ Lock order is as follows::
 
   Page lock (PG_locked bit of page->flags)
     mm->page_table_lock or split pte_lock
-      lock_page_memcg (memcg->move_lock)
+      folio_memcg_lock (memcg->move_lock)
         mapping->i_pages lock
           lruvec->lru_lock.
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 00a88cf947e1..c3d3a0c09315 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -419,7 +419,7 @@ static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
  *
  * - the folio lock
  * - LRU isolation
- * - lock_page_memcg()
+ * - folio_memcg_lock()
  * - exclusive reference
  * - mem_cgroup_trylock_pages()
  *
@@ -949,8 +949,6 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 
 void folio_memcg_lock(struct folio *folio);
 void folio_memcg_unlock(struct folio *folio);
-void lock_page_memcg(struct page *page);
-void unlock_page_memcg(struct page *page);
 
 void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val);
 
@@ -1438,14 +1436,6 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 {
 }
 
-static inline void lock_page_memcg(struct page *page)
-{
-}
-
-static inline void unlock_page_memcg(struct page *page)
-{
-}
-
 static inline void folio_memcg_lock(struct folio *folio)
 {
 }
diff --git a/mm/filemap.c b/mm/filemap.c
index 294ad6de2d09..3b73101f9f86 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -117,7 +117,7 @@
  *    ->i_pages lock		(page_remove_rmap->set_page_dirty)
  *    bdi.wb->list_lock		(page_remove_rmap->set_page_dirty)
  *    ->inode->i_lock		(page_remove_rmap->set_page_dirty)
- *    ->memcg->move_lock	(page_remove_rmap->lock_page_memcg)
+ *    ->memcg->move_lock	(page_remove_rmap->folio_memcg_lock)
  *    bdi.wb->list_lock		(zap_pte_range->set_page_dirty)
  *    ->inode->i_lock		(zap_pte_range->set_page_dirty)
  *    ->private_lock		(zap_pte_range->block_dirty_folio)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 93056918e956..cf06b1c9b3bb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2148,17 +2148,12 @@ void folio_memcg_lock(struct folio *folio)
 	 * When charge migration first begins, we can have multiple
 	 * critical sections holding the fast-path RCU lock and one
 	 * holding the slowpath move_lock. Track the task who has the
-	 * move_lock for unlock_page_memcg().
+	 * move_lock for folio_memcg_unlock().
 	 */
 	memcg->move_lock_task = current;
 	memcg->move_lock_flags = flags;
 }
 
-void lock_page_memcg(struct page *page)
-{
-	folio_memcg_lock(page_folio(page));
-}
-
 static void __folio_memcg_unlock(struct mem_cgroup *memcg)
 {
 	if (memcg && memcg->move_lock_task == current) {
@@ -2186,11 +2181,6 @@ void folio_memcg_unlock(struct folio *folio)
 	__folio_memcg_unlock(folio_memcg(folio));
 }
 
-void unlock_page_memcg(struct page *page)
-{
-	folio_memcg_unlock(page_folio(page));
-}
-
 struct memcg_stock_pcp {
 	local_lock_t stock_lock;
 	struct mem_cgroup *cached; /* this never be root cgroup */
@@ -2866,7 +2856,7 @@ static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 	 *
 	 * - the page lock
 	 * - LRU isolation
-	 * - lock_page_memcg()
+	 * - folio_memcg_lock()
 	 * - exclusive reference
 	 * - mem_cgroup_trylock_pages()
 	 */
@@ -5829,7 +5819,7 @@ static int mem_cgroup_move_account(struct page *page,
 	 * with (un)charging, migration, LRU putback, or anything else
 	 * that would rely on a stable page's memory cgroup.
 	 *
-	 * Note that lock_page_memcg is a memcg lock, not a page lock,
+	 * Note that folio_memcg_lock is a memcg lock, not a page lock,
 	 * to save space. As soon as we switch page's memory cgroup to a
 	 * new memcg that isn't locked, the above state can change
 	 * concurrently again. Make sure we're truly done with it.
@@ -6320,7 +6310,7 @@ static void mem_cgroup_move_charge(void)
 {
 	lru_add_drain_all();
 	/*
-	 * Signal lock_page_memcg() to take the memcg's move_lock
+	 * Signal folio_memcg_lock() to take the memcg's move_lock
 	 * while we're moving its pages to another memcg. Then wait
 	 * for already started RCU-only updates to finish.
 	 */
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index db7943999007..1d17fb1ec863 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2597,7 +2597,7 @@ EXPORT_SYMBOL(noop_dirty_folio);
 /*
  * Helper function for set_page_dirty family.
  *
- * Caller must hold lock_page_memcg().
+ * Caller must hold folio_memcg_lock().
  *
  * NOTE: This relies on being atomic wrt interrupts.
  */
@@ -2631,7 +2631,7 @@ static void folio_account_dirtied(struct folio *folio,
 /*
  * Helper function for deaccounting dirty page without writeback.
  *
- * Caller must hold lock_page_memcg().
+ * Caller must hold folio_memcg_lock().
  */
 void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
 {
@@ -2650,7 +2650,7 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
  * If warn is true, then emit a warning if the folio is not uptodate and has
  * not been truncated.
  *
- * The caller must hold lock_page_memcg().  Most callers have the folio
+ * The caller must hold folio_memcg_lock().  Most callers have the folio
  * locked.  A few have the folio blocked from truncation through other
  * means (eg zap_vma_pages() has it mapped and is holding the page table
  * lock).  This can also be called from mark_buffer_dirty(), which I
-- 
2.41.0


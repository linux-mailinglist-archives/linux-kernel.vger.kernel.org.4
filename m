Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49025BF60E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiIUGHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiIUGHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:07:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E1B7F131
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663740425; x=1695276425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/7kWcvtAL/CcEdmW0newy/EIa1m6JlYj2jWMzPR9NMs=;
  b=IxM9Yj30WQppns6s5c08UER9lZAaSUmpYgSaGGYNmQLnnPsAz+TXDah3
   Mtel2tg8kNtpuoAu+jPxgQMyVi3YVzFuc6kWpsgojZM/C9lQ3qxdjHoeb
   d5yiBmjyURSouTj2yWLVikcwaPwZpMg4w/2+uHCU5X350Tq+yT/cSPXry
   wkQanxNqIHd7ZOx9Vt0i46xfz0vM4YOITNmiE5/rWITATvhAo8cwnNUmD
   iYv12Y/UAsRHStNajb3DeweKnv2i/xf1zKyi9EyklziLQELx+3RKbI+Vm
   DuSCd3raiyDLVTJYvPgaqF/4g1NpL8xBLh8IJcewjOWQmx4rxf64j+zvG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="280284861"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="280284861"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:07:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="649913954"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.5.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:07:01 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC 5/6] mm/migrate_pages: share more code between _unmap and _move
Date:   Wed, 21 Sep 2022 14:06:15 +0800
Message-Id: <20220921060616.73086-6-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220921060616.73086-1-ying.huang@intel.com>
References: <20220921060616.73086-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a code cleanup patch to reduce the duplicated code between the
_unmap and _move stages of migrate_pages().  No functionality change
is expected.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
---
 mm/migrate.c | 240 +++++++++++++++++++++------------------------------
 1 file changed, 100 insertions(+), 140 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 165cbbc834e2..042fa147f302 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -999,6 +999,7 @@ static void __migrate_page_extract(struct page *newpage,
 static void migrate_page_undo_page(struct page *page,
 				   int page_was_mapped,
 				   struct anon_vma *anon_vma,
+				   bool locked,
 				   struct list_head *ret)
 {
 	struct folio *folio = page_folio(page);
@@ -1007,30 +1008,77 @@ static void migrate_page_undo_page(struct page *page,
 		remove_migration_ptes(folio, folio, false);
 	if (anon_vma)
 		put_anon_vma(anon_vma);
-	unlock_page(page);
-	list_move_tail(&page->lru, ret);
+	if (locked)
+		unlock_page(page);
+	if (ret)
+		list_move_tail(&page->lru, ret);
 }
 
 static void migrate_page_undo_newpage(struct page *newpage,
+				      bool locked,
 				      free_page_t put_new_page,
 				      unsigned long private)
 {
-	unlock_page(newpage);
+	if (locked)
+		unlock_page(newpage);
 	if (put_new_page)
 		put_new_page(newpage, private);
 	else
 		put_page(newpage);
 }
 
-static int __migrate_page_unmap(struct page *page, struct page *newpage,
-				int force, enum migrate_mode mode)
+static void migrate_page_done(struct page *page,
+			      enum migrate_reason reason)
+{
+	/*
+	 * Compaction can migrate also non-LRU pages which are
+	 * not accounted to NR_ISOLATED_*. They can be recognized
+	 * as __PageMovable
+	 */
+	if (likely(!__PageMovable(page)))
+		mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
+				    page_is_file_lru(page), -thp_nr_pages(page));
+
+	if (reason != MR_MEMORY_FAILURE)
+		/* We release the page in page_handle_poison. */
+		put_page(page);
+}
+
+/* Obtain the lock on page, remove all ptes. */
+static int migrate_page_unmap(new_page_t get_new_page, free_page_t put_new_page,
+			      unsigned long private, struct page *page,
+			      struct page **newpagep, int force,
+			      enum migrate_mode mode, enum migrate_reason reason,
+			      struct list_head *ret)
 {
 	struct folio *folio = page_folio(page);
-	int rc = -EAGAIN;
+	int rc = MIGRATEPAGE_UNMAP;
+	struct page *newpage = NULL;
 	int page_was_mapped = 0;
 	struct anon_vma *anon_vma = NULL;
 	bool is_lru = !__PageMovable(page);
+	bool locked = false;
+	bool newpage_locked = false;
+
+	if (!thp_migration_supported() && PageTransHuge(page))
+		return -ENOSYS;
 
+	if (page_count(page) == 1) {
+		/* Page was freed from under us. So we are done. */
+		ClearPageActive(page);
+		ClearPageUnevictable(page);
+		/* free_pages_prepare() will clear PG_isolated. */
+		list_del(&page->lru);
+		migrate_page_done(page, reason);
+		return MIGRATEPAGE_SUCCESS;
+	}
+
+	newpage = get_new_page(page, private);
+	if (!newpage)
+		return -ENOMEM;
+	*newpagep = newpage;
+
+	rc = -EAGAIN;
 	if (!trylock_page(page)) {
 		if (!force || mode == MIGRATE_ASYNC)
 			goto out;
@@ -1053,6 +1101,7 @@ static int __migrate_page_unmap(struct page *page, struct page *newpage,
 
 		lock_page(page);
 	}
+	locked = true;
 
 	if (PageWriteback(page)) {
 		/*
@@ -1067,10 +1116,10 @@ static int __migrate_page_unmap(struct page *page, struct page *newpage,
 			break;
 		default:
 			rc = -EBUSY;
-			goto out_unlock;
+			goto out;
 		}
 		if (!force)
-			goto out_unlock;
+			goto out;
 		wait_on_page_writeback(page);
 	}
 
@@ -1100,7 +1149,8 @@ static int __migrate_page_unmap(struct page *page, struct page *newpage,
 	 * This is much like races on refcount of oldpage: just don't BUG().
 	 */
 	if (unlikely(!trylock_page(newpage)))
-		goto out_unlock;
+		goto out;
+	newpage_locked = true;
 
 	if (unlikely(!is_lru)) {
 		__migrate_page_record(newpage, page_was_mapped, anon_vma);
@@ -1123,7 +1173,7 @@ static int __migrate_page_unmap(struct page *page, struct page *newpage,
 		VM_BUG_ON_PAGE(PageAnon(page), page);
 		if (page_has_private(page)) {
 			try_to_free_buffers(folio);
-			goto out_unlock_both;
+			goto out;
 		}
 	} else if (page_mapped(page)) {
 		/* Establish migration ptes */
@@ -1141,20 +1191,28 @@ static int __migrate_page_unmap(struct page *page, struct page *newpage,
 	if (page_was_mapped)
 		remove_migration_ptes(folio, folio, false);
 
-out_unlock_both:
-	unlock_page(newpage);
-out_unlock:
-	/* Drop an anon_vma reference if we took one */
-	if (anon_vma)
-		put_anon_vma(anon_vma);
-	unlock_page(page);
 out:
+	/*
+	 * A page that has not been migrated will have kept its
+	 * references and be restored.
+	 */
+	/* restore the page to right list. */
+	if (rc != -EAGAIN)
+                ret = NULL;
+
+	migrate_page_undo_page(page, page_was_mapped, anon_vma, locked, ret);
+	if (newpage)
+		migrate_page_undo_newpage(newpage, newpage_locked,
+					  put_new_page, private);
 
 	return rc;
 }
 
-static int __migrate_page_move(struct page *page, struct page *newpage,
-			       enum migrate_mode mode)
+/* Migrate the page to the newly allocated page in newpage. */
+static int migrate_page_move(free_page_t put_new_page, unsigned long private,
+			     struct page *page, struct page *newpage,
+			     enum migrate_mode mode, enum migrate_reason reason,
+			     struct list_head *ret)
 {
 	struct folio *folio = page_folio(page);
 	struct folio *dst = page_folio(newpage);
@@ -1165,9 +1223,10 @@ static int __migrate_page_move(struct page *page, struct page *newpage,
 	__migrate_page_extract(newpage, &page_was_mapped, &anon_vma);
 
 	rc = move_to_new_folio(dst, folio, mode);
+	if (rc)
+		goto out;
 
-	if (rc != -EAGAIN)
-		list_del(&newpage->lru);
+	list_del(&newpage->lru);
 	/*
 	 * When successful, push newpage to LRU immediately: so that if it
 	 * turns out to be an mlocked page, remove_migration_ptes() will
@@ -1177,139 +1236,40 @@ static int __migrate_page_move(struct page *page, struct page *newpage,
 	 * unsuccessful, and other cases when a page has been temporarily
 	 * isolated from the unevictable LRU: but this case is the easiest.
 	 */
-	if (rc == MIGRATEPAGE_SUCCESS) {
-		lru_cache_add(newpage);
-		if (page_was_mapped)
-			lru_add_drain();
-	}
-
-	if (rc == -EAGAIN) {
-		__migrate_page_record(newpage, page_was_mapped, anon_vma);
-		return rc;
-	}
-
+	lru_cache_add(newpage);
 	if (page_was_mapped)
-		remove_migration_ptes(folio,
-			rc == MIGRATEPAGE_SUCCESS ? dst : folio, false);
+		lru_add_drain();
 
+	if (page_was_mapped)
+		remove_migration_ptes(folio, dst, false);
 	unlock_page(newpage);
-	/* Drop an anon_vma reference if we took one */
-	if (anon_vma)
-		put_anon_vma(anon_vma);
-	unlock_page(page);
+	set_page_owner_migrate_reason(newpage, reason);
 	/*
 	 * If migration is successful, decrease refcount of the newpage,
 	 * which will not free the page because new page owner increased
 	 * refcounter.
 	 */
-	if (rc == MIGRATEPAGE_SUCCESS)
-		put_page(newpage);
-
-	return rc;
-}
+	put_page(newpage);
 
-static void migrate_page_done(struct page *page,
-			      enum migrate_reason reason)
-{
 	/*
-	 * Compaction can migrate also non-LRU pages which are
-	 * not accounted to NR_ISOLATED_*. They can be recognized
-	 * as __PageMovable
+	 * A page that has been migrated has all references removed
+	 * and will be freed.
 	 */
-	if (likely(!__PageMovable(page)))
-		mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
-				    page_is_file_lru(page), -thp_nr_pages(page));
-
-	if (reason != MR_MEMORY_FAILURE)
-		/* We release the page in page_handle_poison. */
-		put_page(page);
-}
-
-/* Obtain the lock on page, remove all ptes. */
-static int migrate_page_unmap(new_page_t get_new_page, free_page_t put_new_page,
-			      unsigned long private, struct page *page,
-			      struct page **newpagep, int force,
-			      enum migrate_mode mode, enum migrate_reason reason,
-			      struct list_head *ret)
-{
-	int rc = MIGRATEPAGE_UNMAP;
-	struct page *newpage = NULL;
-
-	if (!thp_migration_supported() && PageTransHuge(page))
-		return -ENOSYS;
-
-	if (page_count(page) == 1) {
-		/* Page was freed from under us. So we are done. */
-		ClearPageActive(page);
-		ClearPageUnevictable(page);
-		/* free_pages_prepare() will clear PG_isolated. */
-		list_del(&page->lru);
-		migrate_page_done(page, reason);
-		return MIGRATEPAGE_SUCCESS;
-	}
-
-	newpage = get_new_page(page, private);
-	if (!newpage)
-		return -ENOMEM;
-	*newpagep = newpage;
-
-	newpage->private = 0;
-	rc = __migrate_page_unmap(page, newpage, force, mode);
-	if (rc == MIGRATEPAGE_UNMAP)
-		return rc;
-
-	/*
-	 * A page that has not been migrated will have kept its
-	 * references and be restored.
-	 */
-	/* restore the page to right list. */
-	if (rc != -EAGAIN)
-		list_move_tail(&page->lru, ret);
-
-	if (put_new_page)
-		put_new_page(newpage, private);
-	else
-		put_page(newpage);
+	list_del(&page->lru);
+	migrate_page_undo_page(page, 0, anon_vma, true, NULL);
+	migrate_page_done(page, reason);
 
 	return rc;
-}
 
-/* Migrate the page to the newly allocated page in newpage. */
-static int migrate_page_move(free_page_t put_new_page, unsigned long private,
-			     struct page *page, struct page *newpage,
-			     enum migrate_mode mode, enum migrate_reason reason,
-			     struct list_head *ret)
-{
-	int rc;
-
-	rc = __migrate_page_move(page, newpage, mode);
-	if (rc == MIGRATEPAGE_SUCCESS)
-		set_page_owner_migrate_reason(newpage, reason);
-
-	if (rc != -EAGAIN) {
-		/*
-		 * A page that has been migrated has all references
-		 * removed and will be freed. A page that has not been
-		 * migrated will have kept its references and be restored.
-		 */
-		list_del_init(&page->lru);
+out:
+	if (rc == -EAGAIN) {
+		__migrate_page_record(newpage, page_was_mapped, anon_vma);
+		return rc;
 	}
 
-	/*
-	 * If migration is successful, releases reference grabbed during
-	 * isolation. Otherwise, restore the page to right list unless
-	 * we want to retry.
-	 */
-	if (rc == MIGRATEPAGE_SUCCESS) {
-		migrate_page_done(page, reason);
-	} else if (rc != -EAGAIN) {
-		list_add_tail(&page->lru, ret);
-
-		if (put_new_page)
-			put_new_page(newpage, private);
-		else
-			put_page(newpage);
-	}
+	migrate_page_undo_page(page, page_was_mapped, anon_vma, true, ret);
+	list_del(&newpage->lru);
+	migrate_page_undo_newpage(newpage, true, put_new_page, private);
 
 	return rc;
 }
@@ -1763,9 +1723,9 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 
 		__migrate_page_extract(newpage, &page_was_mapped, &anon_vma);
 		migrate_page_undo_page(page, page_was_mapped, anon_vma,
-				       &ret_pages);
+				       true, &ret_pages);
 		list_del(&newpage->lru);
-		migrate_page_undo_newpage(newpage, put_new_page, private);
+		migrate_page_undo_newpage(newpage, true, put_new_page, private);
 		newpage = newpage2;
 		newpage2 = list_next_entry(newpage, lru);
 	}
-- 
2.35.1


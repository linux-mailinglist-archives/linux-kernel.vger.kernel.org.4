Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF81B6945F2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjBMMgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjBMMgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:36:02 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FD31ABE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676291743; x=1707827743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LJBQcFuwCDNelXry1gr5Vxbs1ZO8LcRLXJ+2vWMUK9M=;
  b=VHnjtZjsqF2UoB4JZ/iM6za1J48H2+D3PL9c5qCdZoWw8IhuJzDcbsLB
   m2CIjkCxCAFkqndno8glNziyBQPqKFt1LGHvN8+5Tz6Q0mi1fLEEnK5Rn
   m3KDcNqjl/j9WRZZgrUIuy5CsXU/fnm9qe96SVd6D6rmy5lJPnsZKceMx
   kLHma9ZdRY62mnVPSWAq7ykI8q+stmX5IusheLKuZ04elFykRDfBItP+N
   VErDiG9nrnZMjUCYDjYQrRiQzPqy0x1vnxLJf3nGgmDRTKcKt3bZ/e7lt
   SXkNqH33zcwUPFzfYyC/R+eng6VSudK1IYf8WcWc4jcxu5TkC0m9oCv6N
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="310513291"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="310513291"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 04:35:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="646366659"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="646366659"
Received: from changxin-mobl2.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.171])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 04:35:39 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH -v5 7/9] migrate_pages: share more code between _unmap and _move
Date:   Mon, 13 Feb 2023 20:34:42 +0800
Message-Id: <20230213123444.155149-8-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230213123444.155149-1-ying.huang@intel.com>
References: <20230213123444.155149-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Cc: Bharata B Rao <bharata@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Xin Hao <xhao@linux.alibaba.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/migrate.c | 207 +++++++++++++++++++++------------------------------
 1 file changed, 85 insertions(+), 122 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 0c7488ebe248..00713ccb6643 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1055,6 +1055,7 @@ static void __migrate_folio_extract(struct folio *dst,
 static void migrate_folio_undo_src(struct folio *src,
 				   int page_was_mapped,
 				   struct anon_vma *anon_vma,
+				   bool locked,
 				   struct list_head *ret)
 {
 	if (page_was_mapped)
@@ -1062,16 +1063,20 @@ static void migrate_folio_undo_src(struct folio *src,
 	/* Drop an anon_vma reference if we took one */
 	if (anon_vma)
 		put_anon_vma(anon_vma);
-	folio_unlock(src);
-	list_move_tail(&src->lru, ret);
+	if (locked)
+		folio_unlock(src);
+	if (ret)
+		list_move_tail(&src->lru, ret);
 }
 
 /* Restore the destination folio to the original state upon failure */
 static void migrate_folio_undo_dst(struct folio *dst,
+				   bool locked,
 				   free_page_t put_new_page,
 				   unsigned long private)
 {
-	folio_unlock(dst);
+	if (locked)
+		folio_unlock(dst);
 	if (put_new_page)
 		put_new_page(&dst->page, private);
 	else
@@ -1096,13 +1101,42 @@ static void migrate_folio_done(struct folio *src,
 		folio_put(src);
 }
 
-static int __migrate_folio_unmap(struct folio *src, struct folio *dst, int force,
-				 bool avoid_force_lock, enum migrate_mode mode)
+/* Obtain the lock on page, remove all ptes. */
+static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page,
+			       unsigned long private, struct folio *src,
+			       struct folio **dstp, int force, bool avoid_force_lock,
+			       enum migrate_mode mode, enum migrate_reason reason,
+			       struct list_head *ret)
 {
+	struct folio *dst;
 	int rc = -EAGAIN;
+	struct page *newpage = NULL;
 	int page_was_mapped = 0;
 	struct anon_vma *anon_vma = NULL;
 	bool is_lru = !__PageMovable(&src->page);
+	bool locked = false;
+	bool dst_locked = false;
+
+	if (!thp_migration_supported() && folio_test_transhuge(src))
+		return -ENOSYS;
+
+	if (folio_ref_count(src) == 1) {
+		/* Folio was freed from under us. So we are done. */
+		folio_clear_active(src);
+		folio_clear_unevictable(src);
+		/* free_pages_prepare() will clear PG_isolated. */
+		list_del(&src->lru);
+		migrate_folio_done(src, reason);
+		return MIGRATEPAGE_SUCCESS;
+	}
+
+	newpage = get_new_page(&src->page, private);
+	if (!newpage)
+		return -ENOMEM;
+	dst = page_folio(newpage);
+	*dstp = dst;
+
+	dst->private = NULL;
 
 	if (!folio_trylock(src)) {
 		if (!force || mode == MIGRATE_ASYNC)
@@ -1137,6 +1171,7 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst, int force
 
 		folio_lock(src);
 	}
+	locked = true;
 
 	if (folio_test_writeback(src)) {
 		/*
@@ -1151,10 +1186,10 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst, int force
 			break;
 		default:
 			rc = -EBUSY;
-			goto out_unlock;
+			goto out;
 		}
 		if (!force)
-			goto out_unlock;
+			goto out;
 		folio_wait_writeback(src);
 	}
 
@@ -1184,7 +1219,8 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst, int force
 	 * This is much like races on refcount of oldpage: just don't BUG().
 	 */
 	if (unlikely(!folio_trylock(dst)))
-		goto out_unlock;
+		goto out;
+	dst_locked = true;
 
 	if (unlikely(!is_lru)) {
 		__migrate_folio_record(dst, page_was_mapped, anon_vma);
@@ -1206,7 +1242,7 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst, int force
 	if (!src->mapping) {
 		if (folio_test_private(src)) {
 			try_to_free_buffers(src);
-			goto out_unlock_both;
+			goto out;
 		}
 	} else if (folio_mapped(src)) {
 		/* Establish migration ptes */
@@ -1221,73 +1257,25 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst, int force
 		return MIGRATEPAGE_UNMAP;
 	}
 
-	if (page_was_mapped)
-		remove_migration_ptes(src, src, false);
-
-out_unlock_both:
-	folio_unlock(dst);
-out_unlock:
-	/* Drop an anon_vma reference if we took one */
-	if (anon_vma)
-		put_anon_vma(anon_vma);
-	folio_unlock(src);
 out:
-
-	return rc;
-}
-
-/* Obtain the lock on page, remove all ptes. */
-static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page,
-			       unsigned long private, struct folio *src,
-			       struct folio **dstp, int force, bool avoid_force_lock,
-			       enum migrate_mode mode, enum migrate_reason reason,
-			       struct list_head *ret)
-{
-	struct folio *dst;
-	int rc = MIGRATEPAGE_UNMAP;
-	struct page *newpage = NULL;
-
-	if (!thp_migration_supported() && folio_test_transhuge(src))
-		return -ENOSYS;
-
-	if (folio_ref_count(src) == 1) {
-		/* Folio was freed from under us. So we are done. */
-		folio_clear_active(src);
-		folio_clear_unevictable(src);
-		/* free_pages_prepare() will clear PG_isolated. */
-		list_del(&src->lru);
-		migrate_folio_done(src, reason);
-		return MIGRATEPAGE_SUCCESS;
-	}
-
-	newpage = get_new_page(&src->page, private);
-	if (!newpage)
-		return -ENOMEM;
-	dst = page_folio(newpage);
-	*dstp = dst;
-
-	dst->private = NULL;
-	rc = __migrate_folio_unmap(src, dst, force, avoid_force_lock, mode);
-	if (rc == MIGRATEPAGE_UNMAP)
-		return rc;
-
 	/*
 	 * A folio that has not been unmapped will be restored to
 	 * right list unless we want to retry.
 	 */
-	if (rc != -EAGAIN && rc != -EDEADLOCK)
-		list_move_tail(&src->lru, ret);
+	if (rc == -EAGAIN || rc == -EDEADLOCK)
+		ret = NULL;
 
-	if (put_new_page)
-		put_new_page(&dst->page, private);
-	else
-		folio_put(dst);
+	migrate_folio_undo_src(src, page_was_mapped, anon_vma, locked, ret);
+	migrate_folio_undo_dst(dst, dst_locked, put_new_page, private);
 
 	return rc;
 }
 
-static int __migrate_folio_move(struct folio *src, struct folio *dst,
-				enum migrate_mode mode)
+/* Migrate the folio to the newly allocated folio in dst. */
+static int migrate_folio_move(free_page_t put_new_page, unsigned long private,
+			      struct folio *src, struct folio *dst,
+			      enum migrate_mode mode, enum migrate_reason reason,
+			      struct list_head *ret)
 {
 	int rc;
 	int page_was_mapped = 0;
@@ -1300,12 +1288,8 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
 	list_del(&dst->lru);
 
 	rc = move_to_new_folio(dst, src, mode);
-
-	if (rc == -EAGAIN) {
-		list_add(&dst->lru, prev);
-		__migrate_folio_record(dst, page_was_mapped, anon_vma);
-		return rc;
-	}
+	if (rc)
+		goto out;
 
 	if (unlikely(!is_lru))
 		goto out_unlock_both;
@@ -1319,70 +1303,49 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
 	 * unsuccessful, and other cases when a page has been temporarily
 	 * isolated from the unevictable LRU: but this case is the easiest.
 	 */
-	if (rc == MIGRATEPAGE_SUCCESS) {
-		folio_add_lru(dst);
-		if (page_was_mapped)
-			lru_add_drain();
-	}
+	folio_add_lru(dst);
+	if (page_was_mapped)
+		lru_add_drain();
 
 	if (page_was_mapped)
-		remove_migration_ptes(src,
-			rc == MIGRATEPAGE_SUCCESS ? dst : src, false);
+		remove_migration_ptes(src, dst, false);
 
 out_unlock_both:
 	folio_unlock(dst);
-	/* Drop an anon_vma reference if we took one */
-	if (anon_vma)
-		put_anon_vma(anon_vma);
-	folio_unlock(src);
+	set_page_owner_migrate_reason(&dst->page, reason);
 	/*
 	 * If migration is successful, decrease refcount of dst,
 	 * which will not free the page because new page owner increased
 	 * refcounter.
 	 */
-	if (rc == MIGRATEPAGE_SUCCESS)
-		folio_put(dst);
-
-	return rc;
-}
-
-/* Migrate the folio to the newly allocated folio in dst. */
-static int migrate_folio_move(free_page_t put_new_page, unsigned long private,
-			      struct folio *src, struct folio *dst,
-			      enum migrate_mode mode, enum migrate_reason reason,
-			      struct list_head *ret)
-{
-	int rc;
-
-	rc = __migrate_folio_move(src, dst, mode);
-	if (rc == MIGRATEPAGE_SUCCESS)
-		set_page_owner_migrate_reason(&dst->page, reason);
-
-	if (rc != -EAGAIN) {
-		/*
-		 * A folio that has been migrated has all references
-		 * removed and will be freed. A folio that has not been
-		 * migrated will have kept its references and be restored.
-		 */
-		list_del(&src->lru);
-	}
+	folio_put(dst);
 
 	/*
-	 * If migration is successful, releases reference grabbed during
-	 * isolation. Otherwise, restore the folio to right list unless
-	 * we want to retry.
+	 * A folio that has been migrated has all references removed
+	 * and will be freed.
 	 */
-	if (rc == MIGRATEPAGE_SUCCESS) {
-		migrate_folio_done(src, reason);
-	} else if (rc != -EAGAIN) {
-		list_add_tail(&src->lru, ret);
+	list_del(&src->lru);
+	/* Drop an anon_vma reference if we took one */
+	if (anon_vma)
+		put_anon_vma(anon_vma);
+	folio_unlock(src);
+	migrate_folio_done(src, reason);
 
-		if (put_new_page)
-			put_new_page(&dst->page, private);
-		else
-			folio_put(dst);
+	return rc;
+out:
+	/*
+	 * A folio that has not been migrated will be restored to
+	 * right list unless we want to retry.
+	 */
+	if (rc == -EAGAIN) {
+		list_add(&dst->lru, prev);
+		__migrate_folio_record(dst, page_was_mapped, anon_vma);
+		return rc;
 	}
 
+	migrate_folio_undo_src(src, page_was_mapped, anon_vma, true, ret);
+	migrate_folio_undo_dst(dst, true, put_new_page, private);
+
 	return rc;
 }
 
@@ -1918,9 +1881,9 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 
 		__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
 		migrate_folio_undo_src(folio, page_was_mapped, anon_vma,
-				       ret_folios);
+				       true, ret_folios);
 		list_del(&dst->lru);
-		migrate_folio_undo_dst(dst, put_new_page, private);
+		migrate_folio_undo_dst(dst, true, put_new_page, private);
 		dst = dst2;
 		dst2 = list_next_entry(dst, lru);
 	}
-- 
2.35.1


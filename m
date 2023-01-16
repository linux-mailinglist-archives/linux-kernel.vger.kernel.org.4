Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6765E66B779
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 07:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjAPGca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 01:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjAPGbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 01:31:52 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC6365BB
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 22:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673850694; x=1705386694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c08JPciVGbfSOCD62Qp15TGPybC907KLoZLpS/qN1Zg=;
  b=JEyOnmkCuANGG2LCuyl4NVOstnYxK0llZZoVMb+WERDBqvMDYwSvAp9U
   7rYwKsT+iWuqBt3uOCUsgosJmB7Dl0AXnjcvAOWo8+BAbIUaFUgse5jZ0
   NX54hBWk+rzKRVtFBbhK8VCYzpl6QtUta0+FQtIzxcZiSyUDJid7YF3U3
   dFnrsPou2WcB2w8d7xA9ccSJMWL7PbmrfimKv5r81MaO312DMNwxvBVh4
   s3xUVJ3lrgebe4bp/ggCwELvdMOeunUQ4w4ZSNhYi3+EnzLtzsFgq3thT
   abm0uRZXSn1twfiEUDQk9dGr8wG3NxPZkwaXe76AnJ8CoEdBqP5IE3/7j
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="388892210"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="388892210"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 22:31:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="801286692"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="801286692"
Received: from tiangeng-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.220])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 22:31:30 -0800
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
        haoxin <xhao@linux.alibaba.com>, Minchan Kim <minchan@kernel.org>
Subject: [PATCH -v3 7/9] migrate_pages: share more code between _unmap and _move
Date:   Mon, 16 Jan 2023 14:30:55 +0800
Message-Id: <20230116063057.653862-8-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230116063057.653862-1-ying.huang@intel.com>
References: <20230116063057.653862-1-ying.huang@intel.com>
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
Cc: Bharata B Rao <bharata@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: haoxin <xhao@linux.alibaba.com>
Cc: Minchan Kim <minchan@kernel.org>
---
 mm/migrate.c | 205 +++++++++++++++++++++------------------------------
 1 file changed, 82 insertions(+), 123 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index a25966233923..ef9f126e21ed 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1037,6 +1037,7 @@ static void __migrate_folio_extract(struct folio *dst,
 static void migrate_folio_undo_src(struct folio *src,
 				   int page_was_mapped,
 				   struct anon_vma *anon_vma,
+				   bool locked,
 				   struct list_head *ret)
 {
 	if (page_was_mapped)
@@ -1044,16 +1045,20 @@ static void migrate_folio_undo_src(struct folio *src,
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
@@ -1078,13 +1083,42 @@ static void migrate_folio_done(struct folio *src,
 		folio_put(src);
 }
 
-static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
-				 int force, bool force_lock, enum migrate_mode mode)
+/* Obtain the lock on page, remove all ptes. */
+static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page,
+			       unsigned long private, struct folio *src,
+			       struct folio **dstp, int force, bool force_lock,
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
@@ -1119,6 +1153,7 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
 
 		folio_lock(src);
 	}
+	locked = true;
 
 	if (folio_test_writeback(src)) {
 		/*
@@ -1133,10 +1168,10 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
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
 
@@ -1166,7 +1201,8 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
 	 * This is much like races on refcount of oldpage: just don't BUG().
 	 */
 	if (unlikely(!folio_trylock(dst)))
-		goto out_unlock;
+		goto out;
+	dst_locked = true;
 
 	if (unlikely(!is_lru)) {
 		__migrate_folio_record(dst, page_was_mapped, anon_vma);
@@ -1188,7 +1224,7 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
 	if (!src->mapping) {
 		if (folio_test_private(src)) {
 			try_to_free_buffers(src);
-			goto out_unlock_both;
+			goto out;
 		}
 	} else if (folio_mapped(src)) {
 		/* Establish migration ptes */
@@ -1203,74 +1239,26 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
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
-			       struct folio **dstp, int force, bool force_lock,
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
-	rc = __migrate_folio_unmap(src, dst, force, force_lock, mode);
-	if (rc == MIGRATEPAGE_UNMAP)
-		return rc;
-
 	/*
 	 * A page that has not been migrated will have kept its
 	 * references and be restored.
 	 */
 	/* restore the folio to right list. */
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
@@ -1280,9 +1268,10 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
 	__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
 
 	rc = move_to_new_folio(dst, src, mode);
+	if (rc)
+		goto out;
 
-	if (rc != -EAGAIN)
-		list_del(&dst->lru);
+	list_del(&dst->lru);
 
 	if (unlikely(!is_lru))
 		goto out_unlock_both;
@@ -1296,75 +1285,45 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
 	 * unsuccessful, and other cases when a page has been temporarily
 	 * isolated from the unevictable LRU: but this case is the easiest.
 	 */
-	if (rc == MIGRATEPAGE_SUCCESS) {
-		folio_add_lru(dst);
-		if (page_was_mapped)
-			lru_add_drain();
-	}
-
-	if (rc == -EAGAIN) {
-		__migrate_folio_record(dst, page_was_mapped, anon_vma);
-		return rc;
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
+	 * A page that has been migrated has all references removed
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
+	if (rc == -EAGAIN) {
+		__migrate_folio_record(dst, page_was_mapped, anon_vma);
+		return rc;
 	}
 
+	migrate_folio_undo_src(src, page_was_mapped, anon_vma, true, ret);
+	list_del(&dst->lru);
+	migrate_folio_undo_dst(dst, true, put_new_page, private);
+
 	return rc;
 }
 
@@ -1896,9 +1855,9 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 
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


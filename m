Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B817666B776
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 07:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjAPGbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 01:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjAPGbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 01:31:34 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4952DA271
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 22:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673850684; x=1705386684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=owp2StX07FtXCpFgHDVBdQMId5O0fSuu5EeccMqJEM0=;
  b=Wm4J3j2ftVSSv5u7iglRlkvpzvZlVfz7JZ/QKb767dNJ2fznCbd1ELFT
   FVETVX21C3RNzWuLYHsJE0eyBQVrFHgP83AH8/Lu2Weo6wpo6ku5YZLzB
   OKrof6et4YBzVJahZ6pjB3Si6V00ggFnJjSMilhpcfiC7jRMVqoa2ipUO
   m/lYzjFUPxFKsBSyove62ROBQVv4Jz79xRbPfTpoCMkAVKKJK/sHfrvih
   JYEZAjGqeSfSrgVKocKiKgzyiGTDead5HeowQbkbk5vcbGF5uQOVyQBRe
   DQ8cbIuLgeE/JqzAnlnIbdMqgaPYWecIB1hTv86+ZwxvhKvvM5T/Wvu5g
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="388892163"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="388892163"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 22:31:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="801286654"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="801286654"
Received: from tiangeng-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.220])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 22:31:20 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>, Minchan Kim <minchan@kernel.org>
Subject: [PATCH -v3 4/9] migrate_pages: split unmap_and_move() to _unmap() and _move()
Date:   Mon, 16 Jan 2023 14:30:52 +0800
Message-Id: <20230116063057.653862-5-ying.huang@intel.com>
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

This is a preparation patch to batch the folio unmapping and moving.

In this patch, unmap_and_move() is split to migrate_folio_unmap() and
migrate_folio_move().  So, we can batch _unmap() and _move() in
different loops later.  To pass some information between unmap and
move, the original unused dst->mapping and dst->private are used.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: haoxin <xhao@linux.alibaba.com>
Cc: Minchan Kim <minchan@kernel.org>
---
 include/linux/migrate.h |   1 +
 mm/migrate.c            | 170 ++++++++++++++++++++++++++++++----------
 2 files changed, 130 insertions(+), 41 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 3ef77f52a4f0..7376074f2e1e 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -18,6 +18,7 @@ struct migration_target_control;
  * - zero on page migration success;
  */
 #define MIGRATEPAGE_SUCCESS		0
+#define MIGRATEPAGE_UNMAP		1
 
 /**
  * struct movable_operations - Driver page migration
diff --git a/mm/migrate.c b/mm/migrate.c
index 9a667039c34c..0428449149f4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1009,11 +1009,53 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 	return rc;
 }
 
-static int __unmap_and_move(struct folio *src, struct folio *dst,
+/*
+ * To record some information during migration, we uses some unused
+ * fields (mapping and private) of struct folio of the newly allocated
+ * destination folio.  This is safe because nobody is using them
+ * except us.
+ */
+static void __migrate_folio_record(struct folio *dst,
+				   unsigned long page_was_mapped,
+				   struct anon_vma *anon_vma)
+{
+	dst->mapping = (void *)anon_vma;
+	dst->private = (void *)page_was_mapped;
+}
+
+static void __migrate_folio_extract(struct folio *dst,
+				   int *page_was_mappedp,
+				   struct anon_vma **anon_vmap)
+{
+	*anon_vmap = (void *)dst->mapping;
+	*page_was_mappedp = (unsigned long)dst->private;
+	dst->mapping = NULL;
+	dst->private = NULL;
+}
+
+/* Cleanup src folio upon migration success */
+static void migrate_folio_done(struct folio *src,
+			       enum migrate_reason reason)
+{
+	/*
+	 * Compaction can migrate also non-LRU pages which are
+	 * not accounted to NR_ISOLATED_*. They can be recognized
+	 * as __PageMovable
+	 */
+	if (likely(!__folio_test_movable(src)))
+		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
+				    folio_is_file_lru(src), -folio_nr_pages(src));
+
+	if (reason != MR_MEMORY_FAILURE)
+		/* We release the page in page_handle_poison. */
+		folio_put(src);
+}
+
+static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
 				int force, enum migrate_mode mode)
 {
 	int rc = -EAGAIN;
-	bool page_was_mapped = false;
+	int page_was_mapped = 0;
 	struct anon_vma *anon_vma = NULL;
 	bool is_lru = !__PageMovable(&src->page);
 
@@ -1089,8 +1131,8 @@ static int __unmap_and_move(struct folio *src, struct folio *dst,
 		goto out_unlock;
 
 	if (unlikely(!is_lru)) {
-		rc = move_to_new_folio(dst, src, mode);
-		goto out_unlock_both;
+		__migrate_folio_record(dst, page_was_mapped, anon_vma);
+		return MIGRATEPAGE_UNMAP;
 	}
 
 	/*
@@ -1115,11 +1157,42 @@ static int __unmap_and_move(struct folio *src, struct folio *dst,
 		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
 			       !folio_test_ksm(src) && !anon_vma, src);
 		try_to_migrate(src, 0);
-		page_was_mapped = true;
+		page_was_mapped = 1;
 	}
 
-	if (!folio_mapped(src))
-		rc = move_to_new_folio(dst, src, mode);
+	if (!folio_mapped(src)) {
+		__migrate_folio_record(dst, page_was_mapped, anon_vma);
+		return MIGRATEPAGE_UNMAP;
+	}
+
+	if (page_was_mapped)
+		remove_migration_ptes(src, src, false);
+
+out_unlock_both:
+	folio_unlock(dst);
+out_unlock:
+	/* Drop an anon_vma reference if we took one */
+	if (anon_vma)
+		put_anon_vma(anon_vma);
+	folio_unlock(src);
+out:
+
+	return rc;
+}
+
+static int __migrate_folio_move(struct folio *src, struct folio *dst,
+				enum migrate_mode mode)
+{
+	int rc;
+	int page_was_mapped = 0;
+	struct anon_vma *anon_vma = NULL;
+	bool is_lru = !__PageMovable(&src->page);
+
+	__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
+
+	rc = move_to_new_folio(dst, src, mode);
+	if (unlikely(!is_lru))
+		goto out_unlock_both;
 
 	/*
 	 * When successful, push dst to LRU immediately: so that if it
@@ -1142,12 +1215,10 @@ static int __unmap_and_move(struct folio *src, struct folio *dst,
 
 out_unlock_both:
 	folio_unlock(dst);
-out_unlock:
 	/* Drop an anon_vma reference if we took one */
 	if (anon_vma)
 		put_anon_vma(anon_vma);
 	folio_unlock(src);
-out:
 	/*
 	 * If migration is successful, decrease refcount of dst,
 	 * which will not free the page because new page owner increased
@@ -1159,19 +1230,15 @@ static int __unmap_and_move(struct folio *src, struct folio *dst,
 	return rc;
 }
 
-/*
- * Obtain the lock on folio, remove all ptes and migrate the folio
- * to the newly allocated folio in dst.
- */
-static int unmap_and_move(new_page_t get_new_page,
-				   free_page_t put_new_page,
-				   unsigned long private, struct folio *src,
-				   int force, enum migrate_mode mode,
-				   enum migrate_reason reason,
-				   struct list_head *ret)
+/* Obtain the lock on page, remove all ptes. */
+static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page,
+			       unsigned long private, struct folio *src,
+			       struct folio **dstp, int force,
+			       enum migrate_mode mode, enum migrate_reason reason,
+			       struct list_head *ret)
 {
 	struct folio *dst;
-	int rc = MIGRATEPAGE_SUCCESS;
+	int rc = MIGRATEPAGE_UNMAP;
 	struct page *newpage = NULL;
 
 	if (!thp_migration_supported() && folio_test_transhuge(src))
@@ -1182,20 +1249,50 @@ static int unmap_and_move(new_page_t get_new_page,
 		folio_clear_active(src);
 		folio_clear_unevictable(src);
 		/* free_pages_prepare() will clear PG_isolated. */
-		goto out;
+		list_del(&src->lru);
+		migrate_folio_done(src, reason);
+		return MIGRATEPAGE_SUCCESS;
 	}
 
 	newpage = get_new_page(&src->page, private);
 	if (!newpage)
 		return -ENOMEM;
 	dst = page_folio(newpage);
+	*dstp = dst;
 
 	dst->private = NULL;
-	rc = __unmap_and_move(src, dst, force, mode);
+	rc = __migrate_folio_unmap(src, dst, force, mode);
+	if (rc == MIGRATEPAGE_UNMAP)
+		return rc;
+
+	/*
+	 * A page that has not been migrated will have kept its
+	 * references and be restored.
+	 */
+	/* restore the folio to right list. */
+	if (rc != -EAGAIN)
+		list_move_tail(&src->lru, ret);
+
+	if (put_new_page)
+		put_new_page(&dst->page, private);
+	else
+		folio_put(dst);
+
+	return rc;
+}
+
+/* Migrate the folio to the newly allocated folio in dst. */
+static int migrate_folio_move(free_page_t put_new_page, unsigned long private,
+			      struct folio *src, struct folio *dst,
+			      enum migrate_mode mode, enum migrate_reason reason,
+			      struct list_head *ret)
+{
+	int rc;
+
+	rc = __migrate_folio_move(src, dst, mode);
 	if (rc == MIGRATEPAGE_SUCCESS)
 		set_page_owner_migrate_reason(&dst->page, reason);
 
-out:
 	if (rc != -EAGAIN) {
 		/*
 		 * A folio that has been migrated has all references
@@ -1211,20 +1308,7 @@ static int unmap_and_move(new_page_t get_new_page,
 	 * we want to retry.
 	 */
 	if (rc == MIGRATEPAGE_SUCCESS) {
-		/*
-		 * Compaction can migrate also non-LRU folios which are
-		 * not accounted to NR_ISOLATED_*. They can be recognized
-		 * as __folio_test_movable
-		 */
-		if (likely(!__folio_test_movable(src)))
-			mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
-					folio_is_file_lru(src), -folio_nr_pages(src));
-
-		if (reason != MR_MEMORY_FAILURE)
-			/*
-			 * We release the folio in page_handle_poison.
-			 */
-			folio_put(src);
+		migrate_folio_done(src, reason);
 	} else {
 		if (rc != -EAGAIN)
 			list_add_tail(&src->lru, ret);
@@ -1516,7 +1600,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	int pass = 0;
 	bool is_large = false;
 	bool is_thp = false;
-	struct folio *folio, *folio2;
+	struct folio *folio, *folio2, *dst = NULL;
 	int rc, nr_pages;
 	LIST_HEAD(split_folios);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
@@ -1543,9 +1627,13 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 
 			cond_resched();
 
-			rc = unmap_and_move(get_new_page, put_new_page,
-					    private, folio, pass > 2, mode,
-					    reason, ret_folios);
+			rc = migrate_folio_unmap(get_new_page, put_new_page, private,
+						 folio, &dst, pass > 2, mode,
+						 reason, ret_folios);
+			if (rc == MIGRATEPAGE_UNMAP)
+				rc = migrate_folio_move(put_new_page, private,
+							folio, dst, mode,
+							reason, ret_folios);
 			/*
 			 * The rules are:
 			 *	Success: folio will be freed
-- 
2.35.1


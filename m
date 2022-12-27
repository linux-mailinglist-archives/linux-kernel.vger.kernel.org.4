Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0692656644
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 01:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiL0AaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 19:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiL0A3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 19:29:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E1B6276
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 16:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672100978; x=1703636978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IlUDC48YZthy4iB9f936bSNt5z2BK2NSyqzBAjVYcv8=;
  b=MfIFT1GN/KfQX/KXvbAGSkrSnO4NUFE9QRR8lgsUE/UD35lRDVxZdpJT
   4+A1ZgYm9wZiY5Sh4Ov42G4RSZyW6ARx9O9JdkzCIzEStyvPgAicqplEQ
   dEYwhqB3GNhIauTujU9R5bY5zwNf6KBegzLyGz1LQ52scWpfh0pTa1Oez
   gEkzHUrBPlQYn95jXRM+l56Ij2wJayOI+4g+kxXs3H0F42JbJNEknOmb1
   1GgFTjVrVb6+VDr5NtKHz5vrIeEB6PwscOFT3TotjX5udnI7Fj5UGA/bZ
   MJIG53aTgbni/8otsZfCm4Gkol6/JTwR+d6sf+10cKGJ3JU/8uptNUtlB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="322597245"
X-IronPort-AV: E=Sophos;i="5.96,277,1665471600"; 
   d="scan'208";a="322597245"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 16:29:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="760172216"
X-IronPort-AV: E=Sophos;i="5.96,277,1665471600"; 
   d="scan'208";a="760172216"
Received: from yyang3-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.254.212.104])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 16:29:34 -0800
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
        haoxin <xhao@linux.alibaba.com>
Subject: [PATCH 4/8] migrate_pages: split unmap_and_move() to _unmap() and _move()
Date:   Tue, 27 Dec 2022 08:28:55 +0800
Message-Id: <20221227002859.27740-5-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221227002859.27740-1-ying.huang@intel.com>
References: <20221227002859.27740-1-ying.huang@intel.com>
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
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: haoxin <xhao@linux.alibaba.com>
---
 include/linux/migrate.h |   1 +
 mm/migrate.c            | 162 +++++++++++++++++++++++++++++-----------
 2 files changed, 121 insertions(+), 42 deletions(-)

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
index 97ea0737ab2b..e2383b430932 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1009,11 +1009,29 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 	return rc;
 }
 
-static int __unmap_and_move(struct folio *src, struct folio *dst,
+static void __migrate_folio_record(struct folio *dst,
+				   unsigned long page_was_mapped,
+				   struct anon_vma *anon_vma)
+{
+	dst->mapping = (struct address_space *)anon_vma;
+	dst->private = (void *)page_was_mapped;
+}
+
+static void __migrate_folio_extract(struct folio *dst,
+				   int *page_was_mappedp,
+				   struct anon_vma **anon_vmap)
+{
+	*anon_vmap = (struct anon_vma *)dst->mapping;
+	*page_was_mappedp = (unsigned long)dst->private;
+	dst->mapping = NULL;
+	dst->private = NULL;
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
 
@@ -1089,8 +1107,8 @@ static int __unmap_and_move(struct folio *src, struct folio *dst,
 		goto out_unlock;
 
 	if (unlikely(!is_lru)) {
-		rc = move_to_new_folio(dst, src, mode);
-		goto out_unlock_both;
+		__migrate_folio_record(dst, page_was_mapped, anon_vma);
+		return MIGRATEPAGE_UNMAP;
 	}
 
 	/*
@@ -1115,11 +1133,40 @@ static int __unmap_and_move(struct folio *src, struct folio *dst,
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
+
+	__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
+
+	rc = move_to_new_folio(dst, src, mode);
 
 	/*
 	 * When successful, push dst to LRU immediately: so that if it
@@ -1140,14 +1187,11 @@ static int __unmap_and_move(struct folio *src, struct folio *dst,
 		remove_migration_ptes(src,
 			rc == MIGRATEPAGE_SUCCESS ? dst : src, false);
 
-out_unlock_both:
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
@@ -1159,19 +1203,32 @@ static int __unmap_and_move(struct folio *src, struct folio *dst,
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
@@ -1182,20 +1239,50 @@ static int unmap_and_move(new_page_t get_new_page,
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
@@ -1211,20 +1298,7 @@ static int unmap_and_move(new_page_t get_new_page,
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
@@ -1499,7 +1573,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	int pass = 0;
 	bool is_large = false;
 	bool is_thp = false;
-	struct folio *folio, *folio2;
+	struct folio *folio, *folio2, *dst = NULL;
 	int rc, nr_pages;
 	LIST_HEAD(split_folios);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
@@ -1524,9 +1598,13 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 
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


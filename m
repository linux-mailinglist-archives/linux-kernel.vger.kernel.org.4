Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416B15BF60B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiIUGHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIUGG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:06:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8D67C1CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663740416; x=1695276416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MrLzv8Dvhk4JFF3omMcaNuJrUuoPDcPH4H019ndQy9c=;
  b=k4io90mjWC6QzuWQ0f0mTwofgix6LVg/LnPbk9DjTpKSkxkRFqG8ZOgO
   bl+eaGCEI4kGsb8KIgIkiWREEFWrrrncYgNC4piZf8Nt0Ds0EU1zdRSAp
   7vrTCmCtW6GOf7QlHe5otyOjH7TfAgnUIRXC3igy7jQgmdUZ3QyKOlJf0
   Uu3hOxmcPxC/CKMGRwppzVw/yiHEsR7Yzaw2MhgHmnqILmAio+m95ZEg+
   8BqnZDsL7NiDL7mCNQhkct3PTqvUmaj/cde8pI+vDhoTNZyDaz2fMJP0F
   GqXz1jkyi2POqextZAoCJKQird2ly6ehTpVLO0BI/hvlLhS8Kvwt51/cG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="280284839"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="280284839"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:06:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="649913857"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.5.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:06:53 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC 2/6] mm/migrate_pages: split unmap_and_move() to _unmap() and _move()
Date:   Wed, 21 Sep 2022 14:06:12 +0800
Message-Id: <20220921060616.73086-3-ying.huang@intel.com>
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

This is a preparation patch to batch the page unmapping and moving
for the normal pages and THP.

In this patch, unmap_and_move() is split to migrate_page_unmap() and
migrate_page_move().  So, we can batch _unmap() and _move() in
different loops later.  To pass some information between unmap and
move, the original unused newpage->mapping and newpage->private are
used.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
---
 mm/migrate.c | 164 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 122 insertions(+), 42 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 117134f1c6dc..4a81e0bfdbcd 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -976,13 +976,32 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 	return rc;
 }
 
-static int __unmap_and_move(struct page *page, struct page *newpage,
+static void __migrate_page_record(struct page *newpage,
+				  int page_was_mapped,
+				  struct anon_vma *anon_vma)
+{
+	newpage->mapping = (struct address_space *)anon_vma;
+	newpage->private = page_was_mapped;
+}
+
+static void __migrate_page_extract(struct page *newpage,
+				   int *page_was_mappedp,
+				   struct anon_vma **anon_vmap)
+{
+	*anon_vmap = (struct anon_vma *)newpage->mapping;
+	*page_was_mappedp = newpage->private;
+	newpage->mapping = NULL;
+	newpage->private = 0;
+}
+
+#define MIGRATEPAGE_UNMAP		1
+
+static int __migrate_page_unmap(struct page *page, struct page *newpage,
 				int force, enum migrate_mode mode)
 {
 	struct folio *folio = page_folio(page);
-	struct folio *dst = page_folio(newpage);
 	int rc = -EAGAIN;
-	bool page_was_mapped = false;
+	int page_was_mapped = 0;
 	struct anon_vma *anon_vma = NULL;
 	bool is_lru = !__PageMovable(page);
 
@@ -1058,8 +1077,8 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 		goto out_unlock;
 
 	if (unlikely(!is_lru)) {
-		rc = move_to_new_folio(dst, folio, mode);
-		goto out_unlock_both;
+		__migrate_page_record(newpage, page_was_mapped, anon_vma);
+		return MIGRATEPAGE_UNMAP;
 	}
 
 	/*
@@ -1085,11 +1104,41 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 		VM_BUG_ON_PAGE(PageAnon(page) && !PageKsm(page) && !anon_vma,
 				page);
 		try_to_migrate(folio, 0);
-		page_was_mapped = true;
+		page_was_mapped = 1;
+	}
+
+	if (!page_mapped(page)) {
+		__migrate_page_record(newpage, page_was_mapped, anon_vma);
+		return MIGRATEPAGE_UNMAP;
 	}
 
-	if (!page_mapped(page))
-		rc = move_to_new_folio(dst, folio, mode);
+	if (page_was_mapped)
+		remove_migration_ptes(folio, folio, false);
+
+out_unlock_both:
+	unlock_page(newpage);
+out_unlock:
+	/* Drop an anon_vma reference if we took one */
+	if (anon_vma)
+		put_anon_vma(anon_vma);
+	unlock_page(page);
+out:
+
+	return rc;
+}
+
+static int __migrate_page_move(struct page *page, struct page *newpage,
+			       enum migrate_mode mode)
+{
+	struct folio *folio = page_folio(page);
+	struct folio *dst = page_folio(newpage);
+	int rc;
+	int page_was_mapped = 0;
+	struct anon_vma *anon_vma = NULL;
+
+	__migrate_page_extract(newpage, &page_was_mapped, &anon_vma);
+
+	rc = move_to_new_folio(dst, folio, mode);
 
 	/*
 	 * When successful, push newpage to LRU immediately: so that if it
@@ -1110,14 +1159,11 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 		remove_migration_ptes(folio,
 			rc == MIGRATEPAGE_SUCCESS ? dst : folio, false);
 
-out_unlock_both:
 	unlock_page(newpage);
-out_unlock:
 	/* Drop an anon_vma reference if we took one */
 	if (anon_vma)
 		put_anon_vma(anon_vma);
 	unlock_page(page);
-out:
 	/*
 	 * If migration is successful, decrease refcount of the newpage,
 	 * which will not free the page because new page owner increased
@@ -1129,18 +1175,31 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 	return rc;
 }
 
-/*
- * Obtain the lock on page, remove all ptes and migrate the page
- * to the newly allocated page in newpage.
- */
-static int unmap_and_move(new_page_t get_new_page,
-				   free_page_t put_new_page,
-				   unsigned long private, struct page *page,
-				   int force, enum migrate_mode mode,
-				   enum migrate_reason reason,
-				   struct list_head *ret)
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
-	int rc = MIGRATEPAGE_SUCCESS;
+	int rc = MIGRATEPAGE_UNMAP;
 	struct page *newpage = NULL;
 
 	if (!thp_migration_supported() && PageTransHuge(page))
@@ -1151,19 +1210,48 @@ static int unmap_and_move(new_page_t get_new_page,
 		ClearPageActive(page);
 		ClearPageUnevictable(page);
 		/* free_pages_prepare() will clear PG_isolated. */
-		goto out;
+		list_del(&page->lru);
+		migrate_page_done(page, reason);
+		return MIGRATEPAGE_SUCCESS;
 	}
 
 	newpage = get_new_page(page, private);
 	if (!newpage)
 		return -ENOMEM;
+	*newpagep = newpage;
 
-	newpage->private = 0;
-	rc = __unmap_and_move(page, newpage, force, mode);
+	rc = __migrate_page_unmap(page, newpage, force, mode);
+	if (rc == MIGRATEPAGE_UNMAP)
+		return rc;
+
+	/*
+	 * A page that has not been migrated will have kept its
+	 * references and be restored.
+	 */
+	/* restore the page to right list. */
+	if (rc != -EAGAIN)
+		list_move_tail(&page->lru, ret);
+
+	if (put_new_page)
+		put_new_page(newpage, private);
+	else
+		put_page(newpage);
+
+	return rc;
+}
+
+/* Migrate the page to the newly allocated page in newpage. */
+static int migrate_page_move(free_page_t put_new_page, unsigned long private,
+			     struct page *page, struct page *newpage,
+			     enum migrate_mode mode, enum migrate_reason reason,
+			     struct list_head *ret)
+{
+	int rc;
+
+	rc = __migrate_page_move(page, newpage, mode);
 	if (rc == MIGRATEPAGE_SUCCESS)
 		set_page_owner_migrate_reason(newpage, reason);
 
-out:
 	if (rc != -EAGAIN) {
 		/*
 		 * A page that has been migrated has all references
@@ -1179,20 +1267,7 @@ static int unmap_and_move(new_page_t get_new_page,
 	 * we want to retry.
 	 */
 	if (rc == MIGRATEPAGE_SUCCESS) {
-		/*
-		 * Compaction can migrate also non-LRU pages which are
-		 * not accounted to NR_ISOLATED_*. They can be recognized
-		 * as __PageMovable
-		 */
-		if (likely(!__PageMovable(page)))
-			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
-					page_is_file_lru(page), -thp_nr_pages(page));
-
-		if (reason != MR_MEMORY_FAILURE)
-			/*
-			 * We release the page in page_handle_poison.
-			 */
-			put_page(page);
+		migrate_page_done(page, reason);
 	} else {
 		if (rc != -EAGAIN)
 			list_add_tail(&page->lru, ret);
@@ -1405,6 +1480,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	int pass = 0;
 	bool is_thp = false;
 	struct page *page;
+	struct page *newpage = NULL;
 	struct page *page2;
 	int rc, nr_subpages;
 	LIST_HEAD(ret_pages);
@@ -1493,9 +1569,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			if (PageHuge(page))
 				continue;
 
-			rc = unmap_and_move(get_new_page, put_new_page,
-						private, page, pass > 2, mode,
+			rc = migrate_page_unmap(get_new_page, put_new_page, private,
+						page, &newpage, pass > 2, mode,
 						reason, &ret_pages);
+			if (rc == MIGRATEPAGE_UNMAP)
+				rc = migrate_page_move(put_new_page, private,
+						       page, newpage, mode,
+						       reason, &ret_pages);
 			/*
 			 * The rules are:
 			 *	Success: page will be freed
-- 
2.35.1


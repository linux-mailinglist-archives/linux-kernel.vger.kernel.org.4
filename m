Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DCF656647
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 01:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiL0Aan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 19:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiL0A3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 19:29:54 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B85126F9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 16:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672100987; x=1703636987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vd3x7uf76BZx4AuXVaHyrVdNIQHfuHN+j/7ggUNEXew=;
  b=FuOQiOXknbxkHHl5wg2Cjic+Ln6l1+wZLZzV5nQshTYJesSKn1Azz0rt
   YeVyfRLh5dw0HMykHtMd9sYco8W7dXqNzFTONsjdyGchbNbtYw/H2nS1y
   RSg57LghW43pc/1PgSu7DF2OGbhMmtYrar+RVmMHS3g+TDo74yYBxEfwN
   a/KFnh+5SqYhqJa8sBB1nb5So4Gxt4bxlvQe6wjazHnoaQ9+DnQx0lavh
   JAF/t4GAFEsBQ8FTmAFQ7EfiEVeVTVeFdkTb/c/l5ANK00FVSfvCO5KbX
   cVxkyD3OnQSZzhiywtc9XOVVvDaBo1SdfA/lo6n6NYB3eSFUkwcuKewCe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="322597269"
X-IronPort-AV: E=Sophos;i="5.96,277,1665471600"; 
   d="scan'208";a="322597269"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 16:29:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="760172236"
X-IronPort-AV: E=Sophos;i="5.96,277,1665471600"; 
   d="scan'208";a="760172236"
Received: from yyang3-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.254.212.104])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 16:29:42 -0800
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
Subject: [PATCH 6/8] migrate_pages: move migrate_folio_done() and migrate_folio_unmap()
Date:   Tue, 27 Dec 2022 08:28:57 +0800
Message-Id: <20221227002859.27740-7-ying.huang@intel.com>
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

Just move the position of 2 functions.  There's no any functionality
change.  This is to make it easier to review the next patch via
putting code near its position in the next patch.

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
 mm/migrate.c | 136 +++++++++++++++++++++++++--------------------------
 1 file changed, 68 insertions(+), 68 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index dd68c3de3da8..70b987391296 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1051,6 +1051,23 @@ static void migrate_folio_undo_dst(struct folio *dst,
 		folio_put(dst);
 }
 
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
 static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
 				 int force, bool force_lock, enum migrate_mode mode)
 {
@@ -1186,6 +1203,57 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
 	return rc;
 }
 
+/* Obtain the lock on page, remove all ptes. */
+static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page,
+			       unsigned long private, struct folio *src,
+			       struct folio **dstp, int force, bool force_lock,
+			       enum migrate_mode mode, enum migrate_reason reason,
+			       struct list_head *ret)
+{
+	struct folio *dst;
+	int rc = MIGRATEPAGE_UNMAP;
+	struct page *newpage = NULL;
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
+	rc = __migrate_folio_unmap(src, dst, force, force_lock, mode);
+	if (rc == MIGRATEPAGE_UNMAP)
+		return rc;
+
+	/*
+	 * A page that has not been migrated will have kept its
+	 * references and be restored.
+	 */
+	/* restore the folio to right list. */
+	if (rc != -EAGAIN && rc != -EDEADLOCK)
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
 static int __migrate_folio_move(struct folio *src, struct folio *dst,
 				enum migrate_mode mode)
 {
@@ -1239,74 +1307,6 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
 	return rc;
 }
 
-static void migrate_folio_done(struct folio *src,
-			       enum migrate_reason reason)
-{
-	/*
-	 * Compaction can migrate also non-LRU pages which are
-	 * not accounted to NR_ISOLATED_*. They can be recognized
-	 * as __PageMovable
-	 */
-	if (likely(!__folio_test_movable(src)))
-		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
-				    folio_is_file_lru(src), -folio_nr_pages(src));
-
-	if (reason != MR_MEMORY_FAILURE)
-		/* We release the page in page_handle_poison. */
-		folio_put(src);
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
-	/*
-	 * A page that has not been migrated will have kept its
-	 * references and be restored.
-	 */
-	/* restore the folio to right list. */
-	if (rc != -EAGAIN && rc != -EDEADLOCK)
-		list_move_tail(&src->lru, ret);
-
-	if (put_new_page)
-		put_new_page(&dst->page, private);
-	else
-		folio_put(dst);
-
-	return rc;
-}
-
 /* Migrate the folio to the newly allocated folio in dst. */
 static int migrate_folio_move(free_page_t put_new_page, unsigned long private,
 			      struct folio *src, struct folio *dst,
-- 
2.35.1


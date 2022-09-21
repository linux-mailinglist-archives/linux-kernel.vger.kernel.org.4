Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A664C5BF60C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiIUGHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiIUGHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:07:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563CF7C1CA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663740419; x=1695276419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vMOxlk+IH0y/jJD/DO08c91l+llx8vnqZ8FEqWsnej4=;
  b=m+YMZEJA4Et195RUlu9WpNWq7bHU9pVayHONR0AwDaZdFFvFVmRb/IJI
   DTn4Pm2PW5U4sIJK8TnRKpppEY0+j6DTtqLREUjUmhOdrsMVEyiPBTXGB
   22QEzVdM3KuErVO37s/kayGCWEMUZgCQ9gutb6EOSWCmcKsAEgVqqE32E
   tpycN1djDqJsqsjVWhgTvJaZ3oHvhhJPmwlo50Xyu9E5Po4CzY6uvDLVm
   VfgCpFZQCVV8nEoXkNkPs0qcKA+UZcrgs4eMljX27i0BQfnlUtik0xAgQ
   BJOSbjNHyMWtUiag8utm8TAZJY9a5rPxUP8A7bL+WK0H/pWE3FxhYlo05
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="280284848"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="280284848"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:06:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="649913874"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.5.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:06:56 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC 3/6] mm/migrate_pages: restrict number of pages to migrate in batch
Date:   Wed, 21 Sep 2022 14:06:13 +0800
Message-Id: <20220921060616.73086-4-ying.huang@intel.com>
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

If we had batched the page unmapping, all pages to be migrated would
be unmapped before copying the contents and flags of the pages.  If
the number of pages that were passed to migrate_pages() was too large,
too many pages would be unmapped.  Then, the execution of their
processes would be stopped for too long time.  For example,
migrate_pages() syscall will call migrate_pages() with all pages of a
process.  To avoid this possible issue, in this patch, we restrict the
number of pages to be migrated to be no more than HPAGE_PMD_NR.  That
is, the influence is at the same level of THP migration.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
---
 mm/migrate.c | 93 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 67 insertions(+), 26 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 4a81e0bfdbcd..1077af858e36 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1439,32 +1439,7 @@ static inline int try_split_thp(struct page *page, struct list_head *split_pages
 	return rc;
 }
 
-/*
- * migrate_pages - migrate the pages specified in a list, to the free pages
- *		   supplied as the target for the page migration
- *
- * @from:		The list of pages to be migrated.
- * @get_new_page:	The function used to allocate free pages to be used
- *			as the target of the page migration.
- * @put_new_page:	The function used to free target pages if migration
- *			fails, or NULL if no special handling is necessary.
- * @private:		Private data to be passed on to get_new_page()
- * @mode:		The migration mode that specifies the constraints for
- *			page migration, if any.
- * @reason:		The reason for page migration.
- * @ret_succeeded:	Set to the number of normal pages migrated successfully if
- *			the caller passes a non-NULL pointer.
- *
- * The function returns after 10 attempts or if no pages are movable any more
- * because the list has become empty or no retryable pages exist any more.
- * It is caller's responsibility to call putback_movable_pages() to return pages
- * to the LRU or free list only if ret != 0.
- *
- * Returns the number of {normal page, THP, hugetlb} that were not migrated, or
- * an error code. The number of THP splits will be considered as the number of
- * non-migrated THP, no matter how many subpages of the THP are migrated successfully.
- */
-int migrate_pages(struct list_head *from, new_page_t get_new_page,
+static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 		free_page_t put_new_page, unsigned long private,
 		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
 {
@@ -1709,6 +1684,72 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	return rc;
 }
 
+/*
+ * migrate_pages - migrate the pages specified in a list, to the free pages
+ *		   supplied as the target for the page migration
+ *
+ * @from:		The list of pages to be migrated.
+ * @get_new_page:	The function used to allocate free pages to be used
+ *			as the target of the page migration.
+ * @put_new_page:	The function used to free target pages if migration
+ *			fails, or NULL if no special handling is necessary.
+ * @private:		Private data to be passed on to get_new_page()
+ * @mode:		The migration mode that specifies the constraints for
+ *			page migration, if any.
+ * @reason:		The reason for page migration.
+ * @ret_succeeded:	Set to the number of normal pages migrated successfully if
+ *			the caller passes a non-NULL pointer.
+ *
+ * The function returns after 10 attempts or if no pages are movable any more
+ * because the list has become empty or no retryable pages exist any more.
+ * It is caller's responsibility to call putback_movable_pages() to return pages
+ * to the LRU or free list only if ret != 0.
+ *
+ * Returns the number of {normal page, THP, hugetlb} that were not migrated, or
+ * an error code. The number of THP splits will be considered as the number of
+ * non-migrated THP, no matter how many subpages of the THP are migrated successfully.
+ */
+int migrate_pages(struct list_head *from, new_page_t get_new_page,
+		free_page_t put_new_page, unsigned long private,
+		enum migrate_mode mode, int reason, unsigned int *pret_succeeded)
+{
+	int rc, rc_gether = 0;
+	int ret_succeeded, ret_succeeded_gether = 0;
+	int nr_pages;
+	struct page *page;
+	LIST_HEAD(pagelist);
+	LIST_HEAD(ret_pages);
+
+again:
+	nr_pages = 0;
+	list_for_each_entry(page, from, lru) {
+		nr_pages += compound_nr(page);
+		if (nr_pages > HPAGE_PMD_NR)
+			break;
+	}
+	if (nr_pages > HPAGE_PMD_NR)
+		list_cut_before(&pagelist, from, &page->lru);
+	else
+		list_splice_init(from, &pagelist);
+	rc = migrate_pages_batch(&pagelist, get_new_page, put_new_page, private,
+				 mode, reason, &ret_succeeded);
+	ret_succeeded_gether += ret_succeeded;
+	list_splice_tail_init(&pagelist, &ret_pages);
+	if (rc == -ENOMEM) {
+		rc_gether = rc;
+		goto out;
+	}
+	rc_gether += rc;
+	if (!list_empty(from))
+		goto again;
+out:
+	if (pret_succeeded)
+		*pret_succeeded = ret_succeeded_gether;
+	list_splice(&ret_pages, from);
+
+	return rc_gether;
+}
+
 struct page *alloc_migration_target(struct page *page, unsigned long private)
 {
 	struct folio *folio = page_folio(page);
-- 
2.35.1


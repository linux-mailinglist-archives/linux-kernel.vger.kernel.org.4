Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCE061449A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 07:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKAGWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 02:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiKAGWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 02:22:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C992816595
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 23:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667283765; x=1698819765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ajt5ZtY5XYTdbQzMvGZFbN1JM+lcIE+fMp58Ij3Laiw=;
  b=R9apRPGVb/NyK+JTqkqlDwuKj8Gb4fegeUoNBasoZ9zeZSASdGkrO4+Z
   j0K2DdjQ7QK/eICue6hF0DszSaDAu2jFwXfzoJlNEeYKZ3UyEP6hZEcYY
   sO4x5DupoRHG3X4MdU5CWcXlwgonhKBS7rSi8Y+9aEQsnR3+8HmAEnwd9
   3Q97+r3UBf8cAc0YzkEtx7I6/zOnSMnxRks7Pb2Akq8Fj3i2x2f8I48BR
   lTYH6xoDu582ZAel6D4gjvIIyM35Vj0kiBmzQwS1e4qInZ913m9xtzFNr
   Jc6bs8InbVtqesIEL59Du5DLbDO6VVR1yz/lahd+T2PR7VUfOk+kUMWF/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="395388692"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="395388692"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 23:22:45 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="878998370"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="878998370"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.69])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 23:22:43 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC 2/2] migrate: convert migrate_pages() to use folios
Date:   Tue,  1 Nov 2022 14:21:37 +0800
Message-Id: <20221101062137.83649-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221101062137.83649-1-ying.huang@intel.com>
References: <20221101062137.83649-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quite straightforward, the page functions are converted to
corresponding folio functions.  Same for comments.

THP specific code are converted to be large folio.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
---
 mm/migrate.c | 215 ++++++++++++++++++++++++++-------------------------
 1 file changed, 108 insertions(+), 107 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index e625fd84b824..c4777d8ca41e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1373,229 +1373,230 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	return rc;
 }
 
-static inline int try_split_thp(struct page *page, struct list_head *split_pages)
+static inline int try_split_folio(struct folio *folio, struct list_head *split_folios)
 {
 	int rc;
 
-	lock_page(page);
-	rc = split_huge_page_to_list(page, split_pages);
-	unlock_page(page);
+	folio_lock(folio);
+	rc = split_folio_to_list(folio, split_folios);
+	folio_unlock(folio);
 	if (!rc)
-		list_move_tail(&page->lru, split_pages);
+		list_move_tail(&folio->lru, split_folios);
 
 	return rc;
 }
 
 /*
- * migrate_pages - migrate the pages specified in a list, to the free pages
+ * migrate_pages - migrate the folios specified in a list, to the free folios
  *		   supplied as the target for the page migration
  *
- * @from:		The list of pages to be migrated.
- * @get_new_page:	The function used to allocate free pages to be used
- *			as the target of the page migration.
- * @put_new_page:	The function used to free target pages if migration
+ * @from:		The list of folios to be migrated.
+ * @get_new_page:	The function used to allocate free folios to be used
+ *			as the target of the folio migration.
+ * @put_new_page:	The function used to free target folios if migration
  *			fails, or NULL if no special handling is necessary.
  * @private:		Private data to be passed on to get_new_page()
  * @mode:		The migration mode that specifies the constraints for
- *			page migration, if any.
- * @reason:		The reason for page migration.
- * @ret_succeeded:	Set to the number of normal pages migrated successfully if
+ *			folio migration, if any.
+ * @reason:		The reason for folio migration.
+ * @ret_succeeded:	Set to the number of folios migrated successfully if
  *			the caller passes a non-NULL pointer.
  *
- * The function returns after 10 attempts or if no pages are movable any more
- * because the list has become empty or no retryable pages exist any more.
- * It is caller's responsibility to call putback_movable_pages() to return pages
+ * The function returns after 10 attempts or if no folios are movable any more
+ * because the list has become empty or no retryable folios exist any more.
+ * It is caller's responsibility to call putback_movable_pages() to return folios
  * to the LRU or free list only if ret != 0.
  *
- * Returns the number of {normal page, THP, hugetlb} that were not migrated, or
- * an error code. The number of THP splits will be considered as the number of
- * non-migrated THP, no matter how many subpages of the THP are migrated successfully.
+ * Returns the number of {normal folio, large folio, hugetlb} that were not
+ * migrated, or an error code. The number of large folio splits will be
+ * considered as the number of non-migrated large folio, no matter how many
+ * split folios of the large folio are migrated successfully.
  */
 int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		free_page_t put_new_page, unsigned long private,
 		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
 {
 	int retry = 1;
-	int thp_retry = 1;
+	int large_retry = 1;
 	int nr_failed = 0;
 	int nr_failed_pages = 0;
 	int nr_retry_pages = 0;
 	int nr_succeeded = 0;
-	int nr_thp_succeeded = 0;
-	int nr_thp_failed = 0;
-	int nr_thp_split = 0;
+	int nr_large_succeeded = 0;
+	int nr_large_failed = 0;
+	int nr_split = 0;
 	int pass = 0;
-	bool is_thp = false;
-	struct page *page;
-	struct page *page2;
-	int rc, nr_subpages;
-	LIST_HEAD(ret_pages);
-	LIST_HEAD(thp_split_pages);
+	bool is_large = false;
+	struct folio *folio, *folio2;
+	int rc, nr_pages;
+	LIST_HEAD(ret_folios);
+	LIST_HEAD(split_folios);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
-	bool no_subpage_counting = false;
+	bool no_split_folio_counting = false;
 
 	trace_mm_migrate_pages_start(mode, reason);
 
-thp_subpage_migration:
-	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
+split_folio_migration:
+	for (pass = 0; pass < 10 && (retry || large_retry); pass++) {
 		retry = 0;
-		thp_retry = 0;
+		large_retry = 0;
 		nr_retry_pages = 0;
 
-		list_for_each_entry_safe(page, page2, from, lru) {
+		list_for_each_entry_safe(folio, folio2, from, lru) {
 			/*
-			 * THP statistics is based on the source huge page.
-			 * Capture required information that might get lost
-			 * during migration.
+			 * Large folio statistics is based on the source large
+			 * folio. Capture required information that might get
+			 * lost during migration.
 			 */
-			is_thp = PageTransHuge(page) && !PageHuge(page);
-			nr_subpages = compound_nr(page);
+			is_large = folio_test_large(folio) && !PageHuge(&folio->page);
+			nr_pages = folio_nr_pages(folio);
 			cond_resched();
 
-			if (PageHuge(page))
+			if (PageHuge(&folio->page))
 				rc = unmap_and_move_huge_page(get_new_page,
-						put_new_page, private, page,
-						pass > 2, mode, reason,
-						&ret_pages);
+						put_new_page, private,
+						&folio->page, pass > 2, mode,
+						reason,
+						&ret_folios);
 			else
 				rc = unmap_and_move(get_new_page, put_new_page,
-						private, page_folio(page), pass > 2, mode,
-						reason, &ret_pages);
+						private, folio, pass > 2, mode,
+						reason, &ret_folios);
 			/*
 			 * The rules are:
-			 *	Success: non hugetlb page will be freed, hugetlb
-			 *		 page will be put back
+			 *	Success: non hugetlb folio will be freed, hugetlb
+			 *		 folio will be put back
 			 *	-EAGAIN: stay on the from list
 			 *	-ENOMEM: stay on the from list
 			 *	-ENOSYS: stay on the from list
-			 *	Other errno: put on ret_pages list then splice to
+			 *	Other errno: put on ret_folios list then splice to
 			 *		     from list
 			 */
 			switch(rc) {
 			/*
-			 * THP migration might be unsupported or the
-			 * allocation could've failed so we should
-			 * retry on the same page with the THP split
-			 * to base pages.
+			 * Large folio migration might be unsupported or
+			 * the allocation could've failed so we should retry
+			 * on the same folio with the large folio split
+			 * to normal folios.
 			 *
-			 * Sub-pages are put in thp_split_pages, and
+			 * Split folios are put in split_folios, and
 			 * we will migrate them after the rest of the
 			 * list is processed.
 			 */
 			case -ENOSYS:
-				/* THP migration is unsupported */
-				if (is_thp) {
-					nr_thp_failed++;
-					if (!try_split_thp(page, &thp_split_pages)) {
-						nr_thp_split++;
+				/* Large folio migration is unsupported */
+				if (is_large) {
+					nr_large_failed++;
+					if (!try_split_folio(folio, &split_folios)) {
+						nr_split++;
 						break;
 					}
 				/* Hugetlb migration is unsupported */
-				} else if (!no_subpage_counting) {
+				} else if (!no_split_folio_counting) {
 					nr_failed++;
 				}
 
-				nr_failed_pages += nr_subpages;
-				list_move_tail(&page->lru, &ret_pages);
+				nr_failed_pages += nr_pages;
+				list_move_tail(&folio->lru, &ret_folios);
 				break;
 			case -ENOMEM:
 				/*
 				 * When memory is low, don't bother to try to migrate
-				 * other pages, just exit.
+				 * other folios, just exit.
 				 */
-				if (is_thp) {
-					nr_thp_failed++;
-					/* THP NUMA faulting doesn't split THP to retry. */
-					if (!nosplit && !try_split_thp(page, &thp_split_pages)) {
-						nr_thp_split++;
+				if (is_large) {
+					nr_large_failed++;
+					/* Large folio NUMA faulting doesn't split to retry. */
+					if (!nosplit && !try_split_folio(folio, &split_folios)) {
+						nr_split++;
 						break;
 					}
-				} else if (!no_subpage_counting) {
+				} else if (!no_split_folio_counting) {
 					nr_failed++;
 				}
 
-				nr_failed_pages += nr_subpages + nr_retry_pages;
+				nr_failed_pages += nr_pages + nr_retry_pages;
 				/*
-				 * There might be some subpages of fail-to-migrate THPs
-				 * left in thp_split_pages list. Move them back to migration
+				 * There might be some split folios of fail-to-migrate large
+				 * folios left in split_folios list. Move them back to migration
 				 * list so that they could be put back to the right list by
-				 * the caller otherwise the page refcnt will be leaked.
+				 * the caller otherwise the folio refcnt will be leaked.
 				 */
-				list_splice_init(&thp_split_pages, from);
+				list_splice_init(&split_folios, from);
 				/* nr_failed isn't updated for not used */
-				nr_thp_failed += thp_retry;
+				nr_large_failed += large_retry;
 				goto out;
 			case -EAGAIN:
-				if (is_thp)
-					thp_retry++;
-				else if (!no_subpage_counting)
+				if (is_large)
+					large_retry++;
+				else if (!no_split_folio_counting)
 					retry++;
-				nr_retry_pages += nr_subpages;
+				nr_retry_pages += nr_pages;
 				break;
 			case MIGRATEPAGE_SUCCESS:
-				nr_succeeded += nr_subpages;
-				if (is_thp)
-					nr_thp_succeeded++;
+				nr_succeeded += nr_pages;
+				if (is_large)
+					nr_large_succeeded++;
 				break;
 			default:
 				/*
 				 * Permanent failure (-EBUSY, etc.):
-				 * unlike -EAGAIN case, the failed page is
-				 * removed from migration page list and not
+				 * unlike -EAGAIN case, the failed folio is
+				 * removed from migration folio list and not
 				 * retried in the next outer loop.
 				 */
-				if (is_thp)
-					nr_thp_failed++;
-				else if (!no_subpage_counting)
+				if (is_large)
+					nr_large_failed++;
+				else if (!no_split_folio_counting)
 					nr_failed++;
 
-				nr_failed_pages += nr_subpages;
+				nr_failed_pages += nr_pages;
 				break;
 			}
 		}
 	}
 	nr_failed += retry;
-	nr_thp_failed += thp_retry;
+	nr_large_failed += large_retry;
 	nr_failed_pages += nr_retry_pages;
 	/*
-	 * Try to migrate subpages of fail-to-migrate THPs, no nr_failed
-	 * counting in this round, since all subpages of a THP is counted
-	 * as 1 failure in the first round.
+	 * Try to migrate split folios of fail-to-migrate large folios, no
+	 * nr_failed counting in this round, since all split folios of a
+	 * large folio is counted as 1 failure in the first round.
 	 */
-	if (!list_empty(&thp_split_pages)) {
+	if (!list_empty(&split_folios)) {
 		/*
-		 * Move non-migrated pages (after 10 retries) to ret_pages
+		 * Move non-migrated folios (after 10 retries) to ret_folios
 		 * to avoid migrating them again.
 		 */
-		list_splice_init(from, &ret_pages);
-		list_splice_init(&thp_split_pages, from);
-		no_subpage_counting = true;
+		list_splice_init(from, &ret_folios);
+		list_splice_init(&split_folios, from);
+		no_split_folio_counting = true;
 		retry = 1;
-		goto thp_subpage_migration;
+		goto split_folio_migration;
 	}
 
-	rc = nr_failed + nr_thp_failed;
+	rc = nr_failed + nr_large_failed;
 out:
 	/*
-	 * Put the permanent failure page back to migration list, they
+	 * Put the permanent failure folio back to migration list, they
 	 * will be put back to the right list by the caller.
 	 */
-	list_splice(&ret_pages, from);
+	list_splice(&ret_folios, from);
 
 	/*
-	 * Return 0 in case all subpages of fail-to-migrate THPs are
-	 * migrated successfully.
+	 * Return 0 in case all split folios of fail-to-migrate large folios
+	 * are migrated successfully.
 	 */
 	if (list_empty(from))
 		rc = 0;
 
 	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
 	count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
-	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
-	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
-	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
-	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_thp_succeeded,
-			       nr_thp_failed, nr_thp_split, mode, reason);
+	count_vm_events(THP_MIGRATION_SUCCESS, nr_large_succeeded);
+	count_vm_events(THP_MIGRATION_FAIL, nr_large_failed);
+	count_vm_events(THP_MIGRATION_SPLIT, nr_split);
+	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_large_succeeded,
+			       nr_large_failed, nr_split, mode, reason);
 
 	if (ret_succeeded)
 		*ret_succeeded = nr_succeeded;
-- 
2.35.1


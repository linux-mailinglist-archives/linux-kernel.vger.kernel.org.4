Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F19B68B59E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 07:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBFGdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 01:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBFGdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:33:47 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867B9193F6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 22:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675665224; x=1707201224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E+ufcmCoz9FarLVwteZ2cUHMggV+b5Nv4b96FC4hzk8=;
  b=OmygnWGCHz2iRjFJp66fUvGEJ3x5LguCuMSlLk+CNiCs4/a4Dgalo0OB
   T/BVT078FsGdyRN+a/hLIh1FqLTNJBGwSyJF3D9MDsNG45jCcFfGeCQ9Q
   ukW+GumWSMVT7VmyuWx1jkdRsN+Le9h4k0RfAKF7dKMFoQqAU71Ui75F5
   Jtr2NtQD/cGlTOk8gqoDntpTlARVokGpQshiPvWZQFANPbTlfZ0XJwGaV
   JeaJSIUigV2aPcnRep0lZA9OW8xT5NUI3/P/yI4wS8HJJWFbkKV0Ey2Kx
   iH87Z8XxHshBcM12yQnmSU/evK5HnV77fnLKdY9NLQDu9topcRuyCH7u3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="330432662"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="330432662"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 22:33:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="659744666"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="659744666"
Received: from baoyumen-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.smartont.net) ([10.255.30.227])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 22:33:38 -0800
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
        haoxin <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH -v4 3/9] migrate_pages: restrict number of pages to migrate in batch
Date:   Mon,  6 Feb 2023 14:33:07 +0800
Message-Id: <20230206063313.635011-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230206063313.635011-1-ying.huang@intel.com>
References: <20230206063313.635011-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation patch to batch the folio unmapping and moving
for non-hugetlb folios.

If we had batched the folio unmapping, all folios to be migrated would
be unmapped before copying the contents and flags of the folios.  If
the folios that were passed to migrate_pages() were too many in unit
of pages, the execution of the processes would be stopped for too long
time, thus too long latency.  For example, migrate_pages() syscall
will call migrate_pages() with all folios of a process.  To avoid this
possible issue, in this patch, we restrict the number of pages to be
migrated to be no more than HPAGE_PMD_NR.  That is, the influence is
at the same level of THP migration.

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
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/migrate.c | 174 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 106 insertions(+), 68 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index be7f37523463..9a667039c34c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1396,6 +1396,11 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
 	return rc;
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define NR_MAX_BATCHED_MIGRATION	HPAGE_PMD_NR
+#else
+#define NR_MAX_BATCHED_MIGRATION	512
+#endif
 #define NR_MAX_MIGRATE_PAGES_RETRY	10
 
 struct migrate_pages_stats {
@@ -1497,40 +1502,15 @@ static int migrate_hugetlbs(struct list_head *from, new_page_t get_new_page,
 	return nr_failed;
 }
 
-/*
- * migrate_pages - migrate the folios specified in a list, to the free folios
- *		   supplied as the target for the page migration
- *
- * @from:		The list of folios to be migrated.
- * @get_new_page:	The function used to allocate free folios to be used
- *			as the target of the folio migration.
- * @put_new_page:	The function used to free target folios if migration
- *			fails, or NULL if no special handling is necessary.
- * @private:		Private data to be passed on to get_new_page()
- * @mode:		The migration mode that specifies the constraints for
- *			folio migration, if any.
- * @reason:		The reason for folio migration.
- * @ret_succeeded:	Set to the number of folios migrated successfully if
- *			the caller passes a non-NULL pointer.
- *
- * The function returns after NR_MAX_MIGRATE_PAGES_RETRY attempts or if no folios
- * are movable any more because the list has become empty or no retryable folios
- * exist any more. It is caller's responsibility to call putback_movable_pages()
- * only if ret != 0.
- *
- * Returns the number of {normal folio, large folio, hugetlb} that were not
- * migrated, or an error code. The number of large folio splits will be
- * considered as the number of non-migrated large folio, no matter how many
- * split folios of the large folio are migrated successfully.
- */
-int migrate_pages(struct list_head *from, new_page_t get_new_page,
+static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 		free_page_t put_new_page, unsigned long private,
-		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
+		enum migrate_mode mode, int reason, struct list_head *ret_folios,
+		struct migrate_pages_stats *stats)
 {
 	int retry = 1;
 	int large_retry = 1;
 	int thp_retry = 1;
-	int nr_failed;
+	int nr_failed = 0;
 	int nr_retry_pages = 0;
 	int nr_large_failed = 0;
 	int pass = 0;
@@ -1538,20 +1518,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	bool is_thp = false;
 	struct folio *folio, *folio2;
 	int rc, nr_pages;
-	LIST_HEAD(ret_folios);
 	LIST_HEAD(split_folios);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
 	bool no_split_folio_counting = false;
-	struct migrate_pages_stats stats;
-
-	trace_mm_migrate_pages_start(mode, reason);
-
-	memset(&stats, 0, sizeof(stats));
-	rc = migrate_hugetlbs(from, get_new_page, put_new_page, private, mode, reason,
-			      &stats, &ret_folios);
-	if (rc < 0)
-		goto out;
-	nr_failed = rc;
 
 split_folio_migration:
 	for (pass = 0;
@@ -1563,12 +1532,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		nr_retry_pages = 0;
 
 		list_for_each_entry_safe(folio, folio2, from, lru) {
-			/* Retried hugetlb folios will be kept in list  */
-			if (folio_test_hugetlb(folio)) {
-				list_move_tail(&folio->lru, &ret_folios);
-				continue;
-			}
-
 			/*
 			 * Large folio statistics is based on the source large
 			 * folio. Capture required information that might get
@@ -1582,15 +1545,14 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 
 			rc = unmap_and_move(get_new_page, put_new_page,
 					    private, folio, pass > 2, mode,
-					    reason, &ret_folios);
+					    reason, ret_folios);
 			/*
 			 * The rules are:
 			 *	Success: folio will be freed
 			 *	-EAGAIN: stay on the from list
 			 *	-ENOMEM: stay on the from list
 			 *	-ENOSYS: stay on the from list
-			 *	Other errno: put on ret_folios list then splice to
-			 *		     from list
+			 *	Other errno: put on ret_folios list
 			 */
 			switch(rc) {
 			/*
@@ -1607,17 +1569,17 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				/* Large folio migration is unsupported */
 				if (is_large) {
 					nr_large_failed++;
-					stats.nr_thp_failed += is_thp;
+					stats->nr_thp_failed += is_thp;
 					if (!try_split_folio(folio, &split_folios)) {
-						stats.nr_thp_split += is_thp;
+						stats->nr_thp_split += is_thp;
 						break;
 					}
 				} else if (!no_split_folio_counting) {
 					nr_failed++;
 				}
 
-				stats.nr_failed_pages += nr_pages;
-				list_move_tail(&folio->lru, &ret_folios);
+				stats->nr_failed_pages += nr_pages;
+				list_move_tail(&folio->lru, ret_folios);
 				break;
 			case -ENOMEM:
 				/*
@@ -1626,13 +1588,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 */
 				if (is_large) {
 					nr_large_failed++;
-					stats.nr_thp_failed += is_thp;
+					stats->nr_thp_failed += is_thp;
 					/* Large folio NUMA faulting doesn't split to retry. */
 					if (!nosplit) {
 						int ret = try_split_folio(folio, &split_folios);
 
 						if (!ret) {
-							stats.nr_thp_split += is_thp;
+							stats->nr_thp_split += is_thp;
 							break;
 						} else if (reason == MR_LONGTERM_PIN &&
 							   ret == -EAGAIN) {
@@ -1650,17 +1612,17 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					nr_failed++;
 				}
 
-				stats.nr_failed_pages += nr_pages + nr_retry_pages;
+				stats->nr_failed_pages += nr_pages + nr_retry_pages;
 				/*
 				 * There might be some split folios of fail-to-migrate large
-				 * folios left in split_folios list. Move them back to migration
+				 * folios left in split_folios list. Move them to ret_folios
 				 * list so that they could be put back to the right list by
 				 * the caller otherwise the folio refcnt will be leaked.
 				 */
-				list_splice_init(&split_folios, from);
+				list_splice_init(&split_folios, ret_folios);
 				/* nr_failed isn't updated for not used */
 				nr_large_failed += large_retry;
-				stats.nr_thp_failed += thp_retry;
+				stats->nr_thp_failed += thp_retry;
 				goto out;
 			case -EAGAIN:
 				if (is_large) {
@@ -1672,8 +1634,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				nr_retry_pages += nr_pages;
 				break;
 			case MIGRATEPAGE_SUCCESS:
-				stats.nr_succeeded += nr_pages;
-				stats.nr_thp_succeeded += is_thp;
+				stats->nr_succeeded += nr_pages;
+				stats->nr_thp_succeeded += is_thp;
 				break;
 			default:
 				/*
@@ -1684,20 +1646,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 */
 				if (is_large) {
 					nr_large_failed++;
-					stats.nr_thp_failed += is_thp;
+					stats->nr_thp_failed += is_thp;
 				} else if (!no_split_folio_counting) {
 					nr_failed++;
 				}
 
-				stats.nr_failed_pages += nr_pages;
+				stats->nr_failed_pages += nr_pages;
 				break;
 			}
 		}
 	}
 	nr_failed += retry;
 	nr_large_failed += large_retry;
-	stats.nr_thp_failed += thp_retry;
-	stats.nr_failed_pages += nr_retry_pages;
+	stats->nr_thp_failed += thp_retry;
+	stats->nr_failed_pages += nr_retry_pages;
 	/*
 	 * Try to migrate split folios of fail-to-migrate large folios, no
 	 * nr_failed counting in this round, since all split folios of a
@@ -1708,7 +1670,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		 * Move non-migrated folios (after NR_MAX_MIGRATE_PAGES_RETRY
 		 * retries) to ret_folios to avoid migrating them again.
 		 */
-		list_splice_init(from, &ret_folios);
+		list_splice_init(from, ret_folios);
 		list_splice_init(&split_folios, from);
 		no_split_folio_counting = true;
 		retry = 1;
@@ -1716,6 +1678,82 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	}
 
 	rc = nr_failed + nr_large_failed;
+out:
+	return rc;
+}
+
+/*
+ * migrate_pages - migrate the folios specified in a list, to the free folios
+ *		   supplied as the target for the page migration
+ *
+ * @from:		The list of folios to be migrated.
+ * @get_new_page:	The function used to allocate free folios to be used
+ *			as the target of the folio migration.
+ * @put_new_page:	The function used to free target folios if migration
+ *			fails, or NULL if no special handling is necessary.
+ * @private:		Private data to be passed on to get_new_page()
+ * @mode:		The migration mode that specifies the constraints for
+ *			folio migration, if any.
+ * @reason:		The reason for folio migration.
+ * @ret_succeeded:	Set to the number of folios migrated successfully if
+ *			the caller passes a non-NULL pointer.
+ *
+ * The function returns after NR_MAX_MIGRATE_PAGES_RETRY attempts or if no folios
+ * are movable any more because the list has become empty or no retryable folios
+ * exist any more. It is caller's responsibility to call putback_movable_pages()
+ * only if ret != 0.
+ *
+ * Returns the number of {normal folio, large folio, hugetlb} that were not
+ * migrated, or an error code. The number of large folio splits will be
+ * considered as the number of non-migrated large folio, no matter how many
+ * split folios of the large folio are migrated successfully.
+ */
+int migrate_pages(struct list_head *from, new_page_t get_new_page,
+		free_page_t put_new_page, unsigned long private,
+		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
+{
+	int rc, rc_gather;
+	int nr_pages;
+	struct folio *folio, *folio2;
+	LIST_HEAD(folios);
+	LIST_HEAD(ret_folios);
+	struct migrate_pages_stats stats;
+
+	trace_mm_migrate_pages_start(mode, reason);
+
+	memset(&stats, 0, sizeof(stats));
+
+	rc_gather = migrate_hugetlbs(from, get_new_page, put_new_page, private,
+				     mode, reason, &stats, &ret_folios);
+	if (rc_gather < 0)
+		goto out;
+again:
+	nr_pages = 0;
+	list_for_each_entry_safe(folio, folio2, from, lru) {
+		/* Retried hugetlb folios will be kept in list  */
+		if (folio_test_hugetlb(folio)) {
+			list_move_tail(&folio->lru, &ret_folios);
+			continue;
+		}
+
+		nr_pages += folio_nr_pages(folio);
+		if (nr_pages > NR_MAX_BATCHED_MIGRATION)
+			break;
+	}
+	if (nr_pages > NR_MAX_BATCHED_MIGRATION)
+		list_cut_before(&folios, from, &folio->lru);
+	else
+		list_splice_init(from, &folios);
+	rc = migrate_pages_batch(&folios, get_new_page, put_new_page, private,
+				 mode, reason, &ret_folios, &stats);
+	list_splice_tail_init(&folios, &ret_folios);
+	if (rc < 0) {
+		rc_gather = rc;
+		goto out;
+	}
+	rc_gather += rc;
+	if (!list_empty(from))
+		goto again;
 out:
 	/*
 	 * Put the permanent failure folio back to migration list, they
@@ -1728,7 +1766,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	 * are migrated successfully.
 	 */
 	if (list_empty(from))
-		rc = 0;
+		rc_gather = 0;
 
 	count_vm_events(PGMIGRATE_SUCCESS, stats.nr_succeeded);
 	count_vm_events(PGMIGRATE_FAIL, stats.nr_failed_pages);
@@ -1742,7 +1780,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	if (ret_succeeded)
 		*ret_succeeded = stats.nr_succeeded;
 
-	return rc;
+	return rc_gather;
 }
 
 struct page *alloc_migration_target(struct page *page, unsigned long private)
-- 
2.35.1


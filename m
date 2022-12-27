Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0288656643
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 01:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiL0A3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 19:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiL0A3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 19:29:36 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44D52729
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 16:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672100974; x=1703636974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cdwO6h42qElO4zPv01NpyCEn7VoA3Yf9bDuT74L7CAA=;
  b=E5P6X72reGCRsjZB3UMD7jlg7ambp9mUxNoGkQlMFUI2QwPaQnbwOdY+
   OXsdJIt1KVWi3PqKrOT+FHjJm3PzmE4/8ahypCorsUJp6B/bamccNcEe0
   lHjNhqtfj6GnZ8nm0ONIN6dxcjpB8yiC0wnIaA9o5y4JB8OK1XQx4KFBN
   uO1yBdPWiUJ77433pUUUajdyqq4nYeRVmhQ6r2FOdCdiDb/hiGJE70sSz
   7g3J/47gITmeEJLYCQQVTQTH3cJcuAqZVvG21/tVl3W1tAH/O4b/s0Aqg
   WTG+YWxcUQJzJWrMHgwudAG2o3QCKLscikhg09nAYbtQ2Nhy2S+Xevrws
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="322597233"
X-IronPort-AV: E=Sophos;i="5.96,277,1665471600"; 
   d="scan'208";a="322597233"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 16:29:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="760172204"
X-IronPort-AV: E=Sophos;i="5.96,277,1665471600"; 
   d="scan'208";a="760172204"
Received: from yyang3-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.254.212.104])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 16:29:30 -0800
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
Subject: [PATCH 3/8] migrate_pages: restrict number of pages to migrate in batch
Date:   Tue, 27 Dec 2022 08:28:54 +0800
Message-Id: <20221227002859.27740-4-ying.huang@intel.com>
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
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: haoxin <xhao@linux.alibaba.com>
---
 mm/migrate.c | 173 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 106 insertions(+), 67 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index bdbe73fe2eb7..97ea0737ab2b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1485,40 +1485,15 @@ static int migrate_hugetlbs(struct list_head *from, new_page_t get_new_page,
 	return rc;
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
- * The function returns after 10 attempts or if no folios are movable any more
- * because the list has become empty or no retryable folios exist any more.
- * It is caller's responsibility to call putback_movable_pages() to return folios
- * to the LRU or free list only if ret != 0.
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
@@ -1526,20 +1501,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
 	for (pass = 0; pass < 10 && (retry || large_retry); pass++) {
@@ -1549,11 +1513,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		nr_retry_pages = 0;
 
 		list_for_each_entry_safe(folio, folio2, from, lru) {
-			if (folio_test_hugetlb(folio)) {
-				list_move_tail(&folio->lru, &ret_folios);
-				continue;
-			}
-
 			/*
 			 * Large folio statistics is based on the source large
 			 * folio. Capture required information that might get
@@ -1567,15 +1526,14 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 
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
@@ -1592,17 +1550,17 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
@@ -1611,13 +1569,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
@@ -1635,17 +1593,17 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
@@ -1657,8 +1615,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
@@ -1669,20 +1627,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
@@ -1693,7 +1651,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		 * Move non-migrated folios (after 10 retries) to ret_folios
 		 * to avoid migrating them again.
 		 */
-		list_splice_init(from, &ret_folios);
+		list_splice_init(from, ret_folios);
 		list_splice_init(&split_folios, from);
 		no_split_folio_counting = true;
 		retry = 1;
@@ -1701,6 +1659,87 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	}
 
 	rc = nr_failed + nr_large_failed;
+out:
+	return rc;
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define NR_MAX_BATCHED_MIGRATION	HPAGE_PMD_NR
+#else
+#define NR_MAX_BATCHED_MIGRATION	512
+#endif
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
+ * The function returns after 10 attempts or if no folios are movable any more
+ * because the list has become empty or no retryable folios exist any more.
+ * It is caller's responsibility to call putback_movable_pages() to return folios
+ * to the LRU or free list only if ret != 0.
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
+	int rc, rc_gether;
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
+	rc_gether = migrate_hugetlbs(from, get_new_page, put_new_page, private,
+				     mode, reason, &stats, &ret_folios);
+	if (rc_gether < 0)
+		goto out;
+again:
+	nr_pages = 0;
+	list_for_each_entry_safe(folio, folio2, from, lru) {
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
+		rc_gether = rc;
+		goto out;
+	}
+	rc_gether += rc;
+	if (!list_empty(from))
+		goto again;
 out:
 	/*
 	 * Put the permanent failure folio back to migration list, they
@@ -1713,7 +1752,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	 * are migrated successfully.
 	 */
 	if (list_empty(from))
-		rc = 0;
+		rc_gether = 0;
 
 	count_vm_events(PGMIGRATE_SUCCESS, stats.nr_succeeded);
 	count_vm_events(PGMIGRATE_FAIL, stats.nr_failed_pages);
@@ -1727,7 +1766,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	if (ret_succeeded)
 		*ret_succeeded = stats.nr_succeeded;
 
-	return rc;
+	return rc_gether;
 }
 
 struct page *alloc_migration_target(struct page *page, unsigned long private)
-- 
2.35.1


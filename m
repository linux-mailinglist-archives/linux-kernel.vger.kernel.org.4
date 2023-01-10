Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D8D663A33
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbjAJHyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbjAJHxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:53:52 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080441A21E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673337231; x=1704873231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8sqENHGY6DNVA+KJ5mUSSEkar1m6VwPzX6i/JVkVePc=;
  b=jYQkAWbfrUk1aabCeSBS8jHJCy2rZsUc63v5dzFrlgGiXQOmqWsJGun8
   pxpAzvC8oPZFixCmQCk1OkiU6CkWbra0z+Ca6Eny9Fg0q6dWVVU1nlYCd
   Z/0XivCdlS8ZIgZETg3TC1SeeSGUtdZDtG3eS3BBGRi9uWEHjc42pw4N2
   BWgxBiuuqJ+nHemLZDV5x5nQt6rGu7jKk3JB7o2mdr3Qg8njS+EuS46AX
   S4J9QM7GMN7fHLVivyc9pp+eMlnp702efVrbzzVEf3PaDzga4zbOCJDln
   mCJZCaTIlelz69H8t6GodlESQBdyJMI3oohs9VH+euiqsO5LIJQEzlFaL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="303449326"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="303449326"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 23:53:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="902287157"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="902287157"
Received: from juxinli-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.254.214.35])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 23:53:47 -0800
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
Subject: [PATCH -v2 5/9] migrate_pages: batch _unmap and _move
Date:   Tue, 10 Jan 2023 15:53:23 +0800
Message-Id: <20230110075327.590514-6-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230110075327.590514-1-ying.huang@intel.com>
References: <20230110075327.590514-1-ying.huang@intel.com>
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

In this patch the _unmap and _move stage of the folio migration is
batched.  That for, previously, it is,

  for each folio
    _unmap()
    _move()

Now, it is,

  for each folio
    _unmap()
  for each folio
    _move()

Based on this, we can batch the TLB flushing and use some hardware
accelerator to copy folios between batched _unmap and batched _move
stages.

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
 mm/migrate.c | 205 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 181 insertions(+), 24 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 4c35c2a49574..2983662cff75 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1033,6 +1033,33 @@ static void __migrate_folio_extract(struct folio *dst,
 	dst->private = NULL;
 }
 
+/* Restore the source folio to the original state upon failure */
+static void migrate_folio_undo_src(struct folio *src,
+				   int page_was_mapped,
+				   struct anon_vma *anon_vma,
+				   struct list_head *ret)
+{
+	if (page_was_mapped)
+		remove_migration_ptes(src, src, false);
+	/* Drop an anon_vma reference if we took one */
+	if (anon_vma)
+		put_anon_vma(anon_vma);
+	folio_unlock(src);
+	list_move_tail(&src->lru, ret);
+}
+
+/* Restore the destination folio to the original state upon failure */
+static void migrate_folio_undo_dst(struct folio *dst,
+				   free_page_t put_new_page,
+				   unsigned long private)
+{
+	folio_unlock(dst);
+	if (put_new_page)
+		put_new_page(&dst->page, private);
+	else
+		folio_put(dst);
+}
+
 /* Cleanup src folio upon migration success */
 static void migrate_folio_done(struct folio *src,
 			       enum migrate_reason reason)
@@ -1052,7 +1079,7 @@ static void migrate_folio_done(struct folio *src,
 }
 
 static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
-				int force, enum migrate_mode mode)
+				 int force, bool force_lock, enum migrate_mode mode)
 {
 	int rc = -EAGAIN;
 	int page_was_mapped = 0;
@@ -1079,6 +1106,17 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
 		if (current->flags & PF_MEMALLOC)
 			goto out;
 
+		/*
+		 * We have locked some folios, to avoid deadlock, we cannot
+		 * lock the folio synchronously.  Go out to process (and
+		 * unlock) all the locked folios.  Then we can lock the folio
+		 * synchronously.
+		 */
+		if (!force_lock) {
+			rc = -EDEADLOCK;
+			goto out;
+		}
+
 		folio_lock(src);
 	}
 
@@ -1192,6 +1230,8 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
 
 	rc = move_to_new_folio(dst, src, mode);
 
+	if (rc != -EAGAIN)
+		list_del(&dst->lru);
 	/*
 	 * When successful, push dst to LRU immediately: so that if it
 	 * turns out to be an mlocked page, remove_migration_ptes() will
@@ -1207,6 +1247,11 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
 			lru_add_drain();
 	}
 
+	if (rc == -EAGAIN) {
+		__migrate_folio_record(dst, page_was_mapped, anon_vma);
+		return rc;
+	}
+
 	if (page_was_mapped)
 		remove_migration_ptes(src,
 			rc == MIGRATEPAGE_SUCCESS ? dst : src, false);
@@ -1230,7 +1275,7 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
 /* Obtain the lock on page, remove all ptes. */
 static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page,
 			       unsigned long private, struct folio *src,
-			       struct folio **dstp, int force,
+			       struct folio **dstp, int force, bool force_lock,
 			       enum migrate_mode mode, enum migrate_reason reason,
 			       struct list_head *ret)
 {
@@ -1258,7 +1303,7 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
 	*dstp = dst;
 
 	dst->private = NULL;
-	rc = __migrate_folio_unmap(src, dst, force, mode);
+	rc = __migrate_folio_unmap(src, dst, force, force_lock, mode);
 	if (rc == MIGRATEPAGE_UNMAP)
 		return rc;
 
@@ -1267,7 +1312,7 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
 	 * references and be restored.
 	 */
 	/* restore the folio to right list. */
-	if (rc != -EAGAIN)
+	if (rc != -EAGAIN && rc != -EDEADLOCK)
 		list_move_tail(&src->lru, ret);
 
 	if (put_new_page)
@@ -1306,9 +1351,8 @@ static int migrate_folio_move(free_page_t put_new_page, unsigned long private,
 	 */
 	if (rc == MIGRATEPAGE_SUCCESS) {
 		migrate_folio_done(src, reason);
-	} else {
-		if (rc != -EAGAIN)
-			list_add_tail(&src->lru, ret);
+	} else if (rc != -EAGAIN) {
+		list_add_tail(&src->lru, ret);
 
 		if (put_new_page)
 			put_new_page(&dst->page, private);
@@ -1588,7 +1632,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 		enum migrate_mode mode, int reason, struct list_head *ret_folios,
 		struct migrate_pages_stats *stats)
 {
-	int retry = 1;
+	int retry;
 	int large_retry = 1;
 	int thp_retry = 1;
 	int nr_failed = 0;
@@ -1597,13 +1641,19 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	int pass = 0;
 	bool is_large = false;
 	bool is_thp = false;
-	struct folio *folio, *folio2, *dst = NULL;
-	int rc, nr_pages;
+	struct folio *folio, *folio2, *dst = NULL, *dst2;
+	int rc, rc_saved, nr_pages;
 	LIST_HEAD(split_folios);
+	LIST_HEAD(unmap_folios);
+	LIST_HEAD(dst_folios);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
 	bool no_split_folio_counting = false;
+	bool force_lock;
 
-split_folio_migration:
+retry:
+	rc_saved = 0;
+	force_lock = true;
+	retry = 1;
 	for (pass = 0;
 	     pass < NR_MAX_MIGRATE_PAGES_RETRY && (retry || large_retry);
 	     pass++) {
@@ -1625,16 +1675,15 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 			cond_resched();
 
 			rc = migrate_folio_unmap(get_new_page, put_new_page, private,
-						 folio, &dst, pass > 2, mode,
-						 reason, ret_folios);
-			if (rc == MIGRATEPAGE_UNMAP)
-				rc = migrate_folio_move(put_new_page, private,
-							folio, dst, mode,
-							reason, ret_folios);
+						 folio, &dst, pass > 2, force_lock,
+						 mode, reason, ret_folios);
 			/*
 			 * The rules are:
 			 *	Success: folio will be freed
+			 *	Unmap: folio will be put on unmap_folios list,
+			 *	       dst folio put on dst_folios list
 			 *	-EAGAIN: stay on the from list
+			 *	-EDEADLOCK: stay on the from list
 			 *	-ENOMEM: stay on the from list
 			 *	-ENOSYS: stay on the from list
 			 *	Other errno: put on ret_folios list
@@ -1669,7 +1718,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 			case -ENOMEM:
 				/*
 				 * When memory is low, don't bother to try to migrate
-				 * other folios, just exit.
+				 * other folios, move unmapped folios, then exit.
 				 */
 				if (is_large) {
 					nr_large_failed++;
@@ -1708,7 +1757,19 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 				/* nr_failed isn't updated for not used */
 				nr_large_failed += large_retry;
 				stats->nr_thp_failed += thp_retry;
-				goto out;
+				rc_saved = rc;
+				if (list_empty(&unmap_folios))
+					goto out;
+				else
+					goto move;
+			case -EDEADLOCK:
+				/*
+				 * The folio cannot be locked for potential deadlock.
+				 * Go move (and unlock) all locked folios.  Then we can
+				 * try again.
+				 */
+				rc_saved = rc;
+				goto move;
 			case -EAGAIN:
 				if (is_large) {
 					large_retry++;
@@ -1722,6 +1783,15 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 				stats->nr_succeeded += nr_pages;
 				stats->nr_thp_succeeded += is_thp;
 				break;
+			case MIGRATEPAGE_UNMAP:
+				/*
+				 * We have locked some folios, don't force lock
+				 * to avoid deadlock.
+				 */
+				force_lock = false;
+				list_move_tail(&folio->lru, &unmap_folios);
+				list_add_tail(&dst->lru, &dst_folios);
+				break;
 			default:
 				/*
 				 * Permanent failure (-EBUSY, etc.):
@@ -1745,12 +1815,95 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	nr_large_failed += large_retry;
 	stats->nr_thp_failed += thp_retry;
 	stats->nr_failed_pages += nr_retry_pages;
+move:
+	retry = 1;
+	for (pass = 0;
+	     pass < NR_MAX_MIGRATE_PAGES_RETRY && (retry || large_retry);
+	     pass++) {
+		retry = 0;
+		large_retry = 0;
+		thp_retry = 0;
+		nr_retry_pages = 0;
+
+		dst = list_first_entry(&dst_folios, struct folio, lru);
+		dst2 = list_next_entry(dst, lru);
+		list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
+			is_large = folio_test_large(folio);
+			is_thp = is_large && folio_test_pmd_mappable(folio);
+			nr_pages = folio_nr_pages(folio);
+
+			cond_resched();
+
+			rc = migrate_folio_move(put_new_page, private,
+						folio, dst, mode,
+						reason, ret_folios);
+			/*
+			 * The rules are:
+			 *	Success: folio will be freed
+			 *	-EAGAIN: stay on the unmap_folios list
+			 *	Other errno: put on ret_folios list
+			 */
+			switch(rc) {
+			case -EAGAIN:
+				if (is_large) {
+					large_retry++;
+					thp_retry += is_thp;
+				} else if (!no_split_folio_counting) {
+					retry++;
+				}
+				nr_retry_pages += nr_pages;
+				break;
+			case MIGRATEPAGE_SUCCESS:
+				stats->nr_succeeded += nr_pages;
+				stats->nr_thp_succeeded += is_thp;
+				break;
+			default:
+				if (is_large) {
+					nr_large_failed++;
+					stats->nr_thp_failed += is_thp;
+				} else if (!no_split_folio_counting) {
+					nr_failed++;
+				}
+
+				stats->nr_failed_pages += nr_pages;
+				break;
+			}
+			dst = dst2;
+			dst2 = list_next_entry(dst, lru);
+		}
+	}
+	nr_failed += retry;
+	nr_large_failed += large_retry;
+	stats->nr_thp_failed += thp_retry;
+	stats->nr_failed_pages += nr_retry_pages;
+
+	if (rc_saved)
+		rc = rc_saved;
+	else
+		rc = nr_failed + nr_large_failed;
+out:
+	/* Cleanup remaining folios */
+	dst = list_first_entry(&dst_folios, struct folio, lru);
+	dst2 = list_next_entry(dst, lru);
+	list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
+		int page_was_mapped = 0;
+		struct anon_vma *anon_vma = NULL;
+
+		__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
+		migrate_folio_undo_src(folio, page_was_mapped, anon_vma,
+				       ret_folios);
+		list_del(&dst->lru);
+		migrate_folio_undo_dst(dst, put_new_page, private);
+		dst = dst2;
+		dst2 = list_next_entry(dst, lru);
+	}
+
 	/*
 	 * Try to migrate split folios of fail-to-migrate large folios, no
 	 * nr_failed counting in this round, since all split folios of a
 	 * large folio is counted as 1 failure in the first round.
 	 */
-	if (!list_empty(&split_folios)) {
+	if (rc >= 0 && !list_empty(&split_folios)) {
 		/*
 		 * Move non-migrated folios (after NR_MAX_MIGRATE_PAGES_RETRY
 		 * retries) to ret_folios to avoid migrating them again.
@@ -1758,12 +1911,16 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 		list_splice_init(from, ret_folios);
 		list_splice_init(&split_folios, from);
 		no_split_folio_counting = true;
-		retry = 1;
-		goto split_folio_migration;
+		goto retry;
 	}
 
-	rc = nr_failed + nr_large_failed;
-out:
+	/*
+	 * We have unlocked all locked folios, so we can force lock now, let's
+	 * try again.
+	 */
+	if (rc == -EDEADLOCK)
+		goto retry;
+
 	return rc;
 }
 
-- 
2.35.1


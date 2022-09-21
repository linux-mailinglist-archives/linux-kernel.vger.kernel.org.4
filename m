Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A945BF60D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiIUGHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiIUGHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:07:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2077EFEE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663740421; x=1695276421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=86Q547FC+4GoVik4Kb6Pl8hTy/8I3tx19/Q4rOJo4M4=;
  b=eujtSkn9ou8MsQIaL06A2buIDxbmVum2PkQHoboBTD3a41GyKrie2AJL
   isEUhA3lzI+2EnNui473v5XWxWA6M2AmO4Qr8YGO6Uo6rQWrrJt3utEmM
   so+8LnWYvAhzDLsgSz9o+ay6gsssg3xakSGpHH+HtkG7iGcYCKe5CuRFY
   yFG4t2sprjWX7uKGTIAyXK7e55Cp3HqCsrGCXKXKPOSoAxRTgUleAc7HI
   jDGs4ikYFCbgAWAn2YEAkS2oKlbWAPUBrHejlRUvNl7eF+5ITRjTY68X/
   Dv3o+nEoHAjkp/LZqHvRDn0PftJcuRqsVMXlaJwvuGqAzcu39nAvtLZDS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="280284855"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="280284855"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:07:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="649913920"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.5.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:06:59 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC 4/6] mm/migrate_pages: batch _unmap and _move
Date:   Wed, 21 Sep 2022 14:06:14 +0800
Message-Id: <20220921060616.73086-5-ying.huang@intel.com>
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

In this patch the _unmap and _move stage of the page migration is
batched.  That for, previously, it is,

  for each page
    _unmap()
    _move()

Now, it is,

  for each page
    _unmap()
  for each page
    _move()

Based on this, we can batch the TLB flushing and use some hardware
accelerator to copy pages between batched _unmap and batched _move
stages.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
---
 mm/migrate.c | 155 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 139 insertions(+), 16 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 1077af858e36..165cbbc834e2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -996,6 +996,32 @@ static void __migrate_page_extract(struct page *newpage,
 
 #define MIGRATEPAGE_UNMAP		1
 
+static void migrate_page_undo_page(struct page *page,
+				   int page_was_mapped,
+				   struct anon_vma *anon_vma,
+				   struct list_head *ret)
+{
+	struct folio *folio = page_folio(page);
+
+	if (page_was_mapped)
+		remove_migration_ptes(folio, folio, false);
+	if (anon_vma)
+		put_anon_vma(anon_vma);
+	unlock_page(page);
+	list_move_tail(&page->lru, ret);
+}
+
+static void migrate_page_undo_newpage(struct page *newpage,
+				      free_page_t put_new_page,
+				      unsigned long private)
+{
+	unlock_page(newpage);
+	if (put_new_page)
+		put_new_page(newpage, private);
+	else
+		put_page(newpage);
+}
+
 static int __migrate_page_unmap(struct page *page, struct page *newpage,
 				int force, enum migrate_mode mode)
 {
@@ -1140,6 +1166,8 @@ static int __migrate_page_move(struct page *page, struct page *newpage,
 
 	rc = move_to_new_folio(dst, folio, mode);
 
+	if (rc != -EAGAIN)
+		list_del(&newpage->lru);
 	/*
 	 * When successful, push newpage to LRU immediately: so that if it
 	 * turns out to be an mlocked page, remove_migration_ptes() will
@@ -1155,6 +1183,11 @@ static int __migrate_page_move(struct page *page, struct page *newpage,
 			lru_add_drain();
 	}
 
+	if (rc == -EAGAIN) {
+		__migrate_page_record(newpage, page_was_mapped, anon_vma);
+		return rc;
+	}
+
 	if (page_was_mapped)
 		remove_migration_ptes(folio,
 			rc == MIGRATEPAGE_SUCCESS ? dst : folio, false);
@@ -1220,6 +1253,7 @@ static int migrate_page_unmap(new_page_t get_new_page, free_page_t put_new_page,
 		return -ENOMEM;
 	*newpagep = newpage;
 
+	newpage->private = 0;
 	rc = __migrate_page_unmap(page, newpage, force, mode);
 	if (rc == MIGRATEPAGE_UNMAP)
 		return rc;
@@ -1258,7 +1292,7 @@ static int migrate_page_move(free_page_t put_new_page, unsigned long private,
 		 * removed and will be freed. A page that has not been
 		 * migrated will have kept its references and be restored.
 		 */
-		list_del(&page->lru);
+		list_del_init(&page->lru);
 	}
 
 	/*
@@ -1268,9 +1302,8 @@ static int migrate_page_move(free_page_t put_new_page, unsigned long private,
 	 */
 	if (rc == MIGRATEPAGE_SUCCESS) {
 		migrate_page_done(page, reason);
-	} else {
-		if (rc != -EAGAIN)
-			list_add_tail(&page->lru, ret);
+	} else if (rc != -EAGAIN) {
+		list_add_tail(&page->lru, ret);
 
 		if (put_new_page)
 			put_new_page(newpage, private);
@@ -1455,11 +1488,13 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	int pass = 0;
 	bool is_thp = false;
 	struct page *page;
-	struct page *newpage = NULL;
+	struct page *newpage = NULL, *newpage2;
 	struct page *page2;
 	int rc, nr_subpages;
 	LIST_HEAD(ret_pages);
 	LIST_HEAD(thp_split_pages);
+	LIST_HEAD(unmap_pages);
+	LIST_HEAD(new_pages);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
 	bool no_subpage_counting = false;
 
@@ -1541,19 +1576,19 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 			nr_subpages = compound_nr(page);
 			cond_resched();
 
-			if (PageHuge(page))
+			if (PageHuge(page)) {
+				list_move_tail(&page->lru, &ret_pages);
 				continue;
+			}
 
 			rc = migrate_page_unmap(get_new_page, put_new_page, private,
 						page, &newpage, pass > 2, mode,
 						reason, &ret_pages);
-			if (rc == MIGRATEPAGE_UNMAP)
-				rc = migrate_page_move(put_new_page, private,
-						       page, newpage, mode,
-						       reason, &ret_pages);
 			/*
 			 * The rules are:
 			 *	Success: page will be freed
+			 *	Unmap: page will be put on unmap_pages list,
+			 *	       new page put on new_pages list
 			 *	-EAGAIN: stay on the from list
 			 *	-ENOMEM: stay on the from list
 			 *	-ENOSYS: stay on the from list
@@ -1589,7 +1624,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 			case -ENOMEM:
 				/*
 				 * When memory is low, don't bother to try to migrate
-				 * other pages, just exit.
+				 * other pages, move unmapped pages, then exit.
 				 */
 				if (is_thp) {
 					nr_thp_failed++;
@@ -1610,9 +1645,11 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 				 * the caller otherwise the page refcnt will be leaked.
 				 */
 				list_splice_init(&thp_split_pages, from);
-				/* nr_failed isn't updated for not used */
 				nr_thp_failed += thp_retry;
-				goto out;
+				if (list_empty(&unmap_pages))
+					goto out;
+				else
+					goto move;
 			case -EAGAIN:
 				if (is_thp)
 					thp_retry++;
@@ -1625,6 +1662,10 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 				if (is_thp)
 					nr_thp_succeeded++;
 				break;
+			case MIGRATEPAGE_UNMAP:
+				list_move_tail(&page->lru, &unmap_pages);
+				list_add_tail(&newpage->lru, &new_pages);
+				break;
 			default:
 				/*
 				 * Permanent failure (-EBUSY, etc.):
@@ -1645,12 +1686,96 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	nr_failed += retry;
 	nr_thp_failed += thp_retry;
 	nr_failed_pages += nr_retry_pages;
+move:
+	retry = 1;
+	thp_retry = 1;
+	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
+		retry = 0;
+		thp_retry = 0;
+		nr_retry_pages = 0;
+
+		newpage = list_first_entry(&new_pages, struct page, lru);
+		newpage2 = list_next_entry(newpage, lru);
+		list_for_each_entry_safe(page, page2, &unmap_pages, lru) {
+			/*
+			 * THP statistics is based on the source huge page.
+			 * Capture required information that might get lost
+			 * during migration.
+			 */
+			is_thp = PageTransHuge(page) && !PageHuge(page);
+			nr_subpages = compound_nr(page);
+			cond_resched();
+
+			rc = migrate_page_move(put_new_page, private,
+					       page, newpage, mode,
+					       reason, &ret_pages);
+			/*
+			 * The rules are:
+			 *	Success: page will be freed
+			 *	-EAGAIN: stay on the unmap_pages list
+			 *	Other errno: put on ret_pages list then splice to
+			 *		     from list
+			 */
+			switch(rc) {
+			case -EAGAIN:
+				if (is_thp)
+					thp_retry++;
+				else if (!no_subpage_counting)
+					retry++;
+				nr_retry_pages += nr_subpages;
+				break;
+			case MIGRATEPAGE_SUCCESS:
+				nr_succeeded += nr_subpages;
+				if (is_thp)
+					nr_thp_succeeded++;
+				break;
+			default:
+				/*
+				 * Permanent failure (-EBUSY, etc.):
+				 * unlike -EAGAIN case, the failed page is
+				 * removed from migration page list and not
+				 * retried in the next outer loop.
+				 */
+				if (is_thp)
+					nr_thp_failed++;
+				else if (!no_subpage_counting)
+					nr_failed++;
+
+				nr_failed_pages += nr_subpages;
+				break;
+			}
+			newpage = newpage2;
+			newpage2 = list_next_entry(newpage, lru);
+		}
+	}
+	nr_failed += retry;
+	nr_thp_failed += thp_retry;
+	nr_failed_pages += nr_retry_pages;
+
+	rc = nr_failed + nr_thp_failed;
+out:
+	/* Cleanup remaining pages */
+	newpage = list_first_entry(&new_pages, struct page, lru);
+	newpage2 = list_next_entry(newpage, lru);
+	list_for_each_entry_safe(page, page2, &unmap_pages, lru) {
+		int page_was_mapped = 0;
+		struct anon_vma *anon_vma = NULL;
+
+		__migrate_page_extract(newpage, &page_was_mapped, &anon_vma);
+		migrate_page_undo_page(page, page_was_mapped, anon_vma,
+				       &ret_pages);
+		list_del(&newpage->lru);
+		migrate_page_undo_newpage(newpage, put_new_page, private);
+		newpage = newpage2;
+		newpage2 = list_next_entry(newpage, lru);
+	}
+
 	/*
 	 * Try to migrate subpages of fail-to-migrate THPs, no nr_failed
 	 * counting in this round, since all subpages of a THP is counted
 	 * as 1 failure in the first round.
 	 */
-	if (!list_empty(&thp_split_pages)) {
+	if (rc >= 0 && !list_empty(&thp_split_pages)) {
 		/*
 		 * Move non-migrated pages (after 10 retries) to ret_pages
 		 * to avoid migrating them again.
@@ -1662,8 +1787,6 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 		goto thp_subpage_migration;
 	}
 
-	rc = nr_failed + nr_thp_failed;
-out:
 	/*
 	 * Put the permanent failure page back to migration list, they
 	 * will be put back to the right list by the caller.
-- 
2.35.1


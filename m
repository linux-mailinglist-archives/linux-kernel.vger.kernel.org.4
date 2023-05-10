Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23EA6FD41B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbjEJDTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjEJDSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:18:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDF93C0B
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 20:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683688729; x=1715224729;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gEQNGkCcU5WT+r+9TyPbJWqYyvG35688ogCCi44yF80=;
  b=LPARbo9acsQ98w5uXsO7odG7kgw9jZZUlh8eojUooqj6a2xT9+6xht6J
   p94w6ZBI8eU4HhJZWJLdX5lR+v/HeZD2wg38bG2aFUzRQx3XNQ4i6kYzm
   ESzB+NOvyV+Yic12efsQ4099B8PTw+M/rQhUIyq5aQVawSJ2nAEZ9jpG/
   mSPfttvXpKamWjXUjRIlMbTBPOCX+0gI3+FxGyspDNe8lDyIRDzx3jDUb
   EjXe1JSG8GQu5qLX6V13A9gFLWCr2PHDxnb47ndry/RN6ycxUz8nlg5vZ
   qNvcy1aBOAaKrK+vQPHNxsqxZs5OaVpTLcroQp1lKTBtLiMxTz/tEzlCH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="347582655"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="347582655"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 20:18:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="676698630"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="676698630"
Received: from jiafuzha-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 20:18:46 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH -V2] migrate_pages_batch: simplify retrying and failure counting of large folios
Date:   Wed, 10 May 2023 11:18:29 +0800
Message-Id: <20230510031829.11513-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After recent changes to the retrying and failure counting in
migrate_pages_batch(), it was found that it's unnecessary to count
retrying and failure for normal, large, and THP folios separately.
Because we don't use retrying and failure number of large folios
directly.  So, in this patch, we simplified retrying and failure
counting of large folios via counting retrying and failure of normal
and large folios together.  This results in the reduced line number.

Previously, in migrate_pages_batch we need to track whether the source
folio is large/THP before splitting.  So is_large is used to cache
folio_test_large() result.  Now, we don't need that variable any more
because we don't count retrying and failure of large folios (only
counting that of THP folios).  So, in this patch, is_large is removed
to simplify the code.

This is just code cleanup, no functionality changes are expected.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Alistair Popple <apopple@nvidia.com>
---
 mm/migrate.c | 110 ++++++++++++++++-----------------------------------
 1 file changed, 35 insertions(+), 75 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 01cac26a3127..2ac927a82bbc 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1614,13 +1614,10 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 		int nr_pass)
 {
 	int retry = 1;
-	int large_retry = 1;
 	int thp_retry = 1;
 	int nr_failed = 0;
 	int nr_retry_pages = 0;
-	int nr_large_failed = 0;
 	int pass = 0;
-	bool is_large = false;
 	bool is_thp = false;
 	struct folio *folio, *folio2, *dst = NULL, *dst2;
 	int rc, rc_saved = 0, nr_pages;
@@ -1631,20 +1628,13 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	VM_WARN_ON_ONCE(mode != MIGRATE_ASYNC &&
 			!list_empty(from) && !list_is_singular(from));
 
-	for (pass = 0; pass < nr_pass && (retry || large_retry); pass++) {
+	for (pass = 0; pass < nr_pass && retry; pass++) {
 		retry = 0;
-		large_retry = 0;
 		thp_retry = 0;
 		nr_retry_pages = 0;
 
 		list_for_each_entry_safe(folio, folio2, from, lru) {
-			/*
-			 * Large folio statistics is based on the source large
-			 * folio. Capture required information that might get
-			 * lost during migration.
-			 */
-			is_large = folio_test_large(folio);
-			is_thp = is_large && folio_test_pmd_mappable(folio);
+			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
 			nr_pages = folio_nr_pages(folio);
 
 			cond_resched();
@@ -1660,7 +1650,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 			 * list is processed.
 			 */
 			if (!thp_migration_supported() && is_thp) {
-				nr_large_failed++;
+				nr_failed++;
 				stats->nr_thp_failed++;
 				if (!try_split_folio(folio, split_folios)) {
 					stats->nr_thp_split++;
@@ -1688,38 +1678,33 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 				 * When memory is low, don't bother to try to migrate
 				 * other folios, move unmapped folios, then exit.
 				 */
-				if (is_large) {
-					nr_large_failed++;
-					stats->nr_thp_failed += is_thp;
-					/* Large folio NUMA faulting doesn't split to retry. */
-					if (!nosplit) {
-						int ret = try_split_folio(folio, split_folios);
+				nr_failed++;
+				stats->nr_thp_failed += is_thp;
+				/* Large folio NUMA faulting doesn't split to retry. */
+				if (folio_test_large(folio) && !nosplit) {
+					int ret = try_split_folio(folio, split_folios);
 
-						if (!ret) {
-							stats->nr_thp_split += is_thp;
-							break;
-						} else if (reason == MR_LONGTERM_PIN &&
-							   ret == -EAGAIN) {
-							/*
-							 * Try again to split large folio to
-							 * mitigate the failure of longterm pinning.
-							 */
-							large_retry++;
-							thp_retry += is_thp;
-							nr_retry_pages += nr_pages;
-							/* Undo duplicated failure counting. */
-							nr_large_failed--;
-							stats->nr_thp_failed -= is_thp;
-							break;
-						}
+					if (!ret) {
+						stats->nr_thp_split += is_thp;
+						break;
+					} else if (reason == MR_LONGTERM_PIN &&
+						   ret == -EAGAIN) {
+						/*
+						 * Try again to split large folio to
+						 * mitigate the failure of longterm pinning.
+						 */
+						retry++;
+						thp_retry += is_thp;
+						nr_retry_pages += nr_pages;
+						/* Undo duplicated failure counting. */
+						nr_failed--;
+						stats->nr_thp_failed -= is_thp;
+						break;
 					}
-				} else {
-					nr_failed++;
 				}
 
 				stats->nr_failed_pages += nr_pages + nr_retry_pages;
 				/* nr_failed isn't updated for not used */
-				nr_large_failed += large_retry;
 				stats->nr_thp_failed += thp_retry;
 				rc_saved = rc;
 				if (list_empty(&unmap_folios))
@@ -1727,12 +1712,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 				else
 					goto move;
 			case -EAGAIN:
-				if (is_large) {
-					large_retry++;
-					thp_retry += is_thp;
-				} else {
-					retry++;
-				}
+				retry++;
+				thp_retry += is_thp;
 				nr_retry_pages += nr_pages;
 				break;
 			case MIGRATEPAGE_SUCCESS:
@@ -1750,20 +1731,14 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 				 * removed from migration folio list and not
 				 * retried in the next outer loop.
 				 */
-				if (is_large) {
-					nr_large_failed++;
-					stats->nr_thp_failed += is_thp;
-				} else {
-					nr_failed++;
-				}
-
+				nr_failed++;
+				stats->nr_thp_failed += is_thp;
 				stats->nr_failed_pages += nr_pages;
 				break;
 			}
 		}
 	}
 	nr_failed += retry;
-	nr_large_failed += large_retry;
 	stats->nr_thp_failed += thp_retry;
 	stats->nr_failed_pages += nr_retry_pages;
 move:
@@ -1771,17 +1746,15 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	try_to_unmap_flush();
 
 	retry = 1;
-	for (pass = 0; pass < nr_pass && (retry || large_retry); pass++) {
+	for (pass = 0; pass < nr_pass && retry; pass++) {
 		retry = 0;
-		large_retry = 0;
 		thp_retry = 0;
 		nr_retry_pages = 0;
 
 		dst = list_first_entry(&dst_folios, struct folio, lru);
 		dst2 = list_next_entry(dst, lru);
 		list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
-			is_large = folio_test_large(folio);
-			is_thp = is_large && folio_test_pmd_mappable(folio);
+			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
 			nr_pages = folio_nr_pages(folio);
 
 			cond_resched();
@@ -1797,12 +1770,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 			 */
 			switch(rc) {
 			case -EAGAIN:
-				if (is_large) {
-					large_retry++;
-					thp_retry += is_thp;
-				} else {
-					retry++;
-				}
+				retry++;
+				thp_retry += is_thp;
 				nr_retry_pages += nr_pages;
 				break;
 			case MIGRATEPAGE_SUCCESS:
@@ -1810,13 +1779,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 				stats->nr_thp_succeeded += is_thp;
 				break;
 			default:
-				if (is_large) {
-					nr_large_failed++;
-					stats->nr_thp_failed += is_thp;
-				} else {
-					nr_failed++;
-				}
-
+				nr_failed++;
+				stats->nr_thp_failed += is_thp;
 				stats->nr_failed_pages += nr_pages;
 				break;
 			}
@@ -1825,14 +1789,10 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 		}
 	}
 	nr_failed += retry;
-	nr_large_failed += large_retry;
 	stats->nr_thp_failed += thp_retry;
 	stats->nr_failed_pages += nr_retry_pages;
 
-	if (rc_saved)
-		rc = rc_saved;
-	else
-		rc = nr_failed + nr_large_failed;
+	rc = rc_saved ? : nr_failed;
 out:
 	/* Cleanup remaining folios */
 	dst = list_first_entry(&dst_folios, struct folio, lru);
-- 
2.39.2


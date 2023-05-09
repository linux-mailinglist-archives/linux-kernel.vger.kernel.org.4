Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D626FBD0F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjEICU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEICUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:20:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07D9E60
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 19:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683598823; x=1715134823;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Nmn1IPrYCW89+aGyZUryWtE01T7K4enWfajjIDcQAnk=;
  b=X71wGZHaWtNxVAwfoGBtocU91ALfwEWXKiH0xlmaffbyprPaFVi3MCGM
   aTIKG1FyVpfScplDrsHRmJpAD60XN+agWmDHhlTuMDW39jWCIkIfi7fCq
   UuuZYB7jzMxqjg6b8aaFGWI96asp2P1dYT94l3VGiASmg8M6Mc8kUMZxo
   ox4h8WlCV0uertwreEy/1YZGGzb+hm6oRZSQY6xrl23diBdcEjExBqHke
   OWVVvRpXjM+9BwLVv6Q3da6U0GFAup7QeZ6SOSwc4JTD7szve7xr6XXyS
   DO65dJZnDpgzRRE7Vc35/qzapI4ICHVhyHTfnK+wypLhajLKrkNP4WbHB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="330155072"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="330155072"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 19:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="731515706"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="731515706"
Received: from jiudongl-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.30.15])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 19:20:19 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 1/2] migrate_pages_batch: simplify retrying and failure counting of large folios
Date:   Tue,  9 May 2023 10:20:13 +0800
Message-Id: <20230509022014.380493-1-ying.huang@intel.com>
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

This is just code cleanup, no functionality changes are expected.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Xin Hao <xhao@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Alistair Popple <apopple@nvidia.com>
---
 mm/migrate.c | 103 +++++++++++++++++----------------------------------
 1 file changed, 35 insertions(+), 68 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 01cac26a3127..10709aed76d3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1614,11 +1614,9 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 		int nr_pass)
 {
 	int retry = 1;
-	int large_retry = 1;
 	int thp_retry = 1;
 	int nr_failed = 0;
 	int nr_retry_pages = 0;
-	int nr_large_failed = 0;
 	int pass = 0;
 	bool is_large = false;
 	bool is_thp = false;
@@ -1631,9 +1629,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	VM_WARN_ON_ONCE(mode != MIGRATE_ASYNC &&
 			!list_empty(from) && !list_is_singular(from));
 
-	for (pass = 0; pass < nr_pass && (retry || large_retry); pass++) {
+	for (pass = 0; pass < nr_pass && retry; pass++) {
 		retry = 0;
-		large_retry = 0;
 		thp_retry = 0;
 		nr_retry_pages = 0;
 
@@ -1660,7 +1657,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 			 * list is processed.
 			 */
 			if (!thp_migration_supported() && is_thp) {
-				nr_large_failed++;
+				nr_failed++;
 				stats->nr_thp_failed++;
 				if (!try_split_folio(folio, split_folios)) {
 					stats->nr_thp_split++;
@@ -1688,38 +1685,33 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 				 * When memory is low, don't bother to try to migrate
 				 * other folios, move unmapped folios, then exit.
 				 */
-				if (is_large) {
-					nr_large_failed++;
-					stats->nr_thp_failed += is_thp;
-					/* Large folio NUMA faulting doesn't split to retry. */
-					if (!nosplit) {
-						int ret = try_split_folio(folio, split_folios);
-
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
+				nr_failed++;
+				stats->nr_thp_failed += is_thp;
+				/* Large folio NUMA faulting doesn't split to retry. */
+				if (is_large && !nosplit) {
+					int ret = try_split_folio(folio, split_folios);
+
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
@@ -1727,12 +1719,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
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
@@ -1750,20 +1738,14 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
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
@@ -1771,17 +1753,15 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
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
@@ -1797,12 +1777,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
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
@@ -1810,13 +1786,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
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
@@ -1825,14 +1796,10 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
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


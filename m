Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071675BF60A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIUGHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiIUGGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:06:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08CB7B2AE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663740413; x=1695276413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P89pEx/QWVFzErE/u067pCGTE2O1BWblDLS8JJgMTCo=;
  b=HrVsviv8cn2Hhy90XMOSngJL8XgJiQfX7rnh/bOIK90hDbjJ0BRsymAG
   dV7VYzzfg65GUKi5kEr07wY3YedNRubDPVQTl4zpMptF9lpg2rrtyIa2C
   V/7ly8yhU1uRr01YLdV7gTRPMUsUX8gZxVuAH5pzKGzTqF8w+mou+my6T
   vdJTIOycLIkdFEy9n1tU8LWHOStGfaW5SX5wXTf1XGve54x1lhTFNuogx
   Jd0nzmFYJD15oiy2NoM6OvCuCn1BNeREI5FdlSzCAD/JnWayzFEWevCTP
   vDNSJOrgs2myouB2rKN8R0Raq+cDwsjTV4umE550WxLx8Z17vJBzlHIay
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="280284830"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="280284830"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:06:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="649913842"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.5.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:06:50 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC 1/6] mm/migrate_pages: separate huge page and normal pages migration
Date:   Wed, 21 Sep 2022 14:06:11 +0800
Message-Id: <20220921060616.73086-2-ying.huang@intel.com>
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

This is a preparation patch to batch the page unmapping and moving for
the normal pages and THPs.  Based on that we can batch the TLB
shootdown during the page migration and make it possible to use some
hardware accelerator for the page copying.

In this patch the huge page (PageHuge()) and normal page and THP
migration is separated in migrate_pages() to make it easy to change
the normal page and THP migration implementation.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
---
 mm/migrate.c | 73 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 9 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 571d8c9fd5bc..117134f1c6dc 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1414,6 +1414,66 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 
 	trace_mm_migrate_pages_start(mode, reason);
 
+	for (pass = 0; pass < 10 && retry; pass++) {
+		retry = 0;
+
+		list_for_each_entry_safe(page, page2, from, lru) {
+			nr_subpages = compound_nr(page);
+			cond_resched();
+
+			if (!PageHuge(page))
+				continue;
+
+			rc = unmap_and_move_huge_page(get_new_page,
+						put_new_page, private, page,
+						pass > 2, mode, reason,
+						&ret_pages);
+			/*
+			 * The rules are:
+			 *	Success: hugetlb page will be put back
+			 *	-EAGAIN: stay on the from list
+			 *	-ENOMEM: stay on the from list
+			 *	-ENOSYS: stay on the from list
+			 *	Other errno: put on ret_pages list then splice to
+			 *		     from list
+			 */
+			switch(rc) {
+			case -ENOSYS:
+				/* Hugetlb migration is unsupported */
+				nr_failed++;
+				nr_failed_pages += nr_subpages;
+				list_move_tail(&page->lru, &ret_pages);
+				break;
+			case -ENOMEM:
+				/*
+				 * When memory is low, don't bother to try to migrate
+				 * other pages, just exit.
+				 */
+				nr_failed++;
+				nr_failed_pages += nr_subpages + nr_retry_pages;
+				goto out;
+			case -EAGAIN:
+				retry++;
+				nr_retry_pages += nr_subpages;
+				break;
+			case MIGRATEPAGE_SUCCESS:
+				nr_succeeded += nr_subpages;
+				break;
+			default:
+				/*
+				 * Permanent failure (-EBUSY, etc.):
+				 * unlike -EAGAIN case, the failed page is
+				 * removed from migration page list and not
+				 * retried in the next outer loop.
+				 */
+				nr_failed++;
+				nr_failed_pages += nr_subpages;
+				break;
+			}
+		}
+	}
+	nr_failed += retry;
+	retry = 1;
 thp_subpage_migration:
 	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
 		retry = 0;
@@ -1431,18 +1491,14 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			cond_resched();
 
 			if (PageHuge(page))
-				rc = unmap_and_move_huge_page(get_new_page,
-						put_new_page, private, page,
-						pass > 2, mode, reason,
-						&ret_pages);
-			else
-				rc = unmap_and_move(get_new_page, put_new_page,
+				continue;
+
+			rc = unmap_and_move(get_new_page, put_new_page,
 						private, page, pass > 2, mode,
 						reason, &ret_pages);
 			/*
 			 * The rules are:
-			 *	Success: non hugetlb page will be freed, hugetlb
-			 *		 page will be put back
+			 *	Success: page will be freed
 			 *	-EAGAIN: stay on the from list
 			 *	-ENOMEM: stay on the from list
 			 *	-ENOSYS: stay on the from list
@@ -1468,7 +1524,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 						nr_thp_split++;
 						break;
 					}
-				/* Hugetlb migration is unsupported */
 				} else if (!no_subpage_counting) {
 					nr_failed++;
 				}
-- 
2.35.1


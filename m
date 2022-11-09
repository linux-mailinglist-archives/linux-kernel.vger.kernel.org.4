Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8603762214E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 02:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKIBYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 20:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiKIBYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 20:24:04 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57055E9ED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 17:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667957043; x=1699493043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yoCjLY5a568iSDEpolTlkW/LjTBOESOZ2uhJ1D8VbnI=;
  b=YydOWPO9z3R0X+Sq97cSIh0pZNyFb1frpE6ElNB8Pm0OaQDcdNJ9dTJm
   0ja2eZhF22Dbtk3JE/Wzu2zxOArBt4jUMp3xu6Ac22EEGLKTYV4Pqz2Wk
   21c0eEbyNCavliL5Du8MtO4otrGunHsyKSJkxbILHw47cdhvS9Yc0QvYH
   ZlBBETLhSrr0ZbckDcR1B8D5Ph3Arxmtr2Tt34Ob3mUSeSUkJPdiYj8P0
   kZ1Lni1FpXVZO7dy2Shs+seY6FKIiU5OXXxej+JBuIAFw+4aoC6IPuhe+
   UG3+D6Gi8O8HZrsXusdtTVmFfOPYIkUlgPR/U5K8tXkoBjgZkwqE+v3yk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="298374467"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="298374467"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 17:24:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="881731723"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="881731723"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.69])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 17:23:58 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH -V2 1/2] migrate: convert unmap_and_move() to use folios
Date:   Wed,  9 Nov 2022 09:23:47 +0800
Message-Id: <20221109012348.93849-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221109012348.93849-1-ying.huang@intel.com>
References: <20221109012348.93849-1-ying.huang@intel.com>
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

Quite straightforward, the page functions are converted to
corresponding folio functions.  Same for comments.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
---
 mm/migrate.c | 54 ++++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 4aea647a0180..eed8082664f2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1150,79 +1150,79 @@ static int __unmap_and_move(struct folio *src, struct folio *dst,
 }
 
 /*
- * Obtain the lock on page, remove all ptes and migrate the page
- * to the newly allocated page in newpage.
+ * Obtain the lock on folio, remove all ptes and migrate the folio
+ * to the newly allocated folio in dst.
  */
 static int unmap_and_move(new_page_t get_new_page,
 				   free_page_t put_new_page,
-				   unsigned long private, struct page *page,
+				   unsigned long private, struct folio *src,
 				   int force, enum migrate_mode mode,
 				   enum migrate_reason reason,
 				   struct list_head *ret)
 {
-	struct folio *dst, *src = page_folio(page);
+	struct folio *dst;
 	int rc = MIGRATEPAGE_SUCCESS;
 	struct page *newpage = NULL;
 
-	if (!thp_migration_supported() && PageTransHuge(page))
+	if (!thp_migration_supported() && folio_test_transhuge(src))
 		return -ENOSYS;
 
-	if (page_count(page) == 1) {
-		/* Page was freed from under us. So we are done. */
-		ClearPageActive(page);
-		ClearPageUnevictable(page);
+	if (folio_ref_count(src) == 1) {
+		/* Folio was freed from under us. So we are done. */
+		folio_clear_active(src);
+		folio_clear_unevictable(src);
 		/* free_pages_prepare() will clear PG_isolated. */
 		goto out;
 	}
 
-	newpage = get_new_page(page, private);
+	newpage = get_new_page(&src->page, private);
 	if (!newpage)
 		return -ENOMEM;
 	dst = page_folio(newpage);
 
-	newpage->private = 0;
+	dst->private = 0;
 	rc = __unmap_and_move(src, dst, force, mode);
 	if (rc == MIGRATEPAGE_SUCCESS)
-		set_page_owner_migrate_reason(newpage, reason);
+		set_page_owner_migrate_reason(&dst->page, reason);
 
 out:
 	if (rc != -EAGAIN) {
 		/*
-		 * A page that has been migrated has all references
-		 * removed and will be freed. A page that has not been
+		 * A folio that has been migrated has all references
+		 * removed and will be freed. A folio that has not been
 		 * migrated will have kept its references and be restored.
 		 */
-		list_del(&page->lru);
+		list_del(&src->lru);
 	}
 
 	/*
 	 * If migration is successful, releases reference grabbed during
-	 * isolation. Otherwise, restore the page to right list unless
+	 * isolation. Otherwise, restore the folio to right list unless
 	 * we want to retry.
 	 */
 	if (rc == MIGRATEPAGE_SUCCESS) {
 		/*
-		 * Compaction can migrate also non-LRU pages which are
+		 * Compaction can migrate also non-LRU folios which are
 		 * not accounted to NR_ISOLATED_*. They can be recognized
-		 * as __PageMovable
+		 * as __folio_test_movable
 		 */
-		if (likely(!__PageMovable(page)))
-			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
-					page_is_file_lru(page), -thp_nr_pages(page));
+		if (likely(!__folio_test_movable(src)))
+			mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
+					folio_is_file_lru(src), -folio_nr_pages(src));
 
 		if (reason != MR_MEMORY_FAILURE)
 			/*
-			 * We release the page in page_handle_poison.
+			 * We release the folio in page_handle_poison.
 			 */
-			put_page(page);
+			folio_put(src);
 	} else {
 		if (rc != -EAGAIN)
-			list_add_tail(&page->lru, ret);
+			list_add_tail(&src->lru, ret);
 
 		if (put_new_page)
-			put_new_page(newpage, private);
+			put_new_page(&dst->page, private);
 		else
-			put_page(newpage);
+			folio_put(dst);
 	}
 
 	return rc;
@@ -1459,7 +1459,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 						&ret_pages);
 			else
 				rc = unmap_and_move(get_new_page, put_new_page,
-						private, page, pass > 2, mode,
+						private, page_folio(page), pass > 2, mode,
 						reason, &ret_pages);
 			/*
 			 * The rules are:
-- 
2.35.1


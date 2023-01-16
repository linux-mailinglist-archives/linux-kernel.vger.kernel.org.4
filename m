Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4D566B778
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 07:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjAPGcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 01:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjAPGbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 01:31:41 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F290CC20
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 22:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673850691; x=1705386691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IWllhTG0GdPmuukl+DFwxPlkS3OUSn/9WM3n7s2+yfw=;
  b=SFWFKENIEL3uQKI9o5Fen69fU3t59O6a+kK41TKS/9OrxkD+DI/SnLZW
   ptVwnxXXD+vQZgtVzOyzfr0Rn5AZiRRgQgtGXNjlcnCva/e4Pe6PEDK54
   09QbHXZVi0J81e80unhnp+tRVu7qjHliVtB6xR8EbQJT6qwNoRkY8W+/C
   W6Qm2ioC6PPLi4zdryhEDHjkL6diN3hqbYfngwoix/LG6qmaah/BECb/J
   FhFrzI0BUs2uk6SI8Kvmn/B2XoVTTqsBBsPSXUS+GAEcWBRtXzGILeOKo
   Lw76Y+zOQ50x1xoU4349MPepuqzZLu2ZhFLorV25Tjf30AO7+T6xQpdU4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="388892192"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="388892192"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 22:31:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="801286676"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="801286676"
Received: from tiangeng-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.220])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 22:31:27 -0800
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
        haoxin <xhao@linux.alibaba.com>, Minchan Kim <minchan@kernel.org>
Subject: [PATCH -v3 6/9] migrate_pages: move migrate_folio_unmap()
Date:   Mon, 16 Jan 2023 14:30:54 +0800
Message-Id: <20230116063057.653862-7-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230116063057.653862-1-ying.huang@intel.com>
References: <20230116063057.653862-1-ying.huang@intel.com>
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

Just move the position of the functions.  There's no any functionality
change.  This is to make it easier to review the next patch via
putting code near its position in the next patch.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: haoxin <xhao@linux.alibaba.com>
Cc: Minchan Kim <minchan@kernel.org>
---
 mm/migrate.c | 102 +++++++++++++++++++++++++--------------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 143d96775b4d..a25966233923 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1218,6 +1218,57 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
 	return rc;
 }
 
+/* Obtain the lock on page, remove all ptes. */
+static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page,
+			       unsigned long private, struct folio *src,
+			       struct folio **dstp, int force, bool force_lock,
+			       enum migrate_mode mode, enum migrate_reason reason,
+			       struct list_head *ret)
+{
+	struct folio *dst;
+	int rc = MIGRATEPAGE_UNMAP;
+	struct page *newpage = NULL;
+
+	if (!thp_migration_supported() && folio_test_transhuge(src))
+		return -ENOSYS;
+
+	if (folio_ref_count(src) == 1) {
+		/* Folio was freed from under us. So we are done. */
+		folio_clear_active(src);
+		folio_clear_unevictable(src);
+		/* free_pages_prepare() will clear PG_isolated. */
+		list_del(&src->lru);
+		migrate_folio_done(src, reason);
+		return MIGRATEPAGE_SUCCESS;
+	}
+
+	newpage = get_new_page(&src->page, private);
+	if (!newpage)
+		return -ENOMEM;
+	dst = page_folio(newpage);
+	*dstp = dst;
+
+	dst->private = NULL;
+	rc = __migrate_folio_unmap(src, dst, force, force_lock, mode);
+	if (rc == MIGRATEPAGE_UNMAP)
+		return rc;
+
+	/*
+	 * A page that has not been migrated will have kept its
+	 * references and be restored.
+	 */
+	/* restore the folio to right list. */
+	if (rc != -EAGAIN && rc != -EDEADLOCK)
+		list_move_tail(&src->lru, ret);
+
+	if (put_new_page)
+		put_new_page(&dst->page, private);
+	else
+		folio_put(dst);
+
+	return rc;
+}
+
 static int __migrate_folio_move(struct folio *src, struct folio *dst,
 				enum migrate_mode mode)
 {
@@ -1277,57 +1328,6 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
 	return rc;
 }
 
-/* Obtain the lock on page, remove all ptes. */
-static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page,
-			       unsigned long private, struct folio *src,
-			       struct folio **dstp, int force, bool force_lock,
-			       enum migrate_mode mode, enum migrate_reason reason,
-			       struct list_head *ret)
-{
-	struct folio *dst;
-	int rc = MIGRATEPAGE_UNMAP;
-	struct page *newpage = NULL;
-
-	if (!thp_migration_supported() && folio_test_transhuge(src))
-		return -ENOSYS;
-
-	if (folio_ref_count(src) == 1) {
-		/* Folio was freed from under us. So we are done. */
-		folio_clear_active(src);
-		folio_clear_unevictable(src);
-		/* free_pages_prepare() will clear PG_isolated. */
-		list_del(&src->lru);
-		migrate_folio_done(src, reason);
-		return MIGRATEPAGE_SUCCESS;
-	}
-
-	newpage = get_new_page(&src->page, private);
-	if (!newpage)
-		return -ENOMEM;
-	dst = page_folio(newpage);
-	*dstp = dst;
-
-	dst->private = NULL;
-	rc = __migrate_folio_unmap(src, dst, force, force_lock, mode);
-	if (rc == MIGRATEPAGE_UNMAP)
-		return rc;
-
-	/*
-	 * A page that has not been migrated will have kept its
-	 * references and be restored.
-	 */
-	/* restore the folio to right list. */
-	if (rc != -EAGAIN && rc != -EDEADLOCK)
-		list_move_tail(&src->lru, ret);
-
-	if (put_new_page)
-		put_new_page(&dst->page, private);
-	else
-		folio_put(dst);
-
-	return rc;
-}
-
 /* Migrate the folio to the newly allocated folio in dst. */
 static int migrate_folio_move(free_page_t put_new_page, unsigned long private,
 			      struct folio *src, struct folio *dst,
-- 
2.35.1


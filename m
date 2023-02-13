Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FAA6945F1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjBMMgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjBMMfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:35:53 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3C315CBE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676291739; x=1707827739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K4XDKropeMr7/ju8eX1ZAYnD0sjioz6DP3VREqBtsko=;
  b=Z5IL4tn+SAjmtk9Cb0hGD6JeBSGVeCuX3kdGF92hkdMoza6R3npUTXiO
   vVeb47nCxQsa01C4PK8xprXf/wR0pAsmDXVbnD5XUllFhoFVe8up2b1I3
   eoQgDARSTFARF2f2XdMVlBzWyRkTM7S2XVXGHBBLjJs05EcweBaVT05Zt
   xteyeli2vK/1s9slGqlE+i5tgrgj+MpUx1qpWP2M6Tr+PMkdJbIzAOf+n
   oHlxMv03DHs0dC64lQR6wZXJ7QCkbDZB475ohgAkAp8RgTUMwGNMTlwbc
   h47bqVIvdxK8jKJzfNMUhvCUX0Ax2TyQMrDSG5fST2I9UsiqD+HEo6Xx1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="310513267"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="310513267"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 04:35:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="646366651"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="646366651"
Received: from changxin-mobl2.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.171])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 04:35:35 -0800
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
        Xin Hao <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH -v5 6/9] migrate_pages: move migrate_folio_unmap()
Date:   Mon, 13 Feb 2023 20:34:41 +0800
Message-Id: <20230213123444.155149-7-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230213123444.155149-1-ying.huang@intel.com>
References: <20230213123444.155149-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just move the position of the functions.  There's no any functionality
change.  This is to make it easier to review the next patch via
putting code near its position in the next patch.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Xin Hao <xhao@linux.alibaba.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/migrate.c | 100 +++++++++++++++++++++++++--------------------------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index ee3e21f1061c..0c7488ebe248 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1236,6 +1236,56 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst, int force
 	return rc;
 }
 
+/* Obtain the lock on page, remove all ptes. */
+static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page,
+			       unsigned long private, struct folio *src,
+			       struct folio **dstp, int force, bool avoid_force_lock,
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
+	rc = __migrate_folio_unmap(src, dst, force, avoid_force_lock, mode);
+	if (rc == MIGRATEPAGE_UNMAP)
+		return rc;
+
+	/*
+	 * A folio that has not been unmapped will be restored to
+	 * right list unless we want to retry.
+	 */
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
@@ -1296,56 +1346,6 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
 	return rc;
 }
 
-/* Obtain the lock on page, remove all ptes. */
-static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page,
-			       unsigned long private, struct folio *src,
-			       struct folio **dstp, int force, bool avoid_force_lock,
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
-	rc = __migrate_folio_unmap(src, dst, force, avoid_force_lock, mode);
-	if (rc == MIGRATEPAGE_UNMAP)
-		return rc;
-
-	/*
-	 * A folio that has not been unmapped will be restored to
-	 * right list unless we want to retry.
-	 */
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


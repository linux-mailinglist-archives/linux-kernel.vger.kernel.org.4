Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A528168C328
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjBFQZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBFQZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:25:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E201DB86
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EmvsNc/fNNCqQFlmART0Ciul5K1EvPWXNpRv8kY4JJ8=; b=E3MDzH1w/xhETRMs+vkPf24prX
        meYolBlytktHBxGoiWbdWLqJyceli3AZQPEJdg0PxCBAc3MgKTNBUKpK4updO+wuvtWK5XOvIdAvA
        Y9yw9DDO3WuDVR9rfKTYAXLjteZ/OsnV1pN296p4UE2vmRrdy9ggpNtOqCtxelV1HSpss7mR56ZnM
        SZqQk46Dxmg2RNBc/mT+363viD6EhgdifvCgyWfWrMfXOIRuD5tsc75XRurDeJOsn1nH9p4QFGlS7
        6Okrr57eXr/mGbh03r3P/GnY1hj6SEyscBkYmy7hw77nl9hGIxFNqVht5PjCNw102kvvYmo7QSUik
        1aLCQVOg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pP4JG-00Gu8f-EM; Mon, 06 Feb 2023 16:25:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
        markhemm@googlemail.com, rientjes@google.com, surenb@google.com,
        shakeelb@google.com, mhocko@suse.com, vbabka@suse.cz,
        quic_pkondeti@quicinc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH 2/2] shmem: Add shmem_read_folio() and shmem_read_folio_gfp()
Date:   Mon,  6 Feb 2023 16:25:20 +0000
Message-Id: <20230206162520.4029022-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230206162520.4029022-1-willy@infradead.org>
References: <20230206162520.4029022-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are the folio replacements for shmem_read_mapping_page()
and shmem_read_mapping_page_gfp().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/shmem_fs.h |  8 ++++++++
 mm/shmem.c               | 34 +++++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index d09d54be4ffd..103d1000a5a2 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -109,6 +109,14 @@ enum sgp_type {
 
 int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **foliop,
 		enum sgp_type sgp);
+struct folio *shmem_read_folio_gfp(struct address_space *mapping,
+		pgoff_t index, gfp_t gfp);
+
+static inline struct folio *shmem_read_folio(struct address_space *mapping,
+		pgoff_t index)
+{
+	return shmem_read_folio_gfp(mapping, index, mapping_gfp_mask(mapping));
+}
 
 static inline struct page *shmem_read_mapping_page(
 				struct address_space *mapping, pgoff_t index)
diff --git a/mm/shmem.c b/mm/shmem.c
index 28f3c699c8ce..d333deddc2b9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4320,9 +4320,9 @@ int shmem_zero_setup(struct vm_area_struct *vma)
 }
 
 /**
- * shmem_read_mapping_page_gfp - read into page cache, using specified page allocation flags.
- * @mapping:	the page's address_space
- * @index:	the page index
+ * shmem_read_folio_gfp - read into page cache, using specified page allocation flags.
+ * @mapping:	the folio's address_space
+ * @index:	the folio index
  * @gfp:	the page allocator flags to use if allocating
  *
  * This behaves as a tmpfs "read_cache_page_gfp(mapping, index, gfp)",
@@ -4334,13 +4334,12 @@ int shmem_zero_setup(struct vm_area_struct *vma)
  * i915_gem_object_get_pages_gtt() mixes __GFP_NORETRY | __GFP_NOWARN in
  * with the mapping_gfp_mask(), to avoid OOMing the machine unnecessarily.
  */
-struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
-					 pgoff_t index, gfp_t gfp)
+struct folio *shmem_read_folio_gfp(struct address_space *mapping,
+		pgoff_t index, gfp_t gfp)
 {
 #ifdef CONFIG_SHMEM
 	struct inode *inode = mapping->host;
 	struct folio *folio;
-	struct page *page;
 	int error;
 
 	BUG_ON(!shmem_mapping(mapping));
@@ -4350,18 +4349,27 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 		return ERR_PTR(error);
 
 	folio_unlock(folio);
-	page = folio_file_page(folio, index);
+	return folio;
+#else
+	/*
+	 * The tiny !SHMEM case uses ramfs without swap
+	 */
+	return mapping_read_folio_gfp(mapping, index, gfp);
+#endif
+}
+EXPORT_SYMBOL_GPL(shmem_read_folio_gfp);
+
+struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
+					 pgoff_t index, gfp_t gfp)
+{
+	struct folio *folio = shmem_read_folio_gfp(mapping, index, gfp);
+	struct page *page = folio_file_page(folio, index);
+
 	if (PageHWPoison(page)) {
 		folio_put(folio);
 		return ERR_PTR(-EIO);
 	}
 
 	return page;
-#else
-	/*
-	 * The tiny !SHMEM case uses ramfs without swap
-	 */
-	return read_cache_page_gfp(mapping, index, gfp);
-#endif
 }
 EXPORT_SYMBOL_GPL(shmem_read_mapping_page_gfp);
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9D86E0133
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjDLVv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLVv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:51:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF3E448F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:51:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76BE26397A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4070C433EF;
        Wed, 12 Apr 2023 21:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681336283;
        bh=pWM7vq7Zdu7WuUxg21CbTFApSSLmEdHPy/g/M9rEKzs=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Rg4Yot9kE2L6H48x5ApXRLZCw3AZUhyM0x+kvu/jmHVEizhVEptaknfQzdE96ukl7
         jN6g/59XCgskNto8tPxmP75Vf2Z/UJ2lv05I5w9cAjSyl7U+5+XeDFg4nfv8qHyShc
         zLWZM17rt/himcXH86xjc+DCc4tyTuIQKKsFZ9dZHz6OaDPaWp5w4NRORGNdAIB911
         btxaR0ngVfLtPBSZTHxFDpA5n63TR4d0MUl8x9zNUbQy1yvaoOUTs65LSZy9cq1b+h
         A7uaU164aGjy23XJmk7O/YrWTkvJrwldwXMe8G5pQuKLJDOMx0w912IR30rUyGaXKW
         w71llH3Rth9Pw==
Date:   Wed, 12 Apr 2023 14:51:22 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/2 v2] f2fs: remove set|get_private_inline to clean up
Message-ID: <ZDcn2iZ0T1MunCK8@google.com>
References: <20230412160810.1534632-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412160810.1534632-1-jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have maintain PagePrivate and page_private and page reference
w/ {set,clear}_page_private_*, it doesn't need to call
folio_detach_private() in the end of .invalidate_folio and
.release_folio, remove it and use f2fs_bug_on instead.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 - Testing this version which avoid remaining inline_data bit.

 fs/f2fs/data.c |  25 +-------
 fs/f2fs/dir.c  |   6 +-
 fs/f2fs/f2fs.h | 154 ++++++++++++++++++++++++-------------------------
 3 files changed, 77 insertions(+), 108 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5a3636b70f48..f21e3aaa2474 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3726,37 +3726,16 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 			f2fs_remove_dirty_inode(inode);
 		}
 	}
-
-	clear_page_private_reference(&folio->page);
-	clear_page_private_gcing(&folio->page);
-
-	if (test_opt(sbi, COMPRESS_CACHE) &&
-			inode->i_ino == F2FS_COMPRESS_INO(sbi))
-		clear_page_private_data(&folio->page);
-
-	folio_detach_private(folio);
+	clear_page_private_all(&folio->page);
 }
 
 bool f2fs_release_folio(struct folio *folio, gfp_t wait)
 {
-	struct f2fs_sb_info *sbi;
-
 	/* If this is dirty folio, keep private data */
 	if (folio_test_dirty(folio))
 		return false;
 
-	sbi = F2FS_M_SB(folio->mapping);
-	if (test_opt(sbi, COMPRESS_CACHE)) {
-		struct inode *inode = folio->mapping->host;
-
-		if (inode->i_ino == F2FS_COMPRESS_INO(sbi))
-			clear_page_private_data(&folio->page);
-	}
-
-	clear_page_private_reference(&folio->page);
-	clear_page_private_gcing(&folio->page);
-
-	folio_detach_private(folio);
+	clear_page_private_all(&folio->page);
 	return true;
 }
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index d6dd8327e82d..887e55988450 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -905,14 +905,10 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 		f2fs_clear_page_cache_dirty_tag(page);
 		clear_page_dirty_for_io(page);
 		ClearPageUptodate(page);
-
-		clear_page_private_gcing(page);
+		clear_page_private_all(page);
 
 		inode_dec_dirty_pages(dir);
 		f2fs_remove_dirty_inode(dir);
-
-		detach_page_private(page);
-		set_page_private(page, 0);
 	}
 	f2fs_put_page(page, 1);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ede38bcef80e..6cae94d51821 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1398,86 +1398,6 @@ enum {
 	PAGE_PRIVATE_MAX
 };
 
-#define PAGE_PRIVATE_GET_FUNC(name, flagname) \
-static inline bool page_private_##name(struct page *page) \
-{ \
-	return PagePrivate(page) && \
-		test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
-		test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
-}
-
-#define PAGE_PRIVATE_SET_FUNC(name, flagname) \
-static inline void set_page_private_##name(struct page *page) \
-{ \
-	if (!PagePrivate(page)) { \
-		get_page(page); \
-		SetPagePrivate(page); \
-		set_page_private(page, 0); \
-	} \
-	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
-	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
-}
-
-#define PAGE_PRIVATE_CLEAR_FUNC(name, flagname) \
-static inline void clear_page_private_##name(struct page *page) \
-{ \
-	clear_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
-	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) { \
-		set_page_private(page, 0); \
-		if (PagePrivate(page)) { \
-			ClearPagePrivate(page); \
-			put_page(page); \
-		}\
-	} \
-}
-
-PAGE_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
-PAGE_PRIVATE_GET_FUNC(inline, INLINE_INODE);
-PAGE_PRIVATE_GET_FUNC(gcing, ONGOING_MIGRATION);
-PAGE_PRIVATE_GET_FUNC(dummy, DUMMY_WRITE);
-
-PAGE_PRIVATE_SET_FUNC(reference, REF_RESOURCE);
-PAGE_PRIVATE_SET_FUNC(inline, INLINE_INODE);
-PAGE_PRIVATE_SET_FUNC(gcing, ONGOING_MIGRATION);
-PAGE_PRIVATE_SET_FUNC(dummy, DUMMY_WRITE);
-
-PAGE_PRIVATE_CLEAR_FUNC(reference, REF_RESOURCE);
-PAGE_PRIVATE_CLEAR_FUNC(inline, INLINE_INODE);
-PAGE_PRIVATE_CLEAR_FUNC(gcing, ONGOING_MIGRATION);
-PAGE_PRIVATE_CLEAR_FUNC(dummy, DUMMY_WRITE);
-
-static inline unsigned long get_page_private_data(struct page *page)
-{
-	unsigned long data = page_private(page);
-
-	if (!test_bit(PAGE_PRIVATE_NOT_POINTER, &data))
-		return 0;
-	return data >> PAGE_PRIVATE_MAX;
-}
-
-static inline void set_page_private_data(struct page *page, unsigned long data)
-{
-	if (!PagePrivate(page)) {
-		get_page(page);
-		SetPagePrivate(page);
-		set_page_private(page, 0);
-	}
-	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page));
-	page_private(page) |= data << PAGE_PRIVATE_MAX;
-}
-
-static inline void clear_page_private_data(struct page *page)
-{
-	page_private(page) &= GENMASK(PAGE_PRIVATE_MAX - 1, 0);
-	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) {
-		set_page_private(page, 0);
-		if (PagePrivate(page)) {
-			ClearPagePrivate(page);
-			put_page(page);
-		}
-	}
-}
-
 /* For compression */
 enum compress_algorithm_type {
 	COMPRESS_LZO,
@@ -2372,6 +2292,80 @@ void f2fs_printk(struct f2fs_sb_info *sbi, const char *fmt, ...);
 #define f2fs_debug(sbi, fmt, ...)					\
 	f2fs_printk(sbi, KERN_DEBUG fmt, ##__VA_ARGS__)
 
+#define PAGE_PRIVATE_GET_FUNC(name, flagname) \
+static inline bool page_private_##name(struct page *page) \
+{ \
+	return PagePrivate(page) && \
+		test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
+		test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
+}
+
+#define PAGE_PRIVATE_SET_FUNC(name, flagname) \
+static inline void set_page_private_##name(struct page *page) \
+{ \
+	if (!PagePrivate(page)) \
+		attach_page_private(page, (void *)0); \
+	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
+	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
+}
+
+#define PAGE_PRIVATE_CLEAR_FUNC(name, flagname) \
+static inline void clear_page_private_##name(struct page *page) \
+{ \
+	clear_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
+	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) \
+		detach_page_private(page); \
+}
+
+PAGE_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
+PAGE_PRIVATE_GET_FUNC(inline, INLINE_INODE);
+PAGE_PRIVATE_GET_FUNC(gcing, ONGOING_MIGRATION);
+PAGE_PRIVATE_GET_FUNC(dummy, DUMMY_WRITE);
+
+PAGE_PRIVATE_SET_FUNC(reference, REF_RESOURCE);
+PAGE_PRIVATE_SET_FUNC(inline, INLINE_INODE);
+PAGE_PRIVATE_SET_FUNC(gcing, ONGOING_MIGRATION);
+PAGE_PRIVATE_SET_FUNC(dummy, DUMMY_WRITE);
+
+PAGE_PRIVATE_CLEAR_FUNC(reference, REF_RESOURCE);
+PAGE_PRIVATE_CLEAR_FUNC(inline, INLINE_INODE);
+PAGE_PRIVATE_CLEAR_FUNC(gcing, ONGOING_MIGRATION);
+PAGE_PRIVATE_CLEAR_FUNC(dummy, DUMMY_WRITE);
+
+static inline unsigned long get_page_private_data(struct page *page)
+{
+	unsigned long data = page_private(page);
+
+	if (!test_bit(PAGE_PRIVATE_NOT_POINTER, &data))
+		return 0;
+	return data >> PAGE_PRIVATE_MAX;
+}
+
+static inline void set_page_private_data(struct page *page, unsigned long data)
+{
+	if (!PagePrivate(page))
+		attach_page_private(page, (void *)0);
+	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page));
+	page_private(page) |= data << PAGE_PRIVATE_MAX;
+}
+
+static inline void clear_page_private_data(struct page *page)
+{
+	page_private(page) &= GENMASK(PAGE_PRIVATE_MAX - 1, 0);
+	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER))
+		detach_page_private(page);
+}
+
+static inline void clear_page_private_all(struct page *page)
+{
+	clear_page_private_data(page);
+	clear_page_private_reference(page);
+	clear_page_private_gcing(page);
+	clear_page_private_inline(page);
+
+	f2fs_bug_on(F2FS_P_SB(page), page_private(page));
+}
+
 static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 						struct inode *inode,
 						block_t count)
-- 
2.40.0.577.gac1e443424-goog


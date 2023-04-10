Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73996DC534
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjDJJjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjDJJjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:39:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F185D5279
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:39:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CDC761A32
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE72C43443;
        Mon, 10 Apr 2023 09:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681119558;
        bh=hQfvtLSuuwTvz2MLeajEI4NVGlDu7NNc7omUTcL4vyk=;
        h=From:To:Cc:Subject:Date:From;
        b=htSUCPpZOVsAJvoQg2qVAmzMdJCiKS4lo+6ZwcvoOlqUbWTB3wqpm/y06AIPYV2ji
         3IgmKGtIStSoVph9kxLG19iJEhHEC9ZMoBgEAVRqaSDxN3vnn0UDam4DgfgR0mBzDZ
         okDsUILdt9SwNpZT5ruVuVZ1Btoxc5F0iV2xDC+2FJQdfe5Iid3Eh0Koj4nPDXhxk6
         YBx67YCO3UFIh8rWwG0PYXxArMQNtFzkhfMYgjsQw7DfpsUTOcUiFu19YTcPP6eeC8
         bYT9UeFc9r4bVkyUJ5WrFPHxAUl2diDZSf8oRFxtPuM79Xb4gLLurRGsp11N+wEMqR
         z0Il+vRNOftMg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH RFC] f2fs: fix to use spinlock to avoid page.private update race
Date:   Mon, 10 Apr 2023 17:39:12 +0800
Message-Id: <20230410093912.2184557-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There may be subtle race condition, make PagePrivate and page_private
being inconsistent, result in decreasing page count incorrectly,
introduce a per-inode spinlock to avoid such condition.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h  | 19 ++++++++++++++++++-
 fs/f2fs/super.c |  2 ++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c378aedcadea..6b31bef5853e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -856,6 +856,8 @@ struct f2fs_inode_info {
 
 	unsigned int atomic_write_cnt;
 	loff_t original_i_size;		/* original i_size before atomic write */
+
+	spinlock_t private_lock;	/* protect page->private */
 };
 
 static inline void get_read_extent_info(struct extent_info *ext,
@@ -1413,21 +1415,28 @@ static inline bool page_private_##name(struct page *page) \
 		test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
 }
 
+static inline struct f2fs_inode_info *F2FS_I(struct inode *inode);
 #define PAGE_PRIVATE_SET_FUNC(name, flagname) \
 static inline void set_page_private_##name(struct page *page) \
 { \
+	unsigned long flags; \
+	spin_lock_irqsave(&F2FS_I(page->mapping->host)->private_lock, flags); \
 	if (!PagePrivate(page)) \
 		attach_page_private(page, (void *)page->private); \
 	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
 	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
+	spin_unlock_irqrestore(&F2FS_I(page->mapping->host)->private_lock, flags); \
 }
 
 #define PAGE_PRIVATE_CLEAR_FUNC(name, flagname) \
 static inline void clear_page_private_##name(struct page *page) \
 { \
+	unsigned long flags; \
+	spin_lock_irqsave(&F2FS_I(page->mapping->host)->private_lock, flags); \
 	clear_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
-	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) \
+	if (page_private(page) == (BIT(PAGE_PRIVATE_NOT_POINTER))) \
 		detach_page_private(page); \
+	spin_unlock_irqrestore(&F2FS_I(page->mapping->host)->private_lock, flags); \
 }
 
 PAGE_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
@@ -1456,17 +1465,25 @@ static inline unsigned long get_page_private_data(struct page *page)
 
 static inline void set_page_private_data(struct page *page, unsigned long data)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&F2FS_I(page->mapping->host)->private_lock, flags);
 	if (!PagePrivate(page))
 		attach_page_private(page, 0);
 	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page));
 	page_private(page) |= data << PAGE_PRIVATE_MAX;
+	spin_unlock_irqrestore(&F2FS_I(page->mapping->host)->private_lock, flags);
 }
 
 static inline void clear_page_private_data(struct page *page)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&F2FS_I(page->mapping->host)->private_lock, flags);
 	page_private(page) &= GENMASK(PAGE_PRIVATE_MAX - 1, 0);
 	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER))
 		detach_page_private(page);
+	spin_unlock_irqrestore(&F2FS_I(page->mapping->host)->private_lock, flags);
 }
 
 /* For compression */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a1b570a5e50f..555424dd85fd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1419,6 +1419,8 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	init_f2fs_rwsem(&fi->i_gc_rwsem[WRITE]);
 	init_f2fs_rwsem(&fi->i_xattr_sem);
 
+	spin_lock_init(&fi->private_lock);
+
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
 
-- 
2.25.1


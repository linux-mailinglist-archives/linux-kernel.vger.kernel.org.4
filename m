Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126796430D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiLESzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiLESy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:54:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E938420374
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 10:54:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DEDDB811F3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 18:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264F6C433D7;
        Mon,  5 Dec 2022 18:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670266493;
        bh=E+D8xdk5gqXIgVYmLrJvIyPn/PYJmfpR6rUrWPbhCjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QFvBYziK8cRaHdll5daziqREyoc6Qd+2lCufAes2gM0ZsAMnAIsId2e59+3b9ro7d
         P8Ea0sTJlPte9+ytyq1TxkQ3iTkinlMIHDKVs4j/TxVt2UXm1/7AfLNjX9DW8p2pec
         Uz6w7Tb/FiWAvTQCj41L7CnFOLhMFJjcWgUWo0xIRhvZ5sAKbC3RfCLRf/NTQi/yQv
         fN+EXdNTegX+i030gfXk09nkMo3FIRnqiyC1VAiXAoeizFaV7TElE/7ulw3rZUSCoH
         jol6ogK4qRY5mCtomqNjJhQS02goPcMx0F9QLtzOq6pAs/HKNkWmVMnlU1aynoIUto
         wiTfzx3GHek2Q==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/6] f2fs: allocate the extent_cache by default
Date:   Mon,  5 Dec 2022 10:54:32 -0800
Message-Id: <20221205185433.3479699-5-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221205185433.3479699-1-jaegeuk@kernel.org>
References: <20221205185433.3479699-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's allocate it to remove the runtime complexity.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/extent_cache.c | 38 +++++++++++++++++++-------------------
 fs/f2fs/f2fs.h         |  3 ++-
 fs/f2fs/inode.c        |  6 ++++--
 fs/f2fs/namei.c        |  4 ++--
 4 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 654a14ab8977..305f969e3ad1 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -47,20 +47,23 @@ static bool __may_read_extent_tree(struct inode *inode)
 	return S_ISREG(inode->i_mode);
 }
 
-static bool __may_extent_tree(struct inode *inode, enum extent_type type)
+static bool __init_may_extent_tree(struct inode *inode, enum extent_type type)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	if (type == EX_READ)
+		return __may_read_extent_tree(inode);
+	return false;
+}
 
+static bool __may_extent_tree(struct inode *inode, enum extent_type type)
+{
 	/*
 	 * for recovered files during mount do not create extents
 	 * if shrinker is not registered.
 	 */
-	if (list_empty(&sbi->s_list))
+	if (list_empty(&F2FS_I_SB(inode)->s_list))
 		return false;
 
-	if (type == EX_READ)
-		return __may_read_extent_tree(inode);
-	return false;
+	return __init_may_extent_tree(inode, type);
 }
 
 static void __try_update_largest_extent(struct extent_tree *et,
@@ -439,20 +442,18 @@ static void __drop_largest_extent(struct extent_tree *et,
 	}
 }
 
-/* return true, if inode page is changed */
-static void __f2fs_init_extent_tree(struct inode *inode, struct page *ipage,
-							enum extent_type type)
+void f2fs_init_read_extent_tree(struct inode *inode, struct page *ipage)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_tree_info *eti = &sbi->extent_tree[type];
-	struct f2fs_extent *i_ext = ipage ? &F2FS_INODE(ipage)->i_ext : NULL;
+	struct extent_tree_info *eti = &sbi->extent_tree[EX_READ];
+	struct f2fs_extent *i_ext = &F2FS_INODE(ipage)->i_ext;
 	struct extent_tree *et;
 	struct extent_node *en;
 	struct extent_info ei;
 
-	if (!__may_extent_tree(inode, type)) {
+	if (!__may_extent_tree(inode, EX_READ)) {
 		/* drop largest read extent */
-		if (type == EX_READ && i_ext && i_ext->len) {
+		if (i_ext && i_ext->len) {
 			f2fs_wait_on_page_writeback(ipage, NODE, true, true);
 			i_ext->len = 0;
 			set_page_dirty(ipage);
@@ -460,13 +461,11 @@ static void __f2fs_init_extent_tree(struct inode *inode, struct page *ipage,
 		goto out;
 	}
 
-	et = __grab_extent_tree(inode, type);
+	et = __grab_extent_tree(inode, EX_READ);
 
 	if (!i_ext || !i_ext->len)
 		goto out;
 
-	BUG_ON(type != EX_READ);
-
 	get_read_extent_info(&ei, i_ext);
 
 	write_lock(&et->lock);
@@ -486,14 +485,15 @@ static void __f2fs_init_extent_tree(struct inode *inode, struct page *ipage,
 unlock_out:
 	write_unlock(&et->lock);
 out:
-	if (type == EX_READ && !F2FS_I(inode)->extent_tree[EX_READ])
+	if (!F2FS_I(inode)->extent_tree[EX_READ])
 		set_inode_flag(inode, FI_NO_EXTENT);
 }
 
-void f2fs_init_extent_tree(struct inode *inode, struct page *ipage)
+void f2fs_init_extent_tree(struct inode *inode)
 {
 	/* initialize read cache */
-	__f2fs_init_extent_tree(inode, ipage, EX_READ);
+	if (__init_may_extent_tree(inode, EX_READ))
+		__grab_extent_tree(inode, EX_READ);
 }
 
 static bool __lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 003b04b10109..ff940cba4600 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4150,7 +4150,7 @@ struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
 		bool force, bool *leftmost);
 bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
 				struct rb_root_cached *root, bool check_key);
-void f2fs_init_extent_tree(struct inode *inode, struct page *ipage);
+void f2fs_init_extent_tree(struct inode *inode);
 void f2fs_drop_extent_tree(struct inode *inode);
 void f2fs_destroy_extent_node(struct inode *inode);
 void f2fs_destroy_extent_tree(struct inode *inode);
@@ -4159,6 +4159,7 @@ int __init f2fs_create_extent_cache(void);
 void f2fs_destroy_extent_cache(void);
 
 /* read extent cache ops */
+void f2fs_init_read_extent_tree(struct inode *inode, struct page *ipage);
 bool f2fs_lookup_read_extent_cache(struct inode *inode, pgoff_t pgofs,
 			struct extent_info *ei);
 void f2fs_update_read_extent_cache(struct dnode_of_data *dn);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 086f201f15a0..c845c16f97d0 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -392,8 +392,6 @@ static int do_read_inode(struct inode *inode)
 	fi->i_pino = le32_to_cpu(ri->i_pino);
 	fi->i_dir_level = ri->i_dir_level;
 
-	f2fs_init_extent_tree(inode, node_page);
-
 	get_inline_info(inode, ri);
 
 	fi->i_extra_isize = f2fs_has_extra_attr(inode) ?
@@ -479,6 +477,10 @@ static int do_read_inode(struct inode *inode)
 	}
 
 	init_idisk_time(inode);
+
+	/* Need all the flag bits */
+	f2fs_init_read_extent_tree(inode, node_page);
+
 	f2fs_put_page(node_page, 1);
 
 	stat_inc_inline_xattr(inode);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 58a91ce8fe08..46de782c2baa 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -284,8 +284,6 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
 	}
 	F2FS_I(inode)->i_inline_xattr_size = xattr_size;
 
-	f2fs_init_extent_tree(inode, NULL);
-
 	F2FS_I(inode)->i_flags =
 		f2fs_mask_flags(mode, F2FS_I(dir)->i_flags & F2FS_FL_INHERITED);
 
@@ -311,6 +309,8 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
 
 	f2fs_set_inode_flags(inode);
 
+	f2fs_init_extent_tree(inode);
+
 	trace_f2fs_new_inode(inode, 0);
 	return inode;
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog


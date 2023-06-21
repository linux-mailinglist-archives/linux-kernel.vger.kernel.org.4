Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E4A7387FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjFUOyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjFUOxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:53:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EAB30E4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC7B3612B7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A32C433C8;
        Wed, 21 Jun 2023 14:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358974;
        bh=+guKJI0dr1zSxzHN9bTzMEKvLYnDM+NtgQTgRIMc65c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=blC+PfP4jXg6TdvGJNSV5geEw+cWTNg1vwgxJIcw0aoPhH+EjOEulIMpCQtnTbJyv
         pyxhdmraM2/owfebuO9zuEJ38n1BHD4FUB/d2ksLu6tDD7XRPB8fHd8o5WJ/oTXqVZ
         FfV+OpBHE06F+jB4zaz0H6BavKE2TbhitkArN65vp1GxKA/9Thv+z7/YrnIkyaYIFQ
         TDIlwKs6/BY5kQSDOXjFQB7/3yD4Vuwtug2uVKXDJSAG8Q6CoAs4dD1+u5bCf7qjxa
         k0X4Mu0D70o9S7G1syqZ+DE5wQTMOAvORnZtac01XNFkOlRtEH0o9+n+QdvuJgEDlc
         w8wKqSAtKb3Tg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Evgeniy Dushistov <dushistov@mail.ru>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 68/79] ufs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:21 -0400
Message-ID: <20230621144735.55953-67-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ufs/dir.c    |  6 +++---
 fs/ufs/ialloc.c |  2 +-
 fs/ufs/inode.c  | 23 +++++++++++++----------
 fs/ufs/namei.c  |  8 ++++----
 4 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 379d75796a5c..0ccd32ab7ffc 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -107,7 +107,7 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 	ufs_commit_chunk(page, pos, len);
 	ufs_put_page(page);
 	if (update_times)
-		dir->i_mtime = dir->i_ctime = current_time(dir);
+		dir->i_mtime = inode_ctime_set_current(dir);
 	mark_inode_dirty(dir);
 	ufs_handle_dirsync(dir);
 }
@@ -397,7 +397,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	ufs_set_de_type(sb, de, inode->i_mode);
 
 	ufs_commit_chunk(page, pos, rec_len);
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 
 	mark_inode_dirty(dir);
 	err = ufs_handle_dirsync(dir);
@@ -539,7 +539,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 		pde->d_reclen = cpu_to_fs16(sb, to - from);
 	dir->d_ino = 0;
 	ufs_commit_chunk(page, pos, to - from);
-	inode->i_ctime = inode->i_mtime = current_time(inode);
+	inode->i_mtime = inode_ctime_set_current(inode);
 	mark_inode_dirty(inode);
 	err = ufs_handle_dirsync(inode);
 out:
diff --git a/fs/ufs/ialloc.c b/fs/ufs/ialloc.c
index 06bd84d555bd..3d64f7b3aba1 100644
--- a/fs/ufs/ialloc.c
+++ b/fs/ufs/ialloc.c
@@ -292,7 +292,7 @@ struct inode *ufs_new_inode(struct inode *dir, umode_t mode)
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	inode->i_blocks = 0;
 	inode->i_generation = 0;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 	ufsi->i_flags = UFS_I(dir)->i_flags;
 	ufsi->i_lastfrag = 0;
 	ufsi->i_shadow = 0;
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index a4246c83a8cd..64242e1378d6 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -296,7 +296,7 @@ ufs_inode_getfrag(struct inode *inode, unsigned index,
 
 	if (new)
 		*new = 1;
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	if (IS_SYNC(inode))
 		ufs_sync_inode (inode);
 	mark_inode_dirty(inode);
@@ -378,7 +378,7 @@ ufs_inode_getblock(struct inode *inode, u64 ind_block,
 	mark_buffer_dirty(bh);
 	if (IS_SYNC(inode))
 		sync_dirty_buffer(bh);
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	mark_inode_dirty(inode);
 out:
 	brelse (bh);
@@ -580,11 +580,12 @@ static int ufs1_read_inode(struct inode *inode, struct ufs_inode *ufs_inode)
 
 	inode->i_size = fs64_to_cpu(sb, ufs_inode->ui_size);
 	inode->i_atime.tv_sec = (signed)fs32_to_cpu(sb, ufs_inode->ui_atime.tv_sec);
-	inode->i_ctime.tv_sec = (signed)fs32_to_cpu(sb, ufs_inode->ui_ctime.tv_sec);
+	inode_ctime_set_sec(inode,
+			    (signed)fs32_to_cpu(sb, ufs_inode->ui_ctime.tv_sec));
 	inode->i_mtime.tv_sec = (signed)fs32_to_cpu(sb, ufs_inode->ui_mtime.tv_sec);
 	inode->i_mtime.tv_nsec = 0;
 	inode->i_atime.tv_nsec = 0;
-	inode->i_ctime.tv_nsec = 0;
+	inode_ctime_set_nsec(inode, 0);
 	inode->i_blocks = fs32_to_cpu(sb, ufs_inode->ui_blocks);
 	inode->i_generation = fs32_to_cpu(sb, ufs_inode->ui_gen);
 	ufsi->i_flags = fs32_to_cpu(sb, ufs_inode->ui_flags);
@@ -626,10 +627,10 @@ static int ufs2_read_inode(struct inode *inode, struct ufs2_inode *ufs2_inode)
 
 	inode->i_size = fs64_to_cpu(sb, ufs2_inode->ui_size);
 	inode->i_atime.tv_sec = fs64_to_cpu(sb, ufs2_inode->ui_atime);
-	inode->i_ctime.tv_sec = fs64_to_cpu(sb, ufs2_inode->ui_ctime);
+	inode_ctime_set_sec(inode, fs64_to_cpu(sb, ufs2_inode->ui_ctime));
 	inode->i_mtime.tv_sec = fs64_to_cpu(sb, ufs2_inode->ui_mtime);
 	inode->i_atime.tv_nsec = fs32_to_cpu(sb, ufs2_inode->ui_atimensec);
-	inode->i_ctime.tv_nsec = fs32_to_cpu(sb, ufs2_inode->ui_ctimensec);
+	inode_ctime_set_nsec(inode, fs32_to_cpu(sb, ufs2_inode->ui_ctimensec));
 	inode->i_mtime.tv_nsec = fs32_to_cpu(sb, ufs2_inode->ui_mtimensec);
 	inode->i_blocks = fs64_to_cpu(sb, ufs2_inode->ui_blocks);
 	inode->i_generation = fs32_to_cpu(sb, ufs2_inode->ui_gen);
@@ -726,7 +727,8 @@ static void ufs1_update_inode(struct inode *inode, struct ufs_inode *ufs_inode)
 	ufs_inode->ui_size = cpu_to_fs64(sb, inode->i_size);
 	ufs_inode->ui_atime.tv_sec = cpu_to_fs32(sb, inode->i_atime.tv_sec);
 	ufs_inode->ui_atime.tv_usec = 0;
-	ufs_inode->ui_ctime.tv_sec = cpu_to_fs32(sb, inode->i_ctime.tv_sec);
+	ufs_inode->ui_ctime.tv_sec = cpu_to_fs32(sb,
+						 inode_ctime_peek(inode).tv_sec);
 	ufs_inode->ui_ctime.tv_usec = 0;
 	ufs_inode->ui_mtime.tv_sec = cpu_to_fs32(sb, inode->i_mtime.tv_sec);
 	ufs_inode->ui_mtime.tv_usec = 0;
@@ -770,8 +772,9 @@ static void ufs2_update_inode(struct inode *inode, struct ufs2_inode *ufs_inode)
 	ufs_inode->ui_size = cpu_to_fs64(sb, inode->i_size);
 	ufs_inode->ui_atime = cpu_to_fs64(sb, inode->i_atime.tv_sec);
 	ufs_inode->ui_atimensec = cpu_to_fs32(sb, inode->i_atime.tv_nsec);
-	ufs_inode->ui_ctime = cpu_to_fs64(sb, inode->i_ctime.tv_sec);
-	ufs_inode->ui_ctimensec = cpu_to_fs32(sb, inode->i_ctime.tv_nsec);
+	ufs_inode->ui_ctime = cpu_to_fs64(sb, inode_ctime_peek(inode).tv_sec);
+	ufs_inode->ui_ctimensec = cpu_to_fs32(sb,
+					      inode_ctime_peek(inode).tv_nsec);
 	ufs_inode->ui_mtime = cpu_to_fs64(sb, inode->i_mtime.tv_sec);
 	ufs_inode->ui_mtimensec = cpu_to_fs32(sb, inode->i_mtime.tv_nsec);
 
@@ -1205,7 +1208,7 @@ static int ufs_truncate(struct inode *inode, loff_t size)
 	truncate_setsize(inode, size);
 
 	ufs_truncate_blocks(inode);
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_ctime_set_current(inode);
 	mark_inode_dirty(inode);
 out:
 	UFSD("EXIT: err %d\n", err);
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 36154b5aca6d..d3f69e3c6965 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -153,7 +153,7 @@ static int ufs_link (struct dentry * old_dentry, struct inode * dir,
 	struct inode *inode = d_inode(old_dentry);
 	int error;
 
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	inode_inc_link_count(inode);
 	ihold(inode);
 
@@ -220,7 +220,7 @@ static int ufs_unlink(struct inode *dir, struct dentry *dentry)
 	if (err)
 		goto out;
 
-	inode->i_ctime = dir->i_ctime;
+	inode_ctime_set(inode, inode_ctime_peek(dir));
 	inode_dec_link_count(inode);
 	err = 0;
 out:
@@ -282,7 +282,7 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		if (!new_de)
 			goto out_dir;
 		ufs_set_link(new_dir, new_de, new_page, old_inode, 1);
-		new_inode->i_ctime = current_time(new_inode);
+		inode_ctime_set_current(new_inode);
 		if (dir_de)
 			drop_nlink(new_inode);
 		inode_dec_link_count(new_inode);
@@ -298,7 +298,7 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	 * Like most other Unix systems, set the ctime for inodes on a
  	 * rename.
 	 */
-	old_inode->i_ctime = current_time(old_inode);
+	inode_ctime_set_current(old_inode);
 
 	ufs_delete_entry(old_dir, old_de, old_page);
 	mark_inode_dirty(old_inode);
-- 
2.41.0


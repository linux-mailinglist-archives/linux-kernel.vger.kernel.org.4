Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEA17387F2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjFUOxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjFUOwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:52:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3BC1FD8;
        Wed, 21 Jun 2023 07:49:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B9DB6159F;
        Wed, 21 Jun 2023 14:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AD7C433C0;
        Wed, 21 Jun 2023 14:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358937;
        bh=YI0ekcjuxgrtvDegmv/g98VNDJqmIL3E+j0N+sr4RfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ph+klMpFn0NnfmWDST8YV5l2WD5+GGXP+55Ibv5XHUI/SRE5Rr/QHhu2wb8qKDC9Q
         SWDk5P/k+cbkLXA+CwywekH6U6HMgeFh0407se6Rlngxd2yKsV+T9TmYO+W1WER6Vf
         371BWyAvTsp711mSR+V11XY/nphXVkkbyY+0NrHnVBhTP5STIpc9vy6nNdmB3WxOin
         PzZRehXRlOMo4BMoFb/m/jq6As/dcZS3VWvNQKw4o3NOvpngL7Dwett3bMy+ug6n4C
         wdVzRonhZu7dlbfp8YkNt/uJydCOnjOoNzsGbV9AWYaxWEVeqs2sy44KWlWxQe6q7p
         nsYTR01hDaY9w==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 47/79] nilfs2: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:00 -0400
Message-ID: <20230621144735.55953-46-jlayton@kernel.org>
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
 fs/nilfs2/dir.c   |  6 +++---
 fs/nilfs2/inode.c | 12 ++++++------
 fs/nilfs2/ioctl.c |  2 +-
 fs/nilfs2/namei.c |  8 ++++----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index decd6471300b..a51d13a95651 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -429,7 +429,7 @@ void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
 	nilfs_set_de_type(de, inode);
 	nilfs_commit_chunk(page, mapping, from, to);
 	nilfs_put_page(page);
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 }
 
 /*
@@ -519,7 +519,7 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 	de->inode = cpu_to_le64(inode->i_ino);
 	nilfs_set_de_type(de, inode);
 	nilfs_commit_chunk(page, page->mapping, from, to);
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	nilfs_mark_inode_dirty(dir);
 	/* OFFSET_CACHE */
 out_put:
@@ -567,7 +567,7 @@ int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
 		pde->rec_len = nilfs_rec_len_to_disk(to - from);
 	dir->inode = 0;
 	nilfs_commit_chunk(page, mapping, from, to);
-	inode->i_ctime = inode->i_mtime = current_time(inode);
+	inode->i_mtime = inode_ctime_set_current(inode);
 out:
 	nilfs_put_page(page);
 	return err;
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index a8ce522ac747..dee831f7426f 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -366,7 +366,7 @@ struct inode *nilfs_new_inode(struct inode *dir, umode_t mode)
 	atomic64_inc(&root->inodes_count);
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	inode->i_ino = ino;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 
 	if (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)) {
 		err = nilfs_bmap_read(ii->i_bmap, NULL);
@@ -450,10 +450,10 @@ int nilfs_read_inode_common(struct inode *inode,
 	set_nlink(inode, le16_to_cpu(raw_inode->i_links_count));
 	inode->i_size = le64_to_cpu(raw_inode->i_size);
 	inode->i_atime.tv_sec = le64_to_cpu(raw_inode->i_mtime);
-	inode->i_ctime.tv_sec = le64_to_cpu(raw_inode->i_ctime);
+	inode_ctime_set_sec(inode, le64_to_cpu(raw_inode->i_ctime));
 	inode->i_mtime.tv_sec = le64_to_cpu(raw_inode->i_mtime);
 	inode->i_atime.tv_nsec = le32_to_cpu(raw_inode->i_mtime_nsec);
-	inode->i_ctime.tv_nsec = le32_to_cpu(raw_inode->i_ctime_nsec);
+	inode_ctime_set_nsec(inode, le32_to_cpu(raw_inode->i_ctime_nsec));
 	inode->i_mtime.tv_nsec = le32_to_cpu(raw_inode->i_mtime_nsec);
 	if (nilfs_is_metadata_file_inode(inode) && !S_ISREG(inode->i_mode))
 		return -EIO; /* this inode is for metadata and corrupted */
@@ -768,9 +768,9 @@ void nilfs_write_inode_common(struct inode *inode,
 	raw_inode->i_gid = cpu_to_le32(i_gid_read(inode));
 	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
 	raw_inode->i_size = cpu_to_le64(inode->i_size);
-	raw_inode->i_ctime = cpu_to_le64(inode->i_ctime.tv_sec);
+	raw_inode->i_ctime = cpu_to_le64(inode_ctime_peek(inode).tv_sec);
 	raw_inode->i_mtime = cpu_to_le64(inode->i_mtime.tv_sec);
-	raw_inode->i_ctime_nsec = cpu_to_le32(inode->i_ctime.tv_nsec);
+	raw_inode->i_ctime_nsec = cpu_to_le32(inode_ctime_peek(inode).tv_nsec);
 	raw_inode->i_mtime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
 	raw_inode->i_blocks = cpu_to_le64(inode->i_blocks);
 
@@ -875,7 +875,7 @@ void nilfs_truncate(struct inode *inode)
 
 	nilfs_truncate_bmap(ii, blkoff);
 
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_ctime_set_current(inode);
 	if (IS_SYNC(inode))
 		nilfs_set_transaction_flag(NILFS_TI_SYNC);
 
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 1dfbc0c34513..811fab46e277 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -149,7 +149,7 @@ int nilfs_fileattr_set(struct mnt_idmap *idmap,
 	NILFS_I(inode)->i_flags = oldflags | (flags & FS_FL_USER_MODIFIABLE);
 
 	nilfs_set_inode_flags(inode);
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	if (IS_SYNC(inode))
 		nilfs_set_transaction_flag(NILFS_TI_SYNC);
 
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index c7024da8f1e2..251f6021c3db 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -185,7 +185,7 @@ static int nilfs_link(struct dentry *old_dentry, struct inode *dir,
 	if (err)
 		return err;
 
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	inode_inc_link_count(inode);
 	ihold(inode);
 
@@ -283,7 +283,7 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
 	if (err)
 		goto out;
 
-	inode->i_ctime = dir->i_ctime;
+	inode_ctime_set(inode, inode_ctime_peek(dir));
 	drop_nlink(inode);
 	err = 0;
 out:
@@ -387,7 +387,7 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 			goto out_dir;
 		nilfs_set_link(new_dir, new_de, new_page, old_inode);
 		nilfs_mark_inode_dirty(new_dir);
-		new_inode->i_ctime = current_time(new_inode);
+		inode_ctime_set_current(new_inode);
 		if (dir_de)
 			drop_nlink(new_inode);
 		drop_nlink(new_inode);
@@ -406,7 +406,7 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 	 * Like most other Unix systems, set the ctime for inodes on a
 	 * rename.
 	 */
-	old_inode->i_ctime = current_time(old_inode);
+	inode_ctime_set_current(old_inode);
 
 	nilfs_delete_entry(old_de, old_page);
 
-- 
2.41.0


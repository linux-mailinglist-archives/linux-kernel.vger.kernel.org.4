Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675DE7387CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjFUOu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjFUOty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:49:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3938D26B5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19331612B7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB038C433C0;
        Wed, 21 Jun 2023 14:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358907;
        bh=eW0bBiExQ+iQquf9GOgwJKb2GfWfiHdHY/cW0o1EVYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qrcfgrKOvB4pYG/UbKWscFa0DnNwcJJGmgFGNiKmEXXYe7WNOMuClv1PtzPmJHAXJ
         1Pd5c0M28rGG91fw4G5JFkLqL3IK/aiV7dP2EJAInehnL1nSNS8evJ6lDhzEU9Nasc
         99PdmipCJ2ZNwt37sJCX5EX7+rEtgmha0bO28H0M4ZURJi/SBfIDtVH6Anv85UzyAA
         Dxz99Nax9MQ9YxcE7amYaiaXJU48fUw5y8SnnaMcT5NJOIT60jXU9ptRLR8ib4whBu
         2f+OvyFzYdvZ01j8z8wjNQ25IU7Rt5jzNf0TGcBMg73R7XMr6GsFq86BonyiWDuLRb
         hPpHO8rmxnH2Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 30/79] f2fs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:43 -0400
Message-ID: <20230621144735.55953-29-jlayton@kernel.org>
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
 fs/f2fs/dir.c      |  8 ++++----
 fs/f2fs/f2fs.h     |  5 ++++-
 fs/f2fs/file.c     | 16 ++++++++--------
 fs/f2fs/inline.c   |  2 +-
 fs/f2fs/inode.c    | 10 +++++-----
 fs/f2fs/namei.c    | 12 ++++++------
 fs/f2fs/recovery.c |  4 ++--
 fs/f2fs/super.c    |  2 +-
 fs/f2fs/xattr.c    |  2 +-
 9 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 887e55988450..54fa7285e2d6 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -455,7 +455,7 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 	de->file_type = fs_umode_to_ftype(inode->i_mode);
 	set_page_dirty(page);
 
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	f2fs_mark_inode_dirty_sync(dir, false);
 	f2fs_put_page(page, 1);
 }
@@ -609,7 +609,7 @@ void f2fs_update_parent_metadata(struct inode *dir, struct inode *inode,
 			f2fs_i_links_write(dir, true);
 		clear_inode_flag(inode, FI_NEW_INODE);
 	}
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	f2fs_mark_inode_dirty_sync(dir, false);
 
 	if (F2FS_I(dir)->i_current_depth != current_depth)
@@ -851,7 +851,7 @@ void f2fs_drop_nlink(struct inode *dir, struct inode *inode)
 
 	if (S_ISDIR(inode->i_mode))
 		f2fs_i_links_write(dir, false);
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 
 	f2fs_i_links_write(inode, false);
 	if (S_ISDIR(inode->i_mode)) {
@@ -912,7 +912,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	}
 	f2fs_put_page(page, 1);
 
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	f2fs_mark_inode_dirty_sync(dir, false);
 
 	if (inode)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7b9af2d51656..b0a0de41f823 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3302,9 +3302,12 @@ static inline void clear_file(struct inode *inode, int type)
 
 static inline bool f2fs_is_time_consistent(struct inode *inode)
 {
+	struct timespec64 ctime;
+
 	if (!timespec64_equal(F2FS_I(inode)->i_disk_time, &inode->i_atime))
 		return false;
-	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 1, &inode->i_ctime))
+	ctime = inode_ctime_peek(inode);
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 1, &ctime))
 		return false;
 	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 2, &inode->i_mtime))
 		return false;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 38688b5192ef..76c38cd89865 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -809,7 +809,7 @@ int f2fs_truncate(struct inode *inode)
 	if (err)
 		return err;
 
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_ctime_set_current(inode);
 	f2fs_mark_inode_dirty_sync(inode, false);
 	return 0;
 }
@@ -920,7 +920,7 @@ static void __setattr_copy(struct mnt_idmap *idmap,
 	if (ia_valid & ATTR_MTIME)
 		inode->i_mtime = attr->ia_mtime;
 	if (ia_valid & ATTR_CTIME)
-		inode->i_ctime = attr->ia_ctime;
+		inode_ctime_set(inode, attr->ia_ctime);
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 		vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
@@ -1023,7 +1023,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			return err;
 
 		spin_lock(&F2FS_I(inode)->i_size_lock);
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode_ctime_set_current(inode);
 		F2FS_I(inode)->last_disk_size = i_size_read(inode);
 		spin_unlock(&F2FS_I(inode)->i_size_lock);
 	}
@@ -1850,7 +1850,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 	}
 
 	if (!ret) {
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode_ctime_set_current(inode);
 		f2fs_mark_inode_dirty_sync(inode, false);
 		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	}
@@ -1952,7 +1952,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 	else
 		clear_inode_flag(inode, FI_PROJ_INHERIT);
 
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	f2fs_set_inode_flags(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
 	return 0;
@@ -3077,7 +3077,7 @@ static int f2fs_ioc_setproject(struct inode *inode, __u32 projid)
 		goto out_unlock;
 
 	fi->i_projid = kprojid;
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
 out_unlock:
 	f2fs_unlock_op(sbi);
@@ -3510,7 +3510,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 		goto out;
 
 	set_inode_flag(inode, FI_COMPRESS_RELEASED);
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
 
 	if (!atomic_read(&F2FS_I(inode)->i_compr_blocks))
@@ -3712,7 +3712,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 
 	if (ret >= 0) {
 		clear_inode_flag(inode, FI_COMPRESS_RELEASED);
-		inode->i_ctime = current_time(inode);
+		inode_ctime_set_current(inode);
 		f2fs_mark_inode_dirty_sync(inode, true);
 	}
 unlock_inode:
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 4638fee16a91..72bb5340b088 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -698,7 +698,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	set_page_dirty(page);
 	f2fs_put_page(page, 1);
 
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	f2fs_mark_inode_dirty_sync(dir, false);
 
 	if (inode)
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 09e986b050c6..95b89e48a159 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -403,7 +403,7 @@ static void init_idisk_time(struct inode *inode)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 
 	fi->i_disk_time[0] = inode->i_atime;
-	fi->i_disk_time[1] = inode->i_ctime;
+	fi->i_disk_time[1] = inode_ctime_peek(inode);
 	fi->i_disk_time[2] = inode->i_mtime;
 }
 
@@ -434,10 +434,10 @@ static int do_read_inode(struct inode *inode)
 	inode->i_blocks = SECTOR_FROM_BLOCK(le64_to_cpu(ri->i_blocks) - 1);
 
 	inode->i_atime.tv_sec = le64_to_cpu(ri->i_atime);
-	inode->i_ctime.tv_sec = le64_to_cpu(ri->i_ctime);
+	inode_ctime_set_sec(inode, le64_to_cpu(ri->i_ctime));
 	inode->i_mtime.tv_sec = le64_to_cpu(ri->i_mtime);
 	inode->i_atime.tv_nsec = le32_to_cpu(ri->i_atime_nsec);
-	inode->i_ctime.tv_nsec = le32_to_cpu(ri->i_ctime_nsec);
+	inode_ctime_set_nsec(inode, le32_to_cpu(ri->i_ctime_nsec));
 	inode->i_mtime.tv_nsec = le32_to_cpu(ri->i_mtime_nsec);
 	inode->i_generation = le32_to_cpu(ri->i_generation);
 	if (S_ISDIR(inode->i_mode))
@@ -714,10 +714,10 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 	set_raw_inline(inode, ri);
 
 	ri->i_atime = cpu_to_le64(inode->i_atime.tv_sec);
-	ri->i_ctime = cpu_to_le64(inode->i_ctime.tv_sec);
+	ri->i_ctime = cpu_to_le64(inode_ctime_peek(inode).tv_sec);
 	ri->i_mtime = cpu_to_le64(inode->i_mtime.tv_sec);
 	ri->i_atime_nsec = cpu_to_le32(inode->i_atime.tv_nsec);
-	ri->i_ctime_nsec = cpu_to_le32(inode->i_ctime.tv_nsec);
+	ri->i_ctime_nsec = cpu_to_le32(inode_ctime_peek(inode).tv_nsec);
 	ri->i_mtime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
 	if (S_ISDIR(inode->i_mode))
 		ri->i_current_depth =
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 614c33f0f17e..c7876c5d74a6 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -233,7 +233,7 @@ static struct inode *f2fs_new_inode(struct mnt_idmap *idmap,
 
 	inode->i_ino = ino;
 	inode->i_blocks = 0;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 	F2FS_I(inode)->i_crtime = inode->i_mtime;
 	inode->i_generation = get_random_u32();
 
@@ -410,7 +410,7 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 
 	f2fs_balance_fs(sbi, true);
 
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	ihold(inode);
 
 	set_inode_flag(inode, FI_INC_LINK);
@@ -1042,7 +1042,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		f2fs_set_link(new_dir, new_entry, new_page, old_inode);
 		new_page = NULL;
 
-		new_inode->i_ctime = current_time(new_inode);
+		inode_ctime_set_current(new_inode);
 		f2fs_down_write(&F2FS_I(new_inode)->i_sem);
 		if (old_dir_entry)
 			f2fs_i_links_write(new_inode, false);
@@ -1076,7 +1076,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		f2fs_i_pino_write(old_inode, new_dir->i_ino);
 	f2fs_up_write(&F2FS_I(old_inode)->i_sem);
 
-	old_inode->i_ctime = current_time(old_inode);
+	inode_ctime_set_current(old_inode);
 	f2fs_mark_inode_dirty_sync(old_inode, false);
 
 	f2fs_delete_entry(old_entry, old_page, old_dir, NULL);
@@ -1241,7 +1241,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_pino_write(old_inode, new_dir->i_ino);
 	f2fs_up_write(&F2FS_I(old_inode)->i_sem);
 
-	old_dir->i_ctime = current_time(old_dir);
+	inode_ctime_set_current(old_dir);
 	if (old_nlink) {
 		f2fs_down_write(&F2FS_I(old_dir)->i_sem);
 		f2fs_i_links_write(old_dir, old_nlink > 0);
@@ -1260,7 +1260,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_pino_write(new_inode, old_dir->i_ino);
 	f2fs_up_write(&F2FS_I(new_inode)->i_sem);
 
-	new_dir->i_ctime = current_time(new_dir);
+	inode_ctime_set_current(new_dir);
 	if (new_nlink) {
 		f2fs_down_write(&F2FS_I(new_dir)->i_sem);
 		f2fs_i_links_write(new_dir, new_nlink > 0);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 4e7d4ceeb084..5a06dd15453d 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -321,10 +321,10 @@ static int recover_inode(struct inode *inode, struct page *page)
 
 	f2fs_i_size_write(inode, le64_to_cpu(raw->i_size));
 	inode->i_atime.tv_sec = le64_to_cpu(raw->i_atime);
-	inode->i_ctime.tv_sec = le64_to_cpu(raw->i_ctime);
+	inode_ctime_set_sec(inode, le64_to_cpu(raw->i_ctime));
 	inode->i_mtime.tv_sec = le64_to_cpu(raw->i_mtime);
 	inode->i_atime.tv_nsec = le32_to_cpu(raw->i_atime_nsec);
-	inode->i_ctime.tv_nsec = le32_to_cpu(raw->i_ctime_nsec);
+	inode_ctime_set_nsec(inode, le32_to_cpu(raw->i_ctime_nsec));
 	inode->i_mtime.tv_nsec = le32_to_cpu(raw->i_mtime_nsec);
 
 	F2FS_I(inode)->i_advise = raw->i_advise;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bc15841fd33c..3c6bb358a7a3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2702,7 +2702,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 
 	if (len == towrite)
 		return err;
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_ctime_set_current(inode);
 	f2fs_mark_inode_dirty_sync(inode, false);
 	return len - towrite;
 }
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index bdc8a55085a2..9bc685b33f4d 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -749,7 +749,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 same:
 	if (is_inode_flag_set(inode, FI_ACL_MODE)) {
 		inode->i_mode = F2FS_I(inode)->i_acl_mode;
-		inode->i_ctime = current_time(inode);
+		inode_ctime_set_current(inode);
 		clear_inode_flag(inode, FI_ACL_MODE);
 	}
 
-- 
2.41.0


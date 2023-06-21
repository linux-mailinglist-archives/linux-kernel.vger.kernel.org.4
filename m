Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22578738824
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjFUO4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjFUOy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:54:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3353A84
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:50:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C6F9615B5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDEEC433C0;
        Wed, 21 Jun 2023 14:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358970;
        bh=bWfKou76bFFjObS87FXTEtpJCLJj//Ee7jkqO2cLFu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhLiYYPm7NVKGNQtohUL1QsckjE7jWHddEG0eG0Dd5MeQONM4c5tPIMwbaTZpOKN5
         7gE/KZvcOX1L2j5X7dMDQStzCSBL7GDFb1Pvqkp50C58XEzs0X5Bpe7EGbSGrZWH2e
         orLE+IgHLKWEqAd3vc75jlrAH8ucg+KmPPcXnncDJ4X9pzBkg95y2jsDYuCTAt8eBQ
         BvDNYP0B5gbUxzqUeAfhofA2KSZ/ccUxnlM7o4lYIOlMtsByRLbk9Tmr9Brg2MT2hX
         fvnSgbVkk/V/923zJLWnq9kytHnt9ePWxPM+6c/mf913x55Gii4bpsyToBoTRz7m56
         jye04OQwA5Ksg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Richard Weinberger <richard@nod.at>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 66/79] ubifs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:19 -0400
Message-ID: <20230621144735.55953-65-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
 fs/ubifs/debug.c   |  4 ++--
 fs/ubifs/dir.c     | 39 +++++++++++++++++++--------------------
 fs/ubifs/file.c    | 16 +++++++++-------
 fs/ubifs/ioctl.c   |  2 +-
 fs/ubifs/journal.c |  4 ++--
 fs/ubifs/super.c   |  4 ++--
 fs/ubifs/xattr.c   |  6 +++---
 7 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index 9c9d3f0e36a4..114c2b00aa29 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -243,8 +243,8 @@ void ubifs_dump_inode(struct ubifs_info *c, const struct inode *inode)
 	       (unsigned int)inode->i_mtime.tv_sec,
 	       (unsigned int)inode->i_mtime.tv_nsec);
 	pr_err("\tctime          %u.%u\n",
-	       (unsigned int)inode->i_ctime.tv_sec,
-	       (unsigned int)inode->i_ctime.tv_nsec);
+	       (unsigned int) inode_ctime_peek(inode).tv_sec,
+	       (unsigned int) inode_ctime_peek(inode).tv_nsec);
 	pr_err("\tcreat_sqnum    %llu\n", ui->creat_sqnum);
 	pr_err("\txattr_size     %u\n", ui->xattr_size);
 	pr_err("\txattr_cnt      %u\n", ui->xattr_cnt);
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index ef0499edc248..39588e3e3a8b 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -96,8 +96,7 @@ struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
 	inode->i_flags |= S_NOCMTIME;
 
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
-	inode->i_mtime = inode->i_atime = inode->i_ctime =
-			 current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 	inode->i_mapping->nrpages = 0;
 
 	if (!is_xattr) {
@@ -325,7 +324,7 @@ static int ubifs_create(struct mnt_idmap *idmap, struct inode *dir,
 	mutex_lock(&dir_ui->ui_mutex);
 	dir->i_size += sz_change;
 	dir_ui->ui_size = dir->i_size;
-	dir->i_mtime = dir->i_ctime = inode->i_ctime;
+	dir->i_mtime = inode_ctime_set(inode, inode_ctime_peek(inode));
 	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
 	if (err)
 		goto out_cancel;
@@ -765,10 +764,10 @@ static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
 
 	inc_nlink(inode);
 	ihold(inode);
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	dir->i_size += sz_change;
 	dir_ui->ui_size = dir->i_size;
-	dir->i_mtime = dir->i_ctime = inode->i_ctime;
+	dir->i_mtime = inode_ctime_set(inode, inode_ctime_peek(inode));
 	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
 	if (err)
 		goto out_cancel;
@@ -838,11 +837,11 @@ static int ubifs_unlink(struct inode *dir, struct dentry *dentry)
 	}
 
 	lock_2_inodes(dir, inode);
-	inode->i_ctime = current_time(dir);
+	inode_ctime_set(inode, current_time(dir));
 	drop_nlink(inode);
 	dir->i_size -= sz_change;
 	dir_ui->ui_size = dir->i_size;
-	dir->i_mtime = dir->i_ctime = inode->i_ctime;
+	dir->i_mtime = inode_ctime_set(inode, inode_ctime_peek(inode));
 	err = ubifs_jnl_update(c, dir, &nm, inode, 1, 0);
 	if (err)
 		goto out_cancel;
@@ -940,12 +939,12 @@ static int ubifs_rmdir(struct inode *dir, struct dentry *dentry)
 	}
 
 	lock_2_inodes(dir, inode);
-	inode->i_ctime = current_time(dir);
+	inode_ctime_set(inode, current_time(dir));
 	clear_nlink(inode);
 	drop_nlink(dir);
 	dir->i_size -= sz_change;
 	dir_ui->ui_size = dir->i_size;
-	dir->i_mtime = dir->i_ctime = inode->i_ctime;
+	dir->i_mtime = inode_ctime_set(inode, inode_ctime_peek(inode));
 	err = ubifs_jnl_update(c, dir, &nm, inode, 1, 0);
 	if (err)
 		goto out_cancel;
@@ -1019,7 +1018,7 @@ static int ubifs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	inc_nlink(dir);
 	dir->i_size += sz_change;
 	dir_ui->ui_size = dir->i_size;
-	dir->i_mtime = dir->i_ctime = inode->i_ctime;
+	dir->i_mtime = inode_ctime_set(inode, inode_ctime_peek(inode));
 	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
 	if (err) {
 		ubifs_err(c, "cannot create directory, error %d", err);
@@ -1110,7 +1109,7 @@ static int ubifs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	mutex_lock(&dir_ui->ui_mutex);
 	dir->i_size += sz_change;
 	dir_ui->ui_size = dir->i_size;
-	dir->i_mtime = dir->i_ctime = inode->i_ctime;
+	dir->i_mtime = inode_ctime_set(inode, inode_ctime_peek(inode));
 	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
 	if (err)
 		goto out_cancel;
@@ -1210,7 +1209,7 @@ static int ubifs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	mutex_lock(&dir_ui->ui_mutex);
 	dir->i_size += sz_change;
 	dir_ui->ui_size = dir->i_size;
-	dir->i_mtime = dir->i_ctime = inode->i_ctime;
+	dir->i_mtime = inode_ctime_set(inode, inode_ctime_peek(inode));
 	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
 	if (err)
 		goto out_cancel;
@@ -1415,7 +1414,7 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
 	 * rename.
 	 */
 	time = current_time(old_dir);
-	old_inode->i_ctime = time;
+	inode_ctime_set(old_inode, time);
 
 	/* We must adjust parent link count when renaming directories */
 	if (is_dir) {
@@ -1444,8 +1443,8 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	old_dir->i_size -= old_sz;
 	ubifs_inode(old_dir)->ui_size = old_dir->i_size;
-	old_dir->i_mtime = old_dir->i_ctime = time;
-	new_dir->i_mtime = new_dir->i_ctime = time;
+	old_dir->i_mtime = inode_ctime_set(old_dir, time);
+	new_dir->i_mtime = inode_ctime_set(new_dir, time);
 
 	/*
 	 * And finally, if we unlinked a direntry which happened to have the
@@ -1462,7 +1461,7 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
 			clear_nlink(new_inode);
 		else
 			drop_nlink(new_inode);
-		new_inode->i_ctime = time;
+		inode_ctime_set(new_inode, time);
 	} else {
 		new_dir->i_size += new_sz;
 		ubifs_inode(new_dir)->ui_size = new_dir->i_size;
@@ -1589,10 +1588,10 @@ static int ubifs_xrename(struct inode *old_dir, struct dentry *old_dentry,
 	lock_4_inodes(old_dir, new_dir, NULL, NULL);
 
 	time = current_time(old_dir);
-	fst_inode->i_ctime = time;
-	snd_inode->i_ctime = time;
-	old_dir->i_mtime = old_dir->i_ctime = time;
-	new_dir->i_mtime = new_dir->i_ctime = time;
+	inode_ctime_set(fst_inode, time);
+	inode_ctime_set(snd_inode, time);
+	old_dir->i_mtime = inode_ctime_set(old_dir, time);
+	new_dir->i_mtime = inode_ctime_set(new_dir, time);
 
 	if (old_dir != new_dir) {
 		if (S_ISDIR(fst_inode->i_mode) && !S_ISDIR(snd_inode->i_mode)) {
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 6738fe43040b..f9ba69f6fbab 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1092,7 +1092,7 @@ static void do_attr_changes(struct inode *inode, const struct iattr *attr)
 	if (attr->ia_valid & ATTR_MTIME)
 		inode->i_mtime = attr->ia_mtime;
 	if (attr->ia_valid & ATTR_CTIME)
-		inode->i_ctime = attr->ia_ctime;
+		inode_ctime_set(inode, attr->ia_ctime);
 	if (attr->ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 
@@ -1192,7 +1192,7 @@ static int do_truncation(struct ubifs_info *c, struct inode *inode,
 	mutex_lock(&ui->ui_mutex);
 	ui->ui_size = inode->i_size;
 	/* Truncation changes inode [mc]time */
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_ctime_set_current(inode);
 	/* Other attributes may be changed at the same time as well */
 	do_attr_changes(inode, attr);
 	err = ubifs_jnl_truncate(c, inode, old_size, new_size);
@@ -1239,7 +1239,7 @@ static int do_setattr(struct ubifs_info *c, struct inode *inode,
 	mutex_lock(&ui->ui_mutex);
 	if (attr->ia_valid & ATTR_SIZE) {
 		/* Truncation changes inode [mc]time */
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode_ctime_set_current(inode);
 		/* 'truncate_setsize()' changed @i_size, update @ui_size */
 		ui->ui_size = inode->i_size;
 	}
@@ -1364,8 +1364,10 @@ int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 static inline int mctime_update_needed(const struct inode *inode,
 				       const struct timespec64 *now)
 {
+	struct timespec64 ctime = inode_ctime_peek(inode);
+
 	if (!timespec64_equal(&inode->i_mtime, now) ||
-	    !timespec64_equal(&inode->i_ctime, now))
+	    !timespec64_equal(&ctime, now))
 		return 1;
 	return 0;
 }
@@ -1396,7 +1398,7 @@ int ubifs_update_time(struct inode *inode, struct timespec64 *time,
 	if (flags & S_ATIME)
 		inode->i_atime = *time;
 	if (flags & S_CTIME)
-		inode->i_ctime = *time;
+		inode_ctime_set(inode, *time);
 	if (flags & S_MTIME)
 		inode->i_mtime = *time;
 
@@ -1432,7 +1434,7 @@ static int update_mctime(struct inode *inode)
 			return err;
 
 		mutex_lock(&ui->ui_mutex);
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode_ctime_set_current(inode);
 		release = ui->dirty;
 		mark_inode_dirty_sync(inode);
 		mutex_unlock(&ui->ui_mutex);
@@ -1570,7 +1572,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_fault *vmf)
 		struct ubifs_inode *ui = ubifs_inode(inode);
 
 		mutex_lock(&ui->ui_mutex);
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode_ctime_set_current(inode);
 		release = ui->dirty;
 		mark_inode_dirty_sync(inode);
 		mutex_unlock(&ui->ui_mutex);
diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index 67c5108abd89..a4da17f4cceb 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -118,7 +118,7 @@ static int setflags(struct inode *inode, int flags)
 	ui->flags &= ~ioctl2ubifs(UBIFS_SETTABLE_IOCTL_FLAGS);
 	ui->flags |= ioctl2ubifs(flags);
 	ubifs_set_inode_flags(inode);
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	release = ui->dirty;
 	mark_inode_dirty_sync(inode);
 	mutex_unlock(&ui->ui_mutex);
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index dc52ac0f4a34..86f5d73cd613 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -454,8 +454,8 @@ static void pack_inode(struct ubifs_info *c, struct ubifs_ino_node *ino,
 	ino->creat_sqnum = cpu_to_le64(ui->creat_sqnum);
 	ino->atime_sec  = cpu_to_le64(inode->i_atime.tv_sec);
 	ino->atime_nsec = cpu_to_le32(inode->i_atime.tv_nsec);
-	ino->ctime_sec  = cpu_to_le64(inode->i_ctime.tv_sec);
-	ino->ctime_nsec = cpu_to_le32(inode->i_ctime.tv_nsec);
+	ino->ctime_sec  = cpu_to_le64(inode_ctime_peek(inode).tv_sec);
+	ino->ctime_nsec = cpu_to_le32(inode_ctime_peek(inode).tv_nsec);
 	ino->mtime_sec  = cpu_to_le64(inode->i_mtime.tv_sec);
 	ino->mtime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
 	ino->uid   = cpu_to_le32(i_uid_read(inode));
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 32cb14759796..29c2f40acac9 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -146,8 +146,8 @@ struct inode *ubifs_iget(struct super_block *sb, unsigned long inum)
 	inode->i_atime.tv_nsec = le32_to_cpu(ino->atime_nsec);
 	inode->i_mtime.tv_sec  = (int64_t)le64_to_cpu(ino->mtime_sec);
 	inode->i_mtime.tv_nsec = le32_to_cpu(ino->mtime_nsec);
-	inode->i_ctime.tv_sec  = (int64_t)le64_to_cpu(ino->ctime_sec);
-	inode->i_ctime.tv_nsec = le32_to_cpu(ino->ctime_nsec);
+	inode_ctime_set_sec(inode, (int64_t)le64_to_cpu(ino->ctime_sec));
+	inode_ctime_set_nsec(inode, le32_to_cpu(ino->ctime_nsec));
 	inode->i_mode = le32_to_cpu(ino->mode);
 	inode->i_size = le64_to_cpu(ino->size);
 
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index 349228dd1191..d5955e1fbb7d 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -134,7 +134,7 @@ static int create_xattr(struct ubifs_info *c, struct inode *host,
 	ui->data_len = size;
 
 	mutex_lock(&host_ui->ui_mutex);
-	host->i_ctime = current_time(host);
+	inode_ctime_set_current(host);
 	host_ui->xattr_cnt += 1;
 	host_ui->xattr_size += CALC_DENT_SIZE(fname_len(nm));
 	host_ui->xattr_size += CALC_XATTR_BYTES(size);
@@ -215,7 +215,7 @@ static int change_xattr(struct ubifs_info *c, struct inode *host,
 	ui->data_len = size;
 
 	mutex_lock(&host_ui->ui_mutex);
-	host->i_ctime = current_time(host);
+	inode_ctime_set_current(host);
 	host_ui->xattr_size -= CALC_XATTR_BYTES(old_size);
 	host_ui->xattr_size += CALC_XATTR_BYTES(size);
 
@@ -474,7 +474,7 @@ static int remove_xattr(struct ubifs_info *c, struct inode *host,
 		return err;
 
 	mutex_lock(&host_ui->ui_mutex);
-	host->i_ctime = current_time(host);
+	inode_ctime_set_current(host);
 	host_ui->xattr_cnt -= 1;
 	host_ui->xattr_size -= CALC_DENT_SIZE(fname_len(nm));
 	host_ui->xattr_size -= CALC_XATTR_BYTES(ui->data_len);
-- 
2.41.0


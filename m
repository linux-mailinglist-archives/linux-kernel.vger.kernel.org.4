Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49B77387F7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjFUOxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjFUOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:52:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC09E10EC;
        Wed, 21 Jun 2023 07:49:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DC6D6158D;
        Wed, 21 Jun 2023 14:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F5FC433C8;
        Wed, 21 Jun 2023 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358960;
        bh=WcJHdoVjXFAYNwmKvs+DtsQu+/wxVUJsdB/1zy7Ed4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KRzNvvlXaerWowU1n1skElsx8cjUkEYuXSsrGgjXayI4k1mLDSXLJJ6MITMS3TWHt
         a/EOsAOCW34HPosJgOJ3rT1dJn63iAt4314F4S6jESdj34JtsUZDt3Et+a80gXHjWB
         CTT/eeHHNNWcKX175fAxu9tPQz1ei84JxHvy7XBDqI6d58w2F4SLhFRbI2PHqdMyZc
         XtX0hDRdB0iHfziF9OoN0WwaHDAtzEMmj8l85caTxbFIU2YKMi3+z8ZYzNS+dHZpXB
         y42zayIXq60Mka7yfTPinES5ysNBXORIiiopB9xyxUOw48S8XvDpGlsfUEdEYXDGCZ
         McRbEaIUnAIQg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 60/79] reiserfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:13 -0400
Message-ID: <20230621144735.55953-59-jlayton@kernel.org>
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
 fs/reiserfs/inode.c     | 14 +++++++-------
 fs/reiserfs/ioctl.c     |  4 ++--
 fs/reiserfs/namei.c     | 21 ++++++++++-----------
 fs/reiserfs/stree.c     |  4 ++--
 fs/reiserfs/super.c     |  2 +-
 fs/reiserfs/xattr.c     |  5 +++--
 fs/reiserfs/xattr_acl.c |  2 +-
 7 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 77bd3b27059f..3d4e18af8dac 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -1259,9 +1259,9 @@ static void init_inode(struct inode *inode, struct treepath *path)
 		inode->i_size = sd_v1_size(sd);
 		inode->i_atime.tv_sec = sd_v1_atime(sd);
 		inode->i_mtime.tv_sec = sd_v1_mtime(sd);
-		inode->i_ctime.tv_sec = sd_v1_ctime(sd);
+		inode_ctime_set_sec(inode, sd_v1_ctime(sd));
 		inode->i_atime.tv_nsec = 0;
-		inode->i_ctime.tv_nsec = 0;
+		inode_ctime_set_nsec(inode, 0);
 		inode->i_mtime.tv_nsec = 0;
 
 		inode->i_blocks = sd_v1_blocks(sd);
@@ -1314,8 +1314,8 @@ static void init_inode(struct inode *inode, struct treepath *path)
 		i_gid_write(inode, sd_v2_gid(sd));
 		inode->i_mtime.tv_sec = sd_v2_mtime(sd);
 		inode->i_atime.tv_sec = sd_v2_atime(sd);
-		inode->i_ctime.tv_sec = sd_v2_ctime(sd);
-		inode->i_ctime.tv_nsec = 0;
+		inode_ctime_set_sec(inode, sd_v2_ctime(sd));
+		inode_ctime_set_nsec(inode, 0);
 		inode->i_mtime.tv_nsec = 0;
 		inode->i_atime.tv_nsec = 0;
 		inode->i_blocks = sd_v2_blocks(sd);
@@ -1374,7 +1374,7 @@ static void inode2sd(void *sd, struct inode *inode, loff_t size)
 	set_sd_v2_gid(sd_v2, i_gid_read(inode));
 	set_sd_v2_mtime(sd_v2, inode->i_mtime.tv_sec);
 	set_sd_v2_atime(sd_v2, inode->i_atime.tv_sec);
-	set_sd_v2_ctime(sd_v2, inode->i_ctime.tv_sec);
+	set_sd_v2_ctime(sd_v2, inode_ctime_peek(inode).tv_sec);
 	set_sd_v2_blocks(sd_v2, to_fake_used_blocks(inode, SD_V2_SIZE));
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
 		set_sd_v2_rdev(sd_v2, new_encode_dev(inode->i_rdev));
@@ -1394,7 +1394,7 @@ static void inode2sd_v1(void *sd, struct inode *inode, loff_t size)
 	set_sd_v1_nlink(sd_v1, inode->i_nlink);
 	set_sd_v1_size(sd_v1, size);
 	set_sd_v1_atime(sd_v1, inode->i_atime.tv_sec);
-	set_sd_v1_ctime(sd_v1, inode->i_ctime.tv_sec);
+	set_sd_v1_ctime(sd_v1, inode_ctime_peek(inode).tv_sec);
 	set_sd_v1_mtime(sd_v1, inode->i_mtime.tv_sec);
 
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
@@ -1986,7 +1986,7 @@ int reiserfs_new_inode(struct reiserfs_transaction_handle *th,
 
 	/* uid and gid must already be set by the caller for quota init */
 
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 	inode->i_size = i_size;
 	inode->i_blocks = 0;
 	inode->i_bytes = 0;
diff --git a/fs/reiserfs/ioctl.c b/fs/reiserfs/ioctl.c
index 6bf9b54e58ca..5d129a0b3ce7 100644
--- a/fs/reiserfs/ioctl.c
+++ b/fs/reiserfs/ioctl.c
@@ -55,7 +55,7 @@ int reiserfs_fileattr_set(struct mnt_idmap *idmap,
 	}
 	sd_attrs_to_i_attrs(flags, inode);
 	REISERFS_I(inode)->i_attrs = flags;
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	mark_inode_dirty(inode);
 	err = 0;
 unlock:
@@ -107,7 +107,7 @@ long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			err = -EFAULT;
 			goto setversion_out;
 		}
-		inode->i_ctime = current_time(inode);
+		inode_ctime_set_current(inode);
 		mark_inode_dirty(inode);
 setversion_out:
 		mnt_drop_write_file(filp);
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 52240cc891cf..fa4d11b21279 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -572,7 +572,7 @@ static int reiserfs_add_entry(struct reiserfs_transaction_handle *th,
 	}
 
 	dir->i_size += paste_size;
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	if (!S_ISDIR(inode->i_mode) && visible)
 		/* reiserfs_mkdir or reiserfs_rename will do that by itself */
 		reiserfs_update_sd(th, dir);
@@ -966,7 +966,8 @@ static int reiserfs_rmdir(struct inode *dir, struct dentry *dentry)
 			       inode->i_nlink);
 
 	clear_nlink(inode);
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(dir);
+	inode_ctime_set_current(inode);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	reiserfs_update_sd(&th, inode);
 
 	DEC_DIR_INODE_NLINK(dir)
@@ -1070,11 +1071,11 @@ static int reiserfs_unlink(struct inode *dir, struct dentry *dentry)
 		inc_nlink(inode);
 		goto end_unlink;
 	}
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	reiserfs_update_sd(&th, inode);
 
 	dir->i_size -= (de.de_entrylen + DEH_SIZE);
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	reiserfs_update_sd(&th, dir);
 
 	if (!savelink)
@@ -1250,7 +1251,7 @@ static int reiserfs_link(struct dentry *old_dentry, struct inode *dir,
 		return err ? err : retval;
 	}
 
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	reiserfs_update_sd(&th, inode);
 
 	ihold(inode);
@@ -1325,7 +1326,6 @@ static int reiserfs_rename(struct mnt_idmap *idmap,
 	int jbegin_count;
 	umode_t old_inode_mode;
 	unsigned long savelink = 1;
-	struct timespec64 ctime;
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
@@ -1576,14 +1576,13 @@ static int reiserfs_rename(struct mnt_idmap *idmap,
 
 	mark_de_hidden(old_de.de_deh + old_de.de_entry_num);
 	journal_mark_dirty(&th, old_de.de_bh);
-	ctime = current_time(old_dir);
-	old_dir->i_ctime = old_dir->i_mtime = ctime;
-	new_dir->i_ctime = new_dir->i_mtime = ctime;
+	old_dir->i_mtime = inode_ctime_set_current(old_dir);
+	new_dir->i_mtime = inode_ctime_set_current(new_dir);
 	/*
 	 * thanks to Alex Adriaanse <alex_a@caltech.edu> for patch
 	 * which adds ctime update of renamed object
 	 */
-	old_inode->i_ctime = ctime;
+	inode_ctime_set_current(old_inode);
 
 	if (new_dentry_inode) {
 		/* adjust link number of the victim */
@@ -1592,7 +1591,7 @@ static int reiserfs_rename(struct mnt_idmap *idmap,
 		} else {
 			drop_nlink(new_dentry_inode);
 		}
-		new_dentry_inode->i_ctime = ctime;
+		inode_ctime_set_current(new_dentry_inode);
 		savelink = new_dentry_inode->i_nlink;
 	}
 
diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
index ce5003986789..c7f0aa0e9a2e 100644
--- a/fs/reiserfs/stree.c
+++ b/fs/reiserfs/stree.c
@@ -2004,7 +2004,7 @@ int reiserfs_do_truncate(struct reiserfs_transaction_handle *th,
 
 			if (update_timestamps) {
 				inode->i_mtime = current_time(inode);
-				inode->i_ctime = current_time(inode);
+				inode_ctime_set_current(inode);
 			}
 			reiserfs_update_sd(th, inode);
 
@@ -2029,7 +2029,7 @@ int reiserfs_do_truncate(struct reiserfs_transaction_handle *th,
 	if (update_timestamps) {
 		/* this is truncate, not file closing */
 		inode->i_mtime = current_time(inode);
-		inode->i_ctime = current_time(inode);
+		inode_ctime_set_current(inode);
 	}
 	reiserfs_update_sd(th, inode);
 
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 929acce6e731..0ff67c74aac2 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -2587,7 +2587,7 @@ static ssize_t reiserfs_quota_write(struct super_block *sb, int type,
 		return err;
 	if (inode->i_size < off + len - towrite)
 		i_size_write(inode, off + len - towrite);
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_ctime_set_current(inode);
 	mark_inode_dirty(inode);
 	return len - towrite;
 }
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 651027967159..469d700d97a9 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -466,12 +466,13 @@ int reiserfs_commit_write(struct file *f, struct page *page,
 static void update_ctime(struct inode *inode)
 {
 	struct timespec64 now = current_time(inode);
+	struct timespec64 ctime = inode_ctime_peek(inode);
 
 	if (inode_unhashed(inode) || !inode->i_nlink ||
-	    timespec64_equal(&inode->i_ctime, &now))
+	    timespec64_equal(&ctime, &now))
 		return;
 
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	mark_inode_dirty(inode);
 }
 
diff --git a/fs/reiserfs/xattr_acl.c b/fs/reiserfs/xattr_acl.c
index 138060452678..07ef471aa436 100644
--- a/fs/reiserfs/xattr_acl.c
+++ b/fs/reiserfs/xattr_acl.c
@@ -285,7 +285,7 @@ __reiserfs_set_acl(struct reiserfs_transaction_handle *th, struct inode *inode,
 	if (error == -ENODATA) {
 		error = 0;
 		if (type == ACL_TYPE_ACCESS) {
-			inode->i_ctime = current_time(inode);
+			inode_ctime_set_current(inode);
 			mark_inode_dirty(inode);
 		}
 	}
-- 
2.41.0


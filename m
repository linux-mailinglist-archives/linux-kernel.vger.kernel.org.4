Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1AD7387EA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjFUOwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjFUOvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADDD2735
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:49:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7D0661572
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D19BC433C0;
        Wed, 21 Jun 2023 14:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358941;
        bh=ggTTkYh6IuilLM0I//venIa9AQMvQmdk9UXT783ly/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nG5P6scc+b5lLj/Vq9ZKrD7QcLlwdW68KeIVM5KaOZSk86YGR0eWmn9mlAajiYFZq
         AQ0REjW40tCADmrz1dWK3qCv8E/mQGeJFb8F23WF078fvzEf6lMx/fSoOkMCXxlnXK
         CFvZifqe6wslRnKRHOkRCtNGzWpgHn5zV9JNl1bKDlJJgeTgq3f2FAUBAj9IKfGenQ
         P3GqM16YSz7IOF5tZ2wSPQbLke5noW+debNpX8NaKrLlwep3HiGnqeXaKuRzIi2kpD
         zY3f4YmuHfIeLv+KcpdRJ6x+sqn7XI9ON8hiVNBGpWraH6aSfcnpWK8PoEkaumXcwo
         jn70UVESMxKxQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 49/79] ntfs3: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:02 -0400
Message-ID: <20230621144735.55953-48-jlayton@kernel.org>
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
 fs/ntfs3/file.c    |  6 +++---
 fs/ntfs3/frecord.c |  4 +++-
 fs/ntfs3/inode.c   | 14 ++++++++------
 fs/ntfs3/namei.c   | 10 +++++-----
 fs/ntfs3/xattr.c   |  4 ++--
 5 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 1d6c824246c4..032452b3e242 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -342,7 +342,7 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
 		err = 0;
 	}
 
-	inode->i_ctime = inode->i_mtime = current_time(inode);
+	inode->i_mtime = inode_ctime_set_current(inode);
 	mark_inode_dirty(inode);
 
 	if (IS_SYNC(inode)) {
@@ -400,7 +400,7 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
 	ni_unlock(ni);
 
 	ni->std_fa |= FILE_ATTRIBUTE_ARCHIVE;
-	inode->i_ctime = inode->i_mtime = current_time(inode);
+	inode->i_mtime = inode_ctime_set_current(inode);
 	if (!IS_DIRSYNC(inode)) {
 		dirty = 1;
 	} else {
@@ -642,7 +642,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		filemap_invalidate_unlock(mapping);
 
 	if (!err) {
-		inode->i_ctime = inode->i_mtime = current_time(inode);
+		inode->i_mtime = inode_ctime_set_current(inode);
 		mark_inode_dirty(inode);
 	}
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 16bd9faa2d28..4712474d74a7 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3264,6 +3264,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 
 	if (is_rec_inuse(ni->mi.mrec) &&
 	    !(sbi->flags & NTFS_FLAGS_LOG_REPLAYING) && inode->i_nlink) {
+		struct timespec64 ctime;
 		bool modified = false;
 
 		/* Update times in standard attribute. */
@@ -3280,7 +3281,8 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 			modified = true;
 		}
 
-		dup.c_time = kernel2nt(&inode->i_ctime);
+		ctime = inode_ctime_peek(inode);
+		dup.c_time = kernel2nt(&ctime);
 		if (std->c_time != dup.c_time) {
 			std->c_time = dup.c_time;
 			modified = true;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index dc7e7ab701c6..ac1726fc4e16 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -44,6 +44,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	u64 t64;
 	struct MFT_REC *rec;
 	struct runs_tree *run;
+	struct timespec64 ctime;
 
 	inode->i_op = NULL;
 	/* Setup 'uid' and 'gid' */
@@ -169,7 +170,8 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		nt2kernel(std5->cr_time, &ni->i_crtime);
 #endif
 		nt2kernel(std5->a_time, &inode->i_atime);
-		nt2kernel(std5->c_time, &inode->i_ctime);
+		ctime = inode_ctime_peek(inode);
+		nt2kernel(std5->c_time, &ctime);
 		nt2kernel(std5->m_time, &inode->i_mtime);
 
 		ni->std_fa = std5->fa;
@@ -958,7 +960,7 @@ int ntfs_write_end(struct file *file, struct address_space *mapping, loff_t pos,
 
 	if (err >= 0) {
 		if (!(ni->std_fa & FILE_ATTRIBUTE_ARCHIVE)) {
-			inode->i_ctime = inode->i_mtime = current_time(inode);
+			inode->i_mtime = inode_ctime_set_current(inode);
 			ni->std_fa |= FILE_ATTRIBUTE_ARCHIVE;
 			dirty = true;
 		}
@@ -1658,8 +1660,8 @@ struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	d_instantiate(dentry, inode);
 
 	/* Set original time. inode times (i_ctime) may be changed in ntfs_init_acl. */
-	inode->i_atime = inode->i_mtime = inode->i_ctime = dir->i_mtime =
-		dir->i_ctime = ni->i_crtime;
+	inode->i_atime = inode->i_mtime = inode_ctime_set(inode, ni->i_crtime);
+	dir->i_mtime = inode_ctime_set(dir, ni->i_crtime);
 
 	mark_inode_dirty(dir);
 	mark_inode_dirty(inode);
@@ -1765,9 +1767,9 @@ int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry)
 
 	if (!err) {
 		drop_nlink(inode);
-		dir->i_mtime = dir->i_ctime = current_time(dir);
+		dir->i_mtime = inode_ctime_set_current(dir);
 		mark_inode_dirty(dir);
-		inode->i_ctime = dir->i_ctime;
+		inode_ctime_set(inode, inode_ctime_peek(dir));
 		if (inode->i_nlink)
 			mark_inode_dirty(inode);
 	} else if (!ni_remove_name_undo(dir_ni, ni, de, de2, undo_remove)) {
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 70f8c859e0ad..30e2341533fa 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -156,8 +156,8 @@ static int ntfs_link(struct dentry *ode, struct inode *dir, struct dentry *de)
 	err = ntfs_link_inode(inode, de);
 
 	if (!err) {
-		dir->i_ctime = dir->i_mtime = inode->i_ctime =
-			current_time(dir);
+		dir->i_mtime = inode_ctime_set_current(dir);
+		inode_ctime_set_current(inode);
 		mark_inode_dirty(inode);
 		mark_inode_dirty(dir);
 		d_instantiate(de, inode);
@@ -324,12 +324,12 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *dir,
 		/* Restore after failed rename failed too. */
 		_ntfs_bad_inode(inode);
 	} else if (!err) {
-		inode->i_ctime = dir->i_ctime = dir->i_mtime =
-			current_time(dir);
+		inode_ctime_set_current(inode);
+		dir->i_mtime = inode_ctime_set_current(dir);
 		mark_inode_dirty(inode);
 		mark_inode_dirty(dir);
 		if (dir != new_dir) {
-			new_dir->i_mtime = new_dir->i_ctime = dir->i_ctime;
+			new_dir->i_mtime = inode_ctime_set_current(new_dir);
 			mark_inode_dirty(new_dir);
 		}
 
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 023f314e8950..fd05965e2a06 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -637,7 +637,7 @@ static noinline int ntfs_set_acl_ex(struct mnt_idmap *idmap,
 	if (!err) {
 		set_cached_acl(inode, type, acl);
 		inode->i_mode = mode;
-		inode->i_ctime = current_time(inode);
+		inode_ctime_set_current(inode);
 		mark_inode_dirty(inode);
 	}
 
@@ -924,7 +924,7 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
 			  NULL);
 
 out:
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	mark_inode_dirty(inode);
 
 	return err;
-- 
2.41.0


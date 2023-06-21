Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD929738826
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjFUO4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjFUOzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:55:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCF93AB0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:50:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BD8E61572
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6742CC433C0;
        Wed, 21 Jun 2023 14:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358966;
        bh=3yeFR++O7YTbL3qL8lqgEnCWrLLy3z6LDcBZ2euddMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sc0OSfSDrB2wRWT+hvakF+s22aeNS4E81l9ekBU2zRTAGMrvuWwn+QvLvEuVrFwBx
         8+uDiclhRCSIWbWr0/dT/ZAbrV/EVK7j+Y0hrRL/W2gQ5bGeZMIuFJT5MXvGsGSvgk
         Riy55/uaTTnIf/IhMFwh1Pwh8AnCgbSkXMi5zc4BD1L5RWNcvcERCcD8HsmHDRBNYU
         l0GNIwzhrBwS5TnF06LhFwbZYskP9R9e+9n1RJEmmeST/DL39ou7DinalNexvVIk+c
         sg04PbTeMnbyyfm7Ivt1tUP3ixVqib6PY+CMExdxgyLP0KJKmaqGDggSKALjf6FAjF
         6k9SoTix31zPg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 64/79] sysv: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:17 -0400
Message-ID: <20230621144735.55953-63-jlayton@kernel.org>
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
 fs/sysv/dir.c    | 6 +++---
 fs/sysv/ialloc.c | 2 +-
 fs/sysv/inode.c  | 6 +++---
 fs/sysv/itree.c  | 4 ++--
 fs/sysv/namei.c  | 6 +++---
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 0140010aa0c3..7c145f2e8b97 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -224,7 +224,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 	memset (de->name + namelen, 0, SYSV_DIRSIZE - namelen - 2);
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
 	dir_commit_chunk(page, pos, SYSV_DIRSIZE);
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	mark_inode_dirty(dir);
 	err = sysv_handle_dirsync(dir);
 out_page:
@@ -249,7 +249,7 @@ int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
 	}
 	de->inode = 0;
 	dir_commit_chunk(page, pos, SYSV_DIRSIZE);
-	inode->i_ctime = inode->i_mtime = current_time(inode);
+	inode->i_mtime = inode_ctime_set_current(inode);
 	mark_inode_dirty(inode);
 	return sysv_handle_dirsync(inode);
 }
@@ -346,7 +346,7 @@ int sysv_set_link(struct sysv_dir_entry *de, struct page *page,
 	}
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
 	dir_commit_chunk(page, pos, SYSV_DIRSIZE);
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	mark_inode_dirty(dir);
 	return sysv_handle_dirsync(inode);
 }
diff --git a/fs/sysv/ialloc.c b/fs/sysv/ialloc.c
index e732879036ab..ade57ef69e3f 100644
--- a/fs/sysv/ialloc.c
+++ b/fs/sysv/ialloc.c
@@ -165,7 +165,7 @@ struct inode * sysv_new_inode(const struct inode * dir, umode_t mode)
 	dirty_sb(sb);
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	inode->i_ino = fs16_to_cpu(sbi, ino);
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 	inode->i_blocks = 0;
 	memset(SYSV_I(inode)->i_data, 0, sizeof(SYSV_I(inode)->i_data));
 	SYSV_I(inode)->i_dir_start_lookup = 0;
diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
index 9e8d4a6fb2f3..53143b9e125a 100644
--- a/fs/sysv/inode.c
+++ b/fs/sysv/inode.c
@@ -202,8 +202,8 @@ struct inode *sysv_iget(struct super_block *sb, unsigned int ino)
 	inode->i_size = fs32_to_cpu(sbi, raw_inode->i_size);
 	inode->i_atime.tv_sec = fs32_to_cpu(sbi, raw_inode->i_atime);
 	inode->i_mtime.tv_sec = fs32_to_cpu(sbi, raw_inode->i_mtime);
-	inode->i_ctime.tv_sec = fs32_to_cpu(sbi, raw_inode->i_ctime);
-	inode->i_ctime.tv_nsec = 0;
+	inode_ctime_set_sec(inode, fs32_to_cpu(sbi, raw_inode->i_ctime));
+	inode_ctime_set_nsec(inode, 0);
 	inode->i_atime.tv_nsec = 0;
 	inode->i_mtime.tv_nsec = 0;
 	inode->i_blocks = 0;
@@ -256,7 +256,7 @@ static int __sysv_write_inode(struct inode *inode, int wait)
 	raw_inode->i_size = cpu_to_fs32(sbi, inode->i_size);
 	raw_inode->i_atime = cpu_to_fs32(sbi, inode->i_atime.tv_sec);
 	raw_inode->i_mtime = cpu_to_fs32(sbi, inode->i_mtime.tv_sec);
-	raw_inode->i_ctime = cpu_to_fs32(sbi, inode->i_ctime.tv_sec);
+	raw_inode->i_ctime = cpu_to_fs32(sbi, inode_ctime_peek(inode).tv_sec);
 
 	si = SYSV_I(inode);
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index 58d7f43a1371..5b3bc071d270 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -183,7 +183,7 @@ static inline int splice_branch(struct inode *inode,
 	*where->p = where->key;
 	write_unlock(&pointers_lock);
 
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 
 	/* had we spliced it onto indirect block? */
 	if (where->bh)
@@ -423,7 +423,7 @@ void sysv_truncate (struct inode * inode)
 		}
 		n++;
 	}
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_ctime_set_current(inode);
 	if (IS_SYNC(inode))
 		sysv_sync_inode (inode);
 	else
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index fcf163fea3ad..d5aa9468c362 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -103,7 +103,7 @@ static int sysv_link(struct dentry * old_dentry, struct inode * dir,
 {
 	struct inode *inode = d_inode(old_dentry);
 
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	inode_inc_link_count(inode);
 	ihold(inode);
 
@@ -161,7 +161,7 @@ static int sysv_unlink(struct inode * dir, struct dentry * dentry)
 
 	err = sysv_delete_entry(de, page);
 	if (!err) {
-		inode->i_ctime = dir->i_ctime;
+		inode_ctime_set(inode, inode_ctime_peek(dir));
 		inode_dec_link_count(inode);
 	}
 	unmap_and_put_page(page, de);
@@ -230,7 +230,7 @@ static int sysv_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		unmap_and_put_page(new_page, new_de);
 		if (err)
 			goto out_dir;
-		new_inode->i_ctime = current_time(new_inode);
+		inode_ctime_set_current(new_inode);
 		if (dir_de)
 			drop_nlink(new_inode);
 		inode_dec_link_count(new_inode);
-- 
2.41.0


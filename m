Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED877387EB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjFUOwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjFUOvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:51:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487121FC9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:49:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 858FA61594
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF25C433C8;
        Wed, 21 Jun 2023 14:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358932;
        bh=Y+tTUnB61nyY7kKqbWS86qJFkQ3jYva05dtyWEpGLh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ayvfvJgo1pVIg9LcBf5ofNEIdwVoxsgl7Ok9iCh+qvp7Se8dRNFqm5c3N/LFxJE6M
         TWXmQPpRxTrsphAMZxDXSbrdhyvAUZqF6GvBnAmxtH9E7aamzvaDZYRSAcHQEeD0vC
         j5raZLQwTUlRBwuIk57/ba2Jgp6TRIhK+c3kBbbTIVWdzZ5GOyNc4+bLGkiqNUHOxD
         Jg3W6AtFQT2NC0kdxhXflisNlt3E95u8Dhyy9I4R/wQb8FvdF9j9bva7Vf3dIgbUDY
         VL2HaCRpJ6cOJVANZFRArnfraUGAZVuk80orP3whwp/WXt16pUUpFZ7PnD18uLr8Fe
         h7lS9pysPXO/A==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 44/79] minix: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:57 -0400
Message-ID: <20230621144735.55953-43-jlayton@kernel.org>
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
 fs/minix/bitmap.c       |  2 +-
 fs/minix/dir.c          |  6 +++---
 fs/minix/inode.c        | 11 ++++++-----
 fs/minix/itree_common.c |  4 ++--
 fs/minix/namei.c        |  6 +++---
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/minix/bitmap.c b/fs/minix/bitmap.c
index 870207ba23f1..9d41dce3b8db 100644
--- a/fs/minix/bitmap.c
+++ b/fs/minix/bitmap.c
@@ -251,7 +251,7 @@ struct inode *minix_new_inode(const struct inode *dir, umode_t mode)
 	}
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	inode->i_ino = j;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 	inode->i_blocks = 0;
 	memset(&minix_i(inode)->u, 0, sizeof(minix_i(inode)->u));
 	insert_inode_hash(inode);
diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index bf9858f76b6a..03d556635ffc 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -281,7 +281,7 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 		de->inode = inode->i_ino;
 	}
 	dir_commit_chunk(page, pos, sbi->s_dirsize);
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	mark_inode_dirty(dir);
 	err = minix_handle_dirsync(dir);
 out_put:
@@ -313,7 +313,7 @@ int minix_delete_entry(struct minix_dir_entry *de, struct page *page)
 	else
 		de->inode = 0;
 	dir_commit_chunk(page, pos, len);
-	inode->i_ctime = inode->i_mtime = current_time(inode);
+	inode->i_mtime = inode_ctime_set_current(inode);
 	mark_inode_dirty(inode);
 	return minix_handle_dirsync(inode);
 }
@@ -436,7 +436,7 @@ int minix_set_link(struct minix_dir_entry *de, struct page *page,
 	else
 		de->inode = inode->i_ino;
 	dir_commit_chunk(page, pos, sbi->s_dirsize);
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	mark_inode_dirty(dir);
 	return minix_handle_dirsync(dir);
 }
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index e9fbb5303a22..e9c45ecf6ec2 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -501,10 +501,11 @@ static struct inode *V1_minix_iget(struct inode *inode)
 	i_gid_write(inode, raw_inode->i_gid);
 	set_nlink(inode, raw_inode->i_nlinks);
 	inode->i_size = raw_inode->i_size;
-	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode->i_ctime.tv_sec = raw_inode->i_time;
+	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode_ctime_set_sec(inode,
+									    raw_inode->i_time);
 	inode->i_mtime.tv_nsec = 0;
 	inode->i_atime.tv_nsec = 0;
-	inode->i_ctime.tv_nsec = 0;
+	inode_ctime_set_nsec(inode, 0);
 	inode->i_blocks = 0;
 	for (i = 0; i < 9; i++)
 		minix_inode->u.i1_data[i] = raw_inode->i_zone[i];
@@ -543,10 +544,10 @@ static struct inode *V2_minix_iget(struct inode *inode)
 	inode->i_size = raw_inode->i_size;
 	inode->i_mtime.tv_sec = raw_inode->i_mtime;
 	inode->i_atime.tv_sec = raw_inode->i_atime;
-	inode->i_ctime.tv_sec = raw_inode->i_ctime;
+	inode_ctime_set_sec(inode, raw_inode->i_ctime);
 	inode->i_mtime.tv_nsec = 0;
 	inode->i_atime.tv_nsec = 0;
-	inode->i_ctime.tv_nsec = 0;
+	inode_ctime_set_nsec(inode, 0);
 	inode->i_blocks = 0;
 	for (i = 0; i < 10; i++)
 		minix_inode->u.i2_data[i] = raw_inode->i_zone[i];
@@ -622,7 +623,7 @@ static struct buffer_head * V2_minix_update_inode(struct inode * inode)
 	raw_inode->i_size = inode->i_size;
 	raw_inode->i_mtime = inode->i_mtime.tv_sec;
 	raw_inode->i_atime = inode->i_atime.tv_sec;
-	raw_inode->i_ctime = inode->i_ctime.tv_sec;
+	raw_inode->i_ctime = inode_ctime_peek(inode).tv_sec;
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
 		raw_inode->i_zone[0] = old_encode_dev(inode->i_rdev);
 	else for (i = 0; i < 10; i++)
diff --git a/fs/minix/itree_common.c b/fs/minix/itree_common.c
index 446148792f41..78e48a6c78a2 100644
--- a/fs/minix/itree_common.c
+++ b/fs/minix/itree_common.c
@@ -131,7 +131,7 @@ static inline int splice_branch(struct inode *inode,
 
 	/* We are done with atomic stuff, now do the rest of housekeeping */
 
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 
 	/* had we spliced it onto indirect block? */
 	if (where->bh)
@@ -350,7 +350,7 @@ static inline void truncate (struct inode * inode)
 		}
 		first_whole++;
 	}
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_ctime_set_current(inode);
 	mark_inode_dirty(inode);
 }
 
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 956d5183828d..f55ea33486c9 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -98,7 +98,7 @@ static int minix_link(struct dentry * old_dentry, struct inode * dir,
 {
 	struct inode *inode = d_inode(old_dentry);
 
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	inode_inc_link_count(inode);
 	ihold(inode);
 	return add_nondir(dentry, inode);
@@ -154,7 +154,7 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
 
 	if (err)
 		return err;
-	inode->i_ctime = dir->i_ctime;
+	inode_ctime_set(inode, inode_ctime_peek(dir));
 	inode_dec_link_count(inode);
 	return 0;
 }
@@ -218,7 +218,7 @@ static int minix_rename(struct mnt_idmap *idmap,
 		put_page(new_page);
 		if (err)
 			goto out_dir;
-		new_inode->i_ctime = current_time(new_inode);
+		inode_ctime_set_current(new_inode);
 		if (dir_de)
 			drop_nlink(new_inode);
 		inode_dec_link_count(new_inode);
-- 
2.41.0


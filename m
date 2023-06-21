Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B863D7387B5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjFUOt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjFUOtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:49:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C3C1FED
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:48:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F5B1615A9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4538EC433C9;
        Wed, 21 Jun 2023 14:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358879;
        bh=/G/8OrDUR4zym7zlwzSJLF/gNXiLX28yyw4v17vzbjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rzMrX89/mG8egQ716WPUWY2wp5UXSzO8WvKzz6saR1Iuk7Sba3sLLpRFKYcUg9Gcc
         Tz6CyvWRMl01l+w6WqPcBdVSzzzCSRSFFjuqYR2gDyWrQEYPEfZoc9RneOFv0G7AiB
         U9ywc35KYXj2DsWJwrKjoPBj49/MMWGDiLPR/Prh5fcdCSxcxSqQNgu0QbIpzonKLY
         BTDGc0ob86W2ylUDM2k4DIQFF1JpNI69hy8OZ2MWA6Yj/Q6XaUujOpRwjfClRF2xBl
         Vkkacmh/fbNnqSmxt6keMV1+mFdiTBZvZsfTZJsKAc36EPM5XKxj6S3ZUO9wfWol2/
         xx3F271ESgERA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/79] bfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:28 -0400
Message-ID: <20230621144735.55953-14-jlayton@kernel.org>
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
 fs/bfs/dir.c   | 16 ++++++++--------
 fs/bfs/inode.c |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
index d2e8a2a56b05..5bcfc6e481bc 100644
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -97,7 +97,7 @@ static int bfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	set_bit(ino, info->si_imap);
 	info->si_freei--;
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 	inode->i_blocks = 0;
 	inode->i_op = &bfs_file_inops;
 	inode->i_fop = &bfs_file_operations;
@@ -158,7 +158,7 @@ static int bfs_link(struct dentry *old, struct inode *dir,
 		return err;
 	}
 	inc_nlink(inode);
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	mark_inode_dirty(inode);
 	ihold(inode);
 	d_instantiate(new, inode);
@@ -187,9 +187,9 @@ static int bfs_unlink(struct inode *dir, struct dentry *dentry)
 	}
 	de->ino = 0;
 	mark_buffer_dirty_inode(bh, dir);
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	mark_inode_dirty(dir);
-	inode->i_ctime = dir->i_ctime;
+	inode_ctime_set(inode, inode_ctime_peek(dir));
 	inode_dec_link_count(inode);
 	error = 0;
 
@@ -240,10 +240,10 @@ static int bfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			goto end_rename;
 	}
 	old_de->ino = 0;
-	old_dir->i_ctime = old_dir->i_mtime = current_time(old_dir);
+	old_dir->i_mtime = inode_ctime_set_current(old_dir);
 	mark_inode_dirty(old_dir);
 	if (new_inode) {
-		new_inode->i_ctime = current_time(new_inode);
+		inode_ctime_set_current(new_inode);
 		inode_dec_link_count(new_inode);
 	}
 	mark_buffer_dirty_inode(old_bh, old_dir);
@@ -292,9 +292,9 @@ static int bfs_add_entry(struct inode *dir, const struct qstr *child, int ino)
 				pos = (block - sblock) * BFS_BSIZE + off;
 				if (pos >= dir->i_size) {
 					dir->i_size += BFS_DIRENT_SIZE;
-					dir->i_ctime = current_time(dir);
+					inode_ctime_set_current(dir);
 				}
-				dir->i_mtime = dir->i_ctime = current_time(dir);
+				dir->i_mtime = inode_ctime_set_current(dir);
 				mark_inode_dirty(dir);
 				de->ino = cpu_to_le16((u16)ino);
 				for (i = 0; i < BFS_NAMELEN; i++)
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index 1926bec2c850..c964316be32b 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -82,10 +82,10 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
 	inode->i_blocks = BFS_FILEBLOCKS(di);
 	inode->i_atime.tv_sec =  le32_to_cpu(di->i_atime);
 	inode->i_mtime.tv_sec =  le32_to_cpu(di->i_mtime);
-	inode->i_ctime.tv_sec =  le32_to_cpu(di->i_ctime);
+	inode_ctime_set_sec(inode, le32_to_cpu(di->i_ctime));
 	inode->i_atime.tv_nsec = 0;
 	inode->i_mtime.tv_nsec = 0;
-	inode->i_ctime.tv_nsec = 0;
+	inode_ctime_set_nsec(inode, 0);
 
 	brelse(bh);
 	unlock_new_inode(inode);
@@ -143,7 +143,7 @@ static int bfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	di->i_nlink = cpu_to_le32(inode->i_nlink);
 	di->i_atime = cpu_to_le32(inode->i_atime.tv_sec);
 	di->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
-	di->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec);
+	di->i_ctime = cpu_to_le32(inode_ctime_peek(inode).tv_sec);
 	i_sblock = BFS_I(inode)->i_sblock;
 	di->i_sblock = cpu_to_le32(i_sblock);
 	di->i_eblock = cpu_to_le32(BFS_I(inode)->i_eblock);
-- 
2.41.0


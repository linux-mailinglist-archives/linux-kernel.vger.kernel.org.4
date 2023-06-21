Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888787387E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjFUOwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjFUOuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:50:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABE7296C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:48:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44A066159B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B23C433C0;
        Wed, 21 Jun 2023 14:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358922;
        bh=UvNq+M9oth0ZwLvHaFU15fGRvb6agUkybQaQqyNXMdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hSKmtL7GOzh8ryKxNvlPtCPaMYjdREurFTyaiU4tT/RKIG0YTrSJ2eVDf3SEBiyMq
         j5WmOAz0nBbsqQfrOq+RV9ZFdzGj1d+9E3epTOFd4lMEcakc46syFOL9LuADxQIWNj
         a+f9l8ReAu1jL/NzHaH06oT/DyIYYozoWFslZ+exTUcRJ0B4bOcut3FgOsYyirXx50
         5eTemc9IpO6dKCthte5LY8lHUUuYVglt9Yrk//4n8zNrQXKDaPd3q8Yx8cN5VTO1mc
         pdfRxg4A8WDnTh9BC1E37C3xAPk7o3WbgPYzbRVmhobR/726zRgQebtcbA0AlPP1Qx
         R2XH4puSJLm5A==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 39/79] hugetlbfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:52 -0400
Message-ID: <20230621144735.55953-38-jlayton@kernel.org>
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
 fs/hugetlbfs/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 90361a922cec..7be5a8f5927f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -889,7 +889,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size)
 		i_size_write(inode, offset + len);
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 out:
 	inode_unlock(inode);
 	return error;
@@ -937,7 +937,7 @@ static struct inode *hugetlbfs_get_root(struct super_block *sb,
 		inode->i_mode = S_IFDIR | ctx->mode;
 		inode->i_uid = ctx->uid;
 		inode->i_gid = ctx->gid;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 		inode->i_op = &hugetlbfs_dir_inode_operations;
 		inode->i_fop = &simple_dir_operations;
 		/* directory inodes start off with i_nlink == 2 (for "." entry) */
@@ -981,7 +981,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 		lockdep_set_class(&inode->i_mapping->i_mmap_rwsem,
 				&hugetlbfs_i_mmap_rwsem_key);
 		inode->i_mapping->a_ops = &hugetlbfs_aops;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 		inode->i_mapping->private_data = resv_map;
 		info->seals = F_SEAL_SEAL;
 		switch (mode & S_IFMT) {
@@ -1024,7 +1024,7 @@ static int hugetlbfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode, dev);
 	if (!inode)
 		return -ENOSPC;
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	d_instantiate(dentry, inode);
 	dget(dentry);/* Extra count - pin the dentry in core */
 	return 0;
@@ -1056,7 +1056,7 @@ static int hugetlbfs_tmpfile(struct mnt_idmap *idmap,
 	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode | S_IFREG, 0);
 	if (!inode)
 		return -ENOSPC;
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	d_tmpfile(file, inode);
 	return finish_open_simple(file, 0);
 }
@@ -1078,7 +1078,7 @@ static int hugetlbfs_symlink(struct mnt_idmap *idmap,
 		} else
 			iput(inode);
 	}
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 
 	return error;
 }
-- 
2.41.0


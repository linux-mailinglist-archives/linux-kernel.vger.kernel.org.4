Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05237387DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjFUOv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjFUOuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A912940
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:48:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D10CE615A2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B420AC433C8;
        Wed, 21 Jun 2023 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358921;
        bh=E1H3kjMPqVnnnLtEOaYufq1IWOlpBohF5iQnPvBQJ2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eKBamOQM8CEJKZa5No1alMcSV8Mq2/pCaf+u7haRk9sjMfxJF0ULmIuHuUEZtWtvE
         w5if+zKnqyQAB08jimvGS1hsVyxlxHYkZRBE2fu1PAc0stkNBbxbZ1TK9I5AMkYwK/
         1uv4SXwDuGssXtsbqtVN2hlDFWr9Yb6NZx5wxRt57vD8e2KyBNtaG+QmMcfg0y6+ny
         eU8NwLB9DTOExNKwlKR+XfsK8NQqQwJs5n9VgTF7aRpG2Dkcwo7Rn7xnPF/VRUiIvI
         7ZCINTUR6ESF52HrnbOcDgvlPl9At78I5AwlgGIEyy9s4S8UORWFpMXwRIb/Y4v1IV
         2tm/uPhPJ+nSQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 38/79] hpfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:51 -0400
Message-ID: <20230621144735.55953-37-jlayton@kernel.org>
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
 fs/hpfs/dir.c   |  8 ++++----
 fs/hpfs/inode.c |  6 +++---
 fs/hpfs/namei.c | 26 +++++++++++++++-----------
 fs/hpfs/super.c |  5 +++--
 4 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/fs/hpfs/dir.c b/fs/hpfs/dir.c
index f32f15669996..fe808e6a3962 100644
--- a/fs/hpfs/dir.c
+++ b/fs/hpfs/dir.c
@@ -277,10 +277,10 @@ struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry, unsigned in
 	 * inode.
 	 */
 
-	if (!result->i_ctime.tv_sec) {
-		if (!(result->i_ctime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(de->creation_date))))
-			result->i_ctime.tv_sec = 1;
-		result->i_ctime.tv_nsec = 0;
+	if (!inode_ctime_peek(result).tv_sec) {
+		if (!(inode_ctime_set_sec(result, local_to_gmt(dir->i_sb, le32_to_cpu(de->creation_date)))))
+			inode_ctime_set_sec(result, 1);
+		inode_ctime_set_nsec(result, 0);
 		result->i_mtime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(de->write_date));
 		result->i_mtime.tv_nsec = 0;
 		result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(de->read_date));
diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
index e50e92a42432..48e71035d88c 100644
--- a/fs/hpfs/inode.c
+++ b/fs/hpfs/inode.c
@@ -36,7 +36,7 @@ void hpfs_init_inode(struct inode *i)
 	hpfs_inode->i_rddir_off = NULL;
 	hpfs_inode->i_dirty = 0;
 
-	i->i_ctime.tv_sec = i->i_ctime.tv_nsec = 0;
+	inode_ctime_set_sec(i, inode_ctime_set_nsec(i, 0));
 	i->i_mtime.tv_sec = i->i_mtime.tv_nsec = 0;
 	i->i_atime.tv_sec = i->i_atime.tv_nsec = 0;
 }
@@ -232,7 +232,7 @@ void hpfs_write_inode_nolock(struct inode *i)
 	if (de) {
 		de->write_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_mtime.tv_sec));
 		de->read_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_atime.tv_sec));
-		de->creation_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_ctime.tv_sec));
+		de->creation_date = cpu_to_le32(gmt_to_local(i->i_sb, inode_ctime_peek(i).tv_sec));
 		de->read_only = !(i->i_mode & 0222);
 		de->ea_size = cpu_to_le32(hpfs_inode->i_ea_size);
 		hpfs_mark_4buffers_dirty(&qbh);
@@ -242,7 +242,7 @@ void hpfs_write_inode_nolock(struct inode *i)
 		if ((de = map_dirent(i, hpfs_inode->i_dno, "\001\001", 2, NULL, &qbh))) {
 			de->write_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_mtime.tv_sec));
 			de->read_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_atime.tv_sec));
-			de->creation_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_ctime.tv_sec));
+			de->creation_date = cpu_to_le32(gmt_to_local(i->i_sb, inode_ctime_peek(i).tv_sec));
 			de->read_only = !(i->i_mode & 0222);
 			de->ea_size = cpu_to_le32(/*hpfs_inode->i_ea_size*/0);
 			de->file_size = cpu_to_le32(0);
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index 69fb40b2c99a..c065ef3fec52 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -13,10 +13,10 @@ static void hpfs_update_directory_times(struct inode *dir)
 {
 	time64_t t = local_to_gmt(dir->i_sb, local_get_seconds(dir->i_sb));
 	if (t == dir->i_mtime.tv_sec &&
-	    t == dir->i_ctime.tv_sec)
+	    t == inode_ctime_peek(dir).tv_sec)
 		return;
-	dir->i_mtime.tv_sec = dir->i_ctime.tv_sec = t;
-	dir->i_mtime.tv_nsec = dir->i_ctime.tv_nsec = 0;
+	dir->i_mtime.tv_sec = inode_ctime_set_sec(dir, t);
+	dir->i_mtime.tv_nsec = inode_ctime_set_nsec(dir, 0);
 	hpfs_write_inode_nolock(dir);
 }
 
@@ -59,8 +59,9 @@ static int hpfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	result->i_ino = fno;
 	hpfs_i(result)->i_parent_dir = dir->i_ino;
 	hpfs_i(result)->i_dno = dno;
-	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
-	result->i_ctime.tv_nsec = 0; 
+	inode_ctime_set_sec(result,
+			    result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)));
+	inode_ctime_set_nsec(result, 0); 
 	result->i_mtime.tv_nsec = 0; 
 	result->i_atime.tv_nsec = 0; 
 	hpfs_i(result)->i_ea_size = 0;
@@ -167,8 +168,9 @@ static int hpfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	result->i_fop = &hpfs_file_ops;
 	set_nlink(result, 1);
 	hpfs_i(result)->i_parent_dir = dir->i_ino;
-	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
-	result->i_ctime.tv_nsec = 0;
+	inode_ctime_set_sec(result,
+			    result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)));
+	inode_ctime_set_nsec(result, 0);
 	result->i_mtime.tv_nsec = 0;
 	result->i_atime.tv_nsec = 0;
 	hpfs_i(result)->i_ea_size = 0;
@@ -250,8 +252,9 @@ static int hpfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	hpfs_init_inode(result);
 	result->i_ino = fno;
 	hpfs_i(result)->i_parent_dir = dir->i_ino;
-	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
-	result->i_ctime.tv_nsec = 0;
+	inode_ctime_set_sec(result,
+			    result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)));
+	inode_ctime_set_nsec(result, 0);
 	result->i_mtime.tv_nsec = 0;
 	result->i_atime.tv_nsec = 0;
 	hpfs_i(result)->i_ea_size = 0;
@@ -326,8 +329,9 @@ static int hpfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	result->i_ino = fno;
 	hpfs_init_inode(result);
 	hpfs_i(result)->i_parent_dir = dir->i_ino;
-	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
-	result->i_ctime.tv_nsec = 0;
+	inode_ctime_set_sec(result,
+			    result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)));
+	inode_ctime_set_nsec(result, 0);
 	result->i_mtime.tv_nsec = 0;
 	result->i_atime.tv_nsec = 0;
 	hpfs_i(result)->i_ea_size = 0;
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index 1cb89595b875..cc7602d5485e 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -729,8 +729,9 @@ static int hpfs_fill_super(struct super_block *s, void *options, int silent)
 		root->i_atime.tv_nsec = 0;
 		root->i_mtime.tv_sec = local_to_gmt(s, le32_to_cpu(de->write_date));
 		root->i_mtime.tv_nsec = 0;
-		root->i_ctime.tv_sec = local_to_gmt(s, le32_to_cpu(de->creation_date));
-		root->i_ctime.tv_nsec = 0;
+		inode_ctime_set_sec(root,
+				    local_to_gmt(s, le32_to_cpu(de->creation_date)));
+		inode_ctime_set_nsec(root, 0);
 		hpfs_i(root)->i_ea_size = le32_to_cpu(de->ea_size);
 		hpfs_i(root)->i_parent_dir = root->i_ino;
 		if (root->i_size == -1)
-- 
2.41.0


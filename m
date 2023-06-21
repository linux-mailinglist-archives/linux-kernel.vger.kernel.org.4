Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20547387E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjFUOwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjFUOvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:51:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04972D55
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC2B46157E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A691C433C8;
        Wed, 21 Jun 2023 14:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358939;
        bh=SEEgw3h/jPpL+PXMgRE1LQFrTLNf3+Q9wbIwlE7Cr0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gcAdQAMzyrGX5k0WK/Id5YI5rykQYZBVvKLlxg5vMF+8k4rmqKh1fsU5cgbPB5gyB
         vp8R00GrGH2340dsBfafDn2Se13REpYMWmPPc/mWmdz+f9GMByUZMA69dm2pnlPbv7
         iuZ2BE+iuVDdFPLm1FwfOBv6S7rzo4BZ/m6bvFMQjoMwQYl3BPQoSuFeaTbn7yTchS
         9jR0ennu4zUPa/KqRRYBhLcpe54un12hHEVvSC3qv4nsz/FF6gfm1MOnlIxo80Smv8
         snJtL31ypO9aXMvcDf9+ceBmpf5j0wX+QnzNeXJV6NoMPtI4V3cG+PVgbA9Vdavq9D
         I8zzvMV7FFb8w==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Namjae Jeon <linkinjeon@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 48/79] ntfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:01 -0400
Message-ID: <20230621144735.55953-47-jlayton@kernel.org>
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
 fs/ntfs/inode.c | 15 ++++++++-------
 fs/ntfs/mft.c   |  3 +--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 6c3f38d66579..285142c22275 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -654,7 +654,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	 * always changes, when mtime is changed. ctime can be changed on its
 	 * own, mtime is then not changed, e.g. when a file is renamed.
 	 */
-	vi->i_ctime = ntfs2utc(si->last_mft_change_time);
+	inode_ctime_set(vi, ntfs2utc(si->last_mft_change_time));
 	/*
 	 * Last access to the data within the file. Not changed during a rename
 	 * for example but changed whenever the file is written to.
@@ -1218,7 +1218,7 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 	vi->i_gid	= base_vi->i_gid;
 	set_nlink(vi, base_vi->i_nlink);
 	vi->i_mtime	= base_vi->i_mtime;
-	vi->i_ctime	= base_vi->i_ctime;
+	inode_ctime_set(vi, inode_ctime_peek(base_vi));
 	vi->i_atime	= base_vi->i_atime;
 	vi->i_generation = ni->seq_no = base_ni->seq_no;
 
@@ -1484,7 +1484,7 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 	vi->i_gid	= base_vi->i_gid;
 	set_nlink(vi, base_vi->i_nlink);
 	vi->i_mtime	= base_vi->i_mtime;
-	vi->i_ctime	= base_vi->i_ctime;
+	inode_ctime_set(vi, inode_ctime_peek(base_vi));
 	vi->i_atime	= base_vi->i_atime;
 	vi->i_generation = ni->seq_no = base_ni->seq_no;
 	/* Set inode type to zero but preserve permissions. */
@@ -2804,13 +2804,14 @@ int ntfs_truncate(struct inode *vi)
 	 */
 	if (!IS_NOCMTIME(VFS_I(base_ni)) && !IS_RDONLY(VFS_I(base_ni))) {
 		struct timespec64 now = current_time(VFS_I(base_ni));
+		struct timespec64 ctime = inode_ctime_peek(VFS_I(base_ni));
 		int sync_it = 0;
 
 		if (!timespec64_equal(&VFS_I(base_ni)->i_mtime, &now) ||
-		    !timespec64_equal(&VFS_I(base_ni)->i_ctime, &now))
+		    !timespec64_equal(&ctime, &now))
 			sync_it = 1;
 		VFS_I(base_ni)->i_mtime = now;
-		VFS_I(base_ni)->i_ctime = now;
+		inode_ctime_set(VFS_I(base_ni), now);
 
 		if (sync_it)
 			mark_inode_dirty_sync(VFS_I(base_ni));
@@ -2928,7 +2929,7 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (ia_valid & ATTR_MTIME)
 		vi->i_mtime = attr->ia_mtime;
 	if (ia_valid & ATTR_CTIME)
-		vi->i_ctime = attr->ia_ctime;
+		inode_ctime_set(vi, attr->ia_ctime);
 	mark_inode_dirty(vi);
 out:
 	return err;
@@ -3004,7 +3005,7 @@ int __ntfs_write_inode(struct inode *vi, int sync)
 		si->last_data_change_time = nt;
 		modified = true;
 	}
-	nt = utc2ntfs(vi->i_ctime);
+	nt = utc2ntfs(inode_ctime_peek(vi));
 	if (si->last_mft_change_time != nt) {
 		ntfs_debug("Updating ctime for inode 0x%lx: old = 0x%llx, "
 				"new = 0x%llx", vi->i_ino, (long long)
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 0155f106ec34..68821e312ed2 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -2682,8 +2682,7 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
 			vi->i_mode &= ~S_IWUGO;
 
 		/* Set the inode times to the current time. */
-		vi->i_atime = vi->i_mtime = vi->i_ctime =
-			current_time(vi);
+		vi->i_atime = vi->i_mtime = inode_ctime_set_current(vi);
 		/*
 		 * Set the file size to 0, the ntfs inode sizes are set to 0 by
 		 * the call to ntfs_init_big_inode() below.
-- 
2.41.0


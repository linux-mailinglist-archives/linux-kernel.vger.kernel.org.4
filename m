Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FD3738803
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjFUOyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbjFUOxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:53:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C8530EA;
        Wed, 21 Jun 2023 07:49:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89CD6615A8;
        Wed, 21 Jun 2023 14:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC8DC433C0;
        Wed, 21 Jun 2023 14:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358978;
        bh=kW7QejN6cAdGFdYK6FmuoXUQCFABRtiU/bPOzqJ3sQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Om1zaprHKqahWUV9/Gb4pL1uWao/LoM18XQ2soYV0p9NkjgIzsSq7CfX8a1ZMAqYv
         xe7Vcu5fyXW8Y9LONV/Cv5fVd7ofyPQvktf428PNCF2a3qE/jn603o3s2EbDZlSwI8
         LaDgkwQ+XQeT5mV3zebQF5XE/3ry5+qgLF603YIx5Mi1YyELbbRLUZ4i5zdyOm8OYH
         wVkKKsC/4v85K2CJ1z6bWfdS02qTFkrUkB2EMfmS5mGiEke8ru92/xonjM3Vv+Xxn4
         1sIwQiQfV22hJODRuL1stvtmeLBTlcdLn1XHGxsuB1SwyEcswXLMYWp5LQ7uhTW3pK
         6+zalzUCFnwyQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 70/79] xfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:23 -0400
Message-ID: <20230621144735.55953-69-jlayton@kernel.org>
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
 fs/xfs/libxfs/xfs_inode_buf.c   | 4 ++--
 fs/xfs/libxfs/xfs_trans_inode.c | 2 +-
 fs/xfs/xfs_acl.c                | 2 +-
 fs/xfs/xfs_bmap_util.c          | 6 ++++--
 fs/xfs/xfs_inode.c              | 2 +-
 fs/xfs/xfs_inode_item.c         | 2 +-
 fs/xfs/xfs_iops.c               | 4 ++--
 fs/xfs/xfs_itable.c             | 4 ++--
 8 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index 758aacd8166b..d5c1d3c86257 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -222,7 +222,7 @@ xfs_inode_from_disk(
 	 */
 	inode->i_atime = xfs_inode_from_disk_ts(from, from->di_atime);
 	inode->i_mtime = xfs_inode_from_disk_ts(from, from->di_mtime);
-	inode->i_ctime = xfs_inode_from_disk_ts(from, from->di_ctime);
+	inode_ctime_set(inode, xfs_inode_from_disk_ts(from, from->di_ctime));
 
 	ip->i_disk_size = be64_to_cpu(from->di_size);
 	ip->i_nblocks = be64_to_cpu(from->di_nblocks);
@@ -316,7 +316,7 @@ xfs_inode_to_disk(
 
 	to->di_atime = xfs_inode_to_disk_ts(ip, inode->i_atime);
 	to->di_mtime = xfs_inode_to_disk_ts(ip, inode->i_mtime);
-	to->di_ctime = xfs_inode_to_disk_ts(ip, inode->i_ctime);
+	to->di_ctime = xfs_inode_to_disk_ts(ip, inode_ctime_peek(inode));
 	to->di_nlink = cpu_to_be32(inode->i_nlink);
 	to->di_gen = cpu_to_be32(inode->i_generation);
 	to->di_mode = cpu_to_be16(inode->i_mode);
diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
index cb4796b6e693..f924e81530be 100644
--- a/fs/xfs/libxfs/xfs_trans_inode.c
+++ b/fs/xfs/libxfs/xfs_trans_inode.c
@@ -67,7 +67,7 @@ xfs_trans_ichgtime(
 	if (flags & XFS_ICHGTIME_MOD)
 		inode->i_mtime = tv;
 	if (flags & XFS_ICHGTIME_CHG)
-		inode->i_ctime = tv;
+		inode_ctime_set(inode, tv);
 	if (flags & XFS_ICHGTIME_CREATE)
 		ip->i_crtime = tv;
 }
diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
index 791db7d9c849..75f17d2bb97c 100644
--- a/fs/xfs/xfs_acl.c
+++ b/fs/xfs/xfs_acl.c
@@ -233,7 +233,7 @@ xfs_acl_set_mode(
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
 	inode->i_mode = mode;
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
 
 	if (xfs_has_wsync(mp))
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index fbb675563208..0d4c141c4413 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1644,6 +1644,7 @@ xfs_swap_extents(
 	uint64_t		f;
 	int			resblks = 0;
 	unsigned int		flags = 0;
+	struct timespec64	ctime;
 
 	/*
 	 * Lock the inodes against other IO, page faults and truncate to
@@ -1756,8 +1757,9 @@ xfs_swap_extents(
 	 * process that the file was not changed out from
 	 * under it.
 	 */
-	if ((sbp->bs_ctime.tv_sec != VFS_I(ip)->i_ctime.tv_sec) ||
-	    (sbp->bs_ctime.tv_nsec != VFS_I(ip)->i_ctime.tv_nsec) ||
+	ctime = inode_ctime_peek(VFS_I(ip));
+	if ((sbp->bs_ctime.tv_sec != ctime.tv_sec) ||
+	    (sbp->bs_ctime.tv_nsec != ctime.tv_nsec) ||
 	    (sbp->bs_mtime.tv_sec != VFS_I(ip)->i_mtime.tv_sec) ||
 	    (sbp->bs_mtime.tv_nsec != VFS_I(ip)->i_mtime.tv_nsec)) {
 		error = -EBUSY;
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 9e62cc500140..763d6c95c56d 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -846,7 +846,7 @@ xfs_init_new_inode(
 	tv = current_time(inode);
 	inode->i_mtime = tv;
 	inode->i_atime = tv;
-	inode->i_ctime = tv;
+	inode_ctime_set(inode, tv);
 
 	ip->i_extsize = 0;
 	ip->i_diflags = 0;
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 91c847a84e10..116038163098 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -528,7 +528,7 @@ xfs_inode_to_log_dinode(
 	memset(to->di_pad3, 0, sizeof(to->di_pad3));
 	to->di_atime = xfs_inode_to_log_dinode_ts(ip, inode->i_atime);
 	to->di_mtime = xfs_inode_to_log_dinode_ts(ip, inode->i_mtime);
-	to->di_ctime = xfs_inode_to_log_dinode_ts(ip, inode->i_ctime);
+	to->di_ctime = xfs_inode_to_log_dinode_ts(ip, inode_ctime_peek(inode));
 	to->di_nlink = inode->i_nlink;
 	to->di_gen = inode->i_generation;
 	to->di_mode = inode->i_mode;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 24718adb3c16..4096c4f86ef7 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -574,7 +574,7 @@ xfs_vn_getattr(
 	stat->ino = ip->i_ino;
 	stat->atime = inode->i_atime;
 	stat->mtime = inode->i_mtime;
-	stat->ctime = inode->i_ctime;
+	stat->ctime = inode_ctime_peek(inode);
 	stat->blocks = XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed_blks);
 
 	if (xfs_has_v3inodes(mp)) {
@@ -1055,7 +1055,7 @@ xfs_vn_update_time(
 
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	if (flags & S_CTIME)
-		inode->i_ctime = *now;
+		inode_ctime_set(inode, *now);
 	if (flags & S_MTIME)
 		inode->i_mtime = *now;
 	if (flags & S_ATIME)
diff --git a/fs/xfs/xfs_itable.c b/fs/xfs/xfs_itable.c
index f225413a993c..75b07eed0602 100644
--- a/fs/xfs/xfs_itable.c
+++ b/fs/xfs/xfs_itable.c
@@ -100,8 +100,8 @@ xfs_bulkstat_one_int(
 	buf->bs_atime_nsec = inode->i_atime.tv_nsec;
 	buf->bs_mtime = inode->i_mtime.tv_sec;
 	buf->bs_mtime_nsec = inode->i_mtime.tv_nsec;
-	buf->bs_ctime = inode->i_ctime.tv_sec;
-	buf->bs_ctime_nsec = inode->i_ctime.tv_nsec;
+	buf->bs_ctime = inode_ctime_peek(inode).tv_sec;
+	buf->bs_ctime_nsec = inode_ctime_peek(inode).tv_nsec;
 	buf->bs_gen = inode->i_generation;
 	buf->bs_mode = inode->i_mode;
 
-- 
2.41.0


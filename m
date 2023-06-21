Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128C27387A2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjFUOsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjFUOr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:47:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199011BCA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:47:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7CE96157F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E541C433C8;
        Wed, 21 Jun 2023 14:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358868;
        bh=3RYKe34tfhw7qCFMfdSwp5DfFyxQfIY9Egtj5X0ni8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jyBusIDy9RnwXDykjRdGdrB37HI23tNaNH9Kn/r/H6n8AyQH5L4VxdrwYFJSGDkUG
         x4GDrOg2uiVQZXTS2OPbIDfoTTTKeulq9Cwe7YOcnFbTqQoi+UTVrFAZima3ScB2T6
         4u8Ho/LD0CpUZfgqeTqip9pYeUUHj4B5eaD5lq2d8HHplRzhLvnGY+J59+rBAUvrHw
         YZEfFfLZ/H35s4BTKT1HaohpIU7HNSajR7+4ovllzIRvDbDTdnuTF7c6DWvrDDNjFe
         rhOeAI/MlrU03RU0BV7Fw8m+fvDGGsWo2j/+BBeq157CrCYzqGSh0b4IXNeb881V8y
         2FVi6HnOyrfJw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/79] 9p: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:21 -0400
Message-ID: <20230621144735.55953-7-jlayton@kernel.org>
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
 fs/9p/vfs_inode.c      |  6 ++++--
 fs/9p/vfs_inode_dotl.c | 11 +++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 36b466e35887..098e4c7160a8 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -261,7 +261,7 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 	inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
 	inode->i_blocks = 0;
 	inode->i_rdev = rdev;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 	inode->i_mapping->a_ops = &v9fs_addr_operations;
 	inode->i_private = NULL;
 
@@ -1153,12 +1153,14 @@ v9fs_stat2inode(struct p9_wstat *stat, struct inode *inode,
 	umode_t mode;
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
 	struct v9fs_inode *v9inode = V9FS_I(inode);
+	struct timespec64 ctime = { .tv_sec  = stat->mtime,
+				    .tv_nsec = 0 };
 
 	set_nlink(inode, 1);
 
 	inode->i_atime.tv_sec = stat->atime;
 	inode->i_mtime.tv_sec = stat->mtime;
-	inode->i_ctime.tv_sec = stat->mtime;
+	inode_ctime_set(inode, ctime);
 
 	inode->i_uid = v9ses->dfltuid;
 	inode->i_gid = v9ses->dfltgid;
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 5361cd2d7996..0041b5fc4407 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -640,14 +640,15 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
 {
 	umode_t mode;
 	struct v9fs_inode *v9inode = V9FS_I(inode);
+	struct timespec64 ctime = { .tv_sec  = stat->st_ctime_sec,
+				    .tv_nsec = stat->st_ctime_nsec };
 
 	if ((stat->st_result_mask & P9_STATS_BASIC) == P9_STATS_BASIC) {
 		inode->i_atime.tv_sec = stat->st_atime_sec;
 		inode->i_atime.tv_nsec = stat->st_atime_nsec;
 		inode->i_mtime.tv_sec = stat->st_mtime_sec;
 		inode->i_mtime.tv_nsec = stat->st_mtime_nsec;
-		inode->i_ctime.tv_sec = stat->st_ctime_sec;
-		inode->i_ctime.tv_nsec = stat->st_ctime_nsec;
+		inode_ctime_set(inode, ctime);
 		inode->i_uid = stat->st_uid;
 		inode->i_gid = stat->st_gid;
 		set_nlink(inode, stat->st_nlink);
@@ -668,10 +669,8 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
 			inode->i_mtime.tv_sec = stat->st_mtime_sec;
 			inode->i_mtime.tv_nsec = stat->st_mtime_nsec;
 		}
-		if (stat->st_result_mask & P9_STATS_CTIME) {
-			inode->i_ctime.tv_sec = stat->st_ctime_sec;
-			inode->i_ctime.tv_nsec = stat->st_ctime_nsec;
-		}
+		if (stat->st_result_mask & P9_STATS_CTIME)
+			inode_ctime_set(inode, ctime);
 		if (stat->st_result_mask & P9_STATS_UID)
 			inode->i_uid = stat->st_uid;
 		if (stat->st_result_mask & P9_STATS_GID)
-- 
2.41.0


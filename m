Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60E67387EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjFUOw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjFUOv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:51:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E542F1FD4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE86E6159A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0AFC433C8;
        Wed, 21 Jun 2023 14:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358946;
        bh=w0GRo5owbosOIL5IOwRPzqacdqpxHdKA8CfKDsWGpQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxs4ILcjp4N2ppOX8asPwYn830WjQU9Lbf/fB7KjgK5wnPYMoVBac0vGJNnyIz/r1
         oIoWqVhtgSfZgo0GiceGIDjeJEx1tG6Rk/GQmIzVVG6Zyit0v5uGPe9Hmqm9oAm35j
         YFm+QXkwHpqJZXyt+/hgjwni0zmTTvcRkc8r5Pvx5ZJ68IfLlGmH2XLp63fe1X/WSx
         +0Yrp3gVDK5Uwbdh2FNWN3vG9jVEEvZQs6U5GdA+xhPOfBKtJHT2g6d6xU8ffV8Xc5
         dh4qXmHXVxShHTqR8oofalh+t08v0XK8JYbjN9d8eCjGfvCHUvAf+OUyyyKaJ8bhd9
         Q9T0BAQmVi1WQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Bob Copeland <me@bobcopeland.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-karma-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 51/79] omfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:04 -0400
Message-ID: <20230621144735.55953-50-jlayton@kernel.org>
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
 fs/omfs/dir.c   |  4 ++--
 fs/omfs/inode.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
index 82cf7e9a665f..9b302b859335 100644
--- a/fs/omfs/dir.c
+++ b/fs/omfs/dir.c
@@ -143,7 +143,7 @@ static int omfs_add_link(struct dentry *dentry, struct inode *inode)
 	mark_buffer_dirty(bh);
 	brelse(bh);
 
-	dir->i_ctime = current_time(dir);
+	inode_ctime_set_current(dir);
 
 	/* mark affected inodes dirty to rebuild checksums */
 	mark_inode_dirty(dir);
@@ -399,7 +399,7 @@ static int omfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (err)
 		goto out;
 
-	old_inode->i_ctime = current_time(old_inode);
+	inode_ctime_set_current(old_inode);
 	mark_inode_dirty(old_inode);
 out:
 	return err;
diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index c4c79e07efc7..d420e5a53de3 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -51,7 +51,7 @@ struct inode *omfs_new_inode(struct inode *dir, umode_t mode)
 	inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
 	inode->i_mapping->a_ops = &omfs_aops;
 
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 	switch (mode & S_IFMT) {
 	case S_IFDIR:
 		inode->i_op = &omfs_dir_inops;
@@ -134,8 +134,8 @@ static int __omfs_write_inode(struct inode *inode, int wait)
 	oi->i_head.h_magic = OMFS_IMAGIC;
 	oi->i_size = cpu_to_be64(inode->i_size);
 
-	ctime = inode->i_ctime.tv_sec * 1000LL +
-		((inode->i_ctime.tv_nsec + 999)/1000);
+	ctime = inode_ctime_peek(inode).tv_sec * 1000LL +
+		((inode_ctime_peek(inode).tv_nsec + 999)/1000);
 	oi->i_ctime = cpu_to_be64(ctime);
 
 	omfs_update_checksums(oi);
@@ -232,10 +232,10 @@ struct inode *omfs_iget(struct super_block *sb, ino_t ino)
 
 	inode->i_atime.tv_sec = ctime;
 	inode->i_mtime.tv_sec = ctime;
-	inode->i_ctime.tv_sec = ctime;
+	inode_ctime_set_sec(inode, ctime);
 	inode->i_atime.tv_nsec = nsecs;
 	inode->i_mtime.tv_nsec = nsecs;
-	inode->i_ctime.tv_nsec = nsecs;
+	inode_ctime_set_nsec(inode, nsecs);
 
 	inode->i_mapping->a_ops = &omfs_aops;
 
-- 
2.41.0


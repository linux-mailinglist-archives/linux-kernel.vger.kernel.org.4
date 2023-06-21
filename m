Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897207387CD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjFUOuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjFUOtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E861BC3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3315E613C5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD2AC433C8;
        Wed, 21 Jun 2023 14:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358891;
        bh=5t8rFLITGfzR6XTuXeH/73+ofK260Rr39ixm/hKd1DU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KYSh3AqMoFIERVUw1Pzf0yp1iaR4R9WhQ8KCbbh51TQuhTxCGlQ5cP5YPZeooJF2s
         Nb2F9ZwoPXuUs+6j15VsyhQeEw4HqvTg218FTDVuhVF7S2RvxxmowqyoHeOv+ctxNh
         gT/HxFOWs7smBPVRBBcuvnanTXlUF2tNH36s5w5CUTXzk/iV7ESXWx+1+SE7uimAL6
         0qlnm492vGLOLA3tu53KYA56uBDGuIQ7BiodqU2RMiMtZqnbPc4DnXskZeOcMxeSPI
         vMXpy4d+kfdVBcKR20t+PFPwzxxL3I8ykCciKnKGYVLLg/vltWkAFgcClw48d2znqh
         cBdyCgry0AJ3g==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/79] devpts: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:35 -0400
Message-ID: <20230621144735.55953-21-jlayton@kernel.org>
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
 fs/devpts/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index fe3db0eda8e4..e07ad406cd52 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -338,7 +338,7 @@ static int mknod_ptmx(struct super_block *sb)
 	}
 
 	inode->i_ino = 2;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 
 	mode = S_IFCHR|opts->ptmxmode;
 	init_special_inode(inode, mode, MKDEV(TTYAUX_MAJOR, 2));
@@ -451,7 +451,7 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
 	if (!inode)
 		goto fail;
 	inode->i_ino = 1;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO | S_IWUSR;
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
@@ -560,7 +560,7 @@ struct dentry *devpts_pty_new(struct pts_fs_info *fsi, int index, void *priv)
 	inode->i_ino = index + 3;
 	inode->i_uid = opts->setuid ? opts->uid : current_fsuid();
 	inode->i_gid = opts->setgid ? opts->gid : current_fsgid();
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 	init_special_inode(inode, S_IFCHR|opts->mode, MKDEV(UNIX98_PTY_SLAVE_MAJOR, index));
 
 	sprintf(s, "%d", index);
-- 
2.41.0


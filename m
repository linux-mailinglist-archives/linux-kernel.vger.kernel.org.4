Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE86738800
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjFUOyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjFUOxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:53:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD3930E7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E612615AB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34408C433CA;
        Wed, 21 Jun 2023 14:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358957;
        bh=9cf+rH9kIsp3ZdLPeIcUhtZoPqtWvR8jGtbLUaFhpUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUMowuMGo8c8jIEEdOPRab7yvrLW1WXFIFcuUwWIO7pQME8C9y3GZxSyoj9yiPgsD
         lDfPUhzrXC5W1WkyeWeLiGdlWDjj1fhCqomgki1LceK/z9uYIwrckvnLlWxeDjZZAY
         8makJ9OibkYRct2oU2fhg2Vnxk2ClaVK/kS416g3wg+HjRhQbJwGolzJ+9iA2sNOUG
         8HeI2Syhp/xyo9vhFzR9sHsyLII6Xxib49dvdrdzobDzsl9Pc5/VdYEqNhUaeRywMT
         DXUx9tYxc6kzsbrVbrvi7x6o+ULo7oz2Fnf4ZQSNW+RkJO5u1HuzTMnA9H6FEg3TJc
         cN7K3re9zC2Zg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 59/79] ramfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:12 -0400
Message-ID: <20230621144735.55953-58-jlayton@kernel.org>
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
 fs/ramfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index fef477c78107..87f59dc5f6f2 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -65,7 +65,7 @@ struct inode *ramfs_get_inode(struct super_block *sb,
 		inode->i_mapping->a_ops = &ram_aops;
 		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
 		mapping_set_unevictable(inode->i_mapping);
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);
@@ -105,7 +105,7 @@ ramfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		d_instantiate(dentry, inode);
 		dget(dentry);	/* Extra count - pin the dentry in core */
 		error = 0;
-		dir->i_mtime = dir->i_ctime = current_time(dir);
+		dir->i_mtime = inode_ctime_set_current(dir);
 	}
 	return error;
 }
@@ -138,7 +138,7 @@ static int ramfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		if (!error) {
 			d_instantiate(dentry, inode);
 			dget(dentry);
-			dir->i_mtime = dir->i_ctime = current_time(dir);
+			dir->i_mtime = inode_ctime_set_current(dir);
 		} else
 			iput(inode);
 	}
-- 
2.41.0


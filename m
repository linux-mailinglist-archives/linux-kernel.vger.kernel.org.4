Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A677387C8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjFUOub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjFUOt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:49:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A5D2680
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:48:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 686FD615A1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC3EC433C0;
        Wed, 21 Jun 2023 14:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358887;
        bh=rS8eAUo4HUuOpWAJVMd8WnT/H+XVhSHn5PZIGcE/ffY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VH4xfG3r0mZawNGCKw4ezDw42voUP+aKbhk48s0Ply0L9PksOUKRfbRYlGLyeL6GY
         MSboueO6SsAh7qECRSj/3SA7xEpB7+558hNBwgO8ziP8ZCH8jpsZvmLX9h/b0DUyBr
         8WRmOS8W7mjUtc0k2mnZPFtXbB12Yn5PtVocI3XuQ4cBhyW6x/afoGtzGf80v/Tiko
         QCDBS84lljUuHdEA2JTCGMhDeqdv5IVBOae/PCPxl9d5i/n5J5AEXiQHSFMicqM9uq
         6Y3r/D0H+IPUEmGLoVdpp9/BwRaqMAn9fCD3as02qJFVacxUOwrUTHhpICJizXrjqt
         nR2bk7/w3PSvQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/79] configfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:32 -0400
Message-ID: <20230621144735.55953-18-jlayton@kernel.org>
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
 fs/configfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index 1c15edbe70ff..21466f7f655f 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -89,7 +89,7 @@ static inline void set_default_inode_attr(struct inode * inode, umode_t mode)
 {
 	inode->i_mode = mode;
 	inode->i_atime = inode->i_mtime =
-		inode->i_ctime = current_time(inode);
+		inode_ctime_set_current(inode);
 }
 
 static inline void set_inode_attr(struct inode * inode, struct iattr * iattr)
@@ -99,7 +99,7 @@ static inline void set_inode_attr(struct inode * inode, struct iattr * iattr)
 	inode->i_gid = iattr->ia_gid;
 	inode->i_atime = iattr->ia_atime;
 	inode->i_mtime = iattr->ia_mtime;
-	inode->i_ctime = iattr->ia_ctime;
+	inode_ctime_set(inode, iattr->ia_ctime);
 }
 
 struct inode *configfs_new_inode(umode_t mode, struct configfs_dirent *sd,
@@ -172,7 +172,7 @@ struct inode *configfs_create(struct dentry *dentry, umode_t mode)
 		return ERR_PTR(-ENOMEM);
 
 	p_inode = d_inode(dentry->d_parent);
-	p_inode->i_mtime = p_inode->i_ctime = current_time(p_inode);
+	p_inode->i_mtime = inode_ctime_set_current(p_inode);
 	configfs_set_inode_lock_class(sd, inode);
 	return inode;
 }
-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36387387A1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjFUOsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjFUOsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:48:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F891BD2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:47:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC600612B7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63CBC433C0;
        Wed, 21 Jun 2023 14:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358869;
        bh=DdJ7C6tlCKMPlU8UZxtXIicsEOsFNUURmBliNnYmY1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/+pHBDDfoDhN/xguQZStTpUaZ1Mqa+zGXrGzOwW3M1J4WigOpi5Uz1+Eg9n+jqYw
         7dhKcbgZ6VYFg0JN79rteiBp+9Zon9lIuQTUVoNtPjrvWqhNJ6qRMg9cIZI+tCtLvS
         tqqdBCzeb37YJ7jAdyyExdnPSTGDSGtMFjZ/6so2LCCf4gUHptJutqwxSke7dKXr/j
         8a1a964AWfU7qr+rtuNWlNTtOXgtJX+I/3o8v+X47b3fdzOutAqbYqyqUE4ZPgmiuT
         z1Y/o1/ZEmJthIp0SIWZEzVkbB3F70OyZD6FqMO/Avkyz9jT2aXwF+tHvD00RHlgf6
         J1x1PR1+H+/mw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/79] adfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:22 -0400
Message-ID: <20230621144735.55953-8-jlayton@kernel.org>
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
 fs/adfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index c3ac613d0975..266191e6b80c 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -270,7 +270,7 @@ adfs_iget(struct super_block *sb, struct object_info *obj)
 	inode->i_mode	 = adfs_atts2mode(sb, inode);
 	adfs_adfs2unix_time(&inode->i_mtime, inode);
 	inode->i_atime = inode->i_mtime;
-	inode->i_ctime = inode->i_mtime;
+	inode_ctime_set(inode, inode->i_mtime);
 
 	if (S_ISDIR(inode->i_mode)) {
 		inode->i_op	= &adfs_dir_inode_operations;
@@ -331,7 +331,7 @@ adfs_notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (ia_valid & ATTR_ATIME)
 		inode->i_atime = attr->ia_atime;
 	if (ia_valid & ATTR_CTIME)
-		inode->i_ctime = attr->ia_ctime;
+		inode_ctime_set(inode, attr->ia_ctime);
 	if (ia_valid & ATTR_MODE) {
 		ADFS_I(inode)->attr = adfs_mode2atts(sb, inode, attr->ia_mode);
 		inode->i_mode = adfs_atts2mode(sb, inode);
-- 
2.41.0


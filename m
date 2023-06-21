Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B297387ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjFUOxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjFUOv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:51:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DB42D66
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:49:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5447615BB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF26BC433C8;
        Wed, 21 Jun 2023 14:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358947;
        bh=JQjWRhfzUQZACyGM7HIbqAr9d+i/Io57Za+SRGPmvhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bdUKZYYLvTy45nvYztdff8e4VCJRwe0ffrexOXDSI/yBlBydc35TzkNnWHmjw5Y/9
         goZxRzSDEzkVWtknVfxfec/Aj+AM2uZRtFVAjAdhfFi3l6MC85srSB3iAHNs95m3/L
         49QZNErjFRDRnCclr1i3sMxkV5OVBXqyjbGJeI7tuFchrrCJQL58vdJl7XNIFAxCMp
         2izD9l1u0LjQ2LXJEub3cMDopxpAIEW+hPjkSzGFSJd73gsxei4tzG/JvBsyqyfm8v
         eME5qHvJOsz0sZQAVec1IErkai6ZKxqxfuw5C+zuqT16qJ0E8s9NZVMyFSJuIw+YjH
         0AJ7qyewiqMdA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 52/79] openpromfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:05 -0400
Message-ID: <20230621144735.55953-51-jlayton@kernel.org>
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
 fs/openpromfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index f0b7f4d51a17..5d5066078638 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -237,7 +237,7 @@ static struct dentry *openpromfs_lookup(struct inode *dir, struct dentry *dentry
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 	if (inode->i_state & I_NEW) {
-		inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 		ent_oi = OP_I(inode);
 		ent_oi->type = ent_type;
 		ent_oi->u = ent_data;
@@ -388,7 +388,7 @@ static int openprom_fill_super(struct super_block *s, struct fs_context *fc)
 	}
 
 	root_inode->i_mtime = root_inode->i_atime =
-		root_inode->i_ctime = current_time(root_inode);
+		inode_ctime_set_current(root_inode);
 	root_inode->i_op = &openprom_inode_operations;
 	root_inode->i_fop = &openprom_operations;
 	root_inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO;
-- 
2.41.0


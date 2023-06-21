Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9767387AC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjFUOtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjFUOsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:48:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106601BFE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:47:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E63956159D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A78C433C8;
        Wed, 21 Jun 2023 14:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358872;
        bh=BMJaFyF2ZVC60oZAWIdEsruiOWgtQ9irmSkTP/JW+sY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bckakp+LrONVjlzggdbjYIPI4kKnFo9QwVnhxj+ne+4JLdr0qnlYBS76QnclgHmUU
         4CJ9RxFk8LKz9EW6rS1RTsJV5TZ+xFmbUVCiZAEKSZS6PRMp+inK8EXsAP7VzSjQ2o
         6tDSxebppwDZMSATmyBlKhcvexE6c8HwviWAnJNifxjK1bfCBNCPzZGKVoczPadXxN
         rl1sHe+D2L/ZzDVhPBYBcnGLg/vmYNKNCy1fqXsEkSTVM0WSeTuZsMLOb84mAd/iX4
         L5ezuJ/AjGhg6XL7CPRBz3h8UDWMsbZoXiJRDccpcYwqaewkP18jKYe8ga+aQPINxS
         p0nC04N0/7zlQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/79] afs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:24 -0400
Message-ID: <20230621144735.55953-10-jlayton@kernel.org>
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
 fs/afs/dynroot.c | 2 +-
 fs/afs/inode.c   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index d7d9402ff718..ee36375de337 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -88,9 +88,9 @@ struct inode *afs_iget_pseudo_dir(struct super_block *sb, bool root)
 	set_nlink(inode, 2);
 	inode->i_uid		= GLOBAL_ROOT_UID;
 	inode->i_gid		= GLOBAL_ROOT_GID;
-	inode->i_ctime = inode->i_atime = inode->i_mtime = current_time(inode);
 	inode->i_blocks		= 0;
 	inode->i_generation	= 0;
+	inode->i_atime		= inode->i_mtime = inode_ctime_set_current(inode);
 
 	set_bit(AFS_VNODE_PSEUDODIR, &vnode->flags);
 	if (!root) {
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 866bab860a88..0b59903c2a43 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -90,7 +90,7 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 	vnode->status = *status;
 
 	t = status->mtime_client;
-	inode->i_ctime = t;
+	inode_ctime_set(inode, t);
 	inode->i_mtime = t;
 	inode->i_atime = t;
 	inode->i_flags |= S_NOATIME;
@@ -206,7 +206,7 @@ static void afs_apply_status(struct afs_operation *op,
 	t = status->mtime_client;
 	inode->i_mtime = t;
 	if (vp->update_ctime)
-		inode->i_ctime = op->ctime;
+		inode_ctime_set(inode, op->ctime);
 
 	if (vnode->status.data_version != status->data_version)
 		data_changed = true;
@@ -252,7 +252,7 @@ static void afs_apply_status(struct afs_operation *op,
 		vnode->netfs.remote_i_size = status->size;
 		if (change_size) {
 			afs_set_i_size(vnode, status->size);
-			inode->i_ctime = t;
+			inode_ctime_set(inode, t);
 			inode->i_atime = t;
 		}
 	}
-- 
2.41.0


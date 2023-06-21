Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DE17387BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjFUOuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjFUOtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:49:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F96C2122
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:48:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AE9761594
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD878C433C9;
        Wed, 21 Jun 2023 14:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358886;
        bh=CEB8rkixi7YO82ePUfp2XAfIP0PNDGjkFzVGTxjtP5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOkYLIREzHCvPajuRMYGs2HkV0oR6hdUH1vR6zgG+zsjyTevjW5ItIzcYe/CB+ixy
         KWjbmSEJFAD5ZQpayLdbJBI30UYmlA/KVZ5oohC4c/1oKMmNGpImKK5+F9YVUh9ECS
         3tOtuM6Wwk6pnf5tddbJSJpJIDSLgzWuwQsNJ7NNnvQwDwutD5qMrw4vODyGKNFeiQ
         6DVQNRxG7cZ3XkfaP7zQYH5UaQj6yhCBoGF62g9U1X2mZfbN+HBwjmbvWrvbTNqhqo
         RJdbzZ7/aU6nhpvaio0M/L2caKuPhjer49gr19DsSe7whjqmZDjb4lnaxYSLLNcOoo
         errAy2UjieNyg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        codalist@coda.cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: [PATCH 18/79] coda: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:31 -0400
Message-ID: <20230621144735.55953-17-jlayton@kernel.org>
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
 fs/coda/coda_linux.c | 2 +-
 fs/coda/dir.c        | 2 +-
 fs/coda/file.c       | 2 +-
 fs/coda/inode.c      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/coda/coda_linux.c b/fs/coda/coda_linux.c
index 903ca8fa4b9b..2a6187ca52d9 100644
--- a/fs/coda/coda_linux.c
+++ b/fs/coda/coda_linux.c
@@ -127,7 +127,7 @@ void coda_vattr_to_iattr(struct inode *inode, struct coda_vattr *attr)
 	if (attr->va_mtime.tv_sec != -1)
 		inode->i_mtime = coda_to_timespec64(attr->va_mtime);
         if (attr->va_ctime.tv_sec != -1)
-		inode->i_ctime = coda_to_timespec64(attr->va_ctime);
+		inode_ctime_set(inode, coda_to_timespec64(attr->va_ctime));
 }
 
 
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 8450b1bd354b..b158a505570c 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -111,7 +111,7 @@ static inline void coda_dir_update_mtime(struct inode *dir)
 	/* optimistically we can also act as if our nose bleeds. The
 	 * granularity of the mtime is coarse anyways so we might actually be
 	 * right most of the time. Note: we only do this for directories. */
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 #endif
 }
 
diff --git a/fs/coda/file.c b/fs/coda/file.c
index 12b26bd13564..18684d73d085 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -84,7 +84,7 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, 0);
 	coda_inode->i_size = file_inode(host_file)->i_size;
 	coda_inode->i_blocks = (coda_inode->i_size + 511) >> 9;
-	coda_inode->i_mtime = coda_inode->i_ctime = current_time(coda_inode);
+	coda_inode->i_mtime = inode_ctime_set_current(coda_inode);
 	inode_unlock(coda_inode);
 	file_end_write(host_file);
 
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index d661e6cf17ac..996729c3041a 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -269,7 +269,7 @@ int coda_setattr(struct mnt_idmap *idmap, struct dentry *de,
 
 	memset(&vattr, 0, sizeof(vattr)); 
 
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	coda_iattr_to_vattr(iattr, &vattr);
 	vattr.va_type = C_VNON; /* cannot set type */
 
-- 
2.41.0


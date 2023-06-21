Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E32D7387E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjFUOwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjFUOu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:50:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F612972
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:48:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E341D6159D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A180C433C0;
        Wed, 21 Jun 2023 14:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358897;
        bh=cPzAVbFk9R0HnrShvi8rLzBxv97vtXRMRe2hrktiDrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hcsmB7v6zbEyvEiZhHfjQHIdGckqwKegVeEVgJ4Igrqhii8bcPxx1YnlpDrpZFirt
         mxZ4y5XlQKvC2fmPnr2y0g7pGzBBgLi3oM4egpOaxz7t2sS/uDiRn4Pwky3B+39Un4
         DxF5i0YIVMefv25QXIkzZfvBkc9fbEbs2xRcoYFa+dtuRekYdpqrNaCPEUlCZDKahg
         pYTF19rBuLHzyN6Imn9cfxrPQSXHdZPZ/FX2vLnzeDGIWU99DBBz34MOlO8F1IFRUh
         pEGwQ8EqQ+MOwkxxCXi+h+x9kLxdPv1Q3l/lWUzV7oJKvqKHcjQMkHF6e4aoXDDFvy
         CrYAbHgYPlRrg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 26/79] erofs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:39 -0400
Message-ID: <20230621144735.55953-25-jlayton@kernel.org>
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
 fs/erofs/inode.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index d70b12b81507..8af56d6d0ff3 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -105,8 +105,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		set_nlink(inode, le32_to_cpu(die->i_nlink));
 
 		/* extended inode has its own timestamp */
-		inode->i_ctime.tv_sec = le64_to_cpu(die->i_mtime);
-		inode->i_ctime.tv_nsec = le32_to_cpu(die->i_mtime_nsec);
+		inode_ctime_set_sec(inode, le64_to_cpu(die->i_mtime));
+		inode_ctime_set_nsec(inode, le32_to_cpu(die->i_mtime_nsec));
 
 		inode->i_size = le64_to_cpu(die->i_size);
 
@@ -148,8 +148,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		set_nlink(inode, le16_to_cpu(dic->i_nlink));
 
 		/* use build time for compact inodes */
-		inode->i_ctime.tv_sec = sbi->build_time;
-		inode->i_ctime.tv_nsec = sbi->build_time_nsec;
+		inode_ctime_set_sec(inode, sbi->build_time);
+		inode_ctime_set_nsec(inode, sbi->build_time_nsec);
 
 		inode->i_size = le32_to_cpu(dic->i_size);
 		if (erofs_inode_is_data_compressed(vi->datalayout))
@@ -176,10 +176,10 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		vi->chunkbits = sb->s_blocksize_bits +
 			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	}
-	inode->i_mtime.tv_sec = inode->i_ctime.tv_sec;
-	inode->i_atime.tv_sec = inode->i_ctime.tv_sec;
-	inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec;
-	inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec;
+	inode->i_mtime.tv_sec = inode_ctime_peek(inode).tv_sec;
+	inode->i_atime.tv_sec = inode_ctime_peek(inode).tv_sec;
+	inode->i_mtime.tv_nsec = inode_ctime_peek(inode).tv_nsec;
+	inode->i_atime.tv_nsec = inode_ctime_peek(inode).tv_nsec;
 
 	inode->i_flags &= ~S_DAX;
 	if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
-- 
2.41.0


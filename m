Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAE57387EF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjFUOxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjFUOwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:52:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6882D78
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DFB66159B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2CBC433C8;
        Wed, 21 Jun 2023 14:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358948;
        bh=TT+04QQZnz99pJf+AzV0cI1/YUAXPqB9Pvl9TXy66DM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2Kiy/TWHPTWtVMq2IQKiNJpOFmMpEOkwMq6gjMdSpL/oBcqJMdghcj8XxI6ZtOap
         JV+svVArl//qprrnuYBiEC1FDGwGEY9LisET3pamty5lBdtY6b+/lNO72u1fefvTJ/
         ydCYxiIhPK09JUDMErq7IgUVAVDKfgGzuPZdD4dL9hoi5p+JMGCXJRJFFT7j6OAr26
         qMNCsMXefF56TkSPNkDXPXKF8rII+TfhuUSa9HH1L+0vx36k7nXrA1Nv+/VjVylQCX
         bg6fx60/SKkrRFj9qLKlZvFvvPw8bbJ85fko/U18hI2VDYAbatT/ff1v7Jp/02cDqO
         pqWN7agHhleZQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 53/79] orangefs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:06 -0400
Message-ID: <20230621144735.55953-52-jlayton@kernel.org>
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
 fs/orangefs/namei.c          | 2 +-
 fs/orangefs/orangefs-utils.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index 77518e248cf7..14085537ba1c 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -421,7 +421,7 @@ static int orangefs_rename(struct mnt_idmap *idmap,
 		     ret);
 
 	if (new_dentry->d_inode)
-		new_dentry->d_inode->i_ctime = current_time(new_dentry->d_inode);
+		inode_ctime_set_current(new_dentry->d_inode);
 
 	op_release(new_op);
 	return ret;
diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index 46b7dcff18ac..4d12efb2ee85 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -361,11 +361,11 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	    downcall.resp.getattr.attributes.atime;
 	inode->i_mtime.tv_sec = (time64_t)new_op->
 	    downcall.resp.getattr.attributes.mtime;
-	inode->i_ctime.tv_sec = (time64_t)new_op->
-	    downcall.resp.getattr.attributes.ctime;
+	inode_ctime_set_sec(inode,
+			    (time64_t)new_op->downcall.resp.getattr.attributes.ctime);
 	inode->i_atime.tv_nsec = 0;
 	inode->i_mtime.tv_nsec = 0;
-	inode->i_ctime.tv_nsec = 0;
+	inode_ctime_set_nsec(inode, 0);
 
 	/* special case: mark the root inode as sticky */
 	inode->i_mode = type | (is_root_handle(inode) ? S_ISVTX : 0) |
-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1527387D3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjFUOvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbjFUOt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:49:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC68A2709
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:48:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CE976159F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DA9C433C8;
        Wed, 21 Jun 2023 14:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358895;
        bh=PaVJkpVh0MegLqLOWSVoL9MGslg86rPr//LDV2xHrbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xs3Ir3zanpeZzXrsGWZMv1ZapRGmlY7QbaFKRfeEmuoSpLJg8Y1jbP8fPad0nf9oS
         Oe51cFB0Raqx3wHGUpiVYr5PTZhF/gQIuooLYYnK4WZvgqsxTGeHfXwsW7K1oAWE39
         gRpsuiSd/OScx6e41jhcjH6AwTGlDyLcDFGEl5HgVaGLCK3CMKJSIRMGnuLLs/Hxbp
         NvJmRwCUi2uk2BXxoh0Vo0MJz8gTwIpDYdvt4JW9jx+zHUOL2Uk00+Nf4KEGrOhhTu
         cgYGMSKQbdorfzIcF1po26iLEaTNgAkimQlcK+jBjs9HGg76VXPmoaN64FovIOhfaS
         6YOUCckhwLQHw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 25/79] efs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:38 -0400
Message-ID: <20230621144735.55953-24-jlayton@kernel.org>
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
 fs/efs/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 3ba94bb005a6..206978b490e6 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -105,8 +105,9 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
 	inode->i_size  = be32_to_cpu(efs_inode->di_size);
 	inode->i_atime.tv_sec = be32_to_cpu(efs_inode->di_atime);
 	inode->i_mtime.tv_sec = be32_to_cpu(efs_inode->di_mtime);
-	inode->i_ctime.tv_sec = be32_to_cpu(efs_inode->di_ctime);
-	inode->i_atime.tv_nsec = inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec = 0;
+	inode_ctime_set_sec(inode, be32_to_cpu(efs_inode->di_ctime));
+	inode->i_atime.tv_nsec = inode->i_mtime.tv_nsec = inode_ctime_set_nsec(inode,
+									       0);
 
 	/* this is the number of blocks in the file */
 	if (inode->i_size == 0) {
-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DBF7387F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjFUOxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjFUOwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:52:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EAE2D7C;
        Wed, 21 Jun 2023 07:49:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1287B61596;
        Wed, 21 Jun 2023 14:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE600C433C0;
        Wed, 21 Jun 2023 14:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358950;
        bh=YWuokfMJ+4rhgsv839ofdmeql5mHi2OINpoubcGpHfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IIOagbf41K//lPF2/RO6T6Q5+Xe/GO1RvWVI/XL+oj89Hlvg040jUCa3I74FwjDJT
         CJLs5m8r2RvvSFTtMUXujc6DP3fJkU9mQ7h5goH8M+BpBiUO0KBj6G6F0NG5Flio54
         jjHv5hY+vES2eZOQPHMcVCpyy8tU035oESGmxyI0xwUfCrP+TicwbpVV8HKL+jHoBG
         j1u7oE1BpXsHkcZZApRcJ5CuI/3mVRjeXtsvEH7WoOgyjQWDPRtGX/1WOAY6YS1UlI
         yc8Sb5evqBTN6lIFkgLp3qLOwJpI+Z05vtg61orV6upUy76HSwv3v52zltYxzTIN/S
         V4ReCo+RuQdNA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 54/79] overlayfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:07 -0400
Message-ID: <20230621144735.55953-53-jlayton@kernel.org>
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
 fs/overlayfs/file.c | 7 +++++--
 fs/overlayfs/util.c | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 21245b00722a..b47013d4bd4e 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -239,6 +239,7 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 static void ovl_file_accessed(struct file *file)
 {
 	struct inode *inode, *upperinode;
+	struct timespec64 ct, uct;
 
 	if (file->f_flags & O_NOATIME)
 		return;
@@ -249,10 +250,12 @@ static void ovl_file_accessed(struct file *file)
 	if (!upperinode)
 		return;
 
+	ct = inode_ctime_peek(inode);
+	uct = inode_ctime_peek(upperinode);
 	if ((!timespec64_equal(&inode->i_mtime, &upperinode->i_mtime) ||
-	     !timespec64_equal(&inode->i_ctime, &upperinode->i_ctime))) {
+	     !timespec64_equal(&ct, &uct))) {
 		inode->i_mtime = upperinode->i_mtime;
-		inode->i_ctime = upperinode->i_ctime;
+		inode_ctime_set(inode, uct);
 	}
 
 	touch_atime(&file->f_path);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 7ef9e13c404a..e3746f9a202f 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1202,6 +1202,6 @@ void ovl_copyattr(struct inode *inode)
 	inode->i_mode = realinode->i_mode;
 	inode->i_atime = realinode->i_atime;
 	inode->i_mtime = realinode->i_mtime;
-	inode->i_ctime = realinode->i_ctime;
+	inode_ctime_set(inode, inode_ctime_peek(realinode));
 	i_size_write(inode, i_size_read(realinode));
 }
-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E141738791
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjFUOr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjFUOrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:47:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851DD19AA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:47:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CCA86158B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C7CC433C8;
        Wed, 21 Jun 2023 14:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358861;
        bh=+ZbVNnWFJyrnkyx7x/5Q61rWw0/EOzbgoTsZmaMWSrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdwQL++zke5r0Tkn8M0bI30T5o5R4QI5cpiziRr7IQWMdP1/4cAEvIXkgekYm3QBd
         SOkh53XgsgFrozB7y1c0+GgLUCbLWCKuAr8dIDZwC8xQqNNhJcymT3Dhp7lOScmZg3
         0LpZI25nGxG7UreHahXG49KK4wpOwExNxw5i0OSqsco1t1s5IJ3uevQuLYFAqZ1SHb
         v3r0KXlzurc8J8mXT+dfCBtL1tYFr9/BT+AKFWhdxjzUMDYRDWUJTS1w/MHYTyUYuX
         W2bJNm244PhLGaKE19TZEi+gG2wfxf+XHFIDysoYWeeBIukRG36l0E9cpwIMqKzfQv
         AvMi/JdB3qNUQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/79] binderfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:17 -0400
Message-ID: <20230621144735.55953-3-jlayton@kernel.org>
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
 drivers/android/binderfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 76e7d6676657..b6b1220e1e55 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -153,7 +153,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 		goto err;
 
 	inode->i_ino = minor + INODE_OFFSET;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 	init_special_inode(inode, S_IFCHR | 0600,
 			   MKDEV(MAJOR(binderfs_dev), minor));
 	inode->i_fop = &binder_fops;
@@ -432,7 +432,7 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
 	}
 
 	inode->i_ino = SECOND_INODE;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 	init_special_inode(inode, S_IFCHR | 0600,
 			   MKDEV(MAJOR(binderfs_dev), minor));
 	inode->i_fop = &binder_ctl_fops;
@@ -474,7 +474,7 @@ static struct inode *binderfs_make_inode(struct super_block *sb, int mode)
 	if (ret) {
 		ret->i_ino = iunique(sb, BINDERFS_MAX_MINOR + INODE_OFFSET);
 		ret->i_mode = mode;
-		ret->i_atime = ret->i_mtime = ret->i_ctime = current_time(ret);
+		ret->i_atime = ret->i_mtime = inode_ctime_set_current(ret);
 	}
 	return ret;
 }
@@ -703,7 +703,7 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode->i_ino = FIRST_INODE;
 	inode->i_fop = &simple_dir_operations;
 	inode->i_mode = S_IFDIR | 0755;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 	inode->i_op = &binderfs_dir_inode_operations;
 	set_nlink(inode, 2);
 
-- 
2.41.0


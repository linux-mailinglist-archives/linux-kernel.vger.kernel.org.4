Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FD873878F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjFUOru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjFUOrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:47:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05051997;
        Wed, 21 Jun 2023 07:47:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54D236157B;
        Wed, 21 Jun 2023 14:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE5AC433C0;
        Wed, 21 Jun 2023 14:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358859;
        bh=SerVS37LZ+M9Q1DrVXe11/DarECztwBfuFbsJZAaL/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b0fWvZziCaDEPNv8e772X/4hR0ZOvdZvEbjB6p+JeCO+zyl3Iy6ikH62A+bQP/ydN
         cQaq5bP9anibGG10Aqrfckh6kUGFswV7aHPM/cPOiBKX89C9oUvTA4YvJDulF5h3cb
         OVap2sebFw8Yly04wHw1ihAaQQcVQwegi11RFHA400KxId71KUhWQhzZPZ/NV+VaS8
         MmV6ItyfcBfC5wEQqDJJdt8SnF7Ym6jI/6ZzH+Ebt+3JPW1vY505jC90DjKbbiNbkw
         hoEAoBTSoHXOD+TcvXEp6S8970563oPpdjqLM7HAhbgLR8bwiAOQzZVSo7pbf7GZsE
         9Us5QMgUSJ8JA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/79] s390: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:16 -0400
Message-ID: <20230621144735.55953-2-jlayton@kernel.org>
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
 arch/s390/hypfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index ee919bfc8186..30fa336ec63e 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -53,7 +53,7 @@ static void hypfs_update_update(struct super_block *sb)
 	struct inode *inode = d_inode(sb_info->update_file);
 
 	sb_info->last_update = ktime_get_seconds();
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 }
 
 /* directory tree removal functions */
@@ -101,7 +101,7 @@ static struct inode *hypfs_make_inode(struct super_block *sb, umode_t mode)
 		ret->i_mode = mode;
 		ret->i_uid = hypfs_info->uid;
 		ret->i_gid = hypfs_info->gid;
-		ret->i_atime = ret->i_mtime = ret->i_ctime = current_time(ret);
+		ret->i_atime = ret->i_mtime = inode_ctime_set_current(ret);
 		if (S_ISDIR(mode))
 			set_nlink(ret, 2);
 	}
-- 
2.41.0


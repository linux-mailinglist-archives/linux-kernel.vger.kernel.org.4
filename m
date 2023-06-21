Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846A873881A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjFUO4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjFUOx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:53:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B542213E;
        Wed, 21 Jun 2023 07:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9474F61539;
        Wed, 21 Jun 2023 14:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3759BC433C0;
        Wed, 21 Jun 2023 14:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358990;
        bh=ZvoZjIEuldwlKWZnI9Mxmed4hFt/g32HDEOmUzdJH4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I7N/JO0lu4Yj4i43TUis4tlHzDByV5tzoMO+jPEQAs0ArK/U10XS5GR4B/2cC/D37
         sXC+VKMTOE+reQNE3XyN0PvmKvQM8A3vXw3/+cUTv48p6R54DDcFelLqG1M9RFE70T
         gC1Gi3RPeD1HC7BYOLgMm1cAYg1HJJDjUgAQcuzzxvHe92tFHHZevOQzaBv8GLUzYQ
         ywwuaTl0ATJAX+XqUOmFg6FIbEStDaSFKEhHfZV3Z2kIHR8i+nBbI7H7gXkM2Hm5oK
         V0+WuTvjpxUFIEKIX0RzUT4x9i8F8V3AuZdVLdkB9V7nqHZHZes7O/EjNdZ/2LtleJ
         Xn37XaisI05gg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 77/79] security: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:30 -0400
Message-ID: <20230621144735.55953-76-jlayton@kernel.org>
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
 security/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/inode.c b/security/inode.c
index 6c326939750d..086280390793 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -145,7 +145,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 
 	inode->i_ino = get_next_ino();
 	inode->i_mode = mode;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 	inode->i_private = data;
 	if (S_ISDIR(mode)) {
 		inode->i_op = &simple_dir_inode_operations;
-- 
2.41.0


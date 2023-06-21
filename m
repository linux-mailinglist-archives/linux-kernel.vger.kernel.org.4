Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E268E7387C4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjFUOu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjFUOtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:49:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B992135;
        Wed, 21 Jun 2023 07:48:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CB456157B;
        Wed, 21 Jun 2023 14:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55919C433C9;
        Wed, 21 Jun 2023 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358893;
        bh=zkF7XZXkTymtKzVrHDI637HQp5mSePtzjunOQ79N8zE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gSHiEXsKhNqGZ+sB3hwTHXGNior3Vyk10xSUYstyJLFKIlTJSAOcnOQ2r8J35gKv4
         hTQgG3n1FDzKuUnLiBOM2ubd4vVWoC1tGAFdUvw8PCKQpszcxBzhXWia3+eKh79s6B
         uS2vR2lIKa92/++teZMrzYnXERN0GyecvjAunedslC8Ku286r07eMZOWmnPpXt151i
         ARyuJgLmKm5pmwarGxtAYtFLRQgryXexDZHGYhW1Q4Fe6L+tP6QiTDIWsr2LP7GTHp
         NykRzV8nRP3w7h5VFEoufujbW+ZihUvJJmL33Lkza8IfhRNn0JonD1p/9u/b2LvNCM
         DYObIt+Ob7Yaw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Tyler Hicks <code@tyhicks.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/79] ecryptfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:36 -0400
Message-ID: <20230621144735.55953-22-jlayton@kernel.org>
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
 fs/ecryptfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 83274915ba6d..3171214fdffd 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -148,7 +148,7 @@ static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
 	}
 	fsstack_copy_attr_times(dir, lower_dir);
 	set_nlink(inode, ecryptfs_inode_to_lower(inode)->i_nlink);
-	inode->i_ctime = dir->i_ctime;
+	inode_ctime_set(inode, inode_ctime_peek(dir));
 out_unlock:
 	dput(lower_dentry);
 	inode_unlock(lower_dir);
-- 
2.41.0


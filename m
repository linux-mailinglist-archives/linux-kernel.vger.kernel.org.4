Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEFC7387CA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjFUOum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjFUOth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:49:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8809F2690
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:48:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A68AA6159A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBC3C433C0;
        Wed, 21 Jun 2023 14:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358889;
        bh=vzPEOgyxqOCaktmDwbXapks+d0FmANIoL7/H7EX46FQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9lEJm3hzh3HO8gS2e9FdAKLPhWVnCLIlKqURQo59Y8p/5acagZxwfMRNn0wpU27X
         t1WK0rMIkofFBBodKmiD7OBo20SIc32KHkqiuFwx5eiRlimyvPmz716as7LX2UG4sF
         vkUhlcunvaafLJKf4CxSjWtkypQ2BcIy0WJkgD9VOam28yzWGfEaYYjlJHUHGZkcC7
         cP/fcKwF1229IUK21aAJnYvRa0GpJWpKW2l7puwFrA32Ui7zg2GiR7T19MyA6KFZj1
         bNo6MqzwuaX1C2Ptgj12KDHtIYb5JH/NSWcPdy76KRnKa4HjZLtmBsQ6SN9wITd+hx
         uInwNzb+pCAyg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/79] cramfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:33 -0400
Message-ID: <20230621144735.55953-19-jlayton@kernel.org>
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
 fs/cramfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 27c6597aa1be..039ce0f8858b 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -133,7 +133,7 @@ static struct inode *get_cramfs_inode(struct super_block *sb,
 	}
 
 	/* Struct copy intentional */
-	inode->i_mtime = inode->i_atime = inode->i_ctime = zerotime;
+	inode->i_mtime = inode->i_atime = inode_ctime_set(inode, zerotime);
 	/* inode->i_nlink is left 1 - arguably wrong for directories,
 	   but it's the best we can do without reading the directory
 	   contents.  1 yields the right result in GNU find, even
-- 
2.41.0


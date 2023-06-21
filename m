Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C69738823
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjFUO4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjFUOzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:55:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6950026A0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:50:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B51061593
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F2BC433CB;
        Wed, 21 Jun 2023 14:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358965;
        bh=vtvQrPGrR+t0jK7eRQgHPWabkEM1OAXF8ZWhtRTMT2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UBCccNdGTlI5Ha0bcEzRIJatGLygln/MjrProEFyLo5R7ak5KDtMwfIlU/XPo1haF
         F2+Cnhz3NLRQKxD6XMWtUJQ0vZrKrnukvuu27+0bXxseESMYGqBZb5aMojsa8Jafyv
         K1C5l31IS74SyXai5ad4J4vWOt35AlGU5WnPCMAXMuvXLl1jZvXOqq9HEqB1k7NOsW
         GVQKj67tkfk45b+i08QC3B2wQPdnpp5bnF5i61mRbyb0+dTsWY9mfTtHXABl+cw+vk
         GSVvQSfn/jy2v6ejfybgTQLr8KWl/MqFkjCcvDE00CITxog3v16vSE0p7o7I4Bdvlx
         QO71PSpC0basQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 63/79] squashfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:16 -0400
Message-ID: <20230621144735.55953-62-jlayton@kernel.org>
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
 fs/squashfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 24463145b351..3d619b294c52 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -61,7 +61,7 @@ static int squashfs_new_inode(struct super_block *sb, struct inode *inode,
 	inode->i_ino = le32_to_cpu(sqsh_ino->inode_number);
 	inode->i_mtime.tv_sec = le32_to_cpu(sqsh_ino->mtime);
 	inode->i_atime.tv_sec = inode->i_mtime.tv_sec;
-	inode->i_ctime.tv_sec = inode->i_mtime.tv_sec;
+	inode_ctime_set_sec(inode, inode->i_mtime.tv_sec);
 	inode->i_mode = le16_to_cpu(sqsh_ino->mode);
 	inode->i_size = 0;
 
-- 
2.41.0


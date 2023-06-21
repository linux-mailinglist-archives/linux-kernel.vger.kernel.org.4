Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5837387DA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjFUOvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjFUOuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:50:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB60273A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4525615A6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53D9C433C8;
        Wed, 21 Jun 2023 14:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358910;
        bh=Y1zOmv57j6KZqwC3v3dA3Bks9DlA96ykpslnKz3twbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q+WkytXaZeZ/b1bQg2EekU9qJmqsUFauiE0a8RZTPM44J+OY1d5sAi27wqmeisFFr
         4ov6d5/cY3JP/e4eLwMUjYQDenIJfmF054qn+X0/qpbfkXNDmTG2HUPS38+x6VFhda
         SdKukNr0WsisO4nWT9auHBWtdpJuTIs4jSTU3xv8VExNu21lkXnbSmfCvD6BCrhpJx
         F7aREpbVMDbkM7Rf8Zh4AfNNKYhIQdXfCE9Vcuu1dyjPuRZOoUx5MJ2DzVFGR8vKhj
         YPdT6nibHMScd124H4A33/aIZoE41sooH//8OHmCvHjR0Zymla2gfhqWJdvTXMPnqa
         0jp3rEera+bUA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 32/79] freevxfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:45 -0400
Message-ID: <20230621144735.55953-31-jlayton@kernel.org>
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
 fs/freevxfs/vxfs_inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/freevxfs/vxfs_inode.c b/fs/freevxfs/vxfs_inode.c
index ceb6a12649ba..ad0f0a627715 100644
--- a/fs/freevxfs/vxfs_inode.c
+++ b/fs/freevxfs/vxfs_inode.c
@@ -110,10 +110,10 @@ static inline void dip2vip_cpy(struct vxfs_sb_info *sbi,
 	inode->i_size = vip->vii_size;
 
 	inode->i_atime.tv_sec = vip->vii_atime;
-	inode->i_ctime.tv_sec = vip->vii_ctime;
+	inode_ctime_set_sec(inode, vip->vii_ctime);
 	inode->i_mtime.tv_sec = vip->vii_mtime;
 	inode->i_atime.tv_nsec = 0;
-	inode->i_ctime.tv_nsec = 0;
+	inode_ctime_set_nsec(inode, 0);
 	inode->i_mtime.tv_nsec = 0;
 
 	inode->i_blocks = vip->vii_blocks;
-- 
2.41.0


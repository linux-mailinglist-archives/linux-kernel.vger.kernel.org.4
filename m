Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780E773881F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjFUO43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjFUOyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:54:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A7D35A4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D80AB6157D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CB9C433C0;
        Wed, 21 Jun 2023 14:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358955;
        bh=f1rttWyEovUo0PnSxIfPqjg/fvLapokvDJ8MLoxkPYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WoUD345LPEF4hodSkjDYo5jbDC614zugtoeX1ouA1gScMBog1mZZYzmATLhoTkySU
         LFuPoSmt+olr3KHqx8+VmRJFW/KeJPLkuxYI+lPde4RamxgyZa9XxPETK+DGxumHFO
         KIwkMqbgaJC8LAAQ+ZbiB9ppRUDv8cCEdqIScHWCOZP3d8eBMuKKN9V2XLvH+iUySx
         A1gejL3krjz8/+bD/6xXL6saZhNjKHvd4qAMpeYWSCkyn1fUj3B+Ft+ohp071f8PCQ
         pPQHqK4yuEyzI9l5GBMhtSq5KLVffyNyX68NbI2pDLjbQLuDCCntxY+oB9xDpD5PKB
         GJwP1DSIe0M6A==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Anders Larsen <al@alarsen.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 57/79] qnx4: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:10 -0400
Message-ID: <20230621144735.55953-56-jlayton@kernel.org>
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
 fs/qnx4/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 391ea402920d..3fde90b3f99b 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -305,8 +305,8 @@ struct inode *qnx4_iget(struct super_block *sb, unsigned long ino)
 	inode->i_mtime.tv_nsec = 0;
 	inode->i_atime.tv_sec   = le32_to_cpu(raw_inode->di_atime);
 	inode->i_atime.tv_nsec = 0;
-	inode->i_ctime.tv_sec   = le32_to_cpu(raw_inode->di_ctime);
-	inode->i_ctime.tv_nsec = 0;
+	inode_ctime_set_sec(inode, le32_to_cpu(raw_inode->di_ctime));
+	inode_ctime_set_nsec(inode, 0);
 	inode->i_blocks  = le32_to_cpu(raw_inode->di_first_xtnt.xtnt_size);
 
 	memcpy(qnx4_inode, raw_inode, QNX4_DIR_ENTRY_SIZE);
-- 
2.41.0


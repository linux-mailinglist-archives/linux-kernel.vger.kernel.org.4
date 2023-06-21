Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD81F7387C3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjFUOuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjFUOtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:49:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B20C2128
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A99C61536
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52E1C433C0;
        Wed, 21 Jun 2023 14:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358890;
        bh=huZJIp/B9xWSD0X0dlYvUh0CjmXR4oUY7WvD+3absj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZ54Gl50DxIfN8Z7D1qc9Ee/OkA44CbpKhWtgQQxPz2nKb0w7aceIscGljczPSc87
         tj8hCLEDgsUJftRjlFPHA+ir31Gr5ZeHd5bhJwPDDxNNYze+N63PTt/7UN/viTfgDC
         +7oQezge7lxn5VYH4H6HvxmERUt+StjYcpQo1KT9Vn1GTl9c05B9vD1RQOk9Vclx+y
         Sds7AIx2TIy0JIg60/6FjANCecOOmBKmhr7CGmgxSIrT6g09VE/5h9MyQIMsyB0x2t
         kSEDCpTyjygdg/Mqz8QpDdCtk3EVIs11lBtnyis7TFXQkjHUPC2gOu1qnF7RYDL2dg
         SAgpLvQ76Gz9Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/79] debugfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:34 -0400
Message-ID: <20230621144735.55953-20-jlayton@kernel.org>
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
 fs/debugfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 3f81f73c241a..d4932a128c7d 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -73,7 +73,7 @@ static struct inode *debugfs_get_inode(struct super_block *sb)
 	if (inode) {
 		inode->i_ino = get_next_ino();
 		inode->i_atime = inode->i_mtime =
-			inode->i_ctime = current_time(inode);
+			inode_ctime_set_current(inode);
 	}
 	return inode;
 }
-- 
2.41.0


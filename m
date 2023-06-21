Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453FA738802
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjFUOyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjFUOxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:53:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E28D2101
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:49:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAD74615A9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72B8C433C8;
        Wed, 21 Jun 2023 14:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358961;
        bh=nkhHCNGuJB7cLw9t9M4IrpbsQgRvxk6x/r8fxSR7EIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I6davxw0bJQjROX9caeCfWoQ0sApzeoXR1M/iBz9F0t5ViFmHv7S4Z58jN/+1cYhf
         xH0TRPzWF4nQAPMYmv0iysbne5Bbrmb+rTrkFyD1OSH6jHKi0Zz9C0pY8kszmpPcfh
         V650KPb2HmRSOcLWX0PiRa2sCfYCFABkEDApPZ1qAfGGKSWIuz7n0aGvY9EpVE6Xok
         IX2CmQVa4iZnx6b3gnAa2V+f8jHtpcWJ2tZCES/vTPoxY5dMQiGQAouWY/jcu9QZlw
         kPAPJme4pQRo89xYsOiFDK7thZlnnQJ20ZRAebj7gXtGxLuPVbbh/bXj3Wzoe0MaML
         OwvoJsfc9Y0/Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 61/79] romfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:14 -0400
Message-ID: <20230621144735.55953-60-jlayton@kernel.org>
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
 fs/romfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index c59b230d55b4..1adea5c249a6 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -322,8 +322,8 @@ static struct inode *romfs_iget(struct super_block *sb, unsigned long pos)
 
 	set_nlink(i, 1);		/* Hard to decide.. */
 	i->i_size = be32_to_cpu(ri.size);
-	i->i_mtime.tv_sec = i->i_atime.tv_sec = i->i_ctime.tv_sec = 0;
-	i->i_mtime.tv_nsec = i->i_atime.tv_nsec = i->i_ctime.tv_nsec = 0;
+	i->i_mtime.tv_sec = i->i_atime.tv_sec = inode_ctime_set_sec(i, 0);
+	i->i_mtime.tv_nsec = i->i_atime.tv_nsec = inode_ctime_set_nsec(i, 0);
 
 	/* set up mode and ops */
 	mode = romfs_modemap[nextfh & ROMFH_TYPE];
-- 
2.41.0


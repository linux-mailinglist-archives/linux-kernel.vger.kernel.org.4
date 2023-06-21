Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64717387FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjFUOx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjFUOxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:53:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC1830E5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 154CD6159C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B53EC433C8;
        Wed, 21 Jun 2023 14:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358956;
        bh=q0RNJR11+YxsF2T3Uf94Nm8LmJtlc14VfDKVIjwrbxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MJU3kKp2cCLJCijVGQWsIBH/mtgTrWrjyx6bwxp0If06rbf4YWU5zndMYVllGNrAt
         GxMkIz90NeZxUTQyv1W9pFQjDRm5DkX93/jR5ImoUOVzup8fgH8w59dRHMAGjbnRjX
         VqU9gKjhaloS+k1VW3pLXDV+EgYSgBOZZWJ593P8uTxHXOVD+ivizNxbOV8aNj06ze
         z7mW2mmc7CFY566MhpqwA1HuGaXLrrnB30Se2GcGwOX52hC0y9CrxPU28fFmfccyTA
         XVEYlcG0GiQWlGzRa7KNcL0ZMXDAYUY6+8Frc0ALYzrmyaCZjaVaUFqNAr85VIzkfk
         Gg9sYPgTI/3Bw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 58/79] qnx6: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:11 -0400
Message-ID: <20230621144735.55953-57-jlayton@kernel.org>
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
 fs/qnx6/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 85b2fa3b211c..ff86c7100aaa 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -562,8 +562,8 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned ino)
 	inode->i_mtime.tv_nsec = 0;
 	inode->i_atime.tv_sec   = fs32_to_cpu(sbi, raw_inode->di_atime);
 	inode->i_atime.tv_nsec = 0;
-	inode->i_ctime.tv_sec   = fs32_to_cpu(sbi, raw_inode->di_ctime);
-	inode->i_ctime.tv_nsec = 0;
+	inode_ctime_set_sec(inode, fs32_to_cpu(sbi, raw_inode->di_ctime));
+	inode_ctime_set_nsec(inode, 0);
 
 	/* calc blocks based on 512 byte blocksize */
 	inode->i_blocks = (inode->i_size + 511) >> 9;
-- 
2.41.0


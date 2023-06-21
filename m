Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235A77387D9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjFUOvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjFUOuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:50:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B5F2736
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BB076159A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A660EC433C8;
        Wed, 21 Jun 2023 14:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358919;
        bh=7kDZ0zSAuiZG3Ri7kKTPNFkOkI3vdeQNaeHRn7Yk8hM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=urrRE+Ul2hVmFhbrwq9sLzT1y4Q0DRerCmZqwlbqL2Ncta4KFzKp7HaNR7245ScwN
         /L0gu2ol0rpyseaLYWMl8wc0hiNg0t25hbFPjNTofAiMIZ3bRbfFVmau3LmGpfZQza
         W/+4CsBak8HhirWT1F8eC1YB37WFHe/H5PO3jDGe+dSlwVqs0Wjj6E3Iy3CTbfvJv+
         fiqa8JMFh0e1JrdNEaJGSariji2RmP38B7lkCq3kHB3/JyryfrRmaWz8+We4vC+VRh
         9XRVLfzXtHM1vK08bNVzGFUAsG+1Av/ycs2PHAp5jUhKTiAAcb0s4jXqQfr9cEV7mX
         GnSwP/rA6COWw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 37/79] hostfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:50 -0400
Message-ID: <20230621144735.55953-36-jlayton@kernel.org>
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
 fs/hostfs/hostfs_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 46387090eb76..2248a2e599a7 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -517,8 +517,8 @@ static int hostfs_inode_update(struct inode *ino, const struct hostfs_stat *st)
 		(struct timespec64){ st->atime.tv_sec, st->atime.tv_nsec };
 	ino->i_mtime =
 		(struct timespec64){ st->mtime.tv_sec, st->mtime.tv_nsec };
-	ino->i_ctime =
-		(struct timespec64){ st->ctime.tv_sec, st->ctime.tv_nsec };
+	inode_ctime_set(ino,
+		(struct timespec64){ st->ctime.tv_sec, st->ctime.tv_nsec });
 	ino->i_size = st->size;
 	ino->i_blocks = st->blocks;
 	return 0;
-- 
2.41.0


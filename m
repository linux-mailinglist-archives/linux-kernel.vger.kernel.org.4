Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783AA6FD0CD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbjEIVUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbjEIVTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725FF4498;
        Tue,  9 May 2023 14:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED38363725;
        Tue,  9 May 2023 21:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240D0C433EF;
        Tue,  9 May 2023 21:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683667181;
        bh=BP3OLBE5mP9F2Tv3wjhBdu4qIMZy7h6rrkt2NWbrCL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rEgBR+XhQ0XDIHJ1q7F4K4xV6xNZ0oTv+FmSwBoJrOmG4Hkppi0BtK19qlTAUKzH+
         Lz9tW1BgfjTMpuroY7jsYRsU93TPhefsFcnA+dE6YJvsKbZjGEIy8K2/XrzxUABQoE
         JvCZ19yR14X5IM6B+feyFxsci9T/z2zfz3obBd6PWo3QSfrYO2ABE2cB4jlGRC/0Ky
         smUnpAusgbAxJBJSZmexgSE33RQp2xod0Z64nkpbBKGhey7bB7vXGe+hOkqO01wcdY
         xbx/I3deJ3+ZbYW3FxCgp3u04UtLhJKB6AuB4CnPOdBhSGCtW3ooL4FRI5VJwouxWl
         dLPvGEr9A5Rdg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>,
        syzbot+f45957555ed4a808cc7a@syzkaller.appspotmail.com,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.3 06/18] fs/ntfs3: Fix NULL dereference in ni_write_inode
Date:   Tue,  9 May 2023 17:19:14 -0400
Message-Id: <20230509211928.21010-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509211928.21010-1-sashal@kernel.org>
References: <20230509211928.21010-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdun Nihaal <abdun.nihaal@gmail.com>

[ Upstream commit 8dae4f6341e335a09575be60b4fdf697c732a470 ]

Syzbot reports a NULL dereference in ni_write_inode.
When creating a new inode, if allocation fails in mi_init function
(called in mi_format_new function), mi->mrec is set to NULL.
In the error path of this inode creation, mi->mrec is later
dereferenced in ni_write_inode.

Add a NULL check to prevent NULL dereference.

Link: https://syzkaller.appspot.com/bug?extid=f45957555ed4a808cc7a
Reported-and-tested-by: syzbot+f45957555ed4a808cc7a@syzkaller.appspotmail.com
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/frecord.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index f1df52dfab74b..912eeb3d34717 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3258,6 +3258,9 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 		return 0;
 	}
 
+	if (!ni->mi.mrec)
+		goto out;
+
 	if (is_rec_inuse(ni->mi.mrec) &&
 	    !(sbi->flags & NTFS_FLAGS_LOG_REPLAYING) && inode->i_nlink) {
 		bool modified = false;
-- 
2.39.2


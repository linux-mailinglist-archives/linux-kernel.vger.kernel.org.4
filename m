Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96207130D7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 02:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjE0APu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 20:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjE0APs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 20:15:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56E5A4
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 17:15:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4810F6542C
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BCAC433EF;
        Sat, 27 May 2023 00:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685146546;
        bh=nXYxH681t7TjkG0u6GW5KrdxO7omwjQ0Ovq3C6thr3o=;
        h=From:To:Cc:Subject:Date:From;
        b=nwxA6WUJ0K4VI3RTizZduy9tfa8DiyultCuBcuFgDUNdIMmDshCVqRCMPGmySpeBi
         Ld/n9f6qhWWquEa5YaKAcVvcd88ClDOXkbwJXghDVTcDVPlQLRXs5FQkI12jW22WV0
         cFnBcTmThtUdSYcnKxuw2vPe/+7nABCnDejDr+XkBQ2MvBkKXVsWhhAq/R7bWwsRUp
         5brQXXF4DmhbYBZ92IBxEiehsUQIwKvAIi/16D/RxQnHDhQZZwnGtnKDtpph3RfbOo
         5ZPey+Od7aDsrI/bPF9khHqq3NokKtmq7nNinirF95qWH9Kl8xqoEMEpLEIBlmpaWt
         18hJmF2C4Uc2Q==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH v3] f2fs: fix to set noatime and immutable flag for quota file
Date:   Sat, 27 May 2023 08:15:39 +0800
Message-Id: <20230527001539.3608665-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
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

We should set noatime bit for quota files, since no one cares about
atime of quota file, and we should set immutalbe bit as well, due to
nobody should write to the file through exported interfaces.

Meanwhile this patch use inode_lock to avoid race condition during
inode->i_flags, f2fs_inode->i_flags update.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- simply check condition suggested by Jaegeuk.
 fs/f2fs/super.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 51812f459581..8eb17cc73941 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2748,6 +2748,7 @@ static int f2fs_quota_enable(struct super_block *sb, int type, int format_id,
 {
 	struct inode *qf_inode;
 	unsigned long qf_inum;
+	unsigned long qf_flag = F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
 	int err;
 
 	BUG_ON(!f2fs_sb_has_quota_ino(F2FS_SB(sb)));
@@ -2763,7 +2764,15 @@ static int f2fs_quota_enable(struct super_block *sb, int type, int format_id,
 	}
 
 	/* Don't account quota for quota files to avoid recursion */
+	inode_lock(qf_inode);
 	qf_inode->i_flags |= S_NOQUOTA;
+
+	if ((F2FS_I(qf_inode)->i_flags & qf_flag) != qf_flag) {
+		F2FS_I(qf_inode)->i_flags |= qf_flag;
+		f2fs_set_inode_flags(qf_inode);
+	}
+	inode_unlock(qf_inode);
+
 	err = dquot_load_quota_inode(qf_inode, type, format_id, flags);
 	iput(qf_inode);
 	return err;
-- 
2.40.1


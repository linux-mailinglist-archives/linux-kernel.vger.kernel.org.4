Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978A872376B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjFFGSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjFFGS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:18:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F338392
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9043E62238
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE80C433EF;
        Tue,  6 Jun 2023 06:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686032308;
        bh=CAju/ke6dt0cBKQdvWsNhZJ0D4UzuH6zEahi6D9GmtI=;
        h=From:To:Cc:Subject:Date:From;
        b=EiVnNsPFHFRKQftqEpwmVzgJ8nZeLuoduHTiLIABkpRdCIwY4wWMrnLWpwuMXUTIf
         v1c9yWo2Lrus9JoNN7XOL6Nab9JmR/8/SUGZ+eSq1wOdk698nL0DSKgVA6ob0FH8iD
         kTsC35KqwnBrP9nSKF5wSYEdqU+uObW18F2f4OsFl3rsnmzRpjI2pp9SsdC8DV3sw6
         R7MoB102bJbpGuKKY9ip87gPSk+lTc2PGtEE/03O7JvElEE+m2dypXdaPQYxKeyyGZ
         XO6bD6dLpK7/dtd1sZemwU4trEk/6+wSpsb1EIL9yS2xrPmb5zUlRlgBr1I88nyOr3
         cTSuqipWPiE1g==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: introduce F2FS_QUOTA_DEFAULT_FL for cleanup
Date:   Tue,  6 Jun 2023 14:18:22 +0800
Message-Id: <20230606061822.1179551-1-chao@kernel.org>
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

This patch adds F2FS_QUOTA_DEFAULT_FL to include two default flags:
F2FS_NOATIME_FL and F2FS_IMMUTABLE_FL, and use it to clean up codes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h  | 2 ++
 fs/f2fs/super.c | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 35ea9165801e..525381bb6050 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2967,6 +2967,8 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define F2FS_CASEFOLD_FL		0x40000000 /* Casefolded file */
 
+#define F2FS_QUOTA_DEFAULT_FL		(F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL)
+
 /* Flags that should be inherited by new inodes from their parent. */
 #define F2FS_FL_INHERITED (F2FS_SYNC_FL | F2FS_NODUMP_FL | F2FS_NOATIME_FL | \
 			   F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL | \
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6861b255a9a6..5f3e3f328f10 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2782,7 +2782,7 @@ static int f2fs_quota_enable(struct super_block *sb, int type, int format_id,
 {
 	struct inode *qf_inode;
 	unsigned long qf_inum;
-	unsigned long qf_flag = F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
+	unsigned long qf_flag = F2FS_QUOTA_DEFAULT_FL;
 	int err;
 
 	BUG_ON(!f2fs_sb_has_quota_ino(F2FS_SB(sb)));
@@ -2959,7 +2959,7 @@ static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
 		return err;
 
 	inode_lock(inode);
-	F2FS_I(inode)->i_flags |= F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
+	F2FS_I(inode)->i_flags |= F2FS_QUOTA_DEFAULT_FL;
 	f2fs_set_inode_flags(inode);
 	inode_unlock(inode);
 	f2fs_mark_inode_dirty_sync(inode, false);
@@ -2984,7 +2984,7 @@ static int __f2fs_quota_off(struct super_block *sb, int type)
 		goto out_put;
 
 	inode_lock(inode);
-	F2FS_I(inode)->i_flags &= ~(F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL);
+	F2FS_I(inode)->i_flags &= ~F2FS_QUOTA_DEFAULT_FL;
 	f2fs_set_inode_flags(inode);
 	inode_unlock(inode);
 	f2fs_mark_inode_dirty_sync(inode, false);
-- 
2.40.1


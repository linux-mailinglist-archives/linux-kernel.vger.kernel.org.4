Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93DC6A0094
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjBWB2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjBWB2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:28:31 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38441C301
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:28:30 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PMZzX0DWLzKmLv;
        Thu, 23 Feb 2023 09:23:36 +0800 (CST)
Received: from huawei.com (10.67.175.88) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 23 Feb
 2023 09:28:27 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <lizetao1@huawei.com>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] f2fs: make f2fs_sync_inode_meta() static
Date:   Thu, 23 Feb 2023 01:25:13 +0000
Message-ID: <20230223012513.1781735-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.88]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 26b5a079197c ("f2fs: cleanup dirty pages if recover failed"),
f2fs_sync_inode_meta() is only used in checkpoint.c, so
f2fs_sync_inode_meta() should only be visible inside. Delete the
declaration in the header file and change f2fs_sync_inode_meta()
to static.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/f2fs/checkpoint.c | 2 +-
 fs/f2fs/f2fs.h       | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c3e058e0a018..57e8ca187dc7 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1133,7 +1133,7 @@ int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type,
 	goto retry;
 }
 
-int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
+static int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
 {
 	struct list_head *head = &sbi->inode_list[DIRTY_META];
 	struct inode *inode;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b0ab2062038a..3c95c8b75a23 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3737,7 +3737,6 @@ void f2fs_set_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
 					unsigned int devidx, int type);
 bool f2fs_is_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
 					unsigned int devidx, int type);
-int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi);
 int f2fs_acquire_orphan_inode(struct f2fs_sb_info *sbi);
 void f2fs_release_orphan_inode(struct f2fs_sb_info *sbi);
 void f2fs_add_orphan_inode(struct inode *inode);
-- 
2.25.1


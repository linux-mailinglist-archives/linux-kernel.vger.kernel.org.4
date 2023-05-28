Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C63A71387B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 09:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjE1HrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 03:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1HrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 03:47:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D143C9
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 00:47:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9862D60B87
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 07:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2343C433EF;
        Sun, 28 May 2023 07:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685260041;
        bh=ZpGoTX9qNRlEq5Lv9msG/vssYrKdybIlN/zFvyB6UuI=;
        h=From:To:Cc:Subject:Date:From;
        b=atEMSKqyr6WeZFg25oEMAjMSq7itWdfOb1eAFaxnqPwQEAU+b3Zh3KR21qtuIVRN6
         uN862Glspb6p1NrG0mPZXuidGcOycI5KmN+Ieokw6dvY+9lbz0pwOG+14x+7XLpNxm
         T12poqoh9i15Wkvxl5OFFZfvvbVpvo16fKMJpthojQi657BuJ0UQOsTa6hgoQfBVg9
         R7X8AXPjNUPuSxKxq/ID3srlFwt/+gezWH92UUrC0ke7H6tA0KPOQSHTNIdJX9wJPu
         HBQTFPbr+L/Celyg1FJjvn12FAY2GVQBt0FoAAIDPUT96W4atJyD57/c8zkDQi8SQP
         /li5PnUAEMrzA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: fix to drop all dirty meta/node pages during umount()
Date:   Sun, 28 May 2023 15:47:12 +0800
Message-Id: <20230528074713.1682062-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
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

For cp error case, there will be dirty meta/node pages remained after
f2fs_write_checkpoint() in f2fs_put_super(), drop them explicitly, and
do sanity check on reference count of dirty pages and inflight IOs.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7499ebabaf35..d1bce753f0d2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1573,6 +1573,7 @@ static void f2fs_put_super(struct super_block *sb)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	int i;
+	int err = 0;
 	bool done;
 
 	/* unregister procfs/sysfs entries in advance to avoid race case */
@@ -1599,7 +1600,7 @@ static void f2fs_put_super(struct super_block *sb)
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT,
 		};
-		f2fs_write_checkpoint(sbi, &cpc);
+		err = f2fs_write_checkpoint(sbi, &cpc);
 	}
 
 	/* be sure to wait for any on-going discard commands */
@@ -1608,7 +1609,7 @@ static void f2fs_put_super(struct super_block *sb)
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT | CP_TRIMMED,
 		};
-		f2fs_write_checkpoint(sbi, &cpc);
+		err = f2fs_write_checkpoint(sbi, &cpc);
 	}
 
 	/*
@@ -1625,6 +1626,19 @@ static void f2fs_put_super(struct super_block *sb)
 
 	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
 
+	if (err) {
+		truncate_inode_pages_final(NODE_MAPPING(sbi));
+		truncate_inode_pages_final(META_MAPPING(sbi));
+	}
+
+	for (i = 0; i < NR_COUNT_TYPE; i++) {
+		if (!get_pages(sbi, i))
+			continue;
+		f2fs_err(sbi, "detect filesystem reference count leak during "
+			"umount, type: %d, count: %lld", i, get_pages(sbi, i));
+		f2fs_bug_on(sbi, 1);
+	}
+
 	f2fs_bug_on(sbi, sbi->fsync_node_num);
 
 	f2fs_destroy_compress_inode(sbi);
-- 
2.40.1


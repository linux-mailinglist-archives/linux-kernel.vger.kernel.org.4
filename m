Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2914E5B68ED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiIMHsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiIMHsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:48:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3A75A3CA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 00:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5529B80E19
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FE0C433C1;
        Tue, 13 Sep 2022 07:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663055297;
        bh=Of/zRCi4LPBlW8V1x2NpTuzZS4rJePo9idcJOEnYoAI=;
        h=From:To:Cc:Subject:Date:From;
        b=k1awtXj5VWUA7HRjnaeNKOernHCW4kLVx01QqRuCW220YsLBxeBVmzEnV4DPx54Fv
         uroA8Q1achGI2lJHwbSR4RgXa2DJ0RX+Gi0A5TvCXjIBmHC7ybBE5JGfU8HSgjFfWZ
         Jmosnzg/L7YlkwtqLF8Hw/t8+UarGTHrg2NwN8aNkxheKx0J3g3MBtUjCsKGYMf1o1
         NPt3TVLWoF8T1DkmN802WNmIREaU1r8xt+Fg8RurBbSYJ4FWUrvR9aOw9cg+t+W6+B
         FFGJBdvHVrGqPRJgBkqfPseERRxVv12qWob9k53huWnW4BqIJOthsw5DVXL2FvJ1Hh
         krdAL5vLXXd9A==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH v3] f2fs: fix to detect corrupted meta ino
Date:   Tue, 13 Sep 2022 15:48:12 +0800
Message-Id: <20220913074812.2300528-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
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

It is possible that ino of dirent or orphan inode is corrupted in a
fuzzed image, occasionally, if corrupted ino is equal to meta ino:
meta_ino, node_ino or compress_ino, caller of f2fs_iget() from below
call paths will get meta inode directly, it's not allowed, let's
add sanity check to detect such cases.

case #1
- recover_dentry
 - __f2fs_find_entry
 - f2fs_iget_retry

case #2
- recover_orphan_inode
 - f2fs_iget_retry

Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- update commit title/message
- change logic inside f2fs_iget() rather than its caller
 fs/f2fs/inode.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index cde0a3dc80c3..1baac6056733 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -487,6 +487,12 @@ static int do_read_inode(struct inode *inode)
 	return 0;
 }
 
+static bool is_meta_ino(struct f2fs_sb_info *sbi, unsigned int ino)
+{
+	return ino == F2FS_NODE_INO(sbi) || ino == F2FS_META_INO(sbi) ||
+		ino == F2FS_COMPRESS_INO(sbi);
+}
+
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -497,17 +503,22 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
+	if (is_meta_ino(sbi, ino)) {
+		if (!(inode->i_state & I_NEW)) {
+			f2fs_err(sbi, "detect corrupted inode no:%lu, run fsck to repair", ino);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			ret = -EFSCORRUPTED;
+			trace_f2fs_iget_exit(inode, ret);
+			iput(inode);
+			return ERR_PTR(ret);
+		}
+		goto make_now;
+	}
+
 	if (!(inode->i_state & I_NEW)) {
 		trace_f2fs_iget(inode);
 		return inode;
 	}
-	if (ino == F2FS_NODE_INO(sbi) || ino == F2FS_META_INO(sbi))
-		goto make_now;
-
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (ino == F2FS_COMPRESS_INO(sbi))
-		goto make_now;
-#endif
 
 	ret = do_read_inode(inode);
 	if (ret)
-- 
2.25.1


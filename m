Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263D36DC297
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjDJCRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJCRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:17:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C062A3590
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 19:17:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 549CE60D41
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7766FC433D2;
        Mon, 10 Apr 2023 02:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681093051;
        bh=2J1XkKkeUOGnc00wXCTQ8yh9LSvEk8H4eWZ0v0WIO38=;
        h=From:To:Cc:Subject:Date:From;
        b=dKxDLmruzF7p7rYASeEOYAJwkp57NyvrSDGvFIbVS96HynpR01trGk/mQprdLO8k9
         svZZkUxxOswf31hYNWaRfmnlFmBBznNjPQwmHWBFT2IE31JaJFV8fcgyW1SWSxUklo
         qzXGfvN+j7aM2NdeCgEUfl2RVFsUgYTg+6+i8Mx9gB2wI4jfYAdzwL1c6eDtXgIVfv
         alAYi8NZ69FIJAQB2oiWx/2vtRhz+nU2bXOQ1JNz4x7DUWSftMgmFkSHC1uXcoD1HX
         FnN6gpOZk4qZDlVqCM95wAry7uQGQ+pV6z64jqgY6m3aDhULmO9/xPos2vMkpNkVwa
         jBxUO6RguklCg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: use f2fs_hw_is_readonly() instead of bdev_read_only()
Date:   Mon, 10 Apr 2023 10:17:22 +0800
Message-Id: <20230410021722.1836433-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs has supported multi-device feature, to check devices' rw status,
it should use f2fs_hw_is_readonly() rather than bdev_read_only(), fix
it.

Meanwhile, it removes f2fs_hw_is_readonly() check condition in:
- f2fs_write_checkpoint()
- f2fs_convert_inline_inode()
As it has checked f2fs_readonly() condition, and if f2fs' devices
were readonly, f2fs_readonly() must be true.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 2 +-
 fs/f2fs/super.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 007fd965dd7e..478ee8aeac33 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -721,7 +721,7 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	if (!is_set_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG))
 		return 0;
 
-	if (bdev_read_only(sbi->sb->s_bdev)) {
+	if (f2fs_hw_is_readonly(sbi)) {
 		f2fs_info(sbi, "write access unavailable, skipping orphan cleanup");
 		return 0;
 	}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1573bf123197..a1b570a5e50f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3358,7 +3358,7 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 		raw_super->segment_count = cpu_to_le32((main_end_blkaddr -
 				segment0_blkaddr) >> log_blocks_per_seg);
 
-		if (f2fs_readonly(sb) || bdev_read_only(sb->s_bdev)) {
+		if (f2fs_readonly(sb) || f2fs_hw_is_readonly(sbi)) {
 			set_sbi_flag(sbi, SBI_NEED_SB_WRITE);
 			res = "internally";
 		} else {
@@ -3934,7 +3934,7 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 	int err;
 
 	if ((recover && f2fs_readonly(sbi->sb)) ||
-				bdev_read_only(sbi->sb->s_bdev)) {
+				f2fs_hw_is_readonly(sbi)) {
 		set_sbi_flag(sbi, SBI_NEED_SB_WRITE);
 		return -EROFS;
 	}
-- 
2.25.1


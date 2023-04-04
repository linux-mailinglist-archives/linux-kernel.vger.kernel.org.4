Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D85F6D6747
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbjDDP2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbjDDP21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:28:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1260349C7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:28:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CD2A635FE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 15:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31949C433D2;
        Tue,  4 Apr 2023 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680622098;
        bh=Q9R/0spYK1JLY5KmDAtd1V4FUjv3MQUTeOhn9KqE2eQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Hy0iHLZYL/ciUUtKwh3G/xrFsOkIo3kS/TW2h3qr3W/E584v9VOPFckjvxO8A0U9i
         2zvFkaBpxbRPL7lBNJTHoZYdr8XT3MQM08MgcujaE5m8o7nc6Jx5CltK5362P7tklU
         8FesFNJ6gFb8xWP67kUf2KA1RF1Zn/acIsH7Iw6wR44KkUcgq2XftXyGs3R1ezQnO+
         qz1USJUspK+Z3GMCmqFNACTZ8ztYZLuhLs6sAs+zrw2GnNZUoMz03S28Ge0zV8QxXh
         p5wRQjDQnzslsTj+CFRA/vQLJXEit4qrtlCtgxOaN7wonpGNR8ukcqpYYlvBETX9a4
         8b6DS3nl6n0KQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: fix to check readonly condition correctly
Date:   Tue,  4 Apr 2023 23:28:07 +0800
Message-Id: <20230404152807.4987-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With below case, it can mount multi-device image w/ rw option, however
one of secondary device is set as ro, later update will cause panic, so
let's introduce f2fs_dev_is_readonly(), and check multi-devices rw status
in f2fs_remount() w/ it in order to avoid such inconsistent mount status.

mkfs.f2fs -c /dev/zram1 /dev/zram0 -f
blockdev --setro /dev/zram1
mount -t f2fs dev/zram0 /mnt/f2fs
mount: /mnt/f2fs: WARNING: source write-protected, mounted read-only.
mount -t f2fs -o remount,rw mnt/f2fs
dd if=/dev/zero  of=/mnt/f2fs/file bs=1M count=8192

kernel BUG at fs/f2fs/inline.c:258!
RIP: 0010:f2fs_write_inline_data+0x23e/0x2d0 [f2fs]
Call Trace:
  f2fs_write_single_data_page+0x26b/0x9f0 [f2fs]
  f2fs_write_cache_pages+0x389/0xa60 [f2fs]
  __f2fs_write_data_pages+0x26b/0x2d0 [f2fs]
  f2fs_write_data_pages+0x2e/0x40 [f2fs]
  do_writepages+0xd3/0x1b0
  __writeback_single_inode+0x5b/0x420
  writeback_sb_inodes+0x236/0x5a0
  __writeback_inodes_wb+0x56/0xf0
  wb_writeback+0x2a3/0x490
  wb_do_writeback+0x2b2/0x330
  wb_workfn+0x6a/0x260
  process_one_work+0x270/0x5e0
  worker_thread+0x52/0x3e0
  kthread+0xf4/0x120
  ret_from_fork+0x29/0x50

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- update commit message to describe details of the issue.
- fix to do the check in f2fs_remount().
 fs/f2fs/f2fs.h  | 5 +++++
 fs/f2fs/super.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2d4a7ef62537..52f3badced21 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4446,6 +4446,11 @@ static inline bool f2fs_hw_is_readonly(struct f2fs_sb_info *sbi)
 	return false;
 }
 
+static inline bool f2fs_dev_is_readonly(struct f2fs_sb_info *sbi)
+{
+	return f2fs_sb_has_readonly(sbi) || f2fs_hw_is_readonly(sbi);
+}
+
 static inline bool f2fs_lfs_mode(struct f2fs_sb_info *sbi)
 {
 	return F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d016f398fcad..75597a107157 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2321,7 +2321,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if (f2fs_readonly(sb) && (*flags & SB_RDONLY))
 		goto skip;
 
-	if (f2fs_sb_has_readonly(sbi) && !(*flags & SB_RDONLY)) {
+	if (f2fs_dev_is_readonly(sbi) && !(*flags & SB_RDONLY)) {
 		err = -EROFS;
 		goto restore_opts;
 	}
-- 
2.36.1


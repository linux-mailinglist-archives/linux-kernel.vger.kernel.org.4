Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E056C734B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjCWWrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjCWWrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:47:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C28B75A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0184DB8227C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADA3C433D2;
        Thu, 23 Mar 2023 22:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679611655;
        bh=p/8ujgmkt7QZhcK+VwSF75YLHjEMK/AWVKd+lKFD298=;
        h=From:To:Cc:Subject:Date:From;
        b=pRspjE+yBdgKHTcBd4qHo/Q9nMFBzJdguvl47/vYxMN36YUyGFgnBy0WZitH6mIgh
         gC6IkxeeM1DnUW0Sp2ePvfeo8lQ/7/xaxb5MoUBz9VIIQkM5ie06er6o+9ApR27CPP
         iBwA8W2ByCPbrWysrNdBK4Nf3PxoHu1XLByNNdlla6Oyeyv/GMR0uKFV9FkoqJ/qE/
         mhFzX2GrEoelCaPX0nYor5w+D9RoMPFfJ/M8rG6JfNOXfCm1krlbOnMUBXtjHEPmeG
         5io7kLVP8HF+ahccowXs9r6bAuBQZvXEo3FtqwsO6Wx18UQYs0FKUa464XWIpw2hQE
         GBYGDnRJOR7nQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix scheduling while atomic in decompression path
Date:   Thu, 23 Mar 2023 15:47:34 -0700
Message-Id: <20230323224734.2041173-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
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

[   16.945668][    C0] Call trace:
[   16.945678][    C0]  dump_backtrace+0x110/0x204
[   16.945706][    C0]  dump_stack_lvl+0x84/0xbc
[   16.945735][    C0]  __schedule_bug+0xb8/0x1ac
[   16.945756][    C0]  __schedule+0x724/0xbdc
[   16.945778][    C0]  schedule+0x154/0x258
[   16.945793][    C0]  bit_wait_io+0x48/0xa4
[   16.945808][    C0]  out_of_line_wait_on_bit+0x114/0x198
[   16.945824][    C0]  __sync_dirty_buffer+0x1f8/0x2e8
[   16.945853][    C0]  __f2fs_commit_super+0x140/0x1f4
[   16.945881][    C0]  f2fs_commit_super+0x110/0x28c
[   16.945898][    C0]  f2fs_handle_error+0x1f4/0x2f4
[   16.945917][    C0]  f2fs_decompress_cluster+0xc4/0x450
[   16.945942][    C0]  f2fs_end_read_compressed_page+0xc0/0xfc
[   16.945959][    C0]  f2fs_handle_step_decompress+0x118/0x1cc
[   16.945978][    C0]  f2fs_read_end_io+0x168/0x2b0
[   16.945993][    C0]  bio_endio+0x25c/0x2c8
[   16.946015][    C0]  dm_io_dec_pending+0x3e8/0x57c
[   16.946052][    C0]  clone_endio+0x134/0x254
[   16.946069][    C0]  bio_endio+0x25c/0x2c8
[   16.946084][    C0]  blk_update_request+0x1d4/0x478
[   16.946103][    C0]  scsi_end_request+0x38/0x4cc
[   16.946129][    C0]  scsi_io_completion+0x94/0x184
[   16.946147][    C0]  scsi_finish_command+0xe8/0x154
[   16.946164][    C0]  scsi_complete+0x90/0x1d8
[   16.946181][    C0]  blk_done_softirq+0xa4/0x11c
[   16.946198][    C0]  _stext+0x184/0x614
[   16.946214][    C0]  __irq_exit_rcu+0x78/0x144
[   16.946234][    C0]  handle_domain_irq+0xd4/0x154
[   16.946260][    C0]  gic_handle_irq.33881+0x5c/0x27c
[   16.946281][    C0]  call_on_irq_stack+0x40/0x70
[   16.946298][    C0]  do_interrupt_handler+0x48/0xa4
[   16.946313][    C0]  el1_interrupt+0x38/0x68
[   16.946346][    C0]  el1h_64_irq_handler+0x20/0x30
[   16.946362][    C0]  el1h_64_irq+0x78/0x7c
[   16.946377][    C0]  finish_task_switch+0xc8/0x3d8
[   16.946394][    C0]  __schedule+0x600/0xbdc
[   16.946408][    C0]  preempt_schedule_common+0x34/0x5c
[   16.946423][    C0]  preempt_schedule+0x44/0x48
[   16.946438][    C0]  process_one_work+0x30c/0x550
[   16.946456][    C0]  worker_thread+0x414/0x8bc
[   16.946472][    C0]  kthread+0x16c/0x1e0
[   16.946486][    C0]  ret_from_fork+0x10/0x20

Fixes: bff139b49d9f ("f2fs: handle decompress only post processing in softirq")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/compress.c | 7 ++++++-
 fs/f2fs/f2fs.h     | 1 +
 fs/f2fs/super.c    | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 9b7149534a58..3182e1506252 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -755,7 +755,12 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 
 	if (dic->clen > PAGE_SIZE * dic->nr_cpages - COMPRESS_HEADER_SIZE) {
 		ret = -EFSCORRUPTED;
-		f2fs_handle_error(sbi, ERROR_FAIL_DECOMPRESSION);
+
+		/* Avoid f2fs_commit_super in irq context */
+		if (in_task)
+			f2fs_save_errors(sbi, ERROR_FAIL_DECOMPRESSION);
+		else
+			f2fs_handle_error(sbi, ERROR_FAIL_DECOMPRESSION);
 		goto out_release;
 	}
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 53a005b420cf..4e2596dacbf1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3539,6 +3539,7 @@ int f2fs_quota_sync(struct super_block *sb, int type);
 loff_t max_file_blocks(struct inode *inode);
 void f2fs_quota_off_umount(struct super_block *sb);
 void f2fs_handle_stop(struct f2fs_sb_info *sbi, unsigned char reason);
+void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag);
 void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error);
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
 int f2fs_sync_fs(struct super_block *sb, int sync);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9c87d91df61b..50d23dcc33fb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3885,7 +3885,7 @@ void f2fs_handle_stop(struct f2fs_sb_info *sbi, unsigned char reason)
 	f2fs_up_write(&sbi->sb_lock);
 }
 
-static void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag)
+void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag)
 {
 	spin_lock(&sbi->error_lock);
 	if (!test_bit(flag, (unsigned long *)sbi->errors)) {
-- 
2.40.0.348.gf938b09366-goog


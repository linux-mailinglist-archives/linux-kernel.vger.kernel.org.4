Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DD46DC291
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjDJCMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJCMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C8530EF
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 19:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E92A56172E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE7FC433D2;
        Mon, 10 Apr 2023 02:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681092754;
        bh=2wTb3o2En2FYkmbvF9dDTpIdwIzLMd7m35J/cia5i2E=;
        h=From:To:Cc:Subject:Date:From;
        b=NAqwGYbgXwF9CP5o0Hf9EftnNEUBP5QlxxnP1r7sHbXBZNntE0OpWq23ME+eS+9sx
         xHXPEgomjcinXQ0lYPVEjjKMA4HmLZDtDzIp8MlLB0Zq8QZkKFN7yot5nwQcsblsv2
         HsexiDSi5J+1NcFB/gqQKVkcgCJ9Ls57qpDA+v5C0vBZYwg+2TZJo8D9P4zGmivond
         Tx36Wmv4YqGDEy5Vsf72KR5j+OutxHRSYQv8lPo9+vIlHNpv5Gss4GOMTLyrO13tYn
         oyn4gK34dMeay7pw3eQ6W3K3XCrdXfoq4oTtH8F/yfsoNJ9D/5vZV84/Roj908vCL+
         3kyR2BZhU+aDg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to drop all dirty pages during umount() if cp_error is set
Date:   Mon, 10 Apr 2023 10:12:22 +0800
Message-Id: <20230410021222.1826966-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
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

xfstest generic/361 reports a bug as below:

f2fs_bug_on(sbi, sbi->fsync_node_num);

kernel BUG at fs/f2fs/super.c:1627!
RIP: 0010:f2fs_put_super+0x3a8/0x3b0
Call Trace:
 generic_shutdown_super+0x8c/0x1b0
 kill_block_super+0x2b/0x60
 kill_f2fs_super+0x87/0x110
 deactivate_locked_super+0x39/0x80
 deactivate_super+0x46/0x50
 cleanup_mnt+0x109/0x170
 __cleanup_mnt+0x16/0x20
 task_work_run+0x65/0xa0
 exit_to_user_mode_prepare+0x175/0x190
 syscall_exit_to_user_mode+0x25/0x50
 do_syscall_64+0x4c/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

During umount(), if cp_error is set, f2fs_wait_on_all_pages() should
not stop waiting all F2FS_WB_CP_DATA pages to be writebacked, otherwise,
fsync_node_num can be non-zero after f2fs_wait_on_all_pages() causing
this bug.

In this case, to avoid deadloop in f2fs_wait_on_all_pages(), it needs
to drop all dirty pages rather than redirtying them.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 12 ++++++++++--
 fs/f2fs/data.c       |  3 ++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index e6b266bb9ce0..007fd965dd7e 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -327,8 +327,15 @@ static int __f2fs_write_meta_page(struct page *page,
 
 	trace_f2fs_writepage(page, META);
 
-	if (unlikely(f2fs_cp_error(sbi)))
+	if (unlikely(f2fs_cp_error(sbi))) {
+		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
+			ClearPageUptodate(page);
+			dec_page_count(sbi, F2FS_DIRTY_META);
+			unlock_page(page);
+			return 0;
+		}
 		goto redirty_out;
+	}
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
 	if (wbc->for_reclaim && page->index < GET_SUM_BLOCK(sbi, 0))
@@ -1288,7 +1295,8 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
 		if (!get_pages(sbi, type))
 			break;
 
-		if (unlikely(f2fs_cp_error(sbi)))
+		if (unlikely(f2fs_cp_error(sbi) &&
+			!is_sbi_flag_set(sbi, SBI_IS_CLOSE)))
 			break;
 
 		if (type == F2FS_DIRTY_META)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index becc7bdb7403..8064df5f829d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2801,7 +2801,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 		 * don't drop any dirty dentry pages for keeping lastest
 		 * directory structure.
 		 */
-		if (S_ISDIR(inode->i_mode))
+		if (S_ISDIR(inode->i_mode) &&
+				!is_sbi_flag_set(sbi, SBI_IS_CLOSE))
 			goto redirty_out;
 		goto out;
 	}
-- 
2.25.1


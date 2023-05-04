Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD066F7771
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjEDUug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjEDUuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:50:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262F6AD03;
        Thu,  4 May 2023 13:50:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7517463844;
        Thu,  4 May 2023 19:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F393C4339B;
        Thu,  4 May 2023 19:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229918;
        bh=7tGG+NOlssfu/NITwNH5Vwr/UrNSkYrA8md/wSgniNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e5jOnoINVrRgTNCga6MqeQ8HW3myP6CLY83kgjFSx9EOGTtGXOFUf9SBrc0O5vPvg
         qxIFgw13ZmgEOfCplzxCV/nrpJxEERjgUeAdW7n2IwowZA8D5ZGZLEGS4rbauPcN6l
         /JKuW5qFGcIwEyBs7hO30tEQYZo9+KOQOKg9KEecBB9cxH33scS2VcjDv2xIUaWOHE
         2KNnTxQisczejPtnVPgRcDBehM56OYUwEY5EqFfgUsi8c+fOGcs+7rYK7ufIM1R5b/
         4dO3Uu4kyxrAtdSHgr/wxkkhQsRNIS4dexLkPTC5TtMNwSSY/5AOB2548lzzyn0tny
         2z8I1vt4hy9fQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 11/13] f2fs: fix to drop all dirty pages during umount() if cp_error is set
Date:   Thu,  4 May 2023 15:51:28 -0400
Message-Id: <20230504195132.3808946-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504195132.3808946-1-sashal@kernel.org>
References: <20230504195132.3808946-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <chao@kernel.org>

[ Upstream commit c9b3649a934d131151111354bcbb638076f03a30 ]

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
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c | 12 ++++++++++--
 fs/f2fs/data.c       |  3 ++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a563de5ccd217..621e0d4f1fbf5 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -273,8 +273,15 @@ static int __f2fs_write_meta_page(struct page *page,
 
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
@@ -1185,7 +1192,8 @@ void f2fs_wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
 		if (!get_pages(sbi, F2FS_WB_CP_DATA))
 			break;
 
-		if (unlikely(f2fs_cp_error(sbi)))
+		if (unlikely(f2fs_cp_error(sbi) &&
+			!is_sbi_flag_set(sbi, SBI_IS_CLOSE)))
 			break;
 
 		io_schedule_timeout(5*HZ);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 56b2dadd623b2..419586809cef6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1885,7 +1885,8 @@ static int __write_data_page(struct page *page, bool *submitted,
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
2.39.2


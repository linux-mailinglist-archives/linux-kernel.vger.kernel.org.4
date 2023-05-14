Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F344B701C49
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 10:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjENIHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 04:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjENIHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 04:07:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260FB1FE5
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 01:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8B5960AD9
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 08:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B53C433EF;
        Sun, 14 May 2023 08:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684051642;
        bh=QQ3nMwGAnsCK6ZrMFJPsS/m9kGhypUyBDVn0s2ymerY=;
        h=From:To:Cc:Subject:Date:From;
        b=AuMbiVq03FYnXeHnaW80P+lJBHCjv5Om8XclL3WhesZamp3BCPrZjWejt1egHRbVF
         RRTO1o05q0DyipdYobDO+fFHNAj0EWHpBKsazhXZsGFqlG9RV9DSwkOmyyll1lUoEk
         Xtr8JRErbMTdEm9ObL0EQikJR8WsWasmeAtFkJIL5C6KhE2e9MtJnCm8q2nf3nCjMD
         hxZXOEV3PbCw3fQVrM4w82pydmObqjhAcEn/kjpIoLgqrUgu2kTTonkphz6w6teWb7
         PZB0MPj/kidIZTDxjOna867QHhv6NETN5lPtkh41lDG4Obc6pXnPhsz6rd9OtsJiU/
         LTqzh+FA1lZhA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix potential deadlock due to unpaired node_write lock use
Date:   Sun, 14 May 2023 16:07:23 +0800
Message-Id: <20230514080723.17313-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
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

If S_NOQUOTA is cleared from inode during data page writeback of quota
file, it may miss to unlock node_write lock, result in potential
deadlock, fix to use the lock in paired.

Kworker					Thread
- writepage
 if (IS_NOQUOTA())
   f2fs_down_read(&sbi->node_write);
					- vfs_cleanup_quota_inode
					 - inode->i_flags &= ~S_NOQUOTA;
 if (IS_NOQUOTA())
   f2fs_up_read(&sbi->node_write);

Fixes: 79963d967b49 ("f2fs: shrink node_write lock coverage")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 7 ++++---
 fs/f2fs/data.c     | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 11653fa79289..2ec7cf454418 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1215,6 +1215,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	unsigned int last_index = cc->cluster_size - 1;
 	loff_t psize;
 	int i, err;
+	bool quota_inode = IS_NOQUOTA(inode);
 
 	/* we should bypass data pages to proceed the kworker jobs */
 	if (unlikely(f2fs_cp_error(sbi))) {
@@ -1222,7 +1223,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		goto out_free;
 	}
 
-	if (IS_NOQUOTA(inode)) {
+	if (quota_inode) {
 		/*
 		 * We need to wait for node_write to avoid block allocation during
 		 * checkpoint. This can only happen to quota writes which can cause
@@ -1344,7 +1345,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 
 	f2fs_put_dnode(&dn);
-	if (IS_NOQUOTA(inode))
+	if (quota_inode)
 		f2fs_up_read(&sbi->node_write);
 	else
 		f2fs_unlock_op(sbi);
@@ -1370,7 +1371,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 out_put_dnode:
 	f2fs_put_dnode(&dn);
 out_unlock_op:
-	if (IS_NOQUOTA(inode))
+	if (quota_inode)
 		f2fs_up_read(&sbi->node_write);
 	else
 		f2fs_unlock_op(sbi);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7165b1202f53..4a0ee9cc43b5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2775,6 +2775,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	loff_t psize = (loff_t)(page->index + 1) << PAGE_SHIFT;
 	unsigned offset = 0;
 	bool need_balance_fs = false;
+	bool quota_inode = IS_NOQUOTA(inode);
 	int err = 0;
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
@@ -2832,19 +2833,19 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 		goto out;
 
 	/* Dentry/quota blocks are controlled by checkpoint */
-	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {
+	if (S_ISDIR(inode->i_mode) || quota_inode) {
 		/*
 		 * We need to wait for node_write to avoid block allocation during
 		 * checkpoint. This can only happen to quota writes which can cause
 		 * the below discard race condition.
 		 */
-		if (IS_NOQUOTA(inode))
+		if (quota_inode)
 			f2fs_down_read(&sbi->node_write);
 
 		fio.need_lock = LOCK_DONE;
 		err = f2fs_do_write_data_page(&fio);
 
-		if (IS_NOQUOTA(inode))
+		if (quota_inode)
 			f2fs_up_read(&sbi->node_write);
 
 		goto done;
-- 
2.36.1


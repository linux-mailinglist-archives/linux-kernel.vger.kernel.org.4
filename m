Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5104764D658
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiLOGHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLOGHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:07:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F209E3FB92
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:07:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AC9861CEF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB02C433EF;
        Thu, 15 Dec 2022 06:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671084451;
        bh=0NfiFGHwkJcI8GSlY2A4QfANtLqFrxyrmqMzhDsZ/xc=;
        h=From:To:Cc:Subject:Date:From;
        b=gpvHGCZ8lTCvgxjC5Q4uB9Op/tcFUsTagOu1u1dPeR5vjVpkk38ebnaALGp3g5Ljf
         skLYRpkWsR7Y+7SKulZytW4qMHP99pZ9yWm7D3O7utIk/P5nF9DJr0WhtGoddaEDbm
         kxeplIwvM0ybFMd91BZ8dCPJmj8rFqInKKbQcsdYSwaGUSDB/dBfvpz3x4Pe6UzErX
         2V9KwDIpkuM6sZzg5+gnRyTRE2B/HwIOf3NsC7Apms1D1QVAYbqYfgN626jUWe1/RT
         YPI/+dp0jry6vUDOfdImprs0iKx9mJ1mRno62UlLuAGRSOtdLO438UpTRoRKZmO3Ni
         WW+16V/FTsLpg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] f2fs: avoid to check PG_error flag
Date:   Thu, 15 Dec 2022 14:05:06 +0800
Message-Id: <20221215060506.3454508-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After below changes:
commit 14db0b3c7b83 ("fscrypt: stop using PG_error to track error status")
commit 98dc08bae678 ("fsverity: stop using PG_error to track error status")

There is no place in f2fs we will set PG_error flag in page, let's remove
other PG_error usage in f2fs, as a step towards freeing the PG_error flag
for other uses.

Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c    | 2 --
 fs/f2fs/gc.c      | 1 -
 fs/f2fs/inline.c  | 1 -
 fs/f2fs/node.c    | 3 ---
 fs/f2fs/segment.c | 1 -
 5 files changed, 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6e43e19c7d1c..78e8745b91c5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2700,7 +2700,6 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 			goto out_writepage;
 
 		set_page_writeback(page);
-		ClearPageError(page);
 		f2fs_put_dnode(&dn);
 		if (fio->need_lock == LOCK_REQ)
 			f2fs_unlock_op(fio->sbi);
@@ -2736,7 +2735,6 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		goto out_writepage;
 
 	set_page_writeback(page);
-	ClearPageError(page);
 
 	if (fio->compr_blocks && fio->old_blkaddr == COMPRESS_ADDR)
 		f2fs_i_compr_blocks_update(inode, fio->compr_blocks - 1, false);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6e2cae3d2e71..43c461b80209 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1365,7 +1365,6 @@ static int move_data_block(struct inode *inode, block_t bidx,
 		dec_page_count(fio.sbi, F2FS_DIRTY_META);
 
 	set_page_writeback(fio.encrypted_page);
-	ClearPageError(page);
 
 	fio.op = REQ_OP_WRITE;
 	fio.op_flags = REQ_SYNC;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 21a495234ffd..08e302d32118 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -174,7 +174,6 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 
 	/* write data page to try to make data consistent */
 	set_page_writeback(page);
-	ClearPageError(page);
 	fio.old_blkaddr = dn->data_blkaddr;
 	set_inode_flag(dn->inode, FI_HOT_DATA);
 	f2fs_outplace_write_data(dn, &fio);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index dde4c0458704..558b318f7316 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1650,7 +1650,6 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	}
 
 	set_page_writeback(page);
-	ClearPageError(page);
 
 	fio.old_blkaddr = ni.blk_addr;
 	f2fs_do_write_node_page(nid, &fio);
@@ -2079,8 +2078,6 @@ int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
 		spin_unlock_irqrestore(&sbi->fsync_node_lock, flags);
 
 		f2fs_wait_on_page_writeback(page, NODE, true, false);
-		if (TestClearPageError(page))
-			ret = -EIO;
 
 		put_page(page);
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 25ddea478fc1..0134d8c166e9 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3423,7 +3423,6 @@ void f2fs_do_write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
 		fio.op_flags &= ~REQ_META;
 
 	set_page_writeback(page);
-	ClearPageError(page);
 	f2fs_submit_page_write(&fio);
 
 	stat_inc_meta_count(sbi, page->index);
-- 
2.25.1


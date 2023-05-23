Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893A270D3CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbjEWGSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbjEWGSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:18:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54663E7B
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:17:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08F8762F6D
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CD8C433EF;
        Tue, 23 May 2023 06:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684822650;
        bh=38y7NLa808DqjIF9OA8vbOvXbxxZjQco8ZcDj1mr0Lc=;
        h=From:To:Cc:Subject:Date:From;
        b=MZNr4UghA8rCfBeNk9r38fP4XHOsdRFRLn4O6Da8m0Y5SiWzmDiio/GdoT3C2OmZu
         j+5ljBGJZZHCU+/hYsjiCnakTkOEcOuh4RgeKVtKhE/KKeLAG7ueMjCkEhuuI6CsDA
         qNqvEYJVnzOCfhlyhkj659cQ8BbVLHkOezpknZTKWZbxWunJTzJRPH3biGsRY667lJ
         aKMZR6/mGoIvMy1gQpfspZDSn4iC0FJjWL66Zopaz+vBGCZvhz9hFTul1AI8CelUN0
         +cxmZO8OXLQrtvxAS7cxF/vetiOw5zkhVO/0a+MrHuo+k/f8xNJ8dh9qsUx84oFqB7
         eMGBmdw72c9Og==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        butt3rflyh4ck <butterflyhuangxx@gmail.com>
Subject: [PATCH v2] f2fs: fix to avoid NULL pointer dereference f2fs_write_end_io()
Date:   Tue, 23 May 2023 14:17:25 +0800
Message-Id: <20230523061725.650692-1-chao@kernel.org>
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

butt3rflyh4ck reports a bug as below:

When a thread always calls F2FS_IOC_RESIZE_FS to resize fs, if resize fs is
failed, f2fs kernel thread would invoke callback function to update f2fs io
info, it would call  f2fs_write_end_io and may trigger null-ptr-deref in
NODE_MAPPING.

general protection fault, probably for non-canonical address
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
RIP: 0010:NODE_MAPPING fs/f2fs/f2fs.h:1972 [inline]
RIP: 0010:f2fs_write_end_io+0x727/0x1050 fs/f2fs/data.c:370
 <TASK>
 bio_endio+0x5af/0x6c0 block/bio.c:1608
 req_bio_endio block/blk-mq.c:761 [inline]
 blk_update_request+0x5cc/0x1690 block/blk-mq.c:906
 blk_mq_end_request+0x59/0x4c0 block/blk-mq.c:1023
 lo_complete_rq+0x1c6/0x280 drivers/block/loop.c:370
 blk_complete_reqs+0xad/0xe0 block/blk-mq.c:1101
 __do_softirq+0x1d4/0x8ef kernel/softirq.c:571
 run_ksoftirqd kernel/softirq.c:939 [inline]
 run_ksoftirqd+0x31/0x60 kernel/softirq.c:931
 smpboot_thread_fn+0x659/0x9e0 kernel/smpboot.c:164
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The root cause is below race case can cause leaving dirty metadata
in f2fs after filesystem is remount as ro:

Thread A				Thread B
- f2fs_ioc_resize_fs
 - f2fs_readonly   --- return false
 - f2fs_resize_fs
					- f2fs_remount
					 - write_checkpoint
					 - set f2fs as ro
  - free_segment_range
   - update meta_inode's data

Then, if f2fs_put_super()  fails to write_checkpoint due to readonly
status, and meta_inode's dirty data will be writebacked after node_inode
is put, finally, f2fs_write_end_io will access NULL pointer on
sbi->node_inode.

Thread A				IRQ context
- f2fs_put_super
 - write_checkpoint fails
 - iput(node_inode)
 - node_inode = NULL
 - iput(meta_inode)
  - write_inode_now
   - f2fs_write_meta_page
					- f2fs_write_end_io
					 - NODE_MAPPING(sbi)
					 : access NULL pointer on node_inode

Fixes: b4b10061ef98 ("f2fs: refactor resize_fs to avoid meta updates in progress")
Reported-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
Closes: https://lore.kernel.org/r/1684480657-2375-1-git-send-email-yangtiezhu@loongson.cn
Tested-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- update commit message a bit
- add Tested-by tag
 fs/f2fs/f2fs.h |  2 +-
 fs/f2fs/file.c |  2 +-
 fs/f2fs/gc.c   | 21 ++++++++++++++++++---
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c604523a22c2..e28cbb89b063 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3843,7 +3843,7 @@ void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi);
 block_t f2fs_start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
 int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control);
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
-int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count);
+int f2fs_resize_fs(struct file *filp, __u64 block_count);
 int __init f2fs_create_garbage_collection_cache(void);
 void f2fs_destroy_garbage_collection_cache(void);
 /* victim selection function for cleaning and SSR */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 78aa8cff4b41..015ed274dc31 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3279,7 +3279,7 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
 			   sizeof(block_count)))
 		return -EFAULT;
 
-	return f2fs_resize_fs(sbi, block_count);
+	return f2fs_resize_fs(filp, block_count);
 }
 
 static int f2fs_ioc_enable_verity(struct file *filp, unsigned long arg)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 35b95b3d57ef..8cbe4839f640 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2195,8 +2195,9 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 	}
 }
 
-int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
+int f2fs_resize_fs(struct file *filp, __u64 block_count)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
 	__u64 old_block_count, shrunk_blocks;
 	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
 	unsigned int secs;
@@ -2234,12 +2235,18 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 		return -EINVAL;
 	}
 
+	err = mnt_want_write_file(filp);
+	if (err)
+		return err;
+
 	shrunk_blocks = old_block_count - block_count;
 	secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
 
 	/* stop other GC */
-	if (!f2fs_down_write_trylock(&sbi->gc_lock))
-		return -EAGAIN;
+	if (!f2fs_down_write_trylock(&sbi->gc_lock)) {
+		err = -EAGAIN;
+		goto out_drop_write;
+	}
 
 	/* stop CP to protect MAIN_SEC in free_segment_range */
 	f2fs_lock_op(sbi);
@@ -2259,10 +2266,18 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 out_unlock:
 	f2fs_unlock_op(sbi);
 	f2fs_up_write(&sbi->gc_lock);
+out_drop_write:
+	mnt_drop_write_file(filp);
 	if (err)
 		return err;
 
 	freeze_super(sbi->sb);
+
+	if (f2fs_readonly(sbi->sb)) {
+		thaw_super(sbi->sb);
+		return -EROFS;
+	}
+
 	f2fs_down_write(&sbi->gc_lock);
 	f2fs_down_write(&sbi->cp_global_sem);
 
-- 
2.40.1


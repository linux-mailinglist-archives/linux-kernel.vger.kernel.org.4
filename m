Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5E7628475
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbiKNPzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbiKNPz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:55:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780FC2E6AB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:55:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32D0CB8107B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DBDC433D6;
        Mon, 14 Nov 2022 15:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668441325;
        bh=H2Y1GL/SJK1DpbLM59qFjLKurzWZxWEgT0xFdgJ3650=;
        h=From:To:Cc:Subject:Date:From;
        b=jBhOPP3h1WF4rxpqWKIvOmKqNs2uikqxUy9fToQFF9JrbNpiKr9IEzcVY/01QBhk5
         lsYsCx1PnX4rlO/AY4mllj4Cs0MZErjbCzO2lvNAnGs80qG/uMWX6qbUJUyslIS4d5
         WNLBb9DMfb494tS/tiga5PfINY0nqh1F4vaMiXefdtpWVv0JrHs7t8SYiitWTkXQ4c
         4BccEEnJJjKGYiyFOgTzvxo6eU0KfsjeTCAt2DHpJav2DySaiHb3WKLPqUuGwrcV/9
         M16voDV37mDz8CBtqrtFyYh71J7/O/umd/WS4zRTyxMoQ7Y4I2q9/NBvGPVpgv9GCB
         8YL83M29KtWAw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        syzbot+f8f3dfa4abc489e768a1@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: fix to do sanity check on i_extra_isize in is_alive()
Date:   Mon, 14 Nov 2022 11:05:41 +0800
Message-Id: <20221114030541.6589-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot found a f2fs bug:

BUG: KASAN: slab-out-of-bounds in data_blkaddr fs/f2fs/f2fs.h:2891 [inline]
BUG: KASAN: slab-out-of-bounds in is_alive fs/f2fs/gc.c:1117 [inline]
BUG: KASAN: slab-out-of-bounds in gc_data_segment fs/f2fs/gc.c:1520 [inline]
BUG: KASAN: slab-out-of-bounds in do_garbage_collect+0x386a/0x3df0 fs/f2fs/gc.c:1734
Read of size 4 at addr ffff888076557568 by task kworker/u4:3/52

CPU: 1 PID: 52 Comm: kworker/u4:3 Not tainted 6.1.0-rc4-syzkaller-00362-gfef7fd48922d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
print_address_description mm/kasan/report.c:284 [inline]
print_report+0x15e/0x45d mm/kasan/report.c:395
kasan_report+0xbb/0x1f0 mm/kasan/report.c:495
data_blkaddr fs/f2fs/f2fs.h:2891 [inline]
is_alive fs/f2fs/gc.c:1117 [inline]
gc_data_segment fs/f2fs/gc.c:1520 [inline]
do_garbage_collect+0x386a/0x3df0 fs/f2fs/gc.c:1734
f2fs_gc+0x88c/0x20a0 fs/f2fs/gc.c:1831
f2fs_balance_fs+0x544/0x6b0 fs/f2fs/segment.c:410
f2fs_write_inode+0x57e/0xe20 fs/f2fs/inode.c:753
write_inode fs/fs-writeback.c:1440 [inline]
__writeback_single_inode+0xcfc/0x1440 fs/fs-writeback.c:1652
writeback_sb_inodes+0x54d/0xf90 fs/fs-writeback.c:1870
wb_writeback+0x2c5/0xd70 fs/fs-writeback.c:2044
wb_do_writeback fs/fs-writeback.c:2187 [inline]
wb_workfn+0x2dc/0x12f0 fs/fs-writeback.c:2227
process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
worker_thread+0x665/0x1080 kernel/workqueue.c:2436
kthread+0x2e4/0x3a0 kernel/kthread.c:376
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The root cause is that we forgot to do sanity check on .i_extra_isize
in below path, result in accessing invalid address later, fix it.
- gc_data_segment
 - is_alive
  - data_blkaddr
   - offset_in_addr

Reported-by: syzbot+f8f3dfa4abc489e768a1@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-f2fs-devel/0000000000003cb3c405ed5c17f9@google.com/T/#u
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 69d7d8db3daa..0aaabfd2cf91 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1077,7 +1077,7 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 {
 	struct page *node_page;
 	nid_t nid;
-	unsigned int ofs_in_node, max_addrs;
+	unsigned int ofs_in_node, max_addrs, base;
 	block_t source_blkaddr;
 
 	nid = le32_to_cpu(sum->nid);
@@ -1103,11 +1103,17 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		return false;
 	}
 
-	max_addrs = IS_INODE(node_page) ? DEF_ADDRS_PER_INODE :
-						DEF_ADDRS_PER_BLOCK;
-	if (ofs_in_node >= max_addrs) {
-		f2fs_err(sbi, "Inconsistent ofs_in_node:%u in summary, ino:%u, nid:%u, max:%u",
-			ofs_in_node, dni->ino, dni->nid, max_addrs);
+	if (IS_INODE(node_page)) {
+		base = offset_in_addr(F2FS_INODE(node_page));
+		max_addrs = DEF_ADDRS_PER_INODE;
+	} else {
+		base = 0;
+		max_addrs = DEF_ADDRS_PER_BLOCK;
+	}
+
+	if (base + ofs_in_node >= max_addrs) {
+		f2fs_err(sbi, "Inconsistent blkaddr offset: base:%u, ofs_in_node:%u, max:%u, ino:%u, nid:%u",
+			base, ofs_in_node, max_addrs, dni->ino, dni->nid);
 		f2fs_put_page(node_page, 1);
 		return false;
 	}
-- 
2.36.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49622627506
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 04:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiKNDjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 22:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbiKNDjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 22:39:20 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174126559;
        Sun, 13 Nov 2022 19:39:19 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N9ZmL55s8z15MdD;
        Mon, 14 Nov 2022 11:38:58 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (7.193.23.147) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 11:39:17 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 11:39:16 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <konishi.ryusuke@gmail.com>, <ye.xingchen@zte.com.cn>,
        <chi.minghao@zte.com.cn>, <vishal.moola@gmail.com>,
        <linux-nilfs@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        <syzbot+ebe05ee8e98f755f61d0@syzkaller.appspotmail.com>
Subject: [PATCH] nilfs2: fix NULL pointer dereference in nilfs_palloc_commit_free_entry()
Date:   Mon, 14 Nov 2022 04:04:41 +0000
Message-ID: <20221114040441.1649940-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

Syzbot reported a null-ptr-deref bug:

NILFS (loop0): segctord starting. Construction interval = 5 seconds, CP
frequency < 30 seconds
general protection fault, probably for non-canonical address
0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 PID: 3603 Comm: segctord Not tainted
6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google
10/11/2022
RIP: 0010:nilfs_palloc_commit_free_entry+0xe5/0x6b0
fs/nilfs2/alloc.c:608
Code: 00 00 00 00 fc ff df 80 3c 02 00 0f 85 cd 05 00 00 48 b8 00 00 00
00 00 fc ff df 4c 8b 73 08 49 8d 7e 10 48 89 fa 48 c1 ea 03 <80> 3c 02
00 0f 85 26 05 00 00 49 8b 46 10 be a6 00 00 00 48 c7 c7
RSP: 0018:ffffc90003dff830 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: ffff88802594e218 RCX: 000000000000000d
RDX: 0000000000000002 RSI: 0000000000002000 RDI: 0000000000000010
RBP: ffff888071880222 R08: 0000000000000005 R09: 000000000000003f
R10: 000000000000000d R11: 0000000000000000 R12: ffff888071880158
R13: ffff88802594e220 R14: 0000000000000000 R15: 0000000000000004
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb1c08316a8 CR3: 0000000018560000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 nilfs_dat_commit_free fs/nilfs2/dat.c:114 [inline]
 nilfs_dat_commit_end+0x464/0x5f0 fs/nilfs2/dat.c:193
 nilfs_dat_commit_update+0x26/0x40 fs/nilfs2/dat.c:236
 nilfs_btree_commit_update_v+0x87/0x4a0 fs/nilfs2/btree.c:1940
 nilfs_btree_commit_propagate_v fs/nilfs2/btree.c:2016 [inline]
 nilfs_btree_propagate_v fs/nilfs2/btree.c:2046 [inline]
 nilfs_btree_propagate+0xa00/0xd60 fs/nilfs2/btree.c:2088
 nilfs_bmap_propagate+0x73/0x170 fs/nilfs2/bmap.c:337
 nilfs_collect_file_data+0x45/0xd0 fs/nilfs2/segment.c:568
 nilfs_segctor_apply_buffers+0x14a/0x470 fs/nilfs2/segment.c:1018
 nilfs_segctor_scan_file+0x3f4/0x6f0 fs/nilfs2/segment.c:1067
 nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1197 [inline]
 nilfs_segctor_collect fs/nilfs2/segment.c:1503 [inline]
 nilfs_segctor_do_construct+0x12fc/0x6af0 fs/nilfs2/segment.c:2045
 nilfs_segctor_construct+0x8e3/0xb30 fs/nilfs2/segment.c:2379
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2487 [inline]
 nilfs_segctor_thread+0x3c3/0xf30 fs/nilfs2/segment.c:2570
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:nilfs_palloc_commit_free_entry+0xe5/0x6b0
fs/nilfs2/alloc.c:608
Code: 00 00 00 00 fc ff df 80 3c 02 00 0f 85 cd 05 00 00 48 b8 00 00 00
00 00 fc ff df 4c 8b 73 08 49 8d 7e 10 48 89 fa 48 c1 ea 03 <80> 3c 02
00 0f 85 26 05 00 00 49 8b 46 10 be a6 00 00 00 48 c7 c7
RSP: 0018:ffffc90003dff830 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: ffff88802594e218 RCX: 000000000000000d
RDX: 0000000000000002 RSI: 0000000000002000 RDI: 0000000000000010
RBP: ffff888071880222 R08: 0000000000000005 R09: 000000000000003f
R10: 000000000000000d R11: 0000000000000000 R12: ffff888071880158
R13: ffff88802594e220 R14: 0000000000000000 R15: 0000000000000004
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb1c08316a8 CR3: 0000000018560000 CR4: 0000000000350ee0
----------------
Code disassembly (best guess), 7 bytes skipped:
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	0f 85 cd 05 00 00    	jne    0x5d7
   a:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  11:	fc ff df
  14:	4c 8b 73 08          	mov    0x8(%rbx),%r14
  18:	49 8d 7e 10          	lea    0x10(%r14),%rdi
  1c:	48 89 fa             	mov    %rdi,%rdx
  1f:	48 c1 ea 03          	shr    $0x3,%rdx
* 23:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping
instruction
  27:	0f 85 26 05 00 00    	jne    0x553
  2d:	49 8b 46 10          	mov    0x10(%r14),%rax
  31:	be a6 00 00 00       	mov    $0xa6,%esi
  36:	48                   	rex.W
  37:	c7                   	.byte 0xc7
  38:	c7                   	.byte 0xc7

When maxlevelp is 1, there is a case where req->pr_desc_bh is NULL and
blocknr is 0, because nilfs_dat_commit_alloc() will modify the blocknr
of oldreq at one level higher to 0. And we don't have a NULL check on
req->pr_desc_bh and req->pr_bitmap_bh in
nilfs_palloc_commit_free_entry() function, so when req->pr_desc_bh is
NULL and kmap() dereferences a NULL pointer, it leads to above crash.
Fix this by adding a NULL check on req->pr_desc_bh and req->pr_bitmap_bh
before nilfs_palloc_commit_free_entry() in nilfs_dat_commit_free().

Reported-by: syzbot+ebe05ee8e98f755f61d0@syzkaller.appspotmail.com
Fixes: bd8169efae8b ("nilfs2: add update functions of virtual block address to dat")
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 fs/nilfs2/dat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index 3b55e239705f..84ce050a8fa3 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -111,6 +111,9 @@ static void nilfs_dat_commit_free(struct inode *dat,
 	kunmap_atomic(kaddr);
 
 	nilfs_dat_commit_entry(dat, req);
+
+	if (req->pr_desc_bh == NULL || req->pr_bitmap_bh == NULL)
+		return;
 	nilfs_palloc_commit_free_entry(dat, req);
 }
 
-- 
2.25.1


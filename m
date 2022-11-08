Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DD3620642
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiKHBlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKHBld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:41:33 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5CA1A80C;
        Mon,  7 Nov 2022 17:41:32 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5rRR5qFMzRp5p;
        Tue,  8 Nov 2022 09:41:23 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 09:41:31 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 09:41:30 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-nilfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH] nilfs2: fix NULL pointer dereference in nilfs_segctor_prepare_write()
Date:   Tue, 8 Nov 2022 10:29:28 +0800
Message-ID: <20221108022928.497746-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reported a NULL pointer dereference:

 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000168
 Mem abort info:
   ESR = 0x0000000096000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x04: level 0 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000004
   CM = 0, WnR = 0
 user pgtable: 4k pages, 48-bit VAs, pgdp=0000000108bcf000
 [0000000000000168] pgd=0000000000000000, p4d=0000000000000000
 Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
 Modules linked in:
 CPU: 1 PID: 3032 Comm: segctord Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
 pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : _compound_head include/linux/page-flags.h:253 [inline]
 pc : lock_page+0x28/0x1e0 include/linux/pagemap.h:958
 lr : lock_page+0x28/0x1e0 include/linux/pagemap.h:956
 sp : ffff80001290bc00
 x29: ffff80001290bc00 x28: ffff80001290bde0 x27: 000000000000001b
 x26: fffffc000330d7c0 x25: ffff0000caa56d68 x24: ffff0000ca9fb1c0
 x23: 0000000000000080 x22: ffff0000ca9fb130 x21: 0000000000000160
 x20: ffff0000c91e10b8 x19: 0000000000000160 x18: 00000000000000c0
 x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c3e63500
 x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c3e63500
 x11: ff808000095d1a0c x10: 0000000000000000 x9 : 0000000000000000
 x8 : 0000000000000000 x7 : ffff80000856806c x6 : 0000000000000000
 x5 : 0000000000000080 x4 : 0000000000000000 x3 : 0000000000000000
 x2 : 0000000000000000 x1 : ffff80000cb431b1 x0 : 0000000000000000
 Call trace:
  lock_page+0x28/0x1e0 include/linux/pagemap.h:956
  nilfs_segctor_prepare_write+0x6c/0x21c fs/nilfs2/segment.c:1658
  nilfs_segctor_do_construct+0x9f4/0xee8 fs/nilfs2/segment.c:2068
  nilfs_segctor_construct+0xa0/0x380 fs/nilfs2/segment.c:2375
  nilfs_segctor_thread_construct fs/nilfs2/segment.c:2483 [inline]
  nilfs_segctor_thread+0x180/0x660 fs/nilfs2/segment.c:2566
  kthread+0x12c/0x158 kernel/kthread.c:376
  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

If didn't call nilfs_sufile_alloc() in nilfs_segctor_begin_construction(),
nilfs_sufile_header's sh_last_alloc is not updated. In such case, we will
add a bh in two segbuf->sb_segsum_buffers. And finally cause list error.

Reported-by: syzbot+77e4f005cb899d4268d1@syzkaller.appspotmail.com
Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 fs/nilfs2/segment.c | 1 +
 fs/nilfs2/sufile.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index b4cebad21b48..7be632c15f91 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1371,6 +1371,7 @@ static int nilfs_segctor_extend_segments(struct nilfs_sc_info *sci,
 		sci->sc_segbuf_nblocks += segbuf->sb_rest_blocks;
 
 		/* allocate the next next full segment */
+		nextnextnum = segbuf->sb_segnum;
 		err = nilfs_sufile_alloc(sufile, &nextnextnum);
 		if (unlikely(err))
 			goto failed_segbuf;
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index 77ff8e95421f..853a8212114f 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -317,7 +317,7 @@ int nilfs_sufile_alloc(struct inode *sufile, __u64 *segnump)
 		goto out_sem;
 	kaddr = kmap_atomic(header_bh->b_page);
 	header = kaddr + bh_offset(header_bh);
-	last_alloc = le64_to_cpu(header->sh_last_alloc);
+	last_alloc = max(le64_to_cpu(header->sh_last_alloc), *segnump);
 	kunmap_atomic(kaddr);
 
 	nsegments = nilfs_sufile_get_nsegments(sufile);
-- 
2.25.1


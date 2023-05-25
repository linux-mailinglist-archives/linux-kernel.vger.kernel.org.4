Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0857102E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 04:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjEYC3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 22:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjEYC3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 22:29:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0601199
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 19:28:14 -0700 (PDT)
Received: from dggpeml500011.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QRX0G3qb3zTktT;
        Thu, 25 May 2023 10:23:10 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpeml500011.china.huawei.com
 (7.185.36.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 25 May
 2023 10:28:09 +0800
From:   Tu Jinjiang <tujinjiang@huawei.com>
To:     <hughd@google.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH] mm: shmem: Fix UAF bug in shmem_show_options()
Date:   Thu, 25 May 2023 11:16:40 +0800
Message-ID: <20230525031640.593733-1-tujinjiang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500011.china.huawei.com (7.185.36.84)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shmem_show_options() uses sbinfo->mpol without adding it's refcnt. This
may lead to race with replacement of the mpol by remount. The execution
sequence is as follows.

       CPU0                                   CPU1
shmem_show_options()                        shmem_reconfigure()
    shmem_show_mpol(seq, sbinfo->mpol)          mpol = sbinfo->mpol
                                                mpol_put(mpol)
        mpol->mode

The KASAN report is as follows.

BUG: KASAN: slab-use-after-free in shmem_show_options+0x21b/0x340
Read of size 2 at addr ffff888124324004 by task mount/2388

CPU: 2 PID: 2388 Comm: mount Not tainted 6.4.0-rc3-00017-g9d646009f65d-dirty #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x37/0x50
 print_report+0xd0/0x620
 ? shmem_show_options+0x21b/0x340
 ? __virt_addr_valid+0xf4/0x180
 ? shmem_show_options+0x21b/0x340
 kasan_report+0xb8/0xe0
 ? shmem_show_options+0x21b/0x340
 shmem_show_options+0x21b/0x340
 ? __pfx_shmem_show_options+0x10/0x10
 ? strchr+0x2c/0x50
 ? strlen+0x23/0x40
 ? seq_puts+0x7d/0x90
 show_vfsmnt+0x1e6/0x260
 ? __pfx_show_vfsmnt+0x10/0x10
 ? __kasan_kmalloc+0x7f/0x90
 seq_read_iter+0x57a/0x740
 vfs_read+0x2e2/0x4a0
 ? __pfx_vfs_read+0x10/0x10
 ? down_write_killable+0xb8/0x140
 ? __pfx_down_write_killable+0x10/0x10
 ? __fget_light+0xa9/0x1e0
 ? up_write+0x3f/0x80
 ksys_read+0xb8/0x150
 ? __pfx_ksys_read+0x10/0x10
 ? fpregs_assert_state_consistent+0x55/0x60
 ? exit_to_user_mode_prepare+0x2d/0x120
 do_syscall_64+0x3c/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

 </TASK>

Allocated by task 2387:
 kasan_save_stack+0x22/0x50
 kasan_set_track+0x25/0x30
 __kasan_slab_alloc+0x59/0x70
 kmem_cache_alloc+0xdd/0x220
 mpol_new+0x83/0x150
 mpol_parse_str+0x280/0x4a0
 shmem_parse_one+0x364/0x520
 vfs_parse_fs_param+0xf8/0x1a0
 vfs_parse_fs_string+0xc9/0x130
 shmem_parse_options+0xb2/0x110
 path_mount+0x597/0xdf0
 do_mount+0xcd/0xf0
 __x64_sys_mount+0xbd/0x100
 do_syscall_64+0x3c/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

Freed by task 2389:
 kasan_save_stack+0x22/0x50
 kasan_set_track+0x25/0x30
 kasan_save_free_info+0x2e/0x50
 __kasan_slab_free+0x10e/0x1a0
 kmem_cache_free+0x9c/0x350
 shmem_reconfigure+0x278/0x370
 reconfigure_super+0x383/0x450
 path_mount+0xcc5/0xdf0
 do_mount+0xcd/0xf0
 __x64_sys_mount+0xbd/0x100
 do_syscall_64+0x3c/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

The buggy address belongs to the object at ffff888124324000
 which belongs to the cache numa_policy of size 32
The buggy address is located 4 bytes inside of
 freed 32-byte region [ffff888124324000, ffff888124324020)
==================================================================

To fix the bug, shmem_get_sbmpol() / mpol_put() needs to be called
before / after shmem_show_mpol() call.

Signed-off-by: Tu Jinjiang <tujinjiang@huawei.com>
---
 mm/shmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index e40a08c5c6d7..5e54ab5f61f2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3726,6 +3726,7 @@ static int shmem_reconfigure(struct fs_context *fc)
 static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(root->d_sb);
+	struct mempolicy *mpol;
 
 	if (sbinfo->max_blocks != shmem_default_max_blocks())
 		seq_printf(seq, ",size=%luk",
@@ -3768,7 +3769,9 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 	if (sbinfo->huge)
 		seq_printf(seq, ",huge=%s", shmem_format_huge(sbinfo->huge));
 #endif
-	shmem_show_mpol(seq, sbinfo->mpol);
+	mpol = shmem_get_sbmpol(sbinfo);
+	shmem_show_mpol(seq, mpol);
+	mpol_put(mpol);
 	if (sbinfo->noswap)
 		seq_printf(seq, ",noswap");
 	return 0;
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1A7628F7B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 02:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiKOBrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 20:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiKOBrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:47:14 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0292E2DCD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 17:47:13 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NB8DX2BLdz15Mdj;
        Tue, 15 Nov 2022 09:46:52 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 09:47:11 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <willy@infradead.org>, <akpm@linux-foundation.org>,
        <damien.lemoal@opensource.wdc.com>, <roman.gushchin@linux.dev>,
        <tytso@mit.edu>, <songmuchun@bytedance.com>, <qhjin.dev@gmail.com>,
        <liaochang1@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] fs: Fix UBSAN detected shift-out-bounds error for bad superblock
Date:   Tue, 15 Nov 2022 09:44:04 +0800
Message-ID: <20221115014404.194531-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBSAN: shift-out-of-bounds in fs/minix/bitmap.c:103:3
shift exponent 8192 is too large for 32-bit type 'unsigned int'
CPU: 1 PID: 32273 Comm: syz-executor.0 Tainted: G        W
6.1.0-rc4-dirty #11
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xcd/0x134
 ubsan_epilogue+0xb/0x50
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x18d
 minix_count_free_blocks.cold+0x16/0x1b
 minix_statfs+0x22a/0x490
 statfs_by_dentry+0x133/0x210
 user_statfs+0xa9/0x160
 __do_sys_statfs+0x7a/0xf0
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The superblock stores on disk contains the size of a data zone, which is
too large to used as the shift when kernel try to calculate the total
size of zones, so it needs to check the superblock when kernel mounts
MINIX-FS.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
v2:
1. Use compiler neutral API to calculate leading zeros count.
2. A invalid s_log_zone_size should be greater than the leading zeros
   count of (s_nzone - s_firstdatazone).

---
 fs/minix/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index da8bdd1712a7..fbfe2021ef50 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -19,6 +19,7 @@
 #include <linux/highuid.h>
 #include <linux/vfs.h>
 #include <linux/writeback.h>
+#include <linux/count_zeros.h>
 
 static int minix_write_inode(struct inode *inode,
 		struct writeback_control *wbc);
@@ -166,6 +167,12 @@ static bool minix_check_superblock(struct super_block *sb)
 	    sb->s_maxbytes > (7 + 512 + 512*512) * BLOCK_SIZE)
 		return false;
 
+	/* the total size of zones must not exceed the limitation of U32_MAX. */
+	if (sbi->s_log_zone_size && (sbi->s_nzones - sbi->s_firstdatazone) &&
+	    (count_leading_zeros(sbi->s_nzones - sbi->s_firstdatazone) <
+	     sbi->s_log_zone_size))
+		return false;
+
 	return true;
 }
 
-- 
2.17.1


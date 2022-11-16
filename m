Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E7462B09F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 02:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiKPBjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 20:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiKPBjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 20:39:11 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BB11EEEA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 17:39:09 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NBm0k1fvlz15Mgd;
        Wed, 16 Nov 2022 09:38:46 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 09:39:07 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <shaggy@kernel.org>
CC:     <jfs-discussion@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <liaochang1@huawei.com>
Subject: [PATCH] jfs: Fix  shift-out-of-bounds in jfs_statfs
Date:   Wed, 16 Nov 2022 09:36:00 +0800
Message-ID: <20221116013600.77906-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller report issue as follows:

UBSAN: shift-out-of-bounds in fs/jfs/super.c:140:14
shift exponent -236023038 is negative
CPU: 0 PID: 3985 Comm: syz-executor.4 Not tainted 6.1.0-rc2-syzkaller #0
Hardware name: Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
 jfs_statfs+0x503/0x510 fs/jfs/super.c:140
 statfs_by_dentry fs/statfs.c:66
 vfs_statfs+0x136/0x310 fs/statfs.c:90
 user_statfs fs/statfs.c:105
__ubsan_handle_shift_out_of_bounds __do_sys_statfs fs/statfs.c:195
 __se_sys_statfs fs/statfs.c:192
 __x64_sys_statfs+0x120/0x230 fs/statfs.c:192
 do_syscall_x64 arch/x86/entry/common.c:50
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
 </TASK>

The on-disk inode map control structure contains a number indicates the
log2 number of blocks per inode extent, which will be used as the shift
to calculate the number of free blocks in jfs_statfs, so it needs to
ensure the on-disk log2 number is positive and less than 64 on JFS
mount.

Reported-by: syzbot+3424c9550a49659f1704@syzkaller.appspotmail.com
Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 fs/jfs/jfs_imap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 799d3837e7c2..1ff632c55acf 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -124,6 +124,12 @@ int diMount(struct inode *ipimap)
 	atomic_set(&imap->im_numfree, le32_to_cpu(dinom_le->in_numfree));
 	imap->im_nbperiext = le32_to_cpu(dinom_le->in_nbperiext);
 	imap->im_l2nbperiext = le32_to_cpu(dinom_le->in_l2nbperiext);
+	if (imap->im_l2nbperiext < 0 ||
+	    imap->im_l2nbperiext >= sizeof(s64) * 8) {
+		kfree(imap);
+		return -EINVAL;
+	}
+
 	for (index = 0; index < MAXAG; index++) {
 		imap->im_agctl[index].inofree =
 		    le32_to_cpu(dinom_le->in_agctl[index].inofree);
-- 
2.17.1


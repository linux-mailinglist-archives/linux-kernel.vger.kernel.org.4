Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF2E628FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiKOCdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiKOCdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:33:20 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC612FD27
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:33:18 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NB9Fl4N0kzRpDv;
        Tue, 15 Nov 2022 10:32:59 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 10:33:16 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <shaggy@kernel.org>
CC:     <jfs-discussion@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <liaochang1@huawei.com>
Subject: [PATCH] jfs: Fix out-of-bounds access on dtSearch
Date:   Tue, 15 Nov 2022 10:30:09 +0800
Message-ID: <20221115023009.251044-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG: KASAN: slab-out-of-bounds in dtSearch+0x1d92/0x2000
Read of size 1 at addr ffff888134497f94 by task syz-executor.2/8793

CPU: 0 PID: 8793 Comm: syz-executor.2 Tainted: G        W
6.0.0-07994-ge8bc52cb8df8 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xcd/0x134
 print_report.cold+0x2ba/0x719
 kasan_report+0xb1/0x1e0
 dtSearch+0x1d92/0x2000
 jfs_lookup+0x17c/0x2f0
 __lookup_slow+0x24c/0x460
 walk_component+0x33f/0x5a0
 link_path_walk.part.0.constprop.0+0x715/0xd80
 path_lookupat+0x92/0x760
 filename_lookup+0x1d2/0x590
 user_path_at_empty+0x42/0x60
 __x64_sys_chdir+0xb7/0x260
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The out-of-bounds access occurs in macro ciToUpper, which converts the
unicode character in ciKey.name into uppercase, this upper operation
will stop when it meets a terminal character(digit 0), so it needs to
set the last character to zero to ensure upper can stop in valid range.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 fs/jfs/jfs_dtree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 92b7c533407c..0c3af64abcfd 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -592,6 +592,7 @@ int dtSearch(struct inode *ip, struct component_name * key, ino_t * data,
 	/* uppercase search key for c-i directory */
 	UniStrcpy(ciKey.name, key->name);
 	ciKey.namlen = key->namlen;
+	ciKey.name[ciKey.namlen] = 0;
 
 	/* only uppercase if case-insensitive support is on */
 	if ((JFS_SBI(sb)->mntflag & JFS_OS2) == JFS_OS2) {
-- 
2.17.1


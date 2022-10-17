Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808C5600579
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 04:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiJQCx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 22:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiJQCxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 22:53:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBC647B80;
        Sun, 16 Oct 2022 19:53:23 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MrLzM5gq7zVjDc;
        Mon, 17 Oct 2022 10:48:47 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 10:53:20 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <bfoster@redhat.com>, <cmaiolino@redhat.com>, <djwong@kernel.org>
CC:     <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>
Subject: [PATCH] xfs: fix memory leak in xfs_errortag_init
Date:   Mon, 17 Oct 2022 10:51:55 +0800
Message-ID: <20221017025155.1810277-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When `xfs_sysfs_init` returns failed, `mp->m_errortag` needs to free.
Otherwise kmemleak would report memory leak after mounting xfs image:

unreferenced object 0xffff888101364900 (size 192):
  comm "mount", pid 13099, jiffies 4294915218 (age 335.207s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000f08ad25c>] __kmalloc+0x41/0x1b0
    [<00000000dca9aeb6>] kmem_alloc+0xfd/0x430
    [<0000000040361882>] xfs_errortag_init+0x20/0x110
    [<00000000b384a0f6>] xfs_mountfs+0x6ea/0x1a30
    [<000000003774395d>] xfs_fs_fill_super+0xe10/0x1a80
    [<000000009cf07b6c>] get_tree_bdev+0x3e7/0x700
    [<00000000046b5426>] vfs_get_tree+0x8e/0x2e0
    [<00000000952ec082>] path_mount+0xf8c/0x1990
    [<00000000beb1f838>] do_mount+0xee/0x110
    [<000000000e9c41bb>] __x64_sys_mount+0x14b/0x1f0
    [<00000000f7bb938e>] do_syscall_64+0x3b/0x90
    [<000000003fcd67a9>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: c68401011522 ("xfs: expose errortag knobs via sysfs")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 fs/xfs/xfs_error.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
index 296faa41d81d..f417320ef9c0 100644
--- a/fs/xfs/xfs_error.c
+++ b/fs/xfs/xfs_error.c
@@ -234,13 +234,18 @@ int
 xfs_errortag_init(
 	struct xfs_mount	*mp)
 {
+	int ret;
+
 	mp->m_errortag = kmem_zalloc(sizeof(unsigned int) * XFS_ERRTAG_MAX,
 			KM_MAYFAIL);
 	if (!mp->m_errortag)
 		return -ENOMEM;
 
-	return xfs_sysfs_init(&mp->m_errortag_kobj, &xfs_errortag_ktype,
-			       &mp->m_kobj, "errortag");
+	ret = xfs_sysfs_init(&mp->m_errortag_kobj, &xfs_errortag_ktype,
+				&mp->m_kobj, "errortag");
+	if (ret)
+		kmem_free(mp->m_errortag);
+	return ret;
 }
 
 void
-- 
2.25.1


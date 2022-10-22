Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B284608C82
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiJVLVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiJVLU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:20:58 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E347EA9C8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 03:48:59 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MvdKz0PMgzJn3b;
        Sat, 22 Oct 2022 18:46:15 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 22 Oct
 2022 18:48:56 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <richard@nod.at>, <Artem.Bityutskiy@nokia.com>,
        <ext-adrian.hunter@nokia.com>
CC:     <lizetao1@huawei.com>, <yi.zhang@huawei.com>,
        <chengzhihao1@huawei.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ubifs: Fix memory leak in alloc_wbufs()
Date:   Sat, 22 Oct 2022 19:52:11 +0800
Message-ID: <20221022115211.1969429-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
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

kmemleak reported a sequence of memory leaks, and show them as following:

  unreferenced object 0xffff8881575f8400 (size 1024):
    comm "mount", pid 19625, jiffies 4297119604 (age 20.383s)
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    backtrace:
      [<ffffffff8176cecd>] __kmalloc+0x4d/0x150
      [<ffffffffa0406b2b>] ubifs_mount+0x307b/0x7170 [ubifs]
      [<ffffffff819fa8fd>] legacy_get_tree+0xed/0x1d0
      [<ffffffff81936f2d>] vfs_get_tree+0x7d/0x230
      [<ffffffff819b2bd4>] path_mount+0xdd4/0x17b0
      [<ffffffff819b37aa>] __x64_sys_mount+0x1fa/0x270
      [<ffffffff83c14295>] do_syscall_64+0x35/0x80
      [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

  unreferenced object 0xffff8881798a6e00 (size 512):
    comm "mount", pid 19677, jiffies 4297121912 (age 37.816s)
    hex dump (first 32 bytes):
      6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
      6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
    backtrace:
      [<ffffffff8176cecd>] __kmalloc+0x4d/0x150
      [<ffffffffa0418342>] ubifs_wbuf_init+0x52/0x480 [ubifs]
      [<ffffffffa0406ca5>] ubifs_mount+0x31f5/0x7170 [ubifs]
      [<ffffffff819fa8fd>] legacy_get_tree+0xed/0x1d0
      [<ffffffff81936f2d>] vfs_get_tree+0x7d/0x230
      [<ffffffff819b2bd4>] path_mount+0xdd4/0x17b0
      [<ffffffff819b37aa>] __x64_sys_mount+0x1fa/0x270
      [<ffffffff83c14295>] do_syscall_64+0x35/0x80
      [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

The problem is that the ubifs_wbuf_init() returns an error in the
loop which in the alloc_wbufs(), then the wbuf->buf and wbuf->inodes
that were successfully alloced before are not freed.

Fix it by adding error hanging path in alloc_wbufs() which frees
the memory alloced before when ubifs_wbuf_init() returns an error.

Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/ubifs/super.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index d0c9a09988bc..32cb14759796 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -833,7 +833,7 @@ static int alloc_wbufs(struct ubifs_info *c)
 		INIT_LIST_HEAD(&c->jheads[i].buds_list);
 		err = ubifs_wbuf_init(c, &c->jheads[i].wbuf);
 		if (err)
-			return err;
+			goto out_wbuf;
 
 		c->jheads[i].wbuf.sync_callback = &bud_wbuf_callback;
 		c->jheads[i].wbuf.jhead = i;
@@ -841,7 +841,7 @@ static int alloc_wbufs(struct ubifs_info *c)
 		c->jheads[i].log_hash = ubifs_hash_get_desc(c);
 		if (IS_ERR(c->jheads[i].log_hash)) {
 			err = PTR_ERR(c->jheads[i].log_hash);
-			goto out;
+			goto out_log_hash;
 		}
 	}
 
@@ -854,9 +854,18 @@ static int alloc_wbufs(struct ubifs_info *c)
 
 	return 0;
 
-out:
-	while (i--)
+out_log_hash:
+	kfree(c->jheads[i].wbuf.buf);
+	kfree(c->jheads[i].wbuf.inodes);
+
+out_wbuf:
+	while (i--) {
+		kfree(c->jheads[i].wbuf.buf);
+		kfree(c->jheads[i].wbuf.inodes);
 		kfree(c->jheads[i].log_hash);
+	}
+	kfree(c->jheads);
+	c->jheads = NULL;
 
 	return err;
 }
-- 
2.31.1


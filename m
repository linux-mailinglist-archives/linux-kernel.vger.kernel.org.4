Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5688562829D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbiKNOcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbiKNOcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:32:18 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB8028E3E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:32:17 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N9sFk6yHsz15M0R;
        Mon, 14 Nov 2022 22:31:54 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 22:32:14 +0800
Received: from huawei.com (10.175.101.6) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 14 Nov
 2022 22:32:13 +0800
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <patchwork@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>,
        <yi.zhang@huawei.com>, <miaoxie@huawei.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>,
        <yuehaibing@huawei.com>, <johnny.chenyi@huawei.com>,
        <weiyongjun1@huawei.com>
Subject: [PATCH -next] ubi: Fix permission display of the debugfs files
Date:   Mon, 14 Nov 2022 22:46:46 +0800
Message-ID: <20221114144646.3828749-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some interface files in debugfs support the read method
dfs_file_read(), but their rwx permissions is shown as
unreadable.

In the user mode, the following problem can be clearly seen:

 # ls -l /sys/kernel/debug/ubi/ubi0/
 total 0
 --w------- 1 root root 0 Oct 22 16:26 chk_fastmap
 --w------- 1 root root 0 Oct 22 16:26 chk_gen
 --w------- 1 root root 0 Oct 22 16:26 chk_io
 -r-------- 1 root root 0 Oct 22 16:26 detailed_erase_block_info
 --w------- 1 root root 0 Oct 22 16:26 tst_disable_bgt
 --w------- 1 root root 0 Oct 22 16:26 tst_emulate_bitflips
 --w------- 1 root root 0 Oct 22 16:26 tst_emulate_io_failures
 --w------- 1 root root 0 Oct 22 16:26 tst_emulate_power_cut
 --w------- 1 root root 0 Oct 22 16:26 tst_emulate_power_cut_max
 --w------- 1 root root 0 Oct 22 16:26 tst_emulate_power_cut_min

It shows that these files do not have read permission 'r',
but we can actually read their contents.

 # echo 1 > /sys/kernel/debug/ubi/ubi0/chk_io
 # cat /sys/kernel/debug/ubi/ubi0/chk_io
 1

User's permission access is determined by capabilities.
Of course, the root user is not restricted from reading
these files.

When reading a debugfs file, the process is as follows:

 ksys_read()
   vfs_read()
     if (file->f_op->read)
       file->f_op->read()
         full_proxy_open()
           real_fops->read()
             dfs_file_read() -- Read method of debugfs file.
     else if (file->f_op->read_iter)
       new_sync_read()
     else
       ret = -EINVAL -- Return -EINVAL if no read method.

This indicates that the debugfs file can be read as long as the read
method of the debugfs file is registered. This patch adds the read
permission display for file that support the read method.

Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
---
 drivers/mtd/ubi/debug.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index 908d0e088557..552b765af810 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -504,6 +504,7 @@ int ubi_debugfs_init_dev(struct ubi_device *ubi)
 {
 	unsigned long ubi_num = ubi->ubi_num;
 	struct ubi_debug_info *d = &ubi->dbg;
+	umode_t mode = S_IRUSR | S_IWUSR;
 	int n;
 
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
@@ -518,41 +519,41 @@ int ubi_debugfs_init_dev(struct ubi_device *ubi)
 
 	d->dfs_dir = debugfs_create_dir(d->dfs_dir_name, dfs_rootdir);
 
-	d->dfs_chk_gen = debugfs_create_file("chk_gen", S_IWUSR, d->dfs_dir,
+	d->dfs_chk_gen = debugfs_create_file("chk_gen", mode, d->dfs_dir,
 					     (void *)ubi_num, &dfs_fops);
 
-	d->dfs_chk_io = debugfs_create_file("chk_io", S_IWUSR, d->dfs_dir,
+	d->dfs_chk_io = debugfs_create_file("chk_io", mode, d->dfs_dir,
 					    (void *)ubi_num, &dfs_fops);
 
-	d->dfs_chk_fastmap = debugfs_create_file("chk_fastmap", S_IWUSR,
+	d->dfs_chk_fastmap = debugfs_create_file("chk_fastmap", mode,
 						 d->dfs_dir, (void *)ubi_num,
 						 &dfs_fops);
 
-	d->dfs_disable_bgt = debugfs_create_file("tst_disable_bgt", S_IWUSR,
+	d->dfs_disable_bgt = debugfs_create_file("tst_disable_bgt", mode,
 						 d->dfs_dir, (void *)ubi_num,
 						 &dfs_fops);
 
 	d->dfs_emulate_bitflips = debugfs_create_file("tst_emulate_bitflips",
-						      S_IWUSR, d->dfs_dir,
+						      mode, d->dfs_dir,
 						      (void *)ubi_num,
 						      &dfs_fops);
 
 	d->dfs_emulate_io_failures = debugfs_create_file("tst_emulate_io_failures",
-							 S_IWUSR, d->dfs_dir,
+							 mode, d->dfs_dir,
 							 (void *)ubi_num,
 							 &dfs_fops);
 
 	d->dfs_emulate_power_cut = debugfs_create_file("tst_emulate_power_cut",
-						       S_IWUSR, d->dfs_dir,
+						       mode, d->dfs_dir,
 						       (void *)ubi_num,
 						       &dfs_fops);
 
 	d->dfs_power_cut_min = debugfs_create_file("tst_emulate_power_cut_min",
-						   S_IWUSR, d->dfs_dir,
+						   mode, d->dfs_dir,
 						   (void *)ubi_num, &dfs_fops);
 
 	d->dfs_power_cut_max = debugfs_create_file("tst_emulate_power_cut_max",
-						   S_IWUSR, d->dfs_dir,
+						   mode, d->dfs_dir,
 						   (void *)ubi_num, &dfs_fops);
 
 	debugfs_create_file("detailed_erase_block_info", S_IRUSR, d->dfs_dir,
-- 
2.31.1


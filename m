Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E6F6873DA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjBBDcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjBBDcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:32:32 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEC335BF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:32:31 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P6kqh69FBzfYwr;
        Thu,  2 Feb 2023 11:32:16 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 2 Feb 2023 11:32:26 +0800
From:   Longlong Xia <xialonglong1@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenwandun@huawei.com>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, Longlong Xia <xialonglong1@huawei.com>
Subject: [PATCH -next 1/3] devtmpfs: convert to pr_fmt
Date:   Thu, 2 Feb 2023 03:32:01 +0000
Message-ID: <20230202033203.1239239-2-xialonglong1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202033203.1239239-1-xialonglong1@huawei.com>
References: <20230202033203.1239239-1-xialonglong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the pr_fmt() macro to prefix all the output with "devtmpfs: ".
while at it, convert printk(<LEVEL>) to pr_<level>().

Signed-off-by: Longlong Xia <xialonglong1@huawei.com>
---
 drivers/base/devtmpfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 03e8a95f1f35..ae72d4ba8547 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -13,6 +13,8 @@
  * overwrite the default setting if needed.
  */
 
+#define pr_fmt(fmt) "devtmpfs: " fmt
+
 #include <linux/kernel.h>
 #include <linux/syscalls.h>
 #include <linux/mount.h>
@@ -376,9 +378,9 @@ int __init devtmpfs_mount(void)
 
 	err = init_mount("devtmpfs", "dev", "devtmpfs", DEVTMPFS_MFLAGS, NULL);
 	if (err)
-		printk(KERN_INFO "devtmpfs: error mounting %i\n", err);
+		pr_info("error mounting %d\n", err);
 	else
-		printk(KERN_INFO "devtmpfs: mounted\n");
+		pr_info("mounted\n");
 	return err;
 }
 
@@ -460,14 +462,12 @@ int __init devtmpfs_init(void)
 
 	mnt = vfs_kern_mount(&internal_fs_type, 0, "devtmpfs", opts);
 	if (IS_ERR(mnt)) {
-		printk(KERN_ERR "devtmpfs: unable to create devtmpfs %ld\n",
-				PTR_ERR(mnt));
+		pr_err("unable to create devtmpfs %ld\n", PTR_ERR(mnt));
 		return PTR_ERR(mnt);
 	}
 	err = register_filesystem(&dev_fs_type);
 	if (err) {
-		printk(KERN_ERR "devtmpfs: unable to register devtmpfs "
-		       "type %i\n", err);
+		pr_err("unable to register devtmpfs type %d\n", err);
 		return err;
 	}
 
@@ -480,12 +480,12 @@ int __init devtmpfs_init(void)
 	}
 
 	if (err) {
-		printk(KERN_ERR "devtmpfs: unable to create devtmpfs %i\n", err);
+		pr_err("unable to create devtmpfs %d\n", err);
 		unregister_filesystem(&dev_fs_type);
 		thread = NULL;
 		return err;
 	}
 
-	printk(KERN_INFO "devtmpfs: initialized\n");
+	pr_info("initialized\n");
 	return 0;
 }
-- 
2.25.1


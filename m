Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D3E62B08D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 02:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiKPB3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 20:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiKPB3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 20:29:04 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A4ADEB7;
        Tue, 15 Nov 2022 17:29:03 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NBlmt6qSQzHvrV;
        Wed, 16 Nov 2022 09:28:30 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 09:29:01 +0800
Received: from mdc.huawei.com (10.175.112.208) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 09:29:00 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <haokexin@gmail.com>
CC:     <xuqiang36@huawei.com>
Subject: [PATCH] watchdog: Fix kmemleak in watchdog_cdev_register
Date:   Wed, 16 Nov 2022 01:27:14 +0000
Message-ID: <20221116012714.102066-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak reports memory leaks in watchdog_dev_register, as follows:
unreferenced object 0xffff888116233000 (size 2048):
  comm ""modprobe"", pid 28147, jiffies 4353426116 (age 61.741s)
  hex dump (first 32 bytes):
    80 fa b9 05 81 88 ff ff 08 30 23 16 81 88 ff ff  .........0#.....
    08 30 23 16 81 88 ff ff 00 00 00 00 00 00 00 00  .0#.............
  backtrace:
    [<000000007f001ffd>] __kmem_cache_alloc_node+0x157/0x220
    [<000000006a389304>] kmalloc_trace+0x21/0x110
    [<000000008d640eea>] watchdog_dev_register+0x4e/0x780 [watchdog]
    [<0000000053c9f248>] __watchdog_register_device+0x4f0/0x680 [watchdog]
    [<00000000b2979824>] watchdog_register_device+0xd2/0x110 [watchdog]
    [<000000001f730178>] 0xffffffffc10880ae
    [<000000007a1a8bcc>] do_one_initcall+0xcb/0x4d0
    [<00000000b98be325>] do_init_module+0x1ca/0x5f0
    [<0000000046d08e7c>] load_module+0x6133/0x70f0
    ...

unreferenced object 0xffff888105b9fa80 (size 16):
  comm ""modprobe"", pid 28147, jiffies 4353426116 (age 61.741s)
  hex dump (first 16 bytes):
    77 61 74 63 68 64 6f 67 31 00 b9 05 81 88 ff ff  watchdog1.......
  backtrace:
    [<000000007f001ffd>] __kmem_cache_alloc_node+0x157/0x220
    [<00000000486ab89b>] __kmalloc_node_track_caller+0x44/0x1b0
    [<000000005a39aab0>] kvasprintf+0xb5/0x140
    [<0000000024806f85>] kvasprintf_const+0x55/0x180
    [<000000009276cb7f>] kobject_set_name_vargs+0x56/0x150
    [<00000000a92e820b>] dev_set_name+0xab/0xe0
    [<00000000cec812c6>] watchdog_dev_register+0x285/0x780 [watchdog]
    [<0000000053c9f248>] __watchdog_register_device+0x4f0/0x680 [watchdog]
    [<00000000b2979824>] watchdog_register_device+0xd2/0x110 [watchdog]
    [<000000001f730178>] 0xffffffffc10880ae
    [<000000007a1a8bcc>] do_one_initcall+0xcb/0x4d0
    [<00000000b98be325>] do_init_module+0x1ca/0x5f0
    [<0000000046d08e7c>] load_module+0x6133/0x70f0
    ...

The reason is that put_device is not be called if cdev_device_add fails
and wdd->id != 0.

watchdog_cdev_register
  wd_data = kzalloc                             [1]
  err = dev_set_name                            [2]
  ..
  err = cdev_device_add
  if (err) {
    if (wdd->id == 0) {  // wdd->id != 0
      ..
    }
    return err;  // [1],[2] would be leaked

To fix it, call put_device in all wdd->id cases.

Fixes: 72139dfa2464 ("watchdog: Fix the race between the release of watchdog_core_data and cdev")
Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 drivers/watchdog/watchdog_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 55574ed42504..fdffa6859dde 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1061,8 +1061,8 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 		if (wdd->id == 0) {
 			misc_deregister(&watchdog_miscdev);
 			old_wd_data = NULL;
-			put_device(&wd_data->dev);
 		}
+		put_device(&wd_data->dev);
 		return err;
 	}
 
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F11630B9F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 04:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiKSD5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 22:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiKSD4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 22:56:46 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469D9C604B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:51:47 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NDfn263YyzHvTV;
        Sat, 19 Nov 2022 11:50:14 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 19 Nov
 2022 11:50:47 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <mcgrof@kernel.org>, <russell.h.weight@intel.com>,
        <tianfei.zhang@intel.com>, <error27@gmail.com>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <shaozhengchao@huawei.com>
Subject: [PATCH] test_firmware: fix memory leak in test_firmware_init()
Date:   Sat, 19 Nov 2022 11:57:21 +0800
Message-ID: <20221119035721.18268-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When misc_register() failed in test_firmware_init(), the memory pointed
by test_fw_config->name is not released. The memory leak information is
as follows:
unreferenced object 0xffff88810a34cb00 (size 32):
  comm "insmod", pid 7952, jiffies 4294948236 (age 49.060s)
  hex dump (first 32 bytes):
    74 65 73 74 2d 66 69 72 6d 77 61 72 65 2e 62 69  test-firmware.bi
    6e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  n...............
  backtrace:
    [<ffffffff81b21fcb>] __kmalloc_node_track_caller+0x4b/0xc0
    [<ffffffff81affb96>] kstrndup+0x46/0xc0
    [<ffffffffa0403a49>] __test_firmware_config_init+0x29/0x380 [test_firmware]
    [<ffffffffa040f068>] 0xffffffffa040f068
    [<ffffffff81002c41>] do_one_initcall+0x141/0x780
    [<ffffffff816a72c3>] do_init_module+0x1c3/0x630
    [<ffffffff816adb9e>] load_module+0x623e/0x76a0
    [<ffffffff816af471>] __do_sys_finit_module+0x181/0x240
    [<ffffffff89978f99>] do_syscall_64+0x39/0xb0
    [<ffffffff89a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: c92316bf8e94 ("test_firmware: add batched firmware tests")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 lib/test_firmware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index c82b65947ce6..1c5a2adb16ef 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -1491,6 +1491,7 @@ static int __init test_firmware_init(void)
 
 	rc = misc_register(&test_fw_misc_device);
 	if (rc) {
+		__test_firmware_config_free();
 		kfree(test_fw_config);
 		pr_err("could not register misc device: %d\n", rc);
 		return rc;
-- 
2.17.1


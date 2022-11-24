Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28713637194
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 05:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiKXEuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 23:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiKXEuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 23:50:04 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20121C8443
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 20:50:02 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NHlry4KdjzHw6x;
        Thu, 24 Nov 2022 12:49:22 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 12:49:59 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 24 Nov
 2022 12:49:59 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <myungjoo.ham@samsung.com>, <cw00.choi@samsung.com>
Subject: [PATCH] extcon: fix possible name leak in error case in extcon_dev_register()
Date:   Thu, 24 Nov 2022 12:47:48 +0800
Message-ID: <20221124044748.3378955-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following memory leak report while doing fault injection test:

unreferenced object 0xffff888108cff080 (size 16):
  comm "77-i2c-ptn5150", pid 253, jiffies 4294732125 (age 33.960s)
  hex dump (first 16 bytes):
    65 78 74 63 6f 6e 38 32 00 f0 cf 08 81 88 ff ff  extcon82........
  backtrace:
    [<000000001811fc5c>] __kmalloc_node_track_caller+0x44/0x1b0
    [<000000005bac260d>] kvasprintf+0xb5/0x140
    [<000000000dd1d389>] kvasprintf_const+0x55/0x110
    [<000000000ea8369c>] kobject_set_name_vargs+0x43/0xf0
    [<00000000d89b28c6>] dev_set_name+0xab/0xe0
    [<00000000a55cf990>] extcon_dev_register+0x170/0xea0 [extcon_core]
    [<00000000eb2f186e>] devm_extcon_dev_register+0x48/0xb0 [extcon_core]
    [<0000000077933346>] ptn5150_i2c_probe+0x2f2/0x543 [extcon_ptn5150]

In the error case before device_register(), the name allocated
by dev_set_name() is leaked. Fix this by moving dev_set_name()
to front of device_register(), so it's managed by device core,
and it is freed when the refcount is 0.

Fixes: 806d9dd71ff5 ("Extcon: support multiple states at a device.")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/extcon/extcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index e1c71359b605..f978e5e8e6cf 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1115,8 +1115,6 @@ int extcon_dev_register(struct extcon_dev *edev)
 			"extcon device name is null\n");
 		return -EINVAL;
 	}
-	dev_set_name(&edev->dev, "extcon%lu",
-			(unsigned long)atomic_inc_return(&edev_no));
 
 	if (edev->max_supported) {
 		char *str;
@@ -1252,6 +1250,8 @@ int extcon_dev_register(struct extcon_dev *edev)
 	dev_set_drvdata(&edev->dev, edev);
 	edev->state = 0;
 
+	dev_set_name(&edev->dev, "extcon%lu",
+		     (unsigned long)atomic_inc_return(&edev_no));
 	ret = device_register(&edev->dev);
 	if (ret) {
 		put_device(&edev->dev);
-- 
2.25.1


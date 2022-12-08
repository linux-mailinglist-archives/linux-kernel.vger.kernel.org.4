Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A94647084
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiLHNJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiLHNJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:09:12 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1BB2BB29
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 05:09:11 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NSZGB2xRYz15NBp;
        Thu,  8 Dec 2022 21:08:18 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 8 Dec
 2022 21:09:08 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <lee@kernel.org>, <akpm@linux-foundation.org>,
        <adobriyan@gmail.com>, <linux-kernel@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH v2] mfd: sm501: Fix error handling in sm501_base_init()
Date:   Thu, 8 Dec 2022 13:06:40 +0000
Message-ID: <20221208130640.74125-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A problem about modprobe sm501 failed is triggered with the following log
given:

 [ 4919.196338] Error: Driver 'sm501' is already registered, aborting...
 insmod: ERROR: could not insert module sm501.ko: Device or resource busy

The reason is that sm501_base_init() returns pci_register_driver()
directly without checking its return value, if pci_register_driver()
failed, it returns without unregistering sm501_plat_driver, resulting
the sm501 can never be installed later.
A simple call graph is shown as below:

 sm501_base_init()
   platform_driver_register() # sm501_plat_driver are registered
   pci_register_driver()
     driver_register()
       bus_add_driver()
         priv = kzalloc(...) # OOM happened
   # return without unregister sm501_plat_driver

Fix by calling platform_driver_unregister() when pci_register_driver()
returns error.

Fixes: 158abca5f699 ("mfd: fix sm501 section mismatches")
Signed-off-by: Yuan Can <yuancan@huawei.com>
Acked-for-MFD-by: Lee Jones <lee@kernel.org>
---
Changes in v2:
- Add Lee Jones's acked-by
 drivers/mfd/sm501.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 3ac4508a6742..c1efa040e94e 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1726,7 +1726,13 @@ static int __init sm501_base_init(void)
 	if (ret < 0)
 		return ret;
 
-	return pci_register_driver(&sm501_pci_driver);
+	ret = pci_register_driver(&sm501_pci_driver);
+	if (ret) {
+		platform_driver_unregister(&sm501_plat_driver);
+		return ret;
+	}
+
+	return 0;
 }
 
 static void __exit sm501_base_exit(void)
-- 
2.17.1


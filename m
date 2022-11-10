Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA37623976
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 03:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiKJCD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 21:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiKJCC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 21:02:59 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB3E2935A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 18:02:07 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N74p82bdpz15MWR;
        Thu, 10 Nov 2022 10:01:52 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 10:02:05 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <wsa+renesas@sang-engineering.com>, <benjamin.mugnier@foss.st.com>,
        <dmitry.torokhov@gmail.com>, <cmo@melexis.com>,
        <u.kleine-koenig@pengutronix.de>, <error27@gmail.com>,
        <justinstitt@google.com>, <fancer.lancer@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH] eeprom: idt_89hpesx: Fix error handling in idt_init()
Date:   Thu, 10 Nov 2022 02:00:30 +0000
Message-ID: <20221110020030.47711-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A problem about idt_89hpesx create debugfs failed is triggered with the
following log given:

 [ 4973.269647] debugfs: Directory 'idt_csr' with parent '/' already present!

The reason is that idt_init() returns i2c_add_driver() directly without
checking its return value, if i2c_add_driver() failed, it returns without
destroy the newly created debugfs, resulting the debugfs of idt_csr can
never be created later.

 idt_init()
   debugfs_create_dir() # create debugfs directory
   i2c_add_driver()
     driver_register()
       bus_add_driver()
         priv = kzalloc(...) # OOM happened
   # return without destroy debugfs directory

Fix by removing debugfs when i2c_add_driver() returns error.

Fixes: cfad6425382e ("eeprom: Add IDT 89HPESx EEPROM/CSR driver")
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/misc/eeprom/idt_89hpesx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index bb3ed352b95f..367054e0ced4 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -1566,12 +1566,20 @@ static struct i2c_driver idt_driver = {
  */
 static int __init idt_init(void)
 {
+	int ret;
+
 	/* Create Debugfs directory first */
 	if (debugfs_initialized())
 		csr_dbgdir = debugfs_create_dir("idt_csr", NULL);
 
 	/* Add new i2c-device driver */
-	return i2c_add_driver(&idt_driver);
+	ret = i2c_add_driver(&idt_driver);
+	if (ret) {
+		debugfs_remove_recursive(csr_dbgdir);
+		return ret;
+	}
+
+	return 0;
 }
 module_init(idt_init);
 
-- 
2.17.1


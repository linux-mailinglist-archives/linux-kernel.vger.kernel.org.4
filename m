Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8E567F5E9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjA1ILh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjA1ILg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:11:36 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C25EB6C;
        Sat, 28 Jan 2023 00:11:35 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4P3nGF5V6Lz8QrkZ;
        Sat, 28 Jan 2023 16:11:33 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl2.zte.com.cn with SMTP id 30S8BS95008465;
        Sat, 28 Jan 2023 16:11:28 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Sat, 28 Jan 2023 16:11:30 +0800 (CST)
Date:   Sat, 28 Jan 2023 16:11:30 +0800 (CST)
X-Zmail-TransId: 2af963d4d8b2ffffffffb65b25e5
X-Mailer: Zmail v1.0
Message-ID: <202301281611305841413@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <dmitry.torokhov@gmail.com>
Cc:     <andriy.shevchenko@linux.intel.com>, <jonathan.cameron@huawei.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBJbnB1dDogc3Qta2V5c2NhbiAtIFVzZcKgZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 30S8BS95008465
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63D4D8B5.001 by FangMail milter!
X-FangMail-Envelope: 1674893493/4P3nGF5V6Lz8QrkZ/63D4D8B5.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63D4D8B5.001/4P3nGF5V6Lz8QrkZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/input/keyboard/st-keyscan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
index 13735a5e8391..b6e83324f97a 100644
--- a/drivers/input/keyboard/st-keyscan.c
+++ b/drivers/input/keyboard/st-keyscan.c
@@ -125,7 +125,6 @@ static int keyscan_probe(struct platform_device *pdev)
 {
 	struct st_keyscan *keypad_data;
 	struct input_dev *input_dev;
-	struct resource *res;
 	int error;

 	if (!pdev->dev.of_node) {
@@ -169,8 +168,7 @@ static int keyscan_probe(struct platform_device *pdev)

 	input_set_drvdata(input_dev, keypad_data);

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	keypad_data->base = devm_ioremap_resource(&pdev->dev, res);
+	keypad_data->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(keypad_data->base))
 		return PTR_ERR(keypad_data->base);

-- 
2.25.1

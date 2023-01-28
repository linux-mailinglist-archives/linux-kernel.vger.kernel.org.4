Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AF567F5E7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbjA1IKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjA1IKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:10:06 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D4AEB6C;
        Sat, 28 Jan 2023 00:10:05 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4P3nDW3VKGz501Qx;
        Sat, 28 Jan 2023 16:10:03 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl1.zte.com.cn with SMTP id 30S89t13012534;
        Sat, 28 Jan 2023 16:09:55 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Sat, 28 Jan 2023 16:09:57 +0800 (CST)
Date:   Sat, 28 Jan 2023 16:09:57 +0800 (CST)
X-Zmail-TransId: 2af963d4d855ffffffff98fb0411
X-Mailer: Zmail v1.0
Message-ID: <202301281609576851394@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <dmitry.torokhov@gmail.com>
Cc:     <jonathan.cameron@huawei.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBJbnB1dDogc3BlYXIta2V5Ym9hcmQgLSBVc2XCoGRldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 30S89t13012534
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63D4D85B.001/4P3nDW3VKGz501Qx
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/input/keyboard/spear-keyboard.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 4bb7c533147c..a50fa9915381 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -186,7 +186,6 @@ static int spear_kbd_probe(struct platform_device *pdev)
 	const struct matrix_keymap_data *keymap = pdata ? pdata->keymap : NULL;
 	struct spear_kbd *kbd;
 	struct input_dev *input_dev;
-	struct resource *res;
 	int irq;
 	int error;

@@ -219,8 +218,7 @@ static int spear_kbd_probe(struct platform_device *pdev)
 		kbd->suspended_rate = pdata->suspended_rate;
 	}

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	kbd->io_base = devm_ioremap_resource(&pdev->dev, res);
+	kbd->io_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(kbd->io_base))
 		return PTR_ERR(kbd->io_base);

-- 
2.25.1

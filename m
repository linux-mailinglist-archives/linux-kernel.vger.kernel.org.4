Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E597867F5F5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjA1INO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjA1INK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:13:10 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F0B12F0B;
        Sat, 28 Jan 2023 00:13:09 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4P3nJ41fhzz6FK2S;
        Sat, 28 Jan 2023 16:13:08 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl1.zte.com.cn with SMTP id 30S8D0DP013896;
        Sat, 28 Jan 2023 16:13:00 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Sat, 28 Jan 2023 16:13:03 +0800 (CST)
Date:   Sat, 28 Jan 2023 16:13:03 +0800 (CST)
X-Zmail-TransId: 2af963d4d90f732b41b0
X-Mailer: Zmail v1.0
Message-ID: <202301281613032191431@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <dmitry.torokhov@gmail.com>
Cc:     <ldewangan@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-input@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBJbnB1dDogdGVncmEta2JjIC0gVXNlwqBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 30S8D0DP013896
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63D4D914.000 by FangMail milter!
X-FangMail-Envelope: 1674893588/4P3nJ41fhzz6FK2S/63D4D914.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63D4D914.000/4P3nJ41fhzz6FK2S
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
 drivers/input/keyboard/tegra-kbc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 1eba06bcf27a..da4019cf0c83 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -598,7 +598,6 @@ MODULE_DEVICE_TABLE(of, tegra_kbc_of_match);
 static int tegra_kbc_probe(struct platform_device *pdev)
 {
 	struct tegra_kbc *kbc;
-	struct resource *res;
 	int err;
 	int num_rows = 0;
 	unsigned int debounce_cnt;
@@ -642,8 +641,7 @@ static int tegra_kbc_probe(struct platform_device *pdev)

 	timer_setup(&kbc->timer, tegra_kbc_keypress_timer, 0);

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	kbc->mmio = devm_ioremap_resource(&pdev->dev, res);
+	kbc->mmio = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(kbc->mmio))
 		return PTR_ERR(kbc->mmio);

-- 
2.25.1

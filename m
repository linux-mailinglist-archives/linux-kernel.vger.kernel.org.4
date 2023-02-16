Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CB2698AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 03:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBPCzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 21:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBPCzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 21:55:09 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F13E46097
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:55:08 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PHKLM213Cz8R043;
        Thu, 16 Feb 2023 10:55:07 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl1.zte.com.cn with SMTP id 31G2swIL024296;
        Thu, 16 Feb 2023 10:54:58 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 16 Feb 2023 10:54:59 +0800 (CST)
Date:   Thu, 16 Feb 2023 10:54:59 +0800 (CST)
X-Zmail-TransId: 2af963ed9b030d7e5fb5
X-Mailer: Zmail v1.0
Message-ID: <202302161054598138273@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <p.zabel@pengutronix.de>
Cc:     <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyXSByZXNldDogbWVzb246IFVzZSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 31G2swIL024296
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63ED9B0B.000 by FangMail milter!
X-FangMail-Envelope: 1676516107/4PHKLM213Cz8R043/63ED9B0B.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63ED9B0B.000/4PHKLM213Cz8R043
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to Use devm_platform_ioremap_resource(), as this is exactly
what this function does.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
v1 -> v2
change devm_platform_get_and_ioremap_resource() to
devm_platform_ioremap_resource().
 drivers/reset/reset-meson.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 26dc54778615..13878ca2779d 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -116,14 +116,12 @@ MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);
 static int meson_reset_probe(struct platform_device *pdev)
 {
 	struct meson_reset *data;
-	struct resource *res;

 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	data->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->reg_base))
 		return PTR_ERR(data->reg_base);

-- 
2.25.1

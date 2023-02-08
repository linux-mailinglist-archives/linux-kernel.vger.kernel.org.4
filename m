Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C8E68EB79
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBHJcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjBHJca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:32:30 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8755346D58
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:32:04 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PBZX240S1z8R03x;
        Wed,  8 Feb 2023 17:32:02 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl2.zte.com.cn with SMTP id 3189VuCM086501;
        Wed, 8 Feb 2023 17:31:57 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 8 Feb 2023 17:31:59 +0800 (CST)
Date:   Wed, 8 Feb 2023 17:31:59 +0800 (CST)
X-Zmail-TransId: 2af963e36c0fffffffffc1268d30
X-Mailer: Zmail v1.0
Message-ID: <202302081731593374472@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <lee@kernel.org>
Cc:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBtZmQ6IGF0bWVsLWZsZXhjb206IHVzZcKgZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 3189VuCM086501
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63E36C12.001 by FangMail milter!
X-FangMail-Envelope: 1675848722/4PBZX240S1z8R03x/63E36C12.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E36C12.001/4PBZX240S1z8R03x
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
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/mfd/atmel-flexcom.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
index 33caa4fba6af..b52f7ffdad35 100644
--- a/drivers/mfd/atmel-flexcom.c
+++ b/drivers/mfd/atmel-flexcom.c
@@ -37,7 +37,6 @@ struct atmel_flexcom {
 static int atmel_flexcom_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct resource *res;
 	struct atmel_flexcom *ddata;
 	int err;

@@ -55,8 +54,7 @@ static int atmel_flexcom_probe(struct platform_device *pdev)
 	    ddata->opmode > ATMEL_FLEXCOM_MODE_TWI)
 		return -EINVAL;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ddata->base = devm_ioremap_resource(&pdev->dev, res);
+	ddata->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(ddata->base))
 		return PTR_ERR(ddata->base);

-- 
2.25.1

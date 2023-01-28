Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F042667F5DB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjA1IFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjA1IFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:05:12 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A66D8001A;
        Sat, 28 Jan 2023 00:05:10 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4P3n6r6lwmz8R039;
        Sat, 28 Jan 2023 16:05:08 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl1.zte.com.cn with SMTP id 30S84vGO010627;
        Sat, 28 Jan 2023 16:04:57 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Sat, 28 Jan 2023 16:04:59 +0800 (CST)
Date:   Sat, 28 Jan 2023 16:04:59 +0800 (CST)
X-Zmail-TransId: 2af963d4d72bfffffffff60a89ea
X-Mailer: Zmail v1.0
Message-ID: <202301281604596831304@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <dmitry.torokhov@gmail.com>
Cc:     <wsa+renesas@sang-engineering.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBJbnB1dDogYXBicHMyIC0gVXNlIGRldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 30S84vGO010627
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63D4D734.001 by FangMail milter!
X-FangMail-Envelope: 1674893108/4P3n6r6lwmz8R039/63D4D734.001/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63D4D734.001/4P3n6r6lwmz8R039
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
 drivers/input/serio/apbps2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/serio/apbps2.c b/drivers/input/serio/apbps2.c
index 9c9ce097f8bf..513d96e40e0e 100644
--- a/drivers/input/serio/apbps2.c
+++ b/drivers/input/serio/apbps2.c
@@ -132,7 +132,6 @@ static int apbps2_of_probe(struct platform_device *ofdev)
 	struct apbps2_priv *priv;
 	int irq, err;
 	u32 freq_hz;
-	struct resource *res;

 	priv = devm_kzalloc(&ofdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
@@ -141,8 +140,7 @@ static int apbps2_of_probe(struct platform_device *ofdev)
 	}

 	/* Find Device Address */
-	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
-	priv->regs = devm_ioremap_resource(&ofdev->dev, res);
+	priv->regs = devm_platform_get_and_ioremap_resource(ofdev, 0, NULL);
 	if (IS_ERR(priv->regs))
 		return PTR_ERR(priv->regs);

-- 
2.25.1

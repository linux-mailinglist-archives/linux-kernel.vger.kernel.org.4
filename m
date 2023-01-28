Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE57A67F5E0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjA1IGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjA1IGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:06:39 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F6E84F89;
        Sat, 28 Jan 2023 00:06:36 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4P3n8W0N9bz6FK2P;
        Sat, 28 Jan 2023 16:06:35 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl1.zte.com.cn with SMTP id 30S86SCS011548;
        Sat, 28 Jan 2023 16:06:28 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Sat, 28 Jan 2023 16:06:30 +0800 (CST)
Date:   Sat, 28 Jan 2023 16:06:30 +0800 (CST)
X-Zmail-TransId: 2af963d4d786726ab1ad
X-Mailer: Zmail v1.0
Message-ID: <202301281606309671328@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <dmitry.torokhov@gmail.com>
Cc:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBJbnB1dDogYXJjX3BzMiAtIFVzZSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 30S86SCS011548
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63D4D78B.000 by FangMail milter!
X-FangMail-Envelope: 1674893195/4P3n8W0N9bz6FK2P/63D4D78B.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63D4D78B.000/4P3n8W0N9bz6FK2P
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
 drivers/input/serio/arc_ps2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/serio/arc_ps2.c b/drivers/input/serio/arc_ps2.c
index 0af9fba5d16d..a6debb13d527 100644
--- a/drivers/input/serio/arc_ps2.c
+++ b/drivers/input/serio/arc_ps2.c
@@ -182,7 +182,6 @@ static int arc_ps2_create_port(struct platform_device *pdev,
 static int arc_ps2_probe(struct platform_device *pdev)
 {
 	struct arc_ps2_data *arc_ps2;
-	struct resource *res;
 	int irq;
 	int error, id, i;

@@ -197,8 +196,7 @@ static int arc_ps2_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	arc_ps2->addr = devm_ioremap_resource(&pdev->dev, res);
+	arc_ps2->addr = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(arc_ps2->addr))
 		return PTR_ERR(arc_ps2->addr);

-- 
2.25.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6577A6978C1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjBOJLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbjBOJLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:11:33 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D155EEC6C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:11:32 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PGsl72Tdqz6FK2S;
        Wed, 15 Feb 2023 17:11:31 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 31F9BGCA080389;
        Wed, 15 Feb 2023 17:11:16 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 15 Feb 2023 17:11:18 +0800 (CST)
Date:   Wed, 15 Feb 2023 17:11:18 +0800 (CST)
X-Zmail-TransId: 2af963eca1b6ffffffffdd3993f8
X-Mailer: Zmail v1.0
Message-ID: <202302151711189308205@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <p.zabel@pengutronix.de>
Cc:     <eugeniy.paltsev@synopsys.com>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSByZXNldDogcmVzZXQtaHNkazogVXNlwqBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 31F9BGCA080389
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63ECA1C3.000 by FangMail milter!
X-FangMail-Envelope: 1676452291/4PGsl72Tdqz6FK2S/63ECA1C3.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63ECA1C3.000/4PGsl72Tdqz6FK2S
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/reset/reset-hsdk.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/reset/reset-hsdk.c b/drivers/reset/reset-hsdk.c
index 4c7b8647b49c..b38150e047b6 100644
--- a/drivers/reset/reset-hsdk.c
+++ b/drivers/reset/reset-hsdk.c
@@ -92,19 +92,16 @@ static const struct reset_control_ops hsdk_reset_ops = {
 static int hsdk_reset_probe(struct platform_device *pdev)
 {
 	struct hsdk_rst *rst;
-	struct resource *mem;

 	rst = devm_kzalloc(&pdev->dev, sizeof(*rst), GFP_KERNEL);
 	if (!rst)
 		return -ENOMEM;

-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rst->regs_ctl = devm_ioremap_resource(&pdev->dev, mem);
+	rst->regs_ctl = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(rst->regs_ctl))
 		return PTR_ERR(rst->regs_ctl);

-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	rst->regs_rst = devm_ioremap_resource(&pdev->dev, mem);
+	rst->regs_rst = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
 	if (IS_ERR(rst->regs_rst))
 		return PTR_ERR(rst->regs_rst);

-- 
2.25.1

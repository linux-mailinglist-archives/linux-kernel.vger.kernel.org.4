Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91530698AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 03:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBPC4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 21:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBPC4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 21:56:39 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE09746097
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:56:38 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PHKN54RPhz8QrkZ;
        Thu, 16 Feb 2023 10:56:37 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl1.zte.com.cn with SMTP id 31G2uT2e026400;
        Thu, 16 Feb 2023 10:56:29 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 16 Feb 2023 10:56:30 +0800 (CST)
Date:   Thu, 16 Feb 2023 10:56:30 +0800 (CST)
X-Zmail-TransId: 2af963ed9b5effffffffffdeaed7
X-Mailer: Zmail v1.0
Message-ID: <202302161056304138337@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <p.zabel@pengutronix.de>
Cc:     <eugeniy.paltsev@synopsys.com>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyXSByZXNldDogcmVzZXQtaHNkazogVXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 31G2uT2e026400
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63ED9B65.000 by FangMail milter!
X-FangMail-Envelope: 1676516197/4PHKN54RPhz8QrkZ/63ED9B65.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63ED9B65.000/4PHKN54RPhz8QrkZ
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
 drivers/reset/reset-hsdk.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/reset/reset-hsdk.c b/drivers/reset/reset-hsdk.c
index 4c7b8647b49c..98460e08752c 100644
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
+	rst->regs_ctl = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rst->regs_ctl))
 		return PTR_ERR(rst->regs_ctl);

-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	rst->regs_rst = devm_ioremap_resource(&pdev->dev, mem);
+	rst->regs_rst = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(rst->regs_rst))
 		return PTR_ERR(rst->regs_rst);

-- 
2.25.1

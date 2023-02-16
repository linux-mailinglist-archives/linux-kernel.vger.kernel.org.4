Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0EB698AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 03:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBPCxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 21:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBPCxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 21:53:50 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB590460A0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:53:49 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4PHKJr3TcMz501N6;
        Thu, 16 Feb 2023 10:53:48 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 31G2rY3G089164;
        Thu, 16 Feb 2023 10:53:35 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 16 Feb 2023 10:53:36 +0800 (CST)
Date:   Thu, 16 Feb 2023 10:53:36 +0800 (CST)
X-Zmail-TransId: 2af963ed9ab0ffffffff90ae17ed
X-Mailer: Zmail v1.0
Message-ID: <202302161053360618204@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <p.zabel@pengutronix.de>
Cc:     <vz@mleia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyXSByZXNldDogbHBjMTh4eDogVXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 31G2rY3G089164
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63ED9ABC.000/4PHKJr3TcMz501N6
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
call to Use devm_platform_ioremap_resource(), as this is exactly
what this function does.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
v1 -> v2
change devm_platform_get_and_ioremap_resource() to
devm_platform_ioremap_resource().
 drivers/reset/reset-lpc18xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/reset/reset-lpc18xx.c b/drivers/reset/reset-lpc18xx.c
index 35d8dd4cccfc..36ec95518905 100644
--- a/drivers/reset/reset-lpc18xx.c
+++ b/drivers/reset/reset-lpc18xx.c
@@ -139,7 +139,6 @@ static const struct reset_control_ops lpc18xx_rgu_ops = {
 static int lpc18xx_rgu_probe(struct platform_device *pdev)
 {
 	struct lpc18xx_rgu_data *rc;
-	struct resource *res;
 	u32 fcclk, firc;
 	int ret;

@@ -147,8 +146,7 @@ static int lpc18xx_rgu_probe(struct platform_device *pdev)
 	if (!rc)
 		return -ENOMEM;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rc->base = devm_ioremap_resource(&pdev->dev, res);
+	rc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rc->base))
 		return PTR_ERR(rc->base);

-- 
2.25.1

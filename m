Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669E76978A2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjBOJHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjBOJHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:07:32 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99935298F9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:07:30 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4PGsfT0xT0z4x5TB;
        Wed, 15 Feb 2023 17:07:29 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl1.zte.com.cn with SMTP id 31F97Gqh096238;
        Wed, 15 Feb 2023 17:07:16 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 15 Feb 2023 17:07:18 +0800 (CST)
Date:   Wed, 15 Feb 2023 17:07:18 +0800 (CST)
X-Zmail-TransId: 2af963eca0c6ffffffffbdc8a210
X-Mailer: Zmail v1.0
Message-ID: <202302151707187228042@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <p.zabel@pengutronix.de>
Cc:     <f.fainelli@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSByZXNldDogYnJjbXN0Yi1yZXNjYWw6IFVzZcKgZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 31F97Gqh096238
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63ECA0D1.000/4PGsfT0xT0z4x5TB
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
 drivers/reset/reset-brcmstb-rescal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/reset/reset-brcmstb-rescal.c b/drivers/reset/reset-brcmstb-rescal.c
index 433fa0c40e47..1227cf74b561 100644
--- a/drivers/reset/reset-brcmstb-rescal.c
+++ b/drivers/reset/reset-brcmstb-rescal.c
@@ -66,14 +66,12 @@ static const struct reset_control_ops brcm_rescal_reset_ops = {
 static int brcm_rescal_reset_probe(struct platform_device *pdev)
 {
 	struct brcm_rescal_reset *data;
-	struct resource *res;

 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->base = devm_ioremap_resource(&pdev->dev, res);
+	data->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);

-- 
2.25.1

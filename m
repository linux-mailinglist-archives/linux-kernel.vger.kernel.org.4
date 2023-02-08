Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B37768E923
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjBHHiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjBHHiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:38:13 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B06A5F8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:37:37 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PBWzm6sycz6FK2V;
        Wed,  8 Feb 2023 15:37:24 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl2.zte.com.cn with SMTP id 3187bDfE035268;
        Wed, 8 Feb 2023 15:37:13 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 8 Feb 2023 15:37:15 +0800 (CST)
Date:   Wed, 8 Feb 2023 15:37:15 +0800 (CST)
X-Zmail-TransId: 2af963e3512b0a54e2dc
X-Mailer: Zmail v1.0
Message-ID: <202302081537158530029@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <f.fainelli@gmail.com>
Cc:     <bcm-kernel-feedback-list@broadcom.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBidXM6IGJyY21zdGJfZ2lzYjogVXNlwqBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 3187bDfE035268
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63E35134.004 by FangMail milter!
X-FangMail-Envelope: 1675841844/4PBWzm6sycz6FK2V/63E35134.004/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E35134.004/4PBWzm6sycz6FK2V
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
 drivers/bus/brcmstb_gisb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index b0c3704777e9..b6dfe4340da2 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -401,12 +401,10 @@ static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
 	struct device_node *dn = pdev->dev.of_node;
 	struct brcmstb_gisb_arb_device *gdev;
 	const struct of_device_id *of_id;
-	struct resource *r;
 	int err, timeout_irq, tea_irq, bp_irq;
 	unsigned int num_masters, j = 0;
 	int i, first, last;

-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	timeout_irq = platform_get_irq(pdev, 0);
 	tea_irq = platform_get_irq(pdev, 1);
 	bp_irq = platform_get_irq(pdev, 2);
@@ -418,7 +416,7 @@ static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
 	mutex_init(&gdev->lock);
 	INIT_LIST_HEAD(&gdev->next);

-	gdev->base = devm_ioremap_resource(&pdev->dev, r);
+	gdev->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(gdev->base))
 		return PTR_ERR(gdev->base);

-- 
2.25.1

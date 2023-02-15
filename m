Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFE66976A0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 07:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjBOGvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 01:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBOGvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 01:51:12 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA64132E6C;
        Tue, 14 Feb 2023 22:51:10 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PGpd92k9kz8R03d;
        Wed, 15 Feb 2023 14:51:09 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl2.zte.com.cn with SMTP id 31F6ovRG090467;
        Wed, 15 Feb 2023 14:50:57 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 15 Feb 2023 14:50:59 +0800 (CST)
Date:   Wed, 15 Feb 2023 14:50:59 +0800 (CST)
X-Zmail-TransId: 2af963ec80d3ffffffffe12ff5cf
X-Mailer: Zmail v1.0
Message-ID: <202302151450594333186@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <sre@kernel.org>
Cc:     <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBwb3dlcjogcmVzZXQ6IGF0OTEtc2FtYTVkMl9zaGR3YzogVXNlwqBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 31F6ovRG090467
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63EC80DD.000 by FangMail milter!
X-FangMail-Envelope: 1676443869/4PGpd92k9kz8R03d/63EC80DD.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63EC80DD.000/4PGpd92k9kz8R03d
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
 drivers/power/reset/at91-sama5d2_shdwc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index d8ecffe72f16..3142ac53782b 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -331,7 +331,6 @@ static const struct of_device_id at91_pmc_ids[] = {

 static int __init at91_shdwc_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	const struct of_device_id *match;
 	struct device_node *np;
 	u32 ddr_type;
@@ -349,8 +348,7 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)

 	platform_set_drvdata(pdev, at91_shdwc);

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	at91_shdwc->shdwc_base = devm_ioremap_resource(&pdev->dev, res);
+	at91_shdwc->shdwc_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(at91_shdwc->shdwc_base))
 		return PTR_ERR(at91_shdwc->shdwc_base);

-- 
2.25.1

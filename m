Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8703C62D9A7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbiKQLka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239932AbiKQLkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:40:03 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8685C74F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:39:40 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NCdHZ5ThZz8RTZK;
        Thu, 17 Nov 2022 19:39:38 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2AHBdTsH020311;
        Thu, 17 Nov 2022 19:39:29 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 17 Nov 2022 19:39:32 +0800 (CST)
Date:   Thu, 17 Nov 2022 19:39:32 +0800 (CST)
X-Zmail-TransId: 2af963761d74ffffffff8983c8e3
X-Mailer: Zmail v1.0
Message-ID: <202211171939327684154@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <ssantosh@kernel.org>
Cc:     <krzysztof.kozlowski@linaro.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG1lbW9yeTogdGktZW1pZi1wbTogVXNlIGRldmljZV9nZXRfbWF0Y2hfZGF0YSgpIHRvIHNpbXBsaWZ5CgogdGhlIGNvZGU=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AHBdTsH020311
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63761D7A.001 by FangMail milter!
X-FangMail-Envelope: 1668685178/4NCdHZ5ThZz8RTZK/63761D7A.001/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63761D7A.001/4NCdHZ5ThZz8RTZK
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Directly get the match data with device_get_match_data().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/memory/ti-emif-pm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/memory/ti-emif-pm.c b/drivers/memory/ti-emif-pm.c
index 31d6266f008c..cef0d3beb63b 100644
--- a/drivers/memory/ti-emif-pm.c
+++ b/drivers/memory/ti-emif-pm.c
@@ -277,18 +277,13 @@ static int ti_emif_probe(struct platform_device *pdev)
 	int ret;
 	struct resource *res;
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *match;
 	struct ti_emif_data *emif_data;

 	emif_data = devm_kzalloc(dev, sizeof(*emif_data), GFP_KERNEL);
 	if (!emif_data)
 		return -ENOMEM;

-	match = of_match_device(ti_emif_of_match, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
-	emif_data->pm_data.ti_emif_sram_config = (unsigned long)match->data;
+	emif_data->pm_data.ti_emif_sram_config = (unsigned long) device_get_match_data(&pdev->dev);

 	emif_data->pm_data.ti_emif_base_addr_virt = devm_platform_get_and_ioremap_resource(pdev,
 											   0,
-- 
2.25.1

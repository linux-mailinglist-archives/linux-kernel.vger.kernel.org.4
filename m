Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B1062D938
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiKQLRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239627AbiKQLQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:16:59 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C77B02
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:16:56 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NCcnK3zc7z4y0vK;
        Thu, 17 Nov 2022 19:16:53 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AHBGlbL066354;
        Thu, 17 Nov 2022 19:16:47 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 17 Nov 2022 19:16:50 +0800 (CST)
Date:   Thu, 17 Nov 2022 19:16:50 +0800 (CST)
X-Zmail-TransId: 2af9637618225bc0663d
X-Mailer: Zmail v1.0
Message-ID: <202211171916504943604@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <tglx@linutronix.de>
Cc:     <maz@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGlycWNoaXA6IHN0OiBVc2UgZGV2aWNlX2dldF9tYXRjaF9kYXRhKCkgdG8gc2ltcGxpZnkgdGhlIGNvZGU=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AHBGlbL066354
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 63761825.002 by FangMail milter!
X-FangMail-Envelope: 1668683813/4NCcnK3zc7z4y0vK/63761825.002/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63761825.002/4NCcnK3zc7z4y0vK
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Directly get the match data with device_get_match_data().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/irqchip/irq-st.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-st.c b/drivers/irqchip/irq-st.c
index 801551e46a7b..1b83512b29c6 100644
--- a/drivers/irqchip/irq-st.c
+++ b/drivers/irqchip/irq-st.c
@@ -153,18 +153,13 @@ static int st_irq_syscfg_enable(struct platform_device *pdev)
 static int st_irq_syscfg_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *match;
 	struct st_irq_syscfg *ddata;

 	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;

-	match = of_match_device(st_irq_syscfg_match, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
-	ddata->syscfg = (unsigned int)match->data;
+	ddata->syscfg = (unsigned int) device_get_match_data(&pdev->dev);

 	ddata->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
 	if (IS_ERR(ddata->regmap)) {
-- 
2.25.1

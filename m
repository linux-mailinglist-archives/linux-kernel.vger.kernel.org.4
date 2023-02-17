Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968D369A462
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 04:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjBQDfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 22:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBQDe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 22:34:58 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7425A383;
        Thu, 16 Feb 2023 19:34:56 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PHy9p6Fclz6FK2m;
        Fri, 17 Feb 2023 11:34:54 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl1.zte.com.cn with SMTP id 31H3YhqP028983;
        Fri, 17 Feb 2023 11:34:43 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 17 Feb 2023 11:34:44 +0800 (CST)
Date:   Fri, 17 Feb 2023 11:34:44 +0800 (CST)
X-Zmail-TransId: 2af963eef5d4ffffffffe9562302
X-Mailer: Zmail v1.0
Message-ID: <202302171134447741391@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <daniel.lezcano@linaro.org>
Cc:     <rafael@kernel.org>, <amitk@kernel.org>, <rui.zhang@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB0aGVybWFsL2RyaXZlcnMvazNfajcyeHhfYmFuZGdhcDogVXNlwqBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 31H3YhqP028983
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63EEF5DE.000 by FangMail milter!
X-FangMail-Envelope: 1676604894/4PHy9p6Fclz6FK2m/63EEF5DE.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63EEF5DE.000/4PHy9p6Fclz6FK2m
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

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/thermal/k3_j72xx_bandgap.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 031ea1091909..cd848dec5a1c 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -346,7 +346,6 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 {
 	int ret = 0, cnt, val, id;
 	int high_max, low_temp;
-	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct k3_j72xx_bandgap *bgp;
 	struct k3_thermal_data *data;
@@ -376,13 +375,11 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		return -ENOMEM;

 	bgp->dev = dev;
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	bgp->base = devm_ioremap_resource(dev, res);
+	bgp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bgp->base))
 		return PTR_ERR(bgp->base);

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	bgp->cfg2_base = devm_ioremap_resource(dev, res);
+	bgp->cfg2_base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(bgp->cfg2_base))
 		return PTR_ERR(bgp->cfg2_base);

@@ -400,8 +397,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	 * https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
 	 */
 	if (workaround_needed) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-		fuse_base = devm_ioremap_resource(dev, res);
+		fuse_base = devm_platform_ioremap_resource(pdev, 2);
 		if (IS_ERR(fuse_base))
 			return PTR_ERR(fuse_base);

-- 
2.25.1

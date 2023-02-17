Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FED169A467
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 04:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjBQDiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 22:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBQDiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 22:38:13 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB60739CF9;
        Thu, 16 Feb 2023 19:38:11 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PHyFZ4s9kz8RV7H;
        Fri, 17 Feb 2023 11:38:10 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl2.zte.com.cn with SMTP id 31H3c4Fq062930;
        Fri, 17 Feb 2023 11:38:04 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 17 Feb 2023 11:38:05 +0800 (CST)
Date:   Fri, 17 Feb 2023 11:38:05 +0800 (CST)
X-Zmail-TransId: 2af963eef69dffffffff9ba69e1f
X-Mailer: Zmail v1.0
Message-ID: <202302171138053231478@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <daniel.lezcano@linaro.org>
Cc:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <rui.zhang@intel.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB0aGVybWFsL2RyaXZlcnMvdHNlbnM6IFVzZSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 31H3c4Fq062930
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63EEF6A2.000 by FangMail milter!
X-FangMail-Envelope: 1676605090/4PHyFZ4s9kz8RV7H/63EEF6A2.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63EEF6A2.000/4PHyFZ4s9kz8RV7H
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

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/thermal/qcom/tsens.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 8020ead2794e..bfe7e4728cf0 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -876,7 +876,6 @@ int __init init_common(struct tsens_priv *priv)
 	void __iomem *tm_base, *srot_base;
 	struct device *dev = priv->dev;
 	u32 ver_minor;
-	struct resource *res;
 	u32 enabled;
 	int ret, i, j;
 	struct platform_device *op = of_find_device_by_node(priv->dev->of_node);
@@ -887,8 +886,7 @@ int __init init_common(struct tsens_priv *priv)
 	if (op->num_resources > 1) {
 		/* DT with separate SROT and TM address space */
 		priv->tm_offset = 0;
-		res = platform_get_resource(op, IORESOURCE_MEM, 1);
-		srot_base = devm_ioremap_resource(dev, res);
+		srot_base = devm_platform_ioremap_resource(op, 1);
 		if (IS_ERR(srot_base)) {
 			ret = PTR_ERR(srot_base);
 			goto err_put_device;
@@ -906,8 +904,7 @@ int __init init_common(struct tsens_priv *priv)
 	}

 	if (tsens_version(priv) >= VER_0_1) {
-		res = platform_get_resource(op, IORESOURCE_MEM, 0);
-		tm_base = devm_ioremap_resource(dev, res);
+		tm_base = devm_platform_ioremap_resource(op, 0);
 		if (IS_ERR(tm_base)) {
 			ret = PTR_ERR(tm_base);
 			goto err_put_device;
-- 
2.25.1

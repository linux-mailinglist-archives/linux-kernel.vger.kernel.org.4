Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA48767173E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjARJRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjARJOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:14:45 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDE4366A4;
        Wed, 18 Jan 2023 00:31:48 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NxfBC0917z501SW;
        Wed, 18 Jan 2023 16:31:47 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 30I8VYIl048219;
        Wed, 18 Jan 2023 16:31:34 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 18 Jan 2023 16:31:36 +0800 (CST)
Date:   Wed, 18 Jan 2023 16:31:36 +0800 (CST)
X-Zmail-TransId: 2af963c7ae68ffffffffe400015c
X-Mailer: Zmail v1.0
Message-ID: <202301181631362083446@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <daniel.lezcano@linaro.org>
Cc:     <mmayer@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <rafael@kernel.org>, <amitk@kernel.org>, <rui.zhang@intel.com>,
        <f.fainelli@gmail.com>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB0aGVybWFsOiBicmNtc3RiX3RoZXJtYWw6IFVzZcKgZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 30I8VYIl048219
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63C7AE73.000/4NxfBC0917z501SW
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index c79c6cfdd74d..4d02c28331e3 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -321,7 +321,6 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 	const struct thermal_zone_device_ops *of_ops;
 	struct thermal_zone_device *thermal;
 	struct brcmstb_thermal_priv *priv;
-	struct resource *res;
 	int irq, ret;

 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -332,8 +331,7 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 	if (!priv->temp_params)
 		return -EINVAL;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->tmon_base = devm_ioremap_resource(&pdev->dev, res);
+	priv->tmon_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(priv->tmon_base))
 		return PTR_ERR(priv->tmon_base);

-- 
2.25.1

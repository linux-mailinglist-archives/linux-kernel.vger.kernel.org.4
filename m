Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061AF68EB87
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjBHJfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjBHJfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:35:14 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF34FF05;
        Wed,  8 Feb 2023 01:34:57 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PBZbN2knBz6FK2Q;
        Wed,  8 Feb 2023 17:34:56 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 3189YmNA096551;
        Wed, 8 Feb 2023 17:34:48 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 8 Feb 2023 17:34:51 +0800 (CST)
Date:   Wed, 8 Feb 2023 17:34:51 +0800 (CST)
X-Zmail-TransId: 2af963e36cbb2606f377
X-Mailer: Zmail v1.0
Message-ID: <202302081734511884545@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <lee@kernel.org>
Cc:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBtZmQ6IHFjb21fcnBtOiB1c2UgZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 3189YmNA096551
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63E36CC0.000 by FangMail milter!
X-FangMail-Envelope: 1675848896/4PBZbN2knBz6FK2Q/63E36CC0.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E36CC0.000/4PBZbN2knBz6FK2Q
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
 drivers/mfd/qcom_rpm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/qcom_rpm.c b/drivers/mfd/qcom_rpm.c
index 8fea0e511550..086611322874 100644
--- a/drivers/mfd/qcom_rpm.c
+++ b/drivers/mfd/qcom_rpm.c
@@ -530,7 +530,6 @@ static int qcom_rpm_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct device_node *syscon_np;
-	struct resource *res;
 	struct qcom_rpm *rpm;
 	u32 fw_version[3];
 	int irq_wakeup;
@@ -576,8 +575,7 @@ static int qcom_rpm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	rpm->data = match->data;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rpm->status_regs = devm_ioremap_resource(&pdev->dev, res);
+	rpm->status_regs = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(rpm->status_regs))
 		return PTR_ERR(rpm->status_regs);
 	rpm->ctrl_regs = rpm->status_regs + 0x400;
-- 
2.25.1

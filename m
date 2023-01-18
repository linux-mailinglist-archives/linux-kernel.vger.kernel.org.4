Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41411671777
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjARJYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjARJVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:21:15 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F20305E7;
        Wed, 18 Jan 2023 00:41:28 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NxfPL3Yttz4xVnK;
        Wed, 18 Jan 2023 16:41:26 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl2.zte.com.cn with SMTP id 30I8fHDN071387;
        Wed, 18 Jan 2023 16:41:17 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 18 Jan 2023 16:41:19 +0800 (CST)
Date:   Wed, 18 Jan 2023 16:41:19 +0800 (CST)
X-Zmail-TransId: 2af963c7b0af41215718
X-Mailer: Zmail v1.0
Message-ID: <202301181641194943741@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <daniel.lezcano@linaro.org>
Cc:     <talel@amazon.com>, <rafael@kernel.org>, <amitk@kernel.org>,
        <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB0aGVybWFsL2RyaXZlcnMvdGhlcm1hbF9tbWlvOiBVc2XCoGRldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 30I8fHDN071387
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63C7B0B6.000 by FangMail milter!
X-FangMail-Envelope: 1674031286/4NxfPL3Yttz4xVnK/63C7B0B6.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63C7B0B6.000/4NxfPL3Yttz4xVnK
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
 drivers/thermal/thermal_mmio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
index 39c921415989..ea616731066c 100644
--- a/drivers/thermal/thermal_mmio.c
+++ b/drivers/thermal/thermal_mmio.c
@@ -39,7 +39,6 @@ static const struct thermal_zone_device_ops thermal_mmio_ops = {

 static int thermal_mmio_probe(struct platform_device *pdev)
 {
-	struct resource *resource;
 	struct thermal_mmio *sensor;
 	int (*sensor_init_func)(struct platform_device *pdev,
 				struct thermal_mmio *sensor);
@@ -51,8 +50,7 @@ static int thermal_mmio_probe(struct platform_device *pdev)
 	if (!sensor)
 		return -ENOMEM;

-	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sensor->mmio_base = devm_ioremap_resource(&pdev->dev, resource);
+	sensor->mmio_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(sensor->mmio_base))
 		return PTR_ERR(sensor->mmio_base);

-- 
2.25.1

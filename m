Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1764068E925
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjBHHjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjBHHjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:39:37 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C94B3ABD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:39:05 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PBX1g5FzHz8RTZJ;
        Wed,  8 Feb 2023 15:39:03 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl1.zte.com.cn with SMTP id 3187cqGk025723;
        Wed, 8 Feb 2023 15:38:52 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 8 Feb 2023 15:38:54 +0800 (CST)
Date:   Wed, 8 Feb 2023 15:38:54 +0800 (CST)
X-Zmail-TransId: 2af963e3518efffffffff1252146
X-Mailer: Zmail v1.0
Message-ID: <202302081538546730084@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <liviu.dudau@arm.com>
Cc:     <sudeep.holla@arm.com>, <lpieralisi@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: =?UTF-8?B?W1BBVENIXSBidXM6IHZleHByZXNzLWNvbmZpZzogdXNlwqBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3187cqGk025723
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63E35197.000 by FangMail milter!
X-FangMail-Envelope: 1675841943/4PBX1g5FzHz8RTZJ/63E35197.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E35197.000/4PBX1g5FzHz8RTZJ
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
 drivers/bus/vexpress-config.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
index a58ac0c8e282..a03c9e32a665 100644
--- a/drivers/bus/vexpress-config.c
+++ b/drivers/bus/vexpress-config.c
@@ -350,7 +350,6 @@ static struct vexpress_config_bridge_ops vexpress_syscfg_bridge_ops = {
 static int vexpress_syscfg_probe(struct platform_device *pdev)
 {
 	struct vexpress_syscfg *syscfg;
-	struct resource *res;
 	struct vexpress_config_bridge *bridge;
 	struct device_node *node;
 	int master;
@@ -362,8 +361,7 @@ static int vexpress_syscfg_probe(struct platform_device *pdev)
 	syscfg->dev = &pdev->dev;
 	INIT_LIST_HEAD(&syscfg->funcs);

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	syscfg->base = devm_ioremap_resource(&pdev->dev, res);
+	syscfg->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(syscfg->base))
 		return PTR_ERR(syscfg->base);

-- 
2.25.1

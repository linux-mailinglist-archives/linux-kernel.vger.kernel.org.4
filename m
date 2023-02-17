Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE9069A460
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 04:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjBQDem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 22:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBQDek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 22:34:40 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3990498BD;
        Thu, 16 Feb 2023 19:34:39 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PHy9V0HRMz6FK7q;
        Fri, 17 Feb 2023 11:34:38 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 31H3XDaY047420;
        Fri, 17 Feb 2023 11:33:13 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 17 Feb 2023 11:33:15 +0800 (CST)
Date:   Fri, 17 Feb 2023 11:33:15 +0800 (CST)
X-Zmail-TransId: 2af963eef57bffffffff83c5ecac
X-Mailer: Zmail v1.0
Message-ID: <202302171133151381336@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <daniel.lezcano@linaro.org>
Cc:     <rafael@kernel.org>, <amitk@kernel.org>, <rui.zhang@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB0aGVybWFsL2RyaXZlcnMvYmFuZ2dhcDogVXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 31H3XDaY047420
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63EEF5CE.000 by FangMail milter!
X-FangMail-Envelope: 1676604878/4PHy9V0HRMz6FK7q/63EEF5CE.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63EEF5CE.000/4PHy9V0HRMz6FK7q
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
 drivers/thermal/k3_bandgap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 22c9bcb899c3..3e3ec846fa50 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -160,7 +160,6 @@ static const struct of_device_id of_k3_bandgap_match[];
 static int k3_bandgap_probe(struct platform_device *pdev)
 {
 	int ret = 0, cnt, val, id;
-	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct k3_bandgap *bgp;
 	struct k3_thermal_data *data;
@@ -173,8 +172,7 @@ static int k3_bandgap_probe(struct platform_device *pdev)
 	if (!bgp)
 		return -ENOMEM;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	bgp->base = devm_ioremap_resource(dev, res);
+	bgp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bgp->base))
 		return PTR_ERR(bgp->base);

-- 
2.25.1

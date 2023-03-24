Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A932F6C7623
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjCXDJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCXDJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:09:06 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1DB28E5F;
        Thu, 23 Mar 2023 20:09:04 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PjRxq1NDYz8R03x;
        Fri, 24 Mar 2023 11:09:03 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl2.zte.com.cn with SMTP id 32O38smi059329;
        Fri, 24 Mar 2023 11:08:54 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 24 Mar 2023 11:08:55 +0800 (CST)
Date:   Fri, 24 Mar 2023 11:08:55 +0800 (CST)
X-Zmail-TransId: 2afa641d14477cf-46207
X-Mailer: Zmail v1.0
Message-ID: <202303241108553006227@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <rafael@kernel.org>
Cc:     <daniel.lezcano@linaro.org>, <amitk@kernel.org>,
        <rui.zhang@intel.com>, <heiko@sntech.de>, <p.zabel@pengutronix.de>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB0aGVybWFsL2RyaXZlcnMvcm9ja2NoaXA6IHVzZcKgZGV2bV9yZXNldF9jb250cm9sX2FycmF5X2dldF9leGNsdXNpdmUoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 32O38smi059329
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 641D144F.000 by FangMail milter!
X-FangMail-Envelope: 1679627343/4PjRxq1NDYz8R03x/641D144F.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 641D144F.000/4PjRxq1NDYz8R03x
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

Switch devm_reset_control_array_get() to
devm_reset_control_array_get_exclusive().

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/thermal/rockchip_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index bb254bdff043..85df34417159 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1378,7 +1378,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(thermal->regs))
 		return PTR_ERR(thermal->regs);

-	thermal->reset = devm_reset_control_array_get(&pdev->dev, false, false);
+	thermal->reset = devm_reset_control_array_get_exclusive(&pdev->dev);
 	if (IS_ERR(thermal->reset)) {
 		error = PTR_ERR(thermal->reset);
 		dev_err(&pdev->dev, "failed to get tsadc reset: %d\n", error);
-- 
2.25.1

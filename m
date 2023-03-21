Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC4F6C3045
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjCULXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjCULXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:23:06 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040BD3E1D0;
        Tue, 21 Mar 2023 04:22:42 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Pgq2M65w2z6FK2R;
        Tue, 21 Mar 2023 19:22:19 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl1.zte.com.cn with SMTP id 32LBMCZ6070552;
        Tue, 21 Mar 2023 19:22:13 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 21 Mar 2023 19:22:16 +0800 (CST)
Date:   Tue, 21 Mar 2023 19:22:16 +0800 (CST)
X-Zmail-TransId: 2afa64199368ffffffffc3c-b82e7
X-Mailer: Zmail v1.0
Message-ID: <202303211922161400872@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <andersson@kernel.org>
Cc:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBidXM6IHFjb20tc3NjLWJsb2NrLWJ1czogdXNlwqBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1lKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 32LBMCZ6070552
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6419936B.000/4Pgq2M65w2z6FK2R
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

Convert platform_get_resource_byname(),devm_ioremap_resource() to a single
call to devm_platform_ioremap_resource_byname(), as this is exactly what
this function does.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/bus/qcom-ssc-block-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/qcom-ssc-block-bus.c b/drivers/bus/qcom-ssc-block-bus.c
index eedeb29a5ff3..ae95112d4e20 100644
--- a/drivers/bus/qcom-ssc-block-bus.c
+++ b/drivers/bus/qcom-ssc-block-bus.c
@@ -277,14 +277,14 @@ static int qcom_ssc_block_bus_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret, "error when enabling power domains\n");

 	/* low level overrides for when the HW logic doesn't "just work" */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpm_sscaon_config0");
-	data->reg_mpm_sscaon_config0 = devm_ioremap_resource(&pdev->dev, res);
+	data->reg_mpm_sscaon_config0 = devm_platform_ioremap_resource_byname(pdev,
+									     "mpm_sscaon_config0");
 	if (IS_ERR(data->reg_mpm_sscaon_config0))
 		return dev_err_probe(&pdev->dev, PTR_ERR(data->reg_mpm_sscaon_config0),
 				     "Failed to ioremap mpm_sscaon_config0\n");

-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpm_sscaon_config1");
-	data->reg_mpm_sscaon_config1 = devm_ioremap_resource(&pdev->dev, res);
+	data->reg_mpm_sscaon_config1 = devm_platform_ioremap_resource_byname(pdev,
+									     "mpm_sscaon_config1");
 	if (IS_ERR(data->reg_mpm_sscaon_config1))
 		return dev_err_probe(&pdev->dev, PTR_ERR(data->reg_mpm_sscaon_config1),
 				     "Failed to ioremap mpm_sscaon_config1\n");
-- 
2.25.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE5F6BC97C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjCPImK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjCPImF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:42:05 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D90080910;
        Thu, 16 Mar 2023 01:41:56 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G8dJ9l025448;
        Thu, 16 Mar 2023 09:41:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=AXUIqhetis6c85+Irfhlb97EXOMi8dfJ4TTcyAiXELg=;
 b=0EtlvnAVAFojn149kBAHFXhGZNJM3HCG4y6hL+oSXJgu6Cxp34HUqTfzoygI62Lg+6LG
 2fgAhugM25bYkhsqQJDjapQDH3ILHSUQbPIS7ckyf4b6Pgl2maKj7HigWKBBrmwmup8F
 dxldLfYZGIIqZd3E8M/+lEzyn6Gqb9HD4V/Bs0zqL4jvBtByK3S+CCcugu8JVuv1n4e7
 HGEmnYFQclfmu69iCK6DhUytr/Kp5gfvkondRYeUJF6qFvMJa9ewYkPAccXSSw0KCGdr
 8dizSdGUAAnKuADyCYg08iWXoEuhENZSxojvYpJIxYLjekmzMvjD3pm2qgtzk4WeRpvf Ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pbpwqtrh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 09:41:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 62C2410002A;
        Thu, 16 Mar 2023 09:41:41 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 01D4C20E1D9;
        Thu, 16 Mar 2023 09:41:41 +0100 (CET)
Received: from localhost (10.48.1.102) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 16 Mar
 2023 09:41:40 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <maz@kernel.org>, <m.szyprowski@samsung.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2] usb: dwc2: fix a devres leak in hw_enable upon suspend resume
Date:   Thu, 16 Mar 2023 09:41:27 +0100
Message-ID: <20230316084127.126084-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.1.102]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_06,2023-03-15_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each time the platform goes to low power, PM suspend / resume routines
call: __dwc2_lowlevel_hw_enable -> devm_add_action_or_reset().
This adds a new devres each time.
This may also happen at runtime, as dwc2_lowlevel_hw_enable() can be
called from udc_start().

This can be seen with tracing:
- echo 1 > /sys/kernel/debug/tracing/events/dev/devres_log/enable
- go to low power
- cat /sys/kernel/debug/tracing/trace

A new "ADD" entry is found upon each low power cycle:
... devres_log: 49000000.usb-otg ADD 82a13bba devm_action_release (8 bytes)
... devres_log: 49000000.usb-otg ADD 49889daf devm_action_release (8 bytes)
...

A second issue is addressed here:
- regulator_bulk_enable() is called upon each PM cycle (suspend/resume).
- regulator_bulk_disable() never gets called.

So the reference count for these regulators constantly increase, by one
upon each low power cycle, due to missing regulator_bulk_disable() call
in __dwc2_lowlevel_hw_disable().

The original fix that introduced the devm_add_action_or_reset() call,
fixed an issue during probe, that happens due to other errors in
dwc2_driver_probe() -> dwc2_core_reset(). Then the probe fails without
disabling regulators, when dr_mode == USB_DR_MODE_PERIPHERAL.

Rather fix the error path: disable all the low level hardware in the
error path, by using the "hsotg->ll_hw_enabled" flag. Checking dr_mode
has been introduced to avoid a dual call to dwc2_lowlevel_hw_disable().
"ll_hw_enabled" should achieve the same (and is used currently in the
remove() routine).

Fixes: 54c196060510 ("usb: dwc2: Always disable regulators on driver teardown")
Fixes: 33a06f1300a7 ("usb: dwc2: Fix error path in gadget registration")
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2: commit message updated to remove useless tags
---
 drivers/usb/dwc2/platform.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 262c13b6362a..d1589ba7d322 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -91,13 +91,6 @@ static int dwc2_get_dr_mode(struct dwc2_hsotg *hsotg)
 	return 0;
 }
 
-static void __dwc2_disable_regulators(void *data)
-{
-	struct dwc2_hsotg *hsotg = data;
-
-	regulator_bulk_disable(ARRAY_SIZE(hsotg->supplies), hsotg->supplies);
-}
-
 static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)
 {
 	struct platform_device *pdev = to_platform_device(hsotg->dev);
@@ -108,11 +101,6 @@ static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       __dwc2_disable_regulators, hsotg);
-	if (ret)
-		return ret;
-
 	if (hsotg->clk) {
 		ret = clk_prepare_enable(hsotg->clk);
 		if (ret)
@@ -168,7 +156,7 @@ static int __dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg)
 	if (hsotg->clk)
 		clk_disable_unprepare(hsotg->clk);
 
-	return 0;
+	return regulator_bulk_disable(ARRAY_SIZE(hsotg->supplies), hsotg->supplies);
 }
 
 /**
@@ -607,7 +595,7 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	if (hsotg->params.activate_stm_id_vb_detection)
 		regulator_disable(hsotg->usb33d);
 error:
-	if (hsotg->dr_mode != USB_DR_MODE_PERIPHERAL)
+	if (hsotg->ll_hw_enabled)
 		dwc2_lowlevel_hw_disable(hsotg);
 	return retval;
 }
-- 
2.25.1


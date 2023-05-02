Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEC16F3CDF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 07:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjEBFFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 01:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBFFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 01:05:10 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C6140D9;
        Mon,  1 May 2023 22:05:07 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34254n4Z2007203, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34254n4Z2007203
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 2 May 2023 13:04:49 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 2 May 2023 13:04:53 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 2 May 2023 13:04:52 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Tue, 2 May 2023 13:04:52 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/2] usb: dwc3: core: add support for RTK SoC custom's global register start address
Date:   Tue, 2 May 2023 13:04:46 +0800
Message-ID: <20230502050452.27276-1-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS05.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTK DHC SoCs were designed, the global register address offset at
0x8100. The default address offset is constant at DWC3_GLOBALS_REGS_START
(0xc100). Therefore, add the compatible name of device-tree to specify
the SoC custom's global register start address.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
 v3 to v4 change:
Use the compatible name to specify the global register address offset.
If the compatible name is "snps,dwc3-rtk-soc", then the offset use 0x8100.
Otherwise, the offset is default value 0xc100.

 v2 to v3 change:
1.  Fix the dtschema validation error.

 v1 to v2 change:
1. Change the name of the property "snps,global-regs-starting-offset".
2. Adjust the format of comment.
3. Add initial value of the global_regs_starting_offset
4. Remove the log of dev_info.
---
 drivers/usb/dwc3/core.c | 18 +++++++++++++++---
 drivers/usb/dwc3/core.h |  5 +++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 0beaab932e7d..4f69b26d7dab 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/acpi.h>
 #include <linux/pinctrl/consumer.h>
@@ -1793,12 +1794,17 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->xhci_resources[0].flags = res->flags;
 	dwc->xhci_resources[0].name = res->name;
 
+	dwc->global_regs_starting_offset = (u32)(uintptr_t)
+		    of_device_get_match_data(dev);
+	if (!dwc->global_regs_starting_offset)
+		dwc->global_regs_starting_offset = DWC3_GLOBALS_REGS_START;
+
 	/*
 	 * Request memory region but exclude xHCI regs,
 	 * since it will be requested by the xhci-plat driver.
 	 */
 	dwc_res = *res;
-	dwc_res.start += DWC3_GLOBALS_REGS_START;
+	dwc_res.start += dwc->global_regs_starting_offset;
 
 	regs = devm_ioremap_resource(dev, &dwc_res);
 	if (IS_ERR(regs))
@@ -2224,10 +2230,16 @@ static const struct dev_pm_ops dwc3_dev_pm_ops = {
 #ifdef CONFIG_OF
 static const struct of_device_id of_dwc3_match[] = {
 	{
-		.compatible = "snps,dwc3"
+		.compatible = "snps,dwc3",
+		.data = (void *)DWC3_GLOBALS_REGS_START,
+	},
+	{
+		.compatible = "snps,dwc3-rtk-soc",
+		.data = (void *)DWC3_GLOBALS_REGS_START_FOR_RTK,
 	},
 	{
-		.compatible = "synopsys,dwc3"
+		.compatible = "synopsys,dwc3",
+		.data = (void *)DWC3_GLOBALS_REGS_START,
 	},
 	{ },
 };
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index d56457c02996..46557cf52f4b 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -84,6 +84,8 @@
 #define DWC3_OTG_REGS_START		0xcc00
 #define DWC3_OTG_REGS_END		0xccff
 
+#define DWC3_GLOBALS_REGS_START_FOR_RTK 0x8100
+
 /* Global Registers */
 #define DWC3_GSBUSCFG0		0xc100
 #define DWC3_GSBUSCFG1		0xc104
@@ -1118,6 +1120,8 @@ struct dwc3_scratchpad_array {
  * @wakeup_configured: set if the device is configured for remote wakeup.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
+ * @global_regs_starting_offset: set the dwc3 global register start address
+ *	 and it is default at DWC3_GLOBALS_REGS_START (0xc100).
  * @max_cfg_eps: current max number of IN eps used across all USB configs.
  * @last_fifo_depth: last fifo depth used to determine next fifo ram start
  *		     address.
@@ -1334,6 +1338,7 @@ struct dwc3 {
 	unsigned		wakeup_configured:1;
 
 	u16			imod_interval;
+	u32			global_regs_starting_offset;
 
 	int			max_cfg_eps;
 	int			last_fifo_depth;
-- 
2.34.1


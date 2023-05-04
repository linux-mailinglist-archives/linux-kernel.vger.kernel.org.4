Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8EF6F63A9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 05:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjEDDoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 23:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEDDoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 23:44:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F78C1B1;
        Wed,  3 May 2023 20:44:32 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3443iJQ21015327, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3443iJQ21015327
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 4 May 2023 11:44:20 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 4 May 2023 11:44:24 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 4 May 2023 11:44:23 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Thu, 4 May 2023 11:44:23 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5] usb: dwc3: core: add support for realtek SoCs custom's global register start address
Date:   Thu, 4 May 2023 11:44:23 +0800
Message-ID: <20230504034423.20813-1-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

The Realtek RTD1xxx SoCs were designed, the global register address
offset at 0x8100. The default address offset is constant at
DWC3_GLOBALS_REGS_START (0xc100). Therefore, add a check if the
compatible name of the parent is "realtek,rtd1xxx-dwc3", then global
register start address will remap to 0x8100.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
 v4 to v5 change:
Use the compatible name of the parent to match this special offset.

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
 drivers/usb/dwc3/core.c | 11 +++++++++++
 drivers/usb/dwc3/core.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 0beaab932e7d..0adafb5439ed 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1800,6 +1800,17 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc_res = *res;
 	dwc_res.start += DWC3_GLOBALS_REGS_START;
 
+	if (dev->of_node) {
+		struct device_node *parent = of_get_parent(dev->of_node);
+
+		if (of_device_is_compatible(parent, "realtek,rtd1xxx-dwc3")) {
+			dwc_res.start -= DWC3_GLOBALS_REGS_START;
+			dwc_res.start += DWC3_RTK_RTD1XXX_GLOBALS_REGS_START;
+		}
+
+		of_node_put(parent);
+	}
+
 	regs = devm_ioremap_resource(dev, &dwc_res);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index d56457c02996..c004e3a548ca 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -84,6 +84,8 @@
 #define DWC3_OTG_REGS_START		0xcc00
 #define DWC3_OTG_REGS_END		0xccff
 
+#define DWC3_RTK_RTD1XXX_GLOBALS_REGS_START	0x8100
+
 /* Global Registers */
 #define DWC3_GSBUSCFG0		0xc100
 #define DWC3_GSBUSCFG1		0xc104
-- 
2.34.1


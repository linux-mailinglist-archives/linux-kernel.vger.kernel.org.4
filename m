Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DCA6F7B39
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 04:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjEECvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 22:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEECvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 22:51:15 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2631209E;
        Thu,  4 May 2023 19:51:12 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3452p0wvD029479, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3452p0wvD029479
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 5 May 2023 10:51:00 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 5 May 2023 10:51:05 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 5 May 2023 10:51:04 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Fri, 5 May 2023 10:51:04 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6] usb: dwc3: core: add support for realtek SoCs custom's global register start address
Date:   Fri, 5 May 2023 10:50:54 +0800
Message-ID: <20230505025104.18321-1-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS05.realtek.com.tw, 9
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

The Realtek RTD SoCs were designed with the global register address
offset at 0x8100. The default address offset is constant at
DWC3_GLOBALS_REGS_START (0xc100). Therefore, add a check if the
compatible name of the parent is realtek,rtd-dwc3, then global
register start address will remap to 0x8100.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
 v5 to v6 change:
Change the compatible name to avoid using the wildcard.

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
index 0beaab932e7d..278cd1c33841 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1800,6 +1800,17 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc_res = *res;
 	dwc_res.start += DWC3_GLOBALS_REGS_START;
 
+	if (dev->of_node) {
+		struct device_node *parent = of_get_parent(dev->of_node);
+
+		if (of_device_is_compatible(parent, "realtek,rtd-dwc3")) {
+			dwc_res.start -= DWC3_GLOBALS_REGS_START;
+			dwc_res.start += DWC3_RTK_RTD_GLOBALS_REGS_START;
+		}
+
+		of_node_put(parent);
+	}
+
 	regs = devm_ioremap_resource(dev, &dwc_res);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index d56457c02996..1968638f29ed 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -84,6 +84,8 @@
 #define DWC3_OTG_REGS_START		0xcc00
 #define DWC3_OTG_REGS_END		0xccff
 
+#define DWC3_RTK_RTD_GLOBALS_REGS_START	0x8100
+
 /* Global Registers */
 #define DWC3_GSBUSCFG0		0xc100
 #define DWC3_GSBUSCFG1		0xc104
-- 
2.34.1


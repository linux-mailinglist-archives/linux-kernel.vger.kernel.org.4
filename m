Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C966E05F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDMEYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjDMEYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:24:30 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA77BB;
        Wed, 12 Apr 2023 21:24:29 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33D4O0VC0024180, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33D4O0VC0024180
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 13 Apr 2023 12:24:00 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 13 Apr 2023 12:24:22 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 13 Apr 2023 12:24:22 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Thu, 13 Apr 2023 12:24:22 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] usb: dwc3: core: add support for remapping global register start address
Date:   Thu, 13 Apr 2023 12:24:22 +0800
Message-ID: <20230413042422.3723-1-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412033006.10859-1-stanley_chang@realtek.com>
References: <20230412033006.10859-1-stanley_chang@realtek.com>
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTK DHC SoCs were designed the global register address offset at
0x8100. The default address is at DWC3_GLOBALS_REGS_START (0xc100).
Therefore, add the property of device-tree to adjust this start address.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
 v1 to v2 change:
1. Change the name of the property "snps,global-regs-starting-offset".
2. Adjust the format of comment.
3. Add initial value of the global_regs_starting_offset
4. Remove the log of dev_info.
---
 drivers/usb/dwc3/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 476b63618511..8c1d1afbdc65 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1785,6 +1785,21 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc_res = *res;
 	dwc_res.start += DWC3_GLOBALS_REGS_START;
 
+	/*
+	 * For some dwc3 controller, the dwc3 global register start address is
+	 * not at DWC3_GLOBALS_REGS_START (0xc100).
+	 */
+	if (dev->of_node) {
+		int global_regs_starting_offset = 0;
+
+		device_property_read_u32(dev, "snps,global-regs-starting-offset",
+			    &global_regs_starting_offset);
+		if (global_regs_starting_offset) {
+			dwc_res.start -= DWC3_GLOBALS_REGS_START;
+			dwc_res.start += global_regs_starting_offset;
+		}
+	}
+
 	regs = devm_ioremap_resource(dev, &dwc_res);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
-- 
2.34.1


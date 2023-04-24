Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AC26E70ED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 04:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjDSCBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 22:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjDSCBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 22:01:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C080136;
        Tue, 18 Apr 2023 19:00:58 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33J20iZqA021874, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33J20iZqA021874
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 19 Apr 2023 10:00:45 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 19 Apr 2023 10:00:44 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 19 Apr 2023 10:00:44 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Wed, 19 Apr 2023 10:00:44 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/2] usb: dwc3: core: add support for disabling High-speed park mode
Date:   Wed, 19 Apr 2023 10:00:42 +0800
Message-ID: <20230419020044.15475-1-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXDAG01.realtek.com.tw, 9
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

Setting the PARKMODE_DISABLE_HS bit in the DWC3_USB3_GUCTL1.
When this bit is set to '1' all HS bus instances in park mode are disabled

For some USB wifi devices, if enable this feature it will reduce the
performance. Therefore, add an option for disabling HS park mode by
device-tree.

In Synopsys's dwc3 data book:
In a few high speed devices when an IN request is sent within 900ns of the
ACK of the previous packet, these devices send a NAK. When connected to
these devices, if required, the software can disable the park mode if you
see performance drop in your system. When park mode is disabled,
pipelining of multiple packet is disabled and instead one packet at a time
is requested by the scheduler. This allows up to 12 NAKs in a micro-frame
and improves performance of these slow devices.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/dwc3/core.c | 5 +++++
 drivers/usb/dwc3/core.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 476b63618511..8fbc92a5f2cb 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1233,6 +1233,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		if (dwc->parkmode_disable_ss_quirk)
 			reg |= DWC3_GUCTL1_PARKMODE_DISABLE_SS;
 
+		if (dwc->parkmode_disable_hs_quirk)
+			reg |= DWC3_GUCTL1_PARKMODE_DISABLE_HS;
+
 		if (DWC3_VER_IS_WITHIN(DWC3, 290A, ANY) &&
 		    (dwc->maximum_speed == USB_SPEED_HIGH ||
 		     dwc->maximum_speed == USB_SPEED_FULL))
@@ -1555,6 +1558,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,resume-hs-terminations");
 	dwc->parkmode_disable_ss_quirk = device_property_read_bool(dev,
 				"snps,parkmode-disable-ss-quirk");
+	dwc->parkmode_disable_hs_quirk = device_property_read_bool(dev,
+				"snps,parkmode-disable-hs-quirk");
 	dwc->gfladj_refclk_lpm_sel = device_property_read_bool(dev,
 				"snps,gfladj-refclk-lpm-sel-quirk");
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4743e918dcaf..30907ffcb3ec 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -263,6 +263,7 @@
 #define DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK	BIT(26)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW		BIT(24)
 #define DWC3_GUCTL1_PARKMODE_DISABLE_SS		BIT(17)
+#define DWC3_GUCTL1_PARKMODE_DISABLE_HS		BIT(16)
 #define DWC3_GUCTL1_RESUME_OPMODE_HS_HOST	BIT(10)
 
 /* Global Status Register */
@@ -1102,6 +1103,8 @@ struct dwc3_scratchpad_array {
  *			generation after resume from suspend.
  * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpeed
  *			instances in park mode.
+ * @parkmode_disable_hs_quirk: set if we need to disable all HishSpeed
+ *			instances in park mode.
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
  *	0	- -6dB de-emphasis
@@ -1318,6 +1321,7 @@ struct dwc3 {
 	unsigned		dis_tx_ipgap_linecheck_quirk:1;
 	unsigned		resume_hs_terminations:1;
 	unsigned		parkmode_disable_ss_quirk:1;
+	unsigned		parkmode_disable_hs_quirk:1;
 	unsigned		gfladj_refclk_lpm_sel:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
-- 
2.34.1


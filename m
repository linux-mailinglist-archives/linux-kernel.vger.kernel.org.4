Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F66C748AF6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjGERt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGERt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:49:56 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0221E3;
        Wed,  5 Jul 2023 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=Umzk5ehZNG0T3NRYgnCWGiPxmb2XrP2Y/6G0hrOSDPc=; b=I
        4SGMZT9SB/Gpbmci/2K4zbwREgZOFmMggtU0UrAV1nz/94JSwD8329cAQmA7p9dfR+sQX3V3W/JQA
        VkCKCnogl1iqViH2qNVZID/ukIeK+tBxjFkmDW9oJBnmFyRciMvW/u/iI/Jm9Sy6+DxbKeUr5U4bZ
        JU9+1Q+YkWR7uT8E=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:53816 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qH6dL-0006Oa-Qh; Wed, 05 Jul 2023 13:49:44 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed,  5 Jul 2023 13:49:32 -0400
Message-Id: <20230705174932.3652479-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v2] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

USB OTG is currently broken on the Variscite Symphony EVK and imx8mn
nano SOM.

The PTN5150 circuitry on newer versions of the Symphony EVK board has
a non-standard configuration in which the PTN5150 IRQ pin is left
unconnected, and the PTN5150 ID pin is connected to GPIO1_IO11. This
requires changes to the ptn5150 driver to support this new mode.
Variscite have indicated their intention to submit those changes
upstream.

In the meantime, import device tree changes from linux-5.15 branch of
varigit repos to at least make the USB OTG port operate correctly in
host mode.

Fixes: 7358e05bddca ("arm64: dts: imx8mn-var-som-symphony: Add Variscite Symphony board with VAR-SOM-MX8MN")
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Link: [v1] https://lkml.org/lkml/2023/7/4/702

Changes from v1:
- Add comments about PTN5150 IRQ/ID line connections
- Remove "typec1_con: connector" node
- Change IRQ type to IRQ_TYPE_EDGE_FALLING

 .../dts/freescale/imx8mn-var-som-symphony.dts | 32 +++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
index 406a711486da..a7a57442cb81 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
@@ -1,11 +1,14 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
+ * Supports Symphony evaluation board versions >= 1.4a.
+ *
  * Copyright 2019-2020 Variscite Ltd.
  * Copyright (C) 2020 Krzysztof Kozlowski <krzk@kernel.org>
  */
 
 /dts-v1/;
 
+#include <dt-bindings/usb/pd.h>
 #include "imx8mn-var-som.dtsi"
 
 / {
@@ -100,14 +103,26 @@ enet-sel-hog {
 		};
 	};
 
+	/*
+	 * For Symphony board version <= 1.4, the PTN5150 IRQ pin is connected
+	 * to GPIO1_IO11 on the SoM (R106 present, R132 absent). From Symphony
+	 * board version >= 1.4a, the PTN5150 ID pin is connected to GPIO1_IO11
+	 * on the SoM (R106 absent, R132 present).
+	 */
 	extcon_usbotg1: typec@3d {
 		compatible = "nxp,ptn5150";
 		reg = <0x3d>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ptn5150>;
 		status = "okay";
+
+		port {
+			typec1_dr_sw: endpoint {
+				remote-endpoint = <&usb1_drd_sw>;
+			};
+		};
 	};
 };
 
@@ -148,8 +163,21 @@ &uart3 {
 };
 
 &usbotg1 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
 	disable-over-current;
-	extcon = <&extcon_usbotg1>, <&extcon_usbotg1>;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	status = "okay";
+
+	port {
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&typec1_dr_sw>;
+		};
+	};
 };
 
 &iomuxc {

base-commit: d528014517f2b0531862c02865b9d4c908019dc4
-- 
2.30.2


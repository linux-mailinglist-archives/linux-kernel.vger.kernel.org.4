Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78B770DCA7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbjEWMeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjEWMd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:33:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF18EC4;
        Tue, 23 May 2023 05:33:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54BDF62877;
        Tue, 23 May 2023 12:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA986C433D2;
        Tue, 23 May 2023 12:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684845236;
        bh=WRj4PeCrYbzTNdM4RjmQBD++ByLrkDUJZxWRpjS/qaU=;
        h=From:To:Cc:Subject:Date:From;
        b=PDiIIwglFuz1jCbXPT1fjIZgWuuI17BF69AnME2jgM0uXebECRJOR/vfff2g3pNMY
         iFRmT8Z/1jxYkt906My8vYP5WZ8ohb8AdEnGgUGDj7LkaeINjst0gE1kY2r4a7Yte+
         lroBmyVvSI3pciX3yk8b/W4RFiUnJpw6knvcWYU8tbnXjmojbXoIxGy1ygCDdByGl1
         vwMSH7T74z+IwVW51zjLaQx2YeDMbu3wH3Np8C0oMPvKFC4jgnVd+/+WGtpBgWZcle
         tKBJr0WhTXm/k1LQivmxMqdqOmOVJV5eEv4aGPE9FDSnrJy6LzSSPTs4QawV2IU1nZ
         SSNKvvJP3cCJw==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com
Cc:     vigneshr@ti.com, r-gunasekaran@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v4] arm64: dts: ti: k3-am625: Enable Type-C port for USB0
Date:   Tue, 23 May 2023 15:33:48 +0300
Message-Id: <20230523123348.52850-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB0 is a Type-C port with dual data role and power sink.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---

Changelog:
v4:
- Rebase on v6.4-rc2
- Drop interrupt patch as it will break Type-C role switch on older boards.

v3:
- include Type-C support for am62-lp-sk
- split interrupts properties for Type-C chip into am625-sk

v2:
- rebase off [1]
- add fixes tag to patch 1

[1] - https://lore.kernel.org/all/20230321-am62-lp-sk-v2-0-0a56e1694804@ti.com/

 arch/arm64/boot/dts/ti/k3-am625-sk.dts        |  2 +-
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 35 ++++++++++++++++++-
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 2a1adda9bff6..729f95e19042 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -161,7 +161,7 @@ exp1: gpio@22 {
 				   "UART1_FET_BUF_EN", "WL_LT_EN",
 				   "GPIO_HDMI_RSTn", "CSI_GPIO1",
 				   "CSI_GPIO2", "PRU_3V3_EN",
-				   "HDMI_INTn", "TEST_GPIO2",
+				   "HDMI_INTn", "PD_I2C_IRQ",
 				   "MCASP1_FET_EN", "MCASP1_BUF_BT_EN",
 				   "MCASP1_FET_SEL", "UART1_FET_SEL",
 				   "TSINT#", "IO_EXP_TEST_LED";
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 976f8303c84f..b6667c0ff826 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -242,6 +242,30 @@ &main_i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
+
+	typec_pd0: tps6598x@3f {
+		compatible = "ti,tps6598x";
+		reg = <0x3f>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			self-powered;
+			data-role = "dual";
+			power-role = "sink";
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					usb_con_hs: endpoint {
+						remote-endpoint = <&usb0_hs_ep>;
+					};
+				};
+			};
+		};
+	};
 };
 
 &main_i2c1 {
@@ -321,7 +345,16 @@ &usbss1 {
 };
 
 &usb0 {
-	dr_mode = "peripheral";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	usb-role-switch;
+
+	port@0 {
+		reg = <0>;
+		usb0_hs_ep: endpoint {
+		    remote-endpoint = <&usb_con_hs>;
+	       };
+	};
 };
 
 &usb1 {
-- 
2.34.1


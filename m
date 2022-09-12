Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531045B553A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiILHTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiILHSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:18:55 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A83EF2EF0B;
        Mon, 12 Sep 2022 00:17:06 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 12 Sep 2022 16:15:58 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id D52DE20584CE;
        Mon, 12 Sep 2022 16:15:58 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 12 Sep 2022 16:15:58 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 8F53CB62A4;
        Mon, 12 Sep 2022 16:15:58 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 6/9] arm64: dts: uniphier: Add USB-device support for PXs3 reference board
Date:   Mon, 12 Sep 2022 16:15:51 +0900
Message-Id: <20220912071554.1480-7-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220912071554.1480-1-hayashi.kunihiko@socionext.com>
References: <20220912071554.1480-1-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PXs3 reference board can change each USB port 0 and 1 to device mode
with jumpers. Prepare devicetree sources for USB port 0 and 1.

This specifies dr_mode, pinctrl, and some quirks and removes nodes for
unused phys and vbus-supply properties.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pinctrl.dtsi       | 10 +++++
 arch/arm64/boot/dts/socionext/Makefile        |  4 +-
 .../socionext/uniphier-pxs3-ref-gadget0.dts   | 41 +++++++++++++++++++
 .../socionext/uniphier-pxs3-ref-gadget1.dts   | 40 ++++++++++++++++++
 4 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget0.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget1.dts

diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index c0fd029b37e5..f909ec2e5333 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -196,11 +196,21 @@ pinctrl_usb0: usb0 {
 		function = "usb0";
 	};
 
+	pinctrl_usb0_device: usb0-device {
+		groups = "usb0_device";
+		function = "usb0";
+	};
+
 	pinctrl_usb1: usb1 {
 		groups = "usb1";
 		function = "usb1";
 	};
 
+	pinctrl_usb1_device: usb1-device {
+		groups = "usb1_device";
+		function = "usb1";
+	};
+
 	pinctrl_usb2: usb2 {
 		groups = "usb2";
 		function = "usb2";
diff --git a/arch/arm64/boot/dts/socionext/Makefile b/arch/arm64/boot/dts/socionext/Makefile
index dda3da33614b..33989a9643ac 100644
--- a/arch/arm64/boot/dts/socionext/Makefile
+++ b/arch/arm64/boot/dts/socionext/Makefile
@@ -5,4 +5,6 @@ dtb-$(CONFIG_ARCH_UNIPHIER) += \
 	uniphier-ld20-akebi96.dtb \
 	uniphier-ld20-global.dtb \
 	uniphier-ld20-ref.dtb \
-	uniphier-pxs3-ref.dtb
+	uniphier-pxs3-ref.dtb \
+	uniphier-pxs3-ref-gadget0.dtb \
+	uniphier-pxs3-ref-gadget1.dtb
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget0.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget0.dts
new file mode 100644
index 000000000000..7069f51bc120
--- /dev/null
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget0.dts
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+//
+// Device Tree Source for UniPhier PXs3 Reference Board (for USB-Device #0)
+//
+// Copyright (C) 2021 Socionext Inc.
+//   Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+/dts-v1/;
+#include "uniphier-pxs3-ref.dts"
+
+/ {
+	model = "UniPhier PXs3 Reference Board (USB-Device #0)";
+};
+
+/* I2C3 pinctrl is shared with USB*VBUSIN */
+&i2c3 {
+	status = "disabled";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "peripheral";
+	pinctrl-0 = <&pinctrl_usb0_device>;
+	snps,dis_enblslpm_quirk;
+	snps,dis_u2_susphy_quirk;
+	snps,dis_u3_susphy_quirk;
+	snps,usb2_gadget_lpm_disable;
+	phy-names = "usb2-phy", "usb3-phy";
+	phys = <&usb0_hsphy0>, <&usb0_ssphy0>;
+};
+
+&usb0_hsphy0 {
+	/delete-property/ vbus-supply;
+};
+
+&usb0_ssphy0 {
+	/delete-property/ vbus-supply;
+};
+
+/delete-node/ &usb0_hsphy1;
+/delete-node/ &usb0_ssphy1;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget1.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget1.dts
new file mode 100644
index 000000000000..a3cfa8113ffb
--- /dev/null
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget1.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+//
+// Device Tree Source for UniPhier PXs3 Reference Board (for USB-Device #1)
+//
+// Copyright (C) 2021 Socionext Inc.
+//   Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+/dts-v1/;
+#include "uniphier-pxs3-ref.dts"
+
+/ {
+	model = "UniPhier PXs3 Reference Board (USB-Device #1)";
+};
+
+/* I2C3 pinctrl is shared with USB*VBUSIN */
+&i2c3 {
+	status = "disabled";
+};
+
+&usb1 {
+	status = "okay";
+	dr_mode = "peripheral";
+	pinctrl-0 = <&pinctrl_usb1_device>;
+	snps,dis_enblslpm_quirk;
+	snps,dis_u2_susphy_quirk;
+	snps,dis_u3_susphy_quirk;
+	snps,usb2_gadget_lpm_disable;
+	phy-names = "usb2-phy", "usb3-phy";
+	phys = <&usb1_hsphy0>, <&usb1_ssphy0>;
+};
+
+&usb1_hsphy0 {
+	/delete-property/ vbus-supply;
+};
+
+&usb1_ssphy0 {
+	/delete-property/ vbus-supply;
+};
+
+/delete-node/ &usb1_hsphy1;
-- 
2.25.1


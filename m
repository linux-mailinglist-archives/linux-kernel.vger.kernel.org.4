Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1165D67235C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjARQcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjARQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:31:40 -0500
X-Greylist: delayed 72 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 08:29:37 PST
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B954059B4D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:29:37 -0800 (PST)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230118162823c3ee4325a36ea5a2fe
        for <linux-kernel@vger.kernel.org>;
        Wed, 18 Jan 2023 17:28:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3Caob5l0q9fl1lZH64o8jCtERq+1/3UHqT0YSyFX62s=;
 b=LxHXc3yPGvwdruGGDHlNYNEFW2ufAtHRWcV3bpv33nZZ34to7rBN+wxufxVXEuemPmtgZP
 fA86ajtF4cYHbzIGM08gRqkJelF2OYQb9w1yHFGjgs38LmI9KgWZjg7r1PLQnTZFl06RLr2+
 Yx3JsTvawe9DjWEq+0sR1CmSviHXU=;
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: [PATCH 3/3] arm64: dts: ti: iot2050: Add support for M.2 variant
Date:   Wed, 18 Jan 2023 17:28:20 +0100
Message-Id: <fe57b923d3f290dceea4f54724459015a7bad899.1674059300.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1674059300.git.jan.kiszka@siemens.com>
References: <cover.1674059300.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chao zeng <chao.zeng@siemens.com>

The M.2 variant comes with 2 slots, one B-keyed and another one E-keyed.
They are configured by the firmware during startup. Also the device tree
will be adjusted according to the detect or manually configured
interface mode by the firmware. The kernel only carries a single
configuration as base device tree. It has to be built with a symbols
node so that the firmware can apply overlays for the connector modes.

Signed-off-by: chao zeng <chao.zeng@siemens.com>
[Jan: refactored to a single DT]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/Makefile               |   3 +
 .../dts/ti/k3-am6548-iot2050-advanced-m2.dts  | 122 ++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index cf7c509538a4..13e79bf7e804 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -11,6 +11,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2.dtb
+
+DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
 
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-beagleboneai64.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-common-proc-board.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
new file mode 100644
index 000000000000..3109adac7c93
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Siemens AG, 2018-2022
+ *
+ * Authors:
+ *   Chao Zeng <chao.zeng@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
+ *
+ * AM6548-based (quad-core) IOT2050 M.2 variant (based on Advanced Product
+ * Generation 2), 2 GB RAM, 16 GB eMMC, USB-serial converter on connector X30
+ *
+ * Product homepage:
+ * https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
+ */
+
+#include "k3-am6548-iot2050-advanced-common.dtsi"
+#include "k3-am65-iot2050-common-pg2.dtsi"
+
+/ {
+	compatible = "siemens,iot2050-advanced-m2", "ti,am654";
+	model = "SIMATIC IOT2050 Advanced M2";
+};
+
+&mcu_r5fss0 {
+	/* lock-step mode not supported on this board */
+	ti,cluster-mode = <0>;
+};
+
+&main_pmx0 {
+	main_m2_enable_pins_default: main-m2-enable-pins-default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x01c4, PIN_INPUT_PULLUP, 7)  /* (AH13) GPIO1_17 */
+		>;
+	};
+
+	main_bkey_pcie_reset: main-bkey-pcie-reset {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x01bc, PIN_OUTPUT_PULLUP, 7)  /* (AG13) GPIO1_15 */
+		>;
+	};
+
+	main_pmx0_m2_config_pins_default: main-pmx0-m2-config-pins-default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x01c8, PIN_INPUT_PULLUP, 7)  /* (AE13) GPIO1_18 */
+			AM65X_IOPAD(0x01cc, PIN_INPUT_PULLUP, 7)  /* (AD13) GPIO1_19 */
+		>;
+	};
+
+	main_m2_pcie_mux_control: main-m2-pcie-mux-control {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x0148, PIN_INPUT_PULLUP, 7)  /* (AG22) GPIO0_82 */
+			AM65X_IOPAD(0x0160, PIN_INPUT_PULLUP, 7)  /* (AE20) GPIO0_88 */
+			AM65X_IOPAD(0x0164, PIN_INPUT_PULLUP, 7)  /* (AF19) GPIO0_89 */
+		>;
+	};
+};
+
+&main_pmx1 {
+	main_pmx1_m2_config_pins_default: main-pmx1-m2-config-pins-default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x0018, PIN_INPUT_PULLUP, 7)  /* (B22) GPIO1_88 */
+			AM65X_IOPAD(0x001c, PIN_INPUT_PULLUP, 7)  /* (C23) GPIO1_89 */
+		>;
+	};
+};
+
+&main_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&main_m2_pcie_mux_control
+		&arduino_io_d4_to_d9_pins_default
+	>;
+};
+
+&main_gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&main_m2_enable_pins_default
+		&main_pmx0_m2_config_pins_default
+		&main_pmx1_m2_config_pins_default
+		&cp2102n_reset_pin_default
+
+	>;
+};
+
+/*
+ * Base configuration for B-key slot with PCIe x2, E-key with USB 2.0 only.
+ * Firmware switches to other modes via device tree overlays.
+ */
+
+&serdes0 {
+	assigned-clocks = <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFCLK>;
+	assigned-clock-parents = <&k3_clks 153 8>, <&k3_clks 153 4>;
+};
+
+&pcie0_rc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_bkey_pcie_reset>;
+
+	num-lanes = <2>;
+	phys = <&serdes0 PHY_TYPE_PCIE 1>, <&serdes1 PHY_TYPE_PCIE 1>;
+	phy-names = "pcie-phy0","pcie-phy1";
+	reset-gpios = <&main_gpio1 15 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&pcie1_rc {
+	status = "disabled";
+};
+
+&dwc3_0 {
+	assigned-clock-parents = <&k3_clks 151 4>,  /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
+				 <&k3_clks 151 9>;  /* set PIPE3_TXB_CLK to CLK_12M_RC/256 (for HS only) */
+	/delete-property/ phys;
+	/delete-property/ phy-names;
+};
+
+&usb0 {
+	maximum-speed = "high-speed";
+	/delete-property/ snps,dis-u1-entry-quirk;
+	/delete-property/ snps,dis-u2-entry-quirk;
+};
-- 
2.35.3


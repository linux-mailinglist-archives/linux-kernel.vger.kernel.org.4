Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90D16786C4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjAWTst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjAWTsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:48:32 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7039222C3;
        Mon, 23 Jan 2023 11:48:30 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30NJmPEx029998;
        Mon, 23 Jan 2023 13:48:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674503305;
        bh=tptSK+K9WlreJxDt+ufoKKg8e77b46NODqKZ91yItUI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pEpghtgmm7BTZim/J5U5nxdEsFLbNkpwkYcOXpw5ifGnh+qPCXe4vza2JSjcBctum
         hmyu4S8WUZWhEmugY+gdieF6TiqE5gBD7501zWNaRzCJqgZzJlXlR00O0JWHav3SHM
         l/hxtdYXfG/rEm8MJvecRMwEW7V9pKmSDMY91o6M=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30NJmPAi108327
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jan 2023 13:48:25 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 23
 Jan 2023 13:48:24 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 23 Jan 2023 13:48:24 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30NJmJ0t031936;
        Mon, 23 Jan 2023 13:48:23 -0600
From:   Andrew Davis <afd@ti.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH v3 3/3] ARM: dts: am57xx-idk: Add IDK displays and touchscreens
Date:   Mon, 23 Jan 2023 13:48:18 -0600
Message-ID: <20230123194818.21448-4-afd@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230123194818.21448-1-afd@ti.com>
References: <20230123194818.21448-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a more interesting use of DT Overlays than the previous patches.
Here we have two touchscreen modules. Each is compatible with, and can be
attached to, either of the two AM57xx IDK development board variants
(AM571x or AM572x).

Due to the way the extension header was wired on the development boards,
the touch sensor on the touchscreen modules will connect to different
SoC pins when connected. For this the touch sensor is modeled as an
additional overlay that is specific to the development board for which it
is connected.

Basically the LCD overlay can be swapped, but the touchscreen overlay
that attaches to the LCD must be used with the corresponding base DT
and not to the LCD.

AM571x -\ /- osd101t2045.dtbo -\ /- am571x-idk-touchscreen.dtbo
         X                      X
AM572x -/ \- osd101t2587.dtbo -/ \- am572x-idk-touchscreen.dtbo

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/boot/dts/Makefile                    |  4 ++
 arch/arm/boot/dts/am571x-idk-touchscreen.dtso | 32 +++++++++
 arch/arm/boot/dts/am572x-idk-touchscreen.dtso | 32 +++++++++
 .../boot/dts/am57xx-idk-lcd-osd101t2045.dtso  | 63 ++++++++++++++++++
 .../boot/dts/am57xx-idk-lcd-osd101t2587.dtso  | 66 +++++++++++++++++++
 5 files changed, 197 insertions(+)
 create mode 100644 arch/arm/boot/dts/am571x-idk-touchscreen.dtso
 create mode 100644 arch/arm/boot/dts/am572x-idk-touchscreen.dtso
 create mode 100644 arch/arm/boot/dts/am57xx-idk-lcd-osd101t2045.dtso
 create mode 100644 arch/arm/boot/dts/am57xx-idk-lcd-osd101t2587.dtso

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ecc3b00bc2e2..e3e8b3eb34b0 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1000,8 +1000,12 @@ dtb-$(CONFIG_SOC_DRA7XX) += \
 	am57xx-cl-som-am57x.dtb \
 	am57xx-sbc-am57x.dtb \
 	am572x-idk.dtb \
+	am572x-idk-touchscreen.dtbo \
 	am571x-idk.dtb \
+	am571x-idk-touchscreen.dtbo \
 	am574x-idk.dtb \
+	am57xx-idk-lcd-osd101t2045.dtbo \
+	am57xx-idk-lcd-osd101t2587.dtbo \
 	dra7-evm.dtb \
 	dra72-evm.dtb \
 	dra72-evm-revc.dtb \
diff --git a/arch/arm/boot/dts/am571x-idk-touchscreen.dtso b/arch/arm/boot/dts/am571x-idk-touchscreen.dtso
new file mode 100644
index 000000000000..c051ee6c1130
--- /dev/null
+++ b/arch/arm/boot/dts/am571x-idk-touchscreen.dtso
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019-2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+&i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	touchscreen: edt-ft5506@38 {
+		compatible = "edt,edt-ft5506", "edt,edt-ft5x06";
+
+		reg = <0x38>;
+
+		interrupt-parent = <&gpio5>;
+		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+
+		/* GPIO line is inverted before going to touch panel */
+		reset-gpios = <&gpio6 15 GPIO_ACTIVE_LOW>;
+
+		touchscreen-size-x = <1920>;
+		touchscreen-size-y = <1200>;
+
+		wakeup-source;
+	};
+};
diff --git a/arch/arm/boot/dts/am572x-idk-touchscreen.dtso b/arch/arm/boot/dts/am572x-idk-touchscreen.dtso
new file mode 100644
index 000000000000..573e932b1239
--- /dev/null
+++ b/arch/arm/boot/dts/am572x-idk-touchscreen.dtso
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019-2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+&i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	touchscreen: edt-ft5506@38 {
+		compatible = "edt,edt-ft5506", "edt,edt-ft5x06";
+
+		reg = <0x38>;
+
+		interrupt-parent = <&gpio3>;
+		interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+
+		/* GPIO line is inverted before going to touch panel */
+		reset-gpios = <&gpio6 15 GPIO_ACTIVE_LOW>;
+
+		touchscreen-size-x = <1920>;
+		touchscreen-size-y = <1200>;
+
+		wakeup-source;
+	};
+};
diff --git a/arch/arm/boot/dts/am57xx-idk-lcd-osd101t2045.dtso b/arch/arm/boot/dts/am57xx-idk-lcd-osd101t2045.dtso
new file mode 100644
index 000000000000..25d74e9f3c9e
--- /dev/null
+++ b/arch/arm/boot/dts/am57xx-idk-lcd-osd101t2045.dtso
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019-2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	aliases {
+		display0 = "/display";
+		display1 = "/connector";
+	};
+
+	lcd_bl: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&ecap0 0 50000 1>;
+		brightness-levels = <0 51 53 56 62 75 101 152 255>;
+		default-brightness-level = <8>;
+	};
+};
+
+&dsi_bridge {
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	lcd: display {
+		compatible = "osddisplays,osd101t2045-53ts";
+		reg = <0>;
+
+		label = "lcd";
+
+		backlight = <&lcd_bl>;
+
+		port {
+			lcd_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
+};
+
+&dsi_bridge_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	port@1 {
+		reg = <1>;
+		dsi_out: endpoint {
+			remote-endpoint = <&lcd_in>;
+		};
+	};
+};
+
+&epwmss0 {
+	status = "okay";
+};
+
+&ecap0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am57xx-idk-lcd-osd101t2587.dtso b/arch/arm/boot/dts/am57xx-idk-lcd-osd101t2587.dtso
new file mode 100644
index 000000000000..8cea7ba32487
--- /dev/null
+++ b/arch/arm/boot/dts/am57xx-idk-lcd-osd101t2587.dtso
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019-2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+&{/} {
+	aliases {
+		display0 = "/display";
+		display1 = "/connector";
+	};
+
+	lcd_bl: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&ecap0 0 50000 1>;
+		brightness-levels = <0 51 53 56 62 75 101 152 255>;
+		default-brightness-level = <8>;
+	};
+};
+
+&dsi_bridge {
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	lcd: display {
+		compatible = "osddisplays,osd101t2587-53ts";
+		reg = <0>;
+
+		label = "lcd";
+
+		backlight = <&lcd_bl>;
+
+		port {
+			lcd_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
+};
+
+&dsi_bridge_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	port@1 {
+		reg = <1>;
+		dsi_out: endpoint {
+			remote-endpoint = <&lcd_in>;
+		};
+	};
+};
+
+&epwmss0 {
+	status = "okay";
+};
+
+&ecap0 {
+	status = "okay";
+};
-- 
2.38.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0D669DC08
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjBUIdo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Feb 2023 03:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjBUIdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:33:40 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1DE7ECE;
        Tue, 21 Feb 2023 00:33:32 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id A86E324E203;
        Tue, 21 Feb 2023 16:33:30 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 16:33:30 +0800
Received: from localhost.localdomain (183.27.98.67) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 16:33:29 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>
CC:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v2 01/11] dt-bindings: clock: Add StarFive JH7110 System-Top-Group clock and reset generator
Date:   Tue, 21 Feb 2023 16:33:13 +0800
Message-ID: <20230221083323.302471-2-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221083323.302471-1-xingyu.wu@starfivetech.com>
References: <20230221083323.302471-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.67]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the System-Top-Group clock and reset generator (STGCRG)
on the JH7110 RISC-V SoC by StarFive Ltd.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../clock/starfive,jh7110-stgcrg.yaml         | 82 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 34 ++++++++
 .../dt-bindings/reset/starfive,jh7110-crg.h   | 28 +++++++
 4 files changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
new file mode 100644
index 000000000000..b64ccd84200a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh7110-stgcrg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 System-Top-Group Clock and Reset Generator
+
+maintainers:
+  - Xingyu Wu <xingyu.wu@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh7110-stgcrg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main Oscillator (24 MHz)
+      - description: HIFI4 core
+      - description: STG AXI/AHB
+      - description: USB (125 MHz)
+      - description: CPU Bus
+      - description: HIFI4 Axi
+      - description: NOC STG Bus
+      - description: APB Bus
+
+  clock-names:
+    items:
+      - const: osc
+      - const: hifi4_core
+      - const: stg_axiahb
+      - const: usb_125m
+      - const: cpu_bus
+      - const: hifi4_axi
+      - const: nocstg_bus
+      - const: apb_bus
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive,jh7110-crg.h> for valid indices.
+
+  '#reset-cells':
+    const: 1
+    description:
+      See <dt-bindings/reset/starfive,jh7110-crg.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh7110-crg.h>
+
+    stgcrg: clock-controller@10230000 {
+        compatible = "starfive,jh7110-stgcrg";
+        reg = <0x10230000 0x10000>;
+        clocks = <&osc>,
+                 <&syscrg JH7110_SYSCLK_HIFI4_CORE>,
+                 <&syscrg JH7110_SYSCLK_STG_AXIAHB>,
+                 <&syscrg JH7110_SYSCLK_USB_125M>,
+                 <&syscrg JH7110_SYSCLK_CPU_BUS>,
+                 <&syscrg JH7110_SYSCLK_HIFI4_AXI>,
+                 <&syscrg JH7110_SYSCLK_NOCSTG_BUS>,
+                 <&syscrg JH7110_SYSCLK_APB_BUS>;
+        clock-names = "osc", "hifi4_core",
+                      "stg_axiahb", "usb_125m",
+                      "cpu_bus", "hifi4_axi",
+                      "nocstg_bus", "apb_bus";
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 93eb504c3b21..2e70c9f21989 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19914,6 +19914,7 @@ F:	arch/riscv/boot/dts/starfive/
 STARFIVE JH71X0 CLOCK DRIVERS
 M:	Emil Renner Berthing <kernel@esmil.dk>
 M:	Hal Feng <hal.feng@starfivetech.com>
+M:	Xingyu Wu <xingyu.wu@starfivetech.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/starfive,jh71*.yaml
 F:	drivers/clk/starfive/clk-starfive-jh71*
diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
index 5e4f21ca0642..5ac8a4d90a7a 100644
--- a/include/dt-bindings/clock/starfive,jh7110-crg.h
+++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
  * Copyright 2022 Emil Renner Berthing <kernel@esmil.dk>
+ * Copyright 2022 StarFive Technology Co., Ltd.
  */
 
 #ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
@@ -222,4 +223,37 @@
 
 #define JH7110_AONCLK_END			14
 
+/* STGCRG clocks */
+#define JH7110_STGCLK_HIFI4_CLK_CORE		0
+#define JH7110_STGCLK_USB0_APB			1
+#define JH7110_STGCLK_USB0_UTMI_APB		2
+#define JH7110_STGCLK_USB0_AXI			3
+#define JH7110_STGCLK_USB0_LPM			4
+#define JH7110_STGCLK_USB0_STB			5
+#define JH7110_STGCLK_USB0_APP_125		6
+#define JH7110_STGCLK_USB0_REFCLK		7
+#define JH7110_STGCLK_PCIE0_AXI_MST0		8
+#define JH7110_STGCLK_PCIE0_APB			9
+#define JH7110_STGCLK_PCIE0_TL			10
+#define JH7110_STGCLK_PCIE1_AXI_MST0		11
+#define JH7110_STGCLK_PCIE1_APB			12
+#define JH7110_STGCLK_PCIE1_TL			13
+#define JH7110_STGCLK_PCIE01_SLV_DEC_MAINCLK	14
+#define JH7110_STGCLK_SEC_HCLK			15
+#define JH7110_STGCLK_SEC_MISCAHB		16
+#define JH7110_STGCLK_GRP0_MAIN			17
+#define JH7110_STGCLK_GRP0_BUS			18
+#define JH7110_STGCLK_GRP0_STG			19
+#define JH7110_STGCLK_GRP1_MAIN			20
+#define JH7110_STGCLK_GRP1_BUS			21
+#define JH7110_STGCLK_GRP1_STG			22
+#define JH7110_STGCLK_GRP1_HIFI			23
+#define JH7110_STGCLK_E2_RTC			24
+#define JH7110_STGCLK_E2_CORE			25
+#define JH7110_STGCLK_E2_DBG			26
+#define JH7110_STGCLK_DMA1P_AXI			27
+#define JH7110_STGCLK_DMA1P_AHB			28
+
+#define JH7110_STGCLK_END			29
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh7110-crg.h b/include/dt-bindings/reset/starfive,jh7110-crg.h
index d78e38690ceb..4a865ded78b8 100644
--- a/include/dt-bindings/reset/starfive,jh7110-crg.h
+++ b/include/dt-bindings/reset/starfive,jh7110-crg.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
  * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
  */
 
 #ifndef __DT_BINDINGS_RESET_STARFIVE_JH7110_CRG_H__
@@ -151,4 +152,31 @@
 
 #define JH7110_AONRST_END			8
 
+/* STGCRG resets */
+#define JH7110_STGRST_SYSCON			0
+#define JH7110_STGRST_HIFI4_CORE		1
+#define JH7110_STGRST_HIFI4_AXI			2
+#define JH7110_STGRST_SEC_TOP_HRESETN		3
+#define JH7110_STGRST_E24_CORE			4
+#define JH7110_STGRST_DMA1P_AXI			5
+#define JH7110_STGRST_DMA1P_AHB			6
+#define JH7110_STGRST_USB0_AXI			7
+#define JH7110_STGRST_USB0_APB			8
+#define JH7110_STGRST_USB0_UTMI_APB		9
+#define JH7110_STGRST_USB0_PWRUP		10
+#define JH7110_STGRST_PCIE0_AXI_MST0		11
+#define JH7110_STGRST_PCIE0_AXI_SLV0		12
+#define JH7110_STGRST_PCIE0_AXI_SLV		13
+#define JH7110_STGRST_PCIE0_BRG			14
+#define JH7110_STGRST_PCIE0_CORE		15
+#define JH7110_STGRST_PCIE0_APB			16
+#define JH7110_STGRST_PCIE1_AXI_MST0		17
+#define JH7110_STGRST_PCIE1_AXI_SLV0		18
+#define JH7110_STGRST_PCIE1_AXI_SLV		19
+#define JH7110_STGRST_PCIE1_BRG			20
+#define JH7110_STGRST_PCIE1_CORE		21
+#define JH7110_STGRST_PCIE1_APB			22
+
+#define JH7110_STGRST_END			23
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JH7110_CRG_H__ */
-- 
2.25.1


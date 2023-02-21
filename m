Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA27869DC1E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjBUIeE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Feb 2023 03:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjBUIdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:33:42 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7004015CBD;
        Tue, 21 Feb 2023 00:33:37 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 0237F24E389;
        Tue, 21 Feb 2023 16:33:36 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 16:33:35 +0800
Received: from localhost.localdomain (183.27.98.67) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 16:33:34 +0800
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
Subject: [PATCH v2 07/11] dt-bindings: clock: Add StarFive JH7110 Video-Output clock and reset generator
Date:   Tue, 21 Feb 2023 16:33:19 +0800
Message-ID: <20230221083323.302471-8-xingyu.wu@starfivetech.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Video-Output clock and reset generator (VOUTCRG)
on the JH7110 RISC-V SoC by StarFive Ltd.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../clock/starfive,jh7110-voutcrg.yaml        | 96 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 22 +++++
 .../dt-bindings/reset/starfive,jh7110-crg.h   | 16 ++++
 3 files changed, 134 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
new file mode 100644
index 000000000000..a6a43d86a392
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh7110-voutcrg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 Video-Output Clock and Reset Generator
+
+maintainers:
+  - Xingyu Wu <xingyu.wu@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh7110-voutcrg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Vout Top core
+      - description: Vout Top Ahb
+      - description: Vout Top Axi
+      - description: Vout Top HDMI MCLK
+      - description: I2STX0 BCLK
+      - description: external HDMI pixel
+
+  clock-names:
+    items:
+      - const: vout_src
+      - const: vout_top_ahb
+      - const: vout_top_axi
+      - const: vout_top_hdmitx0_mclk
+      - const: i2stx0_bclk
+      - const: hdmitx0_pixelclk
+
+  resets:
+    items:
+      - description: Vout Top core
+
+  reset-names:
+    items:
+      - const: vout_top_src
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
+  power-domains:
+    maxItems: 1
+    description:
+      Vout domain power
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - '#clock-cells'
+  - '#reset-cells'
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh7110-crg.h>
+    #include <dt-bindings/power/starfive,jh7110-pmu.h>
+    #include <dt-bindings/reset/starfive,jh7110-crg.h>
+
+    voutcrg: clock-controller@295C0000 {
+        compatible = "starfive,jh7110-voutcrg";
+        reg = <0x295C0000 0x10000>;
+        clocks = <&syscrg JH7110_SYSCLK_VOUT_SRC>,
+                 <&syscrg JH7110_SYSCLK_VOUT_TOP_AHB>,
+                 <&syscrg JH7110_SYSCLK_VOUT_TOP_AXI>,
+                 <&syscrg JH7110_SYSCLK_VOUT_TOP_HDMITX0_MCLK>,
+                 <&syscrg JH7110_SYSCLK_I2STX0_BCLK>,
+                 <&hdmitx0_pixelclk>;
+        clock-names = "vout_src", "vout_top_ahb",
+                      "vout_top_axi", "vout_top_hdmitx0_mclk",
+                      "i2stx0_bclk", "hdmitx0_pixelclk";
+        resets = <&syscrg JH7110_SYSRST_VOUT_TOP_SRC>;
+        reset-names = "vout_top_src";
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+        power-domains = <&pwrc JH7110_PD_VOUT>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
index 91ee589809c3..3ebece93cbd3 100644
--- a/include/dt-bindings/clock/starfive,jh7110-crg.h
+++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
@@ -274,4 +274,26 @@
 
 #define JH7110_ISPCLK_END			14
 
+/* VOUTCRG clocks */
+#define JH7110_VOUTCLK_APB			0
+#define JH7110_VOUTCLK_DC8200_PIX		1
+#define JH7110_VOUTCLK_DSI_SYS			2
+#define JH7110_VOUTCLK_TX_ESC			3
+#define JH7110_VOUTCLK_DC8200_AXI		4
+#define JH7110_VOUTCLK_DC8200_CORE		5
+#define JH7110_VOUTCLK_DC8200_AHB		6
+#define JH7110_VOUTCLK_DC8200_PIX0		7
+#define JH7110_VOUTCLK_DC8200_PIX1		8
+#define JH7110_VOUTCLK_DOM_VOUT_TOP_LCD		9
+#define JH7110_VOUTCLK_DSITX_APB		10
+#define JH7110_VOUTCLK_DSITX_SYS		11
+#define JH7110_VOUTCLK_DSITX_DPI		12
+#define JH7110_VOUTCLK_DSITX_TXESC		13
+#define JH7110_VOUTCLK_MIPITX_DPHY_TXESC	14
+#define JH7110_VOUTCLK_HDMI_TX_MCLK		15
+#define JH7110_VOUTCLK_HDMI_TX_BCLK		16
+#define JH7110_VOUTCLK_HDMI_TX_SYS		17
+
+#define JH7110_VOUTCLK_END			18
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh7110-crg.h b/include/dt-bindings/reset/starfive,jh7110-crg.h
index f23c160ec538..3a3a14bed136 100644
--- a/include/dt-bindings/reset/starfive,jh7110-crg.h
+++ b/include/dt-bindings/reset/starfive,jh7110-crg.h
@@ -195,4 +195,20 @@
 
 #define JH7110_ISPRST_END			12
 
+/* VOUTCRG resets */
+#define JH7110_VOUTRST_DC8200_AXI		0
+#define JH7110_VOUTRST_DC8200_AHB		1
+#define JH7110_VOUTRST_DC8200_CORE		2
+#define JH7110_VOUTRST_DSITX_DPI		3
+#define JH7110_VOUTRST_DSITX_APB		4
+#define JH7110_VOUTRST_DSITX_RXESC		5
+#define JH7110_VOUTRST_DSITX_SYS		6
+#define JH7110_VOUTRST_DSITX_TXBYTEHS		7
+#define JH7110_VOUTRST_DSITX_TXESC		8
+#define JH7110_VOUTRST_HDMI_TX_HDMI		9
+#define JH7110_VOUTRST_MIPITX_DPHY_SYS		10
+#define JH7110_VOUTRST_MIPITX_DPHY_TXBYTEHS	11
+
+#define JH7110_VOUTRST_END			12
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JH7110_CRG_H__ */
-- 
2.25.1


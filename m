Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B3E6ECFCA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjDXNy6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Apr 2023 09:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjDXNy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:54:29 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776D75B90;
        Mon, 24 Apr 2023 06:54:25 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 95A7424E1B6;
        Mon, 24 Apr 2023 21:54:18 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 24 Apr
 2023 21:54:18 +0800
Received: from localhost.localdomain (113.72.145.137) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 24 Apr
 2023 21:54:17 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>
CC:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v5 03/10] dt-bindings: clock: Add StarFive JH7110 Image-Signal-Process clock and reset generator
Date:   Mon, 24 Apr 2023 21:54:02 +0800
Message-ID: <20230424135409.6648-4-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230424135409.6648-1-xingyu.wu@starfivetech.com>
References: <20230424135409.6648-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.137]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Image-Signal-Process clock and reset
generator (ISPCRG) on the JH7110 RISC-V SoC by StarFive Ltd.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../clock/starfive,jh7110-ispcrg.yaml         | 87 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 18 ++++
 .../dt-bindings/reset/starfive,jh7110-crg.h   | 16 ++++
 3 files changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-ispcrg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-ispcrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-ispcrg.yaml
new file mode 100644
index 000000000000..3b8b85be5cd0
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-ispcrg.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh7110-ispcrg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 Image-Signal-Process Clock and Reset Generator
+
+maintainers:
+  - Xingyu Wu <xingyu.wu@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh7110-ispcrg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: ISP Top core
+      - description: ISP Top Axi
+      - description: NOC ISP Bus
+      - description: external DVP
+
+  clock-names:
+    items:
+      - const: isp_top_core
+      - const: isp_top_axi
+      - const: noc_bus_isp_axi
+      - const: dvp_clk
+
+  resets:
+    items:
+      - description: ISP Top core
+      - description: ISP Top Axi
+      - description: NOC ISP Bus
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
+      ISP domain power
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
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
+    ispcrg: clock-controller@19810000 {
+        compatible = "starfive,jh7110-ispcrg";
+        reg = <0x19810000 0x10000>;
+        clocks = <&syscrg JH7110_SYSCLK_ISP_TOP_CORE>,
+                 <&syscrg JH7110_SYSCLK_ISP_TOP_AXI>,
+                 <&syscrg JH7110_SYSCLK_NOC_BUS_ISP_AXI>,
+                 <&dvp_clk>;
+        clock-names = "isp_top_core", "isp_top_axi",
+                      "noc_bus_isp_axi", "dvp_clk";
+        resets = <&syscrg JH7110_SYSRST_ISP_TOP>,
+                 <&syscrg JH7110_SYSRST_ISP_TOP_AXI>,
+                 <&syscrg JH7110_SYSRST_NOC_BUS_ISP_AXI>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+        power-domains = <&pwrc JH7110_PD_ISP>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
index 6c8e8b4cf1f6..39acf30db491 100644
--- a/include/dt-bindings/clock/starfive,jh7110-crg.h
+++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
@@ -252,4 +252,22 @@
 
 #define JH7110_STGCLK_END			29
 
+/* ISPCRG clocks */
+#define JH7110_ISPCLK_DOM4_APB_FUNC		0
+#define JH7110_ISPCLK_MIPI_RX0_PXL		1
+#define JH7110_ISPCLK_DVP_INV			2
+#define JH7110_ISPCLK_M31DPHY_CFG_IN		3
+#define JH7110_ISPCLK_M31DPHY_REF_IN		4
+#define JH7110_ISPCLK_M31DPHY_TX_ESC_LAN0	5
+#define JH7110_ISPCLK_VIN_APB			6
+#define JH7110_ISPCLK_VIN_SYS			7
+#define JH7110_ISPCLK_VIN_PIXEL_IF0		8
+#define JH7110_ISPCLK_VIN_PIXEL_IF1		9
+#define JH7110_ISPCLK_VIN_PIXEL_IF2		10
+#define JH7110_ISPCLK_VIN_PIXEL_IF3		11
+#define JH7110_ISPCLK_VIN_P_AXI_WR		12
+#define JH7110_ISPCLK_ISPV2_TOP_WRAPPER_C	13
+
+#define JH7110_ISPCLK_END			14
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh7110-crg.h b/include/dt-bindings/reset/starfive,jh7110-crg.h
index 4e96ab81dd8e..2c5d9dcefffa 100644
--- a/include/dt-bindings/reset/starfive,jh7110-crg.h
+++ b/include/dt-bindings/reset/starfive,jh7110-crg.h
@@ -179,4 +179,20 @@
 
 #define JH7110_STGRST_END			23
 
+/* ISPCRG resets */
+#define JH7110_ISPRST_ISPV2_TOP_WRAPPER_P	0
+#define JH7110_ISPRST_ISPV2_TOP_WRAPPER_C	1
+#define JH7110_ISPRST_M31DPHY_HW		2
+#define JH7110_ISPRST_M31DPHY_B09_AON		3
+#define JH7110_ISPRST_VIN_APB			4
+#define JH7110_ISPRST_VIN_PIXEL_IF0		5
+#define JH7110_ISPRST_VIN_PIXEL_IF1		6
+#define JH7110_ISPRST_VIN_PIXEL_IF2		7
+#define JH7110_ISPRST_VIN_PIXEL_IF3		8
+#define JH7110_ISPRST_VIN_SYS			9
+#define JH7110_ISPRST_VIN_P_AXI_RD		10
+#define JH7110_ISPRST_VIN_P_AXI_WR		11
+
+#define JH7110_ISPRST_END			12
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JH7110_CRG_H__ */
-- 
2.25.1


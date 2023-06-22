Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B542739F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjFVLeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjFVLd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:33:58 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3B6419A9;
        Thu, 22 Jun 2023 04:33:56 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.00,263,1681138800"; 
   d="scan'208";a="164938167"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Jun 2023 20:33:56 +0900
Received: from mulinux.example.org (unknown [10.226.93.117])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0370D41E8FE8;
        Thu, 22 Jun 2023 20:33:51 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/5] spi: dt-bindings: Add bindings for RZ/V2M CSI
Date:   Thu, 22 Jun 2023 12:33:37 +0100
Message-Id: <20230622113341.657842-2-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com>
References: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for the CSI IP found inside the RZ/V2M SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---

v2: no changes

 .../bindings/spi/renesas,rzv2m-csi.yaml       | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzv2m-csi.yaml

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2m-csi.yaml b/Documentation/devicetree/bindings/spi/renesas,rzv2m-csi.yaml
new file mode 100644
index 000000000000..e59183e53690
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2m-csi.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/renesas,rzv2m-csi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/V2M Clocked Serial Interface (CSI)
+
+maintainers:
+  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: renesas,rzv2m-csi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: The clock used to generate the output clock (CSICLK)
+      - description: Internal clock to access the registers (PCLK)
+
+  clock-names:
+    items:
+      - const: csiclk
+      - const: pclk
+
+  resets:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - power-domains
+  - '#address-cells'
+  - '#size-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/r9a09g011-cpg.h>
+    csi4: spi@a4020200 {
+        compatible = "renesas,rzv2m-csi";
+        reg = <0xa4020200 0x80>;
+        interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cpg CPG_MOD R9A09G011_CSI4_CLK>,
+                 <&cpg CPG_MOD R9A09G011_CPERI_GRPH_PCLK>;
+        clock-names = "csiclk", "pclk";
+        resets = <&cpg R9A09G011_CSI_GPH_PRESETN>;
+        power-domains = <&cpg>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
-- 
2.34.1


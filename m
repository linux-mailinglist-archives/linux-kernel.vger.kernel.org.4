Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC611680482
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 04:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjA3D5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 22:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbjA3D5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 22:57:37 -0500
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F187199CF;
        Sun, 29 Jan 2023 19:57:35 -0800 (PST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0FD52201E24;
        Mon, 30 Jan 2023 04:57:34 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A62A920087C;
        Mon, 30 Jan 2023 04:57:33 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D8B28180222F;
        Mon, 30 Jan 2023 11:57:31 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        l.stach@pengutronix.de, shawnguo@kernel.org,
        lorenzo.pieralisi@arm.com, peng.fan@nxp.com, marex@denx.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        frank.li@nxp.com
Cc:     hongxing.zhu@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v7 2/5] dt-bindings: imx6q-pcie: Add schema for i.MX8M PCIe Endpoint modes
Date:   Mon, 30 Jan 2023 11:32:16 +0800
Message-Id: <1675049539-14976-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1675049539-14976-1-git-send-email-hongxing.zhu@nxp.com>
References: <1675049539-14976-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for i.MX8M PCIe Endpoint modes, and update the MAINTAINER
accordingly.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 317 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 318 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
new file mode 100644
index 000000000000..7c594ae53067
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -0,0 +1,317 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX6 PCIe Endpoint controller
+
+maintainers:
+  - Lucas Stach <l.stach@pengutronix.de>
+  - Richard Zhu <hongxing.zhu@nxp.com>
+
+description: |+
+  This PCIe controller is based on the Synopsys DesignWare PCIe IP and
+  thus inherits all the common properties defined in snps,dw-pcie-ep.yaml.
+  The controller instances are dual mode where in they can work either in
+  Root Port mode or Endpoint mode but one at a time.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8mm-pcie-ep
+      - fsl,imx8mq-pcie-ep
+      - fsl,imx8mp-pcie-ep
+
+  reg:
+    minItems: 2
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: addr_space
+
+  interrupts:
+    items:
+      - description: builtin eDMA interrupter.
+
+  interrupt-names:
+    items:
+      - const: dma
+
+  clocks:
+    minItems: 3
+    items:
+      - description: PCIe bridge clock.
+      - description: PCIe bus clock.
+      - description: PCIe PHY clock.
+      - description: Additional required clock entry for imx6sx-pcie-ep,
+          imx8mq-pcie-ep.
+
+  clock-names:
+    minItems: 3
+    items:
+      - const: pcie
+      - const: pcie_bus
+      - enum: [ pcie_phy, pcie_aux ]
+      - enum: [ pcie_inbound_axi, pcie_aux ]
+
+  num-lanes:
+    const: 1
+
+  fsl,imx7d-pcie-phy:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: A phandle to an fsl,imx7d-pcie-phy node. Additional
+      required properties for imx7d-pcie-ep and imx8mq-pcie-ep.
+
+  power-domains:
+    minItems: 1
+    items:
+      - description: The phandle pointing to the DISPLAY domain for
+          imx6sx-pcie-ep, to PCIE_PHY power domain for imx7d-pcie-ep and
+          imx8mq-pcie-ep.
+      - description: The phandle pointing to the PCIE_PHY power domains
+          for imx6sx-pcie-ep.
+
+  power-domain-names:
+    minItems: 1
+    items:
+      - const: pcie
+      - const: pcie_phy
+
+  resets:
+    minItems: 2
+    maxItems: 3
+    description: Phandles to PCIe-related reset lines exposed by SRC
+      IP block. Additional required by imx7d-pcie-ep and imx8mq-pcie-ep.
+
+  reset-names:
+    minItems: 2
+    maxItems: 3
+
+  fsl,tx-deemph-gen1:
+    description: Gen1 De-emphasis value (optional required).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+
+  fsl,tx-deemph-gen2-3p5db:
+    description: Gen2 (3.5db) De-emphasis value (optional required).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+
+  fsl,tx-deemph-gen2-6db:
+    description: Gen2 (6db) De-emphasis value (optional required).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 20
+
+  fsl,tx-swing-full:
+    description: Gen2 TX SWING FULL value (optional required).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 127
+
+  fsl,tx-swing-low:
+    description: TX launch amplitude swing_low value (optional required).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 127
+
+  fsl,max-link-speed:
+    description: Specify PCI Gen for link capability (optional required).
+      Note that the IMX6 LVDS clock outputs do not meet gen2 jitter
+      requirements and thus for gen2 capability a gen2 compliant clock
+      generator should be used and configured.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 3, 4]
+    default: 1
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: pcie-phy
+
+  vpcie-supply:
+    description: Should specify the regulator in charge of PCIe port power.
+      The regulator will be enabled when initializing the PCIe host and
+      disabled either as part of the init process or when shutting down
+      the host (optional required).
+
+  vph-supply:
+    description: Should specify the regulator in charge of VPH one of
+      the three PCIe PHY powers. This regulator can be supplied by both
+      1.8v and 3.3v voltage supplies (optional required).
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - num-lanes
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx6sx-pcie-ep
+    then:
+      properties:
+        clock-names:
+          items:
+            - {}
+            - {}
+            - const: pcie_phy
+            - const: pcie_inbound_axi
+        power-domains:
+          minItems: 2
+        power-domain-names:
+          minItems: 2
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8mq-pcie-ep
+    then:
+      properties:
+        clock-names:
+          items:
+            - {}
+            - {}
+            - const: pcie_phy
+            - const: pcie_aux
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              enum:
+                - fsl,imx6sx-pcie-ep
+                - fsl,imx8mq-pcie-ep
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          maxItems: 3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx6q-pcie-ep
+              - fsl,imx6qp-pcie-ep
+              - fsl,imx7d-pcie-ep
+    then:
+      properties:
+        clock-names:
+          maxItems: 3
+          contains:
+            const: pcie_phy
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8mm-pcie-ep
+              - fsl,imx8mp-pcie-ep
+    then:
+      properties:
+        clock-names:
+          maxItems: 3
+          contains:
+            const: pcie_aux
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx6q-pcie-ep
+              - fsl,imx6qp-pcie-ep
+    then:
+      properties:
+        power-domains: false
+        power-domain-names: false
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - fsl,imx6sx-pcie-ep
+                - fsl,imx6q-pcie-ep
+                - fsl,imx6qp-pcie-ep
+    then:
+      properties:
+        power-domains:
+          maxItems: 1
+        power-domain-names: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx6q-pcie-ep
+              - fsl,imx6sx-pcie-ep
+              - fsl,imx6qp-pcie-ep
+              - fsl,imx7d-pcie-ep
+              - fsl,imx8mq-pcie-ep
+    then:
+      properties:
+        resets:
+          minItems: 3
+        reset-names:
+          items:
+            - const: pciephy
+            - const: apps
+            - const: turnoff
+    else:
+      properties:
+        resets:
+          maxItems: 2
+        reset-names:
+          items:
+            - const: apps
+            - const: turnoff
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mp-clock.h>
+    #include <dt-bindings/power/imx8mp-power.h>
+    #include <dt-bindings/reset/imx8mp-reset.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pcie_ep: pcie-ep@33800000 {
+      compatible = "fsl,imx8mp-pcie-ep";
+      reg = <0x33800000 0x000400000>, <0x18000000 0x08000000>;
+      reg-names = "dbi", "addr_space";
+      clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
+               <&clk IMX8MP_CLK_HSIO_AXI>,
+               <&clk IMX8MP_CLK_PCIE_ROOT>;
+      clock-names = "pcie", "pcie_bus", "pcie_aux";
+      assigned-clocks = <&clk IMX8MP_CLK_PCIE_AUX>;
+      assigned-clock-rates = <10000000>;
+      assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_50M>;
+      num-lanes = <1>;
+      interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>; /* eDMA */
+      interrupt-names = "dma";
+      fsl,max-link-speed = <3>;
+      power-domains = <&hsio_blk_ctrl IMX8MP_HSIOBLK_PD_PCIE>;
+      resets = <&src IMX8MP_RESET_PCIE_CTRL_APPS_EN>,
+               <&src IMX8MP_RESET_PCIE_CTRL_APPS_TURNOFF>;
+      reset-names = "apps", "turnoff";
+      phys = <&pcie_phy>;
+      phy-names = "pcie-phy";
+      num-ib-windows = <4>;
+      num-ob-windows = <4>;
+      status = "disabled";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 5dce1c45f4d1..663a0d5960d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15997,6 +15997,7 @@ M:	Lucas Stach <l.stach@pengutronix.de>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
 F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
 F:	drivers/pci/controller/dwc/*imx6*
 
-- 
2.34.1


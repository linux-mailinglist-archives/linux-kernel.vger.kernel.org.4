Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C07970D813
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbjEWI4n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 May 2023 04:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbjEWI4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:56:32 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D42211F;
        Tue, 23 May 2023 01:56:30 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C4FB024E255;
        Tue, 23 May 2023 16:56:27 +0800 (CST)
Received: from EXMBX173.cuchost.com (172.16.6.93) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 23 May
 2023 16:56:27 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX173.cuchost.com
 (172.16.6.93) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 23 May
 2023 16:56:27 +0800
From:   Jack Zhu <jack.zhu@starfivetech.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jack.zhu@starfivetech.com>,
        <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 1/5] media: dt-bindings: cadence-csi2rx: Convert to DT schema
Date:   Tue, 23 May 2023 16:56:22 +0800
Message-ID: <20230523085626.3295-2-jack.zhu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523085626.3295-1-jack.zhu@starfivetech.com>
References: <20230523085626.3295-1-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX173.cuchost.com
 (172.16.6.93)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert DT bindings document for Cadence MIPI-CSI2 RX controller to
DT schema format.

For compatible, new compatibles should not be messed with conversion,
but the original binding did not specify any SoC-specific compatible
string, so add the StarFive compatible string.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
---
 .../devicetree/bindings/media/cdns,csi2rx.txt | 100 ----------
 .../bindings/media/cdns,csi2rx.yaml           | 177 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 3 files changed, 178 insertions(+), 100 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.txt
 create mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.yaml

diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt b/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
deleted file mode 100644
index 6b02a0657ad9..000000000000
--- a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
+++ /dev/null
@@ -1,100 +0,0 @@
-Cadence MIPI-CSI2 RX controller
-===============================
-
-The Cadence MIPI-CSI2 RX controller is a CSI-2 bridge supporting up to 4 CSI
-lanes in input, and 4 different pixel streams in output.
-
-Required properties:
-  - compatible: must be set to "cdns,csi2rx" and an SoC-specific compatible
-  - reg: base address and size of the memory mapped region
-  - clocks: phandles to the clocks driving the controller
-  - clock-names: must contain:
-    * sys_clk: main clock
-    * p_clk: register bank clock
-    * pixel_if[0-3]_clk: pixel stream output clock, one for each stream
-                         implemented in hardware, between 0 and 3
-
-Optional properties:
-  - phys: phandle to the external D-PHY, phy-names must be provided
-  - phy-names: must contain "dphy", if the implementation uses an
-               external D-PHY
-
-Required subnodes:
-  - ports: A ports node with one port child node per device input and output
-           port, in accordance with the video interface bindings defined in
-           Documentation/devicetree/bindings/media/video-interfaces.txt. The
-           port nodes are numbered as follows:
-
-           Port Description
-           -----------------------------
-           0    CSI-2 input
-           1    Stream 0 output
-           2    Stream 1 output
-           3    Stream 2 output
-           4    Stream 3 output
-
-           The stream output port nodes are optional if they are not
-           connected to anything at the hardware level or implemented
-           in the design.Since there is only one endpoint per port,
-           the endpoints are not numbered.
-
-
-Example:
-
-csi2rx: csi-bridge@0d060000 {
-	compatible = "cdns,csi2rx";
-	reg = <0x0d060000 0x1000>;
-	clocks = <&byteclock>, <&byteclock>
-		 <&coreclock>, <&coreclock>,
-		 <&coreclock>, <&coreclock>;
-	clock-names = "sys_clk", "p_clk",
-		      "pixel_if0_clk", "pixel_if1_clk",
-		      "pixel_if2_clk", "pixel_if3_clk";
-
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port@0 {
-			reg = <0>;
-
-			csi2rx_in_sensor: endpoint {
-				remote-endpoint = <&sensor_out_csi2rx>;
-				clock-lanes = <0>;
-				data-lanes = <1 2>;
-			};
-		};
-
-		port@1 {
-			reg = <1>;
-
-			csi2rx_out_grabber0: endpoint {
-				remote-endpoint = <&grabber0_in_csi2rx>;
-			};
-		};
-
-		port@2 {
-			reg = <2>;
-
-			csi2rx_out_grabber1: endpoint {
-				remote-endpoint = <&grabber1_in_csi2rx>;
-			};
-		};
-
-		port@3 {
-			reg = <3>;
-
-			csi2rx_out_grabber2: endpoint {
-				remote-endpoint = <&grabber2_in_csi2rx>;
-			};
-		};
-
-		port@4 {
-			reg = <4>;
-
-			csi2rx_out_grabber3: endpoint {
-				remote-endpoint = <&grabber3_in_csi2rx>;
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
new file mode 100644
index 000000000000..aba1191b3e77
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
@@ -0,0 +1,177 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/cdns,csi2rx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence MIPI-CSI2 RX controller
+
+maintainers:
+  - Maxime Ripard <mripard@kernel.org>
+
+description:
+  The Cadence MIPI-CSI2 RX controller is a CSI-2 bridge supporting up to 4 CSI
+  lanes in input, and 4 different pixel streams in output.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - starfive,jh7110-csi2rx
+      - const: cdns,csi2rx
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: CSI2Rx system clock
+      - description: Gated Register bank clock for APB interface
+      - description: pixel Clock for Stream interface 0
+      - description: pixel Clock for Stream interface 1
+      - description: pixel Clock for Stream interface 2
+      - description: pixel Clock for Stream interface 3
+
+  clock-names:
+    items:
+      - const: sys_clk
+      - const: p_clk
+      - const: pixel_if0_clk
+      - const: pixel_if1_clk
+      - const: pixel_if2_clk
+      - const: pixel_if3_clk
+
+  phys:
+    maxItems: 1
+    description: MIPI D-PHY
+
+  phy-names:
+    items:
+      - const: dphy
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Input port node, single endpoint describing the CSI-2 transmitter.
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              bus-type:
+                const: 4
+
+              clock-lanes:
+                const: 0
+
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+                items:
+                  maximum: 4
+
+            required:
+              - data-lanes
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Stream 0 Output port node
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Stream 1 Output port node
+
+      port@3:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Stream 2 Output port node
+
+      port@4:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Stream 3 Output port node
+
+    required:
+      - port@0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    csi@d060000 {
+        compatible = "starfive,jh7110-csi2rx", "cdns,csi2rx";
+        reg = <0x0d060000 0x1000>;
+        clocks = <&byteclock 7>, <&byteclock 6>,
+                 <&coreclock 8>, <&coreclock 9>,
+                 <&coreclock 10>, <&coreclock 11>;
+        clock-names = "sys_clk", "p_clk",
+                      "pixel_if0_clk", "pixel_if1_clk",
+                      "pixel_if2_clk", "pixel_if3_clk";
+        phys = <&csi_phy>;
+        phy-names = "dphy";
+
+        ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    csi2rx_in_sensor: endpoint {
+                        remote-endpoint = <&sensor_out_csi2rx>;
+                        clock-lanes = <0>;
+                        data-lanes = <1 2>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    csi2rx_out_grabber0: endpoint {
+                        remote-endpoint = <&grabber0_in_csi2rx>;
+                    };
+                };
+
+                port@2 {
+                    reg = <2>;
+
+                    csi2rx_out_grabber1: endpoint {
+                        remote-endpoint = <&grabber1_in_csi2rx>;
+                    };
+                };
+
+                port@3 {
+                    reg = <3>;
+
+                    csi2rx_out_grabber2: endpoint {
+                        remote-endpoint = <&grabber2_in_csi2rx>;
+                    };
+                };
+
+                port@4 {
+                    reg = <4>;
+
+                    csi2rx_out_grabber3: endpoint {
+                        remote-endpoint = <&grabber3_in_csi2rx>;
+                    };
+                };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index e4810ad34921..869e1c7fc869 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4518,6 +4518,7 @@ M:	Maxime Ripard <mripard@kernel.org>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/cdns,*.txt
+F:	Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
 F:	drivers/media/platform/cadence/cdns-csi2*
 
 CADENCE NAND DRIVER
-- 
2.34.1


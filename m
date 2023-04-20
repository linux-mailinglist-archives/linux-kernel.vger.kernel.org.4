Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2479F6E9175
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbjDTLDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbjDTLDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:03:19 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809F6559D;
        Thu, 20 Apr 2023 04:01:53 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id D76EF24E1C6;
        Thu, 20 Apr 2023 19:00:58 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 20 Apr
 2023 19:00:58 +0800
Received: from ubuntu.localdomain (113.72.144.253) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 20 Apr
 2023 19:00:57 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Minda Chen" <minda.chen@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: [PATCH v5 5/7] dt-bindings: usb: Add StarFive JH7110 USB controller
Date:   Thu, 20 Apr 2023 19:00:50 +0800
Message-ID: <20230420110052.3182-6-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230420110052.3182-1-minda.chen@starfivetech.com>
References: <20230420110052.3182-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.253]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

StarFive JH7110 platforms USB have a wrapper module around
the Cadence USBSS-DRD controller. Add binding information doc
for that.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Peter Chen <peter.chen@kernel.org>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../bindings/usb/starfive,jh7110-usb.yaml     | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml

diff --git a/Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml b/Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
new file mode 100644
index 000000000000..e6bd8a583da3
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/starfive,jh7110-usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 Cadence USBSS-DRD SoC controller
+
+maintainers:
+  - Minda Chen <minda.chen@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh7110-usb
+
+  reg:
+    items:
+      - description: OTG controller registers
+      - description: XHCI Host controller registers
+      - description: DEVICE controller registers
+
+  reg-names:
+    items:
+      - const: otg
+      - const: xhci
+      - const: dev
+
+  interrupts:
+    items:
+      - description: XHCI host controller interrupt
+      - description: Device controller interrupt
+      - description: OTG/DRD controller interrupt
+
+  interrupt-names:
+    items:
+      - const: host
+      - const: peripheral
+      - const: otg
+
+  clocks:
+    items:
+      - description: low power clock
+      - description: STB clock
+      - description: APB clock
+      - description: AXI clock
+      - description: UTMI APB clock
+
+  clock-names:
+    items:
+      - const: lpm
+      - const: stb
+      - const: apb
+      - const: axi
+      - const: utmi_apb
+
+  resets:
+    items:
+      - description: Power up reset
+      - description: APB clock reset
+      - description: AXI clock reset
+      - description: UTMI APB clock reset
+
+  reset-names:
+    items:
+      - const: pwrup
+      - const: apb
+      - const: axi
+      - const: utmi_apb
+
+  starfive,stg-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      -  items:
+           - description: phandle to System Register Controller stg_syscon node.
+           - description: dr mode register offset of STG_SYSCONSAIF__SYSCFG register for USB.
+    description:
+      The phandle to System Register Controller syscon node and the offset
+      of STG_SYSCONSAIF__SYSCFG register for USB.
+
+  dr_mode:
+    enum: [host, otg, peripheral]
+
+  phys:
+    minItems: 1
+    maxItems: 2
+
+  phy-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      anyOf:
+        - const: usb2
+        - const: usb3
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - clocks
+  - resets
+  - starfive,stg-syscon
+  - dr_mode
+
+additionalProperties: false
+
+examples:
+  - |
+    usb@10100000 {
+        compatible = "starfive,jh7110-usb";
+        reg = <0x10100000 0x10000>,
+              <0x10110000 0x10000>,
+              <0x10120000 0x10000>;
+        reg-names = "otg", "xhci", "dev";
+        interrupts = <100>, <108>, <110>;
+        interrupt-names = "host", "peripheral", "otg";
+        clocks = <&syscrg 4>,
+                 <&stgcrg 5>,
+                 <&stgcrg 1>,
+                 <&stgcrg 3>,
+                 <&stgcrg 2>;
+        clock-names = "lpm", "stb", "apb", "axi", "utmi_apb";
+        resets = <&stgcrg 10>,
+                 <&stgcrg 8>,
+                 <&stgcrg 7>,
+                 <&stgcrg 9>;
+        reset-names = "pwrup", "apb", "axi", "utmi_apb";
+        starfive,stg-syscon = <&stg_syscon 0x4>;
+        dr_mode = "host";
+    };
-- 
2.17.1


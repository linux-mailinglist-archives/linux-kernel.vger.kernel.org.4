Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D41864BF90
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbiLMWnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbiLMWnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:43:37 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA98722292;
        Tue, 13 Dec 2022 14:43:35 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,242,1665414000"; 
   d="scan'208";a="143229837"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Dec 2022 07:43:35 +0900
Received: from mulinux.home (unknown [10.226.93.1])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 819BB40F4527;
        Wed, 14 Dec 2022 07:43:30 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH 3/5] dt-bindings: mfd: Add RZ/V2M PWC global registers bindings
Date:   Tue, 13 Dec 2022 22:43:08 +0000
Message-Id: <20221213224310.543243-4-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221213224310.543243-1-fabrizio.castro.jz@renesas.com>
References: <20221213224310.543243-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RZ/V2M PWC is a multi-function device, and its software
support relies on "syscon" and "simple-mfd".
Add the dt-bindings for the top level device tree node.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 .../bindings/mfd/renesas,rzv2m-pwc.yaml       | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml

diff --git a/Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml b/Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml
new file mode 100644
index 000000000000..a7e180bfbd83
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/renesas,rzv2m-pwc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/V2M External Power Sequence Controller (PWC)
+
+description: |+
+  The PWC IP found in the RZ/V2M family of chips comes with the below
+  capabilities
+    - external power supply on/off sequence generation
+    - on/off signal generation for the LPDDR4 core power supply (LPVDD)
+    - key input signals processing
+    - general-purpose output pins
+
+maintainers:
+  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a09g011-pwc # RZ/V2M
+          - renesas,r9a09g055-pwc # RZ/V2MA
+      - const: renesas,rzv2m-pwc
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  gpio:
+    type: object
+    $ref: /schemas/gpio/renesas,rzv2m-pwc-gpio.yaml#
+    description: General-Purpose Output pins controller.
+
+  poweroff:
+    type: object
+    $ref: /schemas/power/reset/renesas,rzv2m-pwc-poweroff.yaml#
+    description: Power OFF controller.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pwc: pwc@a3700000 {
+            compatible = "renesas,r9a09g011-pwc", "renesas,rzv2m-pwc", "syscon",
+                         "simple-mfd";
+            reg = <0xa3700000 0x800>;
+
+            gpio {
+                    compatible = "renesas,r9a09g011-pwc-gpio",
+                                 "renesas,rzv2m-pwc-gpio";
+                    regmap = <&pwc>;
+                    offset = <0x80>;
+                    gpio-controller;
+                    #gpio-cells = <2>;
+            };
+
+            poweroff {
+                    compatible = "renesas,r9a09g011-pwc-poweroff",
+                                 "renesas,rzv2m-pwc-poweroff";
+                    regmap = <&pwc>;
+            };
+    };
-- 
2.34.1


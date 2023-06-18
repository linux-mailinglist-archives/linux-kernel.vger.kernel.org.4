Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB4773460B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 13:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjFRL6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 07:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjFRL6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 07:58:34 -0400
Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de [80.67.18.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DD8E6E;
        Sun, 18 Jun 2023 04:58:33 -0700 (PDT)
Received: from [92.206.161.29] (helo=note-book.lan)
        by smtprelay05.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1qAqs7-00070T-6I; Sun, 18 Jun 2023 13:47:07 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Date:   Sun, 18 Jun 2023 13:45:53 +0200
Subject: [PATCH 1/2] dt-bindings: leds: Add Kinetic KTD2026/2027 LED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230618-ktd202x-v1-1-fc182fefadd7@apitzsch.eu>
References: <20230618-ktd202x-v1-0-fc182fefadd7@apitzsch.eu>
In-Reply-To: <20230618-ktd202x-v1-0-fc182fefadd7@apitzsch.eu>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.12.2
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Kinetic KTD2026/2027 LED driver devicetree bindings.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 .../devicetree/bindings/leds/leds-ktd202x.yaml     | 164 +++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-ktd202x.yaml b/Documentation/devicetree/bindings/leds/leds-ktd202x.yaml
new file mode 100644
index 000000000000..9868d6f6f147
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-ktd202x.yaml
@@ -0,0 +1,164 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-ktd202x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kinetic KTD2026/7 RGB/White LED Driver
+
+maintainers:
+  - André Apitzsch <git@apitzsch.eu>
+
+description: |
+  The KTD2026/7 is a RGB/White LED driver with I2C interface.
+
+  The data sheet can be found at:
+    https://www.kinet-ic.com/uploads/KTD2026-7-04h.pdf
+
+properties:
+  compatible:
+    enum:
+      - kinetic,ktd2026
+      - kinetic,ktd2027
+
+  reg:
+    maxItems: 1
+
+  vin-supply:
+    description: Regulator providing power to the "VIN" pin.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  multi-led:
+    type: object
+    $ref: leds-class-multicolor.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^led@[0-3]$":
+        type: object
+        $ref: common.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            description: Index of the LED.
+            minimum: 0
+            maximum: 3
+
+        required:
+          - reg
+          - color
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
+
+patternProperties:
+  "^led@[0-3]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        description: Index of the LED.
+        minimum: 0
+        maximum: 3
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@30 {
+            compatible = "kinetic,ktd2026";
+            reg = <0x30>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            vin-supply = <&pm8916_l17>;
+
+            led@0 {
+                reg = <0>;
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_RED>;
+            };
+
+            led@1 {
+                reg = <1>;
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_GREEN>;
+            };
+
+            led@2 {
+                reg = <2>;
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_BLUE>;
+            };
+        };
+    };
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@30 {
+            compatible = "kinetic,ktd2026";
+            reg = <0x30>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            vin-supply = <&pm8916_l17>;
+
+            multi-led {
+                color = <LED_COLOR_ID_RGB>;
+                function = LED_FUNCTION_STATUS;
+
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    color = <LED_COLOR_ID_RED>;
+                };
+
+                led@1 {
+                    reg = <1>;
+                    color = <LED_COLOR_ID_GREEN>;
+                };
+
+                led@2 {
+                    reg = <2>;
+                    color = <LED_COLOR_ID_BLUE>;
+                };
+            };
+        };
+    };

-- 
2.41.0


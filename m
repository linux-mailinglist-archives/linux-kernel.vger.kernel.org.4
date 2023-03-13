Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C796B7EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjCMRLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjCMRLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:11:46 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAEB28E5F;
        Mon, 13 Mar 2023 10:11:15 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 5C96520779;
        Mon, 13 Mar 2023 18:09:54 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: gpio: add fcs,fxl6408
Date:   Mon, 13 Mar 2023 18:09:49 +0100
Message-Id: <20230313170950.256964-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230313170950.256964-1-francesco@dolcini.it>
References: <20230313170950.256964-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Add Fairchild FXL6408 8-bit I2C-controlled GPIO expander.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v3:
 * add Reviewed-by: Krzysztof Kozlowski
v2:
 * remove "driver" word from yaml
 * simplify gpio-hog property definition
 * rename fcs,fxl6408-gpio.yaml to fcs,fxl6408.yaml
 * add missing SoB
---
 .../devicetree/bindings/gpio/fcs,fxl6408.yaml | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/fcs,fxl6408.yaml

diff --git a/Documentation/devicetree/bindings/gpio/fcs,fxl6408.yaml b/Documentation/devicetree/bindings/gpio/fcs,fxl6408.yaml
new file mode 100644
index 000000000000..65b6970e42fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/fcs,fxl6408.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/fcs,fxl6408.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Fairchild FXL6408 I2C GPIO Expander
+
+maintainers:
+  - Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
+
+properties:
+  compatible:
+    enum:
+      - fcs,fxl6408
+
+  reg:
+    maxItems: 1
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+  gpio-line-names:
+    minItems: 1
+    maxItems: 8
+
+patternProperties:
+  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
+    required:
+      - gpio-hog
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        gpio_expander_43: gpio-expander@43 {
+            compatible = "fcs,fxl6408";
+            reg = <0x43>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            gpio-line-names = "Wi-Fi_W_DISABLE", "Wi-Fi_WKUP_WLAN",
+                              "PWR_EN_+V3.3_WiFi_N", "PCIe_REF_CLK_EN",
+                              "USB_RESET_N", "USB_BYPASS_N", "Wi-Fi_PDn",
+                              "Wi-Fi_WKUP_BT";
+        };
+    };
-- 
2.25.1


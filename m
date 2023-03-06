Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AF76AB8CE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCFIu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCFIuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:50:24 -0500
X-Greylist: delayed 607 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Mar 2023 00:50:21 PST
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929DF113C4;
        Mon,  6 Mar 2023 00:50:21 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id DE9B620BA7;
        Mon,  6 Mar 2023 09:34:50 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: gpio: add fcs,fxl6408-gpio binding document
Date:   Mon,  6 Mar 2023 09:34:45 +0100
Message-Id: <20230306083446.41082-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306083446.41082-1-francesco@dolcini.it>
References: <20230306083446.41082-1-francesco@dolcini.it>
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

Add binding document for Fairchild FXL6408 GPIO expander.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 .../bindings/gpio/fcs,fxl6408-gpio.yaml       | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/fcs,fxl6408-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/fcs,fxl6408-gpio.yaml b/Documentation/devicetree/bindings/gpio/fcs,fxl6408-gpio.yaml
new file mode 100644
index 000000000000..ccf946040d00
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/fcs,fxl6408-gpio.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/fcs,fxl6408-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: FXL6408 GPIO driver
+
+maintainers:
+  - Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
+
+description: |
+  Driver for Fairchild FXL6408 GPIO expander
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
+    type: object
+    properties:
+      gpio-hog: true
+      gpios: true
+      input: true
+      output-high: true
+      output-low: true
+      line-name: true
+
+    required:
+      - gpio-hog
+      - gpios
+
+    additionalProperties: false
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
+            gpio-controller;
+            #gpio-cells = <2>;
+            reg = <0x43>;
+            gpio-line-names = "Wi-Fi_W_DISABLE", "Wi-Fi_WKUP_WLAN",
+              "PWR_EN_+V3.3_WiFi_N", "PCIe_REF_CLK_EN",
+              "USB_RESET_N", "USB_BYPASS_N", "Wi-Fi_PDn",
+              "Wi-Fi_WKUP_BT";
+        };
+    };
-- 
2.25.1


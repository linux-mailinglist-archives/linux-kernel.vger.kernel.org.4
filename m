Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DBF5F77A1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 13:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJGLrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 07:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJGLrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 07:47:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D049E0D2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 04:47:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oglof-0001AS-BC; Fri, 07 Oct 2022 13:46:57 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1ogloe-0005lQ-2k; Fri, 07 Oct 2022 13:46:56 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1oglod-00BXDN-98; Fri, 07 Oct 2022 13:46:55 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-gpio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de,
        Serge Semin <fancer.lancer@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/2] dt-bindings: gpio: Add gpio-latch binding document
Date:   Fri,  7 Oct 2022 13:46:47 +0200
Message-Id: <20221007114647.2723457-3-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221007114647.2723457-1-s.hauer@pengutronix.de>
References: <20221007114647.2723457-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a binding for a GPIO multiplexer driver based on latches
connected to other GPIOs.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    Changes since v3:
    - Introduce delays between GPIO toggles as suggested by Serge Semin
    
    Changes since v1:
    - Add license to binding file

 .../devicetree/bindings/gpio/gpio-latch.yaml  | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-latch.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-latch.yaml b/Documentation/devicetree/bindings/gpio/gpio-latch.yaml
new file mode 100644
index 0000000000000..1ed82a2cebdaa
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-latch.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/gpio-latch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO latch controller
+
+maintainers:
+  - Sascha Hauer <s.hauer@pengutronix.de>
+
+description: |
+  This binding describes a GPIO multiplexer based on latches connected to
+  other GPIOs, like this:
+
+  CLK0 ----------------------.        ,--------.
+  CLK1 -------------------.  `--------|>    #0 |
+                          |           |        |
+  OUT0 ----------------+--|-----------|D0    Q0|-----|<
+  OUT1 --------------+-|--|-----------|D1    Q1|-----|<
+  OUT2 ------------+-|-|--|-----------|D2    Q2|-----|<
+  OUT3 ----------+-|-|-|--|-----------|D3    Q3|-----|<
+  OUT4 --------+-|-|-|-|--|-----------|D4    Q4|-----|<
+  OUT5 ------+-|-|-|-|-|--|-----------|D5    Q5|-----|<
+  OUT6 ----+-|-|-|-|-|-|--|-----------|D6    Q6|-----|<
+  OUT7 --+-|-|-|-|-|-|-|--|-----------|D7    Q7|-----|<
+         | | | | | | | |  |           `--------'
+         | | | | | | | |  |
+         | | | | | | | |  |           ,--------.
+         | | | | | | | |  `-----------|>    #1 |
+         | | | | | | | |              |        |
+         | | | | | | | `--------------|D0    Q0|-----|<
+         | | | | | | `----------------|D1    Q1|-----|<
+         | | | | | `------------------|D2    Q2|-----|<
+         | | | | `--------------------|D3    Q3|-----|<
+         | | | `----------------------|D4    Q4|-----|<
+         | | `------------------------|D5    Q5|-----|<
+         | `--------------------------|D6    Q6|-----|<
+         `----------------------------|D7    Q7|-----|<
+                                      `--------'
+
+  The number of clk-gpios and latched-gpios is not fixed. The actual number
+  of number of latches and the number of inputs per latch is derived from
+  the number of GPIOs given in the corresponding device tree properties.
+
+properties:
+  compatible:
+    const: gpio-latch
+  "#gpio-cells":
+    const: 2
+
+  clk-gpios:
+    description: Array of GPIOs to be used to clock a latch
+
+  latched-gpios:
+    description: Array of GPIOs to be used as inputs per latch
+
+  setup-duration-ns:
+    description: Delay in nanoseconds to wait after the latch inputs have been
+      set up
+
+  clock-duration-ns:
+    description: Delay in nanoseconds to wait between clock output changes
+
+  gpio-controller: true
+
+  gpio-line-names: true
+
+required:
+  - compatible
+  - "#gpio-cells"
+  - gpio-controller
+  - clk-gpios
+  - latched-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio-latch {
+        #gpio-cells = <2>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_di_do_leds>;
+        compatible = "gpio-latch";
+        gpio-controller;
+        setup-duration-ns = <100>;
+        clock-duration-ns = <100>;
+
+        clk-gpios = <&gpio3 7 0>, <&gpio3 8 0>;
+        latched-gpios = <&gpio3 21 0>, <&gpio3 22 0>,
+                       <&gpio3 23 0>, <&gpio3 24 0>,
+                       <&gpio3 25 0>, <&gpio3 26 0>,
+                       <&gpio3 27 0>, <&gpio3 28 0>;
+    };
-- 
2.30.2


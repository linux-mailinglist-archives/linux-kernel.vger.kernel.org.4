Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB545B81DE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiINHN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiINHNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:13:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB7466110
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:13:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oYMa4-00055g-Tg; Wed, 14 Sep 2022 09:13:08 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1oYMa5-000eMw-Jh; Wed, 14 Sep 2022 09:13:08 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1oYMa3-00Duib-5f; Wed, 14 Sep 2022 09:13:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-gpio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 2/2] dt-bindings: gpio: Add gpio-latch binding document
Date:   Wed, 14 Sep 2022 09:13:06 +0200
Message-Id: <20220914071306.3254881-3-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220914071306.3254881-1-s.hauer@pengutronix.de>
References: <20220914071306.3254881-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a binding for a GPIO multiplexer driver based on latches
connected to other GPIOs.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

Notes:
    Changes since v1:
    - Add license to binding file

 .../devicetree/bindings/gpio/gpio-latch.yaml  | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-latch.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-latch.yaml b/Documentation/devicetree/bindings/gpio/gpio-latch.yaml
new file mode 100644
index 0000000000000..856a9e1e43b45
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-latch.yaml
@@ -0,0 +1,85 @@
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
+
+        clk-gpios = <&gpio3 7 0>, <&gpio3 8 0>;
+        latched-gpios = <&gpio3 21 0>, <&gpio3 22 0>,
+                       <&gpio3 23 0>, <&gpio3 24 0>,
+                       <&gpio3 25 0>, <&gpio3 26 0>,
+                       <&gpio3 27 0>, <&gpio3 28 0>;
+    };
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B563B6ECA2D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjDXKVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjDXKUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:20:44 -0400
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68CD2D74;
        Mon, 24 Apr 2023 03:20:42 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 6767D5E7EF;
        Mon, 24 Apr 2023 12:36:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-QqphgPat;
        Mon, 24 Apr 2023 12:36:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328965;
        bh=C6LBzQtuPvxvqnaOXftP/JvtH1Yc+ydDMGhI/tFJ394=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=s+QToJQjYNoRrTvzrx/bGkiIodhjzt9ryaOtaq3pomjJ9zpDRY5b530Uq9S6ScElD
         uDbR/uVybBjmW5gErNzwWB+k9PnOnRnxBGqtILpqkhhOYrN83x8CQhAK7zGFQ/Q2tn
         An2G6QRjuzRb1BAR2f/mODb2JlLV87wTE123xNDg=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 32/43] dt-bindings: gpio: Add DT bindings ep93xx gpio
Date:   Mon, 24 Apr 2023 15:34:48 +0300
Message-Id: <20230424123522.18302-33-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML bindings for ep93xx SoC.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../devicetree/bindings/gpio/gpio-ep93xx.yaml | 161 ++++++++++++++++++
 1 file changed, 161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-ep93xx.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-ep93xx.yaml b/Documentation/devicetree/bindings/gpio/gpio-ep93xx.yaml
new file mode 100644
index 000000000000..4cf03c325d39
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-ep93xx.yaml
@@ -0,0 +1,161 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/gpio-ep93xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: EP93xx GPIO controller
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+  - Bartosz Golaszewski <brgl@bgdev.pl>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+properties:
+  compatible:
+    const: cirrus,ep9301-gpio
+
+  chip-label:
+    maxItems: 1
+    description: human readable name.
+
+  reg:
+    minItems: 2
+    items:
+      - description: data register
+      - description: direction register
+      - description: interrupt registers base
+
+  reg-names:
+    minItems: 2
+    items:
+      - const: data
+      - const: dir
+      - const: intr
+
+  gpio-controller: true
+
+  gpio-ranges: true
+
+  "#gpio-cells":
+    const: 2
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupts:
+    items:
+      - const: 27
+
+  interrupts-extended:
+    minItems: 8
+    maxItems: 8
+    description: port F has dedicated irq line for each gpio line.
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
+        gpio0: gpio@80840000 {
+                compatible = "cirrus,ep9301-gpio";
+                chip-label = "A";
+                reg = <0x80840000 0x04>,
+                      <0x80840010 0x04>,
+                      <0x80840090 0x1c>;
+                reg-names = "data", "dir", "intr";
+                gpio-controller;
+                #gpio-cells = <2>;
+                interrupt-controller;
+                interrupt-parent = <&vic1>;
+                interrupts = <27>;
+        };
+
+        gpio1: gpio@80840004 {
+                compatible = "cirrus,ep9301-gpio";
+                chip-label = "B";
+                reg = <0x80840004 0x04>,
+                      <0x80840014 0x04>,
+                      <0x808400ac 0x1c>;
+                reg-names = "data", "dir", "intr";
+                gpio-controller;
+                #gpio-cells = <2>;
+                interrupt-controller;
+                interrupt-parent = <&vic1>;
+                interrupts = <27>;
+        };
+
+        gpio2: gpio@80840008 {
+                compatible = "cirrus,ep9301-gpio";
+                chip-label = "C";
+                reg = <0x80840008 0x04>,
+                      <0x80840018 0x04>;
+                reg-names = "data", "dir";
+                gpio-controller;
+                #gpio-cells = <2>;
+        };
+
+        gpio3: gpio@8084000c {
+                compatible = "cirrus,ep9301-gpio";
+                chip-label = "D";
+                reg = <0x8084000c 0x04>,
+                      <0x8084001c 0x04>;
+                reg-names = "data", "dir";
+                gpio-controller;
+                #gpio-cells = <2>;
+        };
+
+        gpio4: gpio@80840020 {
+                compatible = "cirrus,ep9301-gpio";
+                chip-label = "E";
+                reg = <0x80840020 0x04>,
+                      <0x80840024 0x04>;
+                reg-names = "data", "dir";
+                gpio-controller;
+                #gpio-cells = <2>;
+        };
+
+        gpio5: gpio@80840030 {
+                compatible = "cirrus,ep9301-gpio";
+                chip-label = "F";
+                reg = <0x80840030 0x04>,
+                      <0x80840034 0x04>,
+                      <0x8084004c 0x1c>;
+                reg-names = "data", "dir", "intr";
+                gpio-controller;
+                #gpio-cells = <2>;
+                interrupt-controller;
+                interrupts-extended = <&vic0 19>, <&vic0 20>,
+                                      <&vic0 21>, <&vic0 22>,
+                                      <&vic1 15>, <&vic1 16>,
+                                      <&vic1 17>, <&vic1 18>;
+        };
+
+        gpio6: gpio@80840038 {
+                compatible = "cirrus,ep9301-gpio";
+                chip-label = "G";
+                reg = <0x80840038 0x04>,
+                      <0x8084003c 0x04>;
+                reg-names = "data", "dir";
+                gpio-controller;
+                #gpio-cells = <2>;
+        };
+
+        gpio7: gpio@80840040 {
+                compatible = "cirrus,ep9301-gpio";
+                chip-label = "H";
+                reg = <0x80840040 0x04>,
+                      <0x80840044 0x04>;
+                reg-names = "data", "dir";
+                gpio-controller;
+                #gpio-cells = <2>;
+        };
+
+...
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AB97192A6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjFAFru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjFAFq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:46:58 -0400
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8BA10D7;
        Wed, 31 May 2023 22:46:26 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward102a.mail.yandex.net (Yandex) with ESMTP id 30B0746C97;
        Thu,  1 Jun 2023 08:46:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pjGDMhnDduQ0-IRRIO8Qs;
        Thu, 01 Jun 2023 08:46:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685598382;
        bh=y5M8VTUW3Md/hfd4UTZu0tzO/lLbxF8tmPlhgvZrA64=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=c3PRzP6xMt4i1Mcj+rmou0EgPPmFR1bcDTSBPXpHdSwpw3+jRImJuAWDO2i9BfriS
         8jW/btdn/W7mOVSE3DIV9XNgxpQO05wXTcv3CM0RPvhdCJPVUx67kN8+ZP+B6Urf6m
         NzZgNvHv+x9IDbWph43D1mF2XsR+a6NhRrIgLv1E=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 33/43] dt-bindings: gpio: Add Cirrus EP93xx
Date:   Thu,  1 Jun 2023 08:45:38 +0300
Message-Id: <20230601054549.10843-15-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML bindings for ep93xx SoC gpio controller.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../devicetree/bindings/gpio/gpio-ep9301.yaml | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-ep9301.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-ep9301.yaml b/Documentation/devicetree/bindings/gpio/gpio-ep9301.yaml
new file mode 100644
index 000000000000..daadfb4926c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-ep9301.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/gpio-ep9301.yaml#
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
+    oneOf:
+      - const: cirrus,ep9301-gpio
+      - items:
+          - enum:
+              - cirrus,ep9302-gpio
+              - cirrus,ep9307-gpio
+              - cirrus,ep9312-gpio
+              - cirrus,ep9315-gpio
+          - const: cirrus,ep9301-gpio
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
+    oneOf:
+      - maxItems: 1
+      - description: port F has dedicated irq line for each gpio line
+        maxItems: 8
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
+    gpio@80840000 {
+      compatible = "cirrus,ep9301-gpio";
+      reg = <0x80840000 0x04>,
+            <0x80840010 0x04>,
+            <0x80840090 0x1c>;
+      reg-names = "data", "dir", "intr";
+      gpio-controller;
+      #gpio-cells = <2>;
+        interrupt-controller;
+        interrupt-parent = <&vic1>;
+        interrupts = <27>;
+    };
+
+    gpio@80840004 {
+      compatible = "cirrus,ep9301-gpio";
+      reg = <0x80840004 0x04>,
+            <0x80840014 0x04>,
+            <0x808400ac 0x1c>;
+      reg-names = "data", "dir", "intr";
+      gpio-controller;
+      #gpio-cells = <2>;
+      interrupt-controller;
+      interrupt-parent = <&vic1>;
+      interrupts = <27>;
+    };
+
+    gpio@80840008 {
+      compatible = "cirrus,ep9301-gpio";
+      reg = <0x80840008 0x04>,
+            <0x80840018 0x04>;
+      reg-names = "data", "dir";
+      gpio-controller;
+      #gpio-cells = <2>;
+    };
+
+    gpio@8084000c {
+      compatible = "cirrus,ep9301-gpio";
+      reg = <0x8084000c 0x04>,
+            <0x8084001c 0x04>;
+      reg-names = "data", "dir";
+      gpio-controller;
+      #gpio-cells = <2>;
+    };
+
+    gpio@80840020 {
+      compatible = "cirrus,ep9301-gpio";
+      reg = <0x80840020 0x04>,
+            <0x80840024 0x04>;
+      reg-names = "data", "dir";
+      gpio-controller;
+      #gpio-cells = <2>;
+    };
+
+    gpio@80840030 {
+      compatible = "cirrus,ep9301-gpio";
+      reg = <0x80840030 0x04>,
+            <0x80840034 0x04>,
+            <0x8084004c 0x1c>;
+      reg-names = "data", "dir", "intr";
+      gpio-controller;
+      #gpio-cells = <2>;
+      interrupt-controller;
+      interrupts-extended = <&vic0 19>, <&vic0 20>,
+                            <&vic0 21>, <&vic0 22>,
+                            <&vic1 15>, <&vic1 16>,
+                            <&vic1 17>, <&vic1 18>;
+    };
+
+    gpio@80840038 {
+      compatible = "cirrus,ep9301-gpio";
+      reg = <0x80840038 0x04>,
+            <0x8084003c 0x04>;
+      reg-names = "data", "dir";
+      gpio-controller;
+      #gpio-cells = <2>;
+    };
+
+    gpio@80840040 {
+      compatible = "cirrus,ep9301-gpio";
+      reg = <0x80840040 0x04>,
+            <0x80840044 0x04>;
+      reg-names = "data", "dir";
+      gpio-controller;
+      #gpio-cells = <2>;
+    };
+
+...
-- 
2.37.4


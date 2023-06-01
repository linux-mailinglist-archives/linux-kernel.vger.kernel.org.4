Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB6D719245
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjFAFgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjFAFgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:36:43 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2460912C;
        Wed, 31 May 2023 22:36:41 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:c83:0:640:84f9:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id 08A01600FE;
        Thu,  1 Jun 2023 08:36:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id OaGNfZvWv8c0-EA4TW9tK;
        Thu, 01 Jun 2023 08:36:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685597798;
        bh=aaIioyIMKCqCjeUPUyEeDP5JYK35Mvbg7Xu5/kphzck=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=V6TM8hjlijGeiiJl0uydmitJ8Fg4Q31EcwEA6K/fsuNCDAX6hBPmL+cLSTV8WBWcg
         vMtgph5ENeq7Tg22oLVrLz/xE32zIuo+fnXktp9udJcYcy81bUl4GV/ENCNVTYDjah
         UvXerAGNKmY9ZD2Vvvrl58SdH3AbcallMZY2tRyc=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v1 02/43] dt-bindings: soc: Add Cirrus EP93xx
Date:   Thu,  1 Jun 2023 08:33:53 +0300
Message-Id: <20230601053546.9574-3-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds device tree bindings for the Cirrus Logic EP93xx.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    v0 -> v1:
    
    - fixed compatible - now it specifies three boards
    	- ts7250
    	- bk3
    	- edb9302
    - fixed identation in example
    - dropped labels

 .../devicetree/bindings/arm/ep93xx.yaml       | 107 ++++++++++++++++++
 .../dt-bindings/clock/cirrus,ep93xx-clock.h   |  53 +++++++++
 2 files changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/ep93xx.yaml
 create mode 100644 include/dt-bindings/clock/cirrus,ep93xx-clock.h

diff --git a/Documentation/devicetree/bindings/arm/ep93xx.yaml b/Documentation/devicetree/bindings/arm/ep93xx.yaml
new file mode 100644
index 000000000000..bcf9754d0763
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ep93xx.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/ep93xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic EP93xx device tree bindings
+
+description: |+
+  The EP93xx SoC is a ARMv4T-based with 200 MHz ARM9 CPU.
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: The TS-7250 is a compact, full-featured Single Board Computer (SBC)
+          based upon the Cirrus EP9302 ARM9 CPU
+        items:
+          - const: technologic,ts7250
+          - const: cirrus,ep9301
+
+      - description: The Liebherr BK3 is a derivate from ts7250 board
+        items:
+          - const: liebherr,bk3
+          - const: cirrus,ep9301
+
+      - description: EDB302 is an evaluation board by Cirrus Logic,
+          based on a Cirrus Logic EP9302 CPU
+        items:
+          - const: cirrus,edb9302
+          - const: cirrus,ep9301
+
+  soc:
+    type: object
+    patternProperties:
+      "^.*syscon@80930000$":
+        type: object
+        properties:
+          compatible:
+            items:
+              - const: cirrus,ep9301-syscon
+              - const: syscon
+              - const: simple-mfd
+          ep9301-reboot:
+            type: object
+            properties:
+              compatible:
+                const: cirrus,ep9301-reboot
+        required:
+          - compatible
+          - reg
+          - ep9301-reboot
+
+      "^.*timer@80810000$":
+        type: object
+        properties:
+          compatible:
+            const: cirrus,ep9301-timer
+
+    required:
+      - syscon@80930000
+      - timer@80810000
+
+required:
+  - compatible
+  - soc
+
+additionalProperties: true
+
+examples:
+  - |
+    / {
+      compatible = "technologic,ts7250", "cirrus,ep9301";
+      model = "TS-7250 SBC";
+      #address-cells = <1>;
+      #size-cells = <1>;
+      soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+        compatible = "simple-bus";
+
+        syscon@80930000 {
+          compatible = "cirrus,ep9301-syscon",
+                        "syscon", "simple-mfd";
+          reg = <0x80930000 0x1000>;
+
+          ep9301-reboot {
+            compatible = "cirrus,ep9301-reboot";
+          };
+        };
+
+        timer@80810000 {
+          compatible = "cirrus,ep9301-timer";
+          reg = <0x80810000 0x100>;
+          interrupt-parent = <&vic1>;
+          interrupts = <19>;
+        };
+      };
+    };
+
+...
diff --git a/include/dt-bindings/clock/cirrus,ep93xx-clock.h b/include/dt-bindings/clock/cirrus,ep93xx-clock.h
new file mode 100644
index 000000000000..6a8cf33d811b
--- /dev/null
+++ b/include/dt-bindings/clock/cirrus,ep93xx-clock.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef DT_BINDINGS_CIRRUS_EP93XX_CLOCK_H
+#define DT_BINDINGS_CIRRUS_EP93XX_CLOCK_H
+
+#define EP93XX_CLK_XTALI	0
+
+#define EP93XX_CLK_PLL1		1
+#define EP93XX_CLK_FCLK		2
+#define EP93XX_CLK_HCLK		3
+#define EP93XX_CLK_PCLK		4
+#define EP93XX_CLK_PLL2		5
+
+#define EP93XX_CLK_UART		6
+
+#define EP93XX_CLK_UART1	7
+#define EP93XX_CLK_UART2	8
+#define EP93XX_CLK_UART3	9
+
+#define EP93XX_CLK_M2M0		10
+#define EP93XX_CLK_M2M1		11
+
+#define EP93XX_CLK_M2P0		12
+#define EP93XX_CLK_M2P1		13
+#define EP93XX_CLK_M2P2		14
+#define EP93XX_CLK_M2P3		15
+#define EP93XX_CLK_M2P4		16
+#define EP93XX_CLK_M2P5		17
+#define EP93XX_CLK_M2P6		18
+#define EP93XX_CLK_M2P7		19
+#define EP93XX_CLK_M2P8		20
+#define EP93XX_CLK_M2P9		21
+
+#define EP93XX_CLK_SPI		22
+
+#define EP93XX_CLK_USB		23
+
+#define EP93XX_CLK_ADC		24
+#define EP93XX_CLK_ADC_EN	25
+
+#define EP93XX_CLK_KEYPAD       26
+
+#define EP93XX_CLK_PWM		27
+
+#define EP93XX_CLK_VIDEO	28
+
+#define EP93XX_CLK_I2S_MCLK	29
+#define EP93XX_CLK_I2S_SCLK	30
+#define EP93XX_CLK_I2S_LRCLK	31
+
+
+#define EP93XX_NUM_CLKS (EP93XX_CLK_I2S_LRCLK + 1)
+
+#endif /* DT_BINDINGS_CIRRUS_EP93XX_CLOCK_H */
-- 
2.37.4


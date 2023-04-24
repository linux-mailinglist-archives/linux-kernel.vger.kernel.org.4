Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5286EC977
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjDXJvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjDXJvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:51:39 -0400
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82444E2;
        Mon, 24 Apr 2023 02:51:32 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward501b.mail.yandex.net (Yandex) with ESMTP id 2C9835EB09;
        Mon, 24 Apr 2023 12:35:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-PugXVV2y;
        Mon, 24 Apr 2023 12:35:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328945;
        bh=zEohvvi5jcGAdvJYuQgDDbgSuHmAwruvCaRdhaNqILY=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=lT+bS88MebwD7/X8CoNTFe4dw8aR+hv5EJXM/+buz/nbg4M7wWjfTCO77HWO5Paym
         I8UGTcsfTyXK6H6y3xLjkxjsGLQuZ5voQfsnj7ZW2Sh8HChCK0QVIos1P4fuMP+dyQ
         lwQGxwxVswX1S2MkQ8CvA59JOZmcuUT9+6nN+dc8=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 11/43] dt-bindings: clock: add DT bindings for Cirrus EP93xx
Date:   Mon, 24 Apr 2023 15:34:27 +0300
Message-Id: <20230424123522.18302-12-nikita.shubin@maquefel.me>
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

This adds device tree bindings for the Cirrus Logic EP93xx
clock block used in these SoCs.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../devicetree/bindings/arm/ep93xx.yaml       | 102 ++++++++++++++++++
 .../dt-bindings/clock/cirrus,ep93xx-clock.h   |  53 +++++++++
 2 files changed, 155 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/ep93xx.yaml
 create mode 100644 include/dt-bindings/clock/cirrus,ep93xx-clock.h

diff --git a/Documentation/devicetree/bindings/arm/ep93xx.yaml b/Documentation/devicetree/bindings/arm/ep93xx.yaml
new file mode 100644
index 000000000000..de7020f4f356
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ep93xx.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/ep93xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logick EP93xx device tree bindings
+
+description: |+
+  The EP93xx SoC is a ARMv4T-based with 200 MHz ARM9 CPU.
+
+maintainers:
+  - Hartley Sweeten <hsweeten@visionengravers.com>
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: The TS-7250 is a compact, full-featured Single Board Computer (SBC)
+          based upon the Cirrus EP9302 ARM9 CPU.
+        items:
+          - const: technologic,ts7250
+          - const: liebherr,bk3
+          - const: cirrus,ep9301
+          - const: cirrus,edb9302
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
+          - '#clock-cells'
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
+          #address-cells = <1>;
+          #size-cells = <1>;
+          ranges;
+          compatible = "simple-bus";
+
+          syscon: syscon@80930000 {
+                  compatible = "cirrus,ep9301-syscon",
+                                  "syscon", "simple-mfd";
+                  reg = <0x80930000 0x1000>;
+                  #clock-cells = <1>;
+                  #reset-cells = <1>;
+
+                  ep9301-reboot {
+                          compatible = "cirrus,ep9301-reboot";
+                  };
+          };
+
+          timer: timer@80810000 {
+                  compatible = "cirrus,ep9301-timer";
+                  reg = <0x80810000 0x100>;
+                  interrupt-parent = <&vic1>;
+                  interrupts = <19>;
+          };
+      };
+    };
+
+...
diff --git a/include/dt-bindings/clock/cirrus,ep93xx-clock.h b/include/dt-bindings/clock/cirrus,ep93xx-clock.h
new file mode 100644
index 000000000000..ad796314fb11
--- /dev/null
+++ b/include/dt-bindings/clock/cirrus,ep93xx-clock.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
2.39.2


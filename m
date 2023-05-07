Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9E46F9BD7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 23:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjEGVTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 17:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjEGVT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 17:19:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E52124B2
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 14:19:25 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f1411e8111so4250186e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 14:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683494363; x=1686086363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQ1qf2e03WlPLJuXOlZ1OBamEh8pCtH4w3SZqhsTCas=;
        b=gOQjODFEyx60bJvAHj8ImMrN5WFGCfGZkIK4W7lPRvxxDsUPO7qHekVariVG1p6T2q
         XKqPrP8X6LeSUZMQf6ciJS41Yee/2XzN3Yr07AYlCeFnBBsBnxwQKceRtpKNbdIT2SSq
         0Utn6R2HSIFpGD9kYk4NArK3sZX0nkuBE7P84xU6h6h56DhEaLQPg6pG6EvDjxglofST
         izkJwJUgK99dZI3v9YqyBL+VN1d4HfgQ61HgualuYgwldluMJ4Ku+SPXiuXXTeosVZdE
         pBB/jX//o4r9yscalyvjy0TZLC7hwU4hRUgIXmHbMUIUf4kkdGC6BkmrBlPsMkyVUMRr
         cyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683494363; x=1686086363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQ1qf2e03WlPLJuXOlZ1OBamEh8pCtH4w3SZqhsTCas=;
        b=dRxfcsDo/Jdg4MsIZlmTVlUp+Y7M8ZoxajSHxNnyIQAjnuOaz/pVhLVcwmC7LWoSd0
         ZDFxSmhmEagNIQGeG/103QGYqK4mJQWXlJJ/OL/D6TRuVbeK/+Ywwk0zUQzuPZXZpXlc
         I74rO7zZ6TAZLjyEorkx6Q8QF+r63PzTw2m+MAQ72KuoWdONjohDhGK0qCjY4EofZxp6
         pRVn8Px/JJ9uu1wMaDfsfK6UuTZLHu3QG3fxo8MmTmJNQ+Icvd8CDm4dRbCp2ZN8HOz1
         ja0G4b6xmaWAhQTdMX98B5NMIZvBSRRV02jNsM2MGeqRh9Uo2sWhT8gMCHESPY6FPiZz
         6qlw==
X-Gm-Message-State: AC+VfDzYbEOZZjV9ZDHD+RcDttBES0JohCHv5bm5MlclZ7QnDS3c/sjK
        BD5JJdX6seg0enDf82eEtdWOmw==
X-Google-Smtp-Source: ACHHUZ5xfjVDAtU6I0Xjeidp0geO22VrvIZjfkxNd+8IwuNg1i9Y1IDGhyHQd4PWFnvhtqhUf2KxKA==
X-Received: by 2002:a19:7518:0:b0:4f1:b3ab:cd61 with SMTP id y24-20020a197518000000b004f1b3abcd61mr1185315lfe.61.1683494363481;
        Sun, 07 May 2023 14:19:23 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id c27-20020ac244bb000000b004f195cc3918sm623424lfm.176.2023.05.07.14.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 14:19:22 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 07 May 2023 23:19:20 +0200
Subject: [PATCH v3 2/2] dt-bindings: MFD: Convert STMPE to YAML schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230426-stmpe-dt-bindings-v3-2-eac1d736e488@linaro.org>
References: <20230426-stmpe-dt-bindings-v3-0-eac1d736e488@linaro.org>
In-Reply-To: <20230426-stmpe-dt-bindings-v3-0-eac1d736e488@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the STMPE MFD device tree bindings to the YAML
schema.

Reference the existing schema for the ADC, just define the
other subnode schemas directly in the MFD schema.

Add two examples so we have examples covering both the simple
GPIO expander and the more complex with ADC and touchscreen.

Some in-tree users do not follow the naming conventions for nodes
so these DTS files need to be augmented to use proper node names
like "adc", "pwm", "gpio", "keyboard-controller" etc before the
bindings take effect on them.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Drop the required pwm properties already required by the
  template pwm schema.
- Add the number of PWM cells as const.
ChangeLog v1->v2:
- Split off the GPIO bindings to their own schema, as the old
  bindings didn't even have any GPIO bindings. Put the GPIO
  schema before this schema so we can use GPIO in the examples.
- Drop nodename and pattern as STMPE is not a generic name.
- Add maxItems to the resets.
- Make wakeup-source just :true, as it is a generic property.
- Move unevaluatedProperties for subnodes right before properties
  as requested.
- Name devices "port-expander" in the examples.
- Use lowercase hex in line init.
---
 .../devicetree/bindings/input/stmpe-keypad.txt     |  41 ---
 .../bindings/input/touchscreen/stmpe.txt           | 108 --------
 .../devicetree/bindings/mfd/st,stmpe.yaml          | 297 +++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/stmpe.txt    |  42 ---
 4 files changed, 297 insertions(+), 191 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/stmpe-keypad.txt b/Documentation/devicetree/bindings/input/stmpe-keypad.txt
deleted file mode 100644
index 12bb771d66d4..000000000000
--- a/Documentation/devicetree/bindings/input/stmpe-keypad.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-* STMPE Keypad
-
-Required properties:
- - compatible               : "st,stmpe-keypad"
- - linux,keymap             : See ./matrix-keymap.txt
-
-Optional properties:
- - debounce-interval        : Debouncing interval time in milliseconds
- - st,scan-count            : Scanning cycles elapsed before key data is updated
- - st,no-autorepeat         : If specified device will not autorepeat
- - keypad,num-rows          : See ./matrix-keymap.txt
- - keypad,num-columns       : See ./matrix-keymap.txt
-
-Example:
-
-	stmpe_keypad {
-		compatible = "st,stmpe-keypad";
-
-		debounce-interval = <64>;
-		st,scan-count = <8>;
-		st,no-autorepeat;
-
-		linux,keymap = <0x205006b
-				0x4010074
-				0x3050072
-				0x1030004
-				0x502006a
-				0x500000a
-				0x5008b
-				0x706001c
-				0x405000b
-				0x6070003
-				0x3040067
-				0x303006c
-				0x60400e7
-				0x602009e
-				0x4020073
-				0x5050002
-				0x4030069
-				0x3020008>;
-	};
diff --git a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
deleted file mode 100644
index 238b51555c04..000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
+++ /dev/null
@@ -1,108 +0,0 @@
-STMPE Touchscreen
-----------------
-
-Required properties:
- - compatible: "st,stmpe-ts"
-
-Optional properties:
-- st,ave-ctrl		: Sample average control
-				0 -> 1 sample
-				1 -> 2 samples
-				2 -> 4 samples
-				3 -> 8 samples
-- st,touch-det-delay	: Touch detect interrupt delay (recommended is 3)
-				0 -> 10 us
-				1 -> 50 us
-				2 -> 100 us
-				3 -> 500 us
-				4 -> 1 ms
-				5 -> 5 ms
-				6 -> 10 ms
-				7 -> 50 ms
-- st,settling		: Panel driver settling time (recommended is 2)
-				0 -> 10 us
-				1 -> 100 us
-				2 -> 500 us
-				3 -> 1 ms
-				4 -> 5 ms
-				5 -> 10 ms
-				6 -> 50 ms
-				7 -> 100 ms
-- st,fraction-z		: Length of the fractional part in z (recommended is 7)
-			  (fraction-z ([0..7]) = Count of the fractional part)
-- st,i-drive		: current limit value of the touchscreen drivers
-				0 -> 20 mA (typical 35mA max)
-				1 -> 50 mA (typical 80 mA max)
-
-Optional properties common with MFD (deprecated):
- - st,sample-time	: ADC conversion time in number of clock.
-				0 -> 36 clocks
-				1 -> 44 clocks
-				2 -> 56 clocks
-				3 -> 64 clocks
-				4 -> 80 clocks (recommended)
-				5 -> 96 clocks
-				6 -> 124 clocks
- - st,mod-12b		: ADC Bit mode
-				0 -> 10bit ADC
-				1 -> 12bit ADC
- - st,ref-sel		: ADC reference source
-				0 -> internal
-				1 -> external
- - st,adc-freq		: ADC Clock speed
-				0 -> 1.625 MHz
-				1 -> 3.25 MHz
-				2 || 3 -> 6.5 MHz
-
-Node should be child node of stmpe node to which it belongs.
-
-Note that common ADC settings of stmpe_touchscreen (child) will take precedence
-over the settings done in MFD.
-
-Example:
-
-stmpe811@41 {
-	compatible = "st,stmpe811";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_touch_int>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	reg = <0x41>;
-	interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
-	interrupt-parent = <&gpio4>;
-	interrupt-controller;
-	id = <0>;
-	blocks = <0x5>;
-	irq-trigger = <0x1>;
-	/* Common ADC settings */
-	/* 3.25 MHz ADC clock speed */
-	st,adc-freq = <1>;
-	/* 12-bit ADC */
-	st,mod-12b = <1>;
-	/* internal ADC reference */
-	st,ref-sel = <0>;
-	/* ADC converstion time: 80 clocks */
-	st,sample-time = <4>;
-
-	stmpe_touchscreen {
-		compatible = "st,stmpe-ts";
-		reg = <0>;
-		/* 8 sample average control */
-		st,ave-ctrl = <3>;
-		/* 5 ms touch detect interrupt delay */
-		st,touch-det-delay = <5>;
-		/* 1 ms panel driver settling time */
-		st,settling = <3>;
-		/* 7 length fractional part in z */
-		st,fraction-z = <7>;
-		/*
-		 * 50 mA typical 80 mA max touchscreen drivers
-		 * current limit value
-		 */
-		st,i-drive = <1>;
-	};
-	stmpe_adc {
-		compatible = "st,stmpe-adc";
-		st,norequest-mask = <0x0F>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/mfd/st,stmpe.yaml b/Documentation/devicetree/bindings/mfd/st,stmpe.yaml
new file mode 100644
index 000000000000..b77cc3f3075d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/st,stmpe.yaml
@@ -0,0 +1,297 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/st,stmpe.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectonics Port Expander (STMPE)
+
+description: STMicroelectronics Port Expander (STMPE) is a series of slow
+  bus controllers for various expanded peripherals such as GPIO, keypad,
+  touchscreen, ADC, PWM or rotator. It can contain one or several different
+  peripherals connected to SPI or I2C.
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - st,stmpe601
+      - st,stmpe801
+      - st,stmpe811
+      - st,stmpe1600
+      - st,stmpe1601
+      - st,stmpe2401
+      - st,stmpe2403
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vcc-supply: true
+
+  vio-supply: true
+
+  reset-gpios:
+    maxItems: 1
+
+  wakeup-source: true
+
+  st,autosleep-timeout:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 4, 16, 32, 64, 128, 256, 512, 1024 ]
+    description: Time idle before going to automatic sleep to save power
+
+  st,sample-time:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2, 3, 4, 5, 6 ]
+    description: |
+      Sample time per iteration
+      0 = 36 clock ticks
+      1 = 44 clock ticks
+      2 = 56 clock ticks
+      3 = 64 clock ticks
+      4 = 80 clock ticks - recommended
+      5 = 96 clock ticks
+      6 = 124 clock ticks
+
+  st,mod-12b:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+    description: ADC bit mode 0 = 10bit ADC, 1 = 12bit ADC
+
+  st,ref-sel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+    description: ADC reference source 0 = internal, 1 = external
+
+  st,adc-freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2, 3 ]
+    description: |
+      ADC clock speed
+      0 = 1.625 MHz
+      1 = 3.25 MHz
+      2, 3 = 6.5 MHz
+
+  adc:
+    type: object
+    $ref: /schemas/iio/adc/st,stmpe-adc.yaml#
+
+  gpio:
+    type: object
+    $ref: /schemas/gpio/st,stmpe-gpio.yaml#
+
+  keyboard-controller:
+    type: object
+    $ref: /schemas/input/matrix-keymap.yaml#
+
+    unevaluatedProperties: false
+
+    properties:
+      compatible:
+        const: st,stmpe-keypad
+
+      debounce-interval:
+        description: Debouncing interval in milliseconds
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      st,no-autorepeat:
+        description: If present, the keys will not autorepeat when pressed
+        $ref: /schemas/types.yaml#/definitions/flag
+
+      st,scan-count:
+        description: Scanning cycles elapsed before key data is updated
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+    required:
+      - compatible
+      - linux,keymap
+
+  pwm:
+    type: object
+    $ref: /schemas/pwm/pwm.yaml#
+
+    unevaluatedProperties: false
+
+    properties:
+      compatible:
+        const: st,stmpe-pwm
+
+      "#pwm-cells":
+        const: 2
+
+  touchscreen:
+    type: object
+    $ref: /schemas/input/touchscreen/touchscreen.yaml#
+
+    unevaluatedProperties: false
+
+    properties:
+      compatible:
+        const: st,stmpe-ts
+
+      st,ave-ctrl:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [ 0, 1, 2, 3 ]
+        description: |
+          Sample average control
+          0 = 1 sample
+          1 = 2 samples
+          2 = 4 samples
+          3 = 8 samples
+
+      st,touch-det-delay:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
+        description: |
+          Touch detection delay
+          0 = 10 us
+          1 = 50 us
+          2 = 100 us
+          3 = 500 us - recommended
+          4 = 1 ms
+          5 = 5 ms
+          6 = 10 ms
+          7 = 50 ms
+
+      st,settling:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
+        description: |
+          Panel driver settling time
+          0 = 10 us
+          1 = 100 us
+          2 = 500 us - recommended
+          3 = 1 ms
+          4 = 5 ms
+          5 = 10 ms
+          6 = 50 ms
+          7 = 100 ms
+
+      st,fraction-z:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
+        description: Length of the fractional part in z, recommended is 7
+          (fraction-z ([0..7]) = Count of the fractional part)
+
+      st,i-drive:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [ 0, 1 ]
+        description: |
+          current limit value of the touchscreen drivers
+          0 = 20 mA (typical 35 mA max)
+          1 = 50 mA (typical 80 mA max)
+
+    required:
+      - compatible
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/input/input.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      port-expander@43 {
+        compatible = "st,stmpe2401";
+        reg = <0x43>;
+        reset-gpios = <&gpio 13 GPIO_ACTIVE_LOW>;
+        interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+        interrupt-parent = <&gpio>;
+        vcc-supply = <&db8500_vsmps2_reg>;
+        vio-supply = <&db8500_vsmps2_reg>;
+        wakeup-source;
+        st,autosleep-timeout = <1024>;
+
+        gpio {
+          compatible = "st,stmpe-gpio";
+          gpio-controller;
+          #gpio-cells = <2>;
+          interrupt-controller;
+          #interrupt-cells = <2>;
+          st,norequest-mask = <0xf0f002>;
+        };
+
+        keyboard-controller {
+          compatible = "st,stmpe-keypad";
+          debounce-interval = <64>;
+          st,scan-count = <8>;
+          st,no-autorepeat;
+          keypad,num-rows = <8>;
+          keypad,num-columns = <8>;
+          linux,keymap = <
+              MATRIX_KEY(0x00, 0x00, KEY_1)
+              MATRIX_KEY(0x00, 0x01, KEY_2)
+              MATRIX_KEY(0x00, 0x02, KEY_3)
+              MATRIX_KEY(0x00, 0x03, KEY_4)
+              MATRIX_KEY(0x00, 0x04, KEY_5)
+              MATRIX_KEY(0x00, 0x05, KEY_6)
+              MATRIX_KEY(0x00, 0x06, KEY_7)
+              MATRIX_KEY(0x00, 0x07, KEY_8)
+              MATRIX_KEY(0x00, 0x08, KEY_9)
+              MATRIX_KEY(0x00, 0x09, KEY_0)
+          >;
+        };
+
+        pwm {
+          compatible = "st,stmpe-pwm";
+          #pwm-cells = <2>;
+        };
+      };
+
+      port-expander@41 {
+        compatible = "st,stmpe811";
+        reg = <0x41>;
+        interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-parent = <&gpio>;
+        st,adc-freq = <1>;
+        st,mod-12b = <1>;
+        st,ref-sel = <0>;
+        st,sample-time = <4>;
+
+        adc {
+          compatible = "st,stmpe-adc";
+          st,norequest-mask = <0x0f>;
+          #io-channel-cells = <1>;
+        };
+
+        gpio {
+          compatible = "st,stmpe-gpio";
+          gpio-controller;
+          #gpio-cells = <2>;
+          interrupt-controller;
+          #interrupt-cells = <2>;
+        };
+
+        pwm {
+          compatible = "st,stmpe-pwm";
+          #pwm-cells = <2>;
+        };
+
+        touchscreen {
+          compatible = "st,stmpe-ts";
+          st,ave-ctrl = <3>;
+          st,touch-det-delay = <5>;
+          st,settling = <3>;
+          st,fraction-z = <7>;
+          st,i-drive = <1>;
+        };
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/mfd/stmpe.txt b/Documentation/devicetree/bindings/mfd/stmpe.txt
deleted file mode 100644
index d4408a417193..000000000000
--- a/Documentation/devicetree/bindings/mfd/stmpe.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-* ST Microelectronics STMPE Multi-Functional Device
-
-STMPE is an MFD device which may expose the following inbuilt devices: gpio,
-keypad, touchscreen, adc, pwm, rotator.
-
-Required properties:
- - compatible			: "st,stmpe[610|801|811|1600|1601|2401|2403]"
- - reg				: I2C/SPI address of the device
-
-Optional properties:
- - interrupts			: The interrupt outputs from the controller
- - interrupt-controller		: Marks the device node as an interrupt controller
- - wakeup-source		: Marks the input device as wakable
- - st,autosleep-timeout		: Valid entries (ms); 4, 16, 32, 64, 128, 256, 512 and 1024
- - irq-gpio			: If present, which GPIO to use for event IRQ
-
-Optional properties for devices with touch and ADC (STMPE811|STMPE610):
- - st,sample-time		: ADC conversion time in number of clock.
-					0 -> 36 clocks		4 -> 80 clocks (recommended)
-					1 -> 44 clocks		5 -> 96 clocks
-					2 -> 56 clocks		6 -> 124 clocks
-					3 -> 64 clocks
- - st,mod-12b			: ADC Bit mode
-					0 -> 10bit ADC		1 -> 12bit ADC
- - st,ref-sel			: ADC reference source
-					0 -> internal		1 -> external
- - st,adc-freq			: ADC Clock speed
-					0 -> 1.625 MHz		2 || 3 -> 6.5 MHz
-					1 -> 3.25 MHz
-
-Example:
-
-	stmpe1601: stmpe1601@40 {
-		compatible = "st,stmpe1601";
-		reg = <0x40>;
-		interrupts = <26 0x4>;
-		interrupt-parent = <&gpio6>;
-		interrupt-controller;
-
-		wakeup-source;
-		st,autosleep-timeout = <1024>;
-	};

-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F03F69DDD2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjBUK02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjBUK0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:26:25 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D44234E2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:26:21 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id s22so4961456lfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tyMg1yZzTyNl65fCN2Q7I2bw7lEdFprQKebm7Ahkl3k=;
        b=WGxbWJdD0dL3q1Vn0sSBNm35zUANsjnADuZSvU9DcM5yC3qBagyfrGay1D8ZjJC4BW
         y1LhqlvhnsAXCCEyRySXrsMm197wAEn4OhI8tyaG5e3QyL/3ZhbgWXKy6gNVCS8rFE24
         xs5/tv0vvi060N7fE09JskvWX75wpR0R44Xw4SewwvQJWxk8N0+V1TkVxv7oida4RMYH
         ouIJUx3wdq+pEqgk8JMguuXv4QS8SRQ9miX21XkcHrI7lYFNZqPJN43a4rdKw1cN3MaI
         Hc9niapYvxJQj79Y9XJ5xTLSQEtDz9Yx5YohFXX1dVO3zqkmUler/4vSr9loJDQII6x/
         5WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tyMg1yZzTyNl65fCN2Q7I2bw7lEdFprQKebm7Ahkl3k=;
        b=5x21aORGGJkv17mUdVNxOIv3RPH6WvpUJroZs7Fx1wkUNVHovIrqrJTdfGf4rjVdmw
         A7hJZPzWvxQMYZXvwz1M6kTcnsVBIatS6HxTiWy807EiHtcZSw7QLPPr2QdS7Qoh9xpd
         woKVY2wlMmIp+3cTB2ow0OoysEAaLhjL1vNne8B3GTrbMuFVhCOu/EqZwO9KA1WVtu0i
         eIeh71w7d6NZ29xsUEmT3YA6xye6W5jVOEJZWL7eZVEEsgPUa9q1UQKQCLrKWvaxzT7L
         NVJcZpDq3Z+big9w5F+iVrh9z0UTaYB719w8aMeAK8IEhsU0p/EbdBk1p1PdU7z4mNlx
         qRwQ==
X-Gm-Message-State: AO0yUKVuvOR9FLdEMKOJa050o+uEQRdeMBaKIFQaMdIdK+mZRq5Hlqlx
        GeJM9+07OV8OAgfXTWdgSVCH/A==
X-Google-Smtp-Source: AK7set90g7iSvQ7VVwEybHEdxi3UppCwh3x+UnisfSB/p3Iw0WcA8VPej8bLCrpE+0YYu+ZS67xpKQ==
X-Received: by 2002:a19:a416:0:b0:4b5:7d49:4a05 with SMTP id q22-20020a19a416000000b004b57d494a05mr1503258lfc.0.1676975179733;
        Tue, 21 Feb 2023 02:26:19 -0800 (PST)
Received: from fedora.. ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a19520c000000b004a2c447598fsm147338lfb.159.2023.02.21.02.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 02:26:19 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Marek Vasut <marex@denx.de>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: [PATCH] dt-bindings: MFD: Convert STMPE to YAML schema
Date:   Tue, 21 Feb 2023 11:26:05 +0100
Message-Id: <20230221102605.2007396-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org
Cc: Stefan Agner <stefan@agner.ch>
Cc: Marek Vasut <marex@denx.de>
Cc: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I chose to keep the IIO ADC separate YAML file, and contain the
rest in the MFD YAML file.

I can pull the IIO ADC it into the MFD YAML file, I can push out
sub-YAML files per compatible, happy to do it any way you folks
like, just tell me what to do.
---
 .../bindings/input/stmpe-keypad.txt           |  41 ---
 .../bindings/input/touchscreen/stmpe.txt      | 108 ------
 .../devicetree/bindings/mfd/st,stmpe.yaml     | 344 ++++++++++++++++++
 .../devicetree/bindings/mfd/stmpe.txt         |  42 ---
 4 files changed, 344 insertions(+), 191 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/stmpe-keypad.txt
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stmpe.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/stmpe.txt

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
index 000000000000..57ae1882c829
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/st,stmpe.yaml
@@ -0,0 +1,344 @@
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
+  $nodename:
+    pattern: '^stmpe[0-9]+@[0-9a-f]+$'
+
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
+  reset-gpios: true
+
+  wakeup-source:
+    description: If present, interrupts from the expander can wake up the system
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
+
+    properties:
+      compatible:
+        const: st,stmpe-gpio
+
+      "#gpio-cells":
+        const: 2
+
+      "#interrupt-cells":
+        const: 2
+
+      gpio-controller: true
+
+      interrupt-controller: true
+
+      st,norequest-mask:
+        description: A bitmask of GPIO lines that cannot be requested because for
+          for example not being connected to anything on the system
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+    patternProperties:
+      "^.+-hog(-[0-9]+)?$":
+        type: object
+
+        properties:
+          gpio-hog: true
+          gpios: true
+          input: true
+          output-high: true
+          output-low: true
+          line-name: true
+
+        required:
+          - gpio-hog
+          - gpios
+
+    additionalProperties: false
+
+    required:
+      - compatible
+      - "#gpio-cells"
+      - "#interrupt-cells"
+      - gpio-controller
+      - interrupt-controller
+
+  keyboard-controller:
+    type: object
+    $ref: /schemas/input/matrix-keymap.yaml#
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
+    unevaluatedProperties: false
+
+    required:
+      - compatible
+      - linux,keymap
+
+  pwm:
+    type: object
+    $ref: /schemas/pwm/pwm.yaml#
+
+    properties:
+      compatible:
+        const: st,stmpe-pwm
+
+    unevaluatedProperties: false
+
+    required:
+      - compatible
+      - "#pwm-cells"
+
+  touchscreen:
+    type: object
+    $ref: /schemas/input/touchscreen/touchscreen.yaml#
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
+    unevaluatedProperties: false
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
+      stmpe2401@43 {
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
+      stmpe811@41 {
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
+          st,norequest-mask = <0x0F>;
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


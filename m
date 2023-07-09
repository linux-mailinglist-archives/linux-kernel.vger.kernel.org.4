Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336C074C874
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 23:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGIVsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 17:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGIVs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 17:48:28 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9B0124
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 14:48:25 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b71ae5fa2fso8601231fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 14:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688939304; x=1691531304;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SBr3pmqtFJ0mBgHUUMTs1QAvH5gPXD+Zu0MIiua0TDc=;
        b=Ykfs96UVx4AdWvx6+BrUwdWVZYn6+reTEGJZ3oNUurA7amzeluWpisy57oj5knduxO
         vxABXSzx2F7nPyz2TBllcF28zaP+dHm8MZX84W+yKla+sXJu/Dvsh7xipikGaLEfrN9c
         gRbY33gzooKHvPLrhhmBE4pQFSUobt2sti0veOFn2dW/U2vFxj7e/4mJ1thspD45L/Jw
         Vn8EiNpRIo6VfaQofZkukbmdqE28zJkIbovycBdrqG7LtoeuAmD5MywvG8+BFaQISFxl
         cd2X8ocvKze6lGy4gQ2SFoDGtTmuwQqEqgo2p1ytju0fS7TKg1GcBS+c5Sb3gWXolZWj
         e0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688939304; x=1691531304;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBr3pmqtFJ0mBgHUUMTs1QAvH5gPXD+Zu0MIiua0TDc=;
        b=Np+RP9wQJtwTsA+3ZhFnnyocs6WSg3UKZ5LFTqWqc7Qw8iWGWxDONun7bkLc1Y88wY
         SNbzpw97hy1ayNGEgrVuXXY2XUY0K8Zzu54sAm6Xyx64sDAVuc8yih+3ihklEYEKih/d
         /T6UfAgqfr8OK13ZvuOJ4D3eqjNopEJv08XtdDIpDWDiAka2IIugkNbbOKP2R0UfItnH
         TTdXykW95JqWHtSBC8j8TYgJqLsHTiNR2iOPz/Mhnz7zM3M9w3Jsx7eI2QqleLnCs5qW
         4i1Lixr5Z4evupRX6uPVuo/bazTTU6+aqd9zPAVDAztvR0oysK+APPTirKULIfI60si8
         DnYQ==
X-Gm-Message-State: ABy/qLaFIZ490mzhwZ2jDLJcOcE26Xw2atGX4lsGOVGlPodcuj3TTcpa
        rqlcZYatvrg0ZR3Ym5JfaoIapg==
X-Google-Smtp-Source: APBJJlHrDVuZizdmq9QzcXLhbnLwg1wobW1fIyufqm+mVm/Wj/b5W0ljPEVY0LZWy49YNatg0Uu83g==
X-Received: by 2002:a05:6512:3707:b0:4fb:8df5:8919 with SMTP id z7-20020a056512370700b004fb8df58919mr7378890lfr.23.1688939303958;
        Sun, 09 Jul 2023 14:48:23 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id x23-20020ac25dd7000000b004faf6a87d63sm1454243lfq.38.2023.07.09.14.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 14:48:23 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 09 Jul 2023 23:48:19 +0200
Subject: [PATCH v5] dt-bindings: MFD: Convert STMPE to YAML schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230709-stmpe-dt-bindings-v5-1-34a3d6ee1e57@linaro.org>
X-B4-Tracking: v=1; b=H4sIACIrq2QC/4XOzwrCMAwG8FeRnq1sbffPk+8hHrIm3QLaSTuGM
 vbudjsIIujxS/h+ySwiBaYojrtZBJo48uBTKPY7YXvwHUnGlIXKlM6MKmUcb3eSOMqWPbLvorT
 aVA1ilYOqReq1EEm2Abzt1+a78ITbdd3fAzl+bDfPl5R7juMQntsLk1qnv65NSmZSubqA3DlnE
 U5X9hCGwxA6sXKT/kvoRBDYHCtdkqnrL8L8JUwidOkQC41NkzcfxLIsL8v5GSdZAQAA
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
        linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
This adds the missing GPIO bindings for the STMPE port expander
and converts the existing MFD binding to YAML.

I suppose Lee can merge this when he's happy with it.
---
Changes in v5:
- Rebase on v6.5-rc1 meaning GPIO binding is merged
  upstream and can be dropped.
- Link to v4: https://lore.kernel.org/r/20230426-stmpe-dt-bindings-v4-0-36fdd53d9919@linaro.org

Changes in v4:
- Make the GPIO bindings a conversion: there were some old
  text bindings for the STMPE GPIO, we now delete them as
  part of the patch.
- I expect Lee or the DT binding tree to pick both patches.
- Link to v3: https://lore.kernel.org/r/20230426-stmpe-dt-bindings-v3-0-eac1d736e488@linaro.org

Changes in v3:
- Update to review feedback
- Collected some ack/review tags
- Link to v2: https://lore.kernel.org/r/20230426-stmpe-dt-bindings-v2-0-2f85a1fffcda@linaro.org

Changes in v2:
- Split off a separate GPIO binding
- Updated the MFD binding according to feedback
---
ChangeLog v4->v5:
- Rebase on v6.5-rc1
ChangeLog v3->v4:
- No changes.
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

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230426-stmpe-dt-bindings-c3479dd71a28

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


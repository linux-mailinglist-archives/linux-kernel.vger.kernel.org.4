Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D83617A2A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiKCJpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiKCJo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:44:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51C9E0C1;
        Thu,  3 Nov 2022 02:44:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id f5so3698487ejc.5;
        Thu, 03 Nov 2022 02:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOD1FY/s7x8AJ2DLxTd1dTag+ackuB+KNjgZtFsDZok=;
        b=EhqhUK+IljkLVJLJR8st8UENv+5oUlkgg/fYahbE7Zl1bxJf91zgimxF3tsO9J+gdt
         uHq38agsJxIJZdpdPj788C3jpeskMHyBn/V0rFrfG+nzKPWazFe+fcM1QJ7E8p6+cWsy
         bxCaQ8+DuHxo79deg5cPnp3oaIBWL/zNOktgZkEQ/brr56JBJRWvA+08PpL8yhlUtPIl
         XKEbTRdeFn0Oa/YP4cisHXtisNnilgveb480oAPcWcVQwG6oCJE9YA6a7uvk6WA4rTcL
         8LdsKPCYHCaHUUBYUMTS6uuG9+/GyWPNqOUaPXMuMpVFwEmF1Ols8B6IQEFQQfejqAiI
         2zKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOD1FY/s7x8AJ2DLxTd1dTag+ackuB+KNjgZtFsDZok=;
        b=KTg+rXM+/uvGK3b1Pmkqv9CaJ1/Fl6xJoo9xK5rBBP3AE0f/F2aTKdlANHqwA/x/TR
         QbJVbUWLdxBCO99QZYX8E3enmOT2YG9XogS2zyczub9qVzAQx4ZWRJRw567hy1y6802N
         AI81xhx9QCl8lKPkGx7Knl578MD+rlQUBbNPTS6nMyVo0ZAI/Um25cdn8Z8hT8TVKSzC
         q/t57ot5xWxA1GVjfI33o12fFcefVrX6b6YU2Zb8jgknqwUOOh3/wmV9QraWWAoityaX
         SUatesGTqUcI3VK7/JPcHwMaep4MpxysRvLIiTvqGo7deMvyYlnekOc7FY3rV4I071jf
         M18Q==
X-Gm-Message-State: ACrzQf3NuAcwpAdsPuQF1jw6K+YO7n1KpSKoQy0tILIBMsbIh5u2AdIa
        ar5Xj/PHPaLWDvWlhNr/zAw=
X-Google-Smtp-Source: AMsMyM4Y2evPT2PrsCnxOiYRNVukFMK0Q/IRWPHMNbaYpPG+b2dRrUbz8wDW4HjxDMU/cGGmmxfvzw==
X-Received: by 2002:a17:907:7f0a:b0:7ad:d150:c760 with SMTP id qf10-20020a1709077f0a00b007add150c760mr20895024ejc.409.1667468696171;
        Thu, 03 Nov 2022 02:44:56 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id g14-20020a170906538e00b00788c820e630sm269688ejo.121.2022.11.03.02.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 02:44:55 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: addac: add AD74115
Date:   Thu,  3 Nov 2022 11:44:35 +0200
Message-Id: <20221103094436.2136698-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103094436.2136698-1-demonsingur@gmail.com>
References: <20221103094436.2136698-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

The AD74115H is a single-channel, software-configurable, input and
output device for industrial control applications. The AD74115H
provides a wide range of use cases, integrated on a single chip.

These use cases include analog output, analog input, digital output,
digital input, resistance temperature detector (RTD), and thermocouple
measurement capability. The AD74115H also has an integrated HART modem.

A serial peripheral interface (SPI) is used to handle all communications
to the device, including communications with the HART modem. The digital
input and digital outputs can be accessed via the SPI or the
general-purpose input and output (GPIO) pins to support higher
speed data rates.

The device features a 16-bit, sigma-delta analog-to-digital converter
(ADC) and a 14-bit digital-to-analog converter (DAC).
The AD74115H contains a high accuracy 2.5 V on-chip reference that can
be used as the DAC and ADC reference.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../bindings/iio/addac/adi,ad74115.yaml       | 370 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 377 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml

diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
new file mode 100644
index 000000000000..621f11d5c1f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
@@ -0,0 +1,370 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/addac/adi,ad74115.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD74115H device
+
+maintainers:
+  - Cosmin Tanislav <cosmin.tanislav@analog.com>
+
+description: |
+  The AD74115H is a single-channel software configurable input/output
+  device for industrial control applications. It contains functionality for
+  analog output, analog input, digital output, digital input, resistance
+  temperature detector, and thermocouple measurements integrated into a single
+  chip solution with an SPI interface. The device features a 16-bit ADC and a
+  14-bit DAC.
+
+    https://www.analog.com/en/products/ad74115h.html
+
+properties:
+  compatible:
+    enum:
+      - adi,ad74115h
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  spi-max-frequency:
+    maximum: 24000000
+
+  spi-cpol: true
+
+  reset-gpios: true
+
+  interrupts:
+    maxItems: 1
+
+  avdd-supply: true
+  avcc-supply: true
+  dvcc-supply: true
+  aldo1v8-supply: true
+  dovdd-supply: true
+  refin-supply: true
+
+  adi,ch-func:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Channel function.
+      0 - High impedance
+      1 - Voltage output
+      2 - Current output
+      3 - Voltage input
+      4 - Current input, externally-powered
+      5 - Current input, loop-powered
+      6 - Resistance input
+      7 - RTD measure
+      8 - Digital input logic
+      9 - Digital input, loop-powered
+      10 - Current output with HART
+      11 - Current input, externally-powered, with HART
+      12 - Current input, loop-powered, with HART
+    minimum: 0
+    maximum: 12
+    default: 0
+
+  adi,conv2-mux:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Input node for ADC conversion 2.
+      0 - SENSE_EXT1 to AGND_SENSE
+      1 - SENSE_EXT2 to AGND_SENSE
+      2 - SENSE_EXT2 to SENSE_EXT1
+      3 - AGND to AGND
+    minimum: 0
+    maximum: 3
+    default: 0
+
+  adi,conv2-range:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Conversion range for ADC conversion 2.
+      0 - 0V to 12V
+      1 - -12V to +12V
+      2 - -2.5V to +2.5V
+      3 - -2.5V to 0V
+      4 - 0V to 2.5V
+      5 - 0V to 0.625V
+      6 - -104mV to +104mV
+      7 - 0V to 12V
+    minimum: 0
+    maximum: 7
+    default: 0
+
+  adi,sense-agnd-buffer-lp:
+    type: boolean
+    description: |
+      Whether to enable low-power buffered mode for the AGND sense pin.
+
+  adi,lf-buffer-lp:
+    type: boolean
+    description: |
+      Whether to enable low-power buffered mode for the low-side filtered
+      sense pin.
+
+  adi,hf-buffer-lp:
+    type: boolean
+    description: |
+      Whether to enable low-power buffered mode for the high-side filtered
+      sense pin.
+
+  adi,ext2-buffer-lp:
+    type: boolean
+    description: Whether to enable low-power buffered mode for the EXT2 pin.
+
+  adi,ext1-buffer-lp:
+    type: boolean
+    description: Whether to enable low-power buffered mode for the EXT1 pin.
+
+  adi,comparator-invert:
+    type: boolean
+    description: Whether to invert the comparator output.
+
+  adi,digital-input-sink-range-high:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      When not present, the digital input range is from 0 to 3700uA in steps
+      of 120uA, with a ~2k series resistance.
+      When present, the digital input range is from 0 to 7400uA in steps
+      of 240uA, with a ~1k series resistance.
+
+  adi,digital-input-sink-microamp:
+    description: Sink current in digital input mode.
+    minimum: 0
+    maximum: 3700
+    default: 0
+
+  adi,digital-input-debounce-mode-counter-reset:
+    type: boolean
+    description: |
+      When not present, a counter increments when the signal is asserted
+      and decrements when the signal is de-asserted.
+      When present, a counter increments while the signal is asserted and
+      resets when the signal de-asserts
+
+  adi,digital-input-unbuffered:
+    type: boolean
+    description: Whether to buffer digital input signals.
+
+  adi,digital-input-short-circuit-detection:
+    type: boolean
+    description: Whether to detect digital input short circuits.
+
+  adi,digital-input-open-circuit-detection:
+    type: boolean
+    description: Whether to detect digital input open circuits.
+
+  adi,digital-input-threshold-mode-fixed:
+    type: boolean
+    description: |
+      When not present, the digital input threshold range is -0.96 * AVDD
+      to AVDD.
+      When present, the threshold range is fixed from -19V to 30V.
+
+  adi,dac-bipolar:
+    type: boolean
+    description: |
+      When not present, the DAC operates in the 0V to 12V range.
+      When present, the DAC operates in the -12V to 12V range.
+
+  adi,charge-pump:
+    type: boolean
+    description: Whether to enable the internal charge pump.
+
+  adi,dac-hart-slew:
+    type: boolean
+    description: Whether to use a HART-compatible slew rate.
+
+  adi,dac-current-limit-low:
+    type: boolean
+    description: |
+      When not present, the DAC short-circuit current limit is 32mA in
+      either source or sink for VOUT and 4mA sink for IOUT.
+      When present, the limit is 16mA in either source or sink for VOUT,
+      1mA sink for IOUT.
+
+  adi,4-wire-rtd:
+    type: boolean
+    description: |
+      When not present, the ADC should be used for measuring 3-wire RTDs.
+      When present, the ADC should be used for measuring 4-wire RTDs.
+
+  adi,3-wire-rtd-excitation-swap:
+    type: boolean
+    description: Whether to swap the excitation for 3-wire RTD.
+
+  adi,rtd-excitation-current-microamp:
+    description: Excitation current to apply to RTD.
+    enum: [250, 500, 750, 1000]
+    default: 250
+
+  adi,ext1-burnout:
+    type: boolean
+    description: Whether to enable burnout current for EXT1.
+
+  adi,ext1-burnout-current-nanoamp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Burnout current in nanoamps to be applied to EXT1.
+    enum: [0, 50, 500, 1000, 10000]
+    default: 0
+
+  adi,ext1-burnout-current-polarity-sourcing:
+    type: boolean
+    description: |
+      When not present, the burnout current polarity for EXT1 is sinking.
+      When present, the burnout current polarity for EXT1 is sourcing.
+
+  adi,ext2-burnout:
+    type: boolean
+    description: Whether to enable burnout current for EXT2.
+
+  adi,ext2-burnout-current-nanoamp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Burnout current in nanoamps to be applied to EXT2.
+    enum: [0, 50, 500, 1000, 10000]
+    default: 0
+
+  adi,ext2-burnout-current-polarity-sourcing:
+    type: boolean
+    description: |
+      When not present, the burnout current polarity for EXT2 is sinking.
+      When present, the burnout current polarity for EXT2 is sourcing.
+
+  adi,viout-burnout:
+    type: boolean
+    description: Whether to enable burnout current for VIOUT.
+
+  adi,viout-burnout-current-nanoamp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Burnout current in nanoamps to be applied to VIOUT.
+    enum: [0, 1000, 10000]
+    default: 0
+
+  adi,viout-burnout-current-polarity-sourcing:
+    type: boolean
+    description: |
+      When not present, the burnout current polarity for VIOUT is sinking.
+      When present, the burnout current polarity for VIOUT is sourcing.
+
+  adi,gpio0-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      GPIO functions.
+      0 - Disabled
+      1 - Logic I/O
+      2 - Comparator output
+      3 - Control HART CD
+      4 - Monitor HART CD
+      5 - Monitor HART EOM status
+    minimum: 0
+    maximum: 5
+    default: 0
+
+  adi,gpio1-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      GPIO functions.
+      0 - Disabled
+      1 - Logic I/O
+      2 - Drive external digital output FET
+      3 - Control HART RXD
+      4 - Monitor HART RXD
+      5 - Monitor HART SOM status
+    minimum: 0
+    maximum: 5
+    default: 0
+
+  adi,gpio2-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      GPIO functions.
+      0 - Disabled
+      1 - Logic I/O
+      2 - Drive internal digital output FET
+      3 - Control HART TXD
+      4 - Monitor HART TXD
+      5 - Monitor HART TX complete status
+    minimum: 0
+    maximum: 5
+    default: 0
+
+  adi,gpio3-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      GPIO functions.
+      0 - Disabled
+      1 - Logic I/O
+      2 - High impedance
+      3 - Control HART RTS
+      4 - Monitor HART RTS
+      5 - Monitor HART CD complete status
+    minimum: 0
+    maximum: 5
+    default: 0
+
+required:
+  - compatible
+  - reg
+  - spi-cpol
+  - avdd-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        adi,digital-input-sink-range-high: true
+    then:
+      properties:
+        adi,digital-input-sink-microamp:
+          maximum: 7400
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      addac@0 {
+        compatible = "adi,ad74115h";
+        reg = <0>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        spi-max-frequency = <12000000>;
+        spi-cpol;
+
+        reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+
+        interrupt-parent = <&gpio>;
+        interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+
+        avdd-supply = <&ad74115_avdd>;
+
+        adi,ch-func = <1>;
+        adi,conv2-mux = <2>;
+        adi,conv2-range = <1>;
+
+        adi,gpio0-mode = <1>;
+        adi,gpio1-mode = <1>;
+        adi,gpio2-mode = <1>;
+        adi,gpio3-mode = <1>;
+
+        adi,dac-bipolar;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 7a56c344ca67..5b5533f54f67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1175,6 +1175,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
 F:	drivers/iio/adc/ad7780.c
 
+ANALOG DEVICES INC AD74115 DRIVER
+M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	http://ez.analog.com/community/linux-device-drivers
+F:	Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
+
 ANALOG DEVICES INC AD74413R DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.38.1


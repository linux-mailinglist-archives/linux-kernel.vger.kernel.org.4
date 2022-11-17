Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69E562D4C2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbiKQIJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiKQIJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:09:39 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85332654F9;
        Thu, 17 Nov 2022 00:09:37 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id f18so3146175ejz.5;
        Thu, 17 Nov 2022 00:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyzgNLQp8ZAAlmIThQrQlOldwVODp4M3DslGkwhEOAU=;
        b=nXx1PmYmJXKCW/8F7dDVnCdT7yMyaZHDjAK5aSmdBHE5ZEW5+2rm+LKl9JK0EEbKP2
         GKgMPu1/yK2H9lf7HRMKimnQWS1DlmGHtQbK+i5AXWbPSYKUETg+ndGSXYT1udWJ1c8i
         ISXSnL9PhloC4oPqNfCubItcV5ieOkte/ynPh9Z8BW67Yqoo/4JQQFA3S4fwxN/ATmKK
         Fqg+HXErQ+IePqW60HuJVdYGb/L3PxC34er0nuOzpxU3BXvUmAnsNM9OUFkBNJeJuAcQ
         YS3+GJdywZxxAhk5fJQtBSXE3QZCAA5XCMFYlK2B9OSPb6zPH+TZz0USshYwTnSN+a0v
         sZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyzgNLQp8ZAAlmIThQrQlOldwVODp4M3DslGkwhEOAU=;
        b=ZfPTwe2YWRwZo2rXHJrN30SMZAOm1wRNEtaV1LCLtqmCVgxJ24bG0OfPUrmfzxbvzG
         GACS3em41zV5shttN6WgAHkZSomV52hKIfJRtZhXPbOCepNlurjbVght8sT5Zvx4KO99
         TyB6hQrLlnUbEop9tL+yMEWb7KN7bOSIug6udjb7oZXiSLQMSxFw5A30W8qPbaSR2CFd
         90yPZTO3CPaor7W8epwhZlZ4zjSMxWwxh2j9nRdRPtE4GESoC3ihtXO/+sRX0kiuxnfs
         kNMk9mKfZwG3yDptIQ0nMF5kzpMGV+LtYJuYcKy6GhPcYvMRDc3XHQRMK9X8Ulwbaa2H
         0MZg==
X-Gm-Message-State: ANoB5pk4PZxn00jkqlMKXdGpJfK9y/zDqDYJsR1QWPSfl+H1Q+A54vmo
        PDWJvMjPiLdtJo6tL+jMBnDjsJ9sNaReWA==
X-Google-Smtp-Source: AA0mqf6kvBll5V4ivF2Azv2GWwZ33Fbg8cespccnE0cbzseJnkKvtsYNeWu4GLjatFBLZkXbSMXpVA==
X-Received: by 2002:a17:906:b28f:b0:7ad:a942:4d6b with SMTP id q15-20020a170906b28f00b007ada9424d6bmr1175004ejz.379.1668672575885;
        Thu, 17 Nov 2022 00:09:35 -0800 (PST)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id la18-20020a170907781200b00770880dfc4fsm42192ejc.29.2022.11.17.00.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 00:09:35 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: iio: addac: add AD74115
Date:   Thu, 17 Nov 2022 10:09:15 +0200
Message-Id: <20221117080916.411766-2-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117080916.411766-1-cosmin.tanislav@analog.com>
References: <20221117080916.411766-1-cosmin.tanislav@analog.com>
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
 .../bindings/iio/addac/adi,ad74115.yaml       | 373 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 380 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml

diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
new file mode 100644
index 000000000000..72d2e910f206
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
@@ -0,0 +1,373 @@
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
+  spi-max-frequency:
+    maximum: 24000000
+
+  spi-cpol: true
+
+  reset-gpios: true
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - adc_rdy
+        - alert
+
+  avdd-supply: true
+  avcc-supply: true
+  dvcc-supply: true
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
+  adi,conv2-range-microvolt:
+    description: Conversion range for ADC conversion 2.
+    oneOf:
+      - items:
+          - enum: [-2500000, 0]
+          - const: 2500000
+      - items:
+          - enum: [-12000000, 0]
+          - const: 12000000
+      - items:
+          - const: -2500000
+          - const: 0
+      - items:
+          - const: -104000
+          - const: 104000
+      - items:
+          - const: 0
+          - const: 625000
+
+  adi,sense-agnd-buffer-low-power:
+    type: boolean
+    description:
+      Whether to enable low-power buffered mode for the AGND sense pin.
+
+  adi,lf-buffer-low-power:
+    type: boolean
+    description:
+      Whether to enable low-power buffered mode for the low-side filtered
+      sense pin.
+
+  adi,hf-buffer-low-power:
+    type: boolean
+    description:
+      Whether to enable low-power buffered mode for the high-side filtered
+      sense pin.
+
+  adi,ext2-buffer-low-power:
+    type: boolean
+    description: Whether to enable low-power buffered mode for the EXT2 pin.
+
+  adi,ext1-buffer-low-power:
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
+    description:
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
+      required:
+        - adi,digital-input-sink-range-high
+    then:
+      properties:
+        adi,digital-input-sink-microamp:
+          maximum: 7400
+
+unevaluatedProperties: false
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
+        spi-max-frequency = <12000000>;
+        spi-cpol;
+
+        reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+
+        interrupt-parent = <&gpio>;
+        interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+        interrupt-names = "adc_rdy";
+
+        avdd-supply = <&ad74115_avdd>;
+
+        adi,ch-func = <1>;
+        adi,conv2-mux = <2>;
+        adi,conv2-range-microvolt = <(-12000000) 12000000>;
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
index be373dfae4dd..873756b1a45f 100644
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


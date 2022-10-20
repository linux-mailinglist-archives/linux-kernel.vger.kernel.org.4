Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9F3605A82
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiJTJD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiJTJDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:03:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574651960AF;
        Thu, 20 Oct 2022 02:03:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sc25so45737412ejc.12;
        Thu, 20 Oct 2022 02:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DayiKLlvbIIue7g6LBPYF4GqrTQZTG5BKYE4ilcFye8=;
        b=VGCyTal8LA1G76/CSx8YcuHU2Zms5xsOQGnB0JKISjBurU6oFAaefzNZGO+dSnE+Ag
         NLaGUTiV9bdAg6g5ihI0FjxidQNmZz4v0ZShB3OxSn92NI4y6Ghtsafbt8T3ckcoKwzE
         o6/aGk8BizK7N9y4hLjl2humzyQxYZ3DfQBBwhxpYVdG0Kt8KhLBqM1Ji1RNaaBElwQ4
         xBcxToapErMuLqnDuUw0X3xB2L60zDHkYrEwgpDZRmNNa9WvEPVNBciBdKSfTTxqvrvu
         DqQFKDE+JP8ou4eKwvtbCShcYzEx2h6yL8gI9HvdgZpxOnNlXGzrU0e0PeR7gt/A939O
         4mDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DayiKLlvbIIue7g6LBPYF4GqrTQZTG5BKYE4ilcFye8=;
        b=w8FcMpTUfV4DwVCizlldSkzOoueZGMdOUAA8Q+0fhuH6AipoOF8FW5BM/B+ub7II9z
         S1K9XV8tyUt7yynms7aNM1UbYnVvYEMU3YbXGdHq2YttQ0aCtoIQF7Iy6nuxgFdGBUWg
         zEZrCTRUte0dY2CyJciEq+7GbUOhhFy5JV+rmXQgLWPj0QBFBCQm8mvajcND0CrhfS8E
         H496w0yhyy1PsA7hcXwlea8zeAM1j0GfAneHefvhf/SCzflvK3HAlmfo0f1yVzDqyKw0
         3hCrkOHFSRgGtZRLr1pR4uhU3HqDXrQknKOepEk/HxFYttinbs5H18mDuBxijI4KyP+H
         lBog==
X-Gm-Message-State: ACrzQf3EUfIHzav3uQ8lS3RCEbKlgWE8WiTlPPzbbCG21TLeDxf9t/d8
        YjLQl/zYy9AL9qehsQmWwoo=
X-Google-Smtp-Source: AMsMyM69mrh/rtXedE+Kwf3da9wim0MgBTIWtV9heXZ+miZc119P4Hvxi47t98vPY7FgkdtZoa2oEA==
X-Received: by 2002:a17:907:25c5:b0:783:f5df:900e with SMTP id ae5-20020a17090725c500b00783f5df900emr9753337ejc.491.1666256597449;
        Thu, 20 Oct 2022 02:03:17 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b007933047f923sm1668381ejf.118.2022.10.20.02.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 02:03:17 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v2 3/5] dt-bindings: iio: temperature: ltc2983: refine
Date:   Thu, 20 Oct 2022 12:02:55 +0300
Message-Id: <20221020090257.1717053-4-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221020090257.1717053-1-demonsingur@gmail.com>
References: <20221020090257.1717053-1-demonsingur@gmail.com>
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

 * make sure addresses are represented as hex
 * add note about wrong unit value for adi,mux-delay-config-us
 * simplify descriptions
 * add descriptions for the items of custom sensor tables
 * add default property values where applicable
 * use conditionals to extend minimum reg value
   for single ended sensors
 * remove " around phandle schema $ref
 * remove label from example and use generic temperature
   sensor name

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../bindings/iio/temperature/adi,ltc2983.yaml | 309 +++++++++++-------
 1 file changed, 182 insertions(+), 127 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index 722781aa4697..3e97ec841fd6 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -26,25 +26,25 @@ properties:
 
   adi,mux-delay-config-us:
     description:
-      The LTC2983 performs 2 or 3 internal conversion cycles per temperature
-      result. Each conversion cycle is performed with different excitation and
-      input multiplexer configurations. Prior to each conversion, these
-      excitation circuits and input switch configurations are changed and an
-      internal 1ms delay ensures settling prior to the conversion cycle in most
-      cases. An extra delay can be configured using this property. The value is
-      rounded to nearest 100us.
+      Extra delay prior to each conversion, in addition to the internal 1ms
+      delay, for the multiplexer to switch input configurations and
+      excitation values.
+
+      This property is supposed to be in microseconds, but to maintain
+      compatibility, this value will be multiplied by 100 before usage.
     maximum: 255
+    default: 0
 
   adi,filter-notch-freq:
     description:
-      Set's the default setting of the digital filter. The default is
-      simultaneous 50/60Hz rejection.
+      Notch frequency of the digital filter.
       0 - 50/60Hz rejection
       1 - 60Hz rejection
       2 - 50Hz rejection
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 2
+    default: 0
 
   '#address-cells':
     const: 1
@@ -53,19 +53,19 @@ properties:
     const: 0
 
 patternProperties:
-  "@([1-9]|1[0-9]|20)$":
+  "@([0-9a-f]+)$":
     type: object
-
+    description: Sensor.
     properties:
       reg:
         description:
-          The channel number. It can be connected to one of the 20 channels of
-          the device.
-        minimum: 1
+          Channel number. Connects the sensor to the channel with this number
+          of the device.
+        minimum: 2
         maximum: 20
 
       adi,sensor-type:
-        description: Identifies the type of sensor connected to the device.
+        description: Type of sensor connected to the device.
         $ref: /schemas/types.yaml#/definitions/uint32
 
     required:
@@ -74,10 +74,7 @@ patternProperties:
 
   "^thermocouple@":
     type: object
-    description:
-      Represents a thermocouple sensor which is connected to one of the device
-      channels.
-
+    description: Thermocouple sensor.
     properties:
       adi,sensor-type:
         description: |
@@ -95,87 +92,104 @@ patternProperties:
         maximum: 9
 
       adi,single-ended:
-        description:
-          Boolean property which set's the thermocouple as single-ended.
+        description: Whether the sensor is single-ended.
         type: boolean
 
       adi,sensor-oc-current-microamp:
-        description:
-          This property set's the pulsed current value applied during
-          open-circuit detect.
+        description: Pulsed current value applied during open-circuit detect.
         enum: [10, 100, 500, 1000]
+        default: 10
 
       adi,cold-junction-handle:
         description:
-          Phandle which points to a sensor object responsible for measuring
-          the thermocouple cold junction temperature.
-        $ref: "/schemas/types.yaml#/definitions/phandle"
+          Sensor responsible for measuring the thermocouple cold junction
+          temperature.
+        $ref: /schemas/types.yaml#/definitions/phandle
 
       adi,custom-thermocouple:
         description:
-          This is a table, where each entry should be a pair of
-          voltage(mv)-temperature(K). The entries must be given in nv and uK
-          so that, the original values must be multiplied by 1000000. For
-          more details look at table 69 and 70.
-          Note should be signed, but dtc doesn't currently maintain the
-          sign.
+          Used for digitizing custom thermocouples.
+          See Page 59 of the datasheet.
         $ref: /schemas/types.yaml#/definitions/uint64-matrix
         minItems: 3
         maxItems: 64
         items:
-          minItems: 2
-          maxItems: 2
+          items:
+            - description: Voltage point in nV, signed.
+            - description: Temperature point in uK.
+
+    allOf:
+      - if:
+          properties:
+            adi,single-ended:
+              const: true
+        then:
+          properties:
+            reg:
+              minimum: 1
+      - if:
+          properties:
+            adi,sensor-type:
+              const: 9
+        then:
+          required:
+            - adi,custom-thermocouple
 
   "^diode@":
     type: object
-    description:
-      Represents a diode sensor which is connected to one of the device
-      channels.
-
+    description: Diode sensor.
     properties:
       adi,sensor-type:
-        description: Identifies the sensor as a diode.
+        description: Sensor type for diodes.
         $ref: /schemas/types.yaml#/definitions/uint32
         const: 28
 
       adi,single-ended:
-        description: Boolean property which set's the diode as single-ended.
+        description: Whether the sensor is single-ended.
         type: boolean
 
       adi,three-conversion-cycles:
         description:
-          Boolean property which set's three conversion cycles removing
-          parasitic resistance effects between the LTC2983 and the diode.
+          Whether to use three conversion cycles to remove parasitic
+          resistance between the device and the diode.
         type: boolean
 
       adi,average-on:
         description:
-          Boolean property which enables a running average of the diode
-          temperature reading. This reduces the noise when the diode is used
-          as a cold junction temperature element on an isothermal block
-          where temperatures change slowly.
+          Whether to use a running average of the diode temperature
+          reading to reduce the noise when the diode is used as a cold
+          junction temperature element on an isothermal block where
+          temperatures change slowly.
         type: boolean
 
       adi,excitation-current-microamp:
         description:
-          This property controls the magnitude of the excitation current
-          applied to the diode. Depending on the number of conversions
-          cycles, this property will assume different predefined values on
-          each cycle. Just set the value of the first cycle (1l).
+          Magnitude of the 1l excitation current applied to the diode.
+          4l excitation current will be 4 times this value, and 8l
+          excitation current will be 8 times value.
         enum: [10, 20, 40, 80]
+        default: 10
 
       adi,ideal-factor-value:
         description:
-          This property sets the diode ideality factor. The real value must
-          be multiplied by 1000000 to remove the fractional part. For more
-          information look at table 20 of the datasheet.
+          Diode ideality factor.
+          Set this property to 1000000 times the real value.
         $ref: /schemas/types.yaml#/definitions/uint32
+        default: 0
+
+    allOf:
+      - if:
+          properties:
+            adi,single-ended:
+              const: true
+        then:
+          properties:
+            reg:
+              minimum: 1
 
   "^rtd@":
     type: object
-    description:
-      Represents a rtd sensor which is connected to one of the device channels.
-
+    description: RTD sensor.
     properties:
       reg:
         minimum: 2
@@ -197,56 +211,57 @@ patternProperties:
         maximum: 18
 
       adi,rsense-handle:
-        description:
-          Phandle pointing to a rsense object associated with this RTD.
-        $ref: "/schemas/types.yaml#/definitions/phandle"
+        description: Associated sense resistor sensor.
+        $ref: /schemas/types.yaml#/definitions/phandle
 
       adi,number-of-wires:
         description:
-          Identifies the number of wires used by the RTD. Setting this
-          property to 5 means 4 wires with Kelvin Rsense.
+          Number of wires used by the RTD.
+          5 means 4 wires with Kelvin sense resistor.
         $ref: /schemas/types.yaml#/definitions/uint32
         enum: [2, 3, 4, 5]
+        default: 2
 
       adi,rsense-share:
         description:
-          Boolean property which enables Rsense sharing, where one sense
-          resistor is used for multiple 2-, 3-, and/or 4-wire RTDs.
+          Whether to enable sense resistor sharing, where one sense
+          resistor is used by multiple sensors.
         type: boolean
 
       adi,current-rotate:
         description:
-          Boolean property which enables excitation current rotation to
-          automatically remove parasitic thermocouple effects. Note that
-          this property is not allowed for 2- and 3-wire RTDs.
+          Whether to enable excitation current rotation to automatically
+          remove parasitic thermocouple effects.
         type: boolean
 
       adi,excitation-current-microamp:
-        description:
-          This property controls the magnitude of the excitation current
-          applied to the RTD.
+        description: Excitation current applied to the RTD.
         enum: [5, 10, 25, 50, 100, 250, 500, 1000]
+        default: 5
 
       adi,rtd-curve:
         description:
-          This property set the RTD curve used and the corresponding
-          Callendar-VanDusen constants. Look at table 30 of the datasheet.
+          RTD curve and the corresponding Callendar-VanDusen constants.
+          0 - European
+          1 - American
+          2 - Japanese
+          3 - ITS-90
         $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 3
+        default: 0
 
       adi,custom-rtd:
         description:
-          This is a table, where each entry should be a pair of
-          resistance(ohm)-temperature(K). The entries added here are in uohm
-          and uK. For more details values look at table 74 and 75.
+          Used for digitizing custom RTDs.
+          See Page 62 of the datasheet.
         $ref: /schemas/types.yaml#/definitions/uint64-matrix
+        minItems: 3
+        maxItems: 64
         items:
-          minItems: 3
-          maxItems: 64
           items:
-            minItems: 2
-            maxItems: 2
+            - description: Resistance point in uOhms.
+            - description: Temperature point in uK.
 
     required:
       - adi,rsense-handle
@@ -254,12 +269,25 @@ patternProperties:
     dependencies:
       adi,current-rotate: [ "adi,rsense-share" ]
 
+    allOf:
+      - if:
+          properties:
+            adi,number-of-wires:
+              enum: [2, 3]
+        then:
+          properties:
+            adi,current-rotate: false
+      - if:
+          properties:
+            adi,sensor-type:
+              const: 18
+        then:
+          required:
+            - adi,custom-rtd
+
   "^thermistor@":
     type: object
-    description:
-      Represents a thermistor sensor which is connected to one of the device
-      channels.
-
+    description: Thermistor sensor.
     properties:
       adi,sensor-type:
         description:
@@ -277,61 +305,54 @@ patternProperties:
         maximum: 27
 
       adi,rsense-handle:
-        description:
-          Phandle pointing to a rsense object associated with this
-          thermistor.
-        $ref: "/schemas/types.yaml#/definitions/phandle"
+        description: Associated sense resistor sensor.
+        $ref: /schemas/types.yaml#/definitions/phandle
 
       adi,single-ended:
-        description:
-          Boolean property which set's the thermistor as single-ended.
+        description: Whether the sensor is single-ended.
         type: boolean
 
       adi,rsense-share:
         description:
-          Boolean property which enables Rsense sharing, where one sense
-          resistor is used for multiple thermistors. Note that this property
-          is ignored if adi,single-ended is set.
+          Whether to enable sense resistor sharing, where one sense
+          resistor is used by multiple sensors.
         type: boolean
 
       adi,current-rotate:
         description:
-          Boolean property which enables excitation current rotation to
-          automatically remove parasitic thermocouple effects.
+          Whether to enable excitation current rotation to automatically
+          remove parasitic thermocouple effects.
         type: boolean
 
       adi,excitation-current-nanoamp:
         description:
-          This property controls the magnitude of the excitation current
-          applied to the thermistor. Value 0 set's the sensor in auto-range
-          mode.
+          Excitation current applied to the thermistor.
+          0 sets the sensor in auto-range mode.
         $ref: /schemas/types.yaml#/definitions/uint32
         enum: [0, 250, 500, 1000, 5000, 10000, 25000, 50000, 100000, 250000,
                500000, 1000000]
+        default: 0
+
+      adi,custom-steinhart:
+        description:
+          Steinhart-Hart coefficients in raw format, used for digitizing
+          custom thermistors.
+          See Page 68 of the datasheet.
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 6
+        maxItems: 6
 
       adi,custom-thermistor:
         description:
-          This is a table, where each entry should be a pair of
-          resistance(ohm)-temperature(K). The entries added here are in uohm
-          and uK only for custom thermistors. For more details look at table
-          78 and 79.
+          Used for digitizing custom thermistors.
+          See Page 65 of the datasheet.
         $ref: /schemas/types.yaml#/definitions/uint64-matrix
         minItems: 3
         maxItems: 64
         items:
-          minItems: 2
-          maxItems: 2
-
-      adi,custom-steinhart:
-        description:
-          Steinhart-Hart coefficients are also supported and can
-          be programmed into the device memory using this property. For
-          Steinhart sensors the coefficients are given in the raw
-          format. Look at table 82 for more information.
-        $ref: /schemas/types.yaml#/definitions/uint32-array
-        items:
-          minItems: 6
-          maxItems: 6
+          items:
+            - description: Resistance point in uOhms.
+            - description: Temperature point in uK.
 
     required:
       - adi,rsense-handle
@@ -339,40 +360,74 @@ patternProperties:
     dependencies:
       adi,current-rotate: [ "adi,rsense-share" ]
 
+    allOf:
+      - if:
+          properties:
+            adi,single-ended:
+              const: true
+        then:
+          properties:
+            reg:
+              minimum: 1
+      - if:
+          properties:
+            adi,sensor-type:
+              const: 26
+        then:
+          properties:
+            adi,excitation-current-nanoamp:
+              default: 1000
+          required:
+            - adi,custom-steinhart
+      - if:
+          properties:
+            adi,sensor-type:
+              const: 27
+        then:
+          properties:
+            adi,excitation-current-nanoamp:
+              default: 1000
+          required:
+            - adi,custom-thermistor
+
   "^adc@":
     type: object
-    description: Represents a channel which is being used as a direct adc.
-
+    description: Direct ADC sensor.
     properties:
       adi,sensor-type:
-        description: Identifies the sensor as a direct adc.
+        description: Sensor type for direct ADC sensors.
         $ref: /schemas/types.yaml#/definitions/uint32
         const: 30
 
       adi,single-ended:
-        description: Boolean property which set's the adc as single-ended.
+        description: Whether the sensor is single-ended.
         type: boolean
 
+    allOf:
+      - if:
+          properties:
+            adi,single-ended:
+              const: true
+        then:
+          properties:
+            reg:
+              minimum: 1
+
   "^rsense@":
     type: object
-    description:
-      Represents a rsense which is connected to one of the device channels.
-      Rsense are used by thermistors and RTD's.
-
+    description: Sense resistor sensor.
     properties:
       reg:
         minimum: 2
         maximum: 20
 
       adi,sensor-type:
-        description: Identifies the sensor as a rsense.
+        description: Sensor type sense resistor sensors.
         $ref: /schemas/types.yaml#/definitions/uint32
         const: 29
 
       adi,rsense-val-milli-ohms:
-        description:
-          Sets the value of the sense resistor. Look at table 20 of the
-          datasheet for information.
+        description: Value of the sense resistor.
 
     required:
       - adi,rsense-val-milli-ohms
@@ -391,7 +446,7 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        sensor_ltc2983: ltc2983@0 {
+        temp@0 {
                 compatible = "adi,ltc2983";
                 reg = <0>;
 
-- 
2.38.1


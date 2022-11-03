Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CDE617D57
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiKCNCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiKCNBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:01:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF0715806;
        Thu,  3 Nov 2022 06:01:28 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id 13so5035228ejn.3;
        Thu, 03 Nov 2022 06:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aii7ZeFVsJKah3Sp1J2uui+q3nkwmdgQ+YvTSehqSzc=;
        b=foSOXFNXe0tDxIeWovWmnUYJyzccoRGAA3m643QrB01+h4F8gX1WqP8C9LGHIHtuQU
         A33s36L2tdxo15u474lNxpo/+i4G5/QXlv/3ugUKSF9vRJvlgpMRW2Z0s9gET5emClnM
         qeqomrOJNMT3VPUFsjd1y+UTxuWgN742JJj6zhgSqLNrzDX9oLe9+6XL94FlDCse8WL2
         XIeMj4uvhKYS28RUh5Pckqh/M3IwYYQey0GZkmiDNvGDsRi0cUGDaKgp9xGlH4rYoHaZ
         OXBvVyGF+WzvqAjyRD56hKEloJlcLSZIKFP8ynTPuTWI3YmcFLgUNZ7hEZ8Z0spJ8VDj
         LziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aii7ZeFVsJKah3Sp1J2uui+q3nkwmdgQ+YvTSehqSzc=;
        b=JWl4k76aFcRo3nL8T3ECySmp44Ns4GN2AmS7XgUb08c4hpx6OhcPa7e8PhbzYHDwHf
         Y+kx5N5qM/JoH/8rK7X7RMJhb8efCdSBtOk7V+g48o1DhwAFkxuPkD2LLPJgbaug6FYo
         YEXKzJB8jzxpebi+imT2dslyn+2oo8jEqe6E7h+7lkj02Ynlf9pWM12WIhpLEBvqY0og
         PlAXnN2InmJOot8eKx9SU3dpa/u/QUPR0WnGHgicmvvTEn3+s1VeUP/pMyBHg78anhYl
         xQKloAF+E4K76P6EChO7f0SZcTRhSERYGG+KUR44cC9cBpPGxLDKXKc6pJ8/OTdzVtBA
         3xSA==
X-Gm-Message-State: ACrzQf1+qyaEqvddfOQ2WecM6GyS88v1vl5ORGpR7AvU1OrRYmRTkC52
        6erOGGwVzYRlm7lh6/yNB5c=
X-Google-Smtp-Source: AMsMyM6KXL/vxgfv18y021zmoX6eg+glIvwxyIYLQ1YnlPcf6BEouAvee3bSf8Pl8HqKXjK/MB1h6A==
X-Received: by 2002:a17:907:aa1:b0:7ad:b286:fa25 with SMTP id bz1-20020a1709070aa100b007adb286fa25mr28460756ejc.106.1667480488148;
        Thu, 03 Nov 2022 06:01:28 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090676cc00b00779a605c777sm451829ejn.192.2022.11.03.06.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:01:27 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v4 09/13] dt-bindings: iio: temperature: ltc2983: refine descriptions
Date:   Thu,  3 Nov 2022 15:00:37 +0200
Message-Id: <20221103130041.2153295-10-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103130041.2153295-1-demonsingur@gmail.com>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
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

Some descriptions are too verbose, while others are too succint.
Rewrite them all.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../bindings/iio/temperature/adi,ltc2983.yaml | 163 +++++++-----------
 1 file changed, 65 insertions(+), 98 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index 1b6a11f2aa9d..676801b036cf 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -25,21 +25,16 @@ properties:
     maxItems: 1
 
   adi,mux-delay-config-us:
-    description:
-      The LTC2983 performs 2 or 3 internal conversion cycles per temperature
-      result. Each conversion cycle is performed with different excitation and
-      input multiplexer configurations. Prior to each conversion, these
-      excitation circuits and input switch configurations are changed and an
-      internal 1ms delay ensures settling prior to the conversion cycle in most
-      cases. An extra delay can be configured using this property. The value is
-      rounded to nearest 100us.
+    description: |
+      Extra delay prior to each conversion, in addition to the internal 1ms
+      delay, for the multiplexer to switch input configurations and
+      excitation values.
     maximum: 255
     default: 0
 
   adi,filter-notch-freq:
     description:
-      Set's the default setting of the digital filter. The default is
-      simultaneous 50/60Hz rejection.
+      Notch frequency of the digital filter.
       0 - 50/60Hz rejection
       1 - 60Hz rejection
       2 - 50Hz rejection
@@ -57,17 +52,18 @@ properties:
 patternProperties:
   "@([0-9a-f]+)$":
     type: object
+    description: Sensor.
 
     properties:
       reg:
         description:
-          The channel number. It can be connected to one of the 20 channels of
-          the device.
+          Channel number. Connects the sensor to the channel with this number
+          of the device.
         minimum: 1
         maximum: 20
 
       adi,sensor-type:
-        description: Identifies the type of sensor connected to the device.
+        description: Type of sensor connected to the device.
         $ref: /schemas/types.yaml#/definitions/uint32
 
     required:
@@ -76,9 +72,7 @@ patternProperties:
 
   "^thermocouple@":
     type: object
-    description:
-      Represents a thermocouple sensor which is connected to one of the device
-      channels.
+    description: Thermocouple sensor.
 
     properties:
       adi,sensor-type:
@@ -97,31 +91,24 @@ patternProperties:
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
         default: 10
 
       adi,cold-junction-handle:
         description:
-          Phandle which points to a sensor object responsible for measuring
-          the thermocouple cold junction temperature.
+          Sensor responsible for measuring the thermocouple cold junction
+          temperature.
         $ref: /schemas/types.yaml#/definitions/phandle
 
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
@@ -141,55 +128,50 @@ patternProperties:
 
   "^diode@":
     type: object
-    description:
-      Represents a diode sensor which is connected to one of the device
-      channels.
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
         default: 10
 
       adi,ideal-factor-value:
         description:
-          This property sets the diode ideality factor. The real value must
-          be multiplied by 1000000 to remove the fractional part. For more
-          information look at table 20 of the datasheet.
+          Diode ideality factor.
+          Set this property to 1000000 times the real value.
         $ref: /schemas/types.yaml#/definitions/uint32
         default: 0
 
   "^rtd@":
     type: object
-    description:
-      Represents a rtd sensor which is connected to one of the device channels.
+    description: RTD sensor.
 
     properties:
       reg:
@@ -212,35 +194,35 @@ patternProperties:
         maximum: 18
 
       adi,rsense-handle:
-        description:
-          Phandle pointing to a rsense object associated with this RTD.
+        description: Associated sense resistor sensor.
         $ref: /schemas/types.yaml#/definitions/phandle
 
       adi,number-of-wires:
         description:
-          Identifies the number of wires used by the RTD. Setting this
-          property to 5 means 4 wires with Kelvin Rsense.
+          Number of wires used by the RTD.
+          5 means 4 wires with Kelvin sense resistor.
         $ref: /schemas/types.yaml#/definitions/uint32
         enum: [2, 3, 4, 5]
         default: 2
 
       adi,rsense-share:
         description:
-          Boolean property which enables Rsense sharing, where one sense
-          resistor is used for multiple 2-, 3-, and/or 4-wire RTDs.
+          Whether to enable sense resistor sharing, where one sense
+          resistor is used by multiple sensors.
         type: boolean
 
       adi,excitation-current-microamp:
-        description:
-          This property controls the magnitude of the excitation current
-          applied to the RTD.
+        description: Excitation current applied to the RTD.
         enum: [5, 10, 25, 50, 100, 250, 500, 1000]
         default: 5
 
       adi,rtd-curve:
-        description:
-          This property set the RTD curve used and the corresponding
-          Callendar-VanDusen constants. Look at table 30 of the datasheet.
+        description: |
+          RTD curve and the corresponding Callendar-VanDusen constants.
+          0 - European
+          1 - American
+          2 - Japanese
+          3 - ITS-90
         $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 3
@@ -248,9 +230,8 @@ patternProperties:
 
       adi,custom-rtd:
         description:
-          This is a table, where each entry should be a pair of
-          resistance(ohm)-temperature(K). The entries added here are in uohm
-          and uK. For more details values look at table 74 and 75.
+          Used for digitizing custom RTDs.
+          See Page 62 of the datasheet.
         $ref: /schemas/types.yaml#/definitions/uint64-matrix
         minItems: 3
         maxItems: 64
@@ -288,9 +269,7 @@ patternProperties:
 
   "^thermistor@":
     type: object
-    description:
-      Represents a thermistor sensor which is connected to one of the device
-      channels.
+    description: Thermistor sensor.
 
     properties:
       adi,sensor-type:
@@ -309,34 +288,29 @@ patternProperties:
         maximum: 27
 
       adi,rsense-handle:
-        description:
-          Phandle pointing to a rsense object associated with this
-          thermistor.
+        description: Associated sense resistor sensor.
         $ref: /schemas/types.yaml#/definitions/phandle
 
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
@@ -344,10 +318,8 @@ patternProperties:
 
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
@@ -358,10 +330,9 @@ patternProperties:
 
       adi,custom-steinhart:
         description:
-          Steinhart-Hart coefficients are also supported and can
-          be programmed into the device memory using this property. For
-          Steinhart sensors the coefficients are given in the raw
-          format. Look at table 82 for more information.
+          Steinhart-Hart coefficients in raw format, used for digitizing
+          custom thermistors.
+          See Page 68 of the datasheet.
         $ref: /schemas/types.yaml#/definitions/uint32-array
         minItems: 6
         maxItems: 6
@@ -400,23 +371,21 @@ patternProperties:
 
   "^adc@":
     type: object
-    description: Represents a channel which is being used as a direct adc.
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
 
   "^rsense@":
     type: object
-    description:
-      Represents a rsense which is connected to one of the device channels.
-      Rsense are used by thermistors and RTD's.
+    description: Sense resistor sensor.
 
     properties:
       reg:
@@ -424,14 +393,12 @@ patternProperties:
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
-- 
2.38.1


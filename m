Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E489964B256
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiLMJ1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbiLMJ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:26:57 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCC41171
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:26:52 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id b9so2690286ljr.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHXyMZCTwR7ZwM6OdTDxXVdSwmzG+m5CT1ZIcUskEEY=;
        b=NRkwSVnT4PuqRZB6o3JVkz9Y8GekvifRxAoUoGvhAM2xWBmVUAteygVEVZj40GnmtC
         iTQigJM+KFD5FUJ5I9iPnZbcSNHzN4feJGKwUoaFPJVRk+w9+gtBc6tS/vYNuzE/rAkW
         fngcTY4E866lo6sRaa0N/JE2RdKNs8QjesAhDV4jkr4lxKDHiKWCQqBNCtZx+28syQ2A
         hlbHGAfNT+mME4Rs6uckpfFUnn8edfRr2Ug8UDKcP5v+7py0fBw3NJDxPIarNQsbsbDF
         HeS2YSKI64LGaeSGl9Tv5NV4aVmyKf9Lm9p7xZRfrfJQXhEnRgmQfuOYhg3bIbsGujyN
         Epvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHXyMZCTwR7ZwM6OdTDxXVdSwmzG+m5CT1ZIcUskEEY=;
        b=zTjvPjFz0dGc7xv8JJBU5ANkgIhtHk7bEuDrzstaNVcVtAv4dTFPvqzWqDNMLws1x5
         66uMjUxBwAg18WqeRIREnY/KRPqYC3Ynjd59jF0hNovOviQuyDwchxp3FB/+LA7gtC55
         QPkPe+BWEJidwyNUF6bi6NG0nQsjgbtb5OURoifCQuyUWHuTLrd9Lldj834wW+PgvRWR
         D3VFSpAhl8WFP65TiKMkVU9tPHBS+quaJk0IgZlesjjJP+ToRaUQWrTVTzniqOQkP4lW
         UogoaOJybeEhOpP+4tBN8tPiPPZsfUy2dptvAerOYGGaJPa8BxFO4+MuPZmHkzuSykhs
         23xw==
X-Gm-Message-State: ANoB5pnbcIUFwCYflBugTGoOR27nzEHZGPUAxwFgq0t+PG1RdXVNvgwt
        Z1M/1OawemwsDrszJz4KdK5WCg==
X-Google-Smtp-Source: AA0mqf7G1fbkz4iOxXZgUeX9z4YTaCWIQu3M7y922duGGQZ4aM+YpZZqZdHCpqL9F7cCHv1hCqF/JQ==
X-Received: by 2002:a05:651c:d0:b0:27a:bc7:8baa with SMTP id 16-20020a05651c00d000b0027a0bc78baamr4630588ljr.52.1670923611172;
        Tue, 13 Dec 2022 01:26:51 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k20-20020a2ea274000000b0027a00aab48fsm188958ljm.66.2022.12.13.01.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 01:26:50 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Akshay Gupta <Akshay.Gupta@amd.com>, Kun Yi <kunyi@google.com>,
        Supreeth Venkatesh <supreeth.venkatesh@amd.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krishna Chatradhi <ch.naveen@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Eric Tremblay <etremblay@distech-controls.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: hwmon: correct indentation and style in examples
Date:   Tue, 13 Dec 2022 10:26:41 +0100
Message-Id: <20221213092643.20404-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix mixed indentation to 4-spaces, remove unnecessary suffix from
i2c node name and use lower-case hex.  No functional impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/hwmon/adi,adm1177.yaml           | 12 ++---
 .../bindings/hwmon/adi,adm1266.yaml           |  6 +--
 .../bindings/hwmon/adi,axi-fan-control.yaml   | 20 ++++-----
 .../bindings/hwmon/adi,ltc2947.yaml           | 20 ++++-----
 .../bindings/hwmon/adi,ltc2992.yaml           | 26 +++++------
 .../devicetree/bindings/hwmon/amd,sbrmi.yaml  |  6 +--
 .../devicetree/bindings/hwmon/amd,sbtsi.yaml  |  6 +--
 .../devicetree/bindings/hwmon/iio-hwmon.yaml  |  8 ++--
 .../bindings/hwmon/national,lm90.yaml         | 44 +++++++++----------
 .../bindings/hwmon/ntc-thermistor.yaml        |  2 +-
 .../bindings/hwmon/nuvoton,nct7802.yaml       | 16 +++----
 .../devicetree/bindings/hwmon/ti,tmp513.yaml  | 22 +++++-----
 .../bindings/hwmon/ti,tps23861.yaml           | 16 +++----
 13 files changed, 102 insertions(+), 102 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
index d794deb08bb7..ca2b47320689 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
@@ -52,16 +52,16 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-    i2c0 {
+    i2c {
         #address-cells = <1>;
         #size-cells = <0>;
 
         pwmon@5a {
-                compatible = "adi,adm1177";
-                reg = <0x5a>;
-                shunt-resistor-micro-ohms = <50000>; /* 50 mOhm */
-                adi,shutdown-threshold-microamp = <1059000>; /* 1.059 A */
-                adi,vrange-high-enable;
+            compatible = "adi,adm1177";
+            reg = <0x5a>;
+            shunt-resistor-micro-ohms = <50000>; /* 50 mOhm */
+            adi,shutdown-threshold-microamp = <1059000>; /* 1.059 A */
+            adi,vrange-high-enable;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
index 43b4f4f57b49..4f8e11bd5142 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
@@ -39,13 +39,13 @@ additionalProperties: false
 
 examples:
   - |
-    i2c0 {
+    i2c {
         #address-cells = <1>;
         #size-cells = <0>;
 
         adm1266@40 {
-                compatible = "adi,adm1266";
-                reg = <0x40>;
+            compatible = "adi,adm1266";
+            reg = <0x40>;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml b/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
index f2f99afb3a3b..0cf3ed6212a6 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
@@ -49,15 +49,15 @@ additionalProperties: false
 examples:
   - |
     fpga_axi: fpga-axi {
-            #address-cells = <0x2>;
-            #size-cells = <0x1>;
-
-            axi_fan_control: axi-fan-control@80000000 {
-                    compatible = "adi,axi-fan-control-1.00.a";
-                    reg = <0x0 0x80000000 0x10000>;
-                    clocks = <&clk 71>;
-                    interrupts = <0 110 0>;
-                    pulses-per-revolution = <2>;
-            };
+        #address-cells = <0x2>;
+        #size-cells = <0x1>;
+
+        axi_fan_control: axi-fan-control@80000000 {
+            compatible = "adi,axi-fan-control-1.00.a";
+            reg = <0x0 0x80000000 0x10000>;
+            clocks = <&clk 71>;
+            interrupts = <0 110 0>;
+            pulses-per-revolution = <2>;
+        };
     };
 ...
diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml
index bf04151b63d2..152935334c76 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml
@@ -87,15 +87,15 @@ additionalProperties: false
 examples:
   - |
     spi {
-           #address-cells = <1>;
-           #size-cells = <0>;
-
-           ltc2947_spi: ltc2947@0 {
-                   compatible = "adi,ltc2947";
-                   reg = <0>;
-                   /* accumulation takes place always for energ1/charge1. */
-                   /* accumulation only on positive current for energy2/charge2. */
-                   adi,accumulator-ctl-pol = <0 1>;
-           };
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ltc2947_spi: ltc2947@0 {
+            compatible = "adi,ltc2947";
+            reg = <0>;
+            /* accumulation takes place always for energ1/charge1. */
+            /* accumulation only on positive current for energy2/charge2. */
+            adi,accumulator-ctl-pol = <0 1>;
+        };
     };
 ...
diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
index 64a8fcb7bc46..ff208ab97f96 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
@@ -55,26 +55,26 @@ additionalProperties: false
 
 examples:
   - |
-    i2c1 {
+    i2c {
         #address-cells = <1>;
         #size-cells = <0>;
 
         ltc2992@6F {
-                #address-cells = <1>;
-                #size-cells = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
 
-                compatible = "adi,ltc2992";
-                reg = <0x6F>;
+            compatible = "adi,ltc2992";
+            reg = <0x6F>;
 
-                channel@0 {
-                        reg = <0x0>;
-                        shunt-resistor-micro-ohms = <10000>;
-                };
+            channel@0 {
+                reg = <0x0>;
+                shunt-resistor-micro-ohms = <10000>;
+            };
 
-                channel@1 {
-                        reg = <0x1>;
-                        shunt-resistor-micro-ohms = <10000>;
-                };
+            channel@1 {
+                reg = <0x1>;
+                shunt-resistor-micro-ohms = <10000>;
+            };
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/hwmon/amd,sbrmi.yaml b/Documentation/devicetree/bindings/hwmon/amd,sbrmi.yaml
index 7598b083979c..353d81d89bf5 100644
--- a/Documentation/devicetree/bindings/hwmon/amd,sbrmi.yaml
+++ b/Documentation/devicetree/bindings/hwmon/amd,sbrmi.yaml
@@ -41,13 +41,13 @@ additionalProperties: false
 
 examples:
   - |
-    i2c0 {
+    i2c {
         #address-cells = <1>;
         #size-cells = <0>;
 
         sbrmi@3c {
-                compatible = "amd,sbrmi";
-                reg = <0x3c>;
+            compatible = "amd,sbrmi";
+            reg = <0x3c>;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/hwmon/amd,sbtsi.yaml b/Documentation/devicetree/bindings/hwmon/amd,sbtsi.yaml
index 446b09f1ce94..75088244a274 100644
--- a/Documentation/devicetree/bindings/hwmon/amd,sbtsi.yaml
+++ b/Documentation/devicetree/bindings/hwmon/amd,sbtsi.yaml
@@ -42,13 +42,13 @@ additionalProperties: false
 
 examples:
   - |
-    i2c0 {
+    i2c {
         #address-cells = <1>;
         #size-cells = <0>;
 
         sbtsi@4c {
-                compatible = "amd,sbtsi";
-                reg = <0x4c>;
+            compatible = "amd,sbtsi";
+            reg = <0x4c>;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
index e1ccbd30e0eb..c54b5986b365 100644
--- a/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
+++ b/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
@@ -31,7 +31,7 @@ additionalProperties: false
 
 examples:
   - |
-      iio-hwmon {
-          compatible = "iio-hwmon";
-          io-channels = <&adc 1>, <&adc 2>;
-      };
+    iio-hwmon {
+        compatible = "iio-hwmon";
+        io-channels = <&adc 1>, <&adc 2>;
+    };
diff --git a/Documentation/devicetree/bindings/hwmon/national,lm90.yaml b/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
index e1719839faf0..7b9d48d6d6da 100644
--- a/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
+++ b/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
@@ -198,30 +198,30 @@ examples:
     };
   - |
     i2c {
-      #address-cells = <1>;
-      #size-cells = <0>;
-
-      sensor@4c {
-        compatible = "adi,adt7481";
-        reg = <0x4c>;
         #address-cells = <1>;
         #size-cells = <0>;
 
-        channel@0 {
-          reg = <0x0>;
-          label = "local";
-        };
-
-        channel@1 {
-          reg = <0x1>;
-          label = "front";
-          temperature-offset-millicelsius = <4000>;
-        };
-
-        channel@2 {
-          reg = <0x2>;
-          label = "back";
-          temperature-offset-millicelsius = <750>;
+        sensor@4c {
+            compatible = "adi,adt7481";
+            reg = <0x4c>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0x0>;
+                label = "local";
+            };
+
+            channel@1 {
+                reg = <0x1>;
+                label = "front";
+                temperature-offset-millicelsius = <4000>;
+            };
+
+            channel@2 {
+                reg = <0x2>;
+                label = "back";
+                temperature-offset-millicelsius = <750>;
+            };
         };
-      };
     };
diff --git a/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml b/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
index 3d3b139a91a2..def693a60f55 100644
--- a/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
@@ -132,7 +132,7 @@ additionalProperties: false
 
 examples:
   - |
-    thermistor0 {
+    thermistor {
       compatible = "murata,ncp18wb473";
       io-channels = <&gpadc 0x06>;
       pullup-uv = <1800000>;
diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
index 2f0620ecccc9..cd8dcd797031 100644
--- a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
+++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
@@ -123,23 +123,23 @@ examples:
             #size-cells = <0>;
 
             channel@0 { /* LTD */
-              reg = <0>;
+                reg = <0>;
             };
 
             channel@1 { /* RTD1 */
-              reg = <1>;
-              sensor-type = "voltage";
+                reg = <1>;
+                sensor-type = "voltage";
             };
 
             channel@2 { /* RTD2 */
-              reg = <2>;
-              sensor-type = "temperature";
-              temperature-mode = "thermal-diode";
+                reg = <2>;
+                sensor-type = "temperature";
+                temperature-mode = "thermal-diode";
             };
 
             channel@3 { /* RTD3 */
-              reg = <3>;
-              sensor-type = "temperature";
+                reg = <3>;
+                sensor-type = "temperature";
             };
         };
     };
diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml
index 1502b22c77cc..fde5225ce012 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml
@@ -77,15 +77,15 @@ additionalProperties: false
 examples:
   - |
     i2c {
-          #address-cells = <1>;
-          #size-cells = <0>;
-
-          tmp513@5c {
-              compatible = "ti,tmp513";
-              reg = <0x5C>;
-              shunt-resistor-micro-ohms = <330000>;
-              ti,bus-range-microvolt = <32000000>;
-              ti,pga-gain = <8>;
-              ti,nfactor = <0x1 0xF3 0x00>;
-          };
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tmp513@5c {
+            compatible = "ti,tmp513";
+            reg = <0x5c>;
+            shunt-resistor-micro-ohms = <330000>;
+            ti,bus-range-microvolt = <32000000>;
+            ti,pga-gain = <8>;
+            ti,nfactor = <0x1 0xf3 0x00>;
+        };
     };
diff --git a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
index 3bc8e73dfbf0..bce68a326919 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
@@ -40,12 +40,12 @@ additionalProperties: false
 examples:
   - |
     i2c {
-          #address-cells = <1>;
-          #size-cells = <0>;
-
-          tps23861@30 {
-              compatible = "ti,tps23861";
-              reg = <0x30>;
-              shunt-resistor-micro-ohms = <255000>;
-          };
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tps23861@30 {
+            compatible = "ti,tps23861";
+            reg = <0x30>;
+            shunt-resistor-micro-ohms = <255000>;
+        };
     };
-- 
2.34.1


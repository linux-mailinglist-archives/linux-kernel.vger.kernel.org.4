Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4D967276D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjARSp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjARSo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:44:58 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE952BF1E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:44:56 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h16so34890774wrz.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evJ0fcba2cE3n8ccx4J7DxpK95qJXEcv/XKwRuvqvAA=;
        b=LvLeIXiNr6wwazMg0kdUkrYMykSodqoO8vl+eMSrilh+6zROAmGk++Vw/OPCVnubl/
         qmrqOlI3+kOVrJznrZ43WroWwEGvemsbRDeVE2mMyxfpBQUCMXuI4gn+YuxVFQbhDFl4
         qW2Khyeosq/Xb62V2+hEW5jUV+4TCuVJT99x7oVnQHEmBCoZrDfLd8OnxUQLmykRm/EK
         JNXODat3ef4dU11DHGOq0cetRYNMTHNCNDpHb0y66XAtkFplnQCWYjww7Arqf9QMyU5V
         a8SY3Ka8V9Zp6E2OHimYOdiqAwAeLTEka69K+vDgpFawaCQCTID7JrJBrEfquHzH538K
         Bv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evJ0fcba2cE3n8ccx4J7DxpK95qJXEcv/XKwRuvqvAA=;
        b=xdOSySOS4B0VB8O/4cDPkV8f0Ze7DQ6VdM/bK5DGPKBIWhg75QbFb8vGmgJ0d/a2rS
         NMETPjflkZE+zIek6ENniYLoChZOuiFSKWW/o/t1KJWCdoRC8HmtRVltmUiaze8fgUkZ
         ugPP654e6ZE6apcaws2m4IYt3MgWeDYFBbS5hXzQz7Wcve7gvVr1wdOfHICismUV/Sr2
         8UAf0zoqJZizkkhk5qPL6mzrxtzffnsk7zgquHeTNnshNAxhvBvn3/9dOe6z7Fe/emJv
         00CJFkqX752RQSSd1GhJ7OVZuh6YEDh1dX5I27tExPpoQGEPeiLpETXA1WS2JPOkQTtO
         evrA==
X-Gm-Message-State: AFqh2krICicA/taJmv2HVsLhKoZQk8QeztEghwRwOBA8KaHZWusILcVh
        Cjizpp4vGqfeXiImH9MqwOxLzw==
X-Google-Smtp-Source: AMrXdXudhijn2+kiWeg8sJMy4YQHBKtWF9RlJbFo+Df2E5T/M3CMk+ny/arpxqSE6ju9MYh5YH2nQg==
X-Received: by 2002:adf:cd81:0:b0:2bd:e0e8:694f with SMTP id q1-20020adfcd81000000b002bde0e8694fmr7164303wrj.32.1674067496311;
        Wed, 18 Jan 2023 10:44:56 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g1-20020a5d46c1000000b00241cfe6e286sm31640325wrs.98.2023.01.18.10.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 10:44:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Robert Yang <decatf@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Alexandru Lazar <alazar@startmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Stefan Agner <stefan@agner.ch>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Harald Geyer <harald@ccbib.org>,
        Eugene Zaikonnikov <ez@norophonic.com>,
        Phil Reid <preid@electromag.com.au>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        chrome-platform@lists.linux.dev
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/5] dt-bindings: iio: correct node names in examples
Date:   Wed, 18 Jan 2023 19:44:11 +0100
Message-Id: <20230118184413.395820-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118184413.395820-1-krzysztof.kozlowski@linaro.org>
References: <20230118184413.395820-1-krzysztof.kozlowski@linaro.org>
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

Do not use underscores and unneeded suffixes (e.g. i2c0) in node name in
examples.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/accel/adi,adis16201.yaml      | 2 +-
 .../devicetree/bindings/iio/accel/adi,adis16240.yaml      | 2 +-
 .../devicetree/bindings/iio/accel/adi,adxl313.yaml        | 2 +-
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml        | 4 ++--
 .../devicetree/bindings/iio/accel/bosch,bma220.yaml       | 2 +-
 .../devicetree/bindings/iio/accel/nxp,fxls8962af.yaml     | 4 ++--
 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 2 +-
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 2 +-
 Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml | 2 +-
 .../devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml       | 2 +-
 .../devicetree/bindings/iio/adc/st,stmpe-adc.yaml         | 8 +++-----
 .../devicetree/bindings/iio/frequency/adf4371.yaml        | 2 +-
 .../devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml | 4 ++--
 .../devicetree/bindings/iio/health/ti,afe4403.yaml        | 2 +-
 .../devicetree/bindings/iio/health/ti,afe4404.yaml        | 2 +-
 Documentation/devicetree/bindings/iio/humidity/dht11.yaml | 2 +-
 .../devicetree/bindings/iio/humidity/ti,hdc2010.yaml      | 2 +-
 .../devicetree/bindings/iio/imu/adi,adis16460.yaml        | 2 +-
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml  | 4 ++--
 .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml         | 4 ++--
 .../devicetree/bindings/iio/pressure/asc,dlhl60d.yaml     | 2 +-
 .../devicetree/bindings/iio/pressure/bmp085.yaml          | 2 +-
 .../bindings/iio/temperature/maxim,max31865.yaml          | 2 +-
 23 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
index 7332442e5661..b6ba7ad1a8d5 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
@@ -41,7 +41,7 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
-    spi0 {
+    spi {
         #address-cells = <1>;
         #size-cells = <0>;
 
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
index f6f97164c2ca..5887021cc90f 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
@@ -39,7 +39,7 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-    spi0 {
+    spi {
         #address-cells = <1>;
         #size-cells = <0>;
 
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
index 185b68ffb536..0c5b64cae965 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
@@ -59,7 +59,7 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-    i2c0 {
+    i2c {
         #address-cells = <1>;
         #size-cells = <0>;
 
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index 346abfb13a3a..07cacc3f6a97 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -49,7 +49,7 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-    i2c0 {
+    i2c {
         #address-cells = <1>;
         #size-cells = <0>;
 
@@ -64,7 +64,7 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-    spi0 {
+    spi {
         #address-cells = <1>;
         #size-cells = <0>;
 
diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
index 5dd06f5905b4..ec643de031a3 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
@@ -36,7 +36,7 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
-    spi0 {
+    spi {
         #address-cells = <1>;
         #size-cells = <0>;
 
diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
index 65ce8ea14b52..783c7ddfcd90 100644
--- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
@@ -50,7 +50,7 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
-    i2c0 {
+    i2c {
         #address-cells = <1>;
         #size-cells = <0>;
 
@@ -65,7 +65,7 @@ examples:
     };
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
-    spi0 {
+    spi {
         #address-cells = <1>;
         #size-cells = <0>;
 
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index cc347dade4ef..1d965124c488 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -99,7 +99,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    spi0 {
+    spi {
       #address-cells = <1>;
       #size-cells = <0>;
 
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index ac5a47c8f070..b05652dfd4a2 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -112,7 +112,7 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-    spi0 {
+    spi {
         #address-cells = <1>;
         #size-cells = <0>;
 
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
index a67ba67dab51..5fcc8dd012f1 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
@@ -72,7 +72,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
-    spi0 {
+    spi {
         #address-cells = <1>;
         #size-cells = <0>;
 
diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
index 18aaf6df179d..73def67fbe01 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
@@ -50,7 +50,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
-    spmi_bus {
+    spmi {
         #address-cells = <1>;
         #size-cells = <0>;
         pmic_iadc: adc@3600 {
diff --git a/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml
index 333744a2159c..474e35c49348 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml
@@ -35,10 +35,8 @@ additionalProperties: false
 
 examples:
   - |
-    stmpe {
-        stmpe_adc {
-            compatible = "st,stmpe-adc";
-            st,norequest-mask = <0x0F>; /* dont use ADC CH3-0 */
-        };
+    adc {
+        compatible = "st,stmpe-adc";
+        st,norequest-mask = <0x0f>; /* dont use ADC CH3-0 */
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
index 0144f74a4768..a0a5e5919987 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
@@ -53,7 +53,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    spi0 {
+    spi {
         #address-cells = <1>;
         #size-cells = <0>;
 
diff --git a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
index 2c900e9dddc6..052dccbb5eea 100644
--- a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
+++ b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
@@ -65,7 +65,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
 
-    i2c0 {
+    i2c {
         #address-cells = <1>;
         #size-cells = <0>;
 
@@ -81,7 +81,7 @@ examples:
           interrupt-names = "INT1";
         };
     };
-    spi0 {
+    spi {
         #address-cells = <1>;
         #size-cells = <0>;
 
diff --git a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
index 6c5ad426a016..12f75ddc4a70 100644
--- a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
+++ b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
@@ -42,7 +42,7 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        heart_mon@0 {
+        heart-rate@0 {
             compatible = "ti,afe4403";
             reg = <0>;
             spi-max-frequency = <10000000>;
diff --git a/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml b/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
index c0e815d9999e..b334f3e356ad 100644
--- a/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
+++ b/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
@@ -39,7 +39,7 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        heart_mon@58 {
+        heart-rate@58 {
             compatible = "ti,afe4404";
             reg = <0x58>;
             tx-supply = <&vbat>;
diff --git a/Documentation/devicetree/bindings/iio/humidity/dht11.yaml b/Documentation/devicetree/bindings/iio/humidity/dht11.yaml
index 2247481d0203..0103f4238942 100644
--- a/Documentation/devicetree/bindings/iio/humidity/dht11.yaml
+++ b/Documentation/devicetree/bindings/iio/humidity/dht11.yaml
@@ -34,7 +34,7 @@ additionalProperties: false
 
 examples:
   - |
-    humidity_sensor {
+    humidity-sensor {
         compatible = "dht11";
         gpios = <&gpio0 6 0>;
     };
diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
index 88384b69f917..a36173b0c654 100644
--- a/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
+++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
@@ -35,7 +35,7 @@ additionalProperties: false
 
 examples:
   - |
-    i2c0 {
+    i2c {
       #address-cells = <1>;
       #size-cells = <0>;
 
diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
index d166dbca18c3..4e43c80e5119 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
@@ -42,7 +42,7 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-    spi0 {
+    spi {
         #address-cells = <1>;
         #size-cells = <0>;
 
diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 13c9abdd3131..3ecfb3f086bc 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -65,7 +65,7 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-    i2c0 {
+    i2c {
         #address-cells = <1>;
         #size-cells = <0>;
 
@@ -81,7 +81,7 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-    spi0 {
+    spi {
         #address-cells = <1>;
         #size-cells = <0>;
 
diff --git a/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
index 24416b59b782..db6a145840f7 100644
--- a/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
@@ -49,7 +49,7 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-    i2c0 {
+    i2c {
         #address-cells = <1>;
         #size-cells = <0>;
 
@@ -65,7 +65,7 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-    spi0 {
+    spi {
         #address-cells = <1>;
         #size-cells = <0>;
 
diff --git a/Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml b/Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml
index 1f9fe15b4b3c..9fb8d773efa3 100644
--- a/Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml
@@ -39,7 +39,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
 
-    i2c0 {
+    i2c {
         #address-cells = <1>;
         #size-cells = <0>;
 
diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index 72cd2c2d3f17..256f537840e4 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -60,7 +60,7 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-    i2c0 {
+    i2c {
       #address-cells = <1>;
       #size-cells = <0>;
       pressure@77 {
diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml b/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
index a2823ed6867b..66394e17fcc8 100644
--- a/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
@@ -43,7 +43,7 @@ examples:
        #address-cells = <1>;
        #size-cells = <0>;
 
-       temp_sensor@0 {
+       temperature-sensor@0 {
          compatible = "maxim,max31865";
          reg = <0>;
          spi-max-frequency = <400000>;
-- 
2.34.1


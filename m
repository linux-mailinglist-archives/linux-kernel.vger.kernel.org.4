Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6AF67276C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjARSpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjARSpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:45:09 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D5F2BF1E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:45:06 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h16so34891396wrz.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teBMot/khi8jS/x/1gracRsnq2VUjfO+S07O9ni9qF8=;
        b=jum73M/BNxow4MOh0yyqiiIAFeBb6gfFsIjqzrO6L3pEjFgu4HXCx9gUHXTuZ6fG93
         cj1uLAwvdEeDDv1GC51szld8Y0AHRKhsHvhvkXZ7I4t+CwjTFxzkZv3vMaxAytJYOFjT
         nSbK7z80kNy08NE3GjReqKHwZwGQdxRmdzagsuzIXr0/3iESuQcPMraoMLnmaGOvANhV
         mPcr2/VvbYDLHQfcv0+yEaZJ/+AvVOy2kB93BwvQv/cCmKRpgsmks+DkWPz3gpB3hnic
         dPhUeqx21/+Ww0orvi9z3QhEPopw1cc9KSKBLuvwO6Spn8JqTrkQD3ySkC+sKBg82GSc
         G56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teBMot/khi8jS/x/1gracRsnq2VUjfO+S07O9ni9qF8=;
        b=LBKdn/l8w34uE74soBoObE3yb+EI+414bIvjVcJFpuIb8AmXtnhJCkpn5tj1Nu9dBt
         wL4ZB4OEbCGVN8O28S1aPy33ba5Ae84ym+rcesovytnJGW2Ft0u71L7qsZguZpMn66p2
         RkoEmcdoNBbKcMFFRFvs/S3Oun8SQYQBm5WYlfNrMnKU9Bl2+NzUuD9yzC4d/M2DDo20
         jQJ+dEG3WvysabLYgcTe8Add2hDCyfi0csJdDoeY45PxYcn4nK2kHde81EH7ugzEmVkz
         DlBkZjMTjYZmHk2Dy+0aXPFtef1oaWRI6aZPssaM5yeT99YrQSVudozX8z4CkU16PDjp
         271A==
X-Gm-Message-State: AFqh2koqKNv+hB+bTYEeXa22S0ZApxyopzLC9Kdz3eJl6svIZj8tvPCH
        3gtbnLq1qbKfg2ym5E5UgLijSg==
X-Google-Smtp-Source: AMrXdXuliFBdlsmvAr3WUxXoVqw7Qi7LVi5XAU2vOyk5boidYkLZ7n44pshiZCu/cZsZzChZytL4rQ==
X-Received: by 2002:adf:f701:0:b0:2bd:da56:230c with SMTP id r1-20020adff701000000b002bdda56230cmr6499746wrp.40.1674067505933;
        Wed, 18 Jan 2023 10:45:05 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g1-20020a5d46c1000000b00241cfe6e286sm31640325wrs.98.2023.01.18.10.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 10:45:05 -0800 (PST)
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
Subject: [PATCH 5/5] dt-bindings: iio: cleanup examples - indentation
Date:   Wed, 18 Jan 2023 19:44:13 +0100
Message-Id: <20230118184413.395820-5-krzysztof.kozlowski@linaro.org>
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

Use 4-space indentation (for cases when it is neither 4 not 2 space).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/iio/accel/adi,adxl355.yaml       |  52 +++----
 .../bindings/iio/accel/adi,adxl372.yaml       |  48 +++---
 .../bindings/iio/adc/adi,ad7091r5.yaml        |   8 +-
 .../bindings/iio/adc/adi,ad7192.yaml          |   2 +-
 .../bindings/iio/adc/adi,ad7606.yaml          |  38 ++---
 .../bindings/iio/adc/adi,ad799x.yaml          |  18 +--
 .../bindings/iio/adc/adi,ad9467.yaml          |   8 +-
 .../bindings/iio/adc/adi,axi-adc.yaml         |  10 +-
 .../bindings/iio/adc/ingenic,adc.yaml         |  14 +-
 .../bindings/iio/adc/maxim,max1027.yaml       |   4 +-
 .../bindings/iio/adc/maxim,max1241.yaml       |   4 +-
 .../bindings/iio/adc/qcom,pm8018-adc.yaml     |   2 +-
 .../bindings/iio/adc/qcom,spmi-rradc.yaml     |  16 +-
 .../bindings/iio/adc/samsung,exynos-adc.yaml  |   2 +-
 .../bindings/iio/adc/ti,ads1015.yaml          |   8 +-
 .../bindings/iio/adc/ti,tsc2046.yaml          |  32 ++--
 .../bindings/iio/dac/adi,ad3552r.yaml         |  40 ++---
 .../bindings/iio/dac/adi,ad5766.yaml          |  22 +--
 .../bindings/iio/dac/adi,ad5770r.yaml         |  88 +++++------
 .../bindings/iio/dac/adi,ltc2688.yaml         |  52 +++----
 .../bindings/iio/dac/lltc,ltc2632.yaml        |  16 +-
 .../bindings/iio/frequency/adf4371.yaml       |  10 +-
 .../bindings/iio/gyroscope/adi,adxrs290.yaml  |  14 +-
 .../iio/gyroscope/nxp,fxas21002c.yaml         |  26 ++--
 .../bindings/iio/humidity/ti,hdc2010.yaml     |  12 +-
 .../bindings/iio/imu/adi,adis16475.yaml       |  24 +--
 .../bindings/iio/imu/bosch,bmi160.yaml        |  32 ++--
 .../bindings/iio/imu/invensense,icm42600.yaml |  30 ++--
 .../bindings/iio/imu/nxp,fxos8700.yaml        |  22 +--
 .../iio/magnetometer/yamaha,yas530.yaml       |  18 +--
 .../bindings/iio/pressure/bmp085.yaml         |  22 +--
 .../bindings/iio/proximity/ams,as3935.yaml    |   2 +-
 .../bindings/iio/temperature/adi,ltc2983.yaml | 137 +++++++++---------
 .../iio/temperature/maxim,max31865.yaml       |  10 +-
 34 files changed, 421 insertions(+), 422 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
index 6b03c4efbb08..c07261c71013 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
@@ -58,34 +58,34 @@ unevaluatedProperties: false
 
 examples:
   - |
-        #include <dt-bindings/gpio/gpio.h>
-        #include <dt-bindings/interrupt-controller/irq.h>
-        i2c {
-                #address-cells = <1>;
-                #size-cells = <0>;
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-                /* Example for a I2C device node */
-                accelerometer@1d {
-                        compatible = "adi,adxl355";
-                        reg = <0x1d>;
-                        interrupt-parent = <&gpio>;
-                        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
-                        interrupt-names = "DRDY";
-                };
+        /* Example for a I2C device node */
+        accelerometer@1d {
+            compatible = "adi,adxl355";
+            reg = <0x1d>;
+            interrupt-parent = <&gpio>;
+            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "DRDY";
         };
+    };
   - |
-        #include <dt-bindings/gpio/gpio.h>
-        #include <dt-bindings/interrupt-controller/irq.h>
-        spi {
-                #address-cells = <1>;
-                #size-cells = <0>;
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-                accelerometer@0 {
-                        compatible = "adi,adxl355";
-                        reg = <0>;
-                        spi-max-frequency = <1000000>;
-                        interrupt-parent = <&gpio>;
-                        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
-                        interrupt-names = "DRDY";
-                };
+        accelerometer@0 {
+            compatible = "adi,adxl355";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            interrupt-parent = <&gpio>;
+            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "DRDY";
         };
+    };
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
index 73a5c8f814cc..62465e36a590 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
@@ -37,32 +37,32 @@ unevaluatedProperties: false
 
 examples:
   - |
-        #include <dt-bindings/gpio/gpio.h>
-        #include <dt-bindings/interrupt-controller/irq.h>
-        i2c0 {
-                #address-cells = <1>;
-                #size-cells = <0>;
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-                /* Example for a I2C device node */
-                accelerometer@53 {
-                        compatible = "adi,adxl372";
-                        reg = <0x53>;
-                        interrupt-parent = <&gpio>;
-                        interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
-                };
+        /* Example for a I2C device node */
+        accelerometer@53 {
+            compatible = "adi,adxl372";
+            reg = <0x53>;
+            interrupt-parent = <&gpio>;
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
         };
+    };
   - |
-        #include <dt-bindings/gpio/gpio.h>
-        #include <dt-bindings/interrupt-controller/irq.h>
-        spi0 {
-                #address-cells = <1>;
-                #size-cells = <0>;
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-                accelerometer@0 {
-                        compatible = "adi,adxl372";
-                        reg = <0>;
-                        spi-max-frequency = <1000000>;
-                        interrupt-parent = <&gpio>;
-                        interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
-                };
+        accelerometer@0 {
+            compatible = "adi,adxl372";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            interrupt-parent = <&gpio>;
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
         };
+    };
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
index b97559f23b3a..ce7ba634643c 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
@@ -44,11 +44,11 @@ examples:
         #size-cells = <0>;
 
         adc@2f {
-                compatible = "adi,ad7091r5";
-                reg = <0x2f>;
+            compatible = "adi,ad7091r5";
+            reg = <0x2f>;
 
-                interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
-                interrupt-parent = <&gpio>;
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio>;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index 1d965124c488..04b12146959e 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -120,5 +120,5 @@ examples:
         adi,rejection-60-Hz-enable;
         adi,buffer-enable;
         adi,burnout-currents-enable;
-        };
+      };
     };
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index b05652dfd4a2..7fa46df1f4fb 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -117,25 +117,25 @@ examples:
         #size-cells = <0>;
 
         adc@0 {
-                compatible = "adi,ad7606-8";
-                reg = <0>;
-                spi-max-frequency = <1000000>;
-                spi-cpol;
-                spi-cpha;
-
-                avcc-supply = <&adc_vref>;
-
-                interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
-                interrupt-parent = <&gpio>;
-
-                adi,conversion-start-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
-                reset-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
-                adi,first-data-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
-                adi,oversampling-ratio-gpios = <&gpio 18 GPIO_ACTIVE_HIGH>,
-                                               <&gpio 23 GPIO_ACTIVE_HIGH>,
-                                               <&gpio 26 GPIO_ACTIVE_HIGH>;
-                standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
-                adi,sw-mode;
+            compatible = "adi,ad7606-8";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            spi-cpol;
+            spi-cpha;
+
+            avcc-supply = <&adc_vref>;
+
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio>;
+
+            adi,conversion-start-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
+            adi,first-data-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+            adi,oversampling-ratio-gpios = <&gpio 18 GPIO_ACTIVE_HIGH>,
+                                           <&gpio 23 GPIO_ACTIVE_HIGH>,
+                                           <&gpio 26 GPIO_ACTIVE_HIGH>;
+            standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
+            adi,sw-mode;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml
index 29641ce7175b..433ed2c9295f 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml
@@ -57,17 +57,17 @@ additionalProperties: false
 examples:
   - |
     i2c {
-      #address-cells = <1>;
-      #size-cells = <0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-       adc1: adc@28 {
-               reg = <0x28>;
-               compatible = "adi,ad7991";
-               interrupts = <13 2>;
-               interrupt-parent = <&gpio6>;
+        adc1: adc@28 {
+            reg = <0x28>;
+            compatible = "adi,ad7991";
+            interrupts = <13 2>;
+            interrupt-parent = <&gpio6>;
 
-               vcc-supply = <&vcc_3v3>;
-               vref-supply = <&adc_vref>;
+            vcc-supply = <&vcc_3v3>;
+            vref-supply = <&adc_vref>;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
index 2d72ff6bcbc0..7aa748d6b7a0 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
@@ -64,10 +64,10 @@ examples:
         #size-cells = <0>;
 
         adc@0 {
-          compatible = "adi,ad9467";
-          reg = <0>;
-          clocks = <&adc_clk>;
-          clock-names = "adc-clk";
+            compatible = "adi,ad9467";
+            reg = <0>;
+            clocks = <&adc_clk>;
+            clock-names = "adc-clk";
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index 8e25773d69be..9996dd93f84b 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -51,11 +51,11 @@ additionalProperties: false
 examples:
   - |
     axi-adc@44a00000 {
-          compatible = "adi,axi-adc-10.0.a";
-          reg = <0x44a00000 0x10000>;
-          dmas = <&rx_dma 0>;
-          dma-names = "rx";
+        compatible = "adi,axi-adc-10.0.a";
+        reg = <0x44a00000 0x10000>;
+        dmas = <&rx_dma 0>;
+        dma-names = "rx";
 
-          adi,adc-dev = <&spi_adc>;
+        adi,adc-dev = <&spi_adc>;
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
index b71c951e6d02..9cd0fd539782 100644
--- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
@@ -78,14 +78,14 @@ examples:
     #include <dt-bindings/iio/adc/ingenic,adc.h>
 
     adc@10070000 {
-            compatible = "ingenic,jz4740-adc";
-            #io-channel-cells = <1>;
+        compatible = "ingenic,jz4740-adc";
+        #io-channel-cells = <1>;
 
-            reg = <0x10070000 0x30>;
+        reg = <0x10070000 0x30>;
 
-            clocks = <&cgu JZ4740_CLK_ADC>;
-            clock-names = "adc";
+        clocks = <&cgu JZ4740_CLK_ADC>;
+        clock-names = "adc";
 
-            interrupt-parent = <&intc>;
-            interrupts = <18>;
+        interrupt-parent = <&intc>;
+        interrupts = <18>;
     };
diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1027.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1027.yaml
index d0a7ed26d9ea..e4b362113509 100644
--- a/Documentation/devicetree/bindings/iio/adc/maxim,max1027.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1027.yaml
@@ -54,8 +54,8 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
     spi {
-       #address-cells = <1>;
-       #size-cells = <0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
         maxadc: adc@0 {
             compatible = "maxim,max1027";
             reg = <0>;
diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
index 58b12fe8070c..ef8d51e74c08 100644
--- a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
@@ -54,8 +54,8 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
     spi {
-      #address-cells = <1>;
-      #size-cells = <0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
 
         adc@0 {
             compatible = "maxim,max1241";
diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,pm8018-adc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,pm8018-adc.yaml
index d186b713d6a7..58ea1ca4a5ee 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,pm8018-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,pm8018-adc.yaml
@@ -160,7 +160,7 @@ examples:
             };
             ref_muxoff: adc-channel@f {
                 reg = <0x00 0x0f>;
-           };
+            };
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
index c8cbfd3444be..b3a626389870 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
@@ -40,12 +40,12 @@ additionalProperties: false
 examples:
   - |
     pmic {
-      #address-cells = <1>;
-      #size-cells = <0>;
-
-      pmic_rradc: adc@4500 {
-          compatible = "qcom,pmi8998-rradc";
-          reg = <0x4500>;
-          #io-channel-cells  = <1>;
-      };
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic_rradc: adc@4500 {
+            compatible = "qcom,pmi8998-rradc";
+            reg = <0x4500>;
+            #io-channel-cells  = <1>;
+        };
     };
diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index dca6cfe1e88e..582d0a03b814 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -142,7 +142,7 @@ examples:
             pullup-ohm = <47000>;
             pulldown-ohm = <0>;
             io-channels = <&adc 4>;
-          };
+        };
     };
 
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
index 2c3c2cf2145c..2127d639a768 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
@@ -104,12 +104,12 @@ examples:
             #address-cells = <1>;
             #size-cells = <0>;
             channel@0 {
-              reg = <0>;
+                reg = <0>;
             };
             channel@4 {
-              reg = <4>;
-              ti,gain = <3>;
-              ti,datarate = <5>;
+                reg = <4>;
+                ti,gain = <3>;
+                ti,datarate = <5>;
             };
         };
     };
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml b/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
index 32c52f9fe18b..866a05c9db36 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
@@ -83,36 +83,36 @@ examples:
             #size-cells = <0>;
 
             channel@0 {
-              reg = <0>;
+                reg = <0>;
             };
             channel@1 {
-              reg = <1>;
-              settling-time-us = <700>;
-              oversampling-ratio = <5>;
+                reg = <1>;
+                settling-time-us = <700>;
+                oversampling-ratio = <5>;
             };
             channel@2 {
-              reg = <2>;
+                reg = <2>;
             };
             channel@3 {
-              reg = <3>;
-              settling-time-us = <700>;
-              oversampling-ratio = <5>;
+                reg = <3>;
+                settling-time-us = <700>;
+                oversampling-ratio = <5>;
             };
             channel@4 {
-              reg = <4>;
-              settling-time-us = <700>;
-              oversampling-ratio = <5>;
+                reg = <4>;
+                settling-time-us = <700>;
+                oversampling-ratio = <5>;
             };
             channel@5 {
-              reg = <5>;
-              settling-time-us = <700>;
-              oversampling-ratio = <5>;
+                reg = <5>;
+                settling-time-us = <700>;
+                oversampling-ratio = <5>;
             };
             channel@6 {
-              reg = <6>;
+                reg = <6>;
             };
             channel@7 {
-              reg = <7>;
+                reg = <7>;
             };
         };
     };
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
index fee0f023a8c8..96340a05754c 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -192,26 +192,26 @@ additionalProperties: false
 examples:
   - |
     spi {
-      #address-cells = <1>;
-      #size-cells = <0>;
-      ad3552r@0 {
-              compatible = "adi,ad3552r";
-              reg = <0>;
-              spi-max-frequency = <20000000>;
-              #address-cells = <1>;
-              #size-cells = <0>;
-              channel@0 {
-                      reg = <0>;
-                      adi,output-range-microvolt = <0 10000000>;
-              };
-              channel@1 {
-                      reg = <1>;
-                      custom-output-range-config {
-                              adi,gain-offset = <5>;
-                              adi,gain-scaling-p-inv-log2 = <1>;
-                              adi,gain-scaling-n-inv-log2 = <2>;
-                              adi,rfb-ohms = <1>;
-                      };
+        #address-cells = <1>;
+        #size-cells = <0>;
+        ad3552r@0 {
+            compatible = "adi,ad3552r";
+            reg = <0>;
+            spi-max-frequency = <20000000>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+                reg = <0>;
+                adi,output-range-microvolt = <0 10000000>;
+            };
+            channel@1 {
+                reg = <1>;
+                custom-output-range-config {
+                    adi,gain-offset = <5>;
+                    adi,gain-scaling-p-inv-log2 = <1>;
+                    adi,gain-scaling-n-inv-log2 = <2>;
+                    adi,rfb-ohms = <1>;
+                };
             };
         };
     };
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
index 3c8784a54d2c..212c936bab8d 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
@@ -51,15 +51,15 @@ additionalProperties: false
 examples:
   - |
     spi {
-          #address-cells = <1>;
-          #size-cells = <0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-          ad5766@0 {
-              compatible = "adi,ad5766";
-              output-range-microvolts = <(-5000000) 5000000>;
-              reg = <0>;
-              spi-cpol;
-              spi-max-frequency = <1000000>;
-              reset-gpios = <&gpio 22 0>;
-            };
-      };
+        ad5766@0 {
+            compatible = "adi,ad5766";
+            output-range-microvolts = <(-5000000) 5000000>;
+            reg = <0>;
+            spi-cpol;
+            spi-max-frequency = <1000000>;
+            reset-gpios = <&gpio 22 0>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
index 8e7da0de918f..82b0eed6a7b7 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
@@ -147,49 +147,49 @@ unevaluatedProperties: false
 
 examples:
   - |
-        spi {
-                #address-cells = <1>;
-                #size-cells = <0>;
-
-                ad5770r@0 {
-                        compatible = "adi,ad5770r";
-                        reg = <0>;
-                        spi-max-frequency = <1000000>;
-                        vref-supply = <&vref>;
-                        adi,external-resistor;
-                        reset-gpios = <&gpio 22 0>;
-                        #address-cells = <1>;
-                        #size-cells = <0>;
-
-                        channel@0 {
-                                reg = <0>;
-                                adi,range-microamp = <0 300000>;
-                        };
-
-                        channel@1 {
-                                reg = <1>;
-                                adi,range-microamp = <0 140000>;
-                        };
-
-                        channel@2 {
-                                reg = <2>;
-                                adi,range-microamp = <0 55000>;
-                        };
-
-                        channel@3 {
-                                reg = <3>;
-                                adi,range-microamp = <0 45000>;
-                        };
-
-                        channel@4 {
-                                reg = <4>;
-                                adi,range-microamp = <0 45000>;
-                        };
-
-                        channel@5 {
-                                reg = <5>;
-                                adi,range-microamp = <0 45000>;
-                        };
-                };
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ad5770r@0 {
+            compatible = "adi,ad5770r";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            vref-supply = <&vref>;
+            adi,external-resistor;
+            reset-gpios = <&gpio 22 0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                adi,range-microamp = <0 300000>;
+            };
+
+            channel@1 {
+                reg = <1>;
+                adi,range-microamp = <0 140000>;
+            };
+
+            channel@2 {
+                reg = <2>;
+                adi,range-microamp = <0 55000>;
+            };
+
+            channel@3 {
+                reg = <3>;
+                adi,range-microamp = <0 45000>;
+            };
+
+            channel@4 {
+                reg = <4>;
+                adi,range-microamp = <0 45000>;
+            };
+
+            channel@5 {
+                reg = <5>;
+                adi,range-microamp = <0 45000>;
+            };
         };
+    };
 ...
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
index 15cc6bf59b13..f22ef710ecde 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
@@ -116,32 +116,32 @@ examples:
   - |
 
     spi {
-          #address-cells = <1>;
-          #size-cells = <0>;
-          ltc2688: ltc2688@0 {
-                  compatible = "adi,ltc2688";
-                  reg = <0>;
-
-                  vcc-supply = <&vcc>;
-                  iovcc-supply = <&vcc>;
-                  vref-supply = <&vref>;
-
-                  #address-cells = <1>;
-                  #size-cells = <0>;
-                  channel@0 {
-                          reg = <0>;
-                          adi,toggle-mode;
-                          adi,overrange;
-                  };
-
-                  channel@1 {
-                          reg = <1>;
-                          adi,output-range-microvolt = <0 10000000>;
-
-                          clocks = <&clock_tgp3>;
-                          adi,toggle-dither-input = <2>;
-                  };
-          };
+        #address-cells = <1>;
+        #size-cells = <0>;
+        ltc2688: ltc2688@0 {
+            compatible = "adi,ltc2688";
+            reg = <0>;
+
+            vcc-supply = <&vcc>;
+            iovcc-supply = <&vcc>;
+            vref-supply = <&vref>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+                reg = <0>;
+                adi,toggle-mode;
+                adi,overrange;
+            };
+
+            channel@1 {
+                reg = <1>;
+                adi,output-range-microvolt = <0 10000000>;
+
+                clocks = <&clock_tgp3>;
+                adi,toggle-dither-input = <2>;
+            };
+        };
     };
 
 ...
diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
index c9e3be3b5754..733edc7d6d17 100644
--- a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
@@ -64,14 +64,14 @@ examples:
     };
 
     spi {
-      #address-cells = <1>;
-      #size-cells = <0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-      dac@0 {
-        compatible = "lltc,ltc2632-l12";
-        reg = <0>;    /* CS0 */
-        spi-max-frequency = <1000000>;
-        vref-supply = <&vref>;
-      };
+        dac@0 {
+            compatible = "lltc,ltc2632-l12";
+            reg = <0>;    /* CS0 */
+            spi-max-frequency = <1000000>;
+            vref-supply = <&vref>;
+        };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
index a0a5e5919987..1cb2adaf66f9 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
@@ -58,11 +58,11 @@ examples:
         #size-cells = <0>;
 
         frequency@0 {
-                compatible = "adi,adf4371";
-                reg = <0>;
-                spi-max-frequency = <1000000>;
-                clocks = <&adf4371_clkin>;
-                clock-names = "clkin";
+            compatible = "adi,adf4371";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            clocks = <&adf4371_clkin>;
+            clock-names = "clkin";
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
index 0ae2464b9bc4..3d94dd4612c4 100644
--- a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
+++ b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
@@ -50,13 +50,13 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
         gyro@0 {
-                   compatible = "adi,adxrs290";
-                   reg = <0>;
-                   spi-max-frequency = <5000000>;
-                   spi-cpol;
-                   spi-cpha;
-                   interrupt-parent = <&gpio>;
-                   interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+            compatible = "adi,adxrs290";
+            reg = <0>;
+            spi-max-frequency = <5000000>;
+            spi-cpol;
+            spi-cpha;
+            interrupt-parent = <&gpio>;
+            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
index 052dccbb5eea..297d519d68f2 100644
--- a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
+++ b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
@@ -70,15 +70,15 @@ examples:
         #size-cells = <0>;
 
         gyroscope@20 {
-          compatible = "nxp,fxas21002c";
-          reg = <0x20>;
+            compatible = "nxp,fxas21002c";
+            reg = <0x20>;
 
-          vdd-supply = <&reg_peri_3p15v>;
-          vddio-supply = <&reg_peri_3p15v>;
+            vdd-supply = <&reg_peri_3p15v>;
+            vddio-supply = <&reg_peri_3p15v>;
 
-          interrupt-parent = <&gpio1>;
-          interrupts = <7 IRQ_TYPE_EDGE_RISING>;
-          interrupt-names = "INT1";
+            interrupt-parent = <&gpio1>;
+            interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "INT1";
         };
     };
     spi {
@@ -86,13 +86,13 @@ examples:
         #size-cells = <0>;
 
         gyroscope@0 {
-          compatible = "nxp,fxas21002c";
-          reg = <0x0>;
+            compatible = "nxp,fxas21002c";
+            reg = <0x0>;
 
-          spi-max-frequency = <2000000>;
+            spi-max-frequency = <2000000>;
 
-          interrupt-parent = <&gpio2>;
-          interrupts = <7 IRQ_TYPE_EDGE_RISING>;
-          interrupt-names = "INT2";
+            interrupt-parent = <&gpio2>;
+            interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "INT2";
         };
     };
diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
index a36173b0c654..a2bc1fa92da0 100644
--- a/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
+++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
@@ -36,11 +36,11 @@ additionalProperties: false
 examples:
   - |
     i2c {
-      #address-cells = <1>;
-      #size-cells = <0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-      humidity@40 {
-          compatible = "ti,hdc2010";
-          reg = <0x40>;
-      };
+        humidity@40 {
+            compatible = "ti,hdc2010";
+            reg = <0x40>;
+        };
     };
diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
index 5dbfae80bb28..c73533c54588 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
@@ -114,17 +114,17 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
     spi {
-            #address-cells = <1>;
-            #size-cells = <0>;
-
-            adis16475: adis16475-3@0 {
-                    compatible = "adi,adis16475-3";
-                    reg = <0>;
-                    spi-cpha;
-                    spi-cpol;
-                    spi-max-frequency = <2000000>;
-                    interrupts = <4 IRQ_TYPE_EDGE_RISING>;
-                    interrupt-parent = <&gpio>;
-            };
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adis16475: adis16475-3@0 {
+            compatible = "adi,adis16475-3";
+            reg = <0>;
+            spi-cpha;
+            spi-cpol;
+            spi-max-frequency = <2000000>;
+            interrupts = <4 IRQ_TYPE_EDGE_RISING>;
+            interrupt-parent = <&gpio>;
+        };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
index a0760382548d..47cfba939ca6 100644
--- a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
@@ -64,16 +64,16 @@ examples:
         #size-cells = <0>;
 
         bmi160@68 {
-                compatible = "bosch,bmi160";
-                reg = <0x68>;
-                vdd-supply = <&pm8916_l17>;
-                vddio-supply = <&pm8916_l6>;
-                interrupt-parent = <&gpio4>;
-                interrupts = <12 IRQ_TYPE_EDGE_RISING>;
-                interrupt-names = "INT1";
-                mount-matrix = "0", "1", "0",
-                               "-1", "0", "0",
-                               "0", "0", "1";
+            compatible = "bosch,bmi160";
+            reg = <0x68>;
+            vdd-supply = <&pm8916_l17>;
+            vddio-supply = <&pm8916_l6>;
+            interrupt-parent = <&gpio4>;
+            interrupts = <12 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "INT1";
+            mount-matrix = "0", "1", "0",
+                           "-1", "0", "0",
+                           "0", "0", "1";
         };
     };
   - |
@@ -84,11 +84,11 @@ examples:
         #size-cells = <0>;
 
         bmi160@0 {
-                compatible = "bosch,bmi160";
-                reg = <0>;
-                spi-max-frequency = <10000000>;
-                interrupt-parent = <&gpio2>;
-                interrupts = <12 IRQ_TYPE_EDGE_RISING>;
-                interrupt-names = "INT2";
+            compatible = "bosch,bmi160";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+            interrupt-parent = <&gpio2>;
+            interrupts = <12 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "INT2";
         };
     };
diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 3ecfb3f086bc..7cd05bcbee31 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -70,12 +70,12 @@ examples:
         #size-cells = <0>;
 
         icm42605@68 {
-          compatible = "invensense,icm42605";
-          reg = <0x68>;
-          interrupt-parent = <&gpio2>;
-          interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
-          vdd-supply = <&vdd>;
-          vddio-supply = <&vddio>;
+            compatible = "invensense,icm42605";
+            reg = <0x68>;
+            interrupt-parent = <&gpio2>;
+            interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
         };
     };
   - |
@@ -86,14 +86,14 @@ examples:
         #size-cells = <0>;
 
         icm42602@0 {
-          compatible = "invensense,icm42602";
-          reg = <0>;
-          spi-max-frequency = <24000000>;
-          spi-cpha;
-          spi-cpol;
-          interrupt-parent = <&gpio1>;
-          interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
-          vdd-supply = <&vdd>;
-          vddio-supply = <&vddio>;
+            compatible = "invensense,icm42602";
+            reg = <0>;
+            spi-max-frequency = <24000000>;
+            spi-cpha;
+            spi-cpol;
+            interrupt-parent = <&gpio1>;
+            interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
         };
     };
diff --git a/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
index db6a145840f7..688100b240bc 100644
--- a/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
@@ -54,12 +54,12 @@ examples:
         #size-cells = <0>;
 
         fxos8700@1e {
-          compatible = "nxp,fxos8700";
-          reg = <0x1e>;
+            compatible = "nxp,fxos8700";
+            reg = <0x1e>;
 
-          interrupt-parent = <&gpio2>;
-          interrupts = <7 IRQ_TYPE_EDGE_RISING>;
-          interrupt-names = "INT1";
+            interrupt-parent = <&gpio2>;
+            interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "INT1";
         };
     };
   - |
@@ -70,12 +70,12 @@ examples:
         #size-cells = <0>;
 
         fxos8700@0 {
-          compatible = "nxp,fxos8700";
-          reg = <0>;
+            compatible = "nxp,fxos8700";
+            reg = <0>;
 
-          spi-max-frequency = <1000000>;
-          interrupt-parent = <&gpio1>;
-          interrupts = <7 IRQ_TYPE_EDGE_RISING>;
-          interrupt-names = "INT2";
+            spi-max-frequency = <1000000>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "INT2";
         };
     };
diff --git a/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml b/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml
index 9438fffaf0ba..877226e9219b 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml
@@ -91,12 +91,12 @@ examples:
         #size-cells = <0>;
 
         magnetometer@2e {
-          compatible = "yamaha,yas530";
-          reg = <0x2e>;
-          vdd-supply = <&ldo1_reg>;
-          iovdd-supply = <&ldo2_reg>;
-          reset-gpios = <&gpio6 12 GPIO_ACTIVE_LOW>;
-          interrupts = <13 IRQ_TYPE_EDGE_RISING>;
+            compatible = "yamaha,yas530";
+            reg = <0x2e>;
+            vdd-supply = <&ldo1_reg>;
+            iovdd-supply = <&ldo2_reg>;
+            reset-gpios = <&gpio6 12 GPIO_ACTIVE_LOW>;
+            interrupts = <13 IRQ_TYPE_EDGE_RISING>;
         };
     };
 
@@ -105,8 +105,8 @@ examples:
         #size-cells = <0>;
 
         magnetometer@2e {
-          compatible = "yamaha,yas539";
-          reg = <0x2e>;
-          vdd-supply = <&ldo1_reg>;
+            compatible = "yamaha,yas539";
+            reg = <0x2e>;
+            vdd-supply = <&ldo1_reg>;
         };
     };
diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index 256f537840e4..63885af6a74b 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -61,15 +61,15 @@ examples:
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
-      #address-cells = <1>;
-      #size-cells = <0>;
-      pressure@77 {
-          compatible = "bosch,bmp085";
-          reg = <0x77>;
-          interrupt-parent = <&gpio0>;
-          interrupts = <25 IRQ_TYPE_EDGE_RISING>;
-          reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
-          vddd-supply = <&foo>;
-          vdda-supply = <&bar>;
-      };
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pressure@77 {
+            compatible = "bosch,bmp085";
+            reg = <0x77>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+            reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
+            vddd-supply = <&foo>;
+            vdda-supply = <&bar>;
+        };
     };
diff --git a/Documentation/devicetree/bindings/iio/proximity/ams,as3935.yaml b/Documentation/devicetree/bindings/iio/proximity/ams,as3935.yaml
index 710d3b9a86d9..c999994e19e3 100644
--- a/Documentation/devicetree/bindings/iio/proximity/ams,as3935.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/ams,as3935.yaml
@@ -60,7 +60,7 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-    lightning@0 {
+        lightning@0 {
             compatible = "ams,as3935";
             reg = <0>;
             spi-max-frequency = <400000>;
diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index 3e5b7b47bcdc..f44fc32ce87e 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -472,75 +472,74 @@ examples:
         #size-cells = <0>;
 
         temperature-sensor@0 {
-                compatible = "adi,ltc2983";
-                reg = <0>;
-
-                #address-cells = <1>;
-                #size-cells = <0>;
-
-                interrupts = <20 IRQ_TYPE_EDGE_RISING>;
-                interrupt-parent = <&gpio>;
-
-                thermocouple@18 {
-                        reg = <18>;
-                        adi,sensor-type = <8>; //Type B
-                        adi,sensor-oc-current-microamp = <10>;
-                        adi,cold-junction-handle = <&diode5>;
-                };
-
-                diode5: diode@5 {
-                        reg = <5>;
-                        adi,sensor-type = <28>;
-                };
-
-                rsense2: rsense@2 {
-                        reg = <2>;
-                        adi,sensor-type = <29>;
-                        adi,rsense-val-milli-ohms = <1200000>; //1.2Kohms
-                };
-
-                rtd@14 {
-                        reg = <14>;
-                        adi,sensor-type = <15>; //PT1000
-                        /*2-wire, internal gnd, no current rotation*/
-                        adi,number-of-wires = <2>;
-                        adi,rsense-share;
-                        adi,excitation-current-microamp = <500>;
-                        adi,rsense-handle = <&rsense2>;
-                };
-
-                adc@10 {
-                        reg = <10>;
-                        adi,sensor-type = <30>;
-                        adi,single-ended;
-                };
-
-                thermistor@12 {
-                        reg = <12>;
-                        adi,sensor-type = <26>; //Steinhart
-                        adi,rsense-handle = <&rsense2>;
-                        adi,custom-steinhart = <0x00f371ec 0x12345678
-                                        0x2c0f8733 0x10018c66 0xa0feaccd
-                                        0x90021d99>; //6 entries
-                };
-
-                thermocouple@20 {
-                        reg = <20>;
-                        adi,sensor-type = <9>; //custom thermocouple
-                        adi,single-ended;
-                        adi,custom-thermocouple =
-                                 /bits/ 64 <(-50220000) 0>,
-                                 /bits/ 64 <(-30200000) 99100000>,
-                                 /bits/ 64 <(-5300000) 135400000>,
-                                 /bits/ 64 <0 273150000>,
-                                 /bits/ 64 <40200000 361200000>,
-                                 /bits/ 64 <55300000 522100000>,
-                                 /bits/ 64 <88300000 720300000>,
-                                 /bits/ 64 <132200000 811200000>,
-                                 /bits/ 64 <188700000 922500000>,
-                                 /bits/ 64 <460400000 1000000000>; //10 pairs
-               };
-
+            compatible = "adi,ltc2983";
+            reg = <0>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            interrupts = <20 IRQ_TYPE_EDGE_RISING>;
+            interrupt-parent = <&gpio>;
+
+            thermocouple@18 {
+                reg = <18>;
+                adi,sensor-type = <8>; //Type B
+                adi,sensor-oc-current-microamp = <10>;
+                adi,cold-junction-handle = <&diode5>;
+            };
+
+            diode5: diode@5 {
+                reg = <5>;
+                adi,sensor-type = <28>;
+            };
+
+            rsense2: rsense@2 {
+                reg = <2>;
+                adi,sensor-type = <29>;
+                adi,rsense-val-milli-ohms = <1200000>; //1.2Kohms
+            };
+
+            rtd@14 {
+                reg = <14>;
+                adi,sensor-type = <15>; //PT1000
+                /*2-wire, internal gnd, no current rotation*/
+                adi,number-of-wires = <2>;
+                adi,rsense-share;
+                adi,excitation-current-microamp = <500>;
+                adi,rsense-handle = <&rsense2>;
+            };
+
+            adc@10 {
+                reg = <10>;
+                adi,sensor-type = <30>;
+                adi,single-ended;
+            };
+
+            thermistor@12 {
+                reg = <12>;
+                adi,sensor-type = <26>; //Steinhart
+                adi,rsense-handle = <&rsense2>;
+                adi,custom-steinhart = <0x00f371ec 0x12345678
+                                0x2c0f8733 0x10018c66 0xa0feaccd
+                                0x90021d99>; //6 entries
+            };
+
+            thermocouple@20 {
+                reg = <20>;
+                adi,sensor-type = <9>; //custom thermocouple
+                adi,single-ended;
+                adi,custom-thermocouple =
+                         /bits/ 64 <(-50220000) 0>,
+                         /bits/ 64 <(-30200000) 99100000>,
+                         /bits/ 64 <(-5300000) 135400000>,
+                         /bits/ 64 <0 273150000>,
+                         /bits/ 64 <40200000 361200000>,
+                         /bits/ 64 <55300000 522100000>,
+                         /bits/ 64 <88300000 720300000>,
+                         /bits/ 64 <132200000 811200000>,
+                         /bits/ 64 <188700000 922500000>,
+                         /bits/ 64 <460400000 1000000000>; //10 pairs
+            };
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml b/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
index 66394e17fcc8..7cc365e0ebc8 100644
--- a/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
@@ -44,11 +44,11 @@ examples:
        #size-cells = <0>;
 
        temperature-sensor@0 {
-         compatible = "maxim,max31865";
-         reg = <0>;
-         spi-max-frequency = <400000>;
-         spi-cpha;
-         maxim,3-wire;
+           compatible = "maxim,max31865";
+           reg = <0>;
+           spi-max-frequency = <400000>;
+           spi-cpha;
+           maxim,3-wire;
        };
     };
 ...
-- 
2.34.1


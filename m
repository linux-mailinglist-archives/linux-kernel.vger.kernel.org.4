Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF796792AE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjAXILM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjAXILD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:11:03 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622353F29A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:10:59 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso10269288wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2eFx8hmLeuzWFzYWSsE+TXFjBiA5A2Oyt7JXHYHzrc=;
        b=ZlGkrkDnc8YTjQHMMvtegVUroRi6GUDEu2MidWE8PImVhiUtKK4jT+NYQrTsxUJl/V
         C2cEmhG5sk2j8dxas0931I80yX4Tl0P6hHQQOrUike0GfauC8Pp9BN26M/fOp3Ifnum7
         nHexlnWUuuqxBhJSGSOMj8oQ9j0oJY5GPXKFwlaE2WcSfhUb9hHzUPygWqBz0zxOwlR6
         CTcoirGAjlHovPi/0h+wLl5mveaqpvf/rSkizERJmwl3/JUbYW5xh1QRcudy/kVRFi2/
         HG7Yn6BVjzfMF3JzWkQYGL7qrl94v2wY+U5AB/j01iUOWZ9zzeX6By5duPW8eJVETcAH
         WAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2eFx8hmLeuzWFzYWSsE+TXFjBiA5A2Oyt7JXHYHzrc=;
        b=DOkGY0b8f2xOD4/twpgsOeLjXXGaT1F9KwXLF0i/+9djV+MMR8JMlkCeJWWfnyjL/B
         lNHRiJn4mJ//Cky2Ty4vj/ZnYhHMpMq2xrciUlw7NrXoXF+aQNFGIkdz8kqqGX86zRp2
         dcd5DhRgxfQqC3mjCO5Sh4h1RIvADz8WdcRwbmulXi+U5VlLXW0lDijSiTT5i5i2SC3g
         Pedvx3v105id3QvteWgeCzrGvrlUNXLS3gWYur30/lcLCmCEliwrFXCXoS66YJ7uDOAs
         +Ktq0ttvdf+SYRoCHjvjge8q35zioKUDeMxXhLG9prd55yzWsNHm/R6hfI/y1XYyhWAn
         SaLA==
X-Gm-Message-State: AFqh2kpNR5hAPR0+pAZL8TdjqWToNW0kwZcApaHsPnb5lOO4+ew90DQF
        oI22oiOZb8U+35yi7g4QCR/Ohw==
X-Google-Smtp-Source: AMrXdXubVYet+X90aqye25ndwzU7J0wg7EDnCS0HKplqtVhIY08XI8qJAe3meeiEaYW8/JluYqLzmQ==
X-Received: by 2002:a05:600c:4f83:b0:3db:eab:a600 with SMTP id n3-20020a05600c4f8300b003db0eaba600mr23742673wmq.7.1674547858887;
        Tue, 24 Jan 2023 00:10:58 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003db30be4a54sm13459779wms.38.2023.01.24.00.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 00:10:58 -0800 (PST)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 4/5] dt-bindings: iio: use lowercase hex in examples
Date:   Tue, 24 Jan 2023 09:10:36 +0100
Message-Id: <20230124081037.31013-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124081037.31013-1-krzysztof.kozlowski@linaro.org>
References: <20230124081037.31013-1-krzysztof.kozlowski@linaro.org>
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

Use lowercase hex in addresses in examples.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml     | 2 +-
 .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml     | 2 +-
 Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml   | 2 +-
 .../devicetree/bindings/iio/potentiometer/adi,ad5272.yaml   | 2 +-
 .../devicetree/bindings/iio/temperature/adi,ltc2983.yaml    | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml
index 714e48e613de..6ddb03f61bd9 100644
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml
@@ -44,7 +44,7 @@ examples:
 
         accel@f {
             compatible = "kionix,kxtf9";
-            reg = <0x0F>;
+            reg = <0xf>;
             mount-matrix = "0", "1", "0",
                            "1", "0", "0",
                            "0", "0", "1";
diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index e27d094cfa05..dca6cfe1e88e 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -150,7 +150,7 @@ examples:
 
     adc@126c0000 {
         compatible = "samsung,exynos3250-adc";
-        reg = <0x126C0000 0x100>;
+        reg = <0x126c0000 0x100>;
         interrupts = <0 137 0>;
         #io-channel-cells = <1>;
 
diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
index 88298bc43b81..79da0323c327 100644
--- a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
@@ -46,7 +46,7 @@ examples:
 
         dac@4c {
             compatible = "ti,dac5571";
-            reg = <0x4C>;
+            reg = <0x4c>;
             vref-supply = <&vdd_supply>;
         };
     };
diff --git a/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml
index 0ebb6725a1af..b8d7083c97f8 100644
--- a/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml
+++ b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml
@@ -44,7 +44,7 @@ examples:
 
         potentiometer@2f {
             compatible = "adi,ad5272-020";
-            reg = <0x2F>;
+            reg = <0x2f>;
             reset-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
         };
     };
diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index b69813f281da..3e5b7b47bcdc 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -519,9 +519,9 @@ examples:
                         reg = <12>;
                         adi,sensor-type = <26>; //Steinhart
                         adi,rsense-handle = <&rsense2>;
-                        adi,custom-steinhart = <0x00F371EC 0x12345678
-                                        0x2C0F8733 0x10018C66 0xA0FEACCD
-                                        0x90021D99>; //6 entries
+                        adi,custom-steinhart = <0x00f371ec 0x12345678
+                                        0x2c0f8733 0x10018c66 0xa0feaccd
+                                        0x90021d99>; //6 entries
                 };
 
                 thermocouple@20 {
-- 
2.34.1


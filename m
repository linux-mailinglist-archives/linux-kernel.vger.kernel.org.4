Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A806767276E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjARSpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjARSpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:45:04 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A85C2BF1E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:45:02 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id q8so13601177wmo.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utAAnWEqDvZ+nar543hXWyxMXHUCp5XsRyDad4J9M4E=;
        b=XFhCYx97n+HDJzxe+iB6DUXEtKjYXdmXc+tzD0D2nIypo0/UCbXRJdgme9+/TTKD9R
         Vf6B479K0ic1PkwUjbZbLptYwYGZbCXP0/sKU+Kr2WOY6nOO3qzhPkFkjDwWd+5jEKqA
         JqZFB/AV3Vkd5ryMlk6FcYrwJpy6PpLld9RmaZt/harSKRpcm/o3QcJTSJ/3MtiX12tg
         gnmyfjX284VUXZ83QVocg29BCHPoxWR2YStYuL8gMiqtuLqVIPSLfJSH+nkppKsMadHU
         15JnFaXigZ3/NpNkG1oHiUuHmsu2oSpQ68T+oOvLDezYJXDYCb2Z8Lb5dGPkTq3HbLBv
         M5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utAAnWEqDvZ+nar543hXWyxMXHUCp5XsRyDad4J9M4E=;
        b=pj3zCwp4e4qdxvSuYyGZ4V6am/eu+1w0gEEN76P5sUeXmrkTGaRLz1VAYyMRjpYPQ/
         OW6jIT+hxCxkGii8TOV4jIcMVNLppfym2ZRpy4lL7UULQdzN6/dJbCBd+c3Cj9nSxuf9
         gr88lHWu3O0UaXcUrOesv39FGK3wQjWphq+E/9/si/9O4OhZDloKSdmqTSzeeinOdtvB
         Ifm94z13vBGEmsiU0vi1a2urDFPx3XY7efgb24HBzMq2CofZX4c3kAHk+gOh7EoV5ePg
         xne19FHt6TURnJkRdAvGbieImua+hZuInzAkV46NmLqnyNoq5ZwUesHIaB8VKZ7gVX1q
         sOnw==
X-Gm-Message-State: AFqh2kqDggh05Hz/P1GILWqqRb0Ow5ciiQYvymeNq2vohvSDahiiqyce
        rm5rTbfwh0B8oR42Zn/JRpJvRg==
X-Google-Smtp-Source: AMrXdXskpaf/iWMxPZZaBogusBgNElDx3kRWdeVaaeERbwhpclpRtco1seaspTwqi52nXFm3FDeYmQ==
X-Received: by 2002:a05:600c:3b91:b0:3d3:5c9e:6b27 with SMTP id n17-20020a05600c3b9100b003d35c9e6b27mr3721339wms.12.1674067501025;
        Wed, 18 Jan 2023 10:45:01 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g1-20020a5d46c1000000b00241cfe6e286sm31640325wrs.98.2023.01.18.10.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 10:45:00 -0800 (PST)
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
Subject: [PATCH 4/5] dt-bindings: iio: use lowercase hex in examples
Date:   Wed, 18 Jan 2023 19:44:12 +0100
Message-Id: <20230118184413.395820-4-krzysztof.kozlowski@linaro.org>
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

Use lowercase hex in addresses in examples.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


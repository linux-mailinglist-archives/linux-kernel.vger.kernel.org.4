Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4412F692402
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjBJRHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjBJRHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:07:31 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981F371001;
        Fri, 10 Feb 2023 09:07:30 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so6756661wma.1;
        Fri, 10 Feb 2023 09:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQNrZmksDBpl4fmmiFb/Stn0EUPB7bOOM5pqSh2sIdg=;
        b=K9+H+FQocIzMfZNKuklGWbpmfIcSkcfMPgfV0R+lz+Xq5Zr/VzEMBzwPaDjn+RHItO
         mBO/P/eoJeGODqHez1//UwZE4iHERL7pojFNnX0oNpvD3dy7jvpwcNI9dzxggsJcrs8A
         oaMxACDl+TqxvKbWFhlcommwAr3468rgaqK7hT1jlsa3TUvtJCfGOqa5yUbyo7P9qCqc
         uaZBj4sq/UqtiwsStybxxUYVbJ3bprbmpeDz1e1NG+TbwC9poYsGRQQKHtqgNUMrOC2C
         f585SPkuIXTnIz7ybtmHNpEeKAg/4N12wZYS5jk0zSVQ88/hL4RTqjFV3RX+Te+skeTY
         xpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQNrZmksDBpl4fmmiFb/Stn0EUPB7bOOM5pqSh2sIdg=;
        b=dRaLGN17AEA26sLFqoBwaaRT62TnT4/dbMQRup0Pk2TorPKpCh6TeDGYILZrTohA+V
         8EORX8MaNhGkNt5yo7hyUqbTtUECHcj4ANgQUH2rr3QscKeR18IrABKmrid2Pq0KwQFf
         sG79tEXKVhy7uslAPAZBf0tLDM5WiKZfj0T6eY63JTT6RT9IL3jV4c9L8RV4BGF0gO/X
         /EsfmOBdbdqAUumGZ/BUvokQauoIlu+1mWUvT4liz8Nm6z76lbof8BuicBW4gAo84463
         to+L8//ZtezEbRhq5HpWbwUqGgaNak1tVnDPkDc6OfsK7Kr8XsNkTpZ0VifJtqFMjbsw
         iwDA==
X-Gm-Message-State: AO0yUKU+Dv6l22iORodAKs4K8vrJA3cz0zA0N5O0XBTYsl76qnq7Tsu8
        IEOLlujseIjofrhxZ4waY7k=
X-Google-Smtp-Source: AK7set8wwkdbVXURn6jECfIMn3SjAyn9dmGh59TJ91ZHx7A4gZB2kwBJkZGIHLfQu+3nOzwuBUzHGA==
X-Received: by 2002:a05:600c:308a:b0:3dc:43a0:83bb with SMTP id g10-20020a05600c308a00b003dc43a083bbmr13629846wmn.3.1676048849132;
        Fri, 10 Feb 2023 09:07:29 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x7-20020a05600c188700b003cffd3c3d6csm5351531wmp.12.2023.02.10.09.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 09:07:28 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Ferass El Hafidi <vitali64pmemail@protonmail.com>
Subject: [PATCH v2 1/3] arm64: dts: meson: gxbb-kii-pro: sort and tidy the dts
Date:   Fri, 10 Feb 2023 17:07:19 +0000
Message-Id: <20230210170721.1285914-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230210170721.1285914-1-christianshewitt@gmail.com>
References: <20230210170721.1285914-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alpha-sort the nodes, move the default line in the LED node to where it's
normally found, and remove excess spacing. No functional changes.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Ferass El Hafidi <vitali64pmemail@protonmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../boot/dts/amlogic/meson-gxbb-kii-pro.dts   | 32 ++++++++-----------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
index 6d8cc00fedc7..9bfdb54d912a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
@@ -6,21 +6,22 @@
 /dts-v1/;
 
 #include "meson-gxbb-p20x.dtsi"
-
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
+
 / {
 	compatible = "videostrong,kii-pro", "amlogic,meson-gxbb";
 	model = "Videostrong KII Pro";
 
 	leds {
 		compatible = "gpio-leds";
+
 		status {
 			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_LOW>;
-			default-state = "off";
 			color = <LED_COLOR_ID_RED>;
 			function = LED_FUNCTION_STATUS;
+			default-state = "off";
 		};
 	};
 
@@ -34,24 +35,8 @@ button-reset {
 			gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
 		};
 	};
-
-};
-
-
-
-&uart_A {
-	status = "okay";
-	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
-	pinctrl-names = "default";
-	uart-has-rtscts;
-
-	bluetooth {
-		compatible = "brcm,bcm4335a0";
-	};
 };
 
-
-
 &ethmac {
 	status = "okay";
 	pinctrl-0 = <&eth_rmii_pins>;
@@ -78,3 +63,14 @@ eth_phy0: ethernet-phy@0 {
 &ir {
 	linux,rc-map-name = "rc-videostrong-kii-pro";
 };
+
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "brcm,bcm4335a0";
+	};
+};
-- 
2.34.1


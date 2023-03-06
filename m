Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D880C6ABF3F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjCFMOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjCFMOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:14:01 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9481F4AD;
        Mon,  6 Mar 2023 04:13:59 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r18so8588550wrx.1;
        Mon, 06 Mar 2023 04:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678104838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S69/h6nKwoVosQbtsPPYLPT1mnoRPmUaC8JxTN48O5Q=;
        b=DPFaSKJjfeU1zf2om9bxbD7cBqxQ6G8EGkxbSzxKSMGVXcoC8DZEixc3dwPDsZByCB
         oQeODWeTL9XeRPWRkxx3wjYTRTvF7Fl9vNyzbDxDaMMWZAEwmJssRrcg6vaOlm8qjw5W
         Tq8OM9+4/A5Q6WZYQ3imY7+sgUkHJqj5XyKXBbK1zWTKbOzn6RXdJ0fCrmmD4scD11gd
         m5PDewhJlPD++EewWB20tS6BoUsnXXP81nA0N+avy42I7EFZL4hyuBxPNHYdFDtBQ/mp
         4v5xlpd6Hv98yNaBn4Gv6NmUc9VbQ37mla9y3Dmg9K9mg1AVSaN/LfusNDDLocO9VXrF
         ifvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678104838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S69/h6nKwoVosQbtsPPYLPT1mnoRPmUaC8JxTN48O5Q=;
        b=TKQ3cUAfv6fQ5zwU/k2jCKtoVv4mgKs9/OkskiL3hmpxROiEj3fTR14eC1nOiqI9Bf
         HwG8BOvlRFwF68IVvg/Z01iJHshRWQSyUaSj66hyn0l7avY85aU4suXmmw1Qg4+M2XJD
         rzAtZDuLWxpW//ys/hhb+Gh1MsmJmUX70YumxzlORbbtbPcxtn3V5NhNn82BP8oIz3iK
         blEoxzEkznj80L4tT5uOmDx+RthPYXFracFnzpaRiUFTxReW8NnLa43Fh0NBweWuE2PX
         ZXaOg1xfhax+yhoSyb8sjD4pCLrAGU68pz2p109PX/K66v51jScZP8IgAuc//rw5OC6U
         OquQ==
X-Gm-Message-State: AO0yUKUI/LuDmVahMGo85w6s8uPnokBn10d2X3psUTcJjhakcy4k8/hj
        6GSu5ZEPZGFitow0v+wNg9XhypdWJFOXTw==
X-Google-Smtp-Source: AK7set+daYgIxZAzibZ8FSFcP7EutPd2r+olIldnKo9OBJGohjyJIyT8qApZpNIRA4VTc/UgENsLbA==
X-Received: by 2002:adf:fad1:0:b0:2c6:e7f6:49af with SMTP id a17-20020adffad1000000b002c6e7f649afmr6334270wrs.27.1678104838442;
        Mon, 06 Mar 2023 04:13:58 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d660a000000b002c70ce264bfsm9814798wru.76.2023.03.06.04.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 04:13:58 -0800 (PST)
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
Subject: [PATCH v3 1/3] arm64: dts: meson: gxbb-kii-pro: sort and tidy the dts
Date:   Mon,  6 Mar 2023 12:13:49 +0000
Message-Id: <20230306121351.1606360-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306121351.1606360-1-christianshewitt@gmail.com>
References: <20230306121351.1606360-1-christianshewitt@gmail.com>
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
 .../boot/dts/amlogic/meson-gxbb-kii-pro.dts   | 31 ++++++++-----------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
index 5f2d4317ecfb..73ad0f5110f3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
@@ -6,10 +6,10 @@
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
@@ -18,9 +18,9 @@ leds {
 		compatible = "gpio-leds";
 		led {
 			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_LOW>;
-			default-state = "off";
 			color = <LED_COLOR_ID_RED>;
 			function = LED_FUNCTION_STATUS;
+			default-state = "off";
 		};
 	};
 
@@ -34,24 +34,8 @@ button-reset {
 			gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
 		};
 	};
-
 };
 
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
-};
-
-
-
 &ethmac {
 	status = "okay";
 	pinctrl-0 = <&eth_rmii_pins>;
@@ -78,3 +62,14 @@ eth_phy0: ethernet-phy@0 {
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


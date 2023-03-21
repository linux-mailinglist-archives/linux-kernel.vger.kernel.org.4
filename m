Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8126C37F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjCURNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjCURNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:13:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C902B9C7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:12:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x3so62457115edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1679418762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8YeJ+TdrXR6GASdOVRx8PnOQuXI3Ew9qQcS8RKH/78=;
        b=DnxpTmFgZBR0Rcv2oWHKp2RY4srhlT6dq6CWxiP1Rut/B5GjYwOAJugOuG+8zWjwv2
         WQM3YFL9e0p+Pkeyti2ijROfu4NlN9OoWhPYm9nLzbCO0pz7hghwNyNVu5Vl3sQ6IVh2
         mC0hoUHlAYJdYm53LUYrT6cjlzI7MEpNIuT1KKs6+KW95Te9h3M7+OWgnFqEK3hwlVWI
         MOtMaDVbOaeyg8AkegJgz0oFSqOzM+q0DW/3+eBb3wAn/2uofZPuJLDNGMbo0iKcqYzs
         hcwILSYgCWEGn3rSJH5JIGWoOqe/2svOQNC8/nIYCxr5uDLij3LN/eDE5mT56/7lquK2
         ws6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679418762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8YeJ+TdrXR6GASdOVRx8PnOQuXI3Ew9qQcS8RKH/78=;
        b=X/QQ9JeQw/2M5DO1U7uTwW4dEnojGZio6su1M/l8Kqj6fLVSlZJxaH+jwCVgeUj2yl
         SXKCY6etdHYZnMHQBjrG33YTNbN8itBbVpWuuL/nMIQxJ8gpBFRQmZtTKjElIg5jBvOO
         8NGvXhIz8HU5uW1JJea1uHb7TUGGD6UROvonS61p64dTLJwdxU3MO1Q+RnPf6MLPILGb
         qo9HmfiNoelZ/dF/Y26OZIixcNk4RUEoqnfZnQ5fpBAkY263Dj0zrSY6GeKk3ro++uDO
         XiFJ2oiYsGx/ylrwwd7PisCQQpojMIlpVl+KhH9hKBpqJ+8jNbUv9R/59piRS1QD9Y+d
         3eCw==
X-Gm-Message-State: AO0yUKXpaduA3dzjBucH6bj8ujzd3CR8iVgtgaO6facL8rV6Fm1urD4K
        1QC9H4fSp8QwLBoedIyk4OVJd7mXcAQ=
X-Google-Smtp-Source: AK7set/7cZpQR+LBs78M97gFWMBE6qyE8WRAHy1AkmsN4TheLHOLdLP7X2RpIzKmkUUIsVIPbW7lcA==
X-Received: by 2002:a05:6402:114d:b0:4fe:9374:30d0 with SMTP id g13-20020a056402114d00b004fe937430d0mr3471011edw.39.1679418761776;
        Tue, 21 Mar 2023 10:12:41 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-bc57-1c00-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:bc57:1c00::e63])
        by smtp.googlemail.com with ESMTPSA id c14-20020a509f8e000000b005003fd12eafsm6474959edf.63.2023.03.21.10.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 10:12:41 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        neil.armstrong@linaro.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 3/3] ARM: dts: meson8m2: mxiii-plus: Enable Bluetooth and WiFi support
Date:   Tue, 21 Mar 2023 18:12:13 +0100
Message-Id: <20230321171213.2808460-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230321171213.2808460-1-martin.blumenstingl@googlemail.com>
References: <20230321171213.2808460-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MXIII Plus uses an Ampak AP6330 Bluetooth and WiFi combo chip.
Bluetooth is connected to &uart_A and requires toggling GPIOX_20.
WiFi can be routed to either &sdhc or &sdio. Route WiFi to &sdhc
since  &sdio is already connected to the SD card. Additionally WiFi
requires toggling GPIOX_11 and GPIOAO_6 as well as enabling the 32kHz
clock signal.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts | 48 ++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
index fa6d55f1cfb9..aa4d4bf70629 100644
--- a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
+++ b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
@@ -19,7 +19,6 @@ aliases {
 		ethernet0 = &ethmac;
 		i2c0 = &i2c_AO;
 		serial0 = &uart_AO;
-		serial1 = &uart_A;
 		mmc0 = &sd_card_slot;
 	};
 
@@ -45,12 +44,32 @@ button-function {
 		};
 	};
 
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+
+		pinctrl-0 = <&xtal_32k_out_pins>;
+		pinctrl-names = "default";
+
+		reset-gpios = <&gpio GPIOX_11 GPIO_ACTIVE_LOW>,
+			      <&gpio_ao GPIOAO_6 GPIO_ACTIVE_LOW>;
+
+		clocks = <&xtal_32k_out>;
+		clock-names = "ext_clock";
+	};
+
 	vcc_3v3: regulator-vcc3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC3V3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	xtal_32k_out: xtal-32k-out-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "xtal_32k_out";
+	};
 };
 
 &cpu0 {
@@ -192,6 +211,27 @@ &saradc {
 	vref-supply = <&vddio_ao1v8>;
 };
 
+/* SDIO wifi */
+&sdhc {
+	status = "okay";
+
+	pinctrl-0 = <&sdxc_a_pins>;
+	pinctrl-names = "default";
+
+	bus-width = <4>;
+	max-frequency = <50000000>;
+
+	disable-wp;
+	non-removable;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+
+	mmc-pwrseq = <&sdio_pwrseq>;
+
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_3v3>;
+};
+
 &sdio {
 	status = "okay";
 
@@ -222,6 +262,12 @@ &uart_A {
 	pinctrl-0 = <&uart_a1_pins>, <&uart_a1_cts_rts_pins>;
 	pinctrl-names = "default";
 	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "brcm,bcm20702a1";
+		shutdown-gpios = <&gpio GPIOX_20 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+	};
 };
 
 &uart_AO {
-- 
2.40.0


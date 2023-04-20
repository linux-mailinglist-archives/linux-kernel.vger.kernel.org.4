Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5496E8BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjDTHvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbjDTHvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:51:32 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E525263
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:51:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-504e232fe47so707772a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681977064; x=1684569064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ui4CiEdH8+1c5lAmjZouFBzB+305H/4kKjSIDIYwmvc=;
        b=y6cpUUqpF98WtdmlzfFHSrrAbUeiAtm3S9mixQcE/07aPeEj9WnhRJXI1vGI1CUXaK
         I3dOlBxahzEnulELVGOom96i49JfpBkcB5EhXJhhDb24IIUe0W47q8yRA0mmlyY9uxKD
         tPM6oBLk8x4/ojA5px3LFnnhJyysFvGoA0fh5Lw824locf4+ZaOQAmMCCujiZtCroSy+
         Zy214otaArWg8TPvJHVdB9WVIDpF4t1YUupcAb+BdajPHB2k0mwu6tFzAdkse11zOSvI
         OqstwTHqkKaQr2p+hohOR3jDkkBFuTfW+R8CAbT742cmzvs0FF+0Ut9014//OOORbrLU
         XkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681977064; x=1684569064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ui4CiEdH8+1c5lAmjZouFBzB+305H/4kKjSIDIYwmvc=;
        b=EEUpFKeRwIIlxADMwb0cO6cY+FRd6oQeqGrVWLQeihChLVQZrgBpCxoqqjl6vutEO+
         UXA7SzXDKfdMkmc1shD8WVX+nMwiuqrvCSvHbRZBprtu6oDLVK/sS5VQ7PEYXyZDNgN/
         Jw1ckStuASpdu0oM+BLK/DVgnBmb4/IWqzrkXGtDXZIT44cnXmqZ8tsmDryLfzgKN1Ia
         /NJRSKBD69XmHPyiltQMobNOwTOgNzIVi+zQMZUbKKleJN2jedkUQicCSxTi4YDLWcFQ
         TZWqczQriJRAuRutGe2tcUOYg5+P7jwytD/kFiBXk5na9vjWVePEydaAdH2+nYVvsuPg
         aG/w==
X-Gm-Message-State: AAQBX9dShfxclfl8roe5pBKeU+Uo5/goFzzlJdtLi1qwrgnm20woitQv
        DfcGqS1JxQDi3hTFAqU+xYkgYg==
X-Google-Smtp-Source: AKy350bZVTqNgxXSb0xxlV0PZAtjjQUzGv7eUjD7Rdx0ZeZtO0V1dzjG3AwsbVA+LCxNER0nsrAFTw==
X-Received: by 2002:a05:6402:12d2:b0:506:9805:7b56 with SMTP id k18-20020a05640212d200b0050698057b56mr880238edx.32.1681977064607;
        Thu, 20 Apr 2023 00:51:04 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id h25-20020a50ed99000000b00505060e4280sm447165edr.94.2023.04.20.00.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:51:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 08/10] ARM: dts: qcom: apq8060-dragonboard: move regulators out of simple-bus
Date:   Thu, 20 Apr 2023 09:50:51 +0200
Message-Id: <20230420075053.41976-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
References: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulators is not a bus, so drop incomplete simple-bus usage to fix dtbs
W=1 warnings:

  Warning (simple_bus_reg): /regulators/regulator-fixed: missing or empty reg/ranges property
  Warning (simple_bus_reg): /regulators/xc622a331mrg: missing or empty reg/ranges property
  Warning (simple_bus_reg): /regulators/nds332p: missing or empty reg/ranges property
  Warning (simple_bus_reg): /regulators/txb0104rgyr: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../arm/boot/dts/qcom-apq8060-dragonboard.dts | 80 +++++++++----------
 1 file changed, 38 insertions(+), 42 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
index 8e4b61e4d4b1..e830cb2395aa 100644
--- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -18,50 +18,46 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	regulators {
-		compatible = "simple-bus";
-
-		/* Main power of the board: 3.7V */
-		vph: regulator-fixed {
-			compatible = "regulator-fixed";
-			regulator-min-microvolt = <3700000>;
-			regulator-max-microvolt = <3700000>;
-			regulator-name = "VPH";
-			regulator-type = "voltage";
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		/* GPIO controlled ethernet power regulator */
-		dragon_veth: xc622a331mrg {
-			compatible = "regulator-fixed";
-			regulator-name = "XC6222A331MR-G";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			vin-supply = <&vph>;
-			gpio = <&pm8058_gpio 40 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-			pinctrl-names = "default";
-			pinctrl-0 = <&dragon_veth_gpios>;
-			regulator-always-on;
-		};
+	/* Main power of the board: 3.7V */
+	vph: regulator-fixed {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+		regulator-name = "VPH";
+		regulator-type = "voltage";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/* GPIO controlled ethernet power regulator */
+	dragon_veth: xc622a331mrg {
+		compatible = "regulator-fixed";
+		regulator-name = "XC6222A331MR-G";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vph>;
+		gpio = <&pm8058_gpio 40 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&dragon_veth_gpios>;
+		regulator-always-on;
+	};
 
-		/* VDDvario fixed regulator */
-		dragon_vario: nds332p {
-			compatible = "regulator-fixed";
-			regulator-name = "NDS332P";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			vin-supply = <&pm8058_s3>;
-		};
+	/* VDDvario fixed regulator */
+	dragon_vario: nds332p {
+		compatible = "regulator-fixed";
+		regulator-name = "NDS332P";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&pm8058_s3>;
+	};
 
-		/* This is a levelshifter for SDCC5 */
-		dragon_vio_txb: txb0104rgyr {
-			compatible = "regulator-fixed";
-			regulator-name = "Dragon SDCC levelshifter";
-			vin-supply = <&pm8058_l14>;
-			regulator-always-on;
-		};
+	/* This is a levelshifter for SDCC5 */
+	dragon_vio_txb: txb0104rgyr {
+		compatible = "regulator-fixed";
+		regulator-name = "Dragon SDCC levelshifter";
+		vin-supply = <&pm8058_l14>;
+		regulator-always-on;
 	};
 
 	/*
-- 
2.34.1


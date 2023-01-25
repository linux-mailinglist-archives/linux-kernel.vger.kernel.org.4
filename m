Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A2167AEB6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbjAYJqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjAYJqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:46:07 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA150130
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:45:41 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so816253wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2fHWE2s2rn66moGOFtmLl9XkrN2CcBnplnUXuTtr9E=;
        b=NRRoUYOgxgTV/hY0Wiv+kxL0j0tTLVEu5daY8I2Vk/tzPQDaWsHKLcaaiKAs4bPXUJ
         6hxTkb1lgH5Bari5icNnK9HaqgUzKZJhu9BcREog0exD12/PF20OU00N7EMv6QB43mbO
         pAXUZs8E2BVjEmkC+vHQLjBMnZ/6FUTectvP8rDW5E+Ti8/b28GYTxemhXBytX46ME0X
         2rer26enHyknKh9LQeNnP56JE4PgNTXO7sTXQi/KZnYkSFx9iCj8cVhrYfX0syiRco1W
         VR8z6dl9ed4wlgcFQLPc0FKG3RpfBHIcANOwBnSPFc/0qxT3aAz6Gyc97q/rTV1U1rdy
         pcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2fHWE2s2rn66moGOFtmLl9XkrN2CcBnplnUXuTtr9E=;
        b=wUpxWxC+rU+G/ivvZNE4iWnYcSzQsuGwbDR8vH9HWfmlVJ4J00e76CGjMbGOt8F650
         1V5AOMiEbNss6a6SN3tQzZpmNGkq00isLBpPwocAr4GOH7NlYG+VsA3D7PzVwetZKlVO
         6vThbHeJJfgi/jrFM3DL65I11bXyVzwbbQKq0gqzo5lICDacEEzu1wVXWHjD4Mdm5igU
         LFaB7YEUjt/u1PUCQr5WRIKFGEOakF1icL45j0B1NEwb3Tok7qDxmr+ir+imaS1h0T7b
         Q8xd6Ris1N+j1R4Q4mKjIkVpE6MuhimviWOsMh5UZV9AoWbT0vhAbkvY/sC+ZmHCnptV
         AE2Q==
X-Gm-Message-State: AFqh2kpMEooIjhUJJw4ut8VZPNEsf/MZOVpcxgtz7C95XqeTLjcKT+sQ
        +d/UmO3oaGQqHdgsYD/dKtzL1w==
X-Google-Smtp-Source: AMrXdXvZUq3drT2QPzr/SLF2iItE1bHcK4PRrE1fVzjbwftaRuPW2CVup/zA4f171tHNe6Tmt4tHpA==
X-Received: by 2002:a1c:ed0a:0:b0:3d3:4a47:52e9 with SMTP id l10-20020a1ced0a000000b003d34a4752e9mr30789597wmh.15.1674639931871;
        Wed, 25 Jan 2023 01:45:31 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id fl22-20020a05600c0b9600b003d1e3b1624dsm1419238wmb.2.2023.01.25.01.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 01:45:31 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 7/9] ARM: dts: exynos: use lowercase hex addresses
Date:   Wed, 25 Jan 2023 10:45:11 +0100
Message-Id: <20230125094513.155063-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125094513.155063-1-krzysztof.kozlowski@linaro.org>
References: <20230125094513.155063-1-krzysztof.kozlowski@linaro.org>
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

By convention the hex addresses should be lowercase.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos-syscon-restart.dtsi  |  2 +-
 arch/arm/boot/dts/exynos3250-monk.dts         |  2 +-
 arch/arm/boot/dts/exynos3250-rinato.dts       |  2 +-
 arch/arm/boot/dts/exynos3250.dtsi             | 30 ++++----
 arch/arm/boot/dts/exynos4.dtsi                | 58 +++++++--------
 arch/arm/boot/dts/exynos4210.dtsi             |  4 +-
 .../boot/dts/exynos4412-itop-scp-core.dtsi    |  2 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi       |  2 +-
 .../boot/dts/exynos4412-odroid-common.dtsi    |  2 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts     |  2 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts      |  2 +-
 arch/arm/boot/dts/exynos4412-odroidx2.dts     |  2 +-
 arch/arm/boot/dts/exynos4412-origen.dts       |  2 +-
 arch/arm/boot/dts/exynos4412-p4note.dtsi      |  4 +-
 arch/arm/boot/dts/exynos4412.dtsi             | 28 ++++----
 arch/arm/boot/dts/exynos5.dtsi                | 22 +++---
 arch/arm/boot/dts/exynos5250.dtsi             | 70 +++++++++----------
 arch/arm/boot/dts/exynos5260.dtsi             | 36 +++++-----
 arch/arm/boot/dts/exynos5410.dtsi             |  2 +-
 arch/arm/boot/dts/exynos5420.dtsi             | 66 ++++++++---------
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  2 +-
 21 files changed, 171 insertions(+), 171 deletions(-)

diff --git a/arch/arm/boot/dts/exynos-syscon-restart.dtsi b/arch/arm/boot/dts/exynos-syscon-restart.dtsi
index ecf416690a15..bc9a78f6d4b7 100644
--- a/arch/arm/boot/dts/exynos-syscon-restart.dtsi
+++ b/arch/arm/boot/dts/exynos-syscon-restart.dtsi
@@ -7,7 +7,7 @@ &pmu_system_controller {
 	poweroff: syscon-poweroff {
 		compatible = "syscon-poweroff";
 		regmap = <&pmu_system_controller>;
-		offset = <0x330C>; /* PS_HOLD_CONTROL */
+		offset = <0x330c>; /* PS_HOLD_CONTROL */
 		mask = <0x5200>; /* reset value */
 	};
 
diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index c8eacf1b5d0b..80d90fe7fad1 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -31,7 +31,7 @@ memory@40000000 {
 
 	firmware@205f000 {
 		compatible = "samsung,secure-firmware";
-		reg = <0x0205F000 0x1000>;
+		reg = <0x0205f000 0x1000>;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 812816af8476..1f9cba0607e1 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -36,7 +36,7 @@ memory@40000000 {
 
 	firmware@205f000 {
 		compatible = "samsung,secure-firmware";
-		reg = <0x0205F000 0x1000>;
+		reg = <0x0205f000 0x1000>;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index b91a66cda0a5..28bb2ce8ccf7 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -364,35 +364,35 @@ mipi_phy: video-phy {
 
 		pd_cam: power-domain@10023c00 {
 			compatible = "samsung,exynos4210-pd";
-			reg = <0x10023C00 0x20>;
+			reg = <0x10023c00 0x20>;
 			#power-domain-cells = <0>;
 			label = "CAM";
 		};
 
 		pd_mfc: power-domain@10023c40 {
 			compatible = "samsung,exynos4210-pd";
-			reg = <0x10023C40 0x20>;
+			reg = <0x10023c40 0x20>;
 			#power-domain-cells = <0>;
 			label = "MFC";
 		};
 
 		pd_g3d: power-domain@10023c60 {
 			compatible = "samsung,exynos4210-pd";
-			reg = <0x10023C60 0x20>;
+			reg = <0x10023c60 0x20>;
 			#power-domain-cells = <0>;
 			label = "G3D";
 		};
 
 		pd_lcd0: power-domain@10023c80 {
 			compatible = "samsung,exynos4210-pd";
-			reg = <0x10023C80 0x20>;
+			reg = <0x10023c80 0x20>;
 			#power-domain-cells = <0>;
 			label = "LCD0";
 		};
 
 		pd_isp: power-domain@10023ca0 {
 			compatible = "samsung,exynos4210-pd";
-			reg = <0x10023CA0 0x20>;
+			reg = <0x10023ca0 0x20>;
 			#power-domain-cells = <0>;
 			label = "ISP";
 		};
@@ -409,7 +409,7 @@ cmu: clock-controller@10030000 {
 
 		cmu_dmc: clock-controller@105c0000 {
 			compatible = "samsung,exynos3250-cmu-dmc";
-			reg = <0x105C0000 0x2000>;
+			reg = <0x105c0000 0x2000>;
 			#clock-cells = <1>;
 		};
 
@@ -424,7 +424,7 @@ rtc: rtc@10070000 {
 
 		tmu: tmu@100c0000 {
 			compatible = "samsung,exynos3250-tmu";
-			reg = <0x100C0000 0x100>;
+			reg = <0x100c0000 0x100>;
 			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_TMU_APBIF>;
 			clock-names = "tmu_apbif";
@@ -518,7 +518,7 @@ fimd: fimd@11c00000 {
 
 		dsi_0: dsi@11c80000 {
 			compatible = "samsung,exynos3250-mipi-dsi";
-			reg = <0x11C80000 0x10000>;
+			reg = <0x11c80000 0x10000>;
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			samsung,phy-type = <0>;
 			power-domains = <&pd_lcd0>;
@@ -590,7 +590,7 @@ mshc_2: mmc@12530000 {
 
 		exynos_usbphy: usb-phy@125b0000 {
 			compatible = "samsung,exynos3250-usb2-phy";
-			reg = <0x125B0000 0x100>;
+			reg = <0x125b0000 0x100>;
 			samsung,pmureg-phandle = <&pmu_system_controller>;
 			clocks = <&cmu CLK_USBOTG>, <&cmu CLK_SCLK_UPLL>;
 			clock-names = "phy", "ref";
@@ -618,7 +618,7 @@ pdma1: dma-controller@12690000 {
 
 		adc: adc@126c0000 {
 			compatible = "samsung,exynos3250-adc";
-			reg = <0x126C0000 0x100>;
+			reg = <0x126c0000 0x100>;
 			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "adc", "sclk";
 			clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
@@ -769,7 +769,7 @@ i2c_4: i2c@138a0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
-			reg = <0x138A0000 0x100>;
+			reg = <0x138a0000 0x100>;
 			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C4>;
 			clock-names = "i2c";
@@ -782,7 +782,7 @@ i2c_5: i2c@138b0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
-			reg = <0x138B0000 0x100>;
+			reg = <0x138b0000 0x100>;
 			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C5>;
 			clock-names = "i2c";
@@ -795,7 +795,7 @@ i2c_6: i2c@138c0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
-			reg = <0x138C0000 0x100>;
+			reg = <0x138c0000 0x100>;
 			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C6>;
 			clock-names = "i2c";
@@ -808,7 +808,7 @@ i2c_7: i2c@138d0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
-			reg = <0x138D0000 0x100>;
+			reg = <0x138d0000 0x100>;
 			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C7>;
 			clock-names = "i2c";
@@ -864,7 +864,7 @@ i2s2: i2s@13970000 {
 
 		pwm: pwm@139d0000 {
 			compatible = "samsung,exynos4210-pwm";
-			reg = <0x139D0000 0x1000>;
+			reg = <0x139d0000 0x1000>;
 			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index a421f11b3a57..44dcb1377475 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -65,7 +65,7 @@ soc: soc {
 
 		clock_audss: clock-controller@3810000 {
 			compatible = "samsung,exynos4210-audss-clock";
-			reg = <0x03810000 0x0C>;
+			reg = <0x03810000 0x0c>;
 			#clock-cells = <1>;
 			clocks = <&clock CLK_FIN_PLL>, <&clock CLK_FOUT_EPLL>,
 				 <&clock CLK_SCLK_AUDIO0>,
@@ -113,28 +113,28 @@ mipi_phy: video-phy {
 
 		pd_mfc: power-domain@10023c40 {
 			compatible = "samsung,exynos4210-pd";
-			reg = <0x10023C40 0x20>;
+			reg = <0x10023c40 0x20>;
 			#power-domain-cells = <0>;
 			label = "MFC";
 		};
 
 		pd_g3d: power-domain@10023c60 {
 			compatible = "samsung,exynos4210-pd";
-			reg = <0x10023C60 0x20>;
+			reg = <0x10023c60 0x20>;
 			#power-domain-cells = <0>;
 			label = "G3D";
 		};
 
 		pd_lcd0: power-domain@10023c80 {
 			compatible = "samsung,exynos4210-pd";
-			reg = <0x10023C80 0x20>;
+			reg = <0x10023c80 0x20>;
 			#power-domain-cells = <0>;
 			label = "LCD0";
 		};
 
 		pd_tv: power-domain@10023c20 {
 			compatible = "samsung,exynos4210-pd";
-			reg = <0x10023C20 0x20>;
+			reg = <0x10023c20 0x20>;
 			#power-domain-cells = <0>;
 			power-domains = <&pd_lcd0>;
 			label = "TV";
@@ -142,21 +142,21 @@ pd_tv: power-domain@10023c20 {
 
 		pd_cam: power-domain@10023c00 {
 			compatible = "samsung,exynos4210-pd";
-			reg = <0x10023C00 0x20>;
+			reg = <0x10023c00 0x20>;
 			#power-domain-cells = <0>;
 			label = "CAM";
 		};
 
 		pd_gps: power-domain@10023ce0 {
 			compatible = "samsung,exynos4210-pd";
-			reg = <0x10023CE0 0x20>;
+			reg = <0x10023ce0 0x20>;
 			#power-domain-cells = <0>;
 			label = "GPS";
 		};
 
 		pd_gps_alive: power-domain@10023d00 {
 			compatible = "samsung,exynos4210-pd";
-			reg = <0x10023D00 0x20>;
+			reg = <0x10023d00 0x20>;
 			#power-domain-cells = <0>;
 			label = "GPS alive";
 		};
@@ -190,7 +190,7 @@ pmu_system_controller: system-controller@10020000 {
 
 		dsi_0: dsi@11c80000 {
 			compatible = "samsung,exynos4210-mipi-dsi";
-			reg = <0x11C80000 0x10000>;
+			reg = <0x11c80000 0x10000>;
 			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&pd_lcd0>;
 			phys = <&mipi_phy 1>;
@@ -309,7 +309,7 @@ rtc: rtc@10070000 {
 
 		keypad: keypad@100a0000 {
 			compatible = "samsung,s5pv210-keypad";
-			reg = <0x100A0000 0x100>;
+			reg = <0x100a0000 0x100>;
 			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_KEYIF>;
 			clock-names = "keypad";
@@ -354,7 +354,7 @@ sdhci_3: mmc@12540000 {
 
 		exynos_usbphy: usb-phy@125b0000 {
 			compatible = "samsung,exynos4210-usb2-phy";
-			reg = <0x125B0000 0x100>;
+			reg = <0x125b0000 0x100>;
 			samsung,pmureg-phandle = <&pmu_system_controller>;
 			clocks = <&clock CLK_USB_DEVICE>, <&clock CLK_XUSBXTI>;
 			clock-names = "phy", "ref";
@@ -546,7 +546,7 @@ i2c_4: i2c@138a0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
-			reg = <0x138A0000 0x100>;
+			reg = <0x138a0000 0x100>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_I2C4>;
 			clock-names = "i2c";
@@ -559,7 +559,7 @@ i2c_5: i2c@138b0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
-			reg = <0x138B0000 0x100>;
+			reg = <0x138b0000 0x100>;
 			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_I2C5>;
 			clock-names = "i2c";
@@ -572,7 +572,7 @@ i2c_6: i2c@138c0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
-			reg = <0x138C0000 0x100>;
+			reg = <0x138c0000 0x100>;
 			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_I2C6>;
 			clock-names = "i2c";
@@ -585,7 +585,7 @@ i2c_7: i2c@138d0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
-			reg = <0x138D0000 0x100>;
+			reg = <0x138d0000 0x100>;
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_I2C7>;
 			clock-names = "i2c";
@@ -598,7 +598,7 @@ i2c_8: i2c@138e0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-hdmiphy-i2c";
-			reg = <0x138E0000 0x100>;
+			reg = <0x138e0000 0x100>;
 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_I2C_HDMI>;
 			clock-names = "i2c";
@@ -657,7 +657,7 @@ spi_2: spi@13940000 {
 
 		pwm: pwm@139d0000 {
 			compatible = "samsung,exynos4210-pwm";
-			reg = <0x139D0000 0x1000>;
+			reg = <0x139d0000 0x1000>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
@@ -712,7 +712,7 @@ fimd: fimd@11c00000 {
 
 		tmu: tmu@100c0000 {
 			interrupt-parent = <&combiner>;
-			reg = <0x100C0000 0x100>;
+			reg = <0x100c0000 0x100>;
 			interrupts = <2 4>;
 			status = "disabled";
 			#thermal-sensor-cells = <0>;
@@ -739,7 +739,7 @@ rotator: rotator@12810000 {
 
 		hdmi: hdmi@12d00000 {
 			compatible = "samsung,exynos4210-hdmi";
-			reg = <0x12D00000 0x70000>;
+			reg = <0x12d00000 0x70000>;
 			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "hdmi", "sclk_hdmi", "sclk_pixel",
 				      "sclk_hdmiphy", "mout_hdmi";
@@ -756,7 +756,7 @@ hdmi: hdmi@12d00000 {
 
 		hdmicec: cec@100b0000 {
 			compatible = "samsung,s5p-cec";
-			reg = <0x100B0000 0x200>;
+			reg = <0x100b0000 0x200>;
 			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_HDMI_CEC>;
 			clock-names = "hdmicec";
@@ -770,7 +770,7 @@ hdmicec: cec@100b0000 {
 		mixer: mixer@12c10000 {
 			compatible = "samsung,exynos4210-mixer";
 			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
-			reg = <0x12C10000 0x2100>, <0x12c00000 0x300>;
+			reg = <0x12c10000 0x2100>, <0x12c00000 0x300>;
 			power-domains = <&pd_tv>;
 			iommus = <&sysmmu_tv>;
 			status = "disabled";
@@ -902,7 +902,7 @@ sysmmu_mfc_r: sysmmu@13630000 {
 
 		sysmmu_tv: sysmmu@12e20000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x12E20000 0x1000>;
+			reg = <0x12e20000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <5 4>;
 			clock-names = "sysmmu", "master";
@@ -913,7 +913,7 @@ sysmmu_tv: sysmmu@12e20000 {
 
 		sysmmu_fimc0: sysmmu@11a20000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x11A20000 0x1000>;
+			reg = <0x11a20000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <4 2>;
 			clock-names = "sysmmu", "master";
@@ -924,7 +924,7 @@ sysmmu_fimc0: sysmmu@11a20000 {
 
 		sysmmu_fimc1: sysmmu@11a30000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x11A30000 0x1000>;
+			reg = <0x11a30000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <4 3>;
 			clock-names = "sysmmu", "master";
@@ -935,7 +935,7 @@ sysmmu_fimc1: sysmmu@11a30000 {
 
 		sysmmu_fimc2: sysmmu@11a40000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x11A40000 0x1000>;
+			reg = <0x11a40000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <4 4>;
 			clock-names = "sysmmu", "master";
@@ -946,7 +946,7 @@ sysmmu_fimc2: sysmmu@11a40000 {
 
 		sysmmu_fimc3: sysmmu@11a50000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x11A50000 0x1000>;
+			reg = <0x11a50000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <4 5>;
 			clock-names = "sysmmu", "master";
@@ -957,7 +957,7 @@ sysmmu_fimc3: sysmmu@11a50000 {
 
 		sysmmu_jpeg: sysmmu@11a60000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x11A60000 0x1000>;
+			reg = <0x11a60000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <4 6>;
 			clock-names = "sysmmu", "master";
@@ -968,7 +968,7 @@ sysmmu_jpeg: sysmmu@11a60000 {
 
 		sysmmu_rotator: sysmmu@12a30000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x12A30000 0x1000>;
+			reg = <0x12a30000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <5 0>;
 			clock-names = "sysmmu", "master";
@@ -979,7 +979,7 @@ sysmmu_rotator: sysmmu@12a30000 {
 
 		sysmmu_fimd0: sysmmu@11e20000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x11E20000 0x1000>;
+			reg = <0x11e20000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <5 2>;
 			clock-names = "sysmmu", "master";
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 1b4e55822e7c..5a1ec714c612 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -264,7 +264,7 @@ smp-sram@1f000 {
 
 		pd_lcd1: power-domain@10023ca0 {
 			compatible = "samsung,exynos4210-pd";
-			reg = <0x10023CA0 0x20>;
+			reg = <0x10023ca0 0x20>;
 			#power-domain-cells = <0>;
 			label = "LCD1";
 		};
@@ -356,7 +356,7 @@ ppmu_lcd1: ppmu@12240000 {
 
 		sysmmu_g2d: sysmmu@12a20000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x12A20000 0x1000>;
+			reg = <0x12a20000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <4 7>;
 			clock-names = "sysmmu", "master";
diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
index a67cb61e3cbb..e42e39dc0e40 100644
--- a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
+++ b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
@@ -25,7 +25,7 @@ memory@40000000 {
 
 	firmware@203f000 {
 		compatible = "samsung,secure-firmware";
-		reg = <0x0203F000 0x1000>;
+		reg = <0x0203f000 0x1000>;
 	};
 
 	fixed-rate-clocks {
diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index a626d33d1330..d5074fa57142 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -33,7 +33,7 @@ chosen {
 
 	firmware@204f000 {
 		compatible = "samsung,secure-firmware";
-		reg = <0x0204F000 0x1000>;
+		reg = <0x0204f000 0x1000>;
 	};
 
 	fixed-rate-clocks {
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index e7669b9e9edb..7c2780d3e37c 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -19,7 +19,7 @@ chosen {
 
 	firmware@204f000 {
 		compatible = "samsung,secure-firmware";
-		reg = <0x0204F000 0x1000>;
+		reg = <0x0204f000 0x1000>;
 	};
 
 	gpio_keys: gpio-keys {
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index a5ad88b897ff..42812da1f882 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -23,7 +23,7 @@ aliases {
 
 	memory@40000000 {
 		device_type = "memory";
-		reg = <0x40000000 0x7FF00000>;
+		reg = <0x40000000 0x7ff00000>;
 	};
 
 	vbus_otg_reg: regulator-1 {
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 68d589e081bc..d5316cf2fbb6 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -22,7 +22,7 @@ aliases {
 
 	memory@40000000 {
 		device_type = "memory";
-		reg = <0x40000000 0x3FF00000>;
+		reg = <0x40000000 0x3ff00000>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/exynos4412-odroidx2.dts b/arch/arm/boot/dts/exynos4412-odroidx2.dts
index f4b68c75c962..7be4cbdc4413 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx2.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx2.dts
@@ -17,6 +17,6 @@ / {
 
 	memory@40000000 {
 		device_type = "memory";
-		reg = <0x40000000 0x7FF00000>;
+		reg = <0x40000000 0x7ff00000>;
 	};
 };
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index a3905e27b9cd..ea9fd284386d 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -31,7 +31,7 @@ chosen {
 
 	firmware@203f000 {
 		compatible = "samsung,secure-firmware";
-		reg = <0x0203F000 0x1000>;
+		reg = <0x0203f000 0x1000>;
 	};
 
 	mmc_reg: regulator-0 {
diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/exynos4412-p4note.dtsi
index 201c38edd48f..3e05a49f29ff 100644
--- a/arch/arm/boot/dts/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/exynos4412-p4note.dtsi
@@ -32,7 +32,7 @@ chosen {
 
 	firmware@204f000 {
 		compatible = "samsung,secure-firmware";
-		reg = <0x0204F000 0x1000>;
+		reg = <0x0204f000 0x1000>;
 	};
 
 	fixed-rate-clocks {
@@ -198,7 +198,7 @@ adc@41 {
 			stmpe_adc {
 				compatible = "st,stmpe-adc";
 				#io-channel-cells = <1>;
-				st,norequest-mask = <0x2F>;
+				st,norequest-mask = <0x2f>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index f34c7400475b..11f9dd94b6b3 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -183,7 +183,7 @@ core3 {
 		cpu0: cpu@a00 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
-			reg = <0xA00>;
+			reg = <0xa00>;
 			clocks = <&clock CLK_ARM_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
@@ -193,7 +193,7 @@ cpu0: cpu@a00 {
 		cpu1: cpu@a01 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
-			reg = <0xA01>;
+			reg = <0xa01>;
 			clocks = <&clock CLK_ARM_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
@@ -203,7 +203,7 @@ cpu1: cpu@a01 {
 		cpu2: cpu@a02 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
-			reg = <0xA02>;
+			reg = <0xa02>;
 			clocks = <&clock CLK_ARM_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
@@ -213,7 +213,7 @@ cpu2: cpu@a02 {
 		cpu3: cpu@a03 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
-			reg = <0xA03>;
+			reg = <0xa03>;
 			clocks = <&clock CLK_ARM_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
@@ -376,7 +376,7 @@ pinctrl_2: pinctrl@3860000 {
 
 		pinctrl_3: pinctrl@106e0000 {
 			compatible = "samsung,exynos4x12-pinctrl";
-			reg = <0x106E0000 0x1000>;
+			reg = <0x106e0000 0x1000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
@@ -400,7 +400,7 @@ smp-sram@2f000 {
 
 		pd_isp: power-domain@10023ca0 {
 			compatible = "samsung,exynos4210-pd";
-			reg = <0x10023CA0 0x20>;
+			reg = <0x10023ca0 0x20>;
 			#power-domain-cells = <0>;
 			label = "ISP";
 		};
@@ -460,7 +460,7 @@ watchdog: watchdog@10060000 {
 
 		adc: adc@126c0000 {
 			compatible = "samsung,exynos4212-adc";
-			reg = <0x126C0000 0x100>;
+			reg = <0x126c0000 0x100>;
 			interrupt-parent = <&combiner>;
 			interrupts = <10 3>;
 			clocks = <&clock CLK_TSADC>;
@@ -493,7 +493,7 @@ mshc_0: mmc@12550000 {
 
 		sysmmu_g2d: sysmmu@10a40000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x10A40000 0x1000>;
+			reg = <0x10a40000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <4 7>;
 			clock-names = "sysmmu", "master";
@@ -525,7 +525,7 @@ sysmmu_fimc_drc: sysmmu@12270000 {
 
 		sysmmu_fimc_fd: sysmmu@122a0000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x122A0000 0x1000>;
+			reg = <0x122a0000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <16 4>;
 			power-domains = <&pd_isp>;
@@ -536,7 +536,7 @@ sysmmu_fimc_fd: sysmmu@122a0000 {
 
 		sysmmu_fimc_mcuctl: sysmmu@122b0000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x122B0000 0x1000>;
+			reg = <0x122b0000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <16 5>;
 			power-domains = <&pd_isp>;
@@ -547,7 +547,7 @@ sysmmu_fimc_mcuctl: sysmmu@122b0000 {
 
 		sysmmu_fimc_lite0: sysmmu@123b0000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x123B0000 0x1000>;
+			reg = <0x123b0000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <16 0>;
 			power-domains = <&pd_isp>;
@@ -559,7 +559,7 @@ sysmmu_fimc_lite0: sysmmu@123b0000 {
 
 		sysmmu_fimc_lite1: sysmmu@123c0000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x123C0000 0x1000>;
+			reg = <0x123c0000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <16 1>;
 			power-domains = <&pd_isp>;
@@ -614,7 +614,7 @@ fimc_lite_0: fimc-lite@12390000 {
 
 	fimc_lite_1: fimc-lite@123a0000 {
 		compatible = "samsung,exynos4212-fimc-lite";
-		reg = <0x123A0000 0x1000>;
+		reg = <0x123a0000 0x1000>;
 		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&pd_isp>;
 		clocks = <&isp_clock CLK_ISP_FIMC_LITE1>;
@@ -811,7 +811,7 @@ &tmu {
 	compatible = "samsung,exynos4412-tmu";
 	interrupt-parent = <&combiner>;
 	interrupts = <2 4>;
-	reg = <0x100C0000 0x100>;
+	reg = <0x100c0000 0x100>;
 	clocks = <&clock CLK_TMU_APBIF>;
 	clock-names = "tmu_apbif";
 	status = "disabled";
diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index c8da0d4b1b33..48e43b6b3213 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -104,31 +104,31 @@ sysreg_system_controller: syscon@10050000 {
 
 		serial_0: serial@12c00000 {
 			compatible = "samsung,exynos4210-uart";
-			reg = <0x12C00000 0x100>;
+			reg = <0x12c00000 0x100>;
 			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		serial_1: serial@12c10000 {
 			compatible = "samsung,exynos4210-uart";
-			reg = <0x12C10000 0x100>;
+			reg = <0x12c10000 0x100>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		serial_2: serial@12c20000 {
 			compatible = "samsung,exynos4210-uart";
-			reg = <0x12C20000 0x100>;
+			reg = <0x12c20000 0x100>;
 			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		serial_3: serial@12c30000 {
 			compatible = "samsung,exynos4210-uart";
-			reg = <0x12C30000 0x100>;
+			reg = <0x12c30000 0x100>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		i2c_0: i2c@12c60000 {
 			compatible = "samsung,s3c2440-i2c";
-			reg = <0x12C60000 0x100>;
+			reg = <0x12c60000 0x100>;
 			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -138,7 +138,7 @@ i2c_0: i2c@12c60000 {
 
 		i2c_1: i2c@12c70000 {
 			compatible = "samsung,s3c2440-i2c";
-			reg = <0x12C70000 0x100>;
+			reg = <0x12c70000 0x100>;
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -148,7 +148,7 @@ i2c_1: i2c@12c70000 {
 
 		i2c_2: i2c@12c80000 {
 			compatible = "samsung,s3c2440-i2c";
-			reg = <0x12C80000 0x100>;
+			reg = <0x12c80000 0x100>;
 			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -158,7 +158,7 @@ i2c_2: i2c@12c80000 {
 
 		i2c_3: i2c@12c90000 {
 			compatible = "samsung,s3c2440-i2c";
-			reg = <0x12C90000 0x100>;
+			reg = <0x12c90000 0x100>;
 			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -168,7 +168,7 @@ i2c_3: i2c@12c90000 {
 
 		pwm: pwm@12dd0000 {
 			compatible = "samsung,exynos4210-pwm";
-			reg = <0x12DD0000 0x100>;
+			reg = <0x12dd0000 0x100>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
@@ -180,7 +180,7 @@ pwm: pwm@12dd0000 {
 
 		rtc: rtc@101e0000 {
 			compatible = "samsung,s3c6410-rtc";
-			reg = <0x101E0000 0x100>;
+			reg = <0x101e0000 0x100>;
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -198,7 +198,7 @@ fimd: fimd@14400000 {
 
 		dp: dp-controller@145b0000 {
 			compatible = "samsung,exynos5-dp";
-			reg = <0x145B0000 0x1000>;
+			reg = <0x145b0000 0x1000>;
 			interrupts = <10 3>;
 			interrupt-parent = <&combiner>;
 			status = "disabled";
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 5b5aa79988e9..97e89859ba3d 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -216,14 +216,14 @@ pd_g3d: power-domain@10044060 {
 
 		pd_disp1: power-domain@100440a0 {
 			compatible = "samsung,exynos4210-pd";
-			reg = <0x100440A0 0x20>;
+			reg = <0x100440a0 0x20>;
 			#power-domain-cells = <0>;
 			label = "DISP1";
 		};
 
 		pd_mau: power-domain@100440c0 {
 			compatible = "samsung,exynos4210-pd";
-			reg = <0x100440C0 0x20>;
+			reg = <0x100440c0 0x20>;
 			#power-domain-cells = <0>;
 			label = "MAU";
 		};
@@ -236,7 +236,7 @@ clock: clock-controller@10010000 {
 
 		clock_audss: audss-clock-controller@3810000 {
 			compatible = "samsung,exynos5250-audss-clock";
-			reg = <0x03810000 0x0C>;
+			reg = <0x03810000 0x0c>;
 			#clock-cells = <1>;
 			clocks = <&clock CLK_FIN_PLL>, <&clock CLK_FOUT_EPLL>,
 				 <&clock CLK_SCLK_AUDIO0>, <&clock CLK_DIV_PCM0>;
@@ -247,7 +247,7 @@ clock_audss: audss-clock-controller@3810000 {
 		timer@101c0000 {
 			compatible = "samsung,exynos5250-mct",
 				     "samsung,exynos4210-mct";
-			reg = <0x101C0000 0x800>;
+			reg = <0x101c0000 0x800>;
 			clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
 			clock-names = "fin_pll", "mct";
 			interrupts-extended = <&combiner 23 3>,
@@ -302,7 +302,7 @@ pmu_system_controller: system-controller@10040000 {
 
 		watchdog@101d0000 {
 			compatible = "samsung,exynos5250-wdt";
-			reg = <0x101D0000 0x100>;
+			reg = <0x101d0000 0x100>;
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_WDT>;
 			clock-names = "watchdog";
@@ -322,7 +322,7 @@ mfc: codec@11000000 {
 
 		rotator: rotator@11c00000 {
 			compatible = "samsung,exynos5250-rotator";
-			reg = <0x11C00000 0x64>;
+			reg = <0x11c00000 0x64>;
 			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_ROTATOR>;
 			clock-names = "rotator";
@@ -387,7 +387,7 @@ tmu: tmu@10060000 {
 
 		sata: sata@122f0000 {
 			compatible = "snps,dwc-ahci";
-			reg = <0x122F0000 0x1ff>;
+			reg = <0x122f0000 0x1ff>;
 			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_SATA>, <&clock CLK_SCLK_SATA>;
 			clock-names = "sata", "pclk";
@@ -410,7 +410,7 @@ sata_phy: sata-phy@12170000 {
 		/* i2c_0-3 are defined in exynos5.dtsi */
 		i2c_4: i2c@12ca0000 {
 			compatible = "samsung,s3c2440-i2c";
-			reg = <0x12CA0000 0x100>;
+			reg = <0x12ca0000 0x100>;
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -423,7 +423,7 @@ i2c_4: i2c@12ca0000 {
 
 		i2c_5: i2c@12cb0000 {
 			compatible = "samsung,s3c2440-i2c";
-			reg = <0x12CB0000 0x100>;
+			reg = <0x12cb0000 0x100>;
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -436,7 +436,7 @@ i2c_5: i2c@12cb0000 {
 
 		i2c_6: i2c@12cc0000 {
 			compatible = "samsung,s3c2440-i2c";
-			reg = <0x12CC0000 0x100>;
+			reg = <0x12cc0000 0x100>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -449,7 +449,7 @@ i2c_6: i2c@12cc0000 {
 
 		i2c_7: i2c@12cd0000 {
 			compatible = "samsung,s3c2440-i2c";
-			reg = <0x12CD0000 0x100>;
+			reg = <0x12cd0000 0x100>;
 			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -462,7 +462,7 @@ i2c_7: i2c@12cd0000 {
 
 		i2c_8: i2c@12ce0000 {
 			compatible = "samsung,s3c2440-hdmiphy-i2c";
-			reg = <0x12CE0000 0x1000>;
+			reg = <0x12ce0000 0x1000>;
 			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -478,7 +478,7 @@ hdmiphy: hdmi-phy@38 {
 
 		i2c_9: i2c@121d0000 {
 			compatible = "samsung,exynos5-sata-phy-i2c";
-			reg = <0x121D0000 0x100>;
+			reg = <0x121d0000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clock CLK_SATA_PHYI2C>;
@@ -608,7 +608,7 @@ i2s0: i2s@3830000 {
 		i2s1: i2s@12d60000 {
 			compatible = "samsung,s3c6410-i2s";
 			status = "disabled";
-			reg = <0x12D60000 0x100>;
+			reg = <0x12d60000 0x100>;
 			dmas = <&pdma1 12>,
 				<&pdma1 11>;
 			dma-names = "tx", "rx";
@@ -623,7 +623,7 @@ i2s1: i2s@12d60000 {
 		i2s2: i2s@12d70000 {
 			compatible = "samsung,s3c6410-i2s";
 			status = "disabled";
-			reg = <0x12D70000 0x100>;
+			reg = <0x12d70000 0x100>;
 			dmas = <&pdma0 12>,
 				<&pdma0 11>;
 			dma-names = "tx", "rx";
@@ -695,7 +695,7 @@ usb2_phy_gen: phy@12130000 {
 
 		pdma0: dma-controller@121a0000 {
 			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x121A0000 0x1000>;
+			reg = <0x121a0000 0x1000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_PDMA0>;
 			clock-names = "apb_pclk";
@@ -704,7 +704,7 @@ pdma0: dma-controller@121a0000 {
 
 		pdma1: dma-controller@121b0000 {
 			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x121B0000 0x1000>;
+			reg = <0x121b0000 0x1000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_PDMA1>;
 			clock-names = "apb_pclk";
@@ -722,7 +722,7 @@ mdma0: dma-controller@10800000 {
 
 		mdma1: dma-controller@11c10000 {
 			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x11C10000 0x1000>;
+			reg = <0x11c10000 0x1000>;
 			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_MDMA1>;
 			clock-names = "apb_pclk";
@@ -787,7 +787,7 @@ hdmi: hdmi@14530000 {
 
 		hdmicec: cec@101b0000 {
 			compatible = "samsung,s5p-cec";
-			reg = <0x101B0000 0x200>;
+			reg = <0x101b0000 0x200>;
 			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_HDMI_CEC>;
 			clock-names = "hdmicec";
@@ -838,7 +838,7 @@ dsi_0: dsi@14500000 {
 
 		adc: adc@12d10000 {
 			compatible = "samsung,exynos-adc-v1";
-			reg = <0x12D10000 0x100>;
+			reg = <0x12d10000 0x100>;
 			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_ADC>;
 			clock-names = "adc";
@@ -849,7 +849,7 @@ adc: adc@12d10000 {
 
 		sysmmu_g2d: sysmmu@10a60000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x10A60000 0x1000>;
+			reg = <0x10a60000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <24 5>;
 			clock-names = "sysmmu", "master";
@@ -881,7 +881,7 @@ sysmmu_mfc_l: sysmmu@11210000 {
 
 		sysmmu_rotator: sysmmu@11d40000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x11D40000 0x1000>;
+			reg = <0x11d40000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <4 0>;
 			clock-names = "sysmmu", "master";
@@ -891,7 +891,7 @@ sysmmu_rotator: sysmmu@11d40000 {
 
 		sysmmu_jpeg: sysmmu@11f20000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x11F20000 0x1000>;
+			reg = <0x11f20000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <4 2>;
 			power-domains = <&pd_gsc>;
@@ -922,7 +922,7 @@ sysmmu_fimc_drc: sysmmu@13270000 {
 
 		sysmmu_fimc_fd: sysmmu@132a0000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x132A0000 0x1000>;
+			reg = <0x132a0000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <5 0>;
 			clock-names = "sysmmu";
@@ -952,7 +952,7 @@ sysmmu_fimc_scp: sysmmu@13290000 {
 
 		sysmmu_fimc_mcuctl: sysmmu@132b0000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x132B0000 0x1000>;
+			reg = <0x132b0000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <5 4>;
 			clock-names = "sysmmu";
@@ -962,7 +962,7 @@ sysmmu_fimc_mcuctl: sysmmu@132b0000 {
 
 		sysmmu_fimc_odc: sysmmu@132c0000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x132C0000 0x1000>;
+			reg = <0x132c0000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <11 0>;
 			clock-names = "sysmmu";
@@ -972,7 +972,7 @@ sysmmu_fimc_odc: sysmmu@132c0000 {
 
 		sysmmu_fimc_dis0: sysmmu@132d0000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x132D0000 0x1000>;
+			reg = <0x132d0000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <10 4>;
 			clock-names = "sysmmu";
@@ -982,7 +982,7 @@ sysmmu_fimc_dis0: sysmmu@132d0000 {
 
 		sysmmu_fimc_dis1: sysmmu@132e0000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x132E0000 0x1000>;
+			reg = <0x132e0000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <9 4>;
 			clock-names = "sysmmu";
@@ -992,7 +992,7 @@ sysmmu_fimc_dis1: sysmmu@132e0000 {
 
 		sysmmu_fimc_3dnr: sysmmu@132f0000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x132F0000 0x1000>;
+			reg = <0x132f0000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <5 6>;
 			clock-names = "sysmmu";
@@ -1002,7 +1002,7 @@ sysmmu_fimc_3dnr: sysmmu@132f0000 {
 
 		sysmmu_fimc_lite0: sysmmu@13c40000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x13C40000 0x1000>;
+			reg = <0x13c40000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <3 4>;
 			power-domains = <&pd_gsc>;
@@ -1013,7 +1013,7 @@ sysmmu_fimc_lite0: sysmmu@13c40000 {
 
 		sysmmu_fimc_lite1: sysmmu@13c50000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x13C50000 0x1000>;
+			reg = <0x13c50000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <24 1>;
 			power-domains = <&pd_gsc>;
@@ -1024,7 +1024,7 @@ sysmmu_fimc_lite1: sysmmu@13c50000 {
 
 		sysmmu_gsc0: sysmmu@13e80000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x13E80000 0x1000>;
+			reg = <0x13e80000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <2 0>;
 			power-domains = <&pd_gsc>;
@@ -1035,7 +1035,7 @@ sysmmu_gsc0: sysmmu@13e80000 {
 
 		sysmmu_gsc1: sysmmu@13e90000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x13E90000 0x1000>;
+			reg = <0x13e90000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <2 2>;
 			power-domains = <&pd_gsc>;
@@ -1046,7 +1046,7 @@ sysmmu_gsc1: sysmmu@13e90000 {
 
 		sysmmu_gsc2: sysmmu@13ea0000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x13EA0000 0x1000>;
+			reg = <0x13ea0000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <2 4>;
 			power-domains = <&pd_gsc>;
@@ -1057,7 +1057,7 @@ sysmmu_gsc2: sysmmu@13ea0000 {
 
 		sysmmu_gsc3: sysmmu@13eb0000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x13EB0000 0x1000>;
+			reg = <0x13eb0000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <2 6>;
 			power-domains = <&pd_gsc>;
diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index ff1ee409eff3..a97449b4640c 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -177,7 +177,7 @@ clock_kfc: clock-controller@10700000 {
 
 		clock_g2d: clock-controller@10a00000 {
 			compatible = "samsung,exynos5260-clock-g2d";
-			reg = <0x10A00000 0x10000>;
+			reg = <0x10a00000 0x10000>;
 			#clock-cells = <1>;
 			clocks = <&fin_pll>,
 				 <&clock_top TOP_DOUT_ACLK_G2D_333>;
@@ -187,7 +187,7 @@ clock_g2d: clock-controller@10a00000 {
 
 		clock_mif: clock-controller@10ce0000 {
 			compatible = "samsung,exynos5260-clock-mif";
-			reg = <0x10CE0000 0x10000>;
+			reg = <0x10ce0000 0x10000>;
 			#clock-cells = <1>;
 			clocks = <&fin_pll>;
 			clock-names = "fin_pll";
@@ -213,7 +213,7 @@ clock_g3d: clock-controller@11830000 {
 
 		clock_fsys: clock-controller@122e0000 {
 			compatible = "samsung,exynos5260-clock-fsys";
-			reg = <0x122E0000 0x10000>;
+			reg = <0x122e0000 0x10000>;
 			#clock-cells = <1>;
 			clocks = <&fin_pll>,
 				 <&fin_pll>,
@@ -233,7 +233,7 @@ clock_fsys: clock-controller@122e0000 {
 
 		clock_aud: clock-controller@128c0000 {
 			compatible = "samsung,exynos5260-clock-aud";
-			reg = <0x128C0000 0x10000>;
+			reg = <0x128c0000 0x10000>;
 			#clock-cells = <1>;
 			clocks = <&fin_pll>,
 				 <&clock_top TOP_FOUT_AUD_PLL>,
@@ -247,7 +247,7 @@ clock_aud: clock-controller@128c0000 {
 
 		clock_isp: clock-controller@133c0000 {
 			compatible = "samsung,exynos5260-clock-isp";
-			reg = <0x133C0000 0x10000>;
+			reg = <0x133c0000 0x10000>;
 			#clock-cells = <1>;
 			clocks = <&fin_pll>,
 				 <&clock_top TOP_DOUT_ACLK_ISP1_266>,
@@ -261,7 +261,7 @@ clock_isp: clock-controller@133c0000 {
 
 		clock_gscl: clock-controller@13f00000 {
 			compatible = "samsung,exynos5260-clock-gscl";
-			reg = <0x13F00000 0x10000>;
+			reg = <0x13f00000 0x10000>;
 			#clock-cells = <1>;
 			clocks = <&fin_pll>,
 				 <&clock_top TOP_DOUT_ACLK_GSCL_400>,
@@ -335,7 +335,7 @@ chipid: chipid@10000000 {
 		mct: timer@100b0000 {
 			compatible = "samsung,exynos5260-mct",
 				     "samsung,exynos4210-mct";
-			reg = <0x100B0000 0x1000>;
+			reg = <0x100b0000 0x1000>;
 			clocks = <&fin_pll>, <&clock_peri PERI_CLK_MCT>;
 			clock-names = "fin_pll", "mct";
 			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
@@ -356,8 +356,8 @@ cci: cci@10f00000 {
 			compatible = "arm,cci-400";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			reg = <0x10F00000 0x1000>;
-			ranges = <0x0 0x10F00000 0x6000>;
+			reg = <0x10f00000 0x1000>;
+			ranges = <0x0 0x10f00000 0x6000>;
 
 			cci_control0: slave-if@4000 {
 				compatible = "arm,cci-400-ctrl-if";
@@ -392,18 +392,18 @@ pinctrl_1: pinctrl@12290000 {
 
 		pinctrl_2: pinctrl@128b0000 {
 			compatible = "samsung,exynos5260-pinctrl";
-			reg = <0x128B0000 0x1000>;
+			reg = <0x128b0000 0x1000>;
 			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pmu_system_controller: system-controller@10d50000 {
 			compatible = "samsung,exynos5260-pmu", "syscon";
-			reg = <0x10D50000 0x10000>;
+			reg = <0x10d50000 0x10000>;
 		};
 
 		uart0: serial@12c00000 {
 			compatible = "samsung,exynos4210-uart";
-			reg = <0x12C00000 0x100>;
+			reg = <0x12c00000 0x100>;
 			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peri PERI_CLK_UART0>, <&clock_peri PERI_SCLK_UART0>;
 			clock-names = "uart", "clk_uart_baud0";
@@ -412,7 +412,7 @@ uart0: serial@12c00000 {
 
 		uart1: serial@12c10000 {
 			compatible = "samsung,exynos4210-uart";
-			reg = <0x12C10000 0x100>;
+			reg = <0x12c10000 0x100>;
 			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peri PERI_CLK_UART1>, <&clock_peri PERI_SCLK_UART1>;
 			clock-names = "uart", "clk_uart_baud0";
@@ -421,7 +421,7 @@ uart1: serial@12c10000 {
 
 		uart2: serial@12c20000 {
 			compatible = "samsung,exynos4210-uart";
-			reg = <0x12C20000 0x100>;
+			reg = <0x12c20000 0x100>;
 			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peri PERI_CLK_UART2>, <&clock_peri PERI_SCLK_UART2>;
 			clock-names = "uart", "clk_uart_baud0";
@@ -499,7 +499,7 @@ mmc_2: mmc@12160000 {
 
 		hsi2c_0: i2c@12da0000 {
 			compatible = "samsung,exynos5260-hsi2c";
-			reg = <0x12DA0000 0x1000>;
+			reg = <0x12da0000 0x1000>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -512,7 +512,7 @@ hsi2c_0: i2c@12da0000 {
 
 		hsi2c_1: i2c@12db0000 {
 			compatible = "samsung,exynos5260-hsi2c";
-			reg = <0x12DB0000 0x1000>;
+			reg = <0x12db0000 0x1000>;
 			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -525,7 +525,7 @@ hsi2c_1: i2c@12db0000 {
 
 		hsi2c_2: i2c@12dc0000 {
 			compatible = "samsung,exynos5260-hsi2c";
-			reg = <0x12DC0000 0x1000>;
+			reg = <0x12dc0000 0x1000>;
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -538,7 +538,7 @@ hsi2c_2: i2c@12dc0000 {
 
 		hsi2c_3: i2c@12dd0000 {
 			compatible = "samsung,exynos5260-hsi2c";
-			reg = <0x12DD0000 0x1000>;
+			reg = <0x12dd0000 0x1000>;
 			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 8a6b890fb8f7..350b8afa0a3a 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -81,7 +81,7 @@ clock: clock-controller@10010000 {
 
 		clock_audss: audss-clock-controller@3810000 {
 			compatible = "samsung,exynos5410-audss-clock";
-			reg = <0x03810000 0x0C>;
+			reg = <0x03810000 0x0c>;
 			#clock-cells = <1>;
 			clocks = <&fin_pll>, <&clock CLK_FOUT_EPLL>;
 			clock-names = "pll_ref", "pll_in";
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 96f92faa70e0..13d7be236a23 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -293,7 +293,7 @@ clock: clock-controller@10010000 {
 
 		clock_audss: audss-clock-controller@3810000 {
 			compatible = "samsung,exynos5420-audss-clock";
-			reg = <0x03810000 0x0C>;
+			reg = <0x03810000 0x0c>;
 			#clock-cells = <1>;
 			clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MAU_EPLL>,
 				 <&clock CLK_SCLK_MAUDIO0>, <&clock CLK_SCLK_MAUPCM0>;
@@ -373,37 +373,37 @@ dmc: memory-controller@10c20000 {
 
 		nocp_mem0_0: nocp@10ca1000 {
 			compatible = "samsung,exynos5420-nocp";
-			reg = <0x10CA1000 0x200>;
+			reg = <0x10ca1000 0x200>;
 			status = "disabled";
 		};
 
 		nocp_mem0_1: nocp@10ca1400 {
 			compatible = "samsung,exynos5420-nocp";
-			reg = <0x10CA1400 0x200>;
+			reg = <0x10ca1400 0x200>;
 			status = "disabled";
 		};
 
 		nocp_mem1_0: nocp@10ca1800 {
 			compatible = "samsung,exynos5420-nocp";
-			reg = <0x10CA1800 0x200>;
+			reg = <0x10ca1800 0x200>;
 			status = "disabled";
 		};
 
 		nocp_mem1_1: nocp@10ca1c00 {
 			compatible = "samsung,exynos5420-nocp";
-			reg = <0x10CA1C00 0x200>;
+			reg = <0x10ca1c00 0x200>;
 			status = "disabled";
 		};
 
 		nocp_g3d_0: nocp@11a51000 {
 			compatible = "samsung,exynos5420-nocp";
-			reg = <0x11A51000 0x200>;
+			reg = <0x11a51000 0x200>;
 			status = "disabled";
 		};
 
 		nocp_g3d_1: nocp@11a51400 {
 			compatible = "samsung,exynos5420-nocp";
-			reg = <0x11A51400 0x200>;
+			reg = <0x11a51400 0x200>;
 			status = "disabled";
 		};
 
@@ -485,14 +485,14 @@ g3d_pd: power-domain@10044080 {
 
 		disp_pd: power-domain@100440c0 {
 			compatible = "samsung,exynos4210-pd";
-			reg = <0x100440C0 0x20>;
+			reg = <0x100440c0 0x20>;
 			#power-domain-cells = <0>;
 			label = "DISP";
 		};
 
 		mau_pd: power-domain@100440e0 {
 			compatible = "samsung,exynos4210-pd";
-			reg = <0x100440E0 0x20>;
+			reg = <0x100440e0 0x20>;
 			#power-domain-cells = <0>;
 			label = "MAU";
 		};
@@ -553,7 +553,7 @@ adma: dma-controller@3880000 {
 
 		pdma0: dma-controller@121a0000 {
 			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x121A0000 0x1000>;
+			reg = <0x121a0000 0x1000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_PDMA0>;
 			clock-names = "apb_pclk";
@@ -562,7 +562,7 @@ pdma0: dma-controller@121a0000 {
 
 		pdma1: dma-controller@121b0000 {
 			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x121B0000 0x1000>;
+			reg = <0x121b0000 0x1000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_PDMA1>;
 			clock-names = "apb_pclk";
@@ -580,7 +580,7 @@ mdma0: dma-controller@10800000 {
 
 		mdma1: dma-controller@11c10000 {
 			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x11C10000 0x1000>;
+			reg = <0x11c10000 0x1000>;
 			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_MDMA1>;
 			clock-names = "apb_pclk";
@@ -618,7 +618,7 @@ i2s0: i2s@3830000 {
 
 		i2s1: i2s@12d60000 {
 			compatible = "samsung,exynos5420-i2s";
-			reg = <0x12D60000 0x100>;
+			reg = <0x12d60000 0x100>;
 			dmas = <&pdma1 12>,
 				<&pdma1 11>;
 			dma-names = "tx", "rx";
@@ -634,7 +634,7 @@ i2s1: i2s@12d60000 {
 
 		i2s2: i2s@12d70000 {
 			compatible = "samsung,exynos5420-i2s";
-			reg = <0x12D70000 0x100>;
+			reg = <0x12d70000 0x100>;
 			dmas = <&pdma0 12>,
 				<&pdma0 11>;
 			dma-names = "tx", "rx";
@@ -723,7 +723,7 @@ dsi: dsi@14500000 {
 
 		hsi2c_8: i2c@12e00000 {
 			compatible = "samsung,exynos5250-hsi2c";
-			reg = <0x12E00000 0x1000>;
+			reg = <0x12e00000 0x1000>;
 			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -736,7 +736,7 @@ hsi2c_8: i2c@12e00000 {
 
 		hsi2c_9: i2c@12e10000 {
 			compatible = "samsung,exynos5250-hsi2c";
-			reg = <0x12E10000 0x1000>;
+			reg = <0x12e10000 0x1000>;
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -749,7 +749,7 @@ hsi2c_9: i2c@12e10000 {
 
 		hsi2c_10: i2c@12e20000 {
 			compatible = "samsung,exynos5250-hsi2c";
-			reg = <0x12E20000 0x1000>;
+			reg = <0x12e20000 0x1000>;
 			interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -777,12 +777,12 @@ hdmi: hdmi@14530000 {
 		};
 
 		hdmiphy: hdmi-phy@145d0000 {
-			reg = <0x145D0000 0x20>;
+			reg = <0x145d0000 0x20>;
 		};
 
 		hdmicec: cec@101b0000 {
 			compatible = "samsung,s5p-cec";
-			reg = <0x101B0000 0x200>;
+			reg = <0x101b0000 0x200>;
 			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_HDMI_CEC>;
 			clock-names = "hdmicec";
@@ -807,7 +807,7 @@ mixer: mixer@14450000 {
 
 		rotator: rotator@11c00000 {
 			compatible = "samsung,exynos5250-rotator";
-			reg = <0x11C00000 0x64>;
+			reg = <0x11c00000 0x64>;
 			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_ROTATOR>;
 			clock-names = "rotator";
@@ -916,7 +916,7 @@ scaler_2: scaler@12820000 {
 
 		jpeg_0: jpeg@11f50000 {
 			compatible = "samsung,exynos5420-jpeg";
-			reg = <0x11F50000 0x1000>;
+			reg = <0x11f50000 0x1000>;
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "jpeg";
 			clocks = <&clock CLK_JPEG>;
@@ -925,7 +925,7 @@ jpeg_0: jpeg@11f50000 {
 
 		jpeg_1: jpeg@11f60000 {
 			compatible = "samsung,exynos5420-jpeg";
-			reg = <0x11F60000 0x1000>;
+			reg = <0x11f60000 0x1000>;
 			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "jpeg";
 			clocks = <&clock CLK_JPEG2>;
@@ -990,7 +990,7 @@ tmu_gpu: tmu@100a0000 {
 
 		sysmmu_g2dr: sysmmu@10a60000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x10A60000 0x1000>;
+			reg = <0x10a60000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <24 5>;
 			clock-names = "sysmmu", "master";
@@ -1000,7 +1000,7 @@ sysmmu_g2dr: sysmmu@10a60000 {
 
 		sysmmu_g2dw: sysmmu@10a70000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x10A70000 0x1000>;
+			reg = <0x10a70000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <22 2>;
 			clock-names = "sysmmu", "master";
@@ -1021,7 +1021,7 @@ sysmmu_tv: sysmmu@14650000 {
 
 		sysmmu_gscl0: sysmmu@13e80000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x13E80000 0x1000>;
+			reg = <0x13e80000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <2 0>;
 			clock-names = "sysmmu", "master";
@@ -1032,7 +1032,7 @@ sysmmu_gscl0: sysmmu@13e80000 {
 
 		sysmmu_gscl1: sysmmu@13e90000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x13E90000 0x1000>;
+			reg = <0x13e90000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <2 2>;
 			clock-names = "sysmmu", "master";
@@ -1064,7 +1064,7 @@ sysmmu_scaler1r: sysmmu@12890000 {
 
 		sysmmu_scaler2r: sysmmu@128a0000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x128A0000 0x1000>;
+			reg = <0x128a0000 0x1000>;
 			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "sysmmu", "master";
 			clocks = <&clock CLK_SMMU_MSCL2>, <&clock CLK_MSCL2>;
@@ -1074,7 +1074,7 @@ sysmmu_scaler2r: sysmmu@128a0000 {
 
 		sysmmu_scaler0w: sysmmu@128c0000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x128C0000 0x1000>;
+			reg = <0x128c0000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <27 2>;
 			clock-names = "sysmmu", "master";
@@ -1085,7 +1085,7 @@ sysmmu_scaler0w: sysmmu@128c0000 {
 
 		sysmmu_scaler1w: sysmmu@128d0000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x128D0000 0x1000>;
+			reg = <0x128d0000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <22 6>;
 			clock-names = "sysmmu", "master";
@@ -1096,7 +1096,7 @@ sysmmu_scaler1w: sysmmu@128d0000 {
 
 		sysmmu_scaler2w: sysmmu@128e0000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x128E0000 0x1000>;
+			reg = <0x128e0000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <19 6>;
 			clock-names = "sysmmu", "master";
@@ -1107,7 +1107,7 @@ sysmmu_scaler2w: sysmmu@128e0000 {
 
 		sysmmu_rotator: sysmmu@11d40000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x11D40000 0x1000>;
+			reg = <0x11d40000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <4 0>;
 			clock-names = "sysmmu", "master";
@@ -1117,7 +1117,7 @@ sysmmu_rotator: sysmmu@11d40000 {
 
 		sysmmu_jpeg0: sysmmu@11f10000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x11F10000 0x1000>;
+			reg = <0x11f10000 0x1000>;
 			interrupt-parent = <&combiner>;
 			interrupts = <4 2>;
 			clock-names = "sysmmu", "master";
@@ -1127,7 +1127,7 @@ sysmmu_jpeg0: sysmmu@11f10000 {
 
 		sysmmu_jpeg1: sysmmu@11f20000 {
 			compatible = "samsung,exynos-sysmmu";
-			reg = <0x11F20000 0x1000>;
+			reg = <0x11f20000 0x1000>;
 			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "sysmmu", "master";
 			clocks = <&clock CLK_SMMU_JPEG2>, <&clock CLK_JPEG2>;
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 06103dd37265..30fc677d8bac 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -16,7 +16,7 @@
 / {
 	memory@40000000 {
 		device_type = "memory";
-		reg = <0x40000000 0x7EA00000>;
+		reg = <0x40000000 0x7ea00000>;
 	};
 
 	chosen {
-- 
2.34.1


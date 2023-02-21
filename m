Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8754569E674
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjBURy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjBURyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:54:18 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B412F799;
        Tue, 21 Feb 2023 09:54:16 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cy6so15085661edb.5;
        Tue, 21 Feb 2023 09:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llOPkmJdNtIeNEpVol45mbxinEbldfv6+ZdmOXE/2gU=;
        b=Lv64O0HM8k0aP/T1HXLXt/IlxsftacrR/ufPEvzvlqUUYFLQ9d4xBMSdfmr/oPFc6A
         76QN3ghWpizVdaj5BsS10x9lHR6/0Nwg7zaZBQndDDg/fhQ8E4ZPc77vYutzeADBvUxP
         CtZad7uh5pEv7YSWH+9kL6WQ3rESWa0AekzF2SKq56bqOW62VzxdYtFDafqdROMVvbpl
         vZaBNOjKkBZ/hi1rsF/28jSkUFQMFkMtV5pKzLOYoIgklpgtRIxxZzVmptJQu6P/cjYr
         KVxW+ecHBHLnJm1MIBLcKbwKfm/OIe7IDz6/57pMwAW1M+xAeUeNFJ/t9qAIRX7v2IMu
         Ggaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llOPkmJdNtIeNEpVol45mbxinEbldfv6+ZdmOXE/2gU=;
        b=PN45iHQr0DetqkMqnVAAuck/Fdse7aFvcVYoqx8xLwV+kcT7AYhKHZY045Q08qpwG1
         5LUg0ORyb0bEXpT3+YhiMxifvRvnf0qEUtT5LmqvhCOfaVOMl1/jIDJijSeiIkfGqF6r
         xDMNRfbUZOcS8Fhr/Gn9sPOaS93Dgu4NjwtbSYPuG50mZ0N+Firpc3d3X6WqfBVH8oM2
         dOHZ5FlEdn3FrfcREupKYJzw7K/o8pWC/kGcNHCSuoTc8UO1gUVTGNSsYcML71zjwWJx
         /9HZBFYVlVmVYseMOO23u6w/owhf8BtrUs7u2lOzgFj9G5Bs0+uJq8MTwsYnQX04tdqy
         tHUg==
X-Gm-Message-State: AO0yUKVJyvCrZ9iB5dWe2Y6evZRkXadeir/AlY4TVElw34NDtE5VAqae
        N29hs/s1Sev+q4amDug+dCyFMR92ifA=
X-Google-Smtp-Source: AK7set+YG6IaI/lEqdS0g9u13RIYDyfTrm5pnwAFumlnG12qDih99+miy7zrvSOVHn89Bgam0VaNFQ==
X-Received: by 2002:a17:907:7f1f:b0:888:7ac8:c0f4 with SMTP id qf31-20020a1709077f1f00b008887ac8c0f4mr17765469ejc.25.1677002054738;
        Tue, 21 Feb 2023 09:54:14 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id b3-20020a170906660300b008e493b7bb61sm236357ejp.153.2023.02.21.09.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:54:14 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] ARM: tegra: Add labels to tegra114.dtsi
Date:   Tue, 21 Feb 2023 19:53:45 +0200
Message-Id: <20230221175348.15681-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230221175348.15681-1-clamor95@gmail.com>
References: <20230221175348.15681-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Bambura <jenneron@protonmail.com>

Add more labels in order to use label reference in device-specific
dts files. Labels make device-trees more readable and prevent typos
that are difficult to notice.

Signed-off-by: Anton Bambura <jenneron@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 48 ++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 09996acad639..76c52d0b518a 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -106,7 +106,7 @@ rgb {
 			};
 		};
 
-		hdmi@54280000 {
+		hdmi: hdmi@54280000 {
 			compatible = "nvidia,tegra114-hdmi";
 			reg = <0x54280000 0x00040000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
@@ -370,7 +370,7 @@ pwm: pwm@7000a000 {
 		status = "disabled";
 	};
 
-	i2c@7000c000 {
+	i2c1: i2c@7000c000 {
 		compatible = "nvidia,tegra114-i2c";
 		reg = <0x7000c000 0x100>;
 		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
@@ -385,7 +385,7 @@ i2c@7000c000 {
 		status = "disabled";
 	};
 
-	i2c@7000c400 {
+	i2c2: i2c@7000c400 {
 		compatible = "nvidia,tegra114-i2c";
 		reg = <0x7000c400 0x100>;
 		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
@@ -400,7 +400,7 @@ i2c@7000c400 {
 		status = "disabled";
 	};
 
-	i2c@7000c500 {
+	i2c3: i2c@7000c500 {
 		compatible = "nvidia,tegra114-i2c";
 		reg = <0x7000c500 0x100>;
 		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
@@ -415,7 +415,7 @@ i2c@7000c500 {
 		status = "disabled";
 	};
 
-	i2c@7000c700 {
+	i2c4: i2c@7000c700 {
 		compatible = "nvidia,tegra114-i2c";
 		reg = <0x7000c700 0x100>;
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
@@ -430,7 +430,7 @@ i2c@7000c700 {
 		status = "disabled";
 	};
 
-	i2c@7000d000 {
+	i2c5: i2c@7000d000 {
 		compatible = "nvidia,tegra114-i2c";
 		reg = <0x7000d000 0x100>;
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
@@ -445,7 +445,7 @@ i2c@7000d000 {
 		status = "disabled";
 	};
 
-	spi@7000d400 {
+	spi1: spi@7000d400 {
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000d400 0x200>;
 		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
@@ -460,7 +460,7 @@ spi@7000d400 {
 		status = "disabled";
 	};
 
-	spi@7000d600 {
+	spi2: spi@7000d600 {
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000d600 0x200>;
 		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
@@ -475,7 +475,7 @@ spi@7000d600 {
 		status = "disabled";
 	};
 
-	spi@7000d800 {
+	spi3: spi@7000d800 {
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000d800 0x200>;
 		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
@@ -490,7 +490,7 @@ spi@7000d800 {
 		status = "disabled";
 	};
 
-	spi@7000da00 {
+	spi4: spi@7000da00 {
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000da00 0x200>;
 		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
@@ -505,7 +505,7 @@ spi@7000da00 {
 		status = "disabled";
 	};
 
-	spi@7000dc00 {
+	spi5: spi@7000dc00 {
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000dc00 0x200>;
 		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
@@ -520,7 +520,7 @@ spi@7000dc00 {
 		status = "disabled";
 	};
 
-	spi@7000de00 {
+	spi6: spi@7000de00 {
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000de00 0x200>;
 		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
@@ -535,14 +535,14 @@ spi@7000de00 {
 		status = "disabled";
 	};
 
-	rtc@7000e000 {
+	tegra_rtc: rtc@7000e000 {
 		compatible = "nvidia,tegra114-rtc", "nvidia,tegra20-rtc";
 		reg = <0x7000e000 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA114_CLK_RTC>;
 	};
 
-	kbc@7000e200 {
+	tegra_kbc: kbc@7000e200 {
 		compatible = "nvidia,tegra114-kbc";
 		reg = <0x7000e200 0x100>;
 		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
@@ -682,7 +682,7 @@ mipi: mipi@700e3000 {
 		#nvidia,mipi-calibrate-cells = <1>;
 	};
 
-	mmc@78000000 {
+	sdmmc1: mmc@78000000 {
 		compatible = "nvidia,tegra114-sdhci";
 		reg = <0x78000000 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
@@ -693,7 +693,7 @@ mmc@78000000 {
 		status = "disabled";
 	};
 
-	mmc@78000200 {
+	sdmmc2: mmc@78000200 {
 		compatible = "nvidia,tegra114-sdhci";
 		reg = <0x78000200 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
@@ -704,7 +704,7 @@ mmc@78000200 {
 		status = "disabled";
 	};
 
-	mmc@78000400 {
+	sdmmc3: mmc@78000400 {
 		compatible = "nvidia,tegra114-sdhci";
 		reg = <0x78000400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
@@ -715,7 +715,7 @@ mmc@78000400 {
 		status = "disabled";
 	};
 
-	mmc@78000600 {
+	sdmmc4: mmc@78000600 {
 		compatible = "nvidia,tegra114-sdhci";
 		reg = <0x78000600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
@@ -726,7 +726,7 @@ mmc@78000600 {
 		status = "disabled";
 	};
 
-	usb@7d000000 {
+	usb1: usb@7d000000 {
 		compatible = "nvidia,tegra114-ehci", "nvidia,tegra30-ehci";
 		reg = <0x7d000000 0x4000>;
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
@@ -734,11 +734,11 @@ usb@7d000000 {
 		clocks = <&tegra_car TEGRA114_CLK_USBD>;
 		resets = <&tegra_car 22>;
 		reset-names = "usb";
-		nvidia,phy = <&phy1>;
+		nvidia,phy = <&usb1_phy>;
 		status = "disabled";
 	};
 
-	phy1: usb-phy@7d000000 {
+	usb1_phy: usb-phy@7d000000 {
 		compatible = "nvidia,tegra114-usb-phy", "nvidia,tegra30-usb-phy";
 		reg = <0x7d000000 0x4000>,
 		      <0x7d000000 0x4000>;
@@ -766,7 +766,7 @@ phy1: usb-phy@7d000000 {
 		status = "disabled";
 	};
 
-	usb@7d008000 {
+	usb3: usb@7d008000 {
 		compatible = "nvidia,tegra114-ehci", "nvidia,tegra30-ehci";
 		reg = <0x7d008000 0x4000>;
 		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
@@ -774,11 +774,11 @@ usb@7d008000 {
 		clocks = <&tegra_car TEGRA114_CLK_USB3>;
 		resets = <&tegra_car 59>;
 		reset-names = "usb";
-		nvidia,phy = <&phy3>;
+		nvidia,phy = <&usb3_phy>;
 		status = "disabled";
 	};
 
-	phy3: usb-phy@7d008000 {
+	usb3_phy: usb-phy@7d008000 {
 		compatible = "nvidia,tegra114-usb-phy", "nvidia,tegra30-usb-phy";
 		reg = <0x7d008000 0x4000>,
 		      <0x7d000000 0x4000>;
-- 
2.37.2


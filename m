Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE2E69E66A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjBURyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjBURyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:54:17 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4162F784;
        Tue, 21 Feb 2023 09:54:15 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ee7so5498837edb.2;
        Tue, 21 Feb 2023 09:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhTpi9pCO5tEAYpIqNUCgJuQDyepe4Dv0wciJpZZ8Iw=;
        b=p29vYHuyXU0GCDwzoEjvpuF7OAbv8SmQIMnS1+8wyCdlp9u8cNFy1Y3SVEYygdFACA
         RoLrEl8/3AKmVZQmojhkz+s+V8OwYSLRub9MXeYnMUM98f82d5xltf5OV611hY8fejxx
         pF/az7IohoiQxfNOlVLUznJCrCcXH/dBJPAPcAbBZYxgJAk2BCJkeyOFHv6crcS5rQaC
         ik6CcqpZmP+sUoikrKtklM0MpHKrGy9qjCgbaOnyURmmU3+reHVx47wQLyiJNEK++ciA
         A5ean8UWfHFjgLb8Taj7vTen8ywPd96Q2JX8pCu3SPoajGSm8VpF5eNIXQqkTdVQk3t9
         ducA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhTpi9pCO5tEAYpIqNUCgJuQDyepe4Dv0wciJpZZ8Iw=;
        b=0938Jol75GTfKEa8O/nOfrAzuRGHJYAFgGpuzxVjvbEBxPAxQBA+d33bYHu6rip29p
         y4VoKpm4IpVpht0ujniBO/7MHWq8g9/1JnTPIP08zZTh4XE/SfJhPS0zN6yqH4EMtHKJ
         d59YN6WCYTkoXshNdVdl0dVDPAy/ydVEO+wsczxDtlVPoViWbgviT1EoYefjRboIWppl
         a+dUQQGLW8bK213/Od3XSXFo8P1Gs2J6SkAsWZlbJFpRb/6JPWuHOdrIg3WOe5UW3r2n
         +rpnKWoZQsLOv9NtcyPDyDmIbngSCZCoHO4sJhTJGNvDxi22y8LmVKA6sBpJ7seEdPCF
         v/2A==
X-Gm-Message-State: AO0yUKXdPeCpom7EWUVOaMJKi3UhaQZt3ucNgAbSsVQBJItPnPQ1AF6a
        NBdV9Rn3QGCxCM2BFkZGEzvf7hT6X9w=
X-Google-Smtp-Source: AK7set8ir74PcQc+L9k8Ben2ZSsRVhBCvo6R0ADoPHSOm2sua97L3HnoaoVCJdUj+HRSWFBtS5fj8Q==
X-Received: by 2002:a17:907:6d0d:b0:8dd:76b6:7b14 with SMTP id sa13-20020a1709076d0d00b008dd76b67b14mr4310886ejc.14.1677002053790;
        Tue, 21 Feb 2023 09:54:13 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id b3-20020a170906660300b008e493b7bb61sm236357ejp.153.2023.02.21.09.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:54:13 -0800 (PST)
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
Subject: [PATCH v1 1/5] ARM: tegra: Add labels to tegra30.dtsi
Date:   Tue, 21 Feb 2023 19:53:44 +0200
Message-Id: <20230221175348.15681-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230221175348.15681-1-clamor95@gmail.com>
References: <20230221175348.15681-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Add phandle names for memory/I2C/SPI/USB/SDMMC controller nodes to allow
for cleaner device descriptions.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 36 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 9dab8d2c158a..1cdc64fa1463 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -655,7 +655,7 @@ rtc@7000e000 {
 		clocks = <&tegra_car TEGRA30_CLK_RTC>;
 	};
 
-	i2c@7000c000 {
+	i2c1: i2c@7000c000 {
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000c000 0x100>;
 		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
@@ -671,7 +671,7 @@ i2c@7000c000 {
 		status = "disabled";
 	};
 
-	i2c@7000c400 {
+	i2c2: i2c@7000c400 {
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000c400 0x100>;
 		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
@@ -687,7 +687,7 @@ i2c@7000c400 {
 		status = "disabled";
 	};
 
-	i2c@7000c500 {
+	i2c3: i2c@7000c500 {
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000c500 0x100>;
 		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
@@ -703,7 +703,7 @@ i2c@7000c500 {
 		status = "disabled";
 	};
 
-	i2c@7000c700 {
+	i2c4: i2c@7000c700 {
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000c700 0x100>;
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
@@ -719,7 +719,7 @@ i2c@7000c700 {
 		status = "disabled";
 	};
 
-	i2c@7000d000 {
+	i2c5: i2c@7000d000 {
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000d000 0x100>;
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
@@ -735,7 +735,7 @@ i2c@7000d000 {
 		status = "disabled";
 	};
 
-	spi@7000d400 {
+	spi1: spi@7000d400 {
 		compatible = "nvidia,tegra30-slink";
 		reg = <0x7000d400 0x200>;
 		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
@@ -751,7 +751,7 @@ spi@7000d400 {
 		status = "disabled";
 	};
 
-	spi@7000d600 {
+	spi2: spi@7000d600 {
 		compatible = "nvidia,tegra30-slink";
 		reg = <0x7000d600 0x200>;
 		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
@@ -767,7 +767,7 @@ spi@7000d600 {
 		status = "disabled";
 	};
 
-	spi@7000d800 {
+	spi3: spi@7000d800 {
 		compatible = "nvidia,tegra30-slink";
 		reg = <0x7000d800 0x200>;
 		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
@@ -783,7 +783,7 @@ spi@7000d800 {
 		status = "disabled";
 	};
 
-	spi@7000da00 {
+	spi4: spi@7000da00 {
 		compatible = "nvidia,tegra30-slink";
 		reg = <0x7000da00 0x200>;
 		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
@@ -799,7 +799,7 @@ spi@7000da00 {
 		status = "disabled";
 	};
 
-	spi@7000dc00 {
+	spi5: spi@7000dc00 {
 		compatible = "nvidia,tegra30-slink";
 		reg = <0x7000dc00 0x200>;
 		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
@@ -815,7 +815,7 @@ spi@7000dc00 {
 		status = "disabled";
 	};
 
-	spi@7000de00 {
+	spi6: spi@7000de00 {
 		compatible = "nvidia,tegra30-slink";
 		reg = <0x7000de00 0x200>;
 		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
@@ -1064,7 +1064,7 @@ tegra_i2s4: i2s@70080700 {
 		};
 	};
 
-	mmc@78000000 {
+	sdmmc1: mmc@78000000 {
 		compatible = "nvidia,tegra30-sdhci";
 		reg = <0x78000000 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
@@ -1077,7 +1077,7 @@ mmc@78000000 {
 		status = "disabled";
 	};
 
-	mmc@78000200 {
+	sdmmc2: mmc@78000200 {
 		compatible = "nvidia,tegra30-sdhci";
 		reg = <0x78000200 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
@@ -1088,7 +1088,7 @@ mmc@78000200 {
 		status = "disabled";
 	};
 
-	mmc@78000400 {
+	sdmmc3: mmc@78000400 {
 		compatible = "nvidia,tegra30-sdhci";
 		reg = <0x78000400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
@@ -1101,7 +1101,7 @@ mmc@78000400 {
 		status = "disabled";
 	};
 
-	mmc@78000600 {
+	sdmmc4: mmc@78000600 {
 		compatible = "nvidia,tegra30-sdhci";
 		reg = <0x78000600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
@@ -1112,7 +1112,7 @@ mmc@78000600 {
 		status = "disabled";
 	};
 
-	usb@7d000000 {
+	usb1: usb@7d000000 {
 		compatible = "nvidia,tegra30-ehci";
 		reg = <0x7d000000 0x4000>;
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
@@ -1156,7 +1156,7 @@ phy1: usb-phy@7d000000 {
 		status = "disabled";
 	};
 
-	usb@7d004000 {
+	usb2: usb@7d004000 {
 		compatible = "nvidia,tegra30-ehci";
 		reg = <0x7d004000 0x4000>;
 		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
@@ -1198,7 +1198,7 @@ phy2: usb-phy@7d004000 {
 		status = "disabled";
 	};
 
-	usb@7d008000 {
+	usb3: usb@7d008000 {
 		compatible = "nvidia,tegra30-ehci";
 		reg = <0x7d008000 0x4000>;
 		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.37.2


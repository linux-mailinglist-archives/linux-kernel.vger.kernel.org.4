Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FA06EADFD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjDUP0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjDUP0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:26:34 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828FBBB89;
        Fri, 21 Apr 2023 08:26:33 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f1958d3a85so4689855e9.1;
        Fri, 21 Apr 2023 08:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682090792; x=1684682792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sj/J7bBG6FjM8tAyQNQhnbZ2Rmtu2/+gz7MFzMP1cA8=;
        b=MHvBTVrIttJbs0SZk5eiJLxbUaG74Sfr1EvU0Edd7JVzcuWZvu9RcVyYv6JxRZDfzP
         f9YEQo1Okn+muqR7g6/eg7VcWVTy9NGGRiuRLlafK08Bpf8F3XyKf8LaxGul7OiTECaO
         5oKzQwe7R9xqU35OEJ/8qALhWkKSNK1ogkbb1oIT19oZbj+s/Ayx5oWA5F9Ls1IBS//8
         ZDL5UW2TId5MgsixOw6CiW2hvkuNAiHZX3bCsdV4ytX67STBSNEOVudgmyy+Ep8sRSGM
         uzm0Is0qWofMsM5wDLWadusSdtn64uKwK0gwZSGzTEBio4rnkxNRND34+QrTwb7m/eiQ
         TBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682090792; x=1684682792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sj/J7bBG6FjM8tAyQNQhnbZ2Rmtu2/+gz7MFzMP1cA8=;
        b=M58HZaPNrVACsProyXRGwthfvpaQDmca272mk3NlPF8QZulwGgnHxCTucbxV8PpJgF
         lZjBlrVzlgwpwU5ryNogZi5FAWwtJw1+RFedf25HWBnw8YU3K+55Z8O9zZ2hDUIoxPZV
         djKFjqGp+cV6/jCaf+UMQ9E8FUh/NVoUMu9y3MIcSLFkOC5lLpT1OQH7FEFqOAEcKNho
         fqKxpGlQ4UnWs5FxRInMXgz275p3MJjrPlL+pHte1qLj9IKpFF++7R9L1YP10jDNFR1h
         YBjwWCOD0EQ9LxCFhLe4HcsnNKPmlSkdoiCWXMGOUX8b4IP15ltINeNuklI+zz5hjjV9
         ZBrg==
X-Gm-Message-State: AAQBX9f1kzRPIsD0RmpIceZVH2uMMyo3IpUjAETjp6/YPO2LwLfefnP2
        gV/RUuFVweopor90hpKVBvc=
X-Google-Smtp-Source: AKy350Yxinw9SGq3XrBKhx6z7PPrrBznT5wZk4Zl9gpfkCIh1CtMRhsQD2QqD1qHq6nHgxWbSXUeZQ==
X-Received: by 2002:a1c:cc04:0:b0:3f0:9f9b:1665 with SMTP id h4-20020a1ccc04000000b003f09f9b1665mr2276223wmb.3.1682090791749;
        Fri, 21 Apr 2023 08:26:31 -0700 (PDT)
Received: from archbox.v.cablecom.net (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id a12-20020a05600c224c00b003f1788eeffesm8363153wmm.43.2023.04.21.08.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 08:26:31 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: fix nEXTRST on SOQuartz
Date:   Fri, 21 Apr 2023 17:26:10 +0200
Message-Id: <20230421152610.21688-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pre-production prototypes (of which I only know one person
having one, Peter Geis), GPIO0 pin A5 was tied to the SDMMC
power enable pin on the CM4 connector. On all production models,
this is not the case; instead, this pin is used for the nEXTRST
signal, and the SDMMC power enable pin is always pulled high.

Since everyone currently using the SOQuartz device trees will
want this change, it is made to the tree without splitting the
trees into two separate ones of which users will then inevitably
choose the wrong one.

This fixes USB and PCIe on a wide variety of CM4IO-compatible
boards which use the nEXTRST signal.

Fixes: 5859b5a9c3ac ("arm64: dts: rockchip: add SoQuartz CM4IO dts")
Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
Changes in v2:
 - use GPIO hog instead of a fake regulator

 .../boot/dts/rockchip/rk3566-soquartz-cm4.dts | 18 +++++++-----
 .../boot/dts/rockchip/rk3566-soquartz.dtsi    | 29 +++++++++----------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
index 263ce40770dd..cddf6cd2fecb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
@@ -28,6 +28,16 @@ vcc_5v: vcc-5v-regulator {
 		regulator-max-microvolt = <5000000>;
 		vin-supply = <&vcc12v_dcin>;
 	};
+
+	vcc_sd_pwr: vcc-sd-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sd_pwr";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
 };
 
 /* phy for pcie */
@@ -130,13 +140,7 @@ &saradc {
 };
 
 &sdmmc0 {
-	vmmc-supply = <&sdmmc_pwr>;
-	status = "okay";
-};
-
-&sdmmc_pwr {
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
+	vmmc-supply = <&vcc_sd_pwr>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
index ce7165d7f1a1..3036985e2567 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
@@ -104,16 +104,6 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc5v0_sys>;
 	};
-
-	sdmmc_pwr: sdmmc-pwr-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdmmc_pwr_h>;
-		regulator-name = "sdmmc_pwr";
-		status = "disabled";
-	};
 };
 
 &cpu0 {
@@ -155,6 +145,19 @@ &gmac1m0_clkinout
 	status = "disabled";
 };
 
+&gpio0 {
+	nextrst-hog {
+		gpio-hog;
+		/*
+		 * GPIO_ACTIVE_LOW + output-low here means that the pin is set
+		 * to high, because output-low decides the value pre-inversion.
+		 */
+		gpios = <RK_PA5 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "nEXTRST";
+	};
+};
+
 &gpu {
 	mali-supply = <&vdd_gpu>;
 	status = "okay";
@@ -538,12 +541,6 @@ wifi_enable_h: wifi-enable-h {
 			rockchip,pins = <2 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
-
-	sdmmc-pwr {
-		sdmmc_pwr_h: sdmmc-pwr-h {
-			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
 };
 
 &pmu_io_domains {
-- 
2.40.0


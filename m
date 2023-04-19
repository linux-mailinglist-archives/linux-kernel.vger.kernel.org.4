Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53ED26E8032
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 19:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjDSRR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 13:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjDSRR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 13:17:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EF165B5;
        Wed, 19 Apr 2023 10:17:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f178da21b2so278215e9.1;
        Wed, 19 Apr 2023 10:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681924673; x=1684516673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xBoqLsLFILpUeqaQAwB4b5qUgereH6wIMwsI7Fa/SsY=;
        b=EK+rvPhTQN0/qi3dNdP2dEsmCTVhxtE+gr9YKuIDcjBI7O53jFUlcILeDZiRZrI2Ta
         2qM7ie1i2kzb1TLqtZgJ+xhhcyrGriDgSgpI4vcOMq9bKh5odcNFFd25SLNDdCs/iUBd
         Y00Wc4yHg6kkGZDJj9aKKp+B6Io3fj6Ec0bw3p5kA+boKNZHRK8vtzp9dIOTn+iWtNsJ
         BhB1SVzLmGkBbweQ0bl97Az5asa+O6PJGPpx727RgeeSMho0919dd3iU+qPAFWkk1Oh7
         0dstp3k6FhPhGklkYvin8Ocw+F4E+BnTKIuF1HjfMSkmJGygT9zTwfEPcE7TAjf7JGmx
         9g6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681924673; x=1684516673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBoqLsLFILpUeqaQAwB4b5qUgereH6wIMwsI7Fa/SsY=;
        b=PL43iCADts3q17awKom0oodsKdUhVmRe13EY6CvF1kQmifhHI5s2NlhR6ZbkizVuYb
         lKUbTPKMQnEun/zaBiaU4LYgXJ2nGItk8rM6cZmXtKA+7liiqH8+ZWWQHfR4JtIvBMsn
         S1ydOdAAZXKBTIVSb/weAvh24UkRgEA8qxhsqnOknJ040UYD6CcpHsD0si9xUq+qrCXj
         x85WPTBJxF90UtVGLCOs8uHTuh4d9xrROEwNTDkyCX4r3c6VBgEXvTpwsEo2k/HR1gz6
         P+xeOmxy/YxWjRhCNY8rzJAu8uPGxVnDK3z/pQXJCwoZrQaTd7onZ9cF6VgMuUCmGlpw
         HYww==
X-Gm-Message-State: AAQBX9f0yf1Vb+2GbZX3zRcaEWx1dai+BbcMKbmqAzgdsTZUaiOLpdE6
        aeg2Ev09U9wnHmClUpvmmqw=
X-Google-Smtp-Source: AKy350bwMT9R/pz2b9g2K/44mP9753047Xgad1tVmPzf1Qt31ES4WXB8r6Kt+BKO1skqHoHGuE6VpA==
X-Received: by 2002:a5d:500d:0:b0:2f6:9bc4:76f1 with SMTP id e13-20020a5d500d000000b002f69bc476f1mr5721779wrt.1.1681924672646;
        Wed, 19 Apr 2023 10:17:52 -0700 (PDT)
Received: from archbox.v.cablecom.net (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id t3-20020a5d5343000000b002c55521903bsm16304136wrv.51.2023.04.19.10.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 10:17:52 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: fix nEXTRST on SOQuartz
Date:   Wed, 19 Apr 2023 19:17:31 +0200
Message-Id: <20230419171731.28641-1-frattaroli.nicolas@gmail.com>
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
boards which either rely on the 3.3V being there or use the
nEXTRST signal.

Fixes: 5859b5a9c3ac ("arm64: dts: rockchip: add SoQuartz CM4IO dts")
Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 .../boot/dts/rockchip/rk3566-soquartz-cm4.dts | 18 +++++++------
 .../boot/dts/rockchip/rk3566-soquartz.dtsi    | 25 ++++++++++---------
 2 files changed, 24 insertions(+), 19 deletions(-)

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
index ce7165d7f1a1..f589a4fdaccb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
@@ -65,6 +65,17 @@ led_work: led-work {
 		};
 	};
 
+	nextrst_pin: nextrst-pin-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&nextrst_h>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-name = "nextrst";
+	};
+
 	sdio_pwrseq: sdio-pwrseq {
 		status = "okay";
 		compatible = "mmc-pwrseq-simple";
@@ -104,16 +115,6 @@ vcc3v3_sys: vcc3v3-sys-regulator {
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
@@ -539,8 +540,8 @@ wifi_enable_h: wifi-enable-h {
 		};
 	};
 
-	sdmmc-pwr {
-		sdmmc_pwr_h: sdmmc-pwr-h {
+	nextrst {
+		nextrst_h: nextrst-h {
 			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
-- 
2.40.0


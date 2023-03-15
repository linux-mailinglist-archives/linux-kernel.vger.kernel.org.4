Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41B06BBF05
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCOV1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjCOV1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:27:30 -0400
Received: from out-34.mta1.migadu.com (out-34.mta1.migadu.com [95.215.58.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2251CBCA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:27:26 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1678915645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o4U7vhI7AzOOCPrYusMabXmVnj9q7shWGJQaNzRGVKM=;
        b=a7vxMzHO/etaU3bPz4bHothCDgqXhFcwEn60w4q8KqKIsajyOcE54IBRNQ+kJ7ZVG9bmXe
        Hh9eNVkGzDf1bXo1sF9Rk/JjPMZpSrq7reUXM9BTM1oqcSkHXgqHhrJAhUhU9XmAuup/L/
        n3JFqDU/pj2eHZOI0KmBa0PATDzxvW0=
From:   Henrik Grimler <henrik@grimler.se>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, m.szyprowski@samsung.com,
        jenneron@protonmail.com, markuss.broks@gmail.com,
        martin.juecker@gmail.com, virag.david003@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH v4 1/2] ARM: dts: exynos: replace mshc0 alias with mmc-ddr-1_8v property
Date:   Wed, 15 Mar 2023 22:26:43 +0100
Message-Id: <20230315212644.15764-2-henrik@grimler.se>
In-Reply-To: <20230315212644.15764-1-henrik@grimler.se>
References: <20230315212644.15764-1-henrik@grimler.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the mshc0 alias has been necessary so that
MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA are set for mshc_0/mmc_0.
However, these capabilities should be described in the device tree so
that we do not have to rely on the alias.

The property mmc-ddr-1_8v replaces MMC_CAP_1_8V_DDR, while bus_width =
<8>, which is already set for all the mshc0/mmc0 nodes, replaces
MMC_CAP_8_BIT_DATA.

Also drop other mshc aliases as they are not needed.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---

Changes since v3:
* Drop attempt at node sorting/cleaning
* Move two mmc alias additions to the other patch
* Update commit message

Changes since v2:
* Set mmc-ddr-1_8v in device trees for mshc_0/mmc_0

 arch/arm/boot/dts/exynos3250-artik5.dtsi            | 1 +
 arch/arm/boot/dts/exynos3250-monk.dts               | 1 +
 arch/arm/boot/dts/exynos3250-rinato.dts             | 1 +
 arch/arm/boot/dts/exynos4210-i9100.dts              | 1 +
 arch/arm/boot/dts/exynos4210-origen.dts             | 1 +
 arch/arm/boot/dts/exynos4210-trats.dts              | 1 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts     | 1 +
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi     | 1 +
 arch/arm/boot/dts/exynos4412-midas.dtsi             | 1 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi     | 1 +
 arch/arm/boot/dts/exynos4412-origen.dts             | 1 +
 arch/arm/boot/dts/exynos4412-p4note.dtsi            | 1 +
 arch/arm/boot/dts/exynos4412.dtsi                   | 1 -
 arch/arm/boot/dts/exynos5250-arndale.dts            | 1 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts           | 1 +
 arch/arm/boot/dts/exynos5250-snow-common.dtsi       | 1 +
 arch/arm/boot/dts/exynos5250-spring.dts             | 1 +
 arch/arm/boot/dts/exynos5250.dtsi                   | 4 ----
 arch/arm/boot/dts/exynos5260-xyref5260.dts          | 1 +
 arch/arm/boot/dts/exynos5410-odroidxu.dts           | 1 +
 arch/arm/boot/dts/exynos5410-smdk5410.dts           | 1 +
 arch/arm/boot/dts/exynos5420-arndale-octa.dts       | 1 +
 arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi | 1 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts          | 1 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts           | 1 +
 arch/arm/boot/dts/exynos5420.dtsi                   | 3 ---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi  | 1 +
 arch/arm/boot/dts/exynos5422-samsung-k3g.dts        | 1 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts           | 1 +
 29 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
index 0ac3f284fbb8..b81e1a9df126 100644
--- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
+++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
@@ -321,6 +321,7 @@ &mshc_0 {
 	vmmc-supply = <&ldo12_reg>;
 	clock-frequency = <100000000>;
 	max-frequency = <100000000>;
+	mmc-ddr-1_8v;
 	samsung,dw-mshc-ciu-div = <1>;
 	samsung,dw-mshc-sdr-timing = <0 1>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index 80d90fe7fad1..861c26824d4f 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -443,6 +443,7 @@ &mshc_0 {
 	vmmc-supply = <&vemmc_reg>;
 	clock-frequency = <100000000>;
 	max-frequency = <100000000>;
+	mmc-ddr-1_8v;
 	samsung,dw-mshc-ciu-div = <1>;
 	samsung,dw-mshc-sdr-timing = <0 1>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 1f9cba0607e1..a252a5f667eb 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -624,6 +624,7 @@ &mshc_0 {
 	vmmc-supply = <&ldo12_reg>;
 	clock-frequency = <100000000>;
 	max-frequency = <100000000>;
+	mmc-ddr-1_8v;
 	samsung,dw-mshc-ciu-div = <1>;
 	samsung,dw-mshc-sdr-timing = <0 1>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
index bba85011ecc9..a370a5fa20d8 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -776,6 +776,7 @@ &sdhci_0 {
 	status = "okay";
 
 	bus-width = <8>;
+	mmc-ddr-1_8v;
 	non-removable;
 	vmmc-supply = <&vemmc_reg>;
 
diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 1103e7f92b57..d8dd13ce29e1 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -326,6 +326,7 @@ max8997_irq: max8997-irq-pins {
 
 &sdhci_0 {
 	bus-width = <4>;
+	mmc-ddr-1_8v;
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_cd>;
 	pinctrl-names = "default";
 	vmmc-supply = <&mmc_reg>;
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index b8e9dd23fc51..d757228a5676 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -491,6 +491,7 @@ &rtc {
 
 &sdhci_0 {
 	bus-width = <8>;
+	mmc-ddr-1_8v;
 	non-removable;
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus8>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 140abfb38e1d..57dbed908131 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -584,6 +584,7 @@ &rtc {
 
 &sdhci_0 {
 	bus-width = <8>;
+	mmc-ddr-1_8v;
 	non-removable;
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus8>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
index e42e39dc0e40..ca8d42b2ce3b 100644
--- a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
+++ b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
@@ -476,6 +476,7 @@ &mshc_0 {
 	vmmc-supply = <&buck9_reg>;
 	broken-cd;
 	card-detect-delay = <200>;
+	mmc-ddr-1_8v;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <2 3>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index 3be48de5c130..82aed59cba7c 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -977,6 +977,7 @@ &mshc_0 {
 	samsung,dw-mshc-ciu-div = <0>;
 	samsung,dw-mshc-sdr-timing = <2 3>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
+	mmc-ddr-1_8v;
 	pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
 	pinctrl-names = "default";
 	status = "okay";
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 7c2780d3e37c..25e082fda955 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -533,6 +533,7 @@ &mshc_0 {
 
 	broken-cd;
 	card-detect-delay = <200>;
+	mmc-ddr-1_8v;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <2 3>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index ea9fd284386d..f6cebf73b839 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -498,6 +498,7 @@ &mshc_0 {
 
 	broken-cd;
 	card-detect-delay = <200>;
+	mmc-ddr-1_8v;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <2 3>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/exynos4412-p4note.dtsi
index 317e248f354b..9052b3ebb3e8 100644
--- a/arch/arm/boot/dts/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/exynos4412-p4note.dtsi
@@ -693,6 +693,7 @@ &mshc_0 {
 	samsung,dw-mshc-ciu-div = <0>;
 	samsung,dw-mshc-sdr-timing = <2 3>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
+	mmc-ddr-1_8v;
 	pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
 	pinctrl-names = "default";
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 7fa3e5fd6801..82a36fb5ee8b 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -28,7 +28,6 @@ aliases {
 		pinctrl3 = &pinctrl_3;
 		fimc-lite0 = &fimc_lite_0;
 		fimc-lite1 = &fimc_lite_1;
-		mshc0 = &mshc_0;
 	};
 
 	bus_acp: bus-acp {
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index c03bb436bfed..8f01337bb291 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -589,6 +589,7 @@ &mmc_0 {
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
 };
 
 &mmc_2 {
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 831b3494bd46..f7d4017e1ede 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -350,6 +350,7 @@ &mmc_0 {
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
 };
 
 &mmc_2 {
diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index 3d84b9c6dea3..dea2dc818578 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -549,6 +549,7 @@ &mmc_0 {
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
 };
 
 /* uSD card */
diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index 5eca10ecd550..8980cdbdcb3b 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -431,6 +431,7 @@ &mmc_0 {
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
 };
 
 /*
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 89c8665ac9aa..1a4c6c028d03 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -30,10 +30,6 @@ aliases {
 		gsc1 = &gsc_1;
 		gsc2 = &gsc_2;
 		gsc3 = &gsc_3;
-		mshc0 = &mmc_0;
-		mshc1 = &mmc_1;
-		mshc2 = &mmc_2;
-		mshc3 = &mmc_3;
 		i2c4 = &i2c_4;
 		i2c5 = &i2c_5;
 		i2c6 = &i2c_6;
diff --git a/arch/arm/boot/dts/exynos5260-xyref5260.dts b/arch/arm/boot/dts/exynos5260-xyref5260.dts
index 387b8494f18f..0fd728bc0b75 100644
--- a/arch/arm/boot/dts/exynos5260-xyref5260.dts
+++ b/arch/arm/boot/dts/exynos5260-xyref5260.dts
@@ -89,6 +89,7 @@ &mmc_0 {
 	cap-mmc-highspeed;
 	mmc-hs200-1_8v;
 	card-detect-delay = <200>;
+	mmc-ddr-1_8v;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <0 4>;
 	samsung,dw-mshc-ddr-timing = <0 2>;
diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index 6ddd1dd2fb0b..1ed73f3b4ac0 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -513,6 +513,7 @@ &mmc_0 {
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 	vmmc-supply = <&ldo20_reg>;
 	vqmmc-supply = <&ldo11_reg>;
diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
index b8f953c41c73..b4a74f9cf319 100644
--- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
+++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
@@ -61,6 +61,7 @@ &mmc_0 {
 	cap-mmc-highspeed;
 	broken-cd;
 	card-detect-delay = <200>;
+	mmc-ddr-1_8v;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <2 3>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 55b7759682a9..5ed55a5b0c67 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -778,6 +778,7 @@ &mmc_0 {
 	status = "okay";
 	non-removable;
 	card-detect-delay = <200>;
+	mmc-ddr-1_8v;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <0 4>;
 	samsung,dw-mshc-ddr-timing = <0 2>;
diff --git a/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi b/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
index 63675fe189cd..6a51cb14b58a 100644
--- a/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
+++ b/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
@@ -604,6 +604,7 @@ &mmc_0 {
 	bus-width = <8>;
 	cap-mmc-highspeed;
 	card-detect-delay = <200>;
+	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 	non-removable;
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 9e2123470cad..df863b909ff7 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -722,6 +722,7 @@ &mixer {
 /* eMMC flash */
 &mmc_0 {
 	status = "okay";
+	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 	cap-mmc-highspeed;
 	non-removable;
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 4d7b6d9008a7..0a9371bec3e0 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -355,6 +355,7 @@ &mmc_0 {
 	status = "okay";
 	broken-cd;
 	card-detect-delay = <200>;
+	mmc-ddr-1_8v;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <0 4>;
 	samsung,dw-mshc-ddr-timing = <0 2>;
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 17dec11fb773..dd291f1199f2 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -19,9 +19,6 @@ / {
 	compatible = "samsung,exynos5420", "samsung,exynos5";
 
 	aliases {
-		mshc0 = &mmc_0;
-		mshc1 = &mmc_1;
-		mshc2 = &mmc_2;
 		pinctrl0 = &pinctrl_0;
 		pinctrl1 = &pinctrl_1;
 		pinctrl2 = &pinctrl_2;
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index e6e7e2ff2a26..d1b8e59e2daf 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -472,6 +472,7 @@ &mmc_0 {
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd &sd0_rclk>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 	mmc-hs400-1_8v;
 	max-frequency = <200000000>;
diff --git a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
index df41723d56d4..13134592c199 100644
--- a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
+++ b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
@@ -597,6 +597,7 @@ rmi4-f12@12 {
 /* eMMC flash */
 &mmc_0 {
 	status = "okay";
+	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 	cap-mmc-highspeed;
 	non-removable;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 0ebcb66c6319..37af8fbd215c 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -703,6 +703,7 @@ &mixer {
 /* eMMC flash */
 &mmc_0 {
 	status = "okay";
+	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 	mmc-hs400-1_8v;
 	cap-mmc-highspeed;
-- 
2.30.2


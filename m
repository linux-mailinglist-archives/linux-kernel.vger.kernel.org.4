Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36596A4B63
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjB0Tn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjB0Tn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:43:58 -0500
Received: from out-18.mta1.migadu.com (out-18.mta1.migadu.com [IPv6:2001:41d0:203:375::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F3325E1C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:43:52 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1677527030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kwYNiTz33EJg9574JHtGenYFIBq+DbWwARaMexmbAQQ=;
        b=pB9v6+DXDdjD17NborCpGRnZADcI+wUjIYZ3mirvbhFY0BuFDPeAqF6cke8hybGbAIspW/
        LIex3m+jm8h+OUnu5ODsXXmgzfsMnBLxbnf1OudiqmUMZsk4UpGzg7OGLM+ezKOqmAr5aU
        U9OX57M9s2ilCl5CdYWmuE1dwqZ4XrM=
From:   Henrik Grimler <henrik@grimler.se>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, m.szyprowski@samsung.com,
        jenneron@protonmail.com, markuss.broks@gmail.com,
        martin.juecker@gmail.com, virag.david003@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH v3 1/2] ARM: dts: exynos: replace mshc0 alias with mmc-ddr-1_8v property
Date:   Mon, 27 Feb 2023 20:38:18 +0100
Message-Id: <20230227193819.30133-2-henrik@grimler.se>
In-Reply-To: <20230227193819.30133-1-henrik@grimler.se>
References: <20230227193819.30133-1-henrik@grimler.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Also cleanup and sort (but keep status property at top) some of the
nodes while we are modifying them.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
Changes since v2:
* Set mmc-ddr-1_8v in device trees for mshc_0/mmc_0

 arch/arm/boot/dts/exynos3250-artik5.dtsi      | 15 ++++++-------
 arch/arm/boot/dts/exynos3250-monk.dts         | 19 ++++++++---------
 arch/arm/boot/dts/exynos3250-rinato.dts       | 21 ++++++++-----------
 arch/arm/boot/dts/exynos3250.dtsi             |  3 ---
 arch/arm/boot/dts/exynos4210-i9100.dts        |  5 ++---
 arch/arm/boot/dts/exynos4210-origen.dts       |  3 ++-
 arch/arm/boot/dts/exynos4210-trats.dts        |  3 ++-
 .../boot/dts/exynos4210-universal_c210.dts    |  3 ++-
 arch/arm/boot/dts/exynos4412-itop-elite.dts   |  4 ++++
 .../boot/dts/exynos4412-itop-scp-core.dtsi    | 17 +++++++++------
 arch/arm/boot/dts/exynos4412-midas.dtsi       | 17 ++++++++-------
 .../boot/dts/exynos4412-odroid-common.dtsi    | 16 +++++++-------
 arch/arm/boot/dts/exynos4412-origen.dts       | 12 +++++------
 arch/arm/boot/dts/exynos4412-p4note.dtsi      | 17 ++++++++-------
 arch/arm/boot/dts/exynos4412.dtsi             |  1 -
 arch/arm/boot/dts/exynos5250-arndale.dts      |  1 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts     |  1 +
 arch/arm/boot/dts/exynos5250-snow-common.dtsi |  1 +
 arch/arm/boot/dts/exynos5250-spring.dts       |  1 +
 arch/arm/boot/dts/exynos5250.dtsi             |  4 ----
 arch/arm/boot/dts/exynos5260-xyref5260.dts    | 11 +++++-----
 arch/arm/boot/dts/exynos5410-odroidxu.dts     |  1 +
 arch/arm/boot/dts/exynos5410-smdk5410.dts     |  1 +
 arch/arm/boot/dts/exynos5420-arndale-octa.dts |  1 +
 .../dts/exynos5420-galaxy-tab-common.dtsi     |  1 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts    |  1 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts     |  1 +
 arch/arm/boot/dts/exynos5420.dtsi             |  3 ---
 .../boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
 arch/arm/boot/dts/exynos5422-samsung-k3g.dts  |  1 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |  1 +
 31 files changed, 100 insertions(+), 87 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
index 0ac3f284fbb8..794cbf579316 100644
--- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
+++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
@@ -315,19 +315,20 @@ buck5_reg: BUCK5 {
 };
 
 &mshc_0 {
-	non-removable;
+	status = "okay";
+	bus-width = <8>;
 	cap-mmc-highspeed;
 	card-detect-delay = <200>;
-	vmmc-supply = <&ldo12_reg>;
 	clock-frequency = <100000000>;
 	max-frequency = <100000000>;
+	mmc-ddr-1_8v;
+	non-removable;
+	pinctrl-0 = <&sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
+	pinctrl-names = "default";
 	samsung,dw-mshc-ciu-div = <1>;
-	samsung,dw-mshc-sdr-timing = <0 1>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
-	bus-width = <8>;
-	status = "okay";
+	samsung,dw-mshc-sdr-timing = <0 1>;
+	vmmc-supply = <&ldo12_reg>;
 };
 
 &mshc_1 {
diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index 80d90fe7fad1..2aaeb6f8140b 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -433,23 +433,22 @@ &i2s2 {
 };
 
 &mshc_0 {
-	#address-cells = <1>;
-	#size-cells = <0>;
+	status = "okay";
 	broken-cd;
-	non-removable;
+	bus-width = <8>;
 	cap-mmc-highspeed;
-	mmc-hs200-1_8v;
 	card-detect-delay = <200>;
-	vmmc-supply = <&vemmc_reg>;
 	clock-frequency = <100000000>;
 	max-frequency = <100000000>;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	non-removable;
+	pinctrl-0 = <&sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
+	pinctrl-names = "default";
 	samsung,dw-mshc-ciu-div = <1>;
-	samsung,dw-mshc-sdr-timing = <0 1>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
-	bus-width = <8>;
-	status = "okay";
+	samsung,dw-mshc-sdr-timing = <0 1>;
+	vmmc-supply = <&vemmc_reg>;
 };
 
 &serial_0 {
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 1f9cba0607e1..199c9bffa84e 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -616,29 +616,26 @@ &jpeg {
 };
 
 &mshc_0 {
+	status = "okay";
 	broken-cd;
-	non-removable;
+	bus-width = <8>;
 	cap-mmc-highspeed;
-	mmc-hs200-1_8v;
 	card-detect-delay = <200>;
-	vmmc-supply = <&ldo12_reg>;
 	clock-frequency = <100000000>;
 	max-frequency = <100000000>;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	non-removable;
+	pinctrl-0 = <&sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
+	pinctrl-names = "default";
 	samsung,dw-mshc-ciu-div = <1>;
-	samsung,dw-mshc-sdr-timing = <0 1>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
-	bus-width = <8>;
-	status = "okay";
+	samsung,dw-mshc-sdr-timing = <0 1>;
+	vmmc-supply = <&ldo12_reg>;
 };
 
 &mshc_1 {
 	status = "okay";
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-
 	non-removable;
 	cap-sd-highspeed;
 	cap-sdio-irq;
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 28bb2ce8ccf7..21ac47b209ec 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -28,9 +28,6 @@ / {
 	aliases {
 		pinctrl0 = &pinctrl_0;
 		pinctrl1 = &pinctrl_1;
-		mshc0 = &mshc_0;
-		mshc1 = &mshc_1;
-		mshc2 = &mshc_2;
 		spi0 = &spi_0;
 		spi1 = &spi_1;
 		i2c0 = &i2c_0;
diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
index bba85011ecc9..69f538f79c65 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -774,13 +774,12 @@ &rtc {
 
 &sdhci_0 {
 	status = "okay";
-
 	bus-width = <8>;
+	mmc-ddr-1_8v;
 	non-removable;
-	vmmc-supply = <&vemmc_reg>;
-
 	pinctrl-0 = <&sd0_clk>, <&sd0_cmd>, <&sd0_bus8>;
 	pinctrl-names = "default";
+	vmmc-supply = <&vemmc_reg>;
 };
 
 &sdhci_2 {
diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 1103e7f92b57..8ce648e1a7f1 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -325,11 +325,12 @@ max8997_irq: max8997-irq-pins {
 };
 
 &sdhci_0 {
+	status = "okay";
 	bus-width = <4>;
+	mmc-ddr-1_8v;
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_cd>;
 	pinctrl-names = "default";
 	vmmc-supply = <&mmc_reg>;
-	status = "okay";
 };
 
 &sdhci_2 {
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index b8e9dd23fc51..88ca2ae405d6 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -490,12 +490,13 @@ &rtc {
 };
 
 &sdhci_0 {
+	status = "okay";
 	bus-width = <8>;
+	mmc-ddr-1_8v;
 	non-removable;
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus8>;
 	pinctrl-names = "default";
 	vmmc-supply = <&vemmc_reg>;
-	status = "okay";
 };
 
 &sdhci_2 {
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 62bf335d5bed..2b8c4d6e77ca 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -583,12 +583,13 @@ &rtc {
 };
 
 &sdhci_0 {
+	status = "okay";
 	bus-width = <8>;
+	mmc-ddr-1_8v;
 	non-removable;
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus8>;
 	pinctrl-names = "default";
 	vmmc-supply = <&vemmc_reg>;
-	status = "okay";
 };
 
 &sdhci_2 {
diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
index b596e997e451..6a2c3ea4d477 100644
--- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
+++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
@@ -20,6 +20,10 @@ / {
 	model = "TOPEET iTop 4412 Elite board based on Exynos4412";
 	compatible = "topeet,itop4412-elite", "samsung,exynos4412", "samsung,exynos4";
 
+	aliases {
+		mmc2 = &sdhci_2;
+	};
+
 	chosen {
 		bootargs = "root=/dev/mmcblk0p2 rw rootfstype=ext4 rootdelay=1 rootwait";
 		stdout-path = "serial2:115200n8";
diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
index e42e39dc0e40..8c2639948f66 100644
--- a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
+++ b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
@@ -23,6 +23,10 @@ memory@40000000 {
 		reg = <0x40000000 0x40000000>;
 	};
 
+	aliases {
+		mmc0 = &mshc_0;
+	};
+
 	firmware@203f000 {
 		compatible = "samsung,secure-firmware";
 		reg = <0x0203f000 0x1000>;
@@ -470,17 +474,18 @@ &mfc {
 };
 
 &mshc_0 {
-	pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
-	pinctrl-names = "default";
 	status = "okay";
-	vmmc-supply = <&buck9_reg>;
 	broken-cd;
+	bus-width = <8>;
+	cap-mmc-highspeed;
 	card-detect-delay = <200>;
+	mmc-ddr-1_8v;
+	pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
+	pinctrl-names = "default";
 	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
-	bus-width = <8>;
-	cap-mmc-highspeed;
+	samsung,dw-mshc-sdr-timing = <2 3>;
+	vmmc-supply = <&buck9_reg>;
 };
 
 &pinctrl_1 {
diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index 525f945c4b91..6ea44e57f216 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -971,19 +971,20 @@ &mixer {
 };
 
 &mshc_0 {
+	status = "okay";
 	broken-cd;
-	non-removable;
+	bus-width = <8>;
+	cap-mmc-highspeed;
 	card-detect-delay = <200>;
-	vmmc-supply = <&ldo22_reg>;
 	clock-frequency = <400000000>;
-	samsung,dw-mshc-ciu-div = <0>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
-	samsung,dw-mshc-ddr-timing = <1 2>;
+	mmc-ddr-1_8v;
+	non-removable;
 	pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
 	pinctrl-names = "default";
-	status = "okay";
-	bus-width = <8>;
-	cap-mmc-highspeed;
+	samsung,dw-mshc-ciu-div = <0>;
+	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <2 3>;
+	vmmc-supply = <&ldo22_reg>;
 };
 
 &pmu_system_controller {
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 7c2780d3e37c..1a8502d81274 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -525,19 +525,19 @@ &mixer {
 };
 
 &mshc_0 {
-	pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
-	pinctrl-names = "default";
-	vmmc-supply = <&ldo20_reg>;
-	mmc-pwrseq = <&emmc_pwrseq>;
 	status = "okay";
-
 	broken-cd;
+	bus-width = <8>;
+	cap-mmc-highspeed;
 	card-detect-delay = <200>;
+	mmc-ddr-1_8v;
+	mmc-pwrseq = <&emmc_pwrseq>;
+	pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
+	pinctrl-names = "default";
 	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
-	bus-width = <8>;
-	cap-mmc-highspeed;
+	samsung,dw-mshc-sdr-timing = <2 3>;
+	vmmc-supply = <&ldo20_reg>;
 };
 
 &rtc {
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index ea9fd284386d..878d7cf85f9d 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -492,17 +492,17 @@ key-enter {
 };
 
 &mshc_0 {
-	pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
-	pinctrl-names = "default";
 	status = "okay";
-
 	broken-cd;
+	bus-width = <8>;
+	cap-mmc-highspeed;
 	card-detect-delay = <200>;
+	mmc-ddr-1_8v;
+	pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
+	pinctrl-names = "default";
 	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
-	bus-width = <8>;
-	cap-mmc-highspeed;
+	samsung,dw-mshc-sdr-timing = <2 3>;
 };
 
 &pinctrl_1 {
diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/exynos4412-p4note.dtsi
index 3e05a49f29ff..e598f48b091a 100644
--- a/arch/arm/boot/dts/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/exynos4412-p4note.dtsi
@@ -688,19 +688,20 @@ regulator-state-mem {
 };
 
 &mshc_0 {
+	status = "okay";
 	broken-cd;
-	non-removable;
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
 	card-detect-delay = <200>;
 	clock-frequency = <400000000>;
-	samsung,dw-mshc-ciu-div = <0>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
-	samsung,dw-mshc-ddr-timing = <1 2>;
+	mmc-ddr-1_8v;
+	non-removable;
 	pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
 	pinctrl-names = "default";
-	bus-width = <4>;
-	cap-mmc-highspeed;
-	cap-sd-highspeed;
-	status = "okay";
+	samsung,dw-mshc-ciu-div = <0>;
+	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <2 3>;
 };
 
 &pinctrl_0 {
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 11f9dd94b6b3..0f9b4ee96023 100644
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
index 2e3da5670bc2..6f010e439141 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -586,6 +586,7 @@ &mmc_0 {
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
index a5db4ac213d5..05d4ce8e58e5 100644
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
index 387b8494f18f..7b1e414fb2a6 100644
--- a/arch/arm/boot/dts/exynos5260-xyref5260.dts
+++ b/arch/arm/boot/dts/exynos5260-xyref5260.dts
@@ -86,15 +86,16 @@ &uart3 {
 &mmc_0 {
 	status = "okay";
 	broken-cd;
+	bus-width = <8>;
 	cap-mmc-highspeed;
-	mmc-hs200-1_8v;
 	card-detect-delay = <200>;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	pinctrl-0 = <&sd0_rdqs &sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
+	pinctrl-names = "default";
 	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <0 4>;
 	samsung,dw-mshc-ddr-timing = <0 2>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sd0_rdqs &sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
-	bus-width = <8>;
+	samsung,dw-mshc-sdr-timing = <0 4>;
 };
 
 &mmc_2 {
diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index 232561620da2..0e14ce5c6ce3 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -514,6 +514,7 @@ &mmc_0 {
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
index 13d7be236a23..3be72774d506 100644
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
index a6961ff24030..725c315d70cb 100644
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


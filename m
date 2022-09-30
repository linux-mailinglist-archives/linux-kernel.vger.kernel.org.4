Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3FD5F1224
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiI3TLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiI3TLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:11:01 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8283B1191AB
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:10:59 -0700 (PDT)
Received: from localhost.localdomain (95.49.31.201.neoplus.adsl.tpnet.pl [95.49.31.201])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id DC0C42016F;
        Fri, 30 Sep 2022 21:10:55 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] arm64: dts: qcom: sdm845-tama: Add display nodes
Date:   Fri, 30 Sep 2022 21:10:42 +0200
Message-Id: <20220930191049.123256-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930191049.123256-1-konrad.dybcio@somainline.org>
References: <20220930191049.123256-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required nodes to support display on XZ2/XZ2c. XZ3 has a
different power rail setup and needs to be handled separately.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../qcom/sdm845-sony-xperia-tama-akari.dts    |  4 +
 .../qcom/sdm845-sony-xperia-tama-akatsuki.dts | 44 ++++++++-
 .../qcom/sdm845-sony-xperia-tama-apollo.dts   |  6 ++
 .../dts/qcom/sdm845-sony-xperia-tama.dtsi     | 96 +++++++++++++++++++
 4 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
index 34f84f1f1eb4..d97b7f1e7140 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
@@ -11,3 +11,7 @@ / {
 	model = "Sony Xperia XZ2";
 	compatible = "sony,akari-row", "qcom,sdm845";
 };
+
+&panel {
+	compatible = "sony,td4353-jdi-tama";
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
index 2f5e12deaada..2a16305ac5da 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
@@ -10,9 +10,51 @@
 / {
 	model = "Sony Xperia XZ3";
 	compatible = "sony,akatsuki-row", "qcom,sdm845";
+
+	/* Fixed DCDC for the OLED panel */
+	ts_vddio_supply: ts-vddio-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "ts_vddio";
+
+		regulator-min-microvolt = <1840000>;
+		regulator-max-microvolt = <1840000>;
+
+		gpio = <&tlmm 133 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
+	};
+};
+
+&ibb {
+	status = "disabled";
+};
+
+&lab {
+	status = "disabled";
+};
+
+&panel {
+	/* Akatsuki uses an OLED panel. */
+	/delete-property/ backlight;
+	/delete-property/ vsp-supply;
+	/delete-property/ vsn-supply;
+	/delete-property/ treset-gpios;
+};
+
+&pmi8998_wled {
+	status = "disabled";
+};
+
+&tlmm {
+	ts_vddio_en: ts-vddio-en {
+		pins = "gpio133";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-high;
+	};
 };
 
-/* For the future: WLED + LAB/IBB/OLEDB are not used on Akatsuki */
 &vreg_l14a_1p8 {
 	regulator-min-microvolt = <1840000>;
 	regulator-max-microvolt = <1840000>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts
index c9e62c72f60e..cd056f78070f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts
@@ -11,3 +11,9 @@ / {
 	model = "Sony Xperia XZ2 Compact";
 	compatible = "sony,apollo-row", "qcom,sdm845";
 };
+
+&panel {
+	compatible = "sony,td4353-jdi-tama";
+	height-mm = <112>;
+	width-mm = <56>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index 51ee42e3c995..ac8eb59ed010 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -326,6 +326,46 @@ vreg_s3c_0p6: smps3 {
 	};
 };
 
+&dsi0 {
+	vdda-supply = <&vreg_l26a_1p2>;
+	status = "okay";
+
+	panel: panel@0 {
+		/* The compatible is assigned in device DTs. */
+		reg = <0>;
+
+		backlight = <&pmi8998_wled>;
+		vddio-supply = <&vreg_l14a_1p8>;
+		vsp-supply = <&lab>;
+		vsn-supply = <&ibb>;
+		panel-reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+		touch-reset-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&sde_dsi_active &sde_te_active_sleep>;
+		pinctrl-1 = <&sde_dsi_sleep &sde_te_active_sleep>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&dsi0_out>;
+			};
+		};
+	};
+};
+
+&dsi0_out {
+	remote-endpoint = <&panel_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&dsi0_phy {
+	vdds-supply = <&vreg_l1a_0p9>;
+	status = "okay";
+};
+
 &gcc {
 	protected-clocks = <GCC_QSPI_CORE_CLK>,
 			<GCC_QSPI_CORE_CLK_SRC>,
@@ -358,6 +398,41 @@ &i2c14 {
 	/* AMS TCS3490 RGB+IR color sensor @ 72 */
 };
 
+&ibb {
+	qcom,discharge-resistor-kohms = <300>;
+	regulator-min-microvolt = <5500000>;
+	regulator-max-microvolt = <5700000>;
+	regulator-min-microamp = <0>;
+	regulator-max-microamp = <800000>;
+	regulator-over-current-protection;
+	regulator-soft-start;
+	regulator-pull-down;
+};
+
+&lab {
+	regulator-min-microvolt = <5500000>;
+	regulator-max-microvolt = <5700000>;
+	regulator-min-microamp = <200000>;
+	regulator-max-microamp = <200000>;
+	regulator-over-current-protection;
+	regulator-soft-start;
+	regulator-pull-down;
+};
+
+&mdss {
+	status = "okay";
+};
+
+&pmi8998_wled {
+	default-brightness = <800>;
+	qcom,switching-freq = <800>;
+	qcom,ovp-millivolt = <29600>;
+	qcom,current-boost-limit = <970>;
+	qcom,current-limit-microamp = <20000>;
+	qcom,enabled-strings = <0 1 2 3>;
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -401,6 +476,27 @@ data {
 			bias-pull-up;
 		};
 	};
+
+	sde_dsi_active: sde-dsi-active-state {
+		pins = "gpio6", "gpio52";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	sde_dsi_sleep: sde-dsi-sleep-state {
+		pins = "gpio6", "gpio52";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	sde_te_active_sleep: sde-te-active-sleep-state {
+		pins = "gpio10";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
 };
 
 &uart6 {
-- 
2.37.3


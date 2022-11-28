Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469EC63AEB2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiK1RRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiK1RRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:17:01 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6183E25E87;
        Mon, 28 Nov 2022 09:16:59 -0800 (PST)
Received: from g550jk.arnhem.chello.nl (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 80792D066B;
        Mon, 28 Nov 2022 17:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1669655787; bh=HnZTBAis9/V2pQaRAhM1SxpfMceGAhfR3jTgJsiJW6E=;
        h=From:To:Cc:Subject:Date;
        b=a+rUR+StDmkX/XDkBBg6NH9zn9j1H3wu9io1GkKuDceZ66RExX2w+7vKAtgD51zFo
         n9PjpY0LHujYcT1163lhXP02dLD5iQ3nZvdn8RYBs8oa+H6yo/eshFsS87UL+rMZ/T
         6BzkT0ag6DdkU9AoDjyHDNXnvx8Wx24PoQu6mCVM=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom: msm8974: clean up USB nodes
Date:   Mon, 28 Nov 2022 18:16:23 +0100
Message-Id: <20221128171623.825572-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename "otg" label to "usb" to group it with other usb nodes and also
because "usb" makes more sense for a USB controller.

And now we can also better use the usb_hsX_phy labels instead of having
the ulpi -> phy@X structure in every dts.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../arm/boot/dts/qcom-apq8074-dragonboard.dts | 42 ++++++++--------
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 48 +++++++++----------
 .../dts/qcom-msm8974-sony-xperia-rhine.dtsi   | 48 +++++++++----------
 arch/arm/boot/dts/qcom-msm8974.dtsi           |  6 +--
 .../dts/qcom-msm8974pro-fairphone-fp2.dts     | 48 +++++++++----------
 .../boot/dts/qcom-msm8974pro-samsung-klte.dts | 42 ++++++++--------
 ...-msm8974pro-sony-xperia-shinano-castor.dts | 48 +++++++++----------
 7 files changed, 135 insertions(+), 147 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index 438fe86b3d4d..1345df7cbd00 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -35,28 +35,6 @@ eeprom: eeprom@52 {
 	};
 };
 
-&otg {
-	status = "okay";
-
-	phys = <&usb_hs2_phy>;
-	phy-select = <&tcsr 0xb000 1>;
-	extcon = <&smbb>, <&usb_id>;
-	vbus-supply = <&chg_otg>;
-	hnp-disable;
-	srp-disable;
-	adp-disable;
-
-	ulpi {
-		phy@b {
-			status = "okay";
-			v3p3-supply = <&pm8941_l24>;
-			v1p8-supply = <&pm8941_l6>;
-			extcon = <&smbb>;
-			qcom,init-seq = /bits/ 8 <0x1 0x63>;
-		};
-	};
-};
-
 &rpm_requests {
 	regulators-0 {
 		compatible = "qcom,rpm-pm8841-regulators";
@@ -307,3 +285,23 @@ cd-pins {
 		};
 	};
 };
+
+&usb {
+	status = "okay";
+
+	phys = <&usb_hs2_phy>;
+	phy-select = <&tcsr 0xb000 1>;
+	extcon = <&smbb>, <&usb_id>;
+	vbus-supply = <&chg_otg>;
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+};
+
+&usb_hs2_phy {
+	status = "okay";
+	v3p3-supply = <&pm8941_l24>;
+	v1p8-supply = <&pm8941_l6>;
+	extcon = <&smbb>;
+	qcom,init-seq = /bits/ 8 <0x1 0x63>;
+};
diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 9cc453987d0e..280e63e3ebf2 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -248,31 +248,6 @@ &mdss {
 	status = "okay";
 };
 
-&otg {
-	status = "okay";
-
-	phys = <&usb_hs1_phy>;
-	phy-select = <&tcsr 0xb000 0>;
-
-	extcon = <&charger>, <&usb_id>;
-	vbus-supply = <&usb_otg_vbus>;
-
-	hnp-disable;
-	srp-disable;
-	adp-disable;
-
-	ulpi {
-		phy@a {
-			status = "okay";
-
-			v1p8-supply = <&pm8941_l6>;
-			v3p3-supply = <&pm8941_l24>;
-
-			qcom,init-seq = /bits/ 8 <0x1 0x64>;
-		};
-	};
-};
-
 &pm8941_gpios {
 	gpio_keys_pin_a: gpio-keys-active-state {
 		pins = "gpio2", "gpio3";
@@ -652,3 +627,26 @@ shutdown-pins {
 		};
 	};
 };
+
+&usb {
+	status = "okay";
+
+	phys = <&usb_hs1_phy>;
+	phy-select = <&tcsr 0xb000 0>;
+
+	extcon = <&charger>, <&usb_id>;
+	vbus-supply = <&usb_otg_vbus>;
+
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+};
+
+&usb_hs1_phy {
+	status = "okay";
+
+	v1p8-supply = <&pm8941_l6>;
+	v3p3-supply = <&pm8941_l24>;
+
+	qcom,init-seq = /bits/ 8 <0x1 0x64>;
+};
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
index 00542bd555e8..1b683690a1ad 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
@@ -132,31 +132,6 @@ &blsp2_i2c5 {
 	/* sii8334 MHL HDMI bridge */
 };
 
-&otg {
-	status = "okay";
-
-	phys = <&usb_hs1_phy>;
-	phy-select = <&tcsr 0xb000 0>;
-	extcon = <&smbb>, <&usb_id>;
-	vbus-supply = <&chg_otg>;
-
-	hnp-disable;
-	srp-disable;
-	adp-disable;
-
-	ulpi {
-		phy@a {
-			status = "okay";
-
-			v1p8-supply = <&pm8941_l6>;
-			v3p3-supply = <&pm8941_l24>;
-
-			extcon = <&smbb>;
-			qcom,init-seq = /bits/ 8 <0x1 0x64>;
-		};
-	};
-};
-
 &pm8941_coincell {
 	status = "okay";
 	qcom,rset-ohms = <2100>;
@@ -485,3 +460,26 @@ cd-pins {
 		};
 	};
 };
+
+&usb {
+	status = "okay";
+
+	phys = <&usb_hs1_phy>;
+	phy-select = <&tcsr 0xb000 0>;
+	extcon = <&smbb>, <&usb_id>;
+	vbus-supply = <&chg_otg>;
+
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+};
+
+&usb_hs1_phy {
+	status = "okay";
+
+	v1p8-supply = <&pm8941_l6>;
+	v3p3-supply = <&pm8941_l24>;
+
+	extcon = <&smbb>;
+	qcom,init-seq = /bits/ 8 <0x1 0x64>;
+};
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index bdf1a4cca1c1..8d216a3c0851 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -653,7 +653,7 @@ blsp2_i2c6: i2c@f9968000 {
 			#size-cells = <0>;
 		};
 
-		otg: usb@f9a55000 {
+		usb: usb@f9a55000 {
 			compatible = "qcom,ci-hdrc";
 			reg = <0xf9a55000 0x200>,
 			      <0xf9a55200 0x200>;
@@ -679,7 +679,7 @@ usb_hs1_phy: phy@a {
 					#phy-cells = <0>;
 					clocks = <&xo_board>, <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
 					clock-names = "ref", "sleep";
-					resets = <&gcc GCC_USB2A_PHY_BCR>, <&otg 0>;
+					resets = <&gcc GCC_USB2A_PHY_BCR>, <&usb 0>;
 					reset-names = "phy", "por";
 					status = "disabled";
 				};
@@ -690,7 +690,7 @@ usb_hs2_phy: phy@b {
 					#phy-cells = <0>;
 					clocks = <&xo_board>, <&gcc GCC_USB2B_PHY_SLEEP_CLK>;
 					clock-names = "ref", "sleep";
-					resets = <&gcc GCC_USB2B_PHY_BCR>, <&otg 1>;
+					resets = <&gcc GCC_USB2B_PHY_BCR>, <&usb 1>;
 					reset-names = "phy", "por";
 					status = "disabled";
 				};
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
index 6523257815a0..f531d2679f6c 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
@@ -86,31 +86,6 @@ reboot-mode {
 	};
 };
 
-&otg {
-	status = "okay";
-
-	phys = <&usb_hs1_phy>;
-	phy-select = <&tcsr 0xb000 0>;
-	extcon = <&smbb>, <&usb_id>;
-	vbus-supply = <&chg_otg>;
-
-	hnp-disable;
-	srp-disable;
-	adp-disable;
-
-	ulpi {
-		phy@a {
-			status = "okay";
-
-			v1p8-supply = <&pm8941_l6>;
-			v3p3-supply = <&pm8941_l24>;
-
-			extcon = <&smbb>;
-			qcom,init-seq = /bits/ 8 <0x1 0x64>;
-		};
-	};
-};
-
 &pm8941_gpios {
 	gpio_keys_pin_a: gpio-keys-active-state {
 		pins = "gpio1", "gpio2", "gpio5";
@@ -463,3 +438,26 @@ fm-pins {
 		};
 	};
 };
+
+&usb {
+	status = "okay";
+
+	phys = <&usb_hs1_phy>;
+	phy-select = <&tcsr 0xb000 0>;
+	extcon = <&smbb>, <&usb_id>;
+	vbus-supply = <&chg_otg>;
+
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+};
+
+&usb_hs1_phy {
+	status = "okay";
+
+	v1p8-supply = <&pm8941_l6>;
+	v3p3-supply = <&pm8941_l24>;
+
+	extcon = <&smbb>;
+	qcom,init-seq = /bits/ 8 <0x1 0x64>;
+};
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
index 52ece17986e4..b9698ffb66ca 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
@@ -376,28 +376,6 @@ &mdss {
 	status = "okay";
 };
 
-&otg {
-	status = "okay";
-
-	phys = <&usb_hs1_phy>;
-	phy-select = <&tcsr 0xb000 0>;
-
-	hnp-disable;
-	srp-disable;
-	adp-disable;
-
-	ulpi {
-		phy@a {
-			status = "okay";
-
-			v1p8-supply = <&pma8084_l6>;
-			v3p3-supply = <&pma8084_l24>;
-
-			qcom,init-seq = /bits/ 8 <0x1 0x64>;
-		};
-	};
-};
-
 &pma8084_gpios {
 	gpio_keys_pin_a: gpio-keys-active-state {
 		pins = "gpio2", "gpio3", "gpio5";
@@ -814,3 +792,23 @@ panel_te_pin: panel-state {
 		bias-disable;
 	};
 };
+
+&usb {
+	status = "okay";
+
+	phys = <&usb_hs1_phy>;
+	phy-select = <&tcsr 0xb000 0>;
+
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+};
+
+&usb_hs1_phy {
+	status = "okay";
+
+	v1p8-supply = <&pma8084_l6>;
+	v3p3-supply = <&pma8084_l24>;
+
+	qcom,init-seq = /bits/ 8 <0x1 0x64>;
+};
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 07131db2e35d..3b1cc39f2269 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -213,31 +213,6 @@ bluetooth {
 	};
 };
 
-&otg {
-	status = "okay";
-
-	phys = <&usb_hs1_phy>;
-	phy-select = <&tcsr 0xb000 0>;
-	extcon = <&smbb>, <&usb_id>;
-	vbus-supply = <&chg_otg>;
-
-	hnp-disable;
-	srp-disable;
-	adp-disable;
-
-	ulpi {
-		phy@a {
-			status = "okay";
-
-			v1p8-supply = <&pm8941_l6>;
-			v3p3-supply = <&pm8941_l24>;
-
-			extcon = <&smbb>;
-			qcom,init-seq = /bits/ 8 <0x1 0x64>;
-		};
-	};
-};
-
 &pm8941_coincell {
 	status = "okay";
 
@@ -638,3 +613,26 @@ bt_dev_wake_pin: bt-dev-wake-state {
 		bias-disable;
 	};
 };
+
+&usb {
+	status = "okay";
+
+	phys = <&usb_hs1_phy>;
+	phy-select = <&tcsr 0xb000 0>;
+	extcon = <&smbb>, <&usb_id>;
+	vbus-supply = <&chg_otg>;
+
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+};
+
+&usb_hs1_phy {
+	status = "okay";
+
+	v1p8-supply = <&pm8941_l6>;
+	v3p3-supply = <&pm8941_l24>;
+
+	extcon = <&smbb>;
+	qcom,init-seq = /bits/ 8 <0x1 0x64>;
+};
-- 
2.38.1


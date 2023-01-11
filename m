Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D45E665CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbjAKNeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238740AbjAKNcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:32:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C122365BA;
        Wed, 11 Jan 2023 05:31:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE676B81BDE;
        Wed, 11 Jan 2023 13:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82012C433D2;
        Wed, 11 Jan 2023 13:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673443897;
        bh=Z/FI02OooQV8N4EP0yXnfH5rMZ+Q6kh03FM7KDMyPqA=;
        h=From:To:Cc:Subject:Date:From;
        b=fYg/meIua4viTvHgOS3Jz6tZ87QvToH088WFNyl2gvZnv6Y7asRIJkiT3DEp5vU5n
         ej4yrE+BV4PzLAojYrEjUMVLVpFaZzxR5IF6/R/Hz/7wKwDclhUraz2kDs3TvJBdJi
         jmGu1tG82lRqQv0R8DVneYMu0FX05lF3KIf1wdEJwk3C6IR+68uE01+Lj5gyE/UnvC
         WKGdQ4OWhV2J15A/awG5T8Hd18zydaLjT2IZ6OVs+Q0H9p6zhtEpVf9HQ/phutM2uJ
         aSVEMCSmFGS2fBCiefuN/jjFdpMqi5032CDwB2/2jMDu6lBe4HPXccZZNDI7imxCmj
         NvjAvq8to4W4w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pFbCf-0008HK-Rp; Wed, 11 Jan 2023 14:31:41 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp-x13s: enable eDP display
Date:   Wed, 11 Jan 2023 14:31:28 +0100
Message-Id: <20230111133128.31813-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the eDP display on MDSS0 DP3, including backlight control.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

This one depends on the sc8280xp display patches:

	https://lore.kernel.org/lkml/20230111035906.2975494-1-quic_bjorande@quicinc.com/T/#mbcdfc826df6683a71d80bab5d86645ba81b02d52

Johan


 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 75 ++++++++++++++++++-
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 23c1ca44ec11..ef17ef90d1f0 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -47,7 +47,7 @@ wcd938x: audio-codec {
 		#sound-dai-cells = <1>;
 	};
 
-	backlight {
+	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pmc8280c_lpg 3 1000000>;
 		enable-gpios = <&pmc8280_1_gpios 8 GPIO_ACTIVE_HIGH>;
@@ -72,6 +72,22 @@ switch-lid {
 		};
 	};
 
+	vreg_edp_3p3: regulator-edp-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VCC3LCD";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 25 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_reg_en>;
+
+		regulator-boot-on;
+	};
+
 	vreg_edp_bl: regulator-edp-bl {
 		compatible = "regulator-fixed";
 
@@ -259,7 +275,6 @@ vreg_l6b: ldo6 {
 			regulator-max-microvolt = <880000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-boot-on;
-			regulator-always-on;	/* FIXME: VDD_A_EDP_0_0P9 */
 		};
 	};
 
@@ -340,6 +355,55 @@ vreg_l9d: ldo9 {
 	};
 };
 
+&dispcc0 {
+	status = "okay";
+};
+
+&mdss0 {
+	status = "okay";
+};
+
+&mdss0_dp3 {
+	compatible = "qcom,sc8280xp-edp";
+
+	data-lanes = <0 1 2 3>;
+
+	status = "okay";
+
+	aux-bus {
+		panel {
+			compatible = "edp-panel";
+
+			backlight = <&backlight>;
+			power-supply = <&vreg_edp_3p3>;
+
+			ports {
+				port {
+					edp_panel_in: endpoint {
+						remote-endpoint = <&mdss0_dp3_out>;
+					};
+				};
+			};
+		};
+	};
+
+	ports {
+		port@1 {
+			reg = <1>;
+			mdss0_dp3_out: endpoint {
+				remote-endpoint = <&edp_panel_in>;
+			};
+		};
+	};
+};
+
+&mdss0_dp3_phy {
+	vdda-phy-supply = <&vreg_l6b>;
+	vdda-pll-supply = <&vreg_l3b>;
+
+	status = "okay";
+};
+
 &pcie2a {
 	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
@@ -902,6 +966,13 @@ hastings_reg_en: hastings-reg-en-state {
 &tlmm {
 	gpio-reserved-ranges = <70 2>, <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
 
+	edp_reg_en: edp-reg-en-state {
+		pins = "gpio25";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
 	hall_int_n_default: hall-int-n-state {
 		pins = "gpio107";
 		function = "gpio";
-- 
2.38.2


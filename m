Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACD962400F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiKJKi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKJKiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:38:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A5A6C700;
        Thu, 10 Nov 2022 02:38:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9DA06124E;
        Thu, 10 Nov 2022 10:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D365C43470;
        Thu, 10 Nov 2022 10:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668076698;
        bh=pfUV1J44lGpPw0+uv/i2sIDx3ylSY0hXsbscaznXLnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3Dag3jpoWkQHYgtrAk/4ljhvBTH3ehazPQrKJ+tFjD4oZE0UgdNuJsAO/RqMOwiE
         qMJlekUJakGSVDxoCjbjc2lZOI8u238Vtqn0euvse4H6b62gcLrvHKwAEqEfI3EUVJ
         DXHlOgVZxKg8shu4fQkgqQ3RUKGeRZHJCFbLex9kGpoJk+5aYO1bqK4AHgvkjQS9bd
         amvxrESi1nXNUrJNUv+gAWLHfJU7wNSzjPF5jZbyCZZHC+QMw+Yc6FCAesxq7p62Lc
         ju8e9EL5HoCF6LWhyxseslSb1VvRf1PyAcjs9ULBORgpBOv+06PRSbDzhWVFH1cQNM
         bsFih8t7gMQ7w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ot4wR-0003LY-5A; Thu, 10 Nov 2022 11:37:51 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 5/9] arm64: dts: qcom: sc8280xp-crd: enable SDX55 modem
Date:   Thu, 10 Nov 2022 11:35:54 +0100
Message-Id: <20221110103558.12690-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221110103558.12690-1-johan+linaro@kernel.org>
References: <20221110103558.12690-1-johan+linaro@kernel.org>
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

Enable the SDX55 modem connected to PCIe3.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 65 +++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index fd2bdfd1126b..5b9e37a16f9f 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -80,6 +80,22 @@ vreg_misc_3p3: regulator-misc-3p3 {
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	vreg_wwan: regulator-wwan {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VCC3B_WAN";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&pmc8280_2_gpios 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wwan_sw_en>;
+
+		regulator-boot-on;
+	};
 };
 
 &apps_rsc {
@@ -211,6 +227,25 @@ &pcie2a_phy {
 	status = "okay";
 };
 
+&pcie3a {
+	perst-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
+
+	vddpe-3v3-supply = <&vreg_wwan>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie3a_default>;
+
+	status = "okay";
+};
+
+&pcie3a_phy {
+	vdda-phy-supply = <&vreg_l6d>;
+	vdda-pll-supply = <&vreg_l4d>;
+
+	status = "okay";
+};
+
 &pmc8280c_lpg {
 	status = "okay";
 };
@@ -396,6 +431,13 @@ misc_3p3_reg_en: misc-3p3-reg-en-state {
 	};
 };
 
+&pmc8280_2_gpios {
+	wwan_sw_en: wwan-sw-en-state {
+		pins = "gpio1";
+		function = "normal";
+	};
+};
+
 &pmc8280c_gpios {
 	edp_bl_pwm: edp-bl-pwm-state {
 		pins = "gpio8";
@@ -456,6 +498,29 @@ wake-n-pins {
 	       };
 	};
 
+	pcie3a_default: pcie3a-default-state {
+		clkreq-n-pins {
+			pins = "gpio150";
+			function = "pcie3a_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio151";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		wake-n-pins {
+			pins = "gpio148";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
 	qup0_i2c4_default: qup0-i2c4-default-state {
 		pins = "gpio171", "gpio172";
 		function = "qup4";
-- 
2.37.4


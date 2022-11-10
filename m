Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFD662401E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiKJKi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiKJKiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:38:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35EF317D2;
        Thu, 10 Nov 2022 02:38:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A45BB82169;
        Thu, 10 Nov 2022 10:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18736C43143;
        Thu, 10 Nov 2022 10:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668076698;
        bh=sT1WvXvJ7c0JTRgR47Q1J4qASmlZRKoig4IMsKM5CJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVLp8+Wa65CvW5US91+WgIhKs5TS+ejJ4HpbkbuF5YMhW02n7ttlxs6VOhgTAjJvY
         OLmXv2FZlwyCbJXj/gjNvctlm0z/pJUHHN9V5nDh93LPViIHooSPaWI5XLx2nRj/S9
         qKwFAHpq2pyg76PE0ppJYKZDimLTOtplnSmkyTwa5wFlLTcEmiXCcVjoy1r5sYY2K3
         xVuYZGYbcToIgOd0EjcIzpOrAfR2af8eq+LqrR56EMF+x7JbEDbMgJpJJWFEHX9eRL
         iFEel2JF9Pr883tbQSNejj7wrd3vFDiwb+8io0wgtrE/zrioeb6LzQQLh6HPhDiI81
         q/vlSQDG9Hjuw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ot4wR-0003Lc-82; Thu, 10 Nov 2022 11:37:51 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 6/9] arm64: dts: qcom: sc8280xp-crd: enable WiFi controller
Date:   Thu, 10 Nov 2022 11:35:55 +0100
Message-Id: <20221110103558.12690-7-johan+linaro@kernel.org>
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

Enable the Qualcomm QCNFA765 Wireless Network Adapter connected to
PCIe4.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 65 +++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 5b9e37a16f9f..ab5b0aadeead 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -81,6 +81,22 @@ vreg_misc_3p3: regulator-misc-3p3 {
 		regulator-always-on;
 	};
 
+	vreg_wlan: regulator-wlan {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VCC_WLAN_3R9";
+		regulator-min-microvolt = <3900000>;
+		regulator-max-microvolt = <3900000>;
+
+		gpio = <&pmr735a_gpios 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&hastings_reg_en>;
+
+		regulator-boot-on;
+	};
+
 	vreg_wwan: regulator-wwan {
 		compatible = "regulator-fixed";
 
@@ -246,6 +262,25 @@ &pcie3a_phy {
 	status = "okay";
 };
 
+&pcie4 {
+	perst-gpios = <&tlmm 141 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 139 GPIO_ACTIVE_LOW>;
+
+	vddpe-3v3-supply = <&vreg_wlan>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie4_default>;
+
+	status = "okay";
+};
+
+&pcie4_phy {
+	vdda-phy-supply = <&vreg_l6d>;
+	vdda-pll-supply = <&vreg_l4d>;
+
+	status = "okay";
+};
+
 &pmc8280c_lpg {
 	status = "okay";
 };
@@ -445,6 +480,13 @@ edp_bl_pwm: edp-bl-pwm-state {
 	};
 };
 
+&pmr735a_gpios {
+	hastings_reg_en: hastings-reg-en-state {
+		pins = "gpio1";
+		function = "normal";
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
 
@@ -521,6 +563,29 @@ wake-n-pins {
 		};
 	};
 
+	pcie4_default: pcie4-default-state {
+		clkreq-n-pins {
+			pins = "gpio140";
+			function = "pcie4_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio141";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		wake-n-pins {
+			pins = "gpio139";
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


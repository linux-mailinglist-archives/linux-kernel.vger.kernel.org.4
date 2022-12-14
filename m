Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB6164D346
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiLNXVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiLNXVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:21:23 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD3927143;
        Wed, 14 Dec 2022 15:21:19 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id C252020397;
        Thu, 15 Dec 2022 00:21:17 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Adam Skladowski <a39.skl@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] arm64: dts: qcom: msm8976: Declare and use SDC2 pins
Date:   Thu, 15 Dec 2022 00:20:48 +0100
Message-Id: <20221214232049.703484-6-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214232049.703484-1-marijn.suijten@somainline.org>
References: <20221214232049.703484-1-marijn.suijten@somainline.org>
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

Add the pinctrl states for SDC2 and use them on sdhc_2 to support SD
Cards on the currently mainlined Sony Loire platform.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 .../qcom/msm8956-sony-xperia-loire-kugo.dts   |  6 +++
 .../dts/qcom/msm8956-sony-xperia-loire.dtsi   |  6 +++
 arch/arm64/boot/dts/qcom/msm8976.dtsi         | 45 +++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dts b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dts
index 3fb8e23e4330..9178943e2ee1 100644
--- a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dts
+++ b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dts
@@ -33,3 +33,9 @@ &pm8950_l1 {
 	regulator-min-microvolt = <1100000>;
 	regulator-max-microvolt = <1300000>;
 };
+
+&sdc2_on_state {
+	data-pins {
+		drive-strength = <8>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
index 700583a56a0e..2253fb05f1c9 100644
--- a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
@@ -264,6 +264,12 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&sdc2_on_state {
+	clk-pins {
+		drive-strength = <10>;
+	};
+};
+
 &sdhc_2 {
 	bus-width = <4>;
 	cd-gpios = <&tlmm 100 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 7d4c7548882c..f3371eaa2940 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -558,6 +558,46 @@ rclk-pins {
 				};
 			};
 
+			sdc2_off_state: sdc2-off-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			sdc2_on_state: sdc2-on-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+			};
+
 			spi1_default: spi0-default-state {
 				spi-pins {
 					pins = "gpio0", "gpio1", "gpio3";
@@ -751,6 +791,11 @@ sdhc_2: mmc@7864000 {
 				 <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "iface", "core", "xo";
+
+			pinctrl-0 = <&sdc2_on_state>;
+			pinctrl-1 = <&sdc2_off_state>;
+			pinctrl-names = "default", "sleep";
+
 			status = "disabled";
 		};
 
-- 
2.39.0


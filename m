Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E931D5F1231
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiI3TLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiI3TLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:11:04 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19753143563
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:11:01 -0700 (PDT)
Received: from localhost.localdomain (95.49.31.201.neoplus.adsl.tpnet.pl [95.49.31.201])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id A4C0B1F8F0;
        Fri, 30 Sep 2022 21:10:59 +0200 (CEST)
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
Subject: [PATCH 4/8] arm64: dts: qcom: sdm845-tama: Enable remoteprocs
Date:   Fri, 30 Sep 2022 21:10:45 +0200
Message-Id: <20220930191049.123256-5-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930191049.123256-1-konrad.dybcio@somainline.org>
References: <20220930191049.123256-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ADSP, CDSP, IPA, modem and Venus.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../dts/qcom/sdm845-sony-xperia-tama.dtsi     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index 1c9cb1c3d8aa..b78a93f52d96 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -68,6 +68,11 @@ ramoops@ffc00000 {
 	};
 };
 
+&adsp_pas {
+	firmware-name = "qcom/sdm845/Sony/tama/adsp.mbn";
+	status = "okay";
+};
+
 &apps_rsc {
 	pm8998-rpmh-regulators {
 		compatible = "qcom,pm8998-rpmh-regulators";
@@ -328,6 +333,11 @@ vreg_s3c_0p6: smps3 {
 	};
 };
 
+&cdsp_pas {
+	firmware-name = "qcom/sdm845/Sony/tama/cdsp.mbn";
+	status = "okay";
+};
+
 &dsi0 {
 	vdda-supply = <&vreg_l26a_1p2>;
 	status = "okay";
@@ -444,6 +454,12 @@ &ibb {
 	regulator-pull-down;
 };
 
+&ipa {
+	memory-region = <&ipa_fw_mem>;
+	firmware-name = "qcom/sdm845/Sony/tama/ipa_fws.mbn";
+	status = "okay";
+};
+
 &lab {
 	regulator-min-microvolt = <5500000>;
 	regulator-max-microvolt = <5700000>;
@@ -458,6 +474,11 @@ &mdss {
 	status = "okay";
 };
 
+&mss_pil {
+	firmware-name = "qcom/sdm845/Sony/tama/mba.mbn", "qcom/sdm845/Sony/tama/modem.mbn";
+	status = "okay";
+};
+
 &pmi8998_wled {
 	default-brightness = <800>;
 	qcom,switching-freq = <800>;
@@ -599,3 +620,8 @@ &usb_1_hsphy {
 	vdda-pll-supply = <&vreg_l12a_1p8>;
 	vdda-phy-dpdm-supply = <&vreg_l24a_3p1>;
 };
+
+&venus {
+	firmware-name = "qcom/sdm845/Sony/tama/venus.mbn";
+	status = "okay";
+};
-- 
2.37.3


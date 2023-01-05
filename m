Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBAC65EB16
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjAEMvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjAEMvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:51:24 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DDB4C713;
        Thu,  5 Jan 2023 04:51:22 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 3D75C420E6;
        Thu,  5 Jan 2023 17:34:00 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1672922040; bh=nx/GvWswnauPtlRcTkUzfp1KQCpIEjRYLHbnYq0pPzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rrBvPTL3SF0mjKJ694okNvj8K9aJlZmxxxaw/cKN2M1U07CDDExVKTbV1KRWKS3VQ
         QbPLkGInisouQ2yGKseO7PJLWQjMvcF1B1z2L13JaLXsRgZImuBlzWyObEAIPCUPDU
         EoPlG2PIvgpwDomaIRh2LylZzJAGlbyhh2LmGifngKkY8H+Lne3D2bsNNrQFzjK5ba
         nQBxd6HpG0GyKN8BKYt8Dcn+fjbgc+5OCwKvU0BW2otgRoBwpM2R80/28+q8w03Hpw
         UQe+seZaXlo8Y2AxIgGJkYq+FTGIXh67QHRkD4PDrOL4SsmGBmBDxVg1PJdpFrVyJa
         NRZ5XkfaUEv9A==
From:   Nikita Travkin <nikita@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Siddharth Manthan <siddharth.manthan@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 6/8] arm64: dts: qcom: msm8916-samsung-gt58: Add touchscreen
Date:   Thu,  5 Jan 2023 17:32:38 +0500
Message-Id: <20230105123240.1089375-7-nikita@trvn.ru>
In-Reply-To: <20230105123240.1089375-1-nikita@trvn.ru>
References: <20230105123240.1089375-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Siddharth Manthan <siddharth.manthan@gmail.com>

gt58 uses Zinitix bt532 touch controller.
Add it to device tree.

Signed-off-by: Siddharth Manthan <siddharth.manthan@gmail.com>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../boot/dts/qcom/msm8916-samsung-gt58.dts    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
index 37140d041a22..fcf516888739 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
@@ -9,6 +9,19 @@ / {
 	compatible = "samsung,gt58", "qcom,msm8916";
 	chassis-type = "tablet";
 
+	reg_vdd_tsp: regulator-vdd-tsp {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_tsp";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&msmgpio 73 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&reg_tsp_en_default>;
+		pinctrl-names = "default";
+	};
+
 	vibrator {
 		compatible = "gpio-vibrator";
 		enable-gpios = <&msmgpio 76 GPIO_ACTIVE_HIGH>;
@@ -18,7 +31,43 @@ vibrator {
 	};
 };
 
+&blsp_i2c5 {
+	status = "okay";
+
+	touchscreen@20 {
+		compatible = "zinitix,bt532";
+		reg = <0x20>;
+		interrupt-parent = <&msmgpio>;
+		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+
+		touchscreen-size-x = <768>;
+		touchscreen-size-y = <1024>;
+
+		vcca-supply = <&reg_vdd_tsp>;
+		vdd-supply = <&pm8916_l6>;
+
+		pinctrl-0 = <&tsp_int_default>;
+		pinctrl-names = "default";
+	};
+};
+
 &msmgpio {
+	reg_tsp_en_default: reg-tsp-en-default-state {
+		pins = "gpio73";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_int_default: tsp-int-default-state {
+		pins = "gpio13";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	vibrator_en_default: vibrator-en-default-state {
 		pins = "gpio76";
 		function = "gpio";
-- 
2.38.1


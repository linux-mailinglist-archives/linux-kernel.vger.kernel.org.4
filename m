Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C51B69C7D9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjBTJnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjBTJnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:43:51 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17711BBBE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:43:50 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id eq27so6820092edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X7r8oZbqOdEDUKqJsjABwPZodMhY2NzeDbJjrvQys0I=;
        b=H6rjSmhaZJLXfK4rjDST8C82u/09vGq0Cxfq0GnIwNnaW2mSEoVIEiAFb6qq3b+NpK
         5JcJfYp4b2YGMRsnHPGmQusBID6Is/wEhN88+BcIMrg4fDQD8ABk1mcY2Sdj7o827R9W
         9kaDqob0z4glJyBHNbcL0bHiDm1scXjKQ9KbZQvjrJA1uVgbH/AoWpRY+yLfKC88Zabj
         36GLEhrTtuDZWCCrESPcM8mEEN/aw7KscSRfO59t0Gc2u1nVu9UeHgl2q53RkcTLITSL
         +QdMxr5CUDHFYi4GX4nDfg75Tp3WIZQtgWixv/F09EJ8f3qSA75Euru63bZThmBFHFlu
         pxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7r8oZbqOdEDUKqJsjABwPZodMhY2NzeDbJjrvQys0I=;
        b=p5Gtv0c6ImcmSlUsnkkCP8Z8HK0ph0WiQwYrYZG26wn+FvV5cmhHy7L9uoUuFqnsO5
         LSwMjV3NOzxDUnHtRDL4k/CUAf/LoDCGmmsKTSPOR1IzoBcTzWsItYU3uKvFnrU/1nfw
         k2hWSxgmqsYg/tttB2ldgqcMN6ln+eGhhhBtT6WQqvkJ3v4OhcoVnoYXBJ+0X3PScorm
         T5VK0K1MxJQdLyp2L/fa5HsyAZbS1VcUy/oe5P8pV034kSCXiIrF4DY8JkBlsoE/RtA3
         D2JTr7K3xBIczwg9kvlc0A9wcfIiliyz/NkHXyQ0+SgGBlL+QwWzCTLW5NANHwm8dLI3
         bOCA==
X-Gm-Message-State: AO0yUKUrkk60U70l1ONO2rmLbMfpgaucrO9qVjflVuMlmInM8TlpiFtv
        VotAaVvEoKklanEBkkvdKxqmUw==
X-Google-Smtp-Source: AK7set9pu154zOZi9np80teikVR09AbQ5CWwcA1GtQ+4rAO004JnH3ERoIN+kFdIQzBusSaaVun9DQ==
X-Received: by 2002:a05:6402:4d:b0:4ac:b32e:b6f with SMTP id f13-20020a056402004d00b004acb32e0b6fmr2029346edu.23.1676886228576;
        Mon, 20 Feb 2023 01:43:48 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b2-20020a50b402000000b004aef4f32edesm1557645edh.88.2023.02.20.01.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 01:43:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: qcom: msm8996: move WCD9335 audio codec to boards
Date:   Mon, 20 Feb 2023 10:43:38 +0100
Message-Id: <20230220094339.47370-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WCD9335 audio codec on Slimbus is a property of a board, not SoC,
thus it should not be present in MSM8996 DTSI.  Keep it in specific
boards, so it won't appear incomplete in the boards not having it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts   | 56 +++++++++++++----
 .../boot/dts/qcom/msm8996-oneplus-common.dtsi | 56 +++++++++++++----
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  | 60 ++++++++++++++-----
 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 30 +---------
 4 files changed, 135 insertions(+), 67 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index fe6c415e8229..ce189dea2760 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -974,6 +974,50 @@ dai@2 {
 	};
 };
 
+&slim_msm {
+	status = "okay";
+
+	slim@1 {
+		reg = <1>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		tasha_ifd: tas-ifd@0,0 {
+			compatible = "slim217,1a0";
+			reg = <0 0>;
+		};
+
+		wcd9335: codec@1,0 {
+			compatible = "slim217,1a0";
+			reg = <1 0>;
+
+			clock-names = "mclk", "slimbus";
+			clocks = <&div1_mclk>,
+				 <&rpmcc RPM_SMD_BB_CLK1>;
+			interrupt-parent = <&tlmm>;
+			interrupts = <54 IRQ_TYPE_LEVEL_HIGH>,
+				     <53 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "intr1", "intr2";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			pinctrl-0 = <&cdc_reset_active &wcd_intr_default>;
+			pinctrl-names = "default";
+
+			reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
+			slim-ifc-dev = <&tasha_ifd>;
+
+			#sound-dai-cells = <1>;
+
+			vdd-buck-supply = <&vreg_s4a_1p8>;
+			vdd-buck-sido-supply = <&vreg_s4a_1p8>;
+			vdd-tx-supply = <&vreg_s4a_1p8>;
+			vdd-rx-supply = <&vreg_s4a_1p8>;
+			vdd-io-supply = <&vreg_s4a_1p8>;
+		};
+	};
+};
+
 &sound {
 	compatible = "qcom,apq8096-sndcard";
 	model = "DB820c";
@@ -1101,15 +1145,3 @@ &usb3phy {
 &venus {
 	status = "okay";
 };
-
-&wcd9335 {
-	clock-names = "mclk", "slimbus";
-	clocks = <&div1_mclk>,
-		 <&rpmcc RPM_SMD_BB_CLK1>;
-
-	vdd-buck-supply = <&vreg_s4a_1p8>;
-	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
-	vdd-tx-supply = <&vreg_s4a_1p8>;
-	vdd-rx-supply = <&vreg_s4a_1p8>;
-	vdd-io-supply = <&vreg_s4a_1p8>;
-};
diff --git a/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
index 2994337c6046..104deaee74e5 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
@@ -504,6 +504,50 @@ vreg_l32a_1p8: l32 {
 	};
 };
 
+&slim_msm {
+	status = "okay";
+
+	slim@1 {
+		reg = <1>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		tasha_ifd: tas-ifd@0,0 {
+			compatible = "slim217,1a0";
+			reg = <0 0>;
+		};
+
+		wcd9335: codec@1,0 {
+			compatible = "slim217,1a0";
+			reg = <1 0>;
+
+			clock-names = "mclk", "slimbus";
+			clocks = <&div1_mclk>,
+				 <&rpmcc RPM_SMD_BB_CLK1>;
+			interrupt-parent = <&tlmm>;
+			interrupts = <54 IRQ_TYPE_LEVEL_HIGH>,
+				     <53 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "intr1", "intr2";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			pinctrl-0 = <&cdc_reset_active &wcd_intr_default>;
+			pinctrl-names = "default";
+
+			reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
+			slim-ifc-dev = <&tasha_ifd>;
+
+			#sound-dai-cells = <1>;
+
+			vdd-buck-supply = <&vreg_s4a_1p8>;
+			vdd-buck-sido-supply = <&vreg_s4a_1p8>;
+			vdd-tx-supply = <&vreg_s4a_1p8>;
+			vdd-rx-supply = <&vreg_s4a_1p8>;
+			vdd-io-supply = <&vreg_s4a_1p8>;
+		};
+	};
+};
+
 &slpi_pil {
 	status = "okay";
 };
@@ -772,15 +816,3 @@ &usb3_dwc3 {
 &venus {
 	status = "okay";
 };
-
-&wcd9335 {
-	clock-names = "mclk", "slimbus";
-	clocks = <&div1_mclk>,
-		 <&rpmcc RPM_SMD_BB_CLK1>;
-
-	vdd-buck-supply = <&vreg_s4a_1p8>;
-	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
-	vdd-tx-supply = <&vreg_s4a_1p8>;
-	vdd-rx-supply = <&vreg_s4a_1p8>;
-	vdd-io-supply = <&vreg_s4a_1p8>;
-};
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index 2acfed28e3cb..446b1d23dec0 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -337,6 +337,52 @@ led@3 {
 	};
 };
 
+&slim_msm {
+	status = "okay";
+
+	slim@1 {
+		reg = <1>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		tasha_ifd: tas-ifd@0,0 {
+			compatible = "slim217,1a0";
+			reg = <0 0>;
+		};
+
+		wcd9335: codec@1,0 {
+			compatible = "slim217,1a0";
+			reg = <1 0>;
+
+			clock-names = "mclk", "slimbus";
+			clocks = <&divclk1_cdc>,
+				 <&rpmcc RPM_SMD_BB_CLK1>;
+			interrupt-parent = <&tlmm>;
+			interrupts = <54 IRQ_TYPE_LEVEL_HIGH>,
+				     <53 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "intr1", "intr2";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			pinctrl-0 = <&cdc_reset_active &wcd_intr_default>;
+			pinctrl-names = "default";
+
+			reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
+			slim-ifc-dev = <&tasha_ifd>;
+
+			#sound-dai-cells = <1>;
+
+			vdd-buck-supply = <&vreg_s4a_1p8>;
+			vdd-buck-sido-supply = <&vreg_s4a_1p8>;
+			vdd-rx-supply = <&vreg_s4a_1p8>;
+			vdd-tx-supply = <&vreg_s4a_1p8>;
+			vdd-vbat-supply = <&vph_pwr>;
+			vdd-micbias-supply = <&vph_pwr_bbyp>;
+			vdd-io-supply = <&vreg_s4a_1p8>;
+		};
+	};
+};
+
 &slpi_pil {
 	status = "okay";
 
@@ -395,20 +441,6 @@ &venus {
 	status = "okay";
 };
 
-&wcd9335 {
-	clock-names = "mclk", "slimbus";
-	clocks = <&divclk1_cdc>,
-		 <&rpmcc RPM_SMD_BB_CLK1>;
-
-	vdd-buck-supply = <&vreg_s4a_1p8>;
-	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
-	vdd-rx-supply = <&vreg_s4a_1p8>;
-	vdd-tx-supply = <&vreg_s4a_1p8>;
-	vdd-vbat-supply = <&vph_pwr>;
-	vdd-micbias-supply = <&vph_pwr_bbyp>;
-	vdd-io-supply = <&vreg_s4a_1p8>;
-};
-
 &rpm_requests {
 	regulators-0 {
 		compatible = "qcom,rpm-pm8994-regulators";
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 6f180a8efe77..dfc7153c9d8a 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3383,36 +3383,8 @@ slim_msm: slim-ngd@91c0000 {
 			dma-names = "rx", "tx";
 			#address-cells = <1>;
 			#size-cells = <0>;
-			slim@1 {
-				reg = <1>;
-				#address-cells = <2>;
-				#size-cells = <0>;
-
-				tasha_ifd: tas-ifd@0,0 {
-					compatible = "slim217,1a0";
-					reg = <0 0>;
-				};
-
-				wcd9335: codec@1,0 {
-					pinctrl-0 = <&cdc_reset_active &wcd_intr_default>;
-					pinctrl-names = "default";
-
-					compatible = "slim217,1a0";
-					reg = <1 0>;
 
-					interrupt-parent = <&tlmm>;
-					interrupts = <54 IRQ_TYPE_LEVEL_HIGH>,
-						     <53 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-names = "intr1", "intr2";
-					interrupt-controller;
-					#interrupt-cells = <1>;
-					reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
-
-					slim-ifc-dev = <&tasha_ifd>;
-
-					#sound-dai-cells = <1>;
-				};
-			};
+			status = "disabled";
 		};
 
 		adsp_pil: remoteproc@9300000 {
-- 
2.34.1


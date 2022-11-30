Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86ED63E18A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiK3UMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiK3UMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:12:01 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AEE4E6A6;
        Wed, 30 Nov 2022 12:10:28 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id q7so22148980ljp.9;
        Wed, 30 Nov 2022 12:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lsAMEj6HaUbhZ9bHj/9+ikD6XEF6DUBZQroGChklKg=;
        b=LXfwVLgkA7GrdcTV8UNA2Fem5L/wCKZkMyCv+nQBl9dkWQ3HrGiwiI5/s5ODiYwn7R
         fcojBBzqduf9uqtWP4tU2bnV3JmbHRaVmAJjteg8gsRurtELhABlGJ9eEbvpFKhbOmUC
         JY9dg4XuRFq7WTMqv4Rzj1Ryt8GV6xIEtFfG3amezj9sJCJrOiitnfYlQH8pehTBPFw2
         tU2hlG8H9ZmnOFbUkEK6VRK/CLNZzvUOWnmaOdtuWJA2j31SFrkVHilOp7rCQJm4/8VR
         crgGIGrsEc3DGUG5qW4bB+6gczVK2evMpE2g29sadIEVvbZVaQY8ld9RvFcBkCEOVsAP
         gAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lsAMEj6HaUbhZ9bHj/9+ikD6XEF6DUBZQroGChklKg=;
        b=QP3nw/Fqz5abb/R1QVuq/KmsT2DdATDHxXqi0sGYbBTI2zML4jW/PVNR76IHYBVfYY
         IrrW4ekUOCDFofSTbfsuOt0CfBPUj74+TMtE645E9LdybcUQ6q2AVb3LfPlhJSWrpGOX
         DU5NnFFljHNV9NMu2187yqlIR2CvBq8WGf7Igs57JJvN7rXpKFusYlpVmD9JrNHoxNot
         dLJZ5rB/Ob7SxinyQWsCSpjlWV+2yqSaTv5N7G7rMQQZ955H/LrcbXbtp0Im0qnMawVs
         FQt8kBdhMRVWtfT6fgfCNdolwHl5MOnK9CxXWREs+LeY1n9JSb1Vgth7+8pSA6ImUHmJ
         Q6MA==
X-Gm-Message-State: ANoB5pn34bJLa23VuzoSfUz6113Wlt8MDfn7d/1bOVC1IzoHl7CR4Uhc
        egLWMar6Ov855sz1oYWIKyqPlQxU0H4=
X-Google-Smtp-Source: AA0mqf7kU3fM2GF4LqoHEcstGJ72edHxe2AQx+Uy6dMhopVvX+xPkK5azXuGEa59xmmiEysaHIHZYw==
X-Received: by 2002:a2e:be28:0:b0:278:f1a5:a361 with SMTP id z40-20020a2ebe28000000b00278f1a5a361mr14223947ljq.124.1669839019153;
        Wed, 30 Nov 2022 12:10:19 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id a25-20020a056512201900b004b4e9580b1asm369754lfb.66.2022.11.30.12.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:10:18 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 10/12] arm64: dts: qcom: sm6115: Add i2c/spi nodes
Date:   Wed, 30 Nov 2022 21:09:48 +0100
Message-Id: <20221130200950.144618-11-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130200950.144618-1-a39.skl@gmail.com>
References: <20221130200950.144618-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C/SPI nodes for SM6115.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 290 +++++++++++++++++++++++++++
 1 file changed, 290 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index b30a5485671d..e676b9d117e3 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/qcom,gcc-sm6115.h>
 #include <dt-bindings/clock/qcom,sm6115-dispcc.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -365,6 +366,90 @@ tlmm: pinctrl@500000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
+			qup_i2c0_default: qup-i2c0-default-state {
+				pins = "gpio0", "gpio1";
+				function = "qup0";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c1_default: qup-i2c1-default-state {
+				pins = "gpio4", "gpio5";
+				function = "qup1";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c2_default: qup-i2c2-default-state {
+				pins = "gpio6", "gpio7";
+				function = "qup2";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c3_default: qup-i2c3-default-state {
+				pins = "gpio8", "gpio9";
+				function = "qup3";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c4_default: qup-i2c4-default-state {
+				pins = "gpio12", "gpio13";
+				function = "qup4";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c5_default: qup-i2c5-default-state {
+				pins = "gpio14", "gpio15";
+				function = "qup5";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_spi0_default: qup-spi0-default-state {
+				pins = "gpio0", "gpio1","gpio2", "gpio3";
+				function = "qup0";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_spi1_default: qup-spi1-default-state {
+				pins = "gpio4", "gpio5", "gpio69", "gpio70";
+				function = "qup1";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_spi2_default: qup-spi2-default-state {
+				pins = "gpio6", "gpio7", "gpio71", "gpio80";
+				function = "qup2";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_spi3_default: qup-spi3-default-state {
+				pins = "gpio8", "gpio9", "gpio10", "gpio11";
+				function = "qup3";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_spi4_default: qup-spi4-default-state {
+				pins = "gpio12", "gpio13", "gpio96", "gpio97";
+				function = "qup4";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_spi5_default: qup-spi5-default-state {
+				pins = "gpio14", "gpio15", "gpio16", "gpio17";
+				function = "qup5";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
 			sdc1_state_on: sdc1-on-state {
 				clk-pins {
 					pins = "sdc1_clk";
@@ -701,6 +786,211 @@ gpi_dma0: dma-controller@4a00000 {
 			status = "disabled";
 		};
 
+		qupv3_id_0: geniqup@4ac0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x04ac0000 0x2000>;
+			clock-names = "m-ahb", "s-ahb";
+			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			iommus = <&apps_smmu 0xe3 0x0>;
+			ranges;
+			status = "disabled";
+
+			i2c0: i2c@4a80000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x04a80000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c0_default>;
+				interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi0: spi@4a80000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x04a80000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi0_default>;
+				interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c1: i2c@4a84000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x04a84000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c1_default>;
+				interrupts = <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi1: spi@4a84000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x04a84000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi1_default>;
+				interrupts = <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 1 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c2: i2c@4a88000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x04a88000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c2_default>;
+				interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi2: spi@4a88000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x04a88000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi2_default>;
+				interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c3: i2c@4a8c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x04a8c000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c3_default>;
+				interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi3: spi@4a8c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x04a8c000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi3_default>;
+				interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma0 0 3 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 3 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c4: i2c@4a90000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x04a90000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c4_default>;
+				interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi4: spi@4a90000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x04a90000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi4_default>;
+				interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma0 0 4 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 4 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c5: i2c@4a94000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x04a94000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c5_default>;
+				interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi5: spi@4a94000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x04a94000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi5_default>;
+				interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma0 0 5 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 5 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
 		usb_1: usb@4ef8800 {
 			compatible = "qcom,sm6115-dwc3", "qcom,dwc3";
 			reg = <0x04ef8800 0x400>;
-- 
2.25.1


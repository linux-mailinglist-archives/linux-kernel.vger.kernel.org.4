Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DCB6229E8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiKILNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiKILNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:13:01 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5300F28E1B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:12:53 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i21so26682859edj.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAgMkFLh+A9qlmK7u0Nv6XHzT4Yq7Xys6b3k49GmNps=;
        b=TE5f/I0yPKOM0MXb37JUtgiy0FaznlKxeKsXjVlYYP7GDFu/1MkbA0IswO2wjXD1IJ
         yuEGiIeGgPzHL/QcWDa7TzBdk0T8SqKPMcCHOcaQXTzoZhlin7DMLjgIn6d7H3Mc7s0b
         hyack7pJkVdDNkUH8jk898hSI/fQXWMjO0WS59dWcOvUwJAqrioGb6Sqglb51AvIo80D
         8rkm+j0KpTayLJu/zGMiZ5xAzzm2TLouKyZyfVifdMv90FxzCmm9ibjr+W2BCnD264OE
         1t1c7LYikeBjBg2oMTA9vypA4IFDgwijLYPlPrM6+zKLM9RcIsh2jZHoERphdr0Y2P+9
         lxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAgMkFLh+A9qlmK7u0Nv6XHzT4Yq7Xys6b3k49GmNps=;
        b=2MOz+ZoT48z7aUu+0NucA7C3RPBKssHCmPDXRa/ShfG73L4EHxt3rRLVZpg1zha5mA
         0buH7BV8ww5v+FjtDC/XNkcXgc9ZP6KtTyU/2REHOFsAGt60QGXG3XC6x55ApwvhBSyv
         KyGucEQ/Uj715Ju10C+HSjUHpewWeZreKQezDFZOVZE9Prqz93iGanI1dsnppdFFYSXs
         pPvtC3yHRF/bFQsIDQajEsIL7VRKIXyBlK5XWpNW1tUh2FatHf4epF7r90bbKi+/Xqg2
         T/XGQMdTPKboWtDm+A1LMkh79u/58yggR2CVaJ243R93WbdBmi9gmyzP+HaDK8Tk36An
         U4TQ==
X-Gm-Message-State: ACrzQf0/UAFo7GF+jW/xAHNqHPdtM0bZZByzx6W8AVf/rYevBSsmjIUy
        D0OODNrwQUfvdkXm9x367TyKtA==
X-Google-Smtp-Source: AMsMyM6e/OQO48g29FaoEJLFMTKkmw4IoQSe4L35GahwYZdqtYhXB2YozkODGedw2PHl0TGy/wvffg==
X-Received: by 2002:a05:6402:1553:b0:461:539d:9b88 with SMTP id p19-20020a056402155300b00461539d9b88mr58002137edx.286.1667992371829;
        Wed, 09 Nov 2022 03:12:51 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id k8-20020a1709062a4800b007ad9c826d75sm5825899eje.61.2022.11.09.03.12.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Nov 2022 03:12:51 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] arm64: dts: qcom: sm6375: Add QUPs and corresponding SPI/I2C hosts
Date:   Wed,  9 Nov 2022 12:12:31 +0100
Message-Id: <20221109111236.46003-7-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221109111236.46003-1-konrad.dybcio@linaro.org>
References: <20221109111236.46003-1-konrad.dybcio@linaro.org>
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

Add necessary nodes to support various QUP configurations. Note that:

- QUP3/4/5 and 11 are straight up missing
- There may be more QUPs physically on the SoC that work perfectly
fine, but Qualcomm decided not to expose them on the downstream kernel
- Many are missing pinctrls, as there are both missing pin funcs in
the TLMM driver and missing configuration settings (though they are
possible to guesstimate quite easily)

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 306 +++++++++++++++++++++++++++
 1 file changed, 306 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 952156891476..6adffd927a8e 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/clock/qcom,sm6375-gcc.h>
+#include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -317,6 +318,25 @@ CLUSTER_PD: cpu-cluster0 {
 		};
 	};
 
+	qup_opp_table: opp-table-qup {
+		compatible = "operating-points-v2";
+
+		opp-75000000 {
+			opp-hz = /bits/ 64 <75000000>;
+			required-opps = <&rpmpd_opp_low_svs>;
+		};
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			required-opps = <&rpmpd_opp_svs>;
+		};
+
+		opp-128000000 {
+			opp-hz = /bits/ 64 <128000000>;
+			required-opps = <&rpmpd_opp_nom>;
+		};
+	};
+
 	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -630,6 +650,125 @@ gpi_dma0: dma-controller@4a00000 {
 			status = "disabled";
 		};
 
+		qupv3_id_0: geniqup@4ac0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x0 0x04ac0000 0x0 0x2000>;
+			clock-names = "m-ahb", "s-ahb";
+			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
+			iommus = <&apps_smmu 0x3 0x0>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			i2c0: i2c@4a80000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x04a80000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c0_default>;
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
+				reg = <0x0 0x04a80000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi0_default>;
+				power-domains = <&rpmpd SM6375_VDDCX>;
+				operating-points-v2 = <&qup_opp_table>;
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
+				reg = <0x0 0x04a84000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				interrupts = <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c1_default>;
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
+				reg = <0x0 0x04a84000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				interrupts = <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmpd SM6375_VDDCX>;
+				operating-points-v2 = <&qup_opp_table>;
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
+				reg = <0x0 0x04a88000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c2_default>;
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
+				reg = <0x0 0x04a88000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmpd SM6375_VDDCX>;
+				operating-points-v2 = <&qup_opp_table>;
+				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			/*
+			 * As per GCC, QUP3/4/5/11 also exist, but are not even defined downstream.
+			 * There is a comment in the included DTSI of another SoC saying that they
+			 * are not "bolled out" (probably meaning not routed to solder balls)
+			 * TLMM driver however, suggests there are as many as 15 QUPs in total!
+			 * Most of which don't even have pin configurations for.. Sad stuff!
+			 */
+		};
+
 		gpi_dma1: dma-controller@4c00000 {
 			compatible = "qcom,sm6375-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0 0x04c00000 0 0x60000>;
@@ -650,6 +789,173 @@ gpi_dma1: dma-controller@4c00000 {
 			status = "disabled";
 		};
 
+		qupv3_id_1: geniqup@4cc0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x0 0x04cc0000 0x0 0x2000>;
+			clock-names = "m-ahb", "s-ahb";
+			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
+			iommus = <&apps_smmu 0xc3 0x0>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			i2c6: i2c@4c80000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x04c80000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma1 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 0 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi6: spi@4c80000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x04c80000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmpd SM6375_VDDCX>;
+				operating-points-v2 = <&qup_opp_table>;
+				dmas = <&gpi_dma1 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 0 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c7: i2c@4c84000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x04c84000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				interrupts = <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma1 0 1 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 1 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi7: spi@4c84000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x04c84000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				interrupts = <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmpd SM6375_VDDCX>;
+				operating-points-v2 = <&qup_opp_table>;
+				dmas = <&gpi_dma1 0 1 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 1 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c8: i2c@4c88000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x04c88000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				interrupts = <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c8_default>;
+				dmas = <&gpi_dma1 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 2 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi8: spi@4c88000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x04c88000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				interrupts = <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmpd SM6375_VDDCX>;
+				operating-points-v2 = <&qup_opp_table>;
+				dmas = <&gpi_dma1 0 2 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 2 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c9: i2c@4c8c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x04c8c000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				interrupts = <GIC_SPI 510 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma1 0 3 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 3 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi9: spi@4c8c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x04c8c000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				interrupts = <GIC_SPI 510 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmpd SM6375_VDDCX>;
+				operating-points-v2 = <&qup_opp_table>;
+				dmas = <&gpi_dma1 0 3 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 3 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c10: i2c@4c90000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x04c90000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				interrupts = <GIC_SPI 511 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c10_default>;
+				dmas = <&gpi_dma1 0 4 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 4 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi10: spi@4c90000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x04c90000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				interrupts = <GIC_SPI 511 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmpd SM6375_VDDCX>;
+				operating-points-v2 = <&qup_opp_table>;
+				dmas = <&gpi_dma1 0 4 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 4 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
 		usb_1: usb@4ef8800 {
 			compatible = "qcom,sm6375-dwc3", "qcom,dwc3";
 			reg = <0 0x04ef8800 0 0x400>;
-- 
2.38.1


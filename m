Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8578564FE8A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 12:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiLRLIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 06:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiLRLIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 06:08:21 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D15DB9C;
        Sun, 18 Dec 2022 03:08:19 -0800 (PST)
Received: from [192.168.2.144] (adsl-d248.84-47-10.t-com.sk [84.47.10.248])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id EC50A3EEF4;
        Sun, 18 Dec 2022 12:08:15 +0100 (CET)
Date:   Sun, 18 Dec 2022 12:08:09 +0100
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm6125: Add QUPs with SPI and
 I2C Serial Engines
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <LX23NR.48ID1I6UMKGV1@somainline.org>
In-Reply-To: <20221216233408.1283581-3-marijn.suijten@somainline.org>
References: <20221216233408.1283581-1-marijn.suijten@somainline.org>
        <20221216233408.1283581-3-marijn.suijten@somainline.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, Dec 17 2022 at 12:34:07 AM +01:00:00, Marijn Suijten 
<marijn.suijten@somainline.org> wrote:
> Add Qualcomm Universal Peripheral nodes with SPI and I2C Serial 
> Engines.
> QUP 0 only has two SPIs at index 0 and 2, QUP 1 has four SPIs with a 
> gap
> in the middle (ranging from 5-9 with SPI 7 missing).  Both QUPs have 5
> I2C Serial Engines.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> [Marijn: Add iommus, reword patch description, reorder all properties,
>  sort based on address, use QCOM_GPI_ constants, drop dma cells from 5
>  to 3]
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 298 
> +++++++++++++++++++++++++++
>  1 file changed, 298 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi 
> b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 5fc304b2da63..36ba74b5ad89 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -753,6 +753,138 @@ gpi_dma0: dma-controller@4a00000 {
>  			status = "disabled";
>  		};
> 
> +		qupv3_id_0: geniqup@4ac0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0x04ac0000 0x2000>;
> +			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> +			clock-names = "m-ahb", "s-ahb";
> +			iommus = <&apps_smmu 0x123 0x0>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			status = "disabled";
> +
> +			i2c0: i2c@4a80000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a80000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c0_default>;
> +				pinctrl-1 = <&qup_i2c0_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
> +				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi0: spi@4a80000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x04a80000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_spi0_default>;
> +				pinctrl-1 = <&qup_spi0_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
> +				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c@4a84000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a84000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c1_default>;
> +				pinctrl-1 = <&qup_i2c1_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
> +				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c2: i2c@4a88000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a88000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c2_default>;
> +				pinctrl-1 = <&qup_i2c2_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
> +				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi2: spi@4a88000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x04a88000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_spi2_default>;
> +				pinctrl-1 = <&qup_spi2_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
> +				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c3: i2c@4a8c000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a8c000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c3_default>;
> +				pinctrl-1 = <&qup_i2c3_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
> +				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c4: i2c@4a90000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a90000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c4_default>;
> +				pinctrl-1 = <&qup_i2c4_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
> +				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +		};
> +
>  		gpi_dma1: dma-controller@4c00000 {
>  			compatible = "qcom,sm6125-gpi-dma", "qcom,sdm845-gpi-dma";
>  			reg = <0x04c00000 0x60000>;
> @@ -771,6 +903,172 @@ gpi_dma1: dma-controller@4c00000 {
>  			status = "disabled";
>  		};
> 
> +		qupv3_id_1: geniqup@4cc0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0x04cc0000 0x2000>;
> +			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
> +			clock-names = "m-ahb", "s-ahb";
> +			iommus = <&apps_smmu 0x143 0x0>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			status = "disabled";
> +
> +			i2c5: i2c@4c80000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04c80000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c5_default>;
> +				pinctrl-1 = <&qup_i2c5_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma1 0 0 QCOM_GPI_I2C>,
> +				       <&gpi_dma1 1 0 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi5: spi@4c80000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x04c80000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_spi5_default>;
> +				pinctrl-1 = <&qup_spi5_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma1 0 0 QCOM_GPI_SPI>,
> +				       <&gpi_dma1 1 0 QCOM_GPI_SPI>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c6: i2c@4c84000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04c84000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c6_default>;
> +				pinctrl-1 = <&qup_i2c6_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma1 0 1 QCOM_GPI_I2C>,
> +				       <&gpi_dma1 1 1 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi6: spi@4c84000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x04c84000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_spi6_default>;
> +				pinctrl-1 = <&qup_spi6_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma1 0 1 QCOM_GPI_SPI>,
> +				       <&gpi_dma1 1 1 QCOM_GPI_SPI>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c7: i2c@4c88000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04c88000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c7_default>;
> +				pinctrl-1 = <&qup_i2c7_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma1 0 2 QCOM_GPI_I2C>,
> +				       <&gpi_dma1 1 2 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c8: i2c@4c8c000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04c8c000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c8_default>;
> +				pinctrl-1 = <&qup_i2c8_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma1 0 3 QCOM_GPI_I2C>,
> +				       <&gpi_dma1 1 3 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi8: spi@4c8c000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x04c8c000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_spi8_default>;
> +				pinctrl-1 = <&qup_spi8_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma1 0 3 QCOM_GPI_SPI>,
> +				       <&gpi_dma1 1 3 QCOM_GPI_SPI>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c9: i2c@4c90000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04c90000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c9_default>;
> +				pinctrl-1 = <&qup_i2c9_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma1 0 4 QCOM_GPI_I2C>,
> +				       <&gpi_dma1 1 4 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi9: spi@4c90000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x04c90000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_spi9_default>;
> +				pinctrl-1 = <&qup_spi9_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma1 0 4 QCOM_GPI_SPI>,
> +				       <&gpi_dma1 1 4 QCOM_GPI_SPI>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +		};
> +
>  		usb3: usb@4ef8800 {
>  			compatible = "qcom,sm6125-dwc3", "qcom,dwc3";
>  			reg = <0x04ef8800 0x400>;
> --
> 2.39.0
> 
Reviewed-by: Martin Botka <martin.botka@somainline.org>

-Martin



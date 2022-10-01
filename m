Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64925F1F3C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 22:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiJAUQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 16:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJAUQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 16:16:55 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96A53687F;
        Sat,  1 Oct 2022 13:16:52 -0700 (PDT)
Received: from [192.168.1.101] (95.49.31.201.neoplus.adsl.tpnet.pl [95.49.31.201])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 1641F20117;
        Sat,  1 Oct 2022 22:16:50 +0200 (CEST)
Message-ID: <28cf6d46-23ee-51c6-53b8-3ff415d9c2a3@somainline.org>
Date:   Sat, 1 Oct 2022 22:16:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm6125: Add I2C and SPI nodes
Content-Language: en-US
To:     Martin Botka <martin.botka@somainline.org>, martin.botka1@gmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221001185628.494884-1-martin.botka@somainline.org>
 <20221001185628.494884-2-martin.botka@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221001185628.494884-2-martin.botka@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.10.2022 20:56, Martin Botka wrote:
> This commit adds support for I2C and
> SPI on SM6125 SoC
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 296 +++++++++++++++++++++++++++
>  1 file changed, 296 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 350713742ccd..d35ea4474234 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -1076,6 +1076,302 @@ sdhc_2: mmc@4784000 {
>  			status = "disabled";
>  		};
>  
> +		qupv3_id_0: geniqup@4ac0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0x04ac0000 0x2000>;
> +			clock-names = "m-ahb", "s-ahb";
> +			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			status = "disabled";
> +
> +			i2c0: i2c@4a80000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a80000 0x4000>;
> +				interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
#-cells at the end, before status.

> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
> +				dmas = <&gpi_dma0 0 0 3 64 0>,
> +				       <&gpi_dma0 1 0 3 64 0>;
Please use constants from <dt-bindings/dma/qcom-gpi.h>.

Konrad
> +				dma-names = "tx", "rx";
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c0_default>;
> +				pinctrl-1 = <&qup_i2c0_sleep>;
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c@4a84000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a84000 0x4000>;
> +				interrupts = <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
> +				dmas = <&gpi_dma0 0 1 3 64 0>,
> +				       <&gpi_dma0 1 1 3 64 0>;
> +				dma-names = "tx", "rx";
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c1_default>;
> +				pinctrl-1 = <&qup_i2c1_sleep>;
> +				status = "disabled";
> +			};
> +
> +			i2c2: i2c@4a88000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a88000 0x4000>;
> +				interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
> +				dmas = <&gpi_dma0 0 2 3 64 0>,
> +				       <&gpi_dma0 1 2 3 64 0>;
> +				dma-names = "tx", "rx";
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c2_default>;
> +				pinctrl-1 = <&qup_i2c2_sleep>;
> +				status = "disabled";
> +			};
> +
> +			i2c3: i2c@4a8c000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a8c000 0x4000>;
> +				interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
> +				dmas = <&gpi_dma0 0 3 3 64 0>,
> +				       <&gpi_dma0 1 3 3 64 0>;
> +				dma-names = "tx", "rx";
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c3_default>;
> +				pinctrl-1 = <&qup_i2c3_sleep>;
> +				status = "disabled";
> +			};
> +
> +			i2c4: i2c@4a90000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a90000 0x4000>;
> +				interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
> +				dmas = <&gpi_dma0 0 4 3 64 0>,
> +				       <&gpi_dma0 1 4 3 64 0>;
> +				dma-names = "tx", "rx";
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c4_default>;
> +				pinctrl-1 = <&qup_i2c4_sleep>;
> +				status = "disabled";
> +			};
> +
> +			spi0: spi@4a80000 {
> +				compatible = "qcom,geni-spi";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x04a80000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi0_default>;
> +				pinctrl-1 = <&qup_spi0_sleep>;
> +				interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&gpi_dma0 0 0 1 64 0>,
> +				       <&gpi_dma0 1 0 1 64 0>;
> +				dma-names = "tx", "rx";
> +				status = "disabled";
> +			};
> +
> +			spi2: spi@4a88000 {
> +				compatible = "qcom,geni-spi";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x04a88000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi2_default>;
> +				pinctrl-1 = <&qup_spi2_sleep>;
> +				interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&gpi_dma0 0 2 1 64 0>,
> +				       <&gpi_dma0 1 2 1 64 0>;
> +				dma-names = "tx", "rx";
> +				status = "disabled";
> +			};
> +		};
> +
> +		qupv3_id_1: geniqup@4cc0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0x04cc0000 0x2000>;
> +			clock-names = "m-ahb", "s-ahb";
> +			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			status = "disabled";
> +
> +			i2c5: i2c@4c80000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04c80000 0x4000>;
> +				interrupts = <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
> +				dmas = <&gpi_dma1 0 0 3 64 0>,
> +				       <&gpi_dma1 1 0 3 64 0>;
> +				dma-names = "tx", "rx";
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c5_default>;
> +				pinctrl-1 = <&qup_i2c5_sleep>;
> +				status = "disabled";
> +			};
> +
> +			i2c6: i2c@4c84000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04c84000 0x4000>;
> +				interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
> +				dmas = <&gpi_dma1 0 1 3 64 0>,
> +				       <&gpi_dma1 1 1 3 64 0>;
> +				dma-names = "tx", "rx";
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c6_default>;
> +				pinctrl-1 = <&qup_i2c6_sleep>;
> +				status = "disabled";
> +			};
> +
> +			i2c7: i2c@4c88000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04c88000 0x4000>;
> +				interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
> +				dmas = <&gpi_dma1 0 2 3 64 0>,
> +				       <&gpi_dma1 1 2 3 64 0>;
> +				dma-names = "tx", "rx";
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c7_default>;
> +				pinctrl-1 = <&qup_i2c7_sleep>;
> +				status = "disabled";
> +			};
> +
> +			i2c8: i2c@4c8c000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04c8c000 0x4000>;
> +				interrupts = <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
> +				dmas = <&gpi_dma1 0 3 3 64 0>,
> +				       <&gpi_dma1 1 3 3 64 0>;
> +				dma-names = "tx", "rx";
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c8_default>;
> +				pinctrl-1 = <&qup_i2c8_sleep>;
> +				status = "disabled";
> +			};
> +
> +			i2c9: i2c@4c90000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04c90000 0x4000>;
> +				interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
> +				dmas = <&gpi_dma1 0 4 3 64 0>,
> +				       <&gpi_dma1 1 4 3 64 0>;
> +				dma-names = "tx", "rx";
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c9_default>;
> +				pinctrl-1 = <&qup_i2c9_sleep>;
> +				status = "disabled";
> +			};
> +
> +			spi5: spi@4c80000 {
> +				compatible = "qcom,geni-spi";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x04c80000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi5_default>;
> +				pinctrl-1 = <&qup_spi5_sleep>;
> +				interrupts = <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&gpi_dma1 0 0 1 64 0>,
> +				       <&gpi_dma1 1 0 1 64 0>;
> +				dma-names = "tx", "rx";
> +				status = "disabled";
> +			};
> +
> +			spi6: spi@4c84000 {
> +				compatible = "qcom,geni-spi";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x04c84000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi6_default>;
> +				pinctrl-1 = <&qup_spi6_sleep>;
> +				interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&gpi_dma1 0 1 1 64 0>,
> +				       <&gpi_dma1 1 1 1 64 0>;
> +				dma-names = "tx", "rx";
> +				status = "disabled";
> +			};
> +
> +			spi8: spi@4c8c000 {
> +				compatible = "qcom,geni-spi";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x04c8c000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi8_default>;
> +				pinctrl-1 = <&qup_spi8_sleep>;
> +				interrupts = <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&gpi_dma1 0 3 1 64 0>,
> +				       <&gpi_dma1 1 3 1 64 0>;
> +				dma-names = "tx", "rx";
> +				status = "disabled";
> +			};
> +
> +			spi9: spi@4c90000 {
> +				compatible = "qcom,geni-spi";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x04c90000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi9_default>;
> +				pinctrl-1 = <&qup_spi9_sleep>;
> +				interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&gpi_dma1 0 4 1 64 0>,
> +				       <&gpi_dma1 1 4 1 64 0>;
> +				dma-names = "tx", "rx";
> +				status = "disabled";
> +			};
> +		};
> +
>  		usb3: usb@4ef8800 {
>  			compatible = "qcom,sm6125-dwc3", "qcom,dwc3";
>  			reg = <0x04ef8800 0x400>;

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020715F7E42
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJGTnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJGTnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:43:17 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58503AA3E9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:43:15 -0700 (PDT)
Received: from [192.168.1.101] (95.49.30.201.neoplus.adsl.tpnet.pl [95.49.30.201])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 39D5A200A6;
        Fri,  7 Oct 2022 21:43:13 +0200 (CEST)
Message-ID: <4bd98fa8-6721-8b4b-9e84-12d732bc34bd@somainline.org>
Date:   Fri, 7 Oct 2022 21:43:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8150: align TLMM pin
 configuration with DT schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221006144518.256956-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221006144518.256956-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.10.2022 16:45, Krzysztof Kozlowski wrote:
> DT schema expects TLMM pin configuration nodes to be named with
> '-state' suffix and their optional children with '-pins' suffix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts      |  60 ++-
>  .../dts/qcom/sm8150-microsoft-surface-duo.dts |   2 +-
>  arch/arm64/boot/dts/qcom/sm8150.dtsi          | 376 ++++++------------
>  3 files changed, 157 insertions(+), 281 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> index 87ab0e1ecd16..06d0b6edd48a 100644
> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> @@ -477,26 +477,26 @@ &pcie1_phy {
>  &tlmm {
>  	gpio-reserved-ranges = <0 4>;
>  
> -	sdc2_on: sdc2_on {
> -		clk {
> +	sdc2_on: sdc2-on-state {
> +		clk-pins {
>  			pins = "sdc2_clk";
>  			bias-disable;		/* No pull */
>  			drive-strength = <16>;	/* 16 MA */
I think these comments could go as well? The properties are rather self-explanatory.

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  		};
>  
> -		cmd {
> +		cmd-pins {
>  			pins = "sdc2_cmd";
>  			bias-pull-up;		/* pull up */
>  			drive-strength = <16>;	/* 16 MA */
>  		};
>  
> -		data {
> +		data-pins {
>  			pins = "sdc2_data";
>  			bias-pull-up;		/* pull up */
>  			drive-strength = <16>;	/* 16 MA */
>  		};
>  
> -		sd-cd {
> +		sd-cd-pins {
>  			pins = "gpio96";
>  			function = "gpio";
>  			bias-pull-up;		/* pull up */
> @@ -504,26 +504,26 @@ sd-cd {
>  		};
>  	};
>  
> -	sdc2_off: sdc2_off {
> -		clk {
> +	sdc2_off: sdc2-off-state {
> +		clk-pins {
>  			pins = "sdc2_clk";
>  			bias-disable;		/* No pull */
>  			drive-strength = <2>;	/* 2 MA */
>  		};
>  
> -		cmd {
> +		cmd-pins {
>  			pins = "sdc2_cmd";
>  			bias-pull-up;		/* pull up */
>  			drive-strength = <2>;	/* 2 MA */
>  		};
>  
> -		data {
> +		data-pins {
>  			pins = "sdc2_data";
>  			bias-pull-up;		/* pull up */
>  			drive-strength = <2>;	/* 2 MA */
>  		};
>  
> -		sd-cd {
> +		sd-cd-pins {
>  			pins = "gpio96";
>  			function = "gpio";
>  			bias-pull-up;		/* pull up */
> @@ -531,66 +531,62 @@ sd-cd {
>  		};
>  	};
>  
> -	usb2phy_ac_en1_default: usb2phy_ac_en1_default {
> -		mux {
> -			pins = "gpio113";
> -			function = "usb2phy_ac";
> -			bias-disable;
> -			drive-strength = <2>;
> -		};
> +	usb2phy_ac_en1_default: usb2phy-ac-en1-default-state {
> +		pins = "gpio113";
> +		function = "usb2phy_ac";
> +		bias-disable;
> +		drive-strength = <2>;
>  	};
>  
> -	usb2phy_ac_en2_default: usb2phy_ac_en2_default {
> -		mux {
> -			pins = "gpio123";
> -			function = "usb2phy_ac";
> -			bias-disable;
> -			drive-strength = <2>;
> -		};
> +	usb2phy_ac_en2_default: usb2phy-ac-en2-default-state {
> +		pins = "gpio123";
> +		function = "usb2phy_ac";
> +		bias-disable;
> +		drive-strength = <2>;
>  	};
>  
> -	ethernet_defaults: ethernet-defaults {
> -		mdc {
> +	ethernet_defaults: ethernet-defaults-state {
> +		mdc-pins {
>  			pins = "gpio7";
>  			function = "rgmii";
>  			bias-pull-up;
>  		};
>  
> -		mdio {
> +		mdio-pins {
>  			pins = "gpio59";
>  			function = "rgmii";
>  			bias-pull-up;
>  		};
>  
> -		rgmii-rx {
> +		rgmii-rx-pins {
>  			pins = "gpio117", "gpio118", "gpio119", "gpio120", "gpio115", "gpio116";
>  			function = "rgmii";
>  			bias-disable;
>  			drive-strength = <2>;
>  		};
>  
> -		rgmii-tx {
> +		rgmii-tx-pins {
>  			pins = "gpio122", "gpio4", "gpio5", "gpio6", "gpio114", "gpio121";
>  			function = "rgmii";
>  			bias-pull-up;
>  			drive-strength = <16>;
>  		};
>  
> -		phy-intr {
> +		phy-intr-pins {
>  			pins = "gpio124";
>  			function = "emac_phy";
>  			bias-disable;
>  			drive-strength = <8>;
>  		};
>  
> -		pps {
> +		pps-pins {
>  			pins = "gpio81";
>  			function = "emac_pps";
>  			bias-disable;
>  			drive-strength = <8>;
>  		};
>  
> -		phy-reset {
> +		phy-reset-pins {
>  			pins = "gpio79";
>  			function = "gpio";
>  			bias-pull-up;
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
> index bb278ecac3fa..5397fba9417b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
> @@ -475,7 +475,7 @@ &pon_resin {
>  &tlmm {
>  	gpio-reserved-ranges = <126 4>;
>  
> -	da7280_intr_default: da7280-intr-default {
> +	da7280_intr_default: da7280-intr-default-state {
>  		pins = "gpio42";
>  		function = "gpio";
>  		bias-pull-up;
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index cef8c4f4f0ff..18195ae2d021 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -2276,422 +2276,302 @@ tlmm: pinctrl@3100000 {
>  			#interrupt-cells = <2>;
>  			wakeup-parent = <&pdc>;
>  
> -			qup_i2c0_default: qup-i2c0-default {
> -				mux {
> -					pins = "gpio0", "gpio1";
> -					function = "qup0";
> -				};
> -
> -				config {
> -					pins = "gpio0", "gpio1";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c0_default: qup-i2c0-default-state {
> +				pins = "gpio0", "gpio1";
> +				function = "qup0";
> +				drive-strength = <0x02>;
> +				bias-disable;
>  			};
>  
> -			qup_spi0_default: qup-spi0-default {
> +			qup_spi0_default: qup-spi0-default-state {
>  				pins = "gpio0", "gpio1", "gpio2", "gpio3";
>  				function = "qup0";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			qup_i2c1_default: qup-i2c1-default {
> -				mux {
> -					pins = "gpio114", "gpio115";
> -					function = "qup1";
> -				};
> -
> -				config {
> -					pins = "gpio114", "gpio115";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c1_default: qup-i2c1-default-state {
> +				pins = "gpio114", "gpio115";
> +				function = "qup1";
> +				drive-strength = <2>;
> +				bias-disable;
>  			};
>  
> -			qup_spi1_default: qup-spi1-default {
> +			qup_spi1_default: qup-spi1-default-state {
>  				pins = "gpio114", "gpio115", "gpio116", "gpio117";
>  				function = "qup1";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			qup_i2c2_default: qup-i2c2-default {
> -				mux {
> -					pins = "gpio126", "gpio127";
> -					function = "qup2";
> -				};
> -
> -				config {
> -					pins = "gpio126", "gpio127";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c2_default: qup-i2c2-default-state {
> +				pins = "gpio126", "gpio127";
> +				function = "qup2";
> +				drive-strength = <2>;
> +				bias-disable;
>  			};
>  
> -			qup_spi2_default: qup-spi2-default {
> +			qup_spi2_default: qup-spi2-default-state {
>  				pins = "gpio126", "gpio127", "gpio128", "gpio129";
>  				function = "qup2";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			qup_i2c3_default: qup-i2c3-default {
> -				mux {
> -					pins = "gpio144", "gpio145";
> -					function = "qup3";
> -				};
> -
> -				config {
> -					pins = "gpio144", "gpio145";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c3_default: qup-i2c3-default-state {
> +				pins = "gpio144", "gpio145";
> +				function = "qup3";
> +				drive-strength = <2>;
> +				bias-disable;
>  			};
>  
> -			qup_spi3_default: qup-spi3-default {
> +			qup_spi3_default: qup-spi3-default-state {
>  				pins = "gpio144", "gpio145", "gpio146", "gpio147";
>  				function = "qup3";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			qup_i2c4_default: qup-i2c4-default {
> -				mux {
> -					pins = "gpio51", "gpio52";
> -					function = "qup4";
> -				};
> -
> -				config {
> -					pins = "gpio51", "gpio52";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c4_default: qup-i2c4-default-state {
> +				pins = "gpio51", "gpio52";
> +				function = "qup4";
> +				drive-strength = <2>;
> +				bias-disable;
>  			};
>  
> -			qup_spi4_default: qup-spi4-default {
> +			qup_spi4_default: qup-spi4-default-state {
>  				pins = "gpio51", "gpio52", "gpio53", "gpio54";
>  				function = "qup4";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			qup_i2c5_default: qup-i2c5-default {
> -				mux {
> -					pins = "gpio121", "gpio122";
> -					function = "qup5";
> -				};
> -
> -				config {
> -					pins = "gpio121", "gpio122";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c5_default: qup-i2c5-default-state {
> +				pins = "gpio121", "gpio122";
> +				function = "qup5";
> +				drive-strength = <2>;
> +				bias-disable;
>  			};
>  
> -			qup_spi5_default: qup-spi5-default {
> +			qup_spi5_default: qup-spi5-default-state {
>  				pins = "gpio119", "gpio120", "gpio121", "gpio122";
>  				function = "qup5";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			qup_i2c6_default: qup-i2c6-default {
> -				mux {
> -					pins = "gpio6", "gpio7";
> -					function = "qup6";
> -				};
> -
> -				config {
> -					pins = "gpio6", "gpio7";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c6_default: qup-i2c6-default-state {
> +				pins = "gpio6", "gpio7";
> +				function = "qup6";
> +				drive-strength = <2>;
> +				bias-disable;
>  			};
>  
> -			qup_spi6_default: qup-spi6_default {
> +			qup_spi6_default: qup-spi6_default-state {
>  				pins = "gpio4", "gpio5", "gpio6", "gpio7";
>  				function = "qup6";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			qup_i2c7_default: qup-i2c7-default {
> -				mux {
> -					pins = "gpio98", "gpio99";
> -					function = "qup7";
> -				};
> -
> -				config {
> -					pins = "gpio98", "gpio99";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c7_default: qup-i2c7-default-state {
> +				pins = "gpio98", "gpio99";
> +				function = "qup7";
> +				drive-strength = <2>;
> +				bias-disable;
>  			};
>  
> -			qup_spi7_default: qup-spi7_default {
> +			qup_spi7_default: qup-spi7_default-state {
>  				pins = "gpio98", "gpio99", "gpio100", "gpio101";
>  				function = "qup7";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			qup_i2c8_default: qup-i2c8-default {
> -				mux {
> -					pins = "gpio88", "gpio89";
> -					function = "qup8";
> -				};
> -
> -				config {
> -					pins = "gpio88", "gpio89";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c8_default: qup-i2c8-default-state {
> +				pins = "gpio88", "gpio89";
> +				function = "qup8";
> +				drive-strength = <2>;
> +				bias-disable;
>  			};
>  
> -			qup_spi8_default: qup-spi8-default {
> +			qup_spi8_default: qup-spi8-default-state {
>  				pins = "gpio88", "gpio89", "gpio90", "gpio91";
>  				function = "qup8";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			qup_i2c9_default: qup-i2c9-default {
> -				mux {
> -					pins = "gpio39", "gpio40";
> -					function = "qup9";
> -				};
> -
> -				config {
> -					pins = "gpio39", "gpio40";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c9_default: qup-i2c9-default-state {
> +				pins = "gpio39", "gpio40";
> +				function = "qup9";
> +				drive-strength = <2>;
> +				bias-disable;
>  			};
>  
> -			qup_spi9_default: qup-spi9-default {
> +			qup_spi9_default: qup-spi9-default-state {
>  				pins = "gpio39", "gpio40", "gpio41", "gpio42";
>  				function = "qup9";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			qup_i2c10_default: qup-i2c10-default {
> -				mux {
> -					pins = "gpio9", "gpio10";
> -					function = "qup10";
> -				};
> -
> -				config {
> -					pins = "gpio9", "gpio10";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c10_default: qup-i2c10-default-state {
> +				pins = "gpio9", "gpio10";
> +				function = "qup10";
> +				drive-strength = <2>;
> +				bias-disable;
>  			};
>  
> -			qup_spi10_default: qup-spi10-default {
> +			qup_spi10_default: qup-spi10-default-state {
>  				pins = "gpio9", "gpio10", "gpio11", "gpio12";
>  				function = "qup10";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			qup_i2c11_default: qup-i2c11-default {
> -				mux {
> -					pins = "gpio94", "gpio95";
> -					function = "qup11";
> -				};
> -
> -				config {
> -					pins = "gpio94", "gpio95";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c11_default: qup-i2c11-default-state {
> +				pins = "gpio94", "gpio95";
> +				function = "qup11";
> +				drive-strength = <2>;
> +				bias-disable;
>  			};
>  
> -			qup_spi11_default: qup-spi11-default {
> +			qup_spi11_default: qup-spi11-default-state {
>  				pins = "gpio92", "gpio93", "gpio94", "gpio95";
>  				function = "qup11";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			qup_i2c12_default: qup-i2c12-default {
> -				mux {
> -					pins = "gpio83", "gpio84";
> -					function = "qup12";
> -				};
> -
> -				config {
> -					pins = "gpio83", "gpio84";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c12_default: qup-i2c12-default-state {
> +				pins = "gpio83", "gpio84";
> +				function = "qup12";
> +				drive-strength = <2>;
> +				bias-disable;
>  			};
>  
> -			qup_spi12_default: qup-spi12-default {
> +			qup_spi12_default: qup-spi12-default-state {
>  				pins = "gpio83", "gpio84", "gpio85", "gpio86";
>  				function = "qup12";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			qup_i2c13_default: qup-i2c13-default {
> -				mux {
> -					pins = "gpio43", "gpio44";
> -					function = "qup13";
> -				};
> -
> -				config {
> -					pins = "gpio43", "gpio44";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c13_default: qup-i2c13-default-state {
> +				pins = "gpio43", "gpio44";
> +				function = "qup13";
> +				drive-strength = <2>;
> +				bias-disable;
>  			};
>  
> -			qup_spi13_default: qup-spi13-default {
> +			qup_spi13_default: qup-spi13-default-state {
>  				pins = "gpio43", "gpio44", "gpio45", "gpio46";
>  				function = "qup13";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			qup_i2c14_default: qup-i2c14-default {
> -				mux {
> -					pins = "gpio47", "gpio48";
> -					function = "qup14";
> -				};
> -
> -				config {
> -					pins = "gpio47", "gpio48";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c14_default: qup-i2c14-default-state {
> +				pins = "gpio47", "gpio48";
> +				function = "qup14";
> +				drive-strength = <2>;
> +				bias-disable;
>  			};
>  
> -			qup_spi14_default: qup-spi14-default {
> +			qup_spi14_default: qup-spi14-default-state {
>  				pins = "gpio47", "gpio48", "gpio49", "gpio50";
>  				function = "qup14";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			qup_i2c15_default: qup-i2c15-default {
> -				mux {
> -					pins = "gpio27", "gpio28";
> -					function = "qup15";
> -				};
> -
> -				config {
> -					pins = "gpio27", "gpio28";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c15_default: qup-i2c15-default-state {
> +				pins = "gpio27", "gpio28";
> +				function = "qup15";
> +				drive-strength = <2>;
> +				bias-disable;
>  			};
>  
> -			qup_spi15_default: qup-spi15-default {
> +			qup_spi15_default: qup-spi15-default-state {
>  				pins = "gpio27", "gpio28", "gpio29", "gpio30";
>  				function = "qup15";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			qup_i2c16_default: qup-i2c16-default {
> -				mux {
> -					pins = "gpio86", "gpio85";
> -					function = "qup16";
> -				};
> -
> -				config {
> -					pins = "gpio86", "gpio85";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c16_default: qup-i2c16-default-state {
> +				pins = "gpio86", "gpio85";
> +				function = "qup16";
> +				drive-strength = <2>;
> +				bias-disable;
>  			};
>  
> -			qup_spi16_default: qup-spi16-default {
> +			qup_spi16_default: qup-spi16-default-state {
>  				pins = "gpio83", "gpio84", "gpio85", "gpio86";
>  				function = "qup16";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			qup_i2c17_default: qup-i2c17-default {
> -				mux {
> -					pins = "gpio55", "gpio56";
> -					function = "qup17";
> -				};
> -
> -				config {
> -					pins = "gpio55", "gpio56";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c17_default: qup-i2c17-default-state {
> +				pins = "gpio55", "gpio56";
> +				function = "qup17";
> +				drive-strength = <2>;
> +				bias-disable;
>  			};
>  
> -			qup_spi17_default: qup-spi17-default {
> +			qup_spi17_default: qup-spi17-default-state {
>  				pins = "gpio55", "gpio56", "gpio57", "gpio58";
>  				function = "qup17";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			qup_i2c18_default: qup-i2c18-default {
> -				mux {
> -					pins = "gpio23", "gpio24";
> -					function = "qup18";
> -				};
> -
> -				config {
> -					pins = "gpio23", "gpio24";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c18_default: qup-i2c18-default-state {
> +				pins = "gpio23", "gpio24";
> +				function = "qup18";
> +				drive-strength = <2>;
> +				bias-disable;
>  			};
>  
> -			qup_spi18_default: qup-spi18-default {
> +			qup_spi18_default: qup-spi18-default-state {
>  				pins = "gpio23", "gpio24", "gpio25", "gpio26";
>  				function = "qup18";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			qup_i2c19_default: qup-i2c19-default {
> -				mux {
> -					pins = "gpio57", "gpio58";
> -					function = "qup19";
> -				};
> -
> -				config {
> -					pins = "gpio57", "gpio58";
> -					drive-strength = <0x02>;
> -					bias-disable;
> -				};
> +			qup_i2c19_default: qup-i2c19-default-state {
> +				pins = "gpio57", "gpio58";
> +				function = "qup19";
> +				drive-strength = <2>;
> +				bias-disable;
>  			};
>  
> -			qup_spi19_default: qup-spi19-default {
> +			qup_spi19_default: qup-spi19-default-state {
>  				pins = "gpio55", "gpio56", "gpio57", "gpio58";
>  				function = "qup19";
>  				drive-strength = <6>;
>  				bias-disable;
>  			};
>  
> -			pcie0_default_state: pcie0-default {
> -				perst {
> +			pcie0_default_state: pcie0-default-state {
> +				perst-pins {
>  					pins = "gpio35";
>  					function = "gpio";
>  					drive-strength = <2>;
>  					bias-pull-down;
>  				};
>  
> -				clkreq {
> +				clkreq-pins {
>  					pins = "gpio36";
>  					function = "pci_e0";
>  					drive-strength = <2>;
>  					bias-pull-up;
>  				};
>  
> -				wake {
> +				wake-pins {
>  					pins = "gpio37";
>  					function = "gpio";
>  					drive-strength = <2>;
> @@ -2699,22 +2579,22 @@ wake {
>  				};
>  			};
>  
> -			pcie1_default_state: pcie1-default {
> -				perst {
> +			pcie1_default_state: pcie1-default-state {
> +				perst-pins {
>  					pins = "gpio102";
>  					function = "gpio";
>  					drive-strength = <2>;
>  					bias-pull-down;
>  				};
>  
> -				clkreq {
> +				clkreq-pins {
>  					pins = "gpio103";
>  					function = "pci_e1";
>  					drive-strength = <2>;
>  					bias-pull-up;
>  				};
>  
> -				wake {
> +				wake-pins {
>  					pins = "gpio104";
>  					function = "gpio";
>  					drive-strength = <2>;

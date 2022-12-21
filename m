Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7906C653864
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbiLUWKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiLUWKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:10:08 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA00B1B78D;
        Wed, 21 Dec 2022 14:10:05 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 86ABF20404;
        Wed, 21 Dec 2022 23:10:02 +0100 (CET)
Date:   Wed, 21 Dec 2022 23:10:00 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, konrad.dybcio@linaro.org,
        andersson@kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Move SDHC node(s)'s 'pinctrl'
 properties to dts
Message-ID: <20221221221000.mmahq3nsmyy2bowi@SoMainline.org>
References: <20221220113616.1556097-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220113616.1556097-1-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-20 17:06:16, Bhupesh Sharma wrote:
> Normally the 'pinctrl' properties of a SDHC controller and the
> chip detect pin settings are dependent on the type of the slots
> (for e.g uSD card slot), regulators and GPIO(s) available on the
> board(s).

I always thought it was okay to give the `sdcX_*` pins to the sdhc_X
node unconditionally in SoC DTSI, and leave board-dependent card-detect
(if this SDHCI slot is even used for removable cards) pins to the board
DTS.

> So, move the same from the sm6115 dtsi file to the respective
> board file(s).
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks for cleaning this up, we're already using this pattern in quite a
few SoCs now.

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

Though...

> ---
>  .../boot/dts/qcom/sm4250-oneplus-billie2.dts  | 10 +++++++++
>  arch/arm64/boot/dts/qcom/sm6115.dtsi          | 22 -------------------
>  2 files changed, 10 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> index a3f1c7c41fd73..329eb496bbc5f 100644
> --- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> @@ -202,12 +202,22 @@ &sdhc_2 {
>  	vqmmc-supply = <&vreg_l5a>;
>  
>  	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_state_on &sdc2_card_det_n>;
> +	pinctrl-1 = <&sdc2_state_off &sdc2_card_det_n>;
>  
>  	status = "okay";
>  };
>  
>  &tlmm {
>  	gpio-reserved-ranges = <14 4>;
> +
> +	sdc2_card_det_n: sd-card-det-n-state {
> +		pins = "gpio88";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;

Note that SoC DTSI uses bias-disable in the off state.

> +	};
>  };
>  
>  &ufs_mem_hc {
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 572bf04adf906..6be763d39870d 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -518,13 +518,6 @@ data-pins {
>  					bias-pull-up;
>  					drive-strength = <10>;
>  				};
> -
> -				sd-cd-pins {
> -					pins = "gpio88";
> -					function = "gpio";
> -					bias-pull-up;
> -					drive-strength = <2>;
> -				};
>  			};
>  
>  			sdc2_state_off: sdc2-off-state {
> @@ -545,13 +538,6 @@ data-pins {
>  					bias-pull-up;
>  					drive-strength = <2>;
>  				};
> -
> -				sd-cd-pins {
> -					pins = "gpio88";
> -					function = "gpio";
> -					bias-disable;
> -					drive-strength = <2>;
> -				};
>  			};
>  		};
>  
> @@ -652,10 +638,6 @@ sdhc_1: mmc@4744000 {
>  				 <&gcc GCC_SDCC1_ICE_CORE_CLK>;
>  			clock-names = "iface", "core", "xo", "ice";
>  
> -			pinctrl-0 = <&sdc1_state_on>;
> -			pinctrl-1 = <&sdc1_state_off>;
> -			pinctrl-names = "default", "sleep";
> -

You can probably leave these and below?  Only boards needing to extend
pinctrl with board-specific SDCard pins would have to update/override
these properties that way?

- Marijn

>  			bus-width = <8>;
>  			status = "disabled";
>  		};
> @@ -672,10 +654,6 @@ sdhc_2: mmc@4784000 {
>  			clocks = <&gcc GCC_SDCC2_AHB_CLK>, <&gcc GCC_SDCC2_APPS_CLK>, <&xo_board>;
>  			clock-names = "iface", "core", "xo";
>  
> -			pinctrl-0 = <&sdc2_state_on>;
> -			pinctrl-1 = <&sdc2_state_off>;
> -			pinctrl-names = "default", "sleep";
> -
>  			power-domains = <&rpmpd SM6115_VDDCX>;
>  			operating-points-v2 = <&sdhc2_opp_table>;
>  			iommus = <&apps_smmu 0x00a0 0x0>;
> -- 
> 2.38.1
> 

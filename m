Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9104D66D531
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 04:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbjAQD4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 22:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbjAQD4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 22:56:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194822365E;
        Mon, 16 Jan 2023 19:56:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6B076118B;
        Tue, 17 Jan 2023 03:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB26C433D2;
        Tue, 17 Jan 2023 03:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673927794;
        bh=37Z5aM0AweEaN1rzCXFNF5sDDfEJ8FtEbJ64DoW5oaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l9ivBCHVpRob6okL4TvnRfNR9jnA0/jkneuVhmF5gT/F/S6NGKEX7HmmxGH2WpsHX
         sbmdE1043ymge/B7Rm/HS8VZBIgR6Anse+BAR3JbMrtqjExKxWzcSUDcIzapf7JGvB
         r6aH7NlQuoksMjLv0ZelFUreaOvNCcwohlmEWZRahD8/YPHcCnscD6Wdg1OzRAqiM6
         l5FsNGODWh3vYq8ZcsECasa+NUPS5v1kg9Vi5va/b07MiE1TGR1enqOarEYXrorqO1
         PmXCe7Js0xs1iQn0RPR4K7tkw3ealPZtFhidkmiqEXmWyA09Dnwy/uAcN1cfyLiQnu
         NhtI1DLf5a3hw==
Date:   Mon, 16 Jan 2023 21:56:31 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] arm64: dts: qcom: sdm845: move WCD9340 codec to
 separate file
Message-ID: <20230117035631.cgi6fjdrpz5eppca@builder.lan>
References: <20230113162245.117324-1-krzysztof.kozlowski@linaro.org>
 <20230113162245.117324-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113162245.117324-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 05:22:41PM +0100, Krzysztof Kozlowski wrote:
> WCD9340 codec node is not a property of the SoC, but board.  Move it to
> separate file and include it in the specific boards.  On all others,
> keep the Slimbus node disabled as it is empty.
> 

I think this seems like a reasonable idea. But without clearly
documenting your intentions/guidelines we will soon have
sdm845-display.dtsi, sdm845-pcie.dtsi etc.

So please start there.

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../boot/dts/qcom/sdm845-audio-wcd9340.dtsi   | 69 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  1 +
>  .../qcom/sdm845-xiaomi-beryllium-common.dtsi  |  1 +
>  .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |  1 +
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 60 +---------------
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  1 +
>  .../boot/dts/qcom/sdm850-samsung-w737.dts     |  1 +
>  7 files changed, 75 insertions(+), 59 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi b/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
> new file mode 100644
> index 000000000000..5bcce7d0d709
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi

Why does this include the substring "audio"?

Regards,
Bjorn

> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SDM845 SoC device tree source
> + *
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +&slim {
> +	status = "okay";
> +
> +	slim@1 {
> +		reg = <1>;
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		wcd9340_ifd: ifd@0,0 {
> +			compatible = "slim217,250";
> +			reg = <0 0>;
> +		};
> +
> +		wcd9340: codec@1,0 {
> +			compatible = "slim217,250";
> +			reg = <1 0>;
> +			slim-ifc-dev = <&wcd9340_ifd>;
> +
> +			#sound-dai-cells = <1>;
> +
> +			interrupts-extended = <&tlmm 54 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			#clock-cells = <0>;
> +			clock-frequency = <9600000>;
> +			clock-output-names = "mclk";
> +			qcom,micbias1-microvolt = <1800000>;
> +			qcom,micbias2-microvolt = <1800000>;
> +			qcom,micbias3-microvolt = <1800000>;
> +			qcom,micbias4-microvolt = <1800000>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			wcdgpio: gpio-controller@42 {
> +				compatible = "qcom,wcd9340-gpio";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				reg = <0x42 0x2>;
> +			};
> +
> +			swm: swm@c85 {
> +				compatible = "qcom,soundwire-v1.3.0";
> +				reg = <0xc85 0x40>;
> +				interrupts-extended = <&wcd9340 20>;
> +
> +				qcom,dout-ports = <6>;
> +				qcom,din-ports = <2>;
> +				qcom,ports-sinterval-low = /bits/ 8  <0x07 0x1f 0x3f 0x7 0x1f 0x3f 0x0f 0x0f>;
> +				qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0c 0x6 0x12 0x0d 0x07 0x0a>;
> +				qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1f 0x00 0x00 0x1f 0x00 0x00>;
> +
> +				#sound-dai-cells = <1>;
> +				clocks = <&wcd9340>;
> +				clock-names = "iface";
> +				#address-cells = <2>;
> +				#size-cells = <0>;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index 6b355589edb3..3726465acbde 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
>  #include "sdm845.dtsi"
> +#include "sdm845-audio-wcd9340.dtsi"
>  #include "pm8998.dtsi"
>  #include "pmi8998.dtsi"
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> index 64de4ed9b0c8..e530a676b250 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
>  #include "sdm845.dtsi"
> +#include "sdm845-audio-wcd9340.dtsi"
>  #include "pm8998.dtsi"
>  #include "pmi8998.dtsi"
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> index a80c3dd9a2da..f81619c8a3ba 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
>  #include "sdm845.dtsi"
> +#include "sdm845-audio-wcd9340.dtsi"
>  #include "pm8998.dtsi"
>  #include "pmi8998.dtsi"
>  #include "pm8005.dtsi"
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 4c256431280a..f9b1d7a60fd6 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -3831,65 +3831,7 @@ slim: slim-ngd@171c0000 {
>  			iommus = <&apps_smmu 0x1806 0x0>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -
> -			slim@1 {
> -				reg = <1>;
> -				#address-cells = <2>;
> -				#size-cells = <0>;
> -
> -				wcd9340_ifd: ifd@0,0 {
> -					compatible = "slim217,250";
> -					reg = <0 0>;
> -				};
> -
> -				wcd9340: codec@1,0 {
> -					compatible = "slim217,250";
> -					reg = <1 0>;
> -					slim-ifc-dev = <&wcd9340_ifd>;
> -
> -					#sound-dai-cells = <1>;
> -
> -					interrupts-extended = <&tlmm 54 IRQ_TYPE_LEVEL_HIGH>;
> -					interrupt-controller;
> -					#interrupt-cells = <1>;
> -
> -					#clock-cells = <0>;
> -					clock-frequency = <9600000>;
> -					clock-output-names = "mclk";
> -					qcom,micbias1-microvolt = <1800000>;
> -					qcom,micbias2-microvolt = <1800000>;
> -					qcom,micbias3-microvolt = <1800000>;
> -					qcom,micbias4-microvolt = <1800000>;
> -
> -					#address-cells = <1>;
> -					#size-cells = <1>;
> -
> -					wcdgpio: gpio-controller@42 {
> -						compatible = "qcom,wcd9340-gpio";
> -						gpio-controller;
> -						#gpio-cells = <2>;
> -						reg = <0x42 0x2>;
> -					};
> -
> -					swm: swm@c85 {
> -						compatible = "qcom,soundwire-v1.3.0";
> -						reg = <0xc85 0x40>;
> -						interrupts-extended = <&wcd9340 20>;
> -
> -						qcom,dout-ports = <6>;
> -						qcom,din-ports = <2>;
> -						qcom,ports-sinterval-low = /bits/ 8  <0x07 0x1f 0x3f 0x7 0x1f 0x3f 0x0f 0x0f>;
> -						qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0c 0x6 0x12 0x0d 0x07 0x0a>;
> -						qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1f 0x00 0x00 0x1f 0x00 0x00>;
> -
> -						#sound-dai-cells = <1>;
> -						clocks = <&wcd9340>;
> -						clock-names = "iface";
> -						#address-cells = <2>;
> -						#size-cells = <0>;
> -					};
> -				};
> -			};
> +			status = "disabled";
>  		};
>  
>  		lmh_cluster1: lmh@17d70800 {
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index d9581f4440b3..5586c95aa1ff 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
>  #include "sdm850.dtsi"
> +#include "sdm845-audio-wcd9340.dtsi"
>  #include "pm8998.dtsi"
>  
>  /*
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> index 6730804f4e3e..40223704a2c7 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> @@ -14,6 +14,7 @@
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
>  #include "sdm850.dtsi"
> +#include "sdm845-audio-wcd9340.dtsi"
>  #include "pm8998.dtsi"
>  
>  /*
> -- 
> 2.34.1
> 

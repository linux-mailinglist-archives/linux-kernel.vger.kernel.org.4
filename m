Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE17C5EC3D7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiI0NLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiI0NLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:11:05 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0775F1577F3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:10:59 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.188.neoplus.adsl.tpnet.pl [95.49.29.188])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 38AA73F412;
        Tue, 27 Sep 2022 15:10:57 +0200 (CEST)
Message-ID: <722c4f2a-e9a8-c6e8-d83a-e6b55e51ddcb@somainline.org>
Date:   Tue, 27 Sep 2022 15:10:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 04/33] ARM: dts: qcom: sdx55: align TLMM pin
 configuration with DT schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
 <20220926074415.53100-5-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220926074415.53100-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.09.2022 09:43, Krzysztof Kozlowski wrote:
> DT schema expects TLMM pin configuration nodes to be named with
> '-state' suffix and their optional children with '-pins' suffix.  Schema
> also requires 'function' property, so two nodes for the same gpio (mux
> and config) should be merged into one.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  .../boot/dts/qcom-sdx55-telit-fn980-tlb.dts   | 45 +++++++------------
>  1 file changed, 15 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
> index a4fa468a095f..ac8b4626ae9a 100644
> --- a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
> +++ b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
> @@ -282,40 +282,25 @@ &remoteproc_mpss {
>  };
>  
>  &tlmm {
> -	pcie_ep_clkreq_default: pcie_ep_clkreq_default {
> -		mux {
> -			pins = "gpio56";
> -			function = "pcie_clkreq";
> -		};
> -		config {
> -			pins = "gpio56";
> -			drive-strength = <2>;
> -			bias-disable;
> -		};
> +	pcie_ep_clkreq_default: pcie-ep-clkreq-default-state {
> +		pins = "gpio56";
> +		function = "pcie_clkreq";
> +		drive-strength = <2>;
> +		bias-disable;
>  	};
>  
> -	pcie_ep_perst_default: pcie_ep_perst_default {
> -		mux {
> -			pins = "gpio57";
> -			function = "gpio";
> -		};
> -		config {
> -			pins = "gpio57";
> -			drive-strength = <2>;
> -			bias-pull-down;
> -		};
> +	pcie_ep_perst_default: pcie-ep-perst-default-state {
> +		pins = "gpio57";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
>  	};
>  
> -	pcie_ep_wake_default: pcie_ep_wake_default {
> -		mux {
> -			pins = "gpio53";
> -			function = "gpio";
> -		};
> -		config {
> -			pins = "gpio53";
> -			drive-strength = <2>;
> -			bias-disable;
> -		};
> +	pcie_ep_wake_default: pcie-ep-wake-default-state {
> +		pins = "gpio53";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
>  	};
>  };
>  

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCFA60EA12
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiJZUNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbiJZUNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:13:08 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92063148F49
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:13:07 -0700 (PDT)
Received: from [192.168.31.208] (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id E5E433F291;
        Wed, 26 Oct 2022 22:13:04 +0200 (CEST)
Message-ID: <1765192b-30f4-eeac-76b4-5b52b3a27813@somainline.org>
Date:   Wed, 26 Oct 2022 22:13:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8450-qrd: add SDHCI for microSD
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20221026200357.391635-1-krzysztof.kozlowski@linaro.org>
 <20221026200357.391635-5-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221026200357.391635-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/10/2022 22:03, Krzysztof Kozlowski wrote:
> Based on downstream DTS, it seems that SM8450 QRD has microSD card slot.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Not tested.
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>


Konrad

>   arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> index 017bc48430ba..c9a08608ccf4 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> @@ -427,6 +427,18 @@ &remoteproc_slpi {
>   	firmware-name = "qcom/sm8450/slpi.mbn";
>   };
>   
> +&sdhc_2 {
> +	cd-gpios = <&tlmm 92 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_default_state &sdc2_card_det_n>;
> +	pinctrl-1 = <&sdc2_sleep_state &sdc2_card_det_n>;
> +	vmmc-supply = <&vreg_l9c_2p96>;
> +	vqmmc-supply = <&vreg_l6c_1p8>;
> +	no-sdio;
> +	no-mmc;
> +	status = "okay";
> +};
> +
>   &spi4 {
>   	status = "okay";
>   };
> @@ -474,6 +486,13 @@ pinconf {
>   			bias-pull-down;
>   		};
>   	};
> +
> +	sdc2_card_det_n: sd-card-det-n-state {
> +		pins = "gpio92";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
>   };
>   
>   &uart7 {

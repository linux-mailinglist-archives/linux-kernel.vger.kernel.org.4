Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93ADC60EA06
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiJZUMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiJZUMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:12:12 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED0D13A7FC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:12:11 -0700 (PDT)
Received: from [192.168.31.208] (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B67973F73D;
        Wed, 26 Oct 2022 22:12:09 +0200 (CEST)
Message-ID: <1ce38a7a-7c4d-32b0-dd53-90fd3b708d64@somainline.org>
Date:   Wed, 26 Oct 2022 22:12:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sm8450: disable SDHCI SDR104/SDR50
 on all boards
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20221026200357.391635-1-krzysztof.kozlowski@linaro.org>
 <20221026200357.391635-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221026200357.391635-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/10/2022 22:03, Krzysztof Kozlowski wrote:
> SDHCI on SM8450 HDK also has problems with SDR104/SDR50:
>
>    mmc0: card never left busy state
>    mmc0: error -110 whilst initialising SD card
>
> so I think it is safe to assume this issue affects all SM8450 boards.
> Move the quirk disallowing these modes to the SoC DTSI, to spare people
> working on other boards the misery of debugging this issue.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

While I have no way to tell whether this is a common issue, it may as 
well be..


Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>


Konrad

>   arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts | 2 --
>   arch/arm64/boot/dts/qcom/sm8450.dtsi                          | 3 +++
>   2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
> index 718c690af8ad..ae8ba297b0b6 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
> @@ -556,8 +556,6 @@ &sdhc_2 {
>   	pinctrl-1 = <&sdc2_sleep_state &sdc2_card_det_n>;
>   	vmmc-supply = <&pm8350c_l9>;
>   	vqmmc-supply = <&pm8350c_l6>;
> -	/* Forbid SDR104/SDR50 - broken hw! */
> -	sdhci-caps-mask = <0x3 0x0>;
>   	no-sdio;
>   	no-mmc;
>   	status = "okay";
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 1df5c964c6f7..6800e05a549d 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -3412,6 +3412,9 @@ sdhc_2: sdhci@8804000 {
>   			bus-width = <4>;
>   			dma-coherent;
>   
> +			/* Forbid SDR104/SDR50 - broken hw! */
> +			sdhci-caps-mask = <0x3 0x0>;
> +
>   			status = "disabled";
>   
>   			sdhc2_opp_table: opp-table {

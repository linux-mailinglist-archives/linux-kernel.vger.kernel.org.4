Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA22613FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiJaVNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJaVNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:13:09 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5592314033;
        Mon, 31 Oct 2022 14:13:08 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.156.neoplus.adsl.tpnet.pl [95.49.29.156])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 054043EAF0;
        Mon, 31 Oct 2022 22:13:05 +0100 (CET)
Message-ID: <f05f95d4-4ca6-6da5-d239-0531cff3ddfc@somainline.org>
Date:   Mon, 31 Oct 2022 22:13:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 05/10] arm64: dts: qcom: sm6350-lena: Include pm6350 and
 configure buttons
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221030073232.22726-1-marijn.suijten@somainline.org>
 <20221030073232.22726-6-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221030073232.22726-6-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.10.2022 08:32, Marijn Suijten wrote:
> Include pm6350 to inherit its GPIO and button configuration, and
> configure "resin" to serve as volume up, and gpio2 as volume down.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  .../qcom/sm6350-sony-xperia-lena-pdx213.dts   | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 9a96000fc95b..4512b0bf7fe1 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -4,7 +4,9 @@
>   */
>  /dts-v1/;
>  
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include "sm6350.dtsi"
> +#include "pm6350.dtsi"
>  
>  / {
>  	model = "Sony Xperia 10 III";
> @@ -28,6 +30,35 @@ framebuffer: framebuffer@a0000000 {
>  			clocks = <&gcc GCC_DISP_AXI_CLK>;
>  		};
>  	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_keys_state>;
> +
> +		key-volume-down {
> +			label = "volume_down";
> +			linux,code = <KEY_VOLUMEDOWN>;
> +			gpios = <&pm6350_gpios 2 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&pm6350_gpios {
> +	gpio_keys_state: gpio-keys-state {
> +		key-volume-down-pins {
> +			pins = "gpio2";
> +			function = PMIC_GPIO_FUNC_NORMAL;
> +			power-source = <0>;
> +			bias-disable;
> +			input-enable;
> +		};
> +	};
> +};
> +
> +&pm6350_resin {
> +	linux,code = <KEY_VOLUMEUP>;
> +	status = "okay";
>  };
>  
>  &sdc2_off_state {

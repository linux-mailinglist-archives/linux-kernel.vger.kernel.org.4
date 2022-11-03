Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CD361896A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiKCULh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiKCULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:11:31 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F23B20341
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:11:29 -0700 (PDT)
Received: from [192.168.31.208] (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 82DB21F8A3;
        Thu,  3 Nov 2022 21:11:24 +0100 (CET)
Message-ID: <e90bbbeb-c4c2-98e6-4fe4-430b61173f61@somainline.org>
Date:   Thu, 3 Nov 2022 21:11:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v4 12/12] arm64: dts: qcom: sc8280xp-x13s: Add thermal
 zone support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johan+linaro@kernel.org, quic_jprakash@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org
References: <20221103095810.64606-1-manivannan.sadhasivam@linaro.org>
 <20221103095810.64606-13-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221103095810.64606-13-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/11/2022 10:58, Manivannan Sadhasivam wrote:
> Add thermal zone support by making use of the thermistor SYS_THERM6.
> Based on experiments, this thermistor seems to reflect the actual
> surface temperature of the laptop.
>
> For the cooling device, all BIG CPU cores are throttled down to keep the
> temperature at a sane level.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Taking into account your explanations from our thread on v2,


Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>


Konrad

>   .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 46 +++++++++++++++++++
>   1 file changed, 46 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index bdaacf1abf9f..60dbc736f4d7 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -29,6 +29,52 @@ backlight {
>   		pinctrl-0 = <&edp_bl_en>, <&edp_bl_pwm>;
>   	};
>   
> +	thermal-zones {
> +		skin-temp-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&pmk8280_adc_tm 5>;
> +
> +			trips {
> +				skin_temp_alert0: trip-point0 {
> +					temperature = <55000>;
> +					hysteresis = <1000>;
> +					type = "passive";
> +				};
> +
> +				skin_temp_alert1: trip-point1 {
> +					temperature = <58000>;
> +					hysteresis = <1000>;
> +					type = "passive";
> +				};
> +
> +				skin-temp-crit {
> +					temperature = <73000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&skin_temp_alert0>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +
> +				map1 {
> +					trip = <&skin_temp_alert1>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +	};
> +
>   	vreg_edp_bl: regulator-edp-bl {
>   		compatible = "regulator-fixed";
>   

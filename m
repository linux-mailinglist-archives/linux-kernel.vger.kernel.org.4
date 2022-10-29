Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B71B6123DB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJ2OW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJ2OWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:22:33 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724F74BD1D
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 07:20:08 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.156.neoplus.adsl.tpnet.pl [95.49.29.156])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 784D93EBD1;
        Sat, 29 Oct 2022 16:20:06 +0200 (CEST)
Message-ID: <0cc72f64-808d-c277-946f-40faf2ea84fc@somainline.org>
Date:   Sat, 29 Oct 2022 16:20:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 09/12] arm64: dts: qcom: sc8280xp-x13s: Add
 PM8280_{1/2} VADC channels
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johan+linaro@kernel.org, quic_jprakash@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org
References: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
 <20221029051449.30678-10-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221029051449.30678-10-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.10.2022 07:14, Manivannan Sadhasivam wrote:
> Add VADC channels of PM8280_{1/2} PMICs for measuring the on-chip die
> temperature and external thermistors connected to the AMUX pins.
> 
> The measurements are collected by the primary PMIC PMK8280 from the
> secondary PMICs PM8280_{1/2} and exposed over the PMK8280's VADC channels.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 18315743313b..250e1489f029 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -7,6 +7,7 @@
>  /dts-v1/;
>  
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
>  #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  
> @@ -189,6 +190,66 @@ xo-therm@44 {
>  		qcom,ratiometric;
>  		qcom,hw-settle-time = <200>;
>  	};
> +
> +	pmic-die-temp@103 {
> +		reg = <PM8350_ADC7_DIE_TEMP(1)>;
> +		label = "pm8280_1_die_temp";
> +		qcom,pre-scaling = <1 1>;
> +	};
> +
> +	sys-therm@144 {
> +		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
As I mentioned in the previous patch, maybe swapping the order of these two properties
would make it look better, but of course that doesn't affect functionality.

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
> +	};
> +
> +	sys-therm@145 {
> +		reg = <PM8350_ADC7_AMUX_THM2_100K_PU(1)>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
> +	};
> +
> +	sys-therm@146 {
> +		reg = <PM8350_ADC7_AMUX_THM3_100K_PU(1)>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
> +	};
> +
> +	sys-therm@147 {
> +		reg = <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
> +	};
> +
> +	pmic-die-temp@303 {
> +		reg = <PM8350_ADC7_DIE_TEMP(3)>;
> +		label = "pm8250_2_die_temp";
> +		qcom,pre-scaling = <1 1>;
> +	};
> +
> +	sys-therm@344 {
> +		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(3)>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
> +	};
> +
> +	sys-therm@345 {
> +		reg = <PM8350_ADC7_AMUX_THM2_100K_PU(3)>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
> +	};
> +
> +	sys-therm@346 {
> +		reg = <PM8350_ADC7_AMUX_THM3_100K_PU(3)>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
> +	};
> +
> +	sys-therm@347 {
> +		reg = <PM8350_ADC7_AMUX_THM4_100K_PU(3)>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
> +	};
>  };
>  
>  &qup0 {

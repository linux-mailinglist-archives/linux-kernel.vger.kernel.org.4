Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488ED617A85
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiKCKCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiKCKCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:02:38 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B4E26F0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 03:02:37 -0700 (PDT)
Received: from [192.168.31.208] (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id C26BA20240;
        Thu,  3 Nov 2022 11:02:29 +0100 (CET)
Message-ID: <e46c817b-1a3b-d20c-22e7-a67b7684f17b@somainline.org>
Date:   Thu, 3 Nov 2022 11:02:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v2 12/12] arm64: dts: qcom: sc8280xp-x13s: Add thermal
 zone support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org
References: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
 <20221029051449.30678-13-manivannan.sadhasivam@linaro.org>
 <90b7e0e0-a354-f64d-8c53-aa80df684a3a@somainline.org>
 <20221103055014.GA8434@thinkpad>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221103055014.GA8434@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/11/2022 06:50, Manivannan Sadhasivam wrote:
> On Sat, Oct 29, 2022 at 04:29:05PM +0200, Konrad Dybcio wrote:
>>
>> On 29.10.2022 07:14, Manivannan Sadhasivam wrote:
>>> Add thermal zone support by making use of the thermistor SYS_THERM6.
>>> Based on experiments, this thermistor seems to reflect the actual
>>> surface temperature of the laptop.
>>>
>>> For the cooling device, all BIG CPU cores are throttle down to keep the
>> s/throttle/throttled
>>
>> Is it okay to let the 4xA78C run at full throttle in thermal emergencies though?
> I don't get it. Can you elaborate?

8280xp has 4xA78C and 4xX1C. You only added the latter ones to the 
cooling map.


>
>>> temperature at a sane level.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>   .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 46 +++++++++++++++++++
>>>   1 file changed, 46 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>>> index ca77c19c6d0d..96e2fa72f782 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>>> @@ -29,6 +29,52 @@ backlight {
>>>   		pinctrl-0 = <&edp_bl_en>, <&edp_bl_pwm>;
>>>   	};
>>>   
>>> +	thermal-zones {
>>> +		skin-temp-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <0>;
>>> +			thermal-sensors = <&pmk8280_adc_tm 5>;
>>> +
>>> +			trips {
>>> +				skin_temp_alert0: trip-point0 {
>>> +					temperature = <55000>;
>>> +					hysteresis = <1000>;
>>> +					type = "passive";
>>> +				};
>>> +
>>> +				skin_temp_alert1: trip-point1 {
>>> +					temperature = <58000>;
>>> +					hysteresis = <1000>;
>>> +					type = "passive";
>>> +				};
>>> +
>>> +				skin-temp-crit {
>>> +					temperature = <73000>;
>> Ouch, I didn't know we were serving burnt fingers at the cafeteria today :D
>>
>> Or maybe this just looks scary.. The laptop looks plastic, so maybe it won't cause instant
>> burns?
>>
> 73c is what the reasonable number I came up with after some experiments. At
> this point the temperature won't burn your finger but crossing this surely
> would (that's what happening without this series).

Ok, then I suppose it's fine. Thanks!


Konrad

>
> Thanks,
> Mani
>
>> Konrad
>>> +					hysteresis = <1000>;
>>> +					type = "critical";
>>> +				};
>>> +			};
>>> +
>>> +			cooling-maps {
>>> +				map0 {
>>> +					trip = <&skin_temp_alert0>;
>>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>> +				};
>>> +
>>> +				map1 {
>>> +					trip = <&skin_temp_alert1>;
>>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>> +				};
>>> +			};
>>> +		};
>>> +	};
>>> +
>>>   	vreg_edp_bl: regulator-edp-bl {
>>>   		compatible = "regulator-fixed";
>>>   

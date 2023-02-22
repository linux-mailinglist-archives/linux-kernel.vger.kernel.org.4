Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D988D69EBA6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 01:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjBVAJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 19:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBVAJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 19:09:12 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BFE1E5F3;
        Tue, 21 Feb 2023 16:09:10 -0800 (PST)
Received: from [192.168.2.4] (bc065635.dsl.pool.telekom.hu [::ffff:188.6.86.53])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006FA81.0000000063F55D23.002C9F2E; Wed, 22 Feb 2023 01:09:07 +0100
Message-ID: <8f5bd6b1-b54b-22ad-f122-d29def914dd2@irl.hu>
Date:   Wed, 22 Feb 2023 01:09:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sdm845-oneplus: add alert-slider
Content-Language: en-US, hu
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>
References: <cover.1676850819.git.soyer@irl.hu>
 <16e6c00389bf0ee881a055f81a3dbfd5bfc9c469.1676850819.git.soyer@irl.hu>
 <be1201a5-f315-9125-8768-4719a92f07f9@linaro.org>
From:   Gergo Koteles <soyer@irl.hu>
In-Reply-To: <be1201a5-f315-9125-8768-4719a92f07f9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,
On 2023. 02. 20. 11:17, Konrad Dybcio wrote:
> 
> 
> On 20.02.2023 01:13, Gergo Koteles wrote:
>> The alert-slider is a tri-state sound profile switch found on the OnePlus 6,
>> Android maps the states to "silent", "vibrate" and "ring". Expose them as
>> ABS_SND_PROFILE events.
>> The previous GPIO numbers were wrong. Update them to the correct
>> ones.
>>
>> Co-developed-by: Caleb Connolly <caleb@connolly.tech>
>> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
>> Signed-off-by: Gergo Koteles <soyer@irl.hu>
>> ---
>>   .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 43 ++++++++++++++++++-
>>   1 file changed, 41 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
>> index 64638ea94db7..ff982dd853a9 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
>> @@ -52,6 +52,45 @@ key-vol-up {
>>   		};
>>   	};
>>   
>> +	alert-slider {
> This is out of order, alphabetically.
> 
>> +		compatible = "gpio-keys";
>> +		label = "Alert slider";
>> +
>> +		pinctrl-0 = <&alert_slider_default>;
>> +		pinctrl-names = "default";
>> +
>> +		switch-top {
>> +			label = "Silent";
>> +			linux,input-type = <EV_ABS>;
>> +			linux,code = <ABS_SND_PROFILE>;
>> +			linux,input-value = <SND_PROFILE_SILENT>;
>> +			gpios = <&tlmm 126 GPIO_ACTIVE_LOW>;
>> +			debounce-interval = <50>;
> Is there a reason it can't be the default 5ms, since it should
> more or less be a simple input ping to the userspace?
> 
Yes, it's a simple input ping to the userspace.
It works with the default 5ms also.

Thanks,
Gergo

> Other than that:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad
>> +			linux,can-disable;
>> +		};
>> +
>> +		switch-middle {
>> +			label = "Vibrate";
>> +			linux,input-type = <EV_ABS>;
>> +			linux,code = <ABS_SND_PROFILE>;
>> +			linux,input-value = <SND_PROFILE_VIBRATE>;
>> +			gpios = <&tlmm 52 GPIO_ACTIVE_LOW>;
>> +			debounce-interval = <50>;
>> +			linux,can-disable;
>> +
>> +		};
>> +
>> +		switch-bottom {
>> +			label = "Ring";
>> +			linux,input-type = <EV_ABS>;
>> +			linux,code = <ABS_SND_PROFILE>;
>> +			linux,input-value = <SND_PROFILE_RING>;
>> +			gpios = <&tlmm 24 GPIO_ACTIVE_LOW>;
>> +			debounce-interval = <50>;
>> +			linux,can-disable;
>> +		};
>> +	};
>> +
>>   	reserved-memory {
>>   		/*
>>   		 * The rmtfs_mem needs to be guarded due to "XPU limitations"
>> @@ -753,8 +792,8 @@ &usb_1_hsphy {
>>   &tlmm {
>>   	gpio-reserved-ranges = <0 4>, <81 4>;
>>   
>> -	tri_state_key_default: tri-state-key-default-state {
>> -		pins = "gpio40", "gpio42", "gpio26";
>> +	alert_slider_default: alert-slider-default-state {
>> +		pins = "gpio126", "gpio52", "gpio24";
>>   		function = "gpio";
>>   		drive-strength = <2>;
>>   		bias-disable;


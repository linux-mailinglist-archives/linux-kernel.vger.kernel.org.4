Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D2D6AF4DE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjCGTUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjCGTUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:20:14 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E09BD6EAA;
        Tue,  7 Mar 2023 11:04:08 -0800 (PST)
Received: from [192.168.2.4] (51b69c8d.dsl.pool.telekom.hu [::ffff:81.182.156.141])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006FEDC.0000000064078AA6.00098FCF; Tue, 07 Mar 2023 20:04:06 +0100
Message-ID: <78de9402-d14a-4897-a602-9fd214c31c20@irl.hu>
Date:   Tue, 7 Mar 2023 20:04:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845-oneplus-common: add PN553 NFC
Content-Language: en-US, hu
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
References: <20230307185942.1737867-1-soyer@irl.hu>
 <22b91a6c-7a27-039c-21b8-0d3913e73dbc@linaro.org>
From:   Gergo Koteles <soyer@irl.hu>
In-Reply-To: <22b91a6c-7a27-039c-21b8-0d3913e73dbc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023. 03. 07. 20:02, Konrad Dybcio wrote:
> 
> 
> On 7.03.2023 19:59, Gergo Koteles wrote:
>> The OnePlus 6/6T both have a NQ330 (PN553 + P73N2M0).
>> The PN533 supported by the nxp-nci-i2c driver in mainline.
>> It detects/reads NFC tags using "nfctool".
>>
>> Signed-off-by: Gergo Koteles <soyer@irl.hu>
>> ---
> Next time include a changelog below this --- line detailing
> what changed between revisions.
> 
Okey. Thanks for the suggestion and the review.

> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad
>>   .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 39 +++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
>> index 64638ea94db7..5e45801031d8 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
>> @@ -380,6 +380,24 @@ zap-shader {
>>   	};
>>   };
>>   
>> +&i2c3 {
>> +	clock-frequency = <400000>;
>> +	status = "okay";
>> +
>> +	nfc@28 {
>> +		compatible = "nxp,nxp-nci-i2c";
>> +		reg = <0x28>;
>> +
>> +		interrupts-extended = <&tlmm 63 IRQ_TYPE_EDGE_RISING>;
>> +
>> +		enable-gpios = <&tlmm 12 GPIO_ACTIVE_HIGH>;
>> +		firmware-gpios = <&tlmm 62 GPIO_ACTIVE_HIGH>;
>> +
>> +		pinctrl-0 = <&nfc_int_active &nfc_enable_active &nfc_firmware_active>;
>> +		pinctrl-names = "default";
>> +	};
>> +};
>> +
>>   &i2c10 {
>>   	status = "okay";
>>   	clock-frequency = <100000>;
>> @@ -753,6 +771,27 @@ &usb_1_hsphy {
>>   &tlmm {
>>   	gpio-reserved-ranges = <0 4>, <81 4>;
>>   
>> +	nfc_int_active: nfc-int-active-state {
>> +		pins = "gpio63";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-pull-up;
>> +	};
>> +
>> +	nfc_enable_active: nfc-enable-active-state {
>> +		pins = "gpio12";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-pull-up;
>> +	};
>> +
>> +	nfc_firmware_active: nfc-firmware-active-state {
>> +		pins = "gpio62";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-pull-up;
>> +	};
>> +
>>   	tri_state_key_default: tri-state-key-default-state {
>>   		pins = "gpio40", "gpio42", "gpio26";
>>   		function = "gpio";


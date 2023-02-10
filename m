Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE234692005
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjBJNpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjBJNpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:45:16 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6044173954;
        Fri, 10 Feb 2023 05:45:12 -0800 (PST)
Received: from [192.168.2.4] (51b6913b.dsl.pool.telekom.hu [::ffff:81.182.145.59])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006467B.0000000063E64A63.002B76FD; Fri, 10 Feb 2023 14:45:07 +0100
Message-ID: <59ea3842-1c9d-11d1-8dd9-17d5d2308357@irl.hu>
Date:   Fri, 10 Feb 2023 14:45:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sdm845-oneplus: add
 tri-state-key
Content-Language: en-US, hu
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>
References: <20230209232556.91554-1-soyer@irl.hu>
 <dd77a886-5ab4-c6d3-bb84-5849c411aa7b@linaro.org>
From:   Gergo Koteles <soyer@irl.hu>
In-Reply-To: <dd77a886-5ab4-c6d3-bb84-5849c411aa7b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023. 02. 10. 12:33, Krzysztof Kozlowski wrote:
> On 10/02/2023 00:25, Gergo Koteles wrote:
>> The tri-state-key is a sound profile switch found on the OnePlus 6,
>> Android maps the states to "mute", "vibrate" and "ring". Expose them as
>> ABS_SND_PROFILE events.
>> The previous GPIO numbers were wrong. Update them to the correct
>> ones.
>>
>> Co-developed-by: Caleb Connolly <caleb@connolly.tech>
>> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
>> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> 
> Where are other patches? I got only 3/3.
> 
Hi Krzysztof,

Sorry, I missed the --thread option for git format-patch.

>> ---
>>   .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 39 ++++++++++++++++++-
>>   1 file changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
>> index 64638ea94db7..e45d4fdead82 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
>> @@ -52,6 +52,43 @@ key-vol-up {
>>   		};
>>   	};
>>   
>> +	tri-state-key {
>> +		compatible = "gpio-keys";
>> +		label = "Tri-state key";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&tri_state_key_default>;
> 
> Missing blank line.
> 

I'll add it to v3.

>> +		state-top {
> 
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).
> 

I ran dtbs_check with 
DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/qcom.yaml. It only 
shows warnings for msm8996-oneplus3, but not for sdm845-oneplus phones. 
Is there anything else I need to check?


...
arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb: /: qcom,board-id: 'oneOf' 
conditional failed, one must be fixed:
	[8, 0, 15801, 15, 8, 0, 15801, 16] is too long
	From schema: /Documentation/devicetree/bindings/arm/qcom.yaml
...
   DTC_CHK arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb
   DTC_CHK arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dtb


Thanks,
Gergo

> 
> Best regards,
> Krzysztof
> 


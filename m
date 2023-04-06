Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405496D9E02
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbjDFQzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjDFQzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:55:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E300B2D7D;
        Thu,  6 Apr 2023 09:55:38 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 02D0C66031C3;
        Thu,  6 Apr 2023 17:55:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680800137;
        bh=cdCnEQte5eTYwNIhrAJS0DEE0QkfETi9gYQ3JiJ/g3A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=agCPh6jP8SoSWgHMQMJzuRXJx0LKX452wS8PCkLeg1gBVLOBAdXWdF4JbJ31M+ran
         jrmwfRnPw9dLLDUe+d3JtK8aSmWHFxg1d8UCYJFcTF7myUo+gnYF4MwUqiHL+Z3SRt
         BObObk3ykGxMViDLLH4tx2D9CJi41qRXRU9DPWBgkGQfZ+uV+cwZuMRmj93Fgjucb6
         hYzG+trsXBPS35tr5JI5FAJke2PnOZSGzQiygcRrSd3WXa1rifioo3uMP65ljeEwBv
         169J5xGcwAitfJELtW8T62/aQCFcwyRD3JKykzpviW/seUK6Usg5uWutq+/hUemywy
         ofpa4t5NPfnHA==
Message-ID: <5dd096fc-419f-b67a-9577-7021e36da009@collabora.com>
Date:   Thu, 6 Apr 2023 19:55:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: pwm-fan: Convert to DT schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20230404173807.490520-1-cristian.ciocaltea@collabora.com>
 <20230404173807.490520-2-cristian.ciocaltea@collabora.com>
 <20230406164527.GA3263961-robh@kernel.org>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20230406164527.GA3263961-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 19:45, Rob Herring wrote:
> On Tue, Apr 04, 2023 at 08:38:06PM +0300, Cristian Ciocaltea wrote:
>> Convert the PWM fan bindings to DT schema format.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  .../devicetree/bindings/hwmon/pwm-fan.txt     |  68 +---------
>>  .../devicetree/bindings/hwmon/pwm-fan.yaml    | 119 ++++++++++++++++++
>>  2 files changed, 120 insertions(+), 67 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
>> index 4509e688623a..48886f0ce415 100644
>> --- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
>> +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
>> @@ -1,67 +1 @@
>> -Bindings for a fan connected to the PWM lines
>> -
>> -Required properties:
>> -- compatible	: "pwm-fan"
>> -- pwms		: the PWM that is used to control the PWM fan
>> -- cooling-levels      : PWM duty cycle values in a range from 0 to 255
>> -			which correspond to thermal cooling states
>> -
>> -Optional properties:
>> -- fan-supply		: phandle to the regulator that provides power to the fan
>> -- interrupts		: This contains an interrupt specifier for each fan
>> -			  tachometer output connected to an interrupt source.
>> -			  The output signal must generate a defined number of
>> -			  interrupts per fan revolution, which require that
>> -			  it must be self resetting edge interrupts. See
>> -			  interrupt-controller/interrupts.txt for the format.
>> -- pulses-per-revolution : define the number of pulses per fan revolution for
>> -			  each tachometer input as an integer (default is 2
>> -			  interrupts per revolution). The value must be
>> -			  greater than zero.
>> -
>> -Example:
>> -	fan0: pwm-fan {
>> -		compatible = "pwm-fan";
>> -		#cooling-cells = <2>;
>> -		pwms = <&pwm 0 10000 0>;
>> -		cooling-levels = <0 102 170 230>;
>> -	};
>> -
>> -	thermal-zones {
>> -		cpu_thermal: cpu-thermal {
>> -			     thermal-sensors = <&tmu 0>;
>> -			     polling-delay-passive = <0>;
>> -			     polling-delay = <0>;
>> -			     trips {
>> -					cpu_alert1: cpu-alert1 {
>> -						    temperature = <100000>; /* millicelsius */
>> -						    hysteresis = <2000>; /* millicelsius */
>> -						    type = "passive";
>> -					};
>> -			     };
>> -			     cooling-maps {
>> -					map0 {
>> -						    trip = <&cpu_alert1>;
>> -						    cooling-device = <&fan0 0 1>;
>> -					};
>> -			     };
>> -		};
>> -
>> -Example 2:
>> -	fan0: pwm-fan {
>> -		compatible = "pwm-fan";
>> -		pwms = <&pwm 0 40000 0>;
>> -		fan-supply = <&reg_fan>;
>> -		interrupt-parent = <&gpio5>;
>> -		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
>> -		pulses-per-revolution = <2>;
>> -	};
>> -
>> -Example 3:
>> -	fan0: pwm-fan {
>> -		compatible = "pwm-fan";
>> -		pwms = <&pwm1 0 25000 0>;
>> -		interrupts-extended = <&gpio1 1 IRQ_TYPE_EDGE_FALLING>,
>> -			<&gpio2 5 IRQ_TYPE_EDGE_FALLING>;
>> -		pulses-per-revolution = <2>, <1>;
>> -	};
>> +This file has moved to pwm-fan.yaml.
>> diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml b/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
>> new file mode 100644
>> index 000000000000..048b6ea794c7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
>> @@ -0,0 +1,119 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/pwm-fan.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Fan connected to PWM lines
>> +
>> +maintainers:
>> +  - Jean Delvare <jdelvare@suse.com>
>> +  - Guenter Roeck <linux@roeck-us.net>
>> +
>> +properties:
>> +  compatible:
>> +    const: pwm-fan
>> +
>> +  cooling-levels:
>> +    description: PWM duty cycle values corresponding to thermal cooling states.
>> +    items:
>> +      maximum: 255
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +
>> +  fan-supply:
>> +    description: Phandle to the regulator that provides power to the fan.
>> +
>> +  interrupts:
>> +    description:
>> +      This contains an interrupt specifier for each fan tachometer output
>> +      connected to an interrupt source. The output signal must generate a
>> +      defined number of interrupts per fan revolution, which require that
>> +      it must be self resetting edge interrupts.
>> +    minItems: 1
>> +    maxItems: 5
> 
> I'm not so sure I'd allow for more than 1 if the example is the only 
> case we can find. More than 1 implies you have multiple fans controlled 
> by 1 PWM. What do you do with the tach data other than display it or 
> detect a stuck fan. You can't really implement any control loop unless 
> you average the rpm's? I suppose there could be h/w, so okay.

I will drop the 3rd example and use 'maxItems: 1' here. Same for
pulses-per-revolution below.

>> +
>> +  pulses-per-revolution:
>> +    description:
>> +      Define the number of pulses per fan revolution for each tachometer
>> +      input as an integer.
>> +    items:
>> +      minimum: 1
>> +      maximum: 4
>> +      default: 2
>> +    minItems: 1
>> +    maxItems: 5
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +
>> +  pwms:
>> +    description: The PWM that is used to control the fan.
>> +    maxItems: 1
>> +
>> +  pwm-names: true
> 
> Not part of the original binding. It's not that useful in general if 
> there's only 1 entry. It's completely useless if the name is not defined 
> for the OS to use. So drop it.

Ack.

>> +
>> +  "#cooling-cells":
>> +    description:
>> +      Must be 2, in order to specify minimum and maximum cooling state used in
>> +      the cooling-maps reference. The first cell is the minimum cooling state
>> +      and the second cell is the maximum cooling state requested.
> 
> Just duplicating the same text from thermal-cooling-devices.yaml is 
> pointless.
> 
>> +    const: 2
> 
> As this is globally the only allowed value, you don't need to duplicate 
> this either.
> 
> '"#cooling-cells": true"' is sufficient.

Sure, will do.

Thanks,
Cristian

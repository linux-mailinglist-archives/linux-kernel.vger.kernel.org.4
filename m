Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D325E6D68EF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbjDDQcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjDDQcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:32:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA3D172C;
        Tue,  4 Apr 2023 09:32:17 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2725F6603174;
        Tue,  4 Apr 2023 17:32:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680625935;
        bh=KuXltiexUNkpyNJrQkX/ulGpUOXgGazP2UPpdbEwY4A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LkmnNId6+hvIzALLF0eDx8nofhPV1wtsWAyQk9McBRARSAkQVYbcKgiKph3emWI+n
         Eg/p3YL9ALg5e6DiPMnwfLV/1+7PP+vuoqfrAYFzbyL27PewiJU01at8amx+YbWi5+
         epJSePU/a0SWvTPNudhSHzJ6kwOQeRrIhxciokKUa4V1I2ULxzXh/12NEi1vRJMD+v
         +cfE5n9wJQOvq8ehLBeEa5bKVcDRiOMyLP1Itr1q7D1X6oaf+tj9hXhwZBx0iuTzH/
         1kLEA+CItIKh+bKSuTJwZ4f+GSnp8r+2WQfQjeu+iJCTTr83KTJS5HnXq78SL7la9N
         IKPvXYIv+hChw==
Message-ID: <3eba05be-a836-d362-4e06-2d9f102c4113@collabora.com>
Date:   Tue, 4 Apr 2023 19:32:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: pwm-fan: Convert to DT schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20230403105052.426135-1-cristian.ciocaltea@collabora.com>
 <20230403105052.426135-2-cristian.ciocaltea@collabora.com>
 <20230404141749.GB3793612-robh@kernel.org>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20230404141749.GB3793612-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 17:17, Rob Herring wrote:
> On Mon, Apr 03, 2023 at 01:50:51PM +0300, Cristian Ciocaltea wrote:
>> Convert the PWM fan bindings to DT schema format.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  .../devicetree/bindings/hwmon/pwm-fan.txt     |  68 +----------
>>  .../devicetree/bindings/hwmon/pwm-fan.yaml    | 109 ++++++++++++++++++
>>  2 files changed, 110 insertions(+), 67 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
>>

[...]

>> diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml b/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
>> new file mode 100644
>> index 000000000000..448b48ec5d73
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
>> @@ -0,0 +1,109 @@
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
>> +    description:
>> +      PWM duty cycle values in a range from 0 to 255 which correspond to
> 
> Don't put constraints in plain text:
> 
> items:
>   maximum: 255
> 
>> +      thermal cooling states.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> 
> Unfortunately, looks like we've wound up with same property with 2 
> differing types. A problem for another day...
> 
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
> 
> How many entries? I'm not sure how more than 1 makes sense.

The 3rd example taken from the original binding uses 2 entries. So far
it seems there are no use cases requiring more than one, so I'm going to
limit this to 5 (the driver doesn't enforce a limit).

>> +
>> +  pulses-per-revolution:
>> +    description:
>> +      Define the number of pulses per fan revolution for each tachometer
>> +      input as an integer (default is 2 interrupts per revolution).
> 
> default: 2
> 
>> +      The value must be greater than zero.
> 
> minimum: 1
> 
> maximum: ??? I assume there's some practical limit here much less than 
> 2^32.

Will set it to 4, as suggested by Guenter.

>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> 
> Isn't this a scalar? 

As in the case of interrupts, the 3rd example uses 2 entries. Will set
the same limit (5).

>> +
>> +  pwms:
>> +    description: The PWM that is used to control the fan.
>> +    maxItems: 1
>> +
>> +  pwm-names: true
>> +
>> +  "#cooling-cells":
>> +    description: The PWM fan can be referenced as a cooling-device.
> 
> Not that useful. What would be is what's in the 2 cells.

Will describe its usage according to thermal-cooling-devices binding.

Thanks for reviewing,
Cristian

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220A769EC2D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 02:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjBVBDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 20:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBVBDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 20:03:18 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1F331B56B;
        Tue, 21 Feb 2023 17:03:16 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 22 Feb 2023 10:03:15 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 6C7A02058B4F;
        Wed, 22 Feb 2023 10:03:15 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Wed, 22 Feb 2023 10:03:15 +0900
Received: from [10.212.157.25] (unknown [10.212.157.25])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id DA5217BEA;
        Wed, 22 Feb 2023 10:03:14 +0900 (JST)
Message-ID: <7e19d3f4-a3bc-dc9d-35a0-9bfc05f22b2c@socionext.com>
Date:   Wed, 22 Feb 2023 10:03:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] dt-bindings: ata: Add UniPhier controller binding
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230220054711.4584-1-hayashi.kunihiko@socionext.com>
 <8a4042fd-02a3-261e-4126-7a3090850fda@linaro.org>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <8a4042fd-02a3-261e-4126-7a3090850fda@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/02/20 20:48, Krzysztof Kozlowski wrote:
> On 20/02/2023 06:47, Kunihiko Hayashi wrote:
>> Add UniPhier SATA controller compatible string to the platform binding.
>> This controller needs two or three reset controls.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../bindings/ata/ahci-platform.yaml           | 32 ++++++++++++++++---
>>   1 file changed, 27 insertions(+), 5 deletions(-)
>>
>> Changes since v2:
>> - Add compatible strings to select property
>> - Add minItems and change maxItems for resets
>> - Move condition schema under allOf property
>> - Change resets to "required" for uniphier-*-ahci
>>
>> Changes since v1:
>> - Restrict resets property changes with compatible strings
>> - Fix maxItems from two to three
>>
>> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>> b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>> index 7dc2a2e8f598..4b2ee68097b8 100644
>> --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>> @@ -30,12 +30,12 @@ select:
>>             - marvell,armada-3700-ahci
>>             - marvell,armada-8k-ahci
>>             - marvell,berlin2q-ahci
>> +          - socionext,uniphier-pro4-ahci
>> +          - socionext,uniphier-pxs2-ahci
>> +          - socionext,uniphier-pxs3-ahci
>>     required:
>>       - compatible
>>
>> -allOf:
>> -  - $ref: "ahci-common.yaml#"
>> -
>>   properties:
>>     compatible:
>>       oneOf:
>> @@ -45,6 +45,9 @@ properties:
>>                 - marvell,armada-8k-ahci
>>                 - marvell,berlin2-ahci
>>                 - marvell,berlin2q-ahci
>> +              - socionext,uniphier-pro4-ahci
>> +              - socionext,uniphier-pxs2-ahci
>> +              - socionext,uniphier-pxs3-ahci
>>             - const: generic-ahci
>>         - enum:
>>             - cavium,octeon-7130-ahci
>> @@ -67,14 +70,33 @@ properties:
>>       minItems: 1
>>       maxItems: 3
>>
>> +  resets:
>> +    minItems: 1
>> +    maxItems: 3
>> +
>>     interrupts:
>>       maxItems: 1
>>
>>     power-domains:
>>       maxItems: 1
>>
>> -  resets:
>> -    maxItems: 1
> 
> Why moving it?

Sorry for my mistake. I should fix it.

>> +allOf:
> 
> This goes to the same place as in example-schema.

I can see "allOf" next to "required" in example-schema,

>> +  - $ref: ahci-common.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - socionext,uniphier-pro4-ahci
>> +              - socionext,uniphier-pxs2-ahci
>> +              - socionext,uniphier-pxs3-ahci
>> +    then:
>> +      properties:
>> +        resets:
>> +          minItems: 2
>> +          maxItems: 3
> 
> You need to describe the items, what's expected here.

I'll add the descriptions for each reset for the compatible.
However, I'm afraid this "if" part will grow for UniPhier resets
in common ahci-platform.

> 
>> +      required:
>> +        - resets
> 
> The entire point was to add:
> 
> else - maxItems: 1

I'll add it.

Thank you,

---
Best Regards
Kunihiko Hayashi

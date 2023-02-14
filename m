Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D27695F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjBNJd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjBNJdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:33:50 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAFA023325;
        Tue, 14 Feb 2023 01:33:46 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 14 Feb 2023 18:33:45 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 6E63A2058B4F;
        Tue, 14 Feb 2023 18:33:45 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Tue, 14 Feb 2023 18:33:45 +0900
Received: from [10.212.158.247] (unknown [10.212.158.247])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id C15797367;
        Tue, 14 Feb 2023 18:33:44 +0900 (JST)
Message-ID: <ed864d57-0de3-a169-ebde-628eb84b8a21@socionext.com>
Date:   Tue, 14 Feb 2023 18:33:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] dt-bindings: ata: Add UniPhier controller binding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230213045432.32614-1-hayashi.kunihiko@socionext.com>
 <2d76ec86-6580-28b0-0f80-a5c497f8cef7@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <2d76ec86-6580-28b0-0f80-a5c497f8cef7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2023/02/13 18:10, Krzysztof Kozlowski wrote:
> On 13/02/2023 05:54, Kunihiko Hayashi wrote:
>> Add UniPhier SATA controller compatible string to the platform binding.
>> This controller needs maximum three reset controls.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../devicetree/bindings/ata/ahci-platform.yaml  | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> Changes since v1:
>> - Restrict resets property changes with compatible strings
>> - Fix maxItems from two to three
>>
>> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>> b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>> index 7dc2a2e8f598..25dd5ffaa517 100644
>> --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>> @@ -45,6 +45,9 @@ properties:
>>                 - marvell,armada-8k-ahci
>>                 - marvell,berlin2-ahci
>>                 - marvell,berlin2q-ahci
>> +              - socionext,uniphier-pro4-ahci
>> +              - socionext,uniphier-pxs2-ahci
>> +              - socionext,uniphier-pxs3-ahci
>>             - const: generic-ahci
>>         - enum:
> 
> Top level is saying reset=1, so did you test your bindings?

Umm, I didn't see any errors on dt_binding_check, anyway I'll add
initial minItems:1 and maxItems:3 on top level first.

> 
>>             - cavium,octeon-7130-ahci
>> @@ -76,6 +79,20 @@ properties:
>>     resets:
>>       maxItems: 1
>>
>> +if:
> Keep it in allOf like in example-schema. Will save you one re-indent
> pretty soon...

I see. I'll move if clause into allOf, and also move the original allOf.

>> +  properties:
>> +    compatible:
>> +      contains:
>> +        enum:
>> +          - socionext,uniphier-pro4-ahci
>> +          - socionext,uniphier-pxs2-ahci
>> +          - socionext,uniphier-pxs3-ahci
>> +then:
>> +  properties:
>> +    resets:
>> +      minItems: 1
>> +      maxItems: 3
> 
> And entire allOf goes to the place like in example-schema.

I've got it. and I'll fix it (minItems:2).

Thank you,

---
Best Regards
Kunihiko Hayashi

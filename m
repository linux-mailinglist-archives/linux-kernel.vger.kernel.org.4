Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0807C6360EF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiKWOBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbiKWOAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:00:53 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC510DF94;
        Wed, 23 Nov 2022 05:54:49 -0800 (PST)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 23 Nov
 2022 21:54:47 +0800
Message-ID: <322262b1-d3db-f190-ef69-f42d5d0522c0@amlogic.com>
Date:   Wed, 23 Nov 2022 21:54:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V5 1/4] clk: meson: S4: add support for Amlogic S4 SoC PLL
 clock driver and bindings
Content-Language: en-US
To:     <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <kelvin.zhang@amlogic.com>
References: <20221123021346.18136-1-yu.tu@amlogic.com>
 <20221123021346.18136-2-yu.tu@amlogic.com>
 <f03f331a-5666-298e-a1a2-bdb9bab11a48@linaro.org>
 <92b570ea-3ddc-8e91-5a7a-ed601bb7c02c@amlogic.com>
 <eb56ed39-cfaa-3368-a2c0-0a4e89440e40@linaro.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <eb56ed39-cfaa-3368-a2c0-0a4e89440e40@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.29.47]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On 2022/11/23 21:23, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On 23/11/2022 12:16, Yu Tu wrote:
>> Hi Krzysztof,
>>      Thank you for your reply.
>>
>> On 2022/11/23 18:08, Krzysztof Kozlowski wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On 23/11/2022 03:13, Yu Tu wrote:
>>>> Add the S4 PLL clock controller found and bindings in the s4 SoC 
>>>> family.
>>>>
>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>> ---
>>>>   .../bindings/clock/amlogic,s4-pll-clkc.yaml   |  51 +
>>>
>>> This is v5 and still bindings are here? Bindings are always separate
>>> patches. Use subject prefixes matching the subsystem (git log --oneline
>>> -- ...).
>>>
>>> And this was split, wasn't it? What happened here?!?
>>
>> Put bindings and clock driver patch together from Jerome. Maybe you 
>> can read this chat history.
>> https://lore.kernel.or/all/1jy1v6z14n.fsf@starbuckisacylon.baylibre.com/
> 
> Jerome was asking you to send 2 patchsets, one with :
> - bindings in separate patches
> - drivers in separate patches
> and a second with DT changes.
> 
> Then when the bindings + clocks patches are merged, a pull request of 
> the bindings
> can be done to me so I can merge it with DT.
> 

I may have misunderstood Jerome's advice.So should I follow the V4 patch 
format and change as Jerome suggested from V3?

>>
>>>
>>>
>>>>   MAINTAINERS                                   |   1 +
>>>>   drivers/clk/meson/Kconfig                     |  13 +
>>>>   drivers/clk/meson/Makefile                    |   1 +
>>>>   drivers/clk/meson/s4-pll.c                    | 875 
>>>> ++++++++++++++++++
>>>>   drivers/clk/meson/s4-pll.h                    |  88 ++
>>>>   .../dt-bindings/clock/amlogic,s4-pll-clkc.h   |  30 +
>>>>   7 files changed, 1059 insertions(+)
>>>>   create mode 100644 
>>>> Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
>>>>   create mode 100644 drivers/clk/meson/s4-pll.c
>>>>   create mode 100644 drivers/clk/meson/s4-pll.h
>>>>   create mode 100644 include/dt-bindings/clock/amlogic,s4-pll-clkc.h
>>>>
>>>> diff --git 
>>>> a/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml 
>>>> b/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
>>>> new file mode 100644
>>>> index 000000000000..fd517e8ef14f
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
>>>> @@ -0,0 +1,51 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/clock/amlogic,s4-pll-clkc.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Amlogic Meson S serials PLL Clock Controller
>>>> +
>>>> +maintainers:
>>>> +  - Neil Armstrong <narmstrong@baylibre.com>
>>>> +  - Jerome Brunet <jbrunet@baylibre.com>
>>>> +  - Yu Tu <yu.hu@amlogic.com>
>>>> +
>>> One blank line.
>>
>>   I will delete this, on next version patch.
>>
>>>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: amlogic,s4-pll-clkc
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  clocks:
>>>> +    maxItems: 1
>>>> +
>>>> +  clock-names:
>>>> +    items:
>>>> +      - const: xtal
>>>> +
>>>> +  "#clock-cells":
>>>> +    const: 1
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - clocks
>>>> +  - clock-names
>>>> +  - "#clock-cells"
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    clkc_pll: clock-controller@fe008000 {
>>>> +      compatible = "amlogic,s4-pll-clkc";
>>>> +      reg = <0xfe008000 0x1e8>;
>>>> +      clocks = <&xtal>;
>>>> +      clock-names = "xtal";
>>>> +      #clock-cells = <1>;
>>>> +    };
>>>
>>>
>>>> +#endif /* __MESON_S4_PLL_H__ */
>>>> diff --git a/include/dt-bindings/clock/amlogic,s4-pll-clkc.h 
>>>> b/include/dt-bindings/clock/amlogic,s4-pll-clkc.h
>>>> new file mode 100644
>>>> index 000000000000..345f87023886
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/clock/amlogic,s4-pll-clkc.h
>>>
>>> This belongs to bindings patch, not driver.
>>>
>>>> @@ -0,0 +1,30 @@
>>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>>>> +/*
>>>> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
>>>> + * Author: Yu Tu <yu.tu@amlogic.com>
>>>> + */
>>>> +
>>>> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_S4_PLL_CLKC_H
>>>> +#define _DT_BINDINGS_CLOCK_AMLOGIC_S4_PLL_CLKC_H
>>>> +
>>>> +/*
>>>> + * CLKID index values
>>>> + */
>>>> +
>>>> +#define CLKID_FIXED_PLL            1
>>>> +#define CLKID_FCLK_DIV2            3
>>>
>>> Indexes start from 0 and are incremented by 1. Not by 2.
>>>
>>> NAK.
>>
>> I remember Jerome discussing this with you.You can look at this 
>> submission history.
>> https://lore.kernel.org/all/c088e01c-0714-82be-8347-6140daf56640@linaro.org/ 
>>
> 
> Historically we did that by only exposing part of the numbers, 
> controlling which
> clocks were part of the bindings.
> 
> But it seems this doesn't make sens anymore, maybe it would be time to 
> put all the
> clock ids in the bindings for this new SoC and break with the previous 
> strategy.

That's OK with me. But I don't know if Jerome thinks it's ok?

> 
> Neil
> 
>>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>> .
> 
> .

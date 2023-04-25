Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB696EDACC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjDYDmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjDYDmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:42:50 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A08CAF39;
        Mon, 24 Apr 2023 20:42:09 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 00C7C7FFD;
        Tue, 25 Apr 2023 11:41:40 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 25 Apr
 2023 11:41:40 +0800
Received: from [192.168.125.106] (113.72.145.137) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 25 Apr
 2023 11:41:39 +0800
Message-ID: <d685a1d4-c07d-7dfa-f1fb-b35ceb2aa0eb@starfivetech.com>
Date:   Tue, 25 Apr 2023 11:41:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RESEND v2 1/6] dt-bindings: power: Add JH7110 AON PMU support
To:     Conor Dooley <conor@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <vkoul@kernel.org>,
        <linux-phy@lists.infradead.org>
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
 <20230419035646.43702-2-changhuang.liang@starfivetech.com>
 <20230419-labored-camper-644d51a7ca96@spud>
 <1a5b15fa-4f20-51c2-2ba1-a04a2911a694@starfivetech.com>
 <20230424-baffle-punch-ec73098f2b6a@spud>
Content-Language: en-US
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <20230424-baffle-punch-ec73098f2b6a@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.137]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/25 0:52, Conor Dooley wrote:
> Hey Changhuang,
> 
> On Thu, Apr 20, 2023 at 03:00:10PM +0800, Changhuang Liang wrote:
>> On 2023/4/20 2:29, Conor Dooley wrote:
>>> On Tue, Apr 18, 2023 at 08:56:41PM -0700, Changhuang Liang wrote:
>>>> Add AON PMU for StarFive JH7110 SoC, it can be used to turn on/off DPHY
>>>> rx/tx power switch, and it don't need the properties of reg and
>>>> interrupts.
>>>
>>> Putting this here since the DT guys are more likely to see it this way..
>>> Given how the implementation of the code driving this new
>>> power-controller and the code driving the existing one are rather
>>> different (you've basically re-written the entire driver in this series),
>>> should the dphy driver implement its own power-controller?
>>>
>>> I know originally Changuang had tried something along those lines:
>>> https://lore.kernel.org/linux-riscv/5dc4ddc2-9d15-ebb2-38bc-8a544ca67e0d@starfivetech.com/
>>>
>>> I see that that was shut down pretty much, partly due to the
>>> non-standard property, hence this series adding the dphy power domain to
>>> the existing driver.
>>>
>>> If it was done by looking up the pmu with a
>>> of_find_compatible_node(NULL, "power-controller", "starfive,jh7110-aon-pmu")
>>> type thing, would that make sense? Although, maybe that is not a
>>> question for you, and this series may actually have been better entirely
>>> bundled with the dphy series so the whole thing can be reviewed as a
>>> unit. I've added 
>>>
>>> IOW, don't change this patch, or the dts patch, but move all of the
>>> code back into the phy driver..
>>>
>>
>> Maybe this way can not do that? power domain is binding before driver probe,
>> if I use "of_find_compatible_node" it phy(DPHY rx) probe. Maybe I can only operate 
>> this power switch in my phy(DPHY rx) driver, so the all patch of this series isn't 
>> make sense.
> 
> I'm a wee bit lost here, as I unfortunately know little about how Linux
> handles this power-domain stuff. If the DPHY tries to probe and some
> pre-requisite does not yet exist, you can return -EPROBE_DEFER right?
> 
> But I don't think that's what you are asking, as using
> of_find_compatible_node() doesn't depend on there being a driver AFAIU.
> 
>> In my opinion, We will also submit DPHY TX module later which use this series.
>> Maybe this series should independent?
> 
> Is the DPHY tx module a different driver to the rx one?> If yes, does it have a different bit you must set in the syscon?
> 

Yes, DPHY tx module is a different driver to the DPHY rx. And I have do a
different bit in PATCH 1:

#define JH7110_PD_DPHY_TX	0
#define JH7110_PD_DPHY_RX	1

also in PATCH 5:

static const struct jh71xx_domain_info jh7110_aon_power_domains[] = {
	[JH7110_PD_DPHY_TX] = {
		.name = "DPHY-TX",
		.bit = 30,
	},
	[JH7110_PD_DPHY_RX] = {
		.name = "DPHY-RX",
		.bit = 31,
	},
};

> +CC Walker, do you have a register map for the jh7110? My TRM only says
> what the registers are, but not the bits in them. Would make life easier
> if I had that info.
> 
> I'm fine with taking this code, I just want to make sure that the soc
> driver doing this is the right thing to do.
> I was kinda hoping that combining with the DPHY-rx series might allow
> the PHY folk to spot if you are doing something here with the power
> domains that doesn't make sense.
> 

I asked about our soc colleagues. This syscon register,
offset 0x00:
bit[31] ---> dphy rx power switch
bit[30] ---> dphy tx power switch 
other bits ---> Reserved

>>> Sorry for not asking this sooner Changhuang,
>>> Conor.
>>>
>>> (hopefully this didn't get sent twice, mutt complained of a bad email
>>> addr during sending the first time)
>>>
>>
>> I'm sorry for that, I will notice later.
> 
> No, this was my mail client doing things that I was unsure of. You
> didn't do anything wrong.
> 
[...]
>>>>    - Walker Chen <walker.chen@starfivetech.com>
>>>> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
>>>>  
>>>>  description: |
>>>>    StarFive JH7110 SoC includes support for multiple power domains which can be
>>>> @@ -17,6 +18,7 @@ properties:
>>>>    compatible:
>>>>      enum:
>>>>        - starfive,jh7110-pmu
>>>> +      - starfive,jh7110-aon-pmu
> 
> I was speaking to Rob about this over the weekend, he asked:
> 'Why isn't "starfive,jh7110-aon-syscon" just the power-domain provider
> itself?'

Maybe not, this syscon only offset "0x00" configure power switch.
other offset configure other functions, maybe not power, so this
"starfive,jh7110-aon-syscon" not the power-domain itself.

> Do we actually need to add a new binding for this at all?
> 
> Cheers,
> Conor.
> 

Maybe this patch do that.
https://lore.kernel.org/all/20230414024157.53203-6-xingyu.wu@starfivetech.com/

>>>>  
>>>>    reg:
>>>>      maxItems: 1
>>>> @@ -29,10 +31,19 @@ properties:
>>>>  

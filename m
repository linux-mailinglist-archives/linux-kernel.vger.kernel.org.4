Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7F170567A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjEPS7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjEPS7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:59:51 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987B8DB;
        Tue, 16 May 2023 11:59:49 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34GIxdO7080966;
        Tue, 16 May 2023 13:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684263579;
        bh=kV14IHTqaAMO6TnXBhaseCar9fYNXYm/nM4vJKKHRfQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=R2aET3+32K4fM2S3nNGtfzqCr5xV5N4jb6m0u4sp1/qeGOzXN9QI0LZZeVNFM1H6y
         kbyciuatcdG8fjNbqWJGSR9NdOuKyi1wAXJhdZxgJnnVFHzRnVbUASjvVis1BJsgW+
         onrRGhzd1xTl4VG7s2QWzsZ+5VKTipp9aUf9MNUI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34GIxdZU089296
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 May 2023 13:59:39 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 May 2023 13:59:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 May 2023 13:59:39 -0500
Received: from [10.250.35.184] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34GIxc7c034374;
        Tue, 16 May 2023 13:59:39 -0500
Message-ID: <507381cc-250a-180e-e95a-184d866da74c@ti.com>
Date:   Tue, 16 May 2023 13:59:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mux: mmio: use reg property when parent device is not a
 syscon
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230515191909.611241-1-afd@ti.com>
 <13c1f6ea-63b5-9667-18a2-705829c46437@axentia.se>
 <895c84f5-4a3c-fd2c-2b43-1a1996862e15@ti.com>
 <7d73a37f-80b7-b623-1b71-fa19bf379713@linaro.org>
 <558ebfaf-bd7e-1760-5799-8ed430acad7a@ti.com>
 <32dbdaa3-067b-c997-778f-4fc8dafbbd87@linaro.org>
 <1c27d9d4-b1cc-c158-90f7-f7e47e02c424@ti.com>
 <9a9b074e-d5c9-eca8-4c05-f60861629a2d@linaro.org>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <9a9b074e-d5c9-eca8-4c05-f60861629a2d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/23 1:33 PM, Krzysztof Kozlowski wrote:
> On 16/05/2023 19:47, Andrew Davis wrote:
>> On 5/16/23 11:49 AM, Krzysztof Kozlowski wrote:
>>> On 16/05/2023 18:29, Andrew Davis wrote:
>>>> On 5/16/23 11:19 AM, Krzysztof Kozlowski wrote:
>>>>> On 16/05/2023 17:18, Andrew Davis wrote:
>>>>>> On 5/15/23 4:14 PM, Peter Rosin wrote:
>>>>>>> Hi!
>>>>>>>
>>>>>>> 2023-05-15 at 21:19, Andrew Davis wrote:
>>>>>>>> The DT binding for the reg-mux compatible states it can be used when the
>>>>>>>> "parent device of mux controller is not syscon device". It also allows
>>>>>>>> for a reg property. When the parent device is indeed not a syscon device,
>>>>>>>> nor is it a regmap provider, we should fallback to using that reg
>>>>>>>> property to identify the address space to use for this mux.
>>>>>>>
>>>>>>> We should? Says who?
>>>>>>>
>>>>>>> Don't get me wrong, I'm not saying the change is bad or wrong, I would just
>>>>>>> like to see an example where it matters. Or, at least some rationale for why
>>>>>>> the code needs to change other than covering some case that looks like it
>>>>>>> could/should be possible based on the binding. I.e., why is it not better to
>>>>>>> "close the hole" in the binding instead?
>>>>>>>
>>>>>>
>>>>>> Sure, so this all stated when I was building a checker to make sure that drivers
>>>>>> are not mapping overlapping register spaces. I noticed syscon nodes are a source
>>>>>> of that so I'm trying to look into their usage.
>>>>>>
>>>>>> To start, IHMO there is only one valid use for syscon and that is when more than
>>>>>> one driver needs to access shared bits in a single register. DT has no way to
>>>>>
>>>>> It has... what about all existing efuse/nvmem devices?
>>>>>
>>>>>> describe down to the bit granular level, so one must give that register to
>>>>>> a "syscon node", then have the device node use a phandle to the syscon node:
>>>>>>
>>>>>> common_reg: syscon@10000 {
>>>>>> 	compatible = "syscon";
>>>>>> 	reg = <0x10000 0x4>;
>>>>>> };
>>>>>>
>>>>>> consumer@1 {
>>>>>> 	syscon-efuse = <&common_reg 0x1>;
>>>>>> };
>>>>>>
>>>>>> consumer@2 {
>>>>>> 	syscon-efuse = <&common_reg 0x2>;
>>>>>> };
>>>>>>
>>>>>> Something like that, then regmap will take care of synchronizing access.
>>>>>
>>>>> Syscon is not for this.
>>>>>
>>>>
>>>> That is how it is used today, and in 5 other ways too and there is
>>>> no guidance on it. Let me know what syscon is for then.
>>>
>>> Like described in its bindings (syscon.yaml). The main case is: some
>>> part of address space (dedicated) for various purposes.
>>>
>>
>> That is a "simple-bus", you could use the same reasoning and make the
>> whole address space one big "syscon" node instead then just poke
>> registers from drivers all over.
> 
> Yes and both are discouraged.
> 
>>
>> It is not clear where to draw the line, and for that reason I would
>> like to discourage "syscon" as much as possible and use the normal DT
>> scheme of node per device/register space.
> 
> We all keep discouraging using syscon, so I agree. What exactly do you mean?
> 

Great, then we are in alignment. This thread started as Peter asked for
the "why" and this was my explanation, basically "syscon is discouraged".

>>
>>> Secondary case is a device, with its address space, which has few
>>> registers from other domain, so it needs to expose these to the other
>>> devices.
>>>
>>
>> That is not the case for "reg-mux"; neither case is. So you would
>> agree that "reg-mux" nodes should not be syscon nodes
> 
> I don't understand. reg-mux is not a syscon. No syscon compatible in:
> Documentation/devicetree/bindings/mux/reg-mux.yaml
> 

This was more a segue into a patch that does fix an instance of that I
just posted here:

https://lore.kernel.org/lkml/20230516184626.154892-2-afd@ti.com/

> 
>> nor should
>> they force their parents to be one when they do not meet the above
>> two cases?
> 
> reg-mux does not force the parent to be syscon. You are now mistaking it
> with mmio-mux, which apparently for our Linux implementation it expects
> parent to be syscon.
> 

I might have been mistaking it with "ti,phy-gmii-sel" which does force
that and I am fixing here[0].

https://www.spinics.net/lists/kernel/msg4789373.html

>>> efuse is not syscon, because it is not writeable. efuse has entirely
>>> different purpose with its own defined purpose/type - efuse/OTP etc.
>>>
>>
>> That was just one example I found, I have not found a standard way
>> to describe down to the bit level in DT, only to the word/register.
>> Anything more granular needs non-standard ways of describing which
>> bits belong to which nodes/devices and using syscon to fetch the
>> common registers.
>>
>>>>
>>>>>>
>>>>>
>>>>> ...
>>>>>
>>>>>>
>>>>>> Ideally DT nodes all describe their register space in a "reg"
>>>>>> property and all the "large collection of devices" spaces become
>>>>>> "simple-bus" nodes. "syscon" nodes can then be limited to only the
>>>>>> rare case when multiple devices share bits in a single register.
>>>>>>
>>>>>> If Rob and Krzysztof agree I can send a patch with the above
>>>>>> guidance to the Devicetree Specification repo also.
>>>>>
>>>>> Agree on what?
>>>>>
>>>>
>>>> That we should provide the above guidance on when and how to use syscon
>>>> nodes. Right now it is a free for all and it is causing issues.
>>>
>>> Sure, providing more guidance seems good. We already provide guidance
>>> via review, but we can codify it more. Where? syscon.yaml? It's already
>>> describing everything needed to know...
>>>
>>> What particular problems do you see which need to be solved?
>>>
>>
>> My issue is the guidance is not clear, nor being followed. For instance
>> this is listed as a requirement:
>>
>> "The registers are not cohesive enough to represent as any specific type of device."
>>
>> Take "ti,j721e-system-controller" for instance, today this region is modeled
>> as a "syscon" node but it actually is a region of well defined register spaces
>> and devices. Like PHYs, clock controllers, and our even our pinmux controller.
> 
> Then it should not be syscon. The platform maintainer should tell
> submitter: this is not syscon, please stop this nonsense.
> 
> We do not have access to your datasheets and we do not have time to
> investigate each one of device, so we, DT maintainers, cannot really
> judge. Submitters want everything to be syscon because they can write
> code much faster and shove into kernel poor quality drivers which do not
> adhere to any design principles.
> 

And that is the point of the guidance I'd like to add, it should be: "here are
the only correct uses for syscon", and every other use is just hacking around
making proper device nodes.

>> Most of these devices use the normal "reg" property to claim their registers and
>> so this space should be a "simple-bus" but we are forced to make it one big
>> "syscon" node because a couple devices in this area have a Linux driver that
>> requires their parent node to be a syscon node.
> 
> I don't think it is requirement. You could have a device which has
> children, gives them regmap, but is not really syscon.
> 

Sure, but at least currently making a node "syscon" is the easiest
way to have a parent get a regmap that can be fetched, so most do
that. I have some fixes for that too..

Andrew

>>
>> That is the point of this patch, to relax that restriction in this driver.
>> It doesn't even change the binding, it only makes the driver match what
>> the binding allows.
> 
> Hm, we might be talking about different topics, I don't know. I did not
> look at the driver as it does not fall into category of bindings at all
> and is fully ignored by my filters.
> 
> Best regards,
> Krzysztof
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9DB70555B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjEPRs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjEPRsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:48:17 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2410FA5E6;
        Tue, 16 May 2023 10:48:01 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34GHlrBE089040;
        Tue, 16 May 2023 12:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684259273;
        bh=IyTe1DfWxW9WT24Eoe1CQDijmHKeyOrI37ceuJ0mjY4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=tU9fXSIgjCFQy8RNca3sZSKe55UBQ2khw4plLk6b/pJxTfPkpxjlgcYRs8XQLoEze
         myCgozcLNdvErFiQNJHoSro6AWJ9a6NhNZiFmtf8Vk2iXJvLl1Je06WT7STO+bWFX4
         HMNmobEZDTw0AqRRy4XBjWyaJpWH63TqLDUmyFIY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34GHlrac048944
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 May 2023 12:47:53 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 May 2023 12:47:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 May 2023 12:47:53 -0500
Received: from [10.250.35.184] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34GHlqKj062533;
        Tue, 16 May 2023 12:47:52 -0500
Message-ID: <1c27d9d4-b1cc-c158-90f7-f7e47e02c424@ti.com>
Date:   Tue, 16 May 2023 12:47:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mux: mmio: use reg property when parent device is not a
 syscon
Content-Language: en-US
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
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <32dbdaa3-067b-c997-778f-4fc8dafbbd87@linaro.org>
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

On 5/16/23 11:49 AM, Krzysztof Kozlowski wrote:
> On 16/05/2023 18:29, Andrew Davis wrote:
>> On 5/16/23 11:19 AM, Krzysztof Kozlowski wrote:
>>> On 16/05/2023 17:18, Andrew Davis wrote:
>>>> On 5/15/23 4:14 PM, Peter Rosin wrote:
>>>>> Hi!
>>>>>
>>>>> 2023-05-15 at 21:19, Andrew Davis wrote:
>>>>>> The DT binding for the reg-mux compatible states it can be used when the
>>>>>> "parent device of mux controller is not syscon device". It also allows
>>>>>> for a reg property. When the parent device is indeed not a syscon device,
>>>>>> nor is it a regmap provider, we should fallback to using that reg
>>>>>> property to identify the address space to use for this mux.
>>>>>
>>>>> We should? Says who?
>>>>>
>>>>> Don't get me wrong, I'm not saying the change is bad or wrong, I would just
>>>>> like to see an example where it matters. Or, at least some rationale for why
>>>>> the code needs to change other than covering some case that looks like it
>>>>> could/should be possible based on the binding. I.e., why is it not better to
>>>>> "close the hole" in the binding instead?
>>>>>
>>>>
>>>> Sure, so this all stated when I was building a checker to make sure that drivers
>>>> are not mapping overlapping register spaces. I noticed syscon nodes are a source
>>>> of that so I'm trying to look into their usage.
>>>>
>>>> To start, IHMO there is only one valid use for syscon and that is when more than
>>>> one driver needs to access shared bits in a single register. DT has no way to
>>>
>>> It has... what about all existing efuse/nvmem devices?
>>>
>>>> describe down to the bit granular level, so one must give that register to
>>>> a "syscon node", then have the device node use a phandle to the syscon node:
>>>>
>>>> common_reg: syscon@10000 {
>>>> 	compatible = "syscon";
>>>> 	reg = <0x10000 0x4>;
>>>> };
>>>>
>>>> consumer@1 {
>>>> 	syscon-efuse = <&common_reg 0x1>;
>>>> };
>>>>
>>>> consumer@2 {
>>>> 	syscon-efuse = <&common_reg 0x2>;
>>>> };
>>>>
>>>> Something like that, then regmap will take care of synchronizing access.
>>>
>>> Syscon is not for this.
>>>
>>
>> That is how it is used today, and in 5 other ways too and there is
>> no guidance on it. Let me know what syscon is for then.
> 
> Like described in its bindings (syscon.yaml). The main case is: some
> part of address space (dedicated) for various purposes.
> 

That is a "simple-bus", you could use the same reasoning and make the
whole address space one big "syscon" node instead then just poke
registers from drivers all over.

It is not clear where to draw the line, and for that reason I would
like to discourage "syscon" as much as possible and use the normal DT
scheme of node per device/register space.

> Secondary case is a device, with its address space, which has few
> registers from other domain, so it needs to expose these to the other
> devices.
> 

That is not the case for "reg-mux"; neither case is. So you would
agree that "reg-mux" nodes should not be syscon nodes nor should
they force their parents to be one when they do not meet the above
two cases?

> efuse is not syscon, because it is not writeable. efuse has entirely
> different purpose with its own defined purpose/type - efuse/OTP etc.
> 

That was just one example I found, I have not found a standard way
to describe down to the bit level in DT, only to the word/register.
Anything more granular needs non-standard ways of describing which
bits belong to which nodes/devices and using syscon to fetch the
common registers.

>>
>>>>
>>>
>>> ...
>>>
>>>>
>>>> Ideally DT nodes all describe their register space in a "reg"
>>>> property and all the "large collection of devices" spaces become
>>>> "simple-bus" nodes. "syscon" nodes can then be limited to only the
>>>> rare case when multiple devices share bits in a single register.
>>>>
>>>> If Rob and Krzysztof agree I can send a patch with the above
>>>> guidance to the Devicetree Specification repo also.
>>>
>>> Agree on what?
>>>
>>
>> That we should provide the above guidance on when and how to use syscon
>> nodes. Right now it is a free for all and it is causing issues.
> 
> Sure, providing more guidance seems good. We already provide guidance
> via review, but we can codify it more. Where? syscon.yaml? It's already
> describing everything needed to know...
> 
> What particular problems do you see which need to be solved?
> 

My issue is the guidance is not clear, nor being followed. For instance
this is listed as a requirement:

"The registers are not cohesive enough to represent as any specific type of device."

Take "ti,j721e-system-controller" for instance, today this region is modeled
as a "syscon" node but it actually is a region of well defined register spaces
and devices. Like PHYs, clock controllers, and our even our pinmux controller.
Most of these devices use the normal "reg" property to claim their registers and
so this space should be a "simple-bus" but we are forced to make it one big
"syscon" node because a couple devices in this area have a Linux driver that
requires their parent node to be a syscon node.

That is the point of this patch, to relax that restriction in this driver.
It doesn't even change the binding, it only makes the driver match what
the binding allows.

Andrew

> Best regards,
> Krzysztof
> 

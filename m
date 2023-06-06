Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE86723A7F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbjFFHvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbjFFHuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:50:06 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0E91FC2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:45:36 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id E05195FD26;
        Tue,  6 Jun 2023 10:45:13 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686037513;
        bh=L+3OnyXoHiD3efaXF4rWnuZtnIfzpMfSELR5xR2su0g=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=GwkBenIIDrW9Z/RBsEE9kxzlOvJ8L51nkB94/God97gAzSG+uhSQjiPA/7ZNBzsCB
         mY27jT+762pjHigjZfQKMJ6MGNrkEVhZx5QaNJ++sVAdqMxxtIGymYH3DhMI6LoqEA
         AKMxF6igScB7nsw29JISQG3Q/v3Cn0DAREzaCXhKWGCCQJErijtbjpxsoeZIkdUYwr
         YPlvqKskLC2Cfm35dxe5fXVAOd+yjl3m7J308OOFo1oUIUvuu3dacgmm5oDDlAylYA
         1lIryJeQb6O1Zn5bkdqSKM/i3xoezfNYpQTuqQidKoo2yeGXISSTsJntyKZ23hPRax
         0KTweYRaurNAw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue,  6 Jun 2023 10:45:13 +0300 (MSK)
Message-ID: <19eeb588-f909-8aad-b68c-bcfea8f2e926@sberdevices.ru>
Date:   Tue, 6 Jun 2023 10:40:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v5 2/6] mtd: rawnand: meson: wait for command in
 polling mode
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230601061850.3907800-1-AVKrasnov@sberdevices.ru>
 <20230601061850.3907800-3-AVKrasnov@sberdevices.ru>
 <20230601100751.41c3ff0b@xps-13>
 <9e106d50-2524-c999-48b1-a20760238aaf@sberdevices.ru>
 <20230605110546.6cb00a8d@xps-13>
 <2a755783-1d56-9842-2eee-b5ab41152c81@amlogic.com>
 <163e0684-caff-77d0-1eaf-9a58290c200d@amlogic.com>
 <c316961d-6021-1cb4-9ff4-22fe9ca5a18a@sberdevices.ru>
 <20230606090344.3aca96c8@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230606090344.3aca96c8@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/06 04:28:00 #21442352
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.06.2023 10:03, Miquel Raynal wrote:
> Hi Arseniy,
> 
> avkrasnov@sberdevices.ru wrote on Mon, 5 Jun 2023 19:58:02 +0300:
> 
>> On 05.06.2023 16:30, Liang Yang wrote:
>>>
>>>
>>> On 2023/6/5 21:19, Liang Yang wrote:  
>>>> Hi Miquel and Arseniy,
>>>>
>>>>
>>>> On 2023/6/5 17:05, Miquel Raynal wrote:  
>>>>> [ EXTERNAL EMAIL ]
>>>>>
>>>>> Hi Arseniy,
>>>>>  
>>>>>>>> @@ -1412,6 +1419,8 @@ static int meson_nfc_probe(struct platform_device *pdev)
>>>>>>>>             return ret;
>>>>>>>>     }
>>>>>>>>
>>>>>>>> +  nfc->use_polling = of_property_read_bool(dev->of_node, "polling");  
>>>>>>>
>>>>>>> This is a problem. You cannot add a polling property like that.
>>>>>>>
>>>>>>> There is already a nand-rb property which is supposed to carry how are
>>>>>>> wired the RB lines. I don't see any in-tree users of the compatibles, I
>>>>>>> don't know how acceptable it is to consider using soft fallback when
>>>>>>> this property is missing, otherwise take the values of the rb lines
>>>>>>> provided in the DT and user hardware control, but I would definitely
>>>>>>> prefer that.  
>>>>>>
>>>>>> I see. So i need to implement processing of this property here? And if it
>>>>>> is missed -> use software waiting. I think interesting thing will be that:
>>>>>>
>>>>>> 1) Even with support of this property here, I really don't know how to pass
>>>>>>     RB values to this controller - I just have define for RB command and that's
>>>>>>     it. I found that this property is an array of u32 - IIUC each element is
>>>>>>     RB pin per chip. May be i need to dive into the old vendor's driver to find
>>>>>>     how to use RB values (although this driver uses software waiting so I'm not
>>>>>>     sure that I'll find something in it).  
>>>>>
>>>>> Liang, can you please give use the relevant information here? How do we
>>>>> target RB0 and RB1? It seems like you use the CS as only information
>>>>> like if the RB lines where hardwired internally to a CS. Can we invert
>>>>> the lines with a specific configuration?  
>>>>
>>>> Controllor has only one external RB pinmux (NAND_RB0). all the RB pins
>>>> of different CEs need to be bound into one wire and connect with
>>>> NAND_RB0 if want to use controller polling rb. the current operating
>>>> CE of NAND is decided to "chip_select", of course controller internally has different nfc commands to regconize which Ce's RB signal is polling.
>>>>
>>>> <&nand_pins> in dts/yaml should include the NAND_RB0 if hardware connects, or use software polling here.
>>>>
>>>> @Arseniy, sorry, i don't travel all the informations yet. but why don't you use the new RB_INT command with irq that i provided in another thread. the new RB_INT command doesn't depend on the physical RB wires, it also send the READ status command(0x70) and wait for the irq wake up completion.  
>>
>> Technically no problem! I can use new RB_INT instead of 'nand_soft_waitrdy()' as software fallback, and currently
>> implemented RB_INT as interrupt driven way. What do You think Miquel ?
>>
>>>
>>> Use "nand-rb" in dts to decide old RB_INT(physical RB wires is needed) or new RB_INT(no physical RB wires). the new RB_INT command decides the RB0 or RB1 by the previous command with ce args.
>>>   
>>
>> So I can implement "nand-rb" in dts as boolean value - "false" or missing means use "no physical RB wires", "true" - means use "physical RB wires" ?
> 
> As long as it works and does not contain any extremely strange READ0 or
> READ_STATUS in the middle of nothing, I'm fine, take the simplest
> approach which will work for all.

"extremetely strange READ0" is method which uses STATUS, interrupt, READ0? This method was
described by Liang.

And You mean to use the following logic:
if ("nand-rb" == true)
    use RB_INT which requires wire
else
    use 'nand_soft_waitrdy()'

?

Thanks, Arseniy

> 
>>
>> Thanks, Arseniy
>>
>>>>  
>>>>> Arseniy, if the answer to my above question is no, then you should
>>>>> expect the nand-rb and reg arrays to be identical. If they are not,
>>>>> then you can return -EINVAL.
>>>>>
>>>>> If the nand-rb property is missing, then fallback to software wait.
>>>>>  
>>>>>> 2) I can't test RB mode - I don't have such device :(
>>>>>>
>>>>>> Also for example in arasan-nand-controller.c parsed 'nand-rb' values are used
>>>>>> in controller specific register for waiting (I guess Meson controller has something
>>>>>> like that, but I don't have doc). While in marvell_nand.c it looks like that they parse
>>>>>> 'nand-rb' property, but never use it.  
>>>>>
>>>>> Yes, the logic around the second RB line (taking care of CS1/CS3) is
>>>>> slightly broken or at least badly documented, and thus should not be
>>>>> used.
>>>>>  
>>>>>>> In any case you'll need a dt-binding update which must be acked by
>>>>>>> dt-binding maintainers.  
>>>>>>
>>>>>> You mean to add this property desc to Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml ?  
>>>>>
>>>>> Yes. In a dedicated patch. Something along the lines:
>>>>>
>>>>>          nand-rb: true
>>>>>
>>>>> inside the nand chip object should be fine. And flag the change as a
>>>>> fix because we should have used and parsed this property since the
>>>>> beginning.
>>>>>
>>>>> Thanks,
>>>>> Miquèl  
> 
> 
> Thanks,
> Miquèl

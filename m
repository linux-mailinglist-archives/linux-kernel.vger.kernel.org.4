Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F216D7F77
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbjDEO3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238615AbjDEO3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:29:31 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9995C65BB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=sOAW7WUfRBEQYKDcVis1b6UsgGBI3Q2DcAGh0P9Rqag=; b=FvB11/aTy4PrZZbdB5ibIw3dfd
        CSvLH+hG4gs0y+zCUJ1ZJoPYDpg1cJTQYV6OxhJHn1sNgAsU2hidOlBim87m7Odu1zOKLPcZARBRe
        UTFj63cFTzdO3vi29Yv28YY8iuppLgZop5L01pb2lG7XUcRggvvpk6tDQXMAugjfgjyxkwlt8ExPL
        UrE5vMdQdir07Pa45viioTO9BpnCz3bdMvoE8HFXzlnzhdQsAjnE8YXzbqafRS4rkjNQFpmgBwY/V
        m9Dl5OgQT2RfNTfF68gW75Jn8Ti9IHj6Q+Vkrvr+elpR+X2zD7bUuzPaI9bS6keLztM/B1uxhkqj0
        VyjBcPog==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pk47j-00057M-QH; Wed, 05 Apr 2023 16:28:31 +0200
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pk47j-000Dt8-Fy; Wed, 05 Apr 2023 16:28:31 +0200
Message-ID: <3e1a5b94-5aed-aa4b-c5ee-a44c185504bf@metafoo.de>
Date:   Wed, 5 Apr 2023 07:28:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: iio: ad7192: Pending IRQ on SDO/RDY causing retrigger of
 interrupt handler and missing every sample
Content-Language: en-US
To:     =?UTF-8?Q?Nuno_S=c3=a1?= <noname.nuno@gmail.com>,
        Fabrizio Lamarque <fl.scratchpad@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
References: <CAPJMGm4GaSjD6bdqMwCr2EVZGenWzT-nCCf3BMRaD1TSfAabpA@mail.gmail.com>
 <6d58a58cd7e8a7cbb91b2658e9a85b44b34b64dc.camel@gmail.com>
 <CAPJMGm5WxnmtyW2DnZe4rSUFJ-KtKGmNsf7pStcaK=4suBHWuw@mail.gmail.com>
 <3c5f31cf533ef26ea586e2d18b31995541a95411.camel@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <3c5f31cf533ef26ea586e2d18b31995541a95411.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26866/Wed Apr  5 09:23:41 2023)
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 06:49, Nuno Sá wrote:
> On Wed, 2023-04-05 at 15:20 +0200, Fabrizio Lamarque wrote:
>> On Wed, Apr 5, 2023 at 12:30 PM Nuno Sá <noname.nuno@gmail.com> wrote:
>>> On Wed, 2023-04-05 at 11:53 +0200, Fabrizio Lamarque wrote:
>>>> Link:
>>>> https://lore.kernel.org/all/20210906065630.16325-3-alexandru.tachici@analog.com/
>>>>
>>>> This commit broke the driver functionality, i.e. cat in_voltage1_raw
>>>> triggers a correct sampling sequence only the first time, then it
>>>> always returns the first sampled value.
>>>>
>>>> Following the sequence of ad_sigma_delta_single_conversion() within
>>>> ad_sigma_delta.c, this is due to:
>>>>
>>>> - IRQ resend mechanism is always enabled for ARM cores
>>>> (CONFIG_HARDIRQS_SW_RESEND)
>>>> - Edge IRQs are always made pending when a corresponding event
>>>> happens, even after disable_irq(). This is intentional and designed to
>>>> prevent missing signal edges.
>>>> - Level IRQs are not impacted by IRQ resend (i.e. IRQ_PENDING is
>>>> always cleared).
>>>> - SPI communication causes the IRQ to be set pending (even if
>>>> corresponding interrupt is disabled)
>>>> - The second time ad_sigma_delta_single_conversion() is called,
>>>> enable_irq() will trigger the interrupt immediately, even if RDY line
>>>> is high.
>>>> - In turn, this causes the call
>>>> wait_for_completion_interruptible_timeout() to exit immediately, with
>>>> RDY line still high.
>>>> - Right after the SPI register read, the MODE register is written with
>>>> AD_SD_MODE_IDLE, and pending conversion is stopped. Hence DATA
>>>> register is never updated.
>>>>
>>>> I would suggest to revert this commit or set the flag with
>>>> IRQF_TRIGGER_LOW instead of IRQF_TRIGGER_FALLING, but I am not sure
>>>> about the problem solved by this commit and how to replicate it.
>>>> Another option would be to keep IRQ flags within bindings only.
>>>>
>>> I'm starting to think that what's stated in that commit
>>>
>>> "Leaving IRQ on level instead of falling might trigger a sample read
>>> when the IRQ is enabled, as the SDO line is already low. "
>>>
>>> might actually be related with something else...
>> Hi Nuno Sá,
>>   thank you again for your replies and the time you are spending in checking
>> the reported issues.
>> I see what you mean...
>> I was asking for details on the actual issue that was solved to have a better
>> understanding of the change.
>>
> Yeah, Alex is no longer in ADI so I cannot really say.
>
>>>> As a side note, AD7192 datasheet says that the falling edge on SDO
>>>> line _can_ be used as an interrupt to processor, but it also states
>>>> that the _level_ on SDO/RDY line indicates the sample is ready. What
>>>> happens on SDO/RDY interrupt line before the ADC conversion is
>>>> triggered should be ignored.
>>>>
>>> Well, from the datasheet (as you already know):
>>>
>>> "
>>> In addition, DOUT/RDY operates as a data ready pin, going low to indicate
>>> the completion of a conversion. If the data is not read after the
>>> conversion,
>>> the pin goes high before the next
>>> update occurs. The DOUT/RDY falling edge can be used as an interrupt to a
>>> processor, indicating that valid
>>> data is available.
>>> "
>>>
>>> So I really read IRQF_TRIGGER_FALLING in the above and all the other sigma
>>> delta devices have the same setting (I think). So the fact that it works
>>> with
>>> level IRQs might just be lucky instead of fixing the real problem. Can you
>>> try
>>> the below patch (I'm starting to think it might be related):
>>>
>> We have been using those ADC series for about a decade, the shared SDO/RDY
>> signal has its own quirks.
>> We also discussed several years ago in a support ticket with ADI, both
>> level and edge
>> sensing should be acceptable, provided that limitations are understood.
>>> https://lore.kernel.org/linux-iio/20230306044737.862-1-honda@mechatrax.com/
>> I just tested the patch, but, at least on the platform I'm working on
>> (I.MX6), it does not
>> solve the issue.
>> Whereas the thread describes the very same issue I am experiencing, I
>> am not sure
>> IRQ_DISABLE_UNLAZY would have any impact. By reading CPU registers I see
> I was expecting to have. AFAIU, the lazy approach would be the responsible for
> this behavior because when you call disable_irq() it does not really mask the
> IRQ in HW. Just marks it as disabled and if another IRQ event comes set's it to
> PENDING and only then masks at HW level... If we "unlazy" the IRQ, we should
> mask the IRQ right away so I would expect not to have any pending IRQ...
>
>> the IRQ line disabled at the hardware level, but when the IRQ flag of
>> the processor
>> is set (and this happens even if the interrupt is masked in HW), the
>> interrupt is immediately
>> triggered anyway.
>> (I see GPIOx_IMR cleared, so interrupt is masked, but GPIOx_ISR set. As soon
>> as
>> enable_irq() is called the interrupt is triggered. Just by clearing
>> GPIOx_ISR before
>> enable_irq() solves the issue. I might share a few debug printk).
>>
> Might be that the problem is actually in the behavior of the above controller?
> As said, I would expect a masked IRQ not to be handled and set to PENDING.
>
>> The "real issue" here is that we have a pending IRQ on the RDY line set
>> even if IRQ is disabled (masked) at the hardware level.
>> It does not happen for level sensing interrupts.
>>
>> This link might further clarify why this should be intentional:
>> https://www.kernel.org/doc/html/latest/core-api/genericirq.html#delayed-interrupt-disable
>> (note that I see the IRQ masked at the hardware level anyway, but it
>> does not prevent
>> the described behavior to happen)
>>
>> In case the interrupt flag has to be IRQF_TRIGGER_FALLING, it might be viable
>> to
>> enable the IRQ before the measurement is requested and eventually
>> ignore any spurious
>> interrupt until the measurement is started (SPI write completed).
>>
> Oh no, that looks like just going around the real problem. It would be
> interesting to test this in some other platforms to see if the behavior is the
> same... I guess now is the time to fully understand this. IIRC, originally
> everything was set as LEVEL but since the datasheet states EDGE should be used,
> Alex moved the flags to EDGE.
>
> Maybe you're also right and we should just remove the flags and let users decide
> in the bindings whatever works best for their platforms given the fact that it
> appears that both LEVEL vs EDGE can be used.
>
> Anyways,
>
> +cc Lars since he was the original developer on the sigma delta stuff and maybe
> he remembers something about this level vs edge mess.
>
> Lars, can you shed some light :)?
I don't remember. But the driver was written with the assumption that 
irq_disable() will stop recording of IRQ events. If that does not hold 
we might have to switch from irq_enable/irq_disable to 
request_irq/free_irq, which will come with a slight overhead.



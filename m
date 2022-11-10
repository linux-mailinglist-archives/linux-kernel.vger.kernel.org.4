Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE3062470D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiKJQbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbiKJQb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:31:29 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1AD326C8;
        Thu, 10 Nov 2022 08:31:27 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AACffYQ021705;
        Thu, 10 Nov 2022 10:31:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=G1k1KLyGMwxozZNLgQY9XUSivrmWdqX+jg/q/VREfJQ=;
 b=NAiim7PGQLdTnUxXyyryjfybkJIs1146lYP1fVx1EbnRXJKv5/E3RTDxo1f47TfSRoS3
 of8nH9BOQSU6aBZeARROBxY7NUfTLqIREdqGed8GCmIgERL2OJT2GsyanQXaueJSpCVn
 VJV61rI9+MIm91tLdWiQ0iKZmKdRqvCnufWlkveTDTA2vPobcR1N4EV3yjwqMvkhISSk
 XoP4sV8zdhjnpJMuYTLIDYiZAKfO0436DLnlkG8uPr3FERreK22vJd+cPWtjybF/e+jC
 WAEjPjm8Fv1LZ18kYX1InhSvQnhT3126GAhf/KUmwCJs07iTjyIa8lETo9pcORJJeDaZ WA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3knn81qf0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 10:31:09 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Thu, 10 Nov
 2022 10:31:07 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.15 via Frontend Transport; Thu, 10 Nov 2022 10:31:07 -0600
Received: from [198.90.251.111] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3C0E046B;
        Thu, 10 Nov 2022 16:31:07 +0000 (UTC)
Message-ID: <05ae0e20-b472-f812-1afc-ef8c2a97cdeb@opensource.cirrus.com>
Date:   Thu, 10 Nov 2022 16:31:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 09/12] irqchip: cirrus: Add driver for Cirrus Logic
 CS48L31/32/33 codecs
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>, <tglx@linutronix.de>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
 <20221109165331.29332-10-rf@opensource.cirrus.com>
 <87mt8zutib.wl-maz@kernel.org>
 <c0c05799-6424-7edf-01b3-e28a10907b2c@opensource.cirrus.com>
 <86pmdvow5y.wl-maz@kernel.org>
 <ef60cbdb-f506-7bd6-a8e1-c92b6963a0f4@opensource.cirrus.com>
 <86k042q1uc.wl-maz@kernel.org>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <86k042q1uc.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9jVJuRIJp_kAT78zvrXKtjtfM9LpjTM4
X-Proofpoint-GUID: 9jVJuRIJp_kAT78zvrXKtjtfM9LpjTM4
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2022 15:13, Marc Zyngier wrote:
> On Thu, 10 Nov 2022 13:00:50 +0000,
> Richard Fitzgerald <rf@opensource.cirrus.com> wrote:
>>
>> On 10/11/2022 12:01, Marc Zyngier wrote:
>>> On Thu, 10 Nov 2022 11:22:26 +0000,
>>> Richard Fitzgerald <rf@opensource.cirrus.com> wrote:
>>>>
>>>> On 10/11/2022 08:02, Marc Zyngier wrote:
>>>>> On Wed, 09 Nov 2022 16:53:28 +0000,
>>>>> Richard Fitzgerald <rf@opensource.cirrus.com> wrote:
>>>>>>
>>>>>> The Cirrus Logic CS48L31/32/33 audio codecs contain a programmable
>>>>>> interrupt controller with a variety of interrupt sources, including
>>>>>> GPIOs that can be used as interrupt inputs.
>>>>>>
>>>>>> This driver provides the handling for the interrupt controller. As the
>>>>>> codec is accessed via regmap, the generic regmap_irq functionality
>>>>>> is used to do most of the work.
>>>>>>
>>>>>
>>>>> I cannot spot a shred of interrupt controller code in there. This
>>>>
>>>> It is providing support for handling an interrupt controller so that
>>>> other drivers can bind to those interrupts. It's just that regmap
>>>> provides a lot of generic implementation for SPI-connected interrupt
>>>> controllers so we don't need to open-code all that in the
>>>> irqchip driver.
>>>
>>> And thus none of that code needs to live in drivers/irqchip.
>>>
>>>>
>>>>> belongs IMO to the MFD code.
>>>>
>>>> We did once put interrupt support in MFD for an older product line but
>>>> the MFD maintainer doesn't like the MFD being a dumping-ground for
>>>> random other functionality that have their own subsystems.
>>>
>>> I don't like this stuff either. All this code is a glorified set of
>>> interrupt handlers and #defines that only hide the lack of a proper DT
>>> binding to express the interrupt routing (it feels like looking at
>>> board files from 10 years ago).
>>>
>>
>> I didn't understand this. The whole purpose of this is to instantiate
>> Linux interrupts for the PIC interrupt sources so that other drivers
>> that want to use the interrupts from the CS48L32 PIC can use standard
>> kernel APIs or DT to bind against them.
> 
> There is zero standard APIs in this patch. Does cs48l32_request_irq()
> look standard to you? This whole thing makes a mockery of the
> interrupt model and of firmware-based interrupt description which we
> spent years to build.
> 
>>
>> The four handlers registered within the driver are done here simply
>> because they don't belong to any particular child driver. Since they
>> are a fixed feature of the chip that we know we want to handle we may as
>> well just register them.
> 
> Again, they have no purpose in an interrupt controller driver.
> 
>> If we put them in the MFD with DT definitions it would make a
>> circular dependency between MFD and its child, which is not a great
>> situation. If it's these handlers that are bothering you, we could move
>> them to the audio driver.
> 
> And what's left? Nothing.

Ah, I see. You've missed that the bulk of the implementation re-uses
existing library code from regmap. It does say this in the commit
message.

   "the generic regmap_irq functionality is used to do most of the work."

and I've also said this in previous replies.

This is no way driver that does nothing. There's over 1000 lines of code
handling the PIC and dispatching its interrupts to other drivers that
want to bind to them. It's just that it makes no sense to duplicate 1300
lines of interrupt handling code from elsewhere when we can re-use that
by calling regmap_add_irq_chip(). That gives us all the interrupt-
controller-handling code in drivers/base/regmap/regmap-irq.c

Perhaps you could re-review this taking into account that
regmap_add_irq_chip() is significant.

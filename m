Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3409624305
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiKJNOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKJNOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:14:44 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CF432073;
        Thu, 10 Nov 2022 05:14:43 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AACjddP028494;
        Thu, 10 Nov 2022 07:14:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=kD1m6VCRlQYW+ijK5eEXwbmuUugkbgmTtw/FTowKXZ8=;
 b=UPG+Z2qpQ4+qji+mMslS35OZfNbBY3sJ85P1nQ4DDx7m1pKLxNmtS6agP9EtVXAhY/dN
 a1eOaipQph2487rbwzIXRV4d0s35eK9yK7me+v9zjTGevOKUdDr6k93bkLYPDTlYc8Fj
 gxBBks0+8F2rKflsIQhluJjUkFzewxIOXMGMA+8TRQ9jbvly+7BfgrcyYnIwXDvqlWGR
 zflM9j0xjhdPEyy+XG++0wnFWvrNcwFNOhM2HJIL9+pzhrKKqCm6Esf3ExtTGe6Aa+8a
 1S2DVoVKrqlfOUV/nQv1iwiqXNV+dyWkzQW2sS1xiLyiCcJAfM+JQ4yU9BH16/XVavFu Zg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3knn81q224-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 07:14:32 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Thu, 10 Nov
 2022 07:14:30 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.15 via Frontend
 Transport; Thu, 10 Nov 2022 07:14:30 -0600
Received: from [198.90.251.111] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3F55946B;
        Thu, 10 Nov 2022 13:14:30 +0000 (UTC)
Message-ID: <4d50faae-7eea-bc5a-9def-935c2063a7b3@opensource.cirrus.com>
Date:   Thu, 10 Nov 2022 13:14:30 +0000
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
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <86pmdvow5y.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aQX-5YRNzgLfR64UzVEJh_O4ywOPGPrg
X-Proofpoint-GUID: aQX-5YRNzgLfR64UzVEJh_O4ywOPGPrg
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2022 12:01, Marc Zyngier wrote:
> On Thu, 10 Nov 2022 11:22:26 +0000,
> Richard Fitzgerald <rf@opensource.cirrus.com> wrote:
>>
>> On 10/11/2022 08:02, Marc Zyngier wrote:
>>> On Wed, 09 Nov 2022 16:53:28 +0000,
>>> Richard Fitzgerald <rf@opensource.cirrus.com> wrote:
>>>>
>>>> The Cirrus Logic CS48L31/32/33 audio codecs contain a programmable
>>>> interrupt controller with a variety of interrupt sources, including
>>>> GPIOs that can be used as interrupt inputs.
>>>>
>>>> This driver provides the handling for the interrupt controller. As the
>>>> codec is accessed via regmap, the generic regmap_irq functionality
>>>> is used to do most of the work.
>>>>
>>>
>>> I cannot spot a shred of interrupt controller code in there. This
>>
>> It is providing support for handling an interrupt controller so that
>> other drivers can bind to those interrupts. It's just that regmap
>> provides a lot of generic implementation for SPI-connected interrupt
>> controllers so we don't need to open-code all that in the
>> irqchip driver.
> 
> And thus none of that code needs to live in drivers/irqchip.
> 
>>
>>> belongs IMO to the MFD code.
>>
>> We did once put interrupt support in MFD for an older product line but
>> the MFD maintainer doesn't like the MFD being a dumping-ground for
>> random other functionality that have their own subsystems.
> 
> I don't like this stuff either. All this code is a glorified set of
> interrupt handlers and #defines that only hide the lack of a proper DT
> binding to express the interrupt routing (it feels like looking at
> board files from 10 years ago).
> 
> None of that belongs in the irqchip code.
> 
>>
>>>   It is also a direct copy of the existing
>>> irq-madera.c code, duplicated for no obvious reason.
>>
>> It's not a duplicate. The register map of this device is different
>> (different addressing, 32-bit registers not 16-bit)
> 
> And? How hard is it to implement an indirection containing the
> register map and the relevant callbacks? /roll-eyes
> 

I note your accusation that we were too lazy (or too stupid?)
to think of this.

> 	M.
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF48269F9A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjBVRIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjBVRIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:08:30 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A097193CD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:08:27 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31MH7vrr129973;
        Wed, 22 Feb 2023 11:07:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677085677;
        bh=wZ4rC2g9G6eTB/8I0PC74ORgfbx04Jrnb9vTyIm5dD8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=qXls/Qbt31hKAVoxx4BboY5HnGCi3i9t96qmpCMIfSxD1UqCgGwxO0jf/AvzmAp+k
         I5rsEEoLbdzfISgHGAdPs+uONF7i9OpxpHrtbFrWHG0uZIcr0+Cg6efniBZXDduGt7
         vCLSKQMCCmJKJKuGRNE6Xh+XAaKx6bA4x2V8qqTs=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31MH7utn003778
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Feb 2023 11:07:56 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 22
 Feb 2023 11:07:56 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 22 Feb 2023 11:07:56 -0600
Received: from [10.250.234.154] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31MH7ree109290;
        Wed, 22 Feb 2023 11:07:54 -0600
Message-ID: <9d22ad57-11a5-56ab-7134-07dd46c476a9@ti.com>
Date:   Wed, 22 Feb 2023 22:37:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RFC PATCH 2/2] irqchip: irq-ti-sci-inta: Introduce IRQ affinity
 support
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230122081607.959474-1-vigneshr@ti.com>
 <20230122081607.959474-3-vigneshr@ti.com> <86y1ppl6pl.wl-maz@kernel.org>
 <cba927be-a83c-d397-100c-03c89b5696ec@ti.com> <86h6vgyb85.wl-maz@kernel.org>
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <86h6vgyb85.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/2023 2:17 PM, Marc Zyngier wrote:
> On Fri, 27 Jan 2023 17:53:55 +0000,
> "Raghavendra, Vignesh" <vigneshr@ti.com> wrote:
>>
> 
> [...]
> 
>>>> @@ -504,11 +509,45 @@ static void ti_sci_inta_ack_irq(struct irq_data *data)
>>>>  		ti_sci_inta_manage_event(data, VINT_STATUS_OFFSET);
>>>>  }
>>>>  
>>>> +#ifdef CONFIG_SMP
>>>> +static int ti_sci_inta_set_affinity(struct irq_data *d,
>>>> +				    const struct cpumask *mask_val, bool force)
>>>> +{
>>>> +	struct ti_sci_inta_event_desc *event_desc;
>>>> +	struct ti_sci_inta_vint_desc *vint_desc;
>>>> +	struct irq_data *parent_irq_data;
>>>> +
>>>> +	if (cpumask_equal(irq_data_get_effective_affinity_mask(d), mask_val))
>>>> +		return 0;
>>>> +
>>>> +	event_desc = irq_data_get_irq_chip_data(d);
>>>> +	if (event_desc) {
>>>> +		vint_desc = to_vint_desc(event_desc, event_desc->vint_bit);
>>>> +
>>>> +		/*
>>>> +		 * Cannot set affinity if there is more than one event
>>>> +		 * mapped to same VINT
>>>> +		 */
>>>> +		if (bitmap_weight(vint_desc->event_map, MAX_EVENTS_PER_VINT) > 1)
>>>> +			return -EINVAL;
>>>> +
>>>> +		vint_desc->affinity_managed = true;
>>>> +
>>>> +		irq_data_update_effective_affinity(d, mask_val);
>>>> +		parent_irq_data = irq_get_irq_data(vint_desc->parent_virq);
>>>> +		if (parent_irq_data->chip->irq_set_affinity)
>>>> +			return parent_irq_data->chip->irq_set_affinity(parent_irq_data, mask_val, force);
>>>
>>> This looks completely wrong.
>>>
>>> You still have a chained irqchip on all paths, and have to do some
>>> horrible probing to work out:
>>>
>>> - which parent interrupt this is
>>>
>>> - how many interrupts are connected to it
>>>
>>> And then the fun begins:
>>>
>>> - You have one interrupt that is standalone, so its affinity can be
>>>   moved
>>>
>>> - An unrelated driver gets probed, and one of its interrupts gets
>>>   lumped together with the one above
>>>
>>> - Now it cannot be moved anymore, and userspace complains
>>>
>>> The rule is very simple: chained irqchip, no affinity management.
>>> Either you reserve a poll of direct interrupts that have affinity
>>
>> This is what I am trying to accomplish, that is, reserve a pool of
>> direct interrupts that can be used by certain drivers that require IRQ
>> steering for performance. But I don't see a way to indicate from client
>> drivers to allocate from this reserved pool (there is no hint in
>> request_irq() call that ends up in .irq_request_resources() that I can use)
>>
>> I can try and virtually split INTA into two irqchips perhaps, with one
>> part modeled as chained irqchip and other as stacked for the reserved
>> pool (and would have to spawn of two child msi-domains I presume).
>> But, there is only one DT node for this irqchip and thus clients cannot
>> request IRQ for reserved pool.
> 
> I don't see why DT should be aware of this. You only need to decide at
> allocation time which one is where, and plug it at the right level.
> 

Ah, okay. I can certainly update .irq_set_affinity to point to INTA's
parent during ti_sci_inta_irq_domain_alloc() for reserved pool of direct
interrupts.

> And you probably only need *one* chained interrupt that muxes
> everything that cannot be allocated direct path.

IIRC, suggestion is that driver is aware (eg via static list) of
incoming downstream events that need to be directly mapped and thus does
so during allocation, right?

But this is a bit tricky on TI K3 SoCs. INTA is meant to aggregate DMA
channel events. On certain SoCs, any DMA channel can talk to any
peripheral and there is no static binding. We, ideally, need to do load
balancing for certain networking (and such high IRQ load) peripherals only.

One way I see is create a special DMA channel pool at DMA driver as well
that correspond to reserved VINT pool here. Else I am not aware of a way
for DMA driver to inform INTA driver to allocate IRQ line from reserved
pool.

> 
>> Wondering if you have any pointers here?
> 
> I don't. But this shouldn't be too hard to bolt onto the existing
> framework.


Really appreciate feedback! Thanks

Regards
Vignesh

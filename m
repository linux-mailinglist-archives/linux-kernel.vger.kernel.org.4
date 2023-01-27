Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9892A67ECC8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbjA0Ryd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjA0Ryb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:54:31 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50E97F6A4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:54:28 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30RHrxIs124246;
        Fri, 27 Jan 2023 11:53:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674842039;
        bh=7LwdsGzjDUx5iUJe+8xmnERFrYSaFIJuYsjWEz25iPA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=PTZ9jw1hQawr7brrjVkZvDvrxNhOw9q32StGvPz9Jmg3Z60bY8tkejN8IqjiKZdtR
         n+qpN8vvr3Lq+j3dZCSohKW8dyRNBnHwqG1sYx/nWjeg88h+0vJZoItmulI59geJPY
         5WSQKZPqKk0oRuamQkDunRCc+YUtfYydjemxs3cc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30RHrxux016233
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jan 2023 11:53:59 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 27
 Jan 2023 11:53:59 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 27 Jan 2023 11:53:59 -0600
Received: from [10.250.233.254] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30RHruIg001582;
        Fri, 27 Jan 2023 11:53:56 -0600
Message-ID: <cba927be-a83c-d397-100c-03c89b5696ec@ti.com>
Date:   Fri, 27 Jan 2023 23:23:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
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
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <86y1ppl6pl.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,d

On 1/26/2023 7:48 PM, Marc Zyngier wrote:
> On Sun, 22 Jan 2023 08:16:07 +0000,
> Vignesh Raghavendra <vigneshr@ti.com> wrote:
>>
>> Add support for setting IRQ affinity for VINTs which have only one event
>> mapped to them. This just involves changing the parent IRQs affinity
>> (GIC/INTR). Flag VINTs which have affinity configured so as to not
>> aggregate/map more events to such VINTs.
> 
> 
> 
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>  drivers/irqchip/irq-ti-sci-inta.c | 39 +++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
>> index f1419d24568e..237cb4707cb8 100644
>> --- a/drivers/irqchip/irq-ti-sci-inta.c
>> +++ b/drivers/irqchip/irq-ti-sci-inta.c
>> @@ -64,6 +64,7 @@ struct ti_sci_inta_event_desc {
>>   * @events:		Array of event descriptors assigned to this vint.
>>   * @parent_virq:	Linux IRQ number that gets attached to parent
>>   * @vint_id:		TISCI vint ID
>> + * @affinity_managed	flag to indicate VINT affinity is managed
>>   */
>>  struct ti_sci_inta_vint_desc {
>>  	struct irq_domain *domain;
>> @@ -72,6 +73,7 @@ struct ti_sci_inta_vint_desc {
>>  	struct ti_sci_inta_event_desc events[MAX_EVENTS_PER_VINT];
>>  	unsigned int parent_virq;
>>  	u16 vint_id;
>> +	bool affinity_managed;
>>  };
>>  
>>  /**
>> @@ -334,6 +336,8 @@ static struct ti_sci_inta_event_desc *ti_sci_inta_alloc_irq(struct irq_domain *d
>>  	vint_id = ti_sci_get_free_resource(inta->vint);
>>  	if (vint_id == TI_SCI_RESOURCE_NULL) {
>>  		list_for_each_entry(vint_desc, &inta->vint_list, list) {
>> +			if (vint_desc->affinity_managed)
>> +				continue;
>>  			free_bit = find_first_zero_bit(vint_desc->event_map,
>>  						       MAX_EVENTS_PER_VINT);
>>  			if (free_bit != MAX_EVENTS_PER_VINT)
>> @@ -434,6 +438,7 @@ static int ti_sci_inta_request_resources(struct irq_data *data)
>>  		return PTR_ERR(event_desc);
>>  
>>  	data->chip_data = event_desc;
>> +	irq_data_update_effective_affinity(data, cpu_online_mask);
>>  
>>  	return 0;
>>  }
>> @@ -504,11 +509,45 @@ static void ti_sci_inta_ack_irq(struct irq_data *data)
>>  		ti_sci_inta_manage_event(data, VINT_STATUS_OFFSET);
>>  }
>>  
>> +#ifdef CONFIG_SMP
>> +static int ti_sci_inta_set_affinity(struct irq_data *d,
>> +				    const struct cpumask *mask_val, bool force)
>> +{
>> +	struct ti_sci_inta_event_desc *event_desc;
>> +	struct ti_sci_inta_vint_desc *vint_desc;
>> +	struct irq_data *parent_irq_data;
>> +
>> +	if (cpumask_equal(irq_data_get_effective_affinity_mask(d), mask_val))
>> +		return 0;
>> +
>> +	event_desc = irq_data_get_irq_chip_data(d);
>> +	if (event_desc) {
>> +		vint_desc = to_vint_desc(event_desc, event_desc->vint_bit);
>> +
>> +		/*
>> +		 * Cannot set affinity if there is more than one event
>> +		 * mapped to same VINT
>> +		 */
>> +		if (bitmap_weight(vint_desc->event_map, MAX_EVENTS_PER_VINT) > 1)
>> +			return -EINVAL;
>> +
>> +		vint_desc->affinity_managed = true;
>> +
>> +		irq_data_update_effective_affinity(d, mask_val);
>> +		parent_irq_data = irq_get_irq_data(vint_desc->parent_virq);
>> +		if (parent_irq_data->chip->irq_set_affinity)
>> +			return parent_irq_data->chip->irq_set_affinity(parent_irq_data, mask_val, force);
> 
> This looks completely wrong.
> 
> You still have a chained irqchip on all paths, and have to do some
> horrible probing to work out:
> 
> - which parent interrupt this is
> 
> - how many interrupts are connected to it
> 
> And then the fun begins:
> 
> - You have one interrupt that is standalone, so its affinity can be
>   moved
> 
> - An unrelated driver gets probed, and one of its interrupts gets
>   lumped together with the one above
> 
> - Now it cannot be moved anymore, and userspace complains
> 
> The rule is very simple: chained irqchip, no affinity management.
> Either you reserve a poll of direct interrupts that have affinity

This is what I am trying to accomplish, that is, reserve a pool of
direct interrupts that can be used by certain drivers that require IRQ
steering for performance. But I don't see a way to indicate from client
drivers to allocate from this reserved pool (there is no hint in
request_irq() call that ends up in .irq_request_resources() that I can use)

I can try and virtually split INTA into two irqchips perhaps, with one
part modeled as chained irqchip and other as stacked for the reserved
pool (and would have to spawn of two child msi-domains I presume).
But, there is only one DT node for this irqchip and thus clients cannot
request IRQ for reserved pool.

Wondering if you have any pointers here?

Thanks for your patience.

Regards
Vignesh

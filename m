Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C282A70D241
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjEWDQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjEWDQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:16:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E883B90
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 20:16:04 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QQKBp6rvfzLpxF;
        Tue, 23 May 2023 11:13:06 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 11:16:02 +0800
Message-ID: <4a8012b7-cb82-b21c-6006-a1e2d176ddfc@huawei.com>
Date:   Tue, 23 May 2023 11:16:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
To:     Marc Zyngier <maz@kernel.org>, "Gowans, James" <jgowans@amazon.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Raslan, KarimAllah" <karahmed@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "zouyipeng@huawei.com" <zouyipeng@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sironi, Filippo" <sironi@amazon.de>,
        "chris.zjh@huawei.com" <chris.zjh@huawei.com>
References: <20230317095300.4076497-1-jgowans@amazon.com>
 <87h6tp5lkt.wl-maz@kernel.org>
 <0869847124f982c50d0f8d0ede996004f90a5576.camel@amazon.com>
 <86pm89kyyt.wl-maz@kernel.org>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <86pm89kyyt.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/12 21:32, Marc Zyngier 写道:
> On Tue, 11 Apr 2023 11:27:26 +0100,
> "Gowans, James" <jgowans@amazon.com> wrote:
>>
>> Hi Marc, thanks for taking the time to put thought into this!
>>
>> On Sun, 2023-04-09 at 12:41 +0100, Marc Zyngier wrote:
>>>> Generally it should not be possible for the next interrupt to arrive
>>>> while the previous handler is still running: the next interrupt should
>>>> only arrive after the EOI message has been sent and the previous handler
>>>> has returned.
>>>
>>> There isn't necessarily an EOI message. On bare metal, EOI of a LPI
>>> amounts to sweet nothing (see the pseudocode to convince yourself),
>>> because the physical LPI doesn't have an active state.
>>
>> Okay, I saw the gic_eoi_irq() function and thought there might be something
>> going on there. I guess it's not relevant to this issue.
> 
> It is relevant in a way. If LPIs had an active state, then it wouldn't
> be able to creep back up behind your back until the first CPU had
> issued a deactivation (triggered by EOI when EOImode=0). But the
> architecture was broken since day one, because sine architect thought
> they knew everything there was to know about the subject...
> 
>>
>>>>
>>>> The issue is
>>>> that the global ITS is responsible for affinity but does not know
>>>> whether interrupts are pending/running, only the CPU-local redistributor
>>>> handles the EOI. Hence when the affinity is changed in the ITS, the new
>>>> CPU's redistributor does not know that the original CPU is still running
>>>> the handler.
>>>
>>> You seem to be misunderstanding the architecture.
>>>
>>> The local redistributor doesn't know anything either. A redistributor
>>> doesn't contain any state about what is currently serviced. At best,
>>> it knows of the pending state of interrupts, and that about it. This
>>> is even more true in a VM. Only the CPU knows about this, and there is
>>> no EOI that ever gets propagated to the redistributor.
>>
>> Right. This misunderstanding basically stems from my confusion above where I
>> thought that the EOI would move it back into "pending." That obviously makes no
>> sense because if another IRQ arrives while the handler is already running, then
>> another handler run must be queued, hence it must be something really early in
>> the flow which ACKs the IRQ so that it gets moved back to "inactive."
> 
> The ACK is the read of ICC_IAR_EL1 in the GICv3 driver, which indeed
> sends the interrupt back to the inactive state, despite the
> corresponding priority being active on the CPU. With this setup, EOI
> only performs the priority drop.
> 
>>>> 1. Do we need to mask the IRQ and then unmask it later? I don't think so
>>>> but it's not entirely clear why handle_edge_irq does this anyway; it's
>>>> an edge IRQ so not sure why it needs to be masked.
>>>
>>> Please measure that cost and weep, specially in the context of
>>> multiple concurrent interrupts serviced by a single ITS (cost of
>>> locking the command queue, of waiting for a full round trip to the ITS
>>> for a couple of commands...).
>>
>> Fortunately this mask/unmasking would only happen in the rare(ish) cased of the
>> race condition described here being hit. Exactly the same as
>> with handle_edge_irq(), the masking and later unmasking would only be done
>> when irq_may_run() == false due to the race being hit. Considering that this is
>> a rare occurrence, I think we could stomach the occasional overhead? I was more
>> asking if it's actually *necessary* to do this masking/unmasking. I'm not sure
>> it's necessary anyway, hence it wasn't implemented in my patch.
> 
> But does it solve anything? At the point where you mask the interrupt,
> you already have consumed it. You'd still need to make it pending
> somehow, which is what your patch somehow.
> 
>>
>>>> index 49e7bc871fec..4e5fc2b7e8a9 100644
>>>> --- a/kernel/irq/chip.c
>>>> +++ b/kernel/irq/chip.c
>>>> @@ -692,8 +692,10 @@ void handle_fasteoi_irq(struct irq_desc *desc)
>>>>
>>>>       raw_spin_lock(&desc->lock);
>>>>
>>>> -     if (!irq_may_run(desc))
>>>> +     if (!irq_may_run(desc)) {
>>>> +             desc->istate |= IRQS_PENDING;
>>>>               goto out;
>>>> +     }
>>>
>>> What is currently unclear to me is how we get there on another CPU if
>>> we're still handling the interrupt, which happens in the critical
>>> section delineated by desc->lock. So there is some additional state
>>> change here which you don't seem to be describing.
>>
>> The lock is actually released and later re-acquired in the handle_irq_event()
>> function which is called below. Only this flag wrangling code is done with the
>> irq_desc lock held; all of the logic in the later IRQ-specific handler code is
>> actually run unlocked. This is why there is a window for the irq_desc to get
>> into the irq_may_run() function concurrently with the handler being run on a
>> difference CPU.
> 
> Huh, indeed! Interrupts are still disabled (TFFT!), but this makes
> firing on another CPU entirely possible. Thanks for the eye-opening
> comment.
> 
>>>
>>>>       desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
>>>>
>>>> @@ -711,7 +713,10 @@ void handle_fasteoi_irq(struct irq_desc *desc)
>>>>       if (desc->istate & IRQS_ONESHOT)
>>>>               mask_irq(desc);
>>>>
>>>> -     handle_irq_event(desc);
>>>> +     do {
>>>> +             handle_irq_event(desc);
>>>> +     } while (unlikely((desc->istate & IRQS_PENDING) &&
>>>> +                     !irqd_irq_disabled(&desc->irq_data)));
>>>>
>>>>       cond_unmask_eoi_irq(desc, chip);
>>>>
>>>
>>> Why do we need to inflict any of this on all other users of this flow?
>>> The lack of active state on LPIs is the issue, as it allows a new
>>> interrupt to be presented to another CPU as soon as the previous one
>>> has been ACK'ed.
>>
>> Do you mean an active state in hardware? Even if we had an active state, that
>> state would be CPU-local, right?
> 
> No, and that's the whole point. An active state is global. See for
> example how SPIs, which are as global as it gets, have their active
> state honoured *system wide*.
> 
>> The issue here is that when the CPU affinity
>> changes while the handler is running, the new CPU will early out because the
>> flags in irq_desc indicate it's already running elsewhere. A CPU-local hardware
>> active state would not help here; only if the active/pending states were global,
>> then it may help.
> 
> See above.
> 
>>
>> As for inflicting this on other users, this is pretty light in general. It's
>> basically just looking at that flag again; in general it will be unset and we'll
>> exit the loop after one invoke.
>>
>>>
>>> This also has the effect of keeping the handling of the interrupt on
>>> the original CPU, negating the effects of the change of affinity.
>>
>> Yes. This bothered me too initially, but on reflection I'm not sure it's
>> actually a problem. One possible issue that came to mind was around CPU
>> offlining, but in the event that a CPU being offlined was running interrupt
>> handlers it wouldn't be able to complete the offline anyway until the handlers
>> were finished, so I don't think this is an issue. Do you see any practical issue
>> with running the handler once more on the original CPU immediately after the
>> affinity has been changed?
> 
> My take on this is that we put the pressure on the CPU we want to move
> away from. I'd rather we put the it on the GIC itself, and use its
> Turing-complete powers to force it to redeliver the interrupt at a
> more convenient time.
> 
>>
>>> It feels that we should instead resend the interrupt, either by making
>>> it pending again by generating an INT command to the ITS, or by using
>>> the SW resend mechanism (which the lack of deactivation requirement
>>> makes possible).
>>
>> I'm open to other suggestions here, just not sure how this re-sending would work
>> in practice. Do you mean that when the original CPU observes that the pending
>> flag is set, instead of running the handler again locally the original CPU would
>> instruct the ITS to mark the interrupt as pending again, hence re-triggering it
>> on the new CPU? That could work, but may be tricky to shoe-horn into the generic
>> code, unless we use the EOI callback for this?
> 
> I think we have most of what we need already, see the hack below. It
> is totally untested, but you'll hopefully get the idea.
> 
> Thanks,
> 
> 	M.
> 
>>From c96d2ab37fe273724f1264fba5f4913259875d56 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <maz@kernel.org>
> Date: Mon, 10 Apr 2023 10:56:32 +0100
> Subject: [PATCH] irqchip/gicv3-its: Force resend of LPIs taken while already
>  in-progress
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v3-its.c |  3 +++
>  include/linux/irq.h              | 13 +++++++++++++
>  kernel/irq/chip.c                |  5 ++++-
>  kernel/irq/debugfs.c             |  2 ++
>  4 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 586271b8aa39..d04c73a2bc6b 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3574,6 +3574,7 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  		irqd = irq_get_irq_data(virq + i);
>  		irqd_set_single_target(irqd);
>  		irqd_set_affinity_on_activate(irqd);
> +		irqd_set_resend_when_in_progress(irqd);
>  		pr_debug("ID:%d pID:%d vID:%d\n",
>  			 (int)(hwirq + i - its_dev->event_map.lpi_base),
>  			 (int)(hwirq + i), virq + i);
> @@ -4512,6 +4513,8 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
>  		irq_domain_set_hwirq_and_chip(domain, virq + i, i,
>  					      irqchip, vm->vpes[i]);
>  		set_bit(i, bitmap);
> +
> +		irqd_set_resend_when_in_progress(irq_get_irq_data(virq + i));
>  	}
>  
>  	if (err) {
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index b1b28affb32a..4b2a7cc96eb2 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -223,6 +223,8 @@ struct irq_data {
>   *				  irq_chip::irq_set_affinity() when deactivated.
>   * IRQD_IRQ_ENABLED_ON_SUSPEND	- Interrupt is enabled on suspend by irq pm if
>   *				  irqchip have flag IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND set.
> + * IRQD_RESEND_WHEN_IN_PROGRESS - Interrupt may fire when already in progress,
> + *				  needs resending.
>   */
>  enum {
>  	IRQD_TRIGGER_MASK		= 0xf,
> @@ -249,6 +251,7 @@ enum {
>  	IRQD_HANDLE_ENFORCE_IRQCTX	= (1 << 28),
>  	IRQD_AFFINITY_ON_ACTIVATE	= (1 << 29),
>  	IRQD_IRQ_ENABLED_ON_SUSPEND	= (1 << 30),
> +	IRQD_RESEND_WHEN_IN_PROGRESS	= (1 << 31),
>  };
>  
>  #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
> @@ -448,6 +451,16 @@ static inline bool irqd_affinity_on_activate(struct irq_data *d)
>  	return __irqd_to_state(d) & IRQD_AFFINITY_ON_ACTIVATE;
>  }
>  
> +static inline bool irqd_needs_resend_when_in_progress(struct irq_data *d)
> +{
> +	return __irqd_to_state(d) & IRQD_RESEND_WHEN_IN_PROGRESS;
> +}
> +
> +static inline void irqd_set_resend_when_in_progress(struct irq_data *d)
> +{
> +	__irqd_to_state(d) |= IRQD_RESEND_WHEN_IN_PROGRESS;
> +}
> +
>  #undef __irqd_to_state
>  
>  static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 49e7bc871fec..73546ba8bc43 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -692,8 +692,11 @@ void handle_fasteoi_irq(struct irq_desc *desc)
>  
>  	raw_spin_lock(&desc->lock);
>  
> -	if (!irq_may_run(desc))
> +	if (!irq_may_run(desc)) {
> +		if (irqd_needs_resend_when_in_progress(&desc->irq_data))
> +			check_irq_resend(desc, true);

Marc,

I like your idea of using interrupt redelivery to enhance fasteoi handler. However,
I have a few concerns about the way you are proposing to implement it.

First, the cost issue you mentioned is still a concern in the context of mutiple
concurrent interrupts serviced by a single ITS. Actually, no matter what kind of
operation is performed(mask, unmask or resend), it end up with injecting an ITS
command with the ITS lock held. this could lead to performance issue.

Second, I am concerned that repeatedly resending the interrupt could be harmful to
the current task running on the new CPU. When an interrupt is delivered, the task
will be interrupt and forced to save and restore it context, and CPU must switch
exception level. This can be a costly operation, especially for virtualization systems.

Thanks.

>  		goto out;
> +	}
>  
>  	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
>  
> diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
> index bbcaac64038e..5971a66be034 100644
> --- a/kernel/irq/debugfs.c
> +++ b/kernel/irq/debugfs.c
> @@ -133,6 +133,8 @@ static const struct irq_bit_descr irqdata_states[] = {
>  	BIT_MASK_DESCR(IRQD_HANDLE_ENFORCE_IRQCTX),
>  
>  	BIT_MASK_DESCR(IRQD_IRQ_ENABLED_ON_SUSPEND),
> +
> +	BIT_MASK_DESCR(IRQD_RESEND_WHEN_IN_PROGRESS),
>  };
>  
>  static const struct irq_bit_descr irqdesc_states[] = {

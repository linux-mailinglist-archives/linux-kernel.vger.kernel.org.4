Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A96C664ED6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjAJWgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjAJWgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:36:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE68B42E32
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:36:15 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673390173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=He4dvGJh3gTvZX4K+U3XRlyrWDklv6GqTktTwC4BPCg=;
        b=xI9aw99CpdM49umjNPSGdFd/JWu3KseBBTYOktwLCdah4k8IYw3McGrMQmmc1dcY9DBE4A
        /hk2FU1FaMkFT0Q4Byfcr685jXNMCeIGzjQdLdIqFwvvqe+bmwoblzmkQtv8iPBNYEtE+I
        jGWPUFJs40AAxcMxF54IHHCCvSKNY3hplx8VeTSoEWReenWOct+CovFulhJGxLL95bvkNq
        wfBCgVAak5wExcOZ7e2JsJvy3G4FVnVZbpIOg7p/X6iCQIeeEwHr4yLCxlxVZvjmMI7LaV
        XSOx7Vr+w7aBrT5190bmLZKbulghic/H3AX/a5zn8SwFy2+r+5Zd9LMMYJqgSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673390173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=He4dvGJh3gTvZX4K+U3XRlyrWDklv6GqTktTwC4BPCg=;
        b=bvMglZN7B7FaXwwg9lWaqbFVhkmsCJEBA2v/D7hZ3SFf8Sh64ncaHXiCJW96FrdNbu3x16
        vER0cMf/vPpSj7AQ==
To:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: gic: increase the number of IRQ descriptors
In-Reply-To: <d64145d6-966c-2e9d-beca-b8f896c8d2f0@nvidia.com>
References: <20230104023738.1258925-1-sdonthineni@nvidia.com>
 <86sfgq7jb3.wl-maz@kernel.org>
 <2a0116a8-fbd0-d866-ada0-ed50f0523f1d@nvidia.com>
 <86k0216ydh.wl-maz@kernel.org>
 <4cc4114d-7fa5-1c23-3504-0ca4dbdd0f62@nvidia.com>
 <86fscjoe3i.wl-maz@kernel.org>
 <ed471259-5d32-e93b-20d6-42a32b8b3d89@nvidia.com>
 <87pmbmer6x.wl-maz@kernel.org>
 <d64145d6-966c-2e9d-beca-b8f896c8d2f0@nvidia.com>
Date:   Tue, 10 Jan 2023 23:36:12 +0100
Message-ID: <875ydej9ur.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shanker!

On Tue, Jan 10 2023 at 08:22, Shanker Donthineni wrote:
> On 1/10/23 02:20, Marc Zyngier wrote:
>> I think you should address the problem the other way around, as there
>> are lower hanging fruits:
>> 
>> - turn the irq_desc_tree radix tree into a XArray
>> 
>> - use the XArray mark feature to reimplement the irqs_resend bitmap

and then you go and do:

>      genirq: Use IDR API for Linux-IRQ IDs allocation

But let me look at your preparation patch first:

> +static void irq_free_descs_ids(unsigned int from, unsigned int cnt)
> +{
> +       bitmap_clear(allocated_irqs, from, cnt);
> +}
> +
> +static int irq_alloc_descs_ids(unsigned int from, unsigned int cnt)
> +{
> +       return bitmap_find_next_zero_area(allocated_irqs, IRQ_BITMAP_BITS,
> +                                         from, cnt, 0);

This is a complete misnomer simply because this does not allocate
anything. It finds an appropriate sized empty area.

The actual bitmap update happens later which you then remove in the
second patch:

> -       bitmap_set(allocated_irqs, start, cnt);

thereby breaking SPARSEIRQ=n configs....

> +}
> +
> +static unsigned int irq_get_next_id(unsigned int offset)
> +{
> +       return find_next_bit(allocated_irqs, nr_irqs, offset);
> +}

That's a misnomer too. This is not about getting an arbitrary next ID
starting at @offset. This is about finding the next allocated interrupt
number starting at @offset.

Naming matters. This code is hard enough to read already. No need for
further confusion.

>      The build time config paramter IRQ_BITMAP_BITS (NR_IRQS+8196)
>      may not be sufficient for some architectures. The interrupt ID
>      sparse is huge for ARM-GIC architecture ~32 bits. Static bitmap
>      memory for managing IDs is not optimal when NR_IRQS is set to
>      a high value.
>
>      It uses the IDR API for the IRQ ID allocation/deallocation and
>      its descriptors management insertion/deletion/search. No other
>      references to macro IRQ_BITMAP_BITS hence remove it.

Changelogs should tell the WHY and not the WHAT. I can see that it uses
IDR from the patch, but there is _ZERO_ justification why IDR is the
right choice for this.

>   static int irq_alloc_descs_ids(unsigned int from, unsigned int cnt)
>   {
> -       return bitmap_find_next_zero_area(allocated_irqs, IRQ_BITMAP_BITS,
> -                                         from, cnt, 0);
> +       int start, id, i;
> +
> +       do {
> +               /* Allocate starting ID */
> +               start = idr_alloc(&idr_irq_descs, NULL, from, 0, GFP_ATOMIC);

Why does this require GFP_ATOMIC? The allocation is serialized by a
mutex and is fully preemptible.

Can you find a single GPF_ATOMIC in the irqdesc code?

If you had at least read through the changelogs of that file you would
have found a series of commits which worked towards making the irqdesc
allocation use GFP_KERNEL. But sure, it's way simpler to throw GFP_ATOMIC
at the code just because...

> +               if (start < 0)
> +                       return start;
> +               idr_set_cursor(&idr_irq_descs, start);
> +
> +               /* Allocate contiguous IDs */
> +               for (i = 1; i < cnt; i++) {
> +                       id = idr_alloc_cyclic(&idr_irq_descs, NULL, start + i,
> +                                             start + i, GFP_ATOMIC);
> +                       if (id < 0) {
> +                               irq_free_descs_ids(from, i);

So if there is not enough room, then you start over. *Shudder*

Just assume a halfways dense populated IDR with tons of small holes and
then try to allocate 128 MSI vectors. That'll take ages...

You can simply use a maple_tree for this.

static MTREE_INIT_EXT(sparse_irqs, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN, 
                      sparse_irq_lock);

And the functions become:

static int irq_find_free_area(unsigned int from, unsigned int cnt)
{
        MA_STATE(mas, &sparse_irqs, 0, 0);

        if (mas_empty_area(&mas, from, MAX_SPARSE_IRQS, cnt))
        	return -ENOSPC;
        return mas.index;
}

static unsigned int irq_find_next_irq(unsigned int offset)
{
        MA_STATE(mas, &sparse_irqs, offset, nr_irqs);
        struct irq_desc *desc = mas_next(&mas, nr_irqs);

        return desc ? irq_desc_get_irq(desc) : nr_irqs;
}

static int irq_insert_desc(irq, desc)
{
        MA_STATE(mas, @sparse_irqs, irq, irq);

        return mas_store_gfp(&mas, desc, GFP_KERNEL);
}

static void irq_remove_desc(irq)
{
        MA_STATE(mas, @sparse_irqs, irq, irq);

        return mas_erase(&mas);
}

or something like that.

Coming back to SPARSEIRQ=n.

I'm more than tempted to take this opportunity to get rid of this
distinction. There is no real reason to have the duplicated code. We can
simply get rid of the statically allocated irq descriptor arrays and
just do the preallocation in early_irq_init().

Now for the pending bits:

> ... The irq_resend change will be simple, IDR will fit perfectly.

You wish...

>          /* Set it pending and activate the softirq: */
> -       set_bit(irq, irqs_resend);
> +       id = idr_alloc(&irqs_resend, desc, 0, 0, GFP_ATOMIC);

This breaks PREEMPT_RT as this code runs under a raw spinlock with
interrupts and preemption disabled and _cannot_ do any allocations.

Again, the changelogs of the interrupt code contain enough information
to figure these things out. But sure it's simpler to throw some half
baken stuff at the kernel and see what sticks...

Marc's suggestion to utilize XARRAY and the mark feature would trivialy
avoid this because there is no allocation required in that code
path. The descriptor already exists in the XARRAY.

But that can't work either on PREEMPT_RT because for setting the mark
the xarray code needs to acquire xarray::xa_lock which is a regular
spinlock, which nest inside of a raw spinlock.

So this needs a completely different approach. Let's look at the
functionality of the resend code:

   It's a crutch which tries to handle the inability of (legacy)
   interrupt chips to reinject interrupts at the hardware level.

There is absolutely no reason to care about performance for that, but
using IDR (or anything like that) instead of the bitmap is just
hillarious.

So what else can be done? The obvious:

static DEFINE_RAW_SPINLOCK(irq_resend_lock);
static struct hlist_head irq_resend_list;

static int irq_sw_resend(struct irq_desc *desc)
{
	....
        raw_spin_lock(&irq_resend_lock);
        hlist_add_head(&desc->resend_node, &irq_resend_list);
        raw_spin_lock(&irq_resend_lock);
        tasklet_schedule(&resend_tasklet);
}

and the resend side:

static void resend_irqs(struct tasklet_struct *unused)
{
	struct irq_desc *desc;
	int irq;

        raw_spin_lock_irq(&irq_resend_lock);
	while (!hlist_empty(&irqs_resend_list)) {
                desc = hlist_entry(irqs_resend_list.first, ....);
                hlist_del_init(&desc->resend_node);
		desc->handle_irq(desc);
	}
        raw_spin_unlock_irq(&irq_resend_lock);
}

Plus the proper mechanics to handle the hlist entry when an interrupt is
torn down, which is not rocket science either.

Thanks,

        tglx

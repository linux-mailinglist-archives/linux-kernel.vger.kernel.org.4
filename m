Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86A06C82BD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjCXRBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXRBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:01:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E67E3A0;
        Fri, 24 Mar 2023 10:01:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6768CCE2486;
        Fri, 24 Mar 2023 17:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297EEC433EF;
        Fri, 24 Mar 2023 17:01:31 +0000 (UTC)
Date:   Fri, 24 Mar 2023 17:01:28 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Bouska, Zdenek" <zdenek.bouska@siemens.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Puranjay Mohan <p-mohan@ti.com>
Subject: Re: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
Message-ID: <ZB3XaNtVqGtYHHBw@arm.com>
References: <AS1PR10MB56750EFD7BEA779D033A68CBEB849@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1PR10MB56750EFD7BEA779D033A68CBEB849@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 08:43:38AM +0000, Bouska, Zdenek wrote:
> I have seen ~3 ms delay in interrupt handling on ARM64.
> 
> I have traced it down to raw_spin_lock() call in handle_irq_event() in
> kernel/irq/handle.c:
> 
> irqreturn_t handle_irq_event(struct irq_desc *desc)
> {
>     irqreturn_t ret;
> 
>     desc->istate &= ~IRQS_PENDING;
>     irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
>     raw_spin_unlock(&desc->lock);
> 
>     ret = handle_irq_event_percpu(desc);
> 
> --> raw_spin_lock(&desc->lock);
>     irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
>     return ret;
> }
> 
> It took ~3 ms for this raw_spin_lock() to lock.

That's quite a large indeed.

> During this time irq_finalize_oneshot() from kernel/irq/manage.c locks and
> unlocks the same raw spin lock more than 1000 times:
> 
> static void irq_finalize_oneshot(struct irq_desc *desc,
>                  struct irqaction *action)
> {
>     if (!(desc->istate & IRQS_ONESHOT) ||
>         action->handler == irq_forced_secondary_handler)
>         return;
> again:
>     chip_bus_lock(desc);
> --> raw_spin_lock_irq(&desc->lock);
> 
>     /*
>      * Implausible though it may be we need to protect us against
>      * the following scenario:
>      *
>      * The thread is faster done than the hard interrupt handler
>      * on the other CPU. If we unmask the irq line then the
>      * interrupt can come in again and masks the line, leaves due
>      * to IRQS_INPROGRESS and the irq line is masked forever.
>      *
>      * This also serializes the state of shared oneshot handlers
>      * versus "desc->threads_oneshot |= action->thread_mask;" in
>      * irq_wake_thread(). See the comment there which explains the
>      * serialization.
>      */
>     if (unlikely(irqd_irq_inprogress(&desc->irq_data))) {
> -->     raw_spin_unlock_irq(&desc->lock);
>         chip_bus_sync_unlock(desc);
>         cpu_relax();
>         goto again;
>     }

So this path is hammering the desc->lock location and another CPU cannot
change it. As you found, the problem is not the spinlock algorithm but
the atomic primitives. The LDXR/STXR constructs on arm64 are known to
have this issue with STXR failing indefinitely. raw_spin_unlock() simply
does an STLR and this clears the exclusive monitor that the other CPU
may have set with LDXR but before the STXR. The queued spinlock only
provides fairness if the CPU manages to get in the queue.

> So I confirmed that atomic operations from
> arch/arm64/include/asm/atomic_ll_sc.h can be quite slow when they are
> contested from second CPU.
> 
> Do you think that it is possible to create fair qspinlock implementation
> on top of atomic instructions supported by ARM64 version 8 (no LSE atomic
> instructions) without compromising performance in the uncontested case?
> For example ARM64 could have custom queued_fetch_set_pending_acquire
> implementation same as x86 has in arch/x86/include/asm/qspinlock.h. Is the
> retry loop in irq_finalize_oneshot() ok together with the current ARM64
> cpu_relax() implementation for processor with no LSE atomic instructions?

So is the queued_fetch_set_pending_acquire() where it gets stuck or the
earlier atomic_try_cmpxchg_acquire() before entering on the slow path? I
guess both can fail in a similar way.

A longer cpu_relax() here would improve things (on arm64 this function
is a no-op) but maybe Thomas or Will have a better idea.

-- 
Catalin

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5D16C8486
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjCXSJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjCXSJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:09:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A422210E2;
        Fri, 24 Mar 2023 11:09:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 530A5B82548;
        Fri, 24 Mar 2023 18:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4F5C433EF;
        Fri, 24 Mar 2023 18:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679681350;
        bh=kWAglP/3M/YpfurCGt08xf8SdrOMxcAlvmBWofnH+50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g7qKyXjwRyQ/7rfhwb+FcWl+TNUjHuR/K37ZoWIxgSdzD5KdAQ1zxecVVv8DaIp95
         /O7OW+YssvLHLD/Vx7J7f5iWDJRtptE2oVGtFB4m9vzK9ZyniX31i7u9q7BQs9cweI
         tsauNVu2HhXXBo8zC6R1dhMCXwtjyGvbmkgaftxPHrQCgSzR4b/bfmR+yTsI+SnqfQ
         nV5yNLepx4kBuluss3Do9BcBeNZVTh6C9bkz0qb1Y/PPDrbzU1s7Jw4unb6p788AlL
         A5S7kdVbKT9cjV7ZmRYCSB+rKEoYpxcalZyja1y7g1Y3B0KNfT1RlFyYj4v836V087
         Lhj+Rc8JELitQ==
Date:   Fri, 24 Mar 2023 18:09:05 +0000
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     "Bouska, Zdenek" <zdenek.bouska@siemens.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Puranjay Mohan <p-mohan@ti.com>
Subject: Re: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
Message-ID: <20230324180904.GA28266@willie-the-truck>
References: <AS1PR10MB56750EFD7BEA779D033A68CBEB849@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
 <ZB3XaNtVqGtYHHBw@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB3XaNtVqGtYHHBw@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 05:01:28PM +0000, Catalin Marinas wrote:
> On Fri, Mar 24, 2023 at 08:43:38AM +0000, Bouska, Zdenek wrote:
> > I have seen ~3 ms delay in interrupt handling on ARM64.
> > 
> > I have traced it down to raw_spin_lock() call in handle_irq_event() in
> > kernel/irq/handle.c:
> > 
> > irqreturn_t handle_irq_event(struct irq_desc *desc)
> > {
> >     irqreturn_t ret;
> > 
> >     desc->istate &= ~IRQS_PENDING;
> >     irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
> >     raw_spin_unlock(&desc->lock);
> > 
> >     ret = handle_irq_event_percpu(desc);
> > 
> > --> raw_spin_lock(&desc->lock);
> >     irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
> >     return ret;
> > }
> > 
> > It took ~3 ms for this raw_spin_lock() to lock.
> 
> That's quite a large indeed.
> 
> > During this time irq_finalize_oneshot() from kernel/irq/manage.c locks and
> > unlocks the same raw spin lock more than 1000 times:
> > 
> > static void irq_finalize_oneshot(struct irq_desc *desc,
> >                  struct irqaction *action)
> > {
> >     if (!(desc->istate & IRQS_ONESHOT) ||
> >         action->handler == irq_forced_secondary_handler)
> >         return;
> > again:
> >     chip_bus_lock(desc);
> > --> raw_spin_lock_irq(&desc->lock);
> > 
> >     /*
> >      * Implausible though it may be we need to protect us against
> >      * the following scenario:
> >      *
> >      * The thread is faster done than the hard interrupt handler
> >      * on the other CPU. If we unmask the irq line then the
> >      * interrupt can come in again and masks the line, leaves due
> >      * to IRQS_INPROGRESS and the irq line is masked forever.
> >      *
> >      * This also serializes the state of shared oneshot handlers
> >      * versus "desc->threads_oneshot |= action->thread_mask;" in
> >      * irq_wake_thread(). See the comment there which explains the
> >      * serialization.
> >      */
> >     if (unlikely(irqd_irq_inprogress(&desc->irq_data))) {
> > -->     raw_spin_unlock_irq(&desc->lock);
> >         chip_bus_sync_unlock(desc);
> >         cpu_relax();
> >         goto again;
> >     }
> 
> So this path is hammering the desc->lock location and another CPU cannot
> change it. As you found, the problem is not the spinlock algorithm but
> the atomic primitives. The LDXR/STXR constructs on arm64 are known to
> have this issue with STXR failing indefinitely. raw_spin_unlock() simply
> does an STLR and this clears the exclusive monitor that the other CPU
> may have set with LDXR but before the STXR. The queued spinlock only
> provides fairness if the CPU manages to get in the queue.
> 
> > So I confirmed that atomic operations from
> > arch/arm64/include/asm/atomic_ll_sc.h can be quite slow when they are
> > contested from second CPU.
> > 
> > Do you think that it is possible to create fair qspinlock implementation
> > on top of atomic instructions supported by ARM64 version 8 (no LSE atomic
> > instructions) without compromising performance in the uncontested case?
> > For example ARM64 could have custom queued_fetch_set_pending_acquire
> > implementation same as x86 has in arch/x86/include/asm/qspinlock.h. Is the
> > retry loop in irq_finalize_oneshot() ok together with the current ARM64
> > cpu_relax() implementation for processor with no LSE atomic instructions?
> 
> So is the queued_fetch_set_pending_acquire() where it gets stuck or the
> earlier atomic_try_cmpxchg_acquire() before entering on the slow path? I
> guess both can fail in a similar way.
> 
> A longer cpu_relax() here would improve things (on arm64 this function
> is a no-op) but maybe Thomas or Will have a better idea.

I had a pretty gross cpu_relax() implementation using wfe somewhere on
LKML, so you could try that if you can dig it up.

Generally though, LDXR/STXR and realtime don't mix super well.

Will

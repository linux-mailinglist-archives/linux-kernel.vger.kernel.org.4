Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D7D6EACCB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjDUOZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjDUOZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:25:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5813E9EC8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=chH3xcMkXQQvbi3GLHEgVa4/q08e8dm8Ia2xst1wK/E=; b=S8ao+y3/t+cGcCdJejWo0QjSa3
        Q3jTLjbpnVHqTH23g9phkQPXwIXgWt6F4OpAP9UlEjKpLUD/KmoUf+W/F35dsWsesiNG+ZEpLD16v
        r2B0JfFNJwmaUPpST7g0YY0sOrlIGwDWMqfDvAYUn6gHwWNo5oZ3iJzB0AR2DQOuljRd4k5l4qcjE
        M4nw+hEwm4ZBv/6l80teNGeVwfRr+PYu+w4broXXN8gYrkdyq5zI8rilaoH88i9Ij8ADf/QHkZlz2
        fCrSJnd0Y74qr0RxCiO9m6hMVHo4rpLd9/+9Dmo0nyqObfuRGYJ4KB9dmDT8Idd2V7FVytFSDuWto
        OfNHb/vw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pprgv-00FK1E-Ji; Fri, 21 Apr 2023 14:24:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E3EB3000DC;
        Fri, 21 Apr 2023 16:24:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 046AE23BCFBDD; Fri, 21 Apr 2023 16:24:46 +0200 (CEST)
Date:   Fri, 21 Apr 2023 16:24:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Loongson (and other $ARCHs?) idle VS timer enqueue
Message-ID: <20230421142446.GA1185829@hirez.programming.kicks-ass.net>
References: <ZEKDZEQmKExv0O7Q@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEKDZEQmKExv0O7Q@lothringen>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 02:36:52PM +0200, Frederic Weisbecker wrote:
> Hi,
> 
> I'm looking at the __arch_cpu_idle() implementation in Loongarch
> and I'm wondering about the rollback code. I don't understand well
> that code but with the help from PeterZ I might have seen something,
> so tell me if I'm wrong: when an interrupt happens within
> __arch_cpu_idle(), handle_vint() rolls back the return value to the
> beginning of __arch_cpu_idle(), so that TIF_NEED_RESCHED is checked
> again. Is that correct?

Loongson copied this crap from MIPS, so they are direct affected too.

> Because if an interrupt fires while in __arch_cpu_idle(), that IRQ
> might enqueue a new timer and that new timer needs to be reprogrammed
> from the main idle loop and just checking TIF_NEED_RESCHED doesn't
> tell about that information.

Notably; this is only relevant to NOHZ, right?

> 
> More generally IRQs must _not_ be re-enabled between cpuidle_select()
> (or just tick_nohz_idle_stop_tick() if no cpuidle support) and the
> last halting ASM instruction. If that happens there must be
> a mechanism to cope with that and make sure we return to the main
> idle loop.
> 
> If that mechanism has to go through rollback (I wish your arch allows
> you to find a simpler and less error prone mechanism through), then the
> rollback must actually fast forward to after the halting instruction
> so that the main idle loop re-checks the timers. But then
> __arch_cpu_idle() alone is not enough to be part of the fastforward
> section, it has to start before the raw_local_irq_enable() in
> arch_cpu_idle().
> 
> Another way to cope with this would be to have:
> 
> #define TIF_IDLE_TIMER	 ...
> #define TIF_IDLE_EXIT	 (TIF_NEED_RESCHED | TIF_IDLE_TIMER)
> 
> And set that from the timer enqueue in idle time and check TIF_IDLE_EXIT
> on idle callback. It depends how many architectures are concerned by this.
> All I know so far is:

The alternative is changing kernel/entry/common.c:irqentry_exit() to add
a nohz callback next to ct_irq_exit(), and have that reprogram the timer
if/when we're in NOHZ mode.

> * mwait based mechanism should be fine if called with IRQs disabled (or
> sti is called right before) but then we must be sure that IRQs have never
> been even temporarily re-enabled between cpuidle_select() and mwait. How
> to detect that kind of mistake?

mwait_idle_with_hints() is unaffected since it will idle with IRQs
disabled and wait on IRQ-pending (without taking the interrupt).

*HOWEVER*

intel_idle_irq() is affected -- except that we only (normally) use that
for very shallow idle states and it won't interact with NOHZ (because we
only disable the tick for deep idle states).

sti_mwait() relies on the STI shadow, just like hlt below.

> * wfi based mechanism look fine, but again we must make sure IRQs have
> never been re-enabled.

Yes, arm64 WFI has interrupts disabled and will wake on IRQ-pending

> * sti;hlt should be fine but again...

Indeed, STI has a shadow where the effect of enabling interrupts lags
one instruction, so the HLT being in that shadow actually still runs
with IRQs disabled. Any interrupt will then hit when HLT is in effect
and wake up.

> * Need to check all other archs
> 
> I'm trying to find an automated way to debug this kind of issue but it's not
> easy...

Yeah, too much arch code :/ Easiest might be to check if our idea of
where the timer should be and the hardware agree on IRQ entry or so --
*any* IRQ. That will miss a lot of cases, but at least it's something.

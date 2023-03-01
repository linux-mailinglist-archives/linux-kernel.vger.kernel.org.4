Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2638B6A6A12
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCAJw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCAJwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:52:25 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15A831E23;
        Wed,  1 Mar 2023 01:52:24 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-536c02c9dfbso350474997b3.11;
        Wed, 01 Mar 2023 01:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677664344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7hwkCqrrG+TWaJq+oKYRSNate7/LEvnJo9ySumX8c3E=;
        b=mEIVCoRNH34DNPFjwi0/PpyRHTIxSp3sN0woFKz+Qe+mXoWTIY87udvnIgykOITk0j
         MN+wMNNiN69K61zA6EN7O09OxsRMl+oBjoe1zdvyMbRZ5WkB1gm9Kp5Hud1agDdvG2I7
         CbHxSCPHxhz7izV2t1HzIExNXCmSShUx+KSAafErQ9w63AXAQstwlMSPJ4Rh+K3J/+NO
         sLEGoB5woYvpkV1qvRZIw5ON4OoDRUn4dAa7gXyEolRl5XbWKfKDgOdAZ19wvLG5suTh
         88vs9zKUTTVvrMybViKtAogtc7nQdw5ycJWdpT6T4oOU1mP1MN+z9qKoTh2sswhthTg9
         e9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677664344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hwkCqrrG+TWaJq+oKYRSNate7/LEvnJo9ySumX8c3E=;
        b=ArgGFD/ZwBL2GIc7wDzMNEBm2qPITYEYPcj+lrfRdCULTluviWKomIDNbNacGj7TxJ
         MVXtwU/DDfEJpiv/A5CV4Ly+wuF4Iebu6WuSTu2xWn2yg9CWeafhLspTTyEyQGfjkWZm
         zdURQLBiUpNRI2yeB6LRUXJCrTPewvB+5pEer+AHsfV+0+UlpOjYKDI68dRBdv5MrYR+
         7kTOcqM8KQU38YwW52JYIbIXroW8DkPpHos9nM5ziPB4lzJPszlUhZ9m7WQMAKR3TdU1
         kxyO/v9/mNa+60N48dxldaWASit1O1ioJRaZKPpxQ6rIHv6gzeC4DIqk3fCXMBjcXN0F
         0gZA==
X-Gm-Message-State: AO0yUKU+N+F1i03hErOkF1VVXvzVMCPpSMkfO6QXBAELy/GlrtRh+8IB
        FoQqxkhIOpLpEx6Io5uQZGIO/7bsP28yyrS4gZd+8Fv20LNX+OG3
X-Google-Smtp-Source: AK7set/H3ge6WmuwLOgDvkh4OWRb7DbCF4IAzvpKSzE5D/9M6n/trRhUjKdgmal7OFhucUrlkw8MnhmDTZptlnM20U4=
X-Received: by 2002:a81:b70a:0:b0:536:7529:55ae with SMTP id
 v10-20020a81b70a000000b00536752955aemr3651680ywh.2.1677664343995; Wed, 01 Mar
 2023 01:52:23 -0800 (PST)
MIME-Version: 1.0
References: <20230228155121.3416-1-ubizjak@gmail.com> <Y/5mguXPPqdP3MZF@google.com>
In-Reply-To: <Y/5mguXPPqdP3MZF@google.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 1 Mar 2023 10:52:12 +0100
Message-ID: <CAFULd4YCVp9Rj5XCt-4b=f_QjpgyZ1zseP01otC9pRSnV9wvvA@mail.gmail.com>
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 9:39 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Tue, Feb 28, 2023 at 04:51:21PM +0100, Uros Bizjak wrote:
> > Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> > check_cpu_stall.  x86 CMPXCHG instruction returns success in ZF flag, so
> > this change saves a compare after cmpxchg (and related move instruction in
> > front of cmpxchg).
>
> In my codegen, I am not seeing mov instruction before the cmp removed, how
> can that be? The rax has to be populated with a mov before cmpxchg right?
>
> So try_cmpxchg gives: mov, cmpxchg, cmp, jne
> Where as cmpxchg gives: mov, cmpxchg, mov, jne

(I assume the above is reversed)

You have quite a new compiler (e.g. gcc-12+) which is able to reorder
basic blocks, reschedule instructions and create fast paths through
the code based on likely/unlikely annotations in the definition of
try_cmpxchg. [On a related note, some code growth is allowed to the
compiler in the hot path since the kernel is compiled with -O2, not
-Os.] gcc-10.3.1 improves the code from tree.c from:

    a1c5:    0f 84 53 03 00 00        je     a51e <rcu_sched_clock_irq+0x70e>
    a1cb:    48 89 c8                 mov    %rcx,%rax
    a1ce:    f0 48 0f b1 35 00 00     lock cmpxchg %rsi,0x0(%rip)
  # a1d7 <rcu_sched_clock_irq+0x3c7>
    a1d5:    00 00
            a1d3: R_X86_64_PC32    .data+0xf9c
    a1d7:    48 39 c1                 cmp    %rax,%rcx
    a1da:    0f 85 3e 03 00 00        jne    a51e <rcu_sched_clock_irq+0x70e>

to:

    a1d0:    0f 84 49 03 00 00        je     a51f <rcu_sched_clock_irq+0x70f>
    a1d6:    f0 48 0f b1 35 00 00     lock cmpxchg %rsi,0x0(%rip)
  # a1df <rcu_sched_clock_irq+0x3cf>
    a1dd:    00 00
            a1db: R_X86_64_PC32    .data+0xf9c
    a1df:    0f 85 3a 03 00 00        jne    a51f <rcu_sched_clock_irq+0x70f>

The change brings the following code size improvement:

  text    data     bss     dec     hex filename
 57712    9945      86   67743   1089f tree-new.o
 57760    9945      86   67791   108cf tree-old.o

Small change, but the result of effectively an almost mechanical
one-line substitutions.

Uros.

> So yeah you got rid of compare, but I am not seeing reduction in moves.
> Either way, I think it is an improvement due to dropping cmp so:
>
> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> thanks,
>
>  - Joel
>
>
> >
> > No functional change intended.
> >
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > ---
> >  kernel/rcu/tree_stall.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index b10b8349bb2a..d81c88e66b42 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -760,7 +760,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
> >       jn = jiffies + ULONG_MAX / 2;
> >       if (rcu_gp_in_progress() &&
> >           (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
> > -         cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
> > +         try_cmpxchg(&rcu_state.jiffies_stall, &js, jn)) {
> >
> >               /*
> >                * If a virtual machine is stopped by the host it can look to
> > @@ -778,7 +778,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
> >
> >       } else if (rcu_gp_in_progress() &&
> >                  ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
> > -                cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
> > +                try_cmpxchg(&rcu_state.jiffies_stall, &js, jn)) {
> >
> >               /*
> >                * If a virtual machine is stopped by the host it can look to
> > --
> > 2.39.2
> >

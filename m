Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D337A6217A4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiKHPGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiKHPGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:06:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9063914037
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:06:22 -0800 (PST)
Date:   Tue, 8 Nov 2022 16:06:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667919980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfPSUnpW7rzzp1CUkOeNkqJuJm75Rk0F+y/XDUXdnVo=;
        b=2Pyd82zWpylLBxLRAxXeJmedNKZW4wuVXbvGWrwmOLEP3zWnEST2xrB8BlbAlkZDBAgLBO
        Lkw5aJ+AUBE9vZ9TZUdfbv9/3eHscaHai0HTPpSuGe0/mdj+nhSFl/pliZTfGPCJHM5Exp
        FhgqTC21WcOR0UB08kIB4hh3xrbURYP0JagOb4CRr/TUf2Mf19BBIyBfCMlOfh+mji7E/k
        PGni23dv6Iyrabk+/9+pcM4+W6tWaznblb2ONq7u3Bi76QaNaDUfeHAb1GwsPjVQI5fpHl
        mhGR0ltybUSnFg3fxiLwMVTnDCgb7zFBit9Aw+jeqQmRiphtuY2qdoiWV9oAqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667919980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfPSUnpW7rzzp1CUkOeNkqJuJm75Rk0F+y/XDUXdnVo=;
        b=FZyRqcXoaFj7sdCrb166GHWCSYax2w9oI7AIU59fnJWoGGfovdgWBXMrX+VKKSKslXf2bH
        s4B3RTGiEpVOKyAw==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v4 00/16] timer: Move from a push remote at enqueue to
 a pull at expiry model
In-Reply-To: <20221108043708.GA9994@hu-pkondeti-hyd.qualcomm.com>
Message-ID: <776be028-9161-9ba1-3bf9-417b17f46a1b@linutronix.de>
References: <20221104145737.71236-1-anna-maria@linutronix.de> <20221108043708.GA9994@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2022, Pavan Kondeti wrote:

> Hi Anna-Maria,
> 
> On Fri, Nov 04, 2022 at 03:57:21PM +0100, Anna-Maria Behnsen wrote:
> > Next Steps
> > ~~~~~~~~~~
> > 
> > Simple deferrable timers are no longer required as they can be converted to
> > global timers. If a CPU goes idle, a formerly deferrable timer will not
> > prevent the CPU to sleep as long as possible. Only the last migrator CPU
> > has to take care of them. Deferrable timers with timer pinned flags needs
> > to be expired on the specified CPU but must not prevent CPU from going
> > idle. They require their own timer base which is never taken into account
> > when calculating the next expiry time. This conversation and required
> > cleanup will be done in a follow up series.
> > 
> 
> Taking non-pinned deferrable timers case, they are queued on their own base
> and its expiry is not taken into account while programming the next timer
> event during idle.

If CPU is not the last CPU going idle, then yes.
 
> Can you elaborate on "Simple deferrable timers are no longer required as they
> can be converted to global timers" statement?

Global timers do not prevent CPU from going idle. Same thing that
deferrable timers does right now. Global timers are queued into the
hierarchy and migrator takes care of expiry when CPU goes idle. The main
change of behavoir with global timers compared to deferrable timers is,
that they will expire in time and not necessarily on the CPU they were
enqueued. Deferrable timers were expired, only when the CPU was awake and
always on the CPU they have been enqueued.

> Though they can be on global base, we still need to find a way to distinguish
> them aginst the normal global timers so that the last migrator can program
> the next timer event without taking these deferrable timer expiry into
> account? IOW, a deferrable timer should not bring a completely idle system out
> of idle to serve the deferrable timer.

This behavior will change a little. If the system is completely idle, the
last migrator CPU has to handle the first global timer even if it is a
formerly deferrable and non pinned timer.

> When the deferrable timers will be queued on global base, once a CPU comes out
> of idle and serve the timers on global base, the deferrable timers also would
> be served. This is a welcoming change. We would see a truly deferrable global
> timer something we would be interested in. [1] has some background on this.

Serving the deferrable timers once a CPU comes out of idle is already the
case even without the timer migration hierarchy. See upstream version of
run_local_timers().

> [1]
> https://lore.kernel.org/lkml/1430188744-24737-1-git-send-email-joonwoop@codeaurora.org/

As far as I understand the problem you are linking to correctly, you want
to have a real "unbound" solution for deferrable or delayed work. This is
what you get with the timer migration hierarchy and when enqueuing
deferrable timers into global timer base. Timers are executed on the
migrator CPU because this CPU is not idle - doesn't matter where they have
been queued before.

It might be possible, that a fomerly deferrable timer enforces the last CPU
going idle to come back out of idle. But the question is, how often does
this occur in contrast to a wakeup cause by a non deferrable timer?  If you
have a look at the timers in kernel you have 64 deferrable timers (this
number also contain the deferrable and pinned timers). There are 7 timers
with only TIMER_PINNED flag and some additional using the add_timer_on() to
be enqueued on a dedicated CPU. But in total we have more than 1000
timers. Sure - in the end, numbers hardly depends on the selected kernel
config...

Side note: One big problem of deferrable timers disappear with this
approach. All deferrable timers _WILL_ expire. Even if CPU where they have
been enqueued does not come back out of idle. Only deferrable and pinned
timers will still have this problem.

Thanks,

	Anna-Maria

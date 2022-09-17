Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157195BB8BB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 16:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiIQOZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 10:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIQOZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 10:25:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A671408A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:25:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F473614F7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 14:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E7DC433D6;
        Sat, 17 Sep 2022 14:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663424708;
        bh=h9zDuVIEftxkA5PLJu7r3pDMbCp+ron9ibSyinhZuo4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MTPJPrE0ymGIsUMsrMGRBBiCLP3qLfzy07Q/+Rq2Z427TAeHw6WpmKqCYTpkJxRCv
         lyksVauQzNZ+3q1lyv6y6YBk9LgHiPjsxcrxdNy7DC0bwroOBxO86fa8/Axc9e70gn
         rjymyVE+dPVi+6YQzaub28BtOQfVsRa9tqS4HouN2OKr6zvDO+L0x6GcVTuTmNIMpf
         WR7vnwyHFV20wqxJICtHAr9G8huTzzUB/Jhjms6G8puLc2cOKtzWuTsiP/tBkic4aZ
         ad6dofivoCwU6s/B4G222lZNIiIBpsjOAFoBCUHwVTz7c8/7U1jTe2n9ai5ZezZ/ic
         7o9anHYhohGeg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 805FB5C04D0; Sat, 17 Sep 2022 07:25:08 -0700 (PDT)
Date:   Sat, 17 Sep 2022 07:25:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RCU vs NOHZ
Message-ID: <20220917142508.GF246308@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
 <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1>
 <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
 <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 11:20:14AM +0200, Peter Zijlstra wrote:
> On Fri, Sep 16, 2022 at 12:58:17AM -0700, Paul E. McKenney wrote:
> 
> > To the best of my knowledge at this point in time, agreed.  Who knows
> > what someone will come up with next week?  But for people running certain
> > types of real-time and HPC workloads, context tracking really does handle
> > both idle and userspace transitions.
> 
> Sure, but idle != nohz. Nohz is where we disable the tick, and currently
> RCU can inhibit this -- rcu_needs_cpu().

Exactly.  For non-nohz userspace execution, the tick is still running
anyway, so RCU of course won't be inhibiting its disabling.  And in that
case, RCU's hook is the tick interrupt itself.  RCU's hook is passed a
flag saying whether the interrupt came from userspace or from kernel.

> AFAICT there really isn't an RCU hook for this, not through context
> tracking not through anything else.

There is a directly invoked RCU hook for any transition that enables or
disables the tick, namely the ct_*_enter() and ct_*_exit() functions,
that is, those functions formerly known as rcu_*_enter() and rcu_*_exit().

> > It wasn't enabled for ChromeOS.
> > 
> > When fully enabled, it gave them the energy-efficiency advantages Joel
> > described.  And then Joel described some additional call_rcu_lazy()
> > changes that provided even better energy efficiency.  Though I believe
> > that the application should also be changed to avoid incessantly opening
> > and closing that file while the device is idle, as this would remove
> > -all- RCU work when nearly idle.  But some of the other call_rcu_lazy()
> > use cases would likely remain.
> 
> So I'm thinking the scheme I outlined gets you most if not all of what
> lazy would get you without having to add the lazy thing. A CPU is never
> refused deep idle when it passes off the callbacks.
> 
> The NOHZ thing is a nice hook for 'this-cpu-wants-to-go-idle-long-term'
> and do our utmost bestest to move work away from it. You *want* to break
> affinity at this point.
> 
> If you hate on the global, push it to a per rcu_node offload list until
> the whole node is idle and then push it up the next rcu_node level until
> you reach the top.
> 
> Then when the top rcu_node is full idle; you can insta progress the QS
> state and run the callbacks and go idle.

Unfortunately, the overhead of doing all that tracking along with
resolving all the resulting race conditions will -increase- power
consumption.  With RCU, counting CPU wakeups is not as good a predictor
of power consumption as one might like.  Sure, it is a nice heuristic
in some cases, but with RCU it is absolutely -not- a replacement for
actually measuring power consumption on real hardware.  And yes, I did
learn this the hard way.  Why do you ask?  ;-)

And that is why the recently removed CONFIG_RCU_FAST_NO_HZ left the
callbacks in place and substituted a 4x slower timer for the tick.
-That- actually resulted in significant real measured power savings on
real hardware.

Except that everything that was building with CONFIG_RCU_FAST_NO_HZ
was also doing nohz_full on each and every CPU.  Which meant that all
that CONFIG_RCU_FAST_NO_HZ was doing for them was adding an additional
useless check on each transition to and from idle.  Which in turn is why
CONFIG_RCU_FAST_NO_HZ was removed.  No one was using it in any way that
made any sense.

And more recent testing with rcu_nocbs on both ChromeOS and Android has
produced better savings than was produced by CONFIG_RCU_FAST_NO_HZ anyway.

Much of the additional savings from Joel et al.'s work is not so much
from reducing the number of ticks, but rather from reducing the number
of grace periods, which are of course much heavier weight.

And this of course means that any additional schemes to reduce RCU's
power consumption must be compared (with real measurements on real
hardware!) to Joel et al.'s work, whether in combination or as an
alternative.  And either way, the power savings must of course justify
the added code and complexity.

							Thanx, Paul

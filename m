Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207455EC8CD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiI0P7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiI0P7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:59:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30321272D;
        Tue, 27 Sep 2022 08:59:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A07D161A5E;
        Tue, 27 Sep 2022 15:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010CEC433C1;
        Tue, 27 Sep 2022 15:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664294383;
        bh=yKBA+mhcyl7el7HrbsJjrF+9PpXqNwzgQsopCdVv6YY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cRGiIfZGp38IjvdJTXJjrl28kSzQVipJiDp/Otr9+q2UUcNdWAhdTLw16go9G+E42
         hVHXmG2+LcXelKEA+WKjw0Q5RNQa2DPdClebJxVaYdEfiU/Ne0ihPR+lsf6MFD1uDj
         KIeOhJKyb7SZG0e4ZY45U2yz7ZicqHoDBqMMlsMLuSeehyy/7XfAiQIVno1nk1QwzK
         y9OyK3136CczGKGnk0M9dVpDNOEAMUZqH/Dn3bZDvWVM1VcQgWKOszAm8YKbMFe0gw
         PCIhk/ePgc7mt2MXJrZ9KFi61mDF0DwBkoIbdarHyVeoddpE5mV2z6Sd4zMXRbGiVd
         pSngXRXn30kOw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8F7135C0829; Tue, 27 Sep 2022 08:59:42 -0700 (PDT)
Date:   Tue, 27 Sep 2022 08:59:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <20220927155942.GL4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220926223222.GX4196@paulmck-ThinkPad-P17-Gen-1>
 <8344B0AB-608E-44DA-8FEE-3FE56EDF9172@joelfernandes.org>
 <20220926235944.GE4196@paulmck-ThinkPad-P17-Gen-1>
 <YzJWoRui7mUEDtox@google.com>
 <20220927032246.GH4196@paulmck-ThinkPad-P17-Gen-1>
 <YzL1JauFkeLEMgqV@google.com>
 <20220927141403.GJ4196@paulmck-ThinkPad-P17-Gen-1>
 <YzMHQPStqfm7ll/P@google.com>
 <20220927143020.GK4196@paulmck-ThinkPad-P17-Gen-1>
 <YzMVzpvvHbbkFMs8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzMVzpvvHbbkFMs8@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:25:02PM +0000, Joel Fernandes wrote:
> On Tue, Sep 27, 2022 at 07:30:20AM -0700, Paul E. McKenney wrote:
> > On Tue, Sep 27, 2022 at 02:22:56PM +0000, Joel Fernandes wrote:
> > > On Tue, Sep 27, 2022 at 07:14:03AM -0700, Paul E. McKenney wrote:
> > > > On Tue, Sep 27, 2022 at 01:05:41PM +0000, Joel Fernandes wrote:
> > > > > On Mon, Sep 26, 2022 at 08:22:46PM -0700, Paul E. McKenney wrote:
> > > > > [..]
> > > > > > > > > >>> --- a/kernel/workqueue.c
> > > > > > > > > >>> +++ b/kernel/workqueue.c
> > > > > > > > > >>> @@ -1771,7 +1771,7 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
> > > > > > > > > >>> 
> > > > > > > > > >>>        if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
> > > > > > > > > >>>                rwork->wq = wq;
> > > > > > > > > >>> -               call_rcu(&rwork->rcu, rcu_work_rcufn);
> > > > > > > > > >>> +               call_rcu_flush(&rwork->rcu, rcu_work_rcufn);
> > > > > > > > > >>>                return true;
> > > > > > > > > >>>        }
> > > > > > > > > >>> 
> > > > > > > > > >>> <snip>
> > > > > > > > > >>> 
> > > > > > > > > >>> ?
> > > > > > > > > >>> 
> > > > > > > > > >>> But it does not fully solve my boot-up issue. Will debug tomorrow further.
> > > > > > > > > >> 
> > > > > > > > > >> Ah, but at least its progress, thanks. Could you send me a patch to include
> > > > > > > > > >> in the next revision with details of this?
> > > > > > > > > >> 
> > > > > > > > > >>>> Might one more proactive approach be to use Coccinelle to locate such
> > > > > > > > > >>>> callback functions?  We might not want -all- callbacks that do wakeups
> > > > > > > > > >>>> to use call_rcu_flush(), but knowing which are which should speed up
> > > > > > > > > >>>> slow-boot debugging by quite a bit.
> > > > > > > > > >>>> 
> > > > > > > > > >>>> Or is there a better way to do this?
> > > > > > > > > >>>> 
> > > > > > > > > >>> I am not sure what Coccinelle is. If we had something automated that measures
> > > > > > > > > >>> a boot time and if needed does some profiling it would be good. Otherwise it
> > > > > > > > > >>> is a manual debugging mainly, IMHO.
> > > > > > > > > >> 
> > > > > > > > > >> Paul, What about using a default-off kernel CONFIG that splats on all lazy
> > > > > > > > > >> call_rcu() callbacks that do a wake up. We could use the trace hooks to do it
> > > > > > > > > >> in kernel I think. I can talk to Steve to get ideas on how to do that but I
> > > > > > > > > >> think it can be done purely from trace events (we might need a new
> > > > > > > > > >> trace_end_invoke_callback to fire after the callback is invoked). Thoughts?
> > > > > > > > > > 
> > > > > > > > > > Could you look for wakeups invoked between trace_rcu_batch_start() and
> > > > > > > > > > trace_rcu_batch_end() that are not from interrupt context?  This would
> > > > > > > > > > of course need to be associated with a task rather than a CPU.
> > > > > > > > > 
> > > > > > > > > Yes this sounds good, but we also need to know if the callbacks are
> > > > > > > > > lazy or not since wake-up is ok from a non lazy one. I think I’ll
> > > > > > > > > need a table to track that at queuing time.
> > > > > > > > 
> > > > > > > > Agreed.
> > > > > > > > 
> > > > > > > > > > Note that you would need to check for wakeups from interrupt handlers
> > > > > > > > > > even with the extra trace_end_invoke_callback().  The window where an
> > > > > > > > > > interrupt handler could do a wakeup would be reduced, but not eliminated.
> > > > > > > > > 
> > > > > > > > > True! Since this is a  debugging option, can we not just disable interrupts across callback invocation?
> > > > > > > > 
> > > > > > > > Not without terminally annoying lockdep, at least for any RCU callbacks
> > > > > > > > doing things like spin_lock_bh().
> > > > > > > > 
> > > > > > > 
> > > > > > > Sorry if my last email bounced. Looks like my iPhone betrayed me this once ;)
> > > > > > > 
> > > > > > > I was thinking something like this:
> > > > > > > 1. Put a flag in rcu_head to mark CBs as lazy.
> > > > > > > 2. Add a trace_rcu_invoke_callback_end() trace point.
> > > > > > > 
> > > > > > > Both #1 and #2 can be a debug CONFIG option. #2 can be a tracepoint and not
> > > > > > > exposed if needed.
> > > > > > > 
> > > > > > > 3. Put an in-kernel probe on both trace_rcu_invoke_callback_start() and
> > > > > > > trace_rcu_invoke_callback_end(). In the start probe, set a per-task flag if
> > > > > > > the current CB is lazy. In the end probe, clear it.
> > > > > > > 
> > > > > > > 4. Put an in-kernel probe on trace_rcu_sched_wakeup().
> > > > > > > 
> > > > > > > Splat in the wake up probe if:
> > > > > > > 1. Hard IRQs are on.
> > > > > > > 2. The per-cpu flag is set.
> > > > > > > 
> > > > > > > #3 actually does not even need probes if we can directly call the functions
> > > > > > > from the rcu_do_batch() function.
> > > > > > 
> > > > > > This is fine for an experiment or a debugging session, but a solution
> > > > > > based totally on instrumentation would be better for production use.
> > > > > 
> > > > > Maybe we can borrow the least-significant bit of rhp->func to mark laziness?
> > > > > Then it can be production as long as we're ok with the trace_sched_wakeup
> > > > > probe.
> > > > 
> > > > Last time I tried this, there were architectures that could have odd-valued
> > > > function addresses.  Maybe this is no longer the case?
> > > 
> > > Oh ok! If this happens, maybe we can just make it depend on x86-64 assuming
> > > x86-64 does not have pointer oddness. We can also add a warning for if the
> > > function address is odd before setting the bit.
> > 
> > Let me rephrase this...  ;-)
> > 
> > Given that this used to not work and still might not work, let's see
> > if we can find some other way to debug this.  Unless and until it can
> > be demonstrated that there is no supported compiler that will generated
> > odd-valued function addresses on any supported architecture.
> > 
> > Plus there was a time that x86 did odd-valued pointer addresses.
> > The instruction set is plenty fine with this, so it would have to be a
> > compiler and assembly-language convention to avoid it.
> 
> Ok, so then I am not sure how to make it work in production at the moment. I
> could track the lazy callbacks in a hashtable but then that's overhead.
> 
> Or, I could focus on trying Vlad's config and figure out what's going on and
> keep the auto-debug for later.

For one thing, experience with manual debugging might inform later
auto-debugging efforts.

> On another thought, this is the sort of thing that should be doable via Daniel
> Bristot's runtime verification framework, as its a classical "see if these
> traces look right" issue which should be teachable to a computer with a few rules.

Worth a shot!  Failing that, there is always BPF.  ;-)

								Thanx, Paul

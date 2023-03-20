Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC646C20C5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjCTTE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjCTTDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:03:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEC534324;
        Mon, 20 Mar 2023 11:56:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AE04B81065;
        Mon, 20 Mar 2023 18:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AF0C433D2;
        Mon, 20 Mar 2023 18:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679338560;
        bh=17eEbzVSRmRXrR+IelGWk/y511cPFSCkk4DC7cAGrRs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Eotv/rmZIbKlLp57Zlh1BwoRXpBGlECdZavmNwRGBIkQHf3YM2cTTYz8okXnsoItk
         0AMaAgjdwaeZ5DJTu76cX2V7VV9Lubr1VhJF0g+T1+iYthyW5ZhyrLKOOHRj3evbtd
         +wHLqhWyq1hXUVRADgRbVPGjg8Li65VZ6aLTOIb6ozL6+YgW0Twx+WOEN/MZJPmoHj
         XTAuNSZTPdFYqzrzKznvzp/beF1rP5qk2UxmOY2DsEsLLGqHxmyXViy1Mt4USN4RiJ
         5iQPy79Th1TxvILZgWcDGj/lF5cKMu0vUXdP9JNLNAUVWIwrvFh5LRkikaRngYKqfQ
         wheJU3+LWhUJQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6C3981540395; Mon, 20 Mar 2023 11:56:00 -0700 (PDT)
Date:   Mon, 20 Mar 2023 11:56:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, frederic@kernel.org,
        quic_neeraju@quicinc.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Remove RCU_NONIDLE()
Message-ID: <29095aff-02eb-41f3-8b00-3df378cd2b55@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230320173751.GU2194297@hirez.programming.kicks-ass.net>
 <ZBiacVlnbOLiKO3D@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBiacVlnbOLiKO3D@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 05:40:01PM +0000, Mark Rutland wrote:
> On Mon, Mar 20, 2023 at 06:37:51PM +0100, Peter Zijlstra wrote:
> > 
> > Since there are now exactly _zero_ users of RCU_NONIDLE(), make it go
> > away before someone else decides to (ab)use it.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thank you both!

Queued for v6.5, but it will hit -next much sooner than that.  ;-)


							Thanx, Paul

> Mark.
> 
> > ---
> >  .../RCU/Design/Requirements/Requirements.rst       | 36 +---------------------
> >  Documentation/RCU/whatisRCU.rst                    |  1 -
> >  include/linux/rcupdate.h                           | 25 ---------------
> >  3 files changed, 1 insertion(+), 61 deletions(-)
> > 
> > diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> > index 49387d823619..77155b51d4c2 100644
> > --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> > +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> > @@ -2071,41 +2071,7 @@ call.
> >  
> >  Because RCU avoids interrupting idle CPUs, it is illegal to execute an
> >  RCU read-side critical section on an idle CPU. (Kernels built with
> > -``CONFIG_PROVE_RCU=y`` will splat if you try it.) The RCU_NONIDLE()
> > -macro and ``_rcuidle`` event tracing is provided to work around this
> > -restriction. In addition, rcu_is_watching() may be used to test
> > -whether or not it is currently legal to run RCU read-side critical
> > -sections on this CPU. I learned of the need for diagnostics on the one
> > -hand and RCU_NONIDLE() on the other while inspecting idle-loop code.
> > -Steven Rostedt supplied ``_rcuidle`` event tracing, which is used quite
> > -heavily in the idle loop. However, there are some restrictions on the
> > -code placed within RCU_NONIDLE():
> > -
> > -#. Blocking is prohibited. In practice, this is not a serious
> > -   restriction given that idle tasks are prohibited from blocking to
> > -   begin with.
> > -#. Although nesting RCU_NONIDLE() is permitted, they cannot nest
> > -   indefinitely deeply. However, given that they can be nested on the
> > -   order of a million deep, even on 32-bit systems, this should not be a
> > -   serious restriction. This nesting limit would probably be reached
> > -   long after the compiler OOMed or the stack overflowed.
> > -#. Any code path that enters RCU_NONIDLE() must sequence out of that
> > -   same RCU_NONIDLE(). For example, the following is grossly
> > -   illegal:
> > -
> > -      ::
> > -
> > -	  1     RCU_NONIDLE({
> > -	  2       do_something();
> > -	  3       goto bad_idea;  /* BUG!!! */
> > -	  4       do_something_else();});
> > -	  5   bad_idea:
> > -
> > -
> > -   It is just as illegal to transfer control into the middle of
> > -   RCU_NONIDLE()'s argument. Yes, in theory, you could transfer in
> > -   as long as you also transferred out, but in practice you could also
> > -   expect to get sharply worded review comments.
> > +``CONFIG_PROVE_RCU=y`` will splat if you try it.) 
> >  
> >  It is similarly socially unacceptable to interrupt an ``nohz_full`` CPU
> >  running in userspace. RCU must therefore track ``nohz_full`` userspace
> > diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> > index 2c5563a91998..c3b1cbfa1530 100644
> > --- a/Documentation/RCU/whatisRCU.rst
> > +++ b/Documentation/RCU/whatisRCU.rst
> > @@ -1117,7 +1117,6 @@ in docbook.  Here is the list, by category.
> >  
> >  	RCU_LOCKDEP_WARN
> >  	rcu_sleep_check
> > -	RCU_NONIDLE
> >  
> >  All: Unchecked RCU-protected pointer access::
> >  
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 094321c17e48..ddd42efc6224 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -156,31 +156,6 @@ static inline int rcu_nocb_cpu_deoffload(int cpu) { return 0; }
> >  static inline void rcu_nocb_flush_deferred_wakeup(void) { }
> >  #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
> >  
> > -/**
> > - * RCU_NONIDLE - Indicate idle-loop code that needs RCU readers
> > - * @a: Code that RCU needs to pay attention to.
> > - *
> > - * RCU read-side critical sections are forbidden in the inner idle loop,
> > - * that is, between the ct_idle_enter() and the ct_idle_exit() -- RCU
> > - * will happily ignore any such read-side critical sections.  However,
> > - * things like powertop need tracepoints in the inner idle loop.
> > - *
> > - * This macro provides the way out:  RCU_NONIDLE(do_something_with_RCU())
> > - * will tell RCU that it needs to pay attention, invoke its argument
> > - * (in this example, calling the do_something_with_RCU() function),
> > - * and then tell RCU to go back to ignoring this CPU.  It is permissible
> > - * to nest RCU_NONIDLE() wrappers, but not indefinitely (but the limit is
> > - * on the order of a million or so, even on 32-bit systems).  It is
> > - * not legal to block within RCU_NONIDLE(), nor is it permissible to
> > - * transfer control either into or out of RCU_NONIDLE()'s statement.
> > - */
> > -#define RCU_NONIDLE(a) \
> > -	do { \
> > -		ct_irq_enter_irqson(); \
> > -		do { a; } while (0); \
> > -		ct_irq_exit_irqson(); \
> > -	} while (0)
> > -
> >  /*
> >   * Note a quasi-voluntary context switch for RCU-tasks's benefit.
> >   * This is a macro rather than an inline function to avoid #include hell.

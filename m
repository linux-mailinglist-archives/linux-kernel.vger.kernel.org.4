Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1B56C1E64
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCTRoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCTRoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:44:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 363241D921;
        Mon, 20 Mar 2023 10:40:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2C8EFEC;
        Mon, 20 Mar 2023 10:40:57 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BB4A3F67D;
        Mon, 20 Mar 2023 10:40:12 -0700 (PDT)
Date:   Mon, 20 Mar 2023 17:40:01 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Paul McKenney <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Remove RCU_NONIDLE()
Message-ID: <ZBiacVlnbOLiKO3D@FVFF77S0Q05N.cambridge.arm.com>
References: <20230320173751.GU2194297@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320173751.GU2194297@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 06:37:51PM +0100, Peter Zijlstra wrote:
> 
> Since there are now exactly _zero_ users of RCU_NONIDLE(), make it go
> away before someone else decides to (ab)use it.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  .../RCU/Design/Requirements/Requirements.rst       | 36 +---------------------
>  Documentation/RCU/whatisRCU.rst                    |  1 -
>  include/linux/rcupdate.h                           | 25 ---------------
>  3 files changed, 1 insertion(+), 61 deletions(-)
> 
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> index 49387d823619..77155b51d4c2 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -2071,41 +2071,7 @@ call.
>  
>  Because RCU avoids interrupting idle CPUs, it is illegal to execute an
>  RCU read-side critical section on an idle CPU. (Kernels built with
> -``CONFIG_PROVE_RCU=y`` will splat if you try it.) The RCU_NONIDLE()
> -macro and ``_rcuidle`` event tracing is provided to work around this
> -restriction. In addition, rcu_is_watching() may be used to test
> -whether or not it is currently legal to run RCU read-side critical
> -sections on this CPU. I learned of the need for diagnostics on the one
> -hand and RCU_NONIDLE() on the other while inspecting idle-loop code.
> -Steven Rostedt supplied ``_rcuidle`` event tracing, which is used quite
> -heavily in the idle loop. However, there are some restrictions on the
> -code placed within RCU_NONIDLE():
> -
> -#. Blocking is prohibited. In practice, this is not a serious
> -   restriction given that idle tasks are prohibited from blocking to
> -   begin with.
> -#. Although nesting RCU_NONIDLE() is permitted, they cannot nest
> -   indefinitely deeply. However, given that they can be nested on the
> -   order of a million deep, even on 32-bit systems, this should not be a
> -   serious restriction. This nesting limit would probably be reached
> -   long after the compiler OOMed or the stack overflowed.
> -#. Any code path that enters RCU_NONIDLE() must sequence out of that
> -   same RCU_NONIDLE(). For example, the following is grossly
> -   illegal:
> -
> -      ::
> -
> -	  1     RCU_NONIDLE({
> -	  2       do_something();
> -	  3       goto bad_idea;  /* BUG!!! */
> -	  4       do_something_else();});
> -	  5   bad_idea:
> -
> -
> -   It is just as illegal to transfer control into the middle of
> -   RCU_NONIDLE()'s argument. Yes, in theory, you could transfer in
> -   as long as you also transferred out, but in practice you could also
> -   expect to get sharply worded review comments.
> +``CONFIG_PROVE_RCU=y`` will splat if you try it.) 
>  
>  It is similarly socially unacceptable to interrupt an ``nohz_full`` CPU
>  running in userspace. RCU must therefore track ``nohz_full`` userspace
> diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> index 2c5563a91998..c3b1cbfa1530 100644
> --- a/Documentation/RCU/whatisRCU.rst
> +++ b/Documentation/RCU/whatisRCU.rst
> @@ -1117,7 +1117,6 @@ in docbook.  Here is the list, by category.
>  
>  	RCU_LOCKDEP_WARN
>  	rcu_sleep_check
> -	RCU_NONIDLE
>  
>  All: Unchecked RCU-protected pointer access::
>  
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 094321c17e48..ddd42efc6224 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -156,31 +156,6 @@ static inline int rcu_nocb_cpu_deoffload(int cpu) { return 0; }
>  static inline void rcu_nocb_flush_deferred_wakeup(void) { }
>  #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
>  
> -/**
> - * RCU_NONIDLE - Indicate idle-loop code that needs RCU readers
> - * @a: Code that RCU needs to pay attention to.
> - *
> - * RCU read-side critical sections are forbidden in the inner idle loop,
> - * that is, between the ct_idle_enter() and the ct_idle_exit() -- RCU
> - * will happily ignore any such read-side critical sections.  However,
> - * things like powertop need tracepoints in the inner idle loop.
> - *
> - * This macro provides the way out:  RCU_NONIDLE(do_something_with_RCU())
> - * will tell RCU that it needs to pay attention, invoke its argument
> - * (in this example, calling the do_something_with_RCU() function),
> - * and then tell RCU to go back to ignoring this CPU.  It is permissible
> - * to nest RCU_NONIDLE() wrappers, but not indefinitely (but the limit is
> - * on the order of a million or so, even on 32-bit systems).  It is
> - * not legal to block within RCU_NONIDLE(), nor is it permissible to
> - * transfer control either into or out of RCU_NONIDLE()'s statement.
> - */
> -#define RCU_NONIDLE(a) \
> -	do { \
> -		ct_irq_enter_irqson(); \
> -		do { a; } while (0); \
> -		ct_irq_exit_irqson(); \
> -	} while (0)
> -
>  /*
>   * Note a quasi-voluntary context switch for RCU-tasks's benefit.
>   * This is a macro rather than an inline function to avoid #include hell.

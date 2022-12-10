Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8C564900E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 18:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLJRr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 12:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiLJRr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 12:47:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E11634C
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 09:47:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF519B80884
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 17:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4F9C433D2;
        Sat, 10 Dec 2022 17:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670694473;
        bh=eGEHQ/VAOok5w7QGZwJySepr/dzmtnSDc+W5FmrQevg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fQfI5OsuPa7u19qb3TYtkYtgfula+Ktq0+C+CP1fOfg3NCaCcfcesikGTVcsZQQPu
         B1mT48cIlRnQi59LltjG/3ibHsC1v9Beszv5Bad+t47i7Vd8onIuJUoPJ7Caxls6jq
         ck8Pun446A/bK/e6ZUs5OIio4JQ64+KXD0rGdPctvpKU0ExFYOkdJ+16icuxIjrQvY
         8g4qDbxmI7+gwxEWYhbVmXb9L208G70RyNLejGRXrpBSDKUmcrXab9a7nqEKeY/Sab
         BrusZjtj4RHOnK9dGchGE4+FJv/cCpTSdjQ4REqMUWFE2jva9dQIM2L4yl6a+hWGZD
         g/uRln229tl4A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2FD795C05C0; Sat, 10 Dec 2022 09:47:53 -0800 (PST)
Date:   Sat, 10 Dec 2022 09:47:53 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [for-next][PATCH 13/25] x86/mm/kmmio: Use
 rcu_read_lock_sched_notrace()
Message-ID: <20221210174753.GD4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221210135750.425719934@goodmis.org>
 <20221210135825.241167123@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221210135825.241167123@goodmis.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2022 at 08:58:03AM -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The mmiotrace tracer is "special". The purpose is to help reverse engineer
> binary drivers by removing the memory allocated by the driver and when the
> driver goes to access it, a fault occurs, the mmiotracer will record what
> the driver was doing and then do the work on its behalf by single stepping
> through the process.
> 
> But to achieve this ability, it must do some special things. One is to
> take the rcu_read_lock() when the fault occurs, and then release it in the
> breakpoint that is single stepping. This makes lockdep unhappy, as it
> changes the state of RCU from within an exception that is not contained in
> that exception, and we get a nasty splat from lockdep.
> 
> Instead, switch to rcu_read_lock_sched_notrace() as the RCU sched variant
> has the same grace period as normal RCU. This is basically the same as
> rcu_read_lock() but does not make lockdep complain about it.
> 
> Note, the preempt_disable() is still needed as it uses preempt_enable_no_resched().
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20221209134144.04f33626@gandalf.local.home
> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Karol Herbst <karolherbst@gmail.com>
> Cc: Pekka Paalanen <ppaalanen@gmail.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Executable code can be the best form of comment.  ;-)

This does mess with preempt_count() redundantly, but the overhead from
that should be way down in the noise.

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  arch/x86/mm/kmmio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/mm/kmmio.c b/arch/x86/mm/kmmio.c
> index edb486450158..853c49877c16 100644
> --- a/arch/x86/mm/kmmio.c
> +++ b/arch/x86/mm/kmmio.c
> @@ -254,7 +254,7 @@ int kmmio_handler(struct pt_regs *regs, unsigned long addr)
>  	 * again.
>  	 */
>  	preempt_disable();
> -	rcu_read_lock();
> +	rcu_read_lock_sched_notrace();
>  
>  	faultpage = get_kmmio_fault_page(page_base);
>  	if (!faultpage) {
> @@ -323,7 +323,7 @@ int kmmio_handler(struct pt_regs *regs, unsigned long addr)
>  	return 1; /* fault handled */
>  
>  no_kmmio:
> -	rcu_read_unlock();
> +	rcu_read_unlock_sched_notrace();
>  	preempt_enable_no_resched();
>  	return ret;
>  }
> @@ -363,7 +363,7 @@ static int post_kmmio_handler(unsigned long condition, struct pt_regs *regs)
>  	/* These were acquired in kmmio_handler(). */
>  	ctx->active--;
>  	BUG_ON(ctx->active);
> -	rcu_read_unlock();
> +	rcu_read_unlock_sched_notrace();
>  	preempt_enable_no_resched();
>  
>  	/*
> -- 
> 2.35.1
> 
> 

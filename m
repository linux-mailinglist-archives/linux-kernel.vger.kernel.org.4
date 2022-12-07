Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40CE646051
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiLGRg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLGRgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:36:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173565B862;
        Wed,  7 Dec 2022 09:36:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2F7961B7F;
        Wed,  7 Dec 2022 17:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B8BC433C1;
        Wed,  7 Dec 2022 17:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670434582;
        bh=59zA4/AaIIK3K2fxEdDUzEgmFLigV6Fq1Sp+QlfZskc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=F76qL7uFYLbtkgV6a5GxwhUguopJT0WuOAVl3K+fKDIAtvdCnBLl4GSn6O1C6mEck
         zYlXtg7KCDGi9DEAh0ai76lQcQZ5AXAdQtMjCQ1YTuVcJDuJf/mi7oMMGRLXdNmVcN
         sOPhdGT0yftmqfidjv+sJxDtXm168fivn6yqwZ0ZHkocpLv9tP6BQtqhfNRdZ/QemZ
         CibXmUFj1+l7+hiC8T0eJNBV6UpVX27OUvhpv/dpx0QoLLUJaZE+6NHEJNf3sCXaBN
         ilr5foful0qeXaeP1swsq+MP7q0AIP5q5kFqNdLNFgNxdTLHuTDzF/OvFPZsMdelHZ
         9kcDMVd0meuyw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7AE9C5C0AFC; Wed,  7 Dec 2022 09:36:21 -0800 (PST)
Date:   Wed, 7 Dec 2022 09:36:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Re: [PATCH 2/2] x86/mm/kmmio: Remove rcu_read_lock()
Message-ID: <20221207173621.GF4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221206191201.217838841@goodmis.org>
 <20221206191229.813199661@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206191229.813199661@goodmis.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 02:12:03PM -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The mmiotrace tracer is "special". The purpose is to help reverse engineer
> binary drivers by removing the memory allocated by the driver and when the
> driver goes to access it, a fault occurs, the mmiotracer will record what
> the driver was doing and then do the work on its behalf by single stepping
> through the process.
> 
> But to achieve this ability, it must do some special things. One is it
> take the rcu_read_lock() when the fault occurs, and then release it in the
> breakpoint that in the single stepping. This makes lockdep unhappy, as it
> changes the state of RCU from within an exception that is not contained in
> that exception, and we get a nasty splat from lockdep.
> 
> As it also disables preemption everywhere rcu_read_lock() is taken, and
> enables preemption everywhere rcu_read_unlock(), and does not enable
> preemption in between, it is the same as synchronize_rcu_sched(). But as
> the RCU sched variant has the same grace period as normal RCU, there's no
> reason to take the rcu_read_lock(). Simply remove it.
> 
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Might be worth adding a comment saying that others are using this
preempt_disable() to block an RCU grace period, but that is up to
you guys.  I will let you and your future selves be the judges.

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  arch/x86/mm/kmmio.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/x86/mm/kmmio.c b/arch/x86/mm/kmmio.c
> index edb486450158..e15e3aaaf94c 100644
> --- a/arch/x86/mm/kmmio.c
> +++ b/arch/x86/mm/kmmio.c
> @@ -254,7 +254,6 @@ int kmmio_handler(struct pt_regs *regs, unsigned long addr)
>  	 * again.
>  	 */
>  	preempt_disable();
> -	rcu_read_lock();
>  
>  	faultpage = get_kmmio_fault_page(page_base);
>  	if (!faultpage) {
> @@ -323,7 +322,6 @@ int kmmio_handler(struct pt_regs *regs, unsigned long addr)
>  	return 1; /* fault handled */
>  
>  no_kmmio:
> -	rcu_read_unlock();
>  	preempt_enable_no_resched();
>  	return ret;
>  }
> @@ -363,7 +361,6 @@ static int post_kmmio_handler(unsigned long condition, struct pt_regs *regs)
>  	/* These were acquired in kmmio_handler(). */
>  	ctx->active--;
>  	BUG_ON(ctx->active);
> -	rcu_read_unlock();
>  	preempt_enable_no_resched();
>  
>  	/*
> -- 
> 2.35.1
> 
> 

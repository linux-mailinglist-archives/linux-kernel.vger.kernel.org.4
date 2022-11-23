Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AABC634BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbiKWAXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiKWAXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:23:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4970786D4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 16:23:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAAFA61988
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31464C433D7;
        Wed, 23 Nov 2022 00:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669162979;
        bh=D+mZBOiCIC7JPWUavVmxGooy+V+EK3/V7Vh+09epscc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JdNjxC5mY4MD9P032W9yu2lo40UVR2OVMEhTplsSwnsXdG+UUcgud4L09vH9DUrff
         nMZshVfsk/54bfE53/ZDMJAUIS41mOMZ+1w9aA2ZdD4R/iguYnJsK+YRRMDeVh0aTT
         dHjjA+qkTuI/C1+dxlCMfiEk65oQeYJTi+bqSzy521ISeg/xmyPVCeUcAeFkr2F3Y/
         FVQMa0CQcZY7WDGTzqB+GQ+sHhgC+LR4ECMqLygV4FioY9nLCkoYYHTa6Tcd8vuOSs
         iD485jSLECHx9n6Y6D2hYZDOlIYbkrmmb9w6e7iaDoESb5IA1pkI75Yj2KKBCNnaex
         AZNzBYyQi2iNA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B5D165C0BE7; Tue, 22 Nov 2022 16:22:58 -0800 (PST)
Date:   Tue, 22 Nov 2022 16:22:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: objtool warning for next-20221118
Message-ID: <20221123002258.GR4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221121040736.GA3738360@paulmck-ThinkPad-P17-Gen-1>
 <Y3thrQxfcvZSXFlr@hirez.programming.kicks-ass.net>
 <20221121145215.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <20221122051605.4hcbslwxez2trdvt@treble>
 <Y3yJxQJ9DwxTx7km@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3yJxQJ9DwxTx7km@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 09:35:17AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 21, 2022 at 09:16:05PM -0800, Josh Poimboeuf wrote:
> 
> > It's complaining about an unreachable instruction after a call to
> > arch_cpu_idle_dead().  In this case objtool detects the fact
> > arch_cpu_idle_dead() doesn't return due to its call to the
> > non-CONFIG_SMP version of play_dead().  But GCC has no way of detecting
> > that because the caller is in another translation unit.
> > 
> > As far as I can tell, that function should never return.  Though it
> > seems to have some dubious semantics (see xen_pv_play_dead() for
> > example, which *does* seem to return?).  I'm thinking it would be an
> > improvement to enforce that noreturn behavior across all arches and
> > platforms, sprinkling __noreturn and BUG() on arch_cpu_idle_dead() and
> > maybe some of it callees, where needed.
> > 
> > Peter, what do you think?  I could attempt a patch.
> 
> I'm thinking the Xen case makes all this really rather difficult :/
> 
> While normally a CPU is brought up through a trampoline, Xen seems to
> have implemented it by simply returning from play_dead(), and afaict
> that is actually a valid way to go about doing it.
> 
> Perhaps the best way would be to stick a REACHABLE annotation in
> arch_cpu_idle_dead() or something?

When I apply this on -next, I still get the objtool complaint.
Is there something else I should also be doing?

							Thanx, Paul

> ---
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index c21b7347a26d..0354be027eb0 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -712,6 +712,7 @@ void arch_cpu_idle_enter(void)
>  void arch_cpu_idle_dead(void)
>  {
>  	play_dead();
> +	asm(ASM_REACHABLE);
>  }
>  
>  /*

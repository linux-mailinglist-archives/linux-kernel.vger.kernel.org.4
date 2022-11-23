Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA416367A2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbiKWRuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbiKWRt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:49:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11828BE266
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:49:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66568B82202
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33F8C433D7;
        Wed, 23 Nov 2022 17:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669225792;
        bh=/kQvzs/iNALbr97SgLe2N6KrPnAAyGsng1wmG/TRpZc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=opAP4xpb5RlZOwyZXqhCmFKlZ/Pi5vzRg4Xpnu9xb+5Sv/fC9LKIQAfCeN1Y7EoRr
         qua5iso2FxuU8a0eo79L13todz2MxO2IZmB1VOz8c+SDQls5PerD2HdchfHuNLHIFA
         LEd1Urf+1+Lkg5dEzDPP2q3y3pg0Qh8HAc6mfyWACgIOO67Ob2fNJE8SSSPPrCOguJ
         rc98xrXWGICOF7fQR1YTifTgIHYKDAnI5kBF5GjPCErd+jIh/UTk3qvBzDT7GOPxmn
         N2xyv/kUyiS3xBJXTy5tAVA5ZeHRwsgyow/M8SPTLrDSLt9xsgs+NLUry/yy7Gr+Dt
         rLIvwivECoUfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8FCA35C0A3F; Wed, 23 Nov 2022 09:49:51 -0800 (PST)
Date:   Wed, 23 Nov 2022 09:49:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: objtool warning for next-20221118
Message-ID: <20221123174951.GZ4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221121040736.GA3738360@paulmck-ThinkPad-P17-Gen-1>
 <Y3thrQxfcvZSXFlr@hirez.programming.kicks-ass.net>
 <20221121145215.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <20221122051605.4hcbslwxez2trdvt@treble>
 <Y3yJxQJ9DwxTx7km@hirez.programming.kicks-ass.net>
 <20221123002258.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <20221123014812.7gptbvvndzemt5nc@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123014812.7gptbvvndzemt5nc@treble>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 05:48:12PM -0800, Josh Poimboeuf wrote:
> On Tue, Nov 22, 2022 at 04:22:58PM -0800, Paul E. McKenney wrote:
> > On Tue, Nov 22, 2022 at 09:35:17AM +0100, Peter Zijlstra wrote:
> > > On Mon, Nov 21, 2022 at 09:16:05PM -0800, Josh Poimboeuf wrote:
> > > 
> > > > It's complaining about an unreachable instruction after a call to
> > > > arch_cpu_idle_dead().  In this case objtool detects the fact
> > > > arch_cpu_idle_dead() doesn't return due to its call to the
> > > > non-CONFIG_SMP version of play_dead().  But GCC has no way of detecting
> > > > that because the caller is in another translation unit.
> > > > 
> > > > As far as I can tell, that function should never return.  Though it
> > > > seems to have some dubious semantics (see xen_pv_play_dead() for
> > > > example, which *does* seem to return?).  I'm thinking it would be an
> > > > improvement to enforce that noreturn behavior across all arches and
> > > > platforms, sprinkling __noreturn and BUG() on arch_cpu_idle_dead() and
> > > > maybe some of it callees, where needed.
> > > > 
> > > > Peter, what do you think?  I could attempt a patch.
> > > 
> > > I'm thinking the Xen case makes all this really rather difficult :/
> > > 
> > > While normally a CPU is brought up through a trampoline, Xen seems to
> > > have implemented it by simply returning from play_dead(), and afaict
> > > that is actually a valid way to go about doing it.
> > > 
> > > Perhaps the best way would be to stick a REACHABLE annotation in
> > > arch_cpu_idle_dead() or something?
> > 
> > When I apply this on -next, I still get the objtool complaint.
> > Is there something else I should also be doing?
> 
> Silly GCC is folding the inline asm.  This works (but still doesn't seem
> like the right approach):
> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 26e8f57c75ad..128e7d78fedf 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -702,7 +702,7 @@ static void (*x86_idle)(void);
>  #ifndef CONFIG_SMP
>  static inline void play_dead(void)
>  {
> -	BUG();
> +	_BUG_FLAGS(ASM_UD2, 0, ASM_REACHABLE);
>  }
>  #endif

I tried this, and still get:

vmlinux.o: warning: objtool: do_idle+0x156: unreachable instruction

Maybe my gcc is haunted?

							Thanx, Paul

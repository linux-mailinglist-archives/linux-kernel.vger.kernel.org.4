Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0739636891
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbiKWSTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238816AbiKWSTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:19:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3C310FA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 10:19:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96D59B82215
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 18:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3436CC433D6;
        Wed, 23 Nov 2022 18:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669227583;
        bh=HfKCxUf/kEaMg1EqZNQeaiJch/1K7iIS4r+c9bp1iXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aXnqfmRmmoF2y8Y1euD9uZ4PKDjWXASOgjU+dk3A/cuMWxMZ13O9gqwOS1nHGz9Ft
         SEgs2U7Gqgl03gHDZCje0dcXSSYjvn8rtDY/28mbUuth/2QzpOfbwnkY+swPBmF0tM
         Asi4/8pl/WmN9zQGpjeRLRJ/Hv09x7/Nrlg+W4REyiOXBug0OfaePFJJb/uS5f4107
         C4uZB3oOW+VT2hFcAJG+E1byGg9KCm8lvOnBWLrCm55xClT7xRKmBSHWBvbAZh1f7J
         XQ50nDMhYUPZ9YcbmKCzhItf77Bt5OoYLCnnkgTeTJlSRU1enURNik03xJ1rerX2oo
         6PxVzrZIn3WVg==
Date:   Wed, 23 Nov 2022 10:19:41 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: objtool warning for next-20221118
Message-ID: <20221123181941.fh4hrr3pazelwtxc@treble>
References: <20221121040736.GA3738360@paulmck-ThinkPad-P17-Gen-1>
 <Y3thrQxfcvZSXFlr@hirez.programming.kicks-ass.net>
 <20221121145215.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <20221122051605.4hcbslwxez2trdvt@treble>
 <Y3yJxQJ9DwxTx7km@hirez.programming.kicks-ass.net>
 <20221123002258.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <20221123014812.7gptbvvndzemt5nc@treble>
 <20221123174951.GZ4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221123174951.GZ4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 09:49:51AM -0800, Paul E. McKenney wrote:
> > > > Perhaps the best way would be to stick a REACHABLE annotation in
> > > > arch_cpu_idle_dead() or something?
> > > 
> > > When I apply this on -next, I still get the objtool complaint.
> > > Is there something else I should also be doing?
> > 
> > Silly GCC is folding the inline asm.  This works (but still doesn't seem
> > like the right approach):
> > 
> > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > index 26e8f57c75ad..128e7d78fedf 100644
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -702,7 +702,7 @@ static void (*x86_idle)(void);
> >  #ifndef CONFIG_SMP
> >  static inline void play_dead(void)
> >  {
> > -	BUG();
> > +	_BUG_FLAGS(ASM_UD2, 0, ASM_REACHABLE);
> >  }
> >  #endif
> 
> I tried this, and still get:
> 
> vmlinux.o: warning: objtool: do_idle+0x156: unreachable instruction
> 
> Maybe my gcc is haunted?

Weird, it worked for me.  I have

  gcc version 12.2.1 20220819 (Red Hat 12.2.1-2) (GCC)

and I can't really fathom why that wouldn't work.  Maybe it's a
different issue?  The "unreachable instruction" warning is limited to
one, so when a first warning gets fixed, a second warning might suddenly
become visible.

Can you attach arch/x86/kernel/process.o?

-- 
Josh

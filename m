Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF78663463
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237271AbjAIWxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbjAIWxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:53:15 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBAD9140F5
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 14:53:14 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 330CD92009D; Mon,  9 Jan 2023 23:53:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 2FB4B92009C;
        Mon,  9 Jan 2023 22:53:12 +0000 (GMT)
Date:   Mon, 9 Jan 2023 22:53:12 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ingo Molnar <mingo@kernel.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Disable kernel stack offset randomization for
 !TSC
In-Reply-To: <Y7vvKHYXpe7KmwCI@gmail.com>
Message-ID: <alpine.DEB.2.21.2301091946360.65308@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301082113350.65308@angie.orcam.me.uk> <Y7vvKHYXpe7KmwCI@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason,

 Would you mind commenting on the below?

On Mon, 9 Jan 2023, Ingo Molnar wrote:

> > For x86 kernel stack offset randomization uses the RDTSC instruction, 
> > which causes an invalid opcode exception with hardware that does not 
> > implement this instruction:
> 
> > @@ -85,7 +86,8 @@ static inline void arch_exit_to_user_mod
> >  	 * Therefore, final stack offset entropy will be 5 (x86_64) or
> >  	 * 6 (ia32) bits.
> >  	 */
> > -	choose_random_kstack_offset(rdtsc() & 0xFF);
> > +	if (cpu_feature_enabled(X86_FEATURE_TSC))
> > +		choose_random_kstack_offset(rdtsc() & 0xFF);
> >  }
> 
> While this is an obscure corner case, falling back to 0 offset silently 
> feels a bit wrong - could we at least attempt to generate some 
> unpredictability in this case?
> 
> It's not genuine entropy, but we could pass in a value that varies from 
> task to task and which is not an 'obviously known' constant value like the 
> 0 fallback?
> 
> For example the lowest 8 bits of the virtual page number of the current 
> task plus the lowest 8 bits of jiffies should vary from task to task, has 
> some time dependence and is cheap to compute:
> 
> 	(((unsigned long)current >> 12) + jiffies) & 0xFF
> 
> This combined with the per-CPU forward storage of previous offsets:
> 
> #define choose_random_kstack_offset(rand) do {                          \
>         if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
>                                 &randomize_kstack_offset)) {            \
>                 u32 offset = raw_cpu_read(kstack_offset);               \
>                 offset ^= (rand);                                       \
>                 raw_cpu_write(kstack_offset, offset);                   \
>         }                                                               \
> 
> Should make this reasonably hard to guess for long-running tasks even if 
> there's no TSC - and make it hard to guess even for tasks whose creation an 
> attacker controls, unless there's an info-leak to rely on.

 Sure, I'm fine implementing it, even in such a way so as not to cause a 
code size/performance regression for X86_TSC configurations.  But is the 
calculation really unpredictable enough?  I don't feel competent enough to 
decide.  Jason, what do you think?

  Maciej

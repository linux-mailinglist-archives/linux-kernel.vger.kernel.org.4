Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F07666875
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 02:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbjALBee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 20:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjALBec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 20:34:32 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D6B927186
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:34:31 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id ECDB692009C; Thu, 12 Jan 2023 02:34:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id E5A1E92009B;
        Thu, 12 Jan 2023 01:34:29 +0000 (GMT)
Date:   Thu, 12 Jan 2023 01:34:29 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Disable kernel stack offset randomization for
 !TSC
In-Reply-To: <Y72CByxvewQv78YH@zx2c4.com>
Message-ID: <alpine.DEB.2.21.2301120129020.65308@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301082113350.65308@angie.orcam.me.uk> <Y72CByxvewQv78YH@zx2c4.com>
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

On Tue, 10 Jan 2023, Jason A. Donenfeld wrote:

> > Index: linux-macro/arch/x86/include/asm/entry-common.h
> > ===================================================================
> > --- linux-macro.orig/arch/x86/include/asm/entry-common.h
> > +++ linux-macro/arch/x86/include/asm/entry-common.h
> > @@ -5,6 +5,7 @@
> >  #include <linux/randomize_kstack.h>
> >  #include <linux/user-return-notifier.h>
> >  
> > +#include <asm/cpufeature.h>
> >  #include <asm/nospec-branch.h>
> >  #include <asm/io_bitmap.h>
> >  #include <asm/fpu/api.h>
> > @@ -85,7 +86,8 @@ static inline void arch_exit_to_user_mod
> >  	 * Therefore, final stack offset entropy will be 5 (x86_64) or
> >  	 * 6 (ia32) bits.
> >  	 */
> > -	choose_random_kstack_offset(rdtsc() & 0xFF);
> > +	if (cpu_feature_enabled(X86_FEATURE_TSC))
> > +		choose_random_kstack_offset(rdtsc() & 0xFF);
> 
> What would happen if you just called `get_random_u8()` here?

 Thank you for your input.  I've had a look at the function and it seems a 
bit heavyweight compared to a mere single CPU instruction, but I guess why 
not.  Do you have any performance figures (in terms of CPU cycles) for the 
usual cases?  Offhand I'm not sure how I could benchmark it myself.

 I have made a patch and of course it makes the system boot too, although 
it's not clear to me how I can actually verify randomisation works.  I can 
assume it does I suppose.

  Maciej

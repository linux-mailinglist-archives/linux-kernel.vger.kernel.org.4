Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE585639CBB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiK0UST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiK0USS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:18:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2CB2DD2;
        Sun, 27 Nov 2022 12:18:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D332EB80AC2;
        Sun, 27 Nov 2022 20:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115BFC433C1;
        Sun, 27 Nov 2022 20:18:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ctC5PFp7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669580290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Y3CBMuPS7LaIxQ72QWojthFee5sMI0jlRfrPvp9oDc=;
        b=ctC5PFp74Lbo172SyBzejQP2DBuiADzFpnJVpc1S+AizO0l4hyc5HqdAIGDX9Opv90ixyq
        49JHP982vikll1vRoxCUz/+tCTyJswAYuT6Qbuh3m4EH927rcNYPfUD2DGRVy4jdFu7kMV
        TAKU3FLoGxYFkdWht5K4cVZpukbc+Wo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 68cd4782 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 27 Nov 2022 20:18:09 +0000 (UTC)
Date:   Sun, 27 Nov 2022 21:18:02 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v7 1/3] random: add vgetrandom_alloc() syscall
Message-ID: <Y4PF+pBlNZGfZ0sr@zx2c4.com>
References: <20221124165536.1631325-1-Jason@zx2c4.com>
 <20221124165536.1631325-2-Jason@zx2c4.com>
 <87bkouyd90.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bkouyd90.ffs@tglx>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thanks a lot for the thorough review, here, and in the other two emails.
I appreciate you taking the time to look at it, and my apologies for
parts that are unclear or sloppy or otherwise unpolished. I'll try to
make v8 a lot better.

Comments inline below:

On Fri, Nov 25, 2022 at 09:45:31PM +0100, Thomas Gleixner wrote:
> On Thu, Nov 24 2022 at 17:55, Jason A. Donenfeld wrote:
> > ---
> >  MAINTAINERS                             |  1 +
> >  arch/x86/Kconfig                        |  1 +
> >  arch/x86/entry/syscalls/syscall_64.tbl  |  1 +
> >  arch/x86/include/asm/unistd.h           |  1 +
> >  drivers/char/random.c                   | 59 +++++++++++++++++++++++++
> >  include/uapi/asm-generic/unistd.h       |  7 ++-
> >  kernel/sys_ni.c                         |  3 ++
> >  lib/vdso/getrandom.h                    | 23 ++++++++++
> >  scripts/checksyscalls.sh                |  4 ++
> >  tools/include/uapi/asm-generic/unistd.h |  7 ++-
> >  10 files changed, 105 insertions(+), 2 deletions(-)
> >  create mode 100644 lib/vdso/getrandom.h
> 
> I think I asked for this before:
> 
> Please split these things properly up. Provide the syscall and then wire
> it up.

Before I split it into "syscall, generic vdso, x86 vdso", as that's how
I interpreted your email. Next, I'll split it up into "generic syscall,
generic vdso, x86 vdso & syscall", since enabling the syscall without
the vdso function, or vice-versa, doesn't make sense, and having that
last step be all at once there will provide an easy thing for other
archs to look at.

> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 67745ceab0db..331e21ba961a 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -59,6 +59,7 @@ config X86
> >  	#
> >  	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
> >  	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
> > +	select ADVISE_SYSCALLS			if X86_64
> 
> Why is this x86_64 specific?
> 
> > --- a/arch/x86/include/asm/unistd.h
> > +++ b/arch/x86/include/asm/unistd.h
> > @@ -27,6 +27,7 @@
> >  #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64
> >  #  define __ARCH_WANT_COMPAT_SYS_PREADV64V2
> >  #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64V2
> > +#  define __ARCH_WANT_VGETRANDOM_ALLOC
> 
> So instead of this define, why can't you do:
> 
> config VGETRADOM_ALLOC
>        bool
>        select ADVISE_SYSCALLS
> 
> and then have
> 
> config GENERIC_VDSO_RANDOM_WHATEVER
>        bool
>        select VGETRANDOM_ALLOC
> 
> This gives a clear Kconfig dependency instead of the random
> ADVISE_SYSCALLS select.

That's much better indeed. I was trying to straddle the two conventions
of `#define __ARCH_...` for syscalls and a Kconfig for vDSO functions,
but doing it all together as you've suggested is nicer.

I'll try to figure this out, though so far futzing around suggests there
might have to be both, because of unistd.h being a userspace header.
That is, include/uapi/asm-generic/unistd.h typically needs a `#if
__ARCH_WANT..., #define ...` in it. I'll give it a spin and you'll see
for v8. At the very least it should get rid of the more awkward
`select ADVISE_SYSCALLS if X86_64` part, and will better separate the
arch code from non-arch code.

> 
> >--- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> 
> > +#include "../../lib/vdso/getrandom.h"
> 
> Seriously?
> 
> include/vdso/ exists for a reason.

Er, yes, thanks.

> 
> > +#ifdef __ARCH_WANT_VGETRANDOM_ALLOC
> > +/*
> > + * The vgetrandom() function in userspace requires an opaque state, which this
> > + * function provides to userspace, by mapping a certain number of special pages
> > + * into the calling process. It takes a hint as to the number of opaque states
> > + * desired, and returns the number of opaque states actually allocated, the
> > + * size of each one in bytes, and the address of the first state.
> 
> As this is a syscall which can be invoked outside of the VDSO, can you
> please provide proper kernel-doc which explains the arguments, the
> functionality and the return value?

Yes, will do.

> 
> > + */
> > +SYSCALL_DEFINE3(vgetrandom_alloc, unsigned int __user *, num,
> > +		unsigned int __user *, size_per_each, unsigned int, flags)
> > +{
> > +	size_t alloc_size, num_states;
> > +	unsigned long pages_addr;
> > +	unsigned int num_hint;
> > +	int ret;
> > +
> > +	if (flags)
> > +		return -EINVAL;
> > +
> > +	if (get_user(num_hint, num))
> > +		return -EFAULT;
> > +
> > +	num_states = clamp_t(size_t, num_hint, 1, (SIZE_MAX & PAGE_MASK) / sizeof(struct vgetrandom_state));
> > +	alloc_size = PAGE_ALIGN(num_states * sizeof(struct vgetrandom_state));
> > +
> > +	if (put_user(alloc_size / sizeof(struct vgetrandom_state), num) ||
> > +	    put_user(sizeof(struct vgetrandom_state), size_per_each))
> > +		return -EFAULT;
> 
> That's a total of four sizeof(struct vgetrandom_state) usage sites.
> 
>        size_t state_size = sizeof(struct vgetrandom_state);
> 
> perhaps?

Not my style -- I like to have the constant expression at the usage site
so I don't have to remember the variable -- but I'm fine going with your
suggestion, so I'll do that for v8.

Jason

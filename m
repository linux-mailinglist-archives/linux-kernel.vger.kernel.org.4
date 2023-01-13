Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCA2669CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjAMPnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjAMPnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:43:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A453C871CA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:34:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40D53620D3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B682C433EF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:34:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TRUS0fhN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1673624043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1V+NP/P+0D5lj6C9ODkA/x3MZDk+pZ4mGwXIBnl4UJo=;
        b=TRUS0fhN/0IQMxsZwgP1sQW4zYe8LeC84NbYSPcXrOXGaqBtv9yw7Xh4uf5i/FEYbbUXDu
        57jg4f1NJA+l246/8/yPjgW9QX4lo1Y1OISY3RtcPY37S1tt+qXXi5UKxVY/Y4yP26ZsEQ
        A8hufrrfN5QKLTw4FerJFlXXBiC6ql8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 581cd5dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 13 Jan 2023 15:34:03 +0000 (UTC)
Received: by mail-yb1-f181.google.com with SMTP id 20so3695433ybl.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:34:03 -0800 (PST)
X-Gm-Message-State: AFqh2kr4UGMcbnjX9xruTj1MPMPqjcvP4IK9MAruxuJsFZbcYmHAoUJw
        k5K7WjdUufKCRKNtAtvBnm4IS13oBgsKZIQugSg=
X-Google-Smtp-Source: AMrXdXv4JTC7mv0gPVrN3mf8BTQNyl7/+ujMYTHN4izVo1DoUrmxzccmlAcZdySa1SC/barkP5rHVnuIrvo4iqt5nm4=
X-Received: by 2002:a25:4903:0:b0:770:d766:b5e8 with SMTP id
 w3-20020a254903000000b00770d766b5e8mr5829778yba.24.1673624042507; Fri, 13 Jan
 2023 07:34:02 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2301082113350.65308@angie.orcam.me.uk>
 <Y72CByxvewQv78YH@zx2c4.com> <alpine.DEB.2.21.2301120129020.65308@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2301120129020.65308@angie.orcam.me.uk>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 13 Jan 2023 16:33:52 +0100
X-Gmail-Original-Message-ID: <CAHmME9p9emE9WXBJyxCuCF64GqTPKqhMEJO9kpts-OdE8_2=pg@mail.gmail.com>
Message-ID: <CAHmME9p9emE9WXBJyxCuCF64GqTPKqhMEJO9kpts-OdE8_2=pg@mail.gmail.com>
Subject: Re: [PATCH v2] x86: Disable kernel stack offset randomization for !TSC
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On Thu, Jan 12, 2023 at 2:34 AM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> On Tue, 10 Jan 2023, Jason A. Donenfeld wrote:
>
> > > Index: linux-macro/arch/x86/include/asm/entry-common.h
> > > ===================================================================
> > > --- linux-macro.orig/arch/x86/include/asm/entry-common.h
> > > +++ linux-macro/arch/x86/include/asm/entry-common.h
> > > @@ -5,6 +5,7 @@
> > >  #include <linux/randomize_kstack.h>
> > >  #include <linux/user-return-notifier.h>
> > >
> > > +#include <asm/cpufeature.h>
> > >  #include <asm/nospec-branch.h>
> > >  #include <asm/io_bitmap.h>
> > >  #include <asm/fpu/api.h>
> > > @@ -85,7 +86,8 @@ static inline void arch_exit_to_user_mod
> > >      * Therefore, final stack offset entropy will be 5 (x86_64) or
> > >      * 6 (ia32) bits.
> > >      */
> > > -   choose_random_kstack_offset(rdtsc() & 0xFF);
> > > +   if (cpu_feature_enabled(X86_FEATURE_TSC))
> > > +           choose_random_kstack_offset(rdtsc() & 0xFF);
> >
> > What would happen if you just called `get_random_u8()` here?
>
>  Thank you for your input.  I've had a look at the function and it seems a
> bit heavyweight compared to a mere single CPU instruction, but I guess why
> not.  Do you have any performance figures (in terms of CPU cycles) for the
> usual cases?  Offhand I'm not sure how I could benchmark it myself.

Generally it's very very fast, as most cases wind up being only a
memcpy -- in this case, a single byte copy. So by and large it should
be suitable. It's fast enough now that most networking things are able
to use it. And lots of other places where you'd want really high
performance. So I'd expect it's okay to use here too. And if it is too
slow, we should figure out how to make it faster. But I don't suspect
it'll be too slow.

Resist calls to use RDRAND directly (it's much much slower, and not
universally available) or to roll your own opencoded bespoke RNG.

Jason

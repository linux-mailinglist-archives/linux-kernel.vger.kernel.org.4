Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBA06964DA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjBNNkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjBNNj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:39:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FD925956
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:39:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B054661620
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5804C4339C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:39:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oUUl5cW9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1676381994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ie7pHIAdGvdobbD0n6vxbJautzdMexIb8/CLOuFnebA=;
        b=oUUl5cW9kt/YpHgIYJiTjy+l6mgc/UQ0NiowQ0Z8uQztcbJP6ivC20Y+v8OfnTZuqIRV/R
        XQrWb+Bz7rJB8o15BFjaAmVjdmr/EFoeUw8/f6EA557qhyjd1xU96HuykS/1j+mlZGQdDt
        JjlS8YlWgtIP4XiMItY/vereJSRn3uw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 622e97f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 14 Feb 2023 13:39:53 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-52ee632329dso132724157b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:39:53 -0800 (PST)
X-Gm-Message-State: AO0yUKXITzqEmu+SZJ/D00ukR0axv5GhaNupJ+NBjyCd5vCLKx0aLRr9
        7mqr+tY62Y+06FVKVKiD6Ey3BoU08/slgsom6gM=
X-Google-Smtp-Source: AK7set9/ul9LIHlcdTUUeZOvzfxkuDHNZYtqOHA35cZhtKPeKR7JJ1nQRuR/s5Brk8kkS8Ljth/dmRDx7/YMAAx4ExA=
X-Received: by 2002:a81:7444:0:b0:526:d72f:8483 with SMTP id
 p65-20020a817444000000b00526d72f8483mr250986ywc.514.1676381992026; Tue, 14
 Feb 2023 05:39:52 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk>
 <874jrptmk9.ffs@tglx> <alpine.DEB.2.21.2302140456360.6368@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2302140456360.6368@angie.orcam.me.uk>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 14 Feb 2023 14:39:41 +0100
X-Gmail-Original-Message-ID: <CAHmME9r2pF-ncO5Mb7FbgW_1S_0ZrqgG-7TNa5hxieHk_8j90g@mail.gmail.com>
Message-ID: <CAHmME9r2pF-ncO5Mb7FbgW_1S_0ZrqgG-7TNa5hxieHk_8j90g@mail.gmail.com>
Subject: Re: [PATCH v3] x86: Use `get_random_u8' for kernel stack offset randomization
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
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

On Tue, Feb 14, 2023 at 6:12 AM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> On Mon, 13 Feb 2023, Thomas Gleixner wrote:
>
> > On Mon, Jan 30 2023 at 21:30, Maciej W. Rozycki wrote:
> > >
> > > Therefore switch to our generic entropy source and use `get_random_u8'
> > > instead, which according to Jason A. Donenfeld is supposed to be fast
> > > enough:
> > >
> > > "Generally it's very very fast, as most cases wind up being only a
> > > memcpy -- in this case, a single byte copy. So by and large it should
> > > be suitable. It's fast enough now that most networking things are able
> > > to use it. And lots of other places where you'd want really high
> > > performance. So I'd expect it's okay to use here too. And if it is too
> > > slow, we should figure out how to make it faster. But I don't suspect
> > > it'll be too slow."
> >
> > Please provide numbers on contemporary hardware.
>
>  Jason, is this something you could help me with to back up your claim?
>
>  My access to modern x86 gear is limited and I just don't have anything I
> can randomly fiddle with (I guess an Intel Core 2 Duo T5600 processor back
> from 2008 doesn't count as "contemporary", does it?).

I imagine tglx wants real life performance numbers rather than a
microbench of the rng. So the thing to do would be to exercise
arch_exit_to_user_mode() a bunch. Does this trigger on every syscall,
even invalid ones? If so, you could make a test like:

    #include <sys/syscall.h>
    #include <unistd.h>

    int main(int argc, char *argv[])
    {
     for (int i = 0; i < (1 << 26); ++i)
      syscall(0xffffffff);
     return 0;
    }

And then see if the timing changes across your patch.

Jason

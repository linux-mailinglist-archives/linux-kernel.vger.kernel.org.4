Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE8869F403
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjBVMGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjBVMFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:05:52 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5192E3866D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:05:20 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 5C82B92009C; Wed, 22 Feb 2023 13:05:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 593FD92009B;
        Wed, 22 Feb 2023 12:05:19 +0000 (GMT)
Date:   Wed, 22 Feb 2023 12:05:19 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86: Use `get_random_u8' for kernel stack offset
 randomization
In-Reply-To: <CAHmME9r2pF-ncO5Mb7FbgW_1S_0ZrqgG-7TNa5hxieHk_8j90g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2302160014100.44324@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk> <874jrptmk9.ffs@tglx> <alpine.DEB.2.21.2302140456360.6368@angie.orcam.me.uk> <CAHmME9r2pF-ncO5Mb7FbgW_1S_0ZrqgG-7TNa5hxieHk_8j90g@mail.gmail.com>
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

On Tue, 14 Feb 2023, Jason A. Donenfeld wrote:

> > > Please provide numbers on contemporary hardware.
> >
> >  Jason, is this something you could help me with to back up your claim?
> >
> >  My access to modern x86 gear is limited and I just don't have anything I
> > can randomly fiddle with (I guess an Intel Core 2 Duo T5600 processor back
> > from 2008 doesn't count as "contemporary", does it?).
> 
> I imagine tglx wants real life performance numbers rather than a
> microbench of the rng. So the thing to do would be to exercise
> arch_exit_to_user_mode() a bunch. Does this trigger on every syscall,
> even invalid ones? If so, you could make a test like:
> 
>     #include <sys/syscall.h>
>     #include <unistd.h>
> 
>     int main(int argc, char *argv[])
>     {
>      for (int i = 0; i < (1 << 26); ++i)
>       syscall(0xffffffff);
>      return 0;
>     }
> 
> And then see if the timing changes across your patch.

 Thanks.  Though that does not solve my lack of suitable hardware, sigh.  
It's not like I have x86 systems scattered all over the place.  I guess I 
could try to benchmark with said T5600 piece, but it won't be until April 
the earliest as I'm away most of the time.

  Maciej

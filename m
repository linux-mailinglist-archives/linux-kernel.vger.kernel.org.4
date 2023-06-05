Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C08722BC0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjFEPqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjFEPqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:46:20 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BFC3E7A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:45:55 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 1FE2C92009C; Mon,  5 Jun 2023 17:45:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 184C592009B;
        Mon,  5 Jun 2023 16:45:16 +0100 (BST)
Date:   Mon, 5 Jun 2023 16:45:16 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86: Use `get_random_u8' for kernel stack offset
 randomization
In-Reply-To: <alpine.DEB.2.21.2302160014100.44324@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2306051609430.36323@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk> <874jrptmk9.ffs@tglx> <alpine.DEB.2.21.2302140456360.6368@angie.orcam.me.uk> <CAHmME9r2pF-ncO5Mb7FbgW_1S_0ZrqgG-7TNa5hxieHk_8j90g@mail.gmail.com>
 <alpine.DEB.2.21.2302160014100.44324@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2023, Maciej W. Rozycki wrote:

> > > > Please provide numbers on contemporary hardware.
> > >
> > >  Jason, is this something you could help me with to back up your claim?
> > >
> > >  My access to modern x86 gear is limited and I just don't have anything I
> > > can randomly fiddle with (I guess an Intel Core 2 Duo T5600 processor back
> > > from 2008 doesn't count as "contemporary", does it?).
> > 
> > I imagine tglx wants real life performance numbers rather than a
> > microbench of the rng. So the thing to do would be to exercise
> > arch_exit_to_user_mode() a bunch. Does this trigger on every syscall,
> > even invalid ones? If so, you could make a test like:
> > 
> >     #include <sys/syscall.h>
> >     #include <unistd.h>
> > 
> >     int main(int argc, char *argv[])
> >     {
> >      for (int i = 0; i < (1 << 26); ++i)
> >       syscall(0xffffffff);
> >      return 0;
> >     }
> > 
> > And then see if the timing changes across your patch.
> 
>  Thanks.  Though that does not solve my lack of suitable hardware, sigh.  
> It's not like I have x86 systems scattered all over the place.  I guess I 
> could try to benchmark with said T5600 piece, but it won't be until April 
> the earliest as I'm away most of the time.

 Thank you for waiting.  I was able to arrange for benchmarking now with 
an "Intel(R) Core(TM)2 CPU T5600 @ 1.83GHz" piece.  I did a minor research 
and chose to use `perf bench syscall all' to evaluate the change, as this 
software is readily available and bundled with Linux even.  Results are as 
follows:

1. Randomisation configured in, but disabled:

# Running syscall/basic benchmark...
# Executed 10000000 getppid() calls
     Total time: 4.601 [sec]

       0.460165 usecs/op
        2173132 ops/sec

# Running syscall/getpgid benchmark...
# Executed 10000000 getpgid() calls
     Total time: 3.241 [sec]

       0.324109 usecs/op
        3085383 ops/sec

# Running syscall/execve benchmark...
# Executed 10000 execve() calls
     Total time: 7.041 [sec]

     704.193800 usecs/op
           1420 ops/sec

2. Randomisation enabled, using RDTSC:

# Running syscall/basic benchmark...
# Executed 10000000 getppid() calls
     Total time: 4.995 [sec]

       0.499529 usecs/op
        2001886 ops/sec

# Running syscall/getpgid benchmark...
# Executed 10000000 getpgid() calls
     Total time: 3.625 [sec]

       0.362521 usecs/op
        2758460 ops/sec

# Running syscall/execve benchmark...
# Executed 10000 execve() calls
     Total time: 7.009 [sec]

     700.990800 usecs/op
           1426 ops/sec

3. Randomisation enabled, using `get_random_u8':

# Running syscall/basic benchmark...
# Executed 10000000 getppid() calls
     Total time: 6.053 [sec]

       0.605394 usecs/op
        1651817 ops/sec

# Running syscall/getpgid benchmark...
# Executed 10000000 getpgid() calls
     Total time: 4.641 [sec]

       0.464124 usecs/op
        2154598 ops/sec

# Running syscall/execve benchmark...
# Executed 10000 execve() calls
     Total time: 7.023 [sec]

     702.355400 usecs/op
           1423 ops/sec

There is some variance between runs, but the trend is stable.  NB this has 
been obtained with 6.3.0 (both Linux and `perf') and GCC 11.

 So enabling randomisation with RDTSC and with `get_random_u8' makes fast 
syscalls respectively 8% and 24% slower.  I think it has been expected 
that a call to `get_random_u8' will be slower than RDTSC.  But can we 
accept the slowdown given the security concerns about RDTSC?

 What are the next steps then?

  Maciej

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F076385C1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiKYI7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiKYI7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:59:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C1431EE7;
        Fri, 25 Nov 2022 00:59:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16CBB6230E;
        Fri, 25 Nov 2022 08:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEB7C433B5;
        Fri, 25 Nov 2022 08:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669366771;
        bh=tKXgzOEam9Y7w9Zqw7Ty+4SAeHCvrSV+lqu7ZnYbTtI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pvhygxmhUCTu+f6JE2uHMB7CNVv5IukUss7nahMmOqRKCGt6kEjpHhRdgTb4YFMxx
         PlvHWP+v3slpb6HpMTl9U3DQhMb1NVdPTwxdJO3bw9b8fFyd2q8VcnUWO1L3e0xvVr
         IU+WdCTTzVQokyJOVQwW9gPFol0Z+CbgWuSvhix4mWDMEUl7wZx2hgo3zeopKQG94l
         dBjCRGgyg4R2iZP3xlkQQl3tMAt45Gx9p0nr9l0wGNj/59rMgvGwqknHOOpyQJXned
         7xqnAb/fz/jsQzpw9qKvk72NOAZnrYgx4Wd9zLJHMlLBw00ZIY4GOjTj4AwAz2IqdX
         cgoF78LTD5U2g==
Received: by mail-lf1-f41.google.com with SMTP id d6so5873598lfs.10;
        Fri, 25 Nov 2022 00:59:31 -0800 (PST)
X-Gm-Message-State: ANoB5pl0zR4nelQO+k4xRRfrhQLEsBH3LpPMVO4b/OMJyBoWPdE0KgBR
        enj/10Ytw7Zai+CdZFDJ7SNZcSMWF8UFz0Z8ar0=
X-Google-Smtp-Source: AA0mqf44IKuFZlXXXK76VmqsA+wAMZKlXyS6SzEypeShQA6TRiuieO+jnCBpVN0qzYlUNO5+ASmmIRDppfH6JfeoGog=
X-Received: by 2002:ac2:488e:0:b0:4b4:cf32:e105 with SMTP id
 x14-20020ac2488e000000b004b4cf32e105mr9000508lfc.110.1669366769424; Fri, 25
 Nov 2022 00:59:29 -0800 (PST)
MIME-Version: 1.0
References: <20221103042740.6556-1-elliott@hpe.com> <20221116041342.3841-1-elliott@hpe.com>
 <20221116041342.3841-11-elliott@hpe.com> <Y3TF7/+DejcnN0eV@zx2c4.com> <Y4B/kjS0lgzdUJHG@gondor.apana.org.au>
In-Reply-To: <Y4B/kjS0lgzdUJHG@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 25 Nov 2022 09:59:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHHm+L=qE5opDXhjoWZt+1eKXFeGVS=OdvyF0VNFZivCA@mail.gmail.com>
Message-ID: <CAMj1kXHHm+L=qE5opDXhjoWZt+1eKXFeGVS=OdvyF0VNFZivCA@mail.gmail.com>
Subject: Re: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Robert Elliott <elliott@hpe.com>, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com,
        David.Laight@aculab.com, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 at 09:41, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Wed, Nov 16, 2022 at 12:13:51PM +0100, Jason A. Donenfeld wrote:
> > On Tue, Nov 15, 2022 at 10:13:28PM -0600, Robert Elliott wrote:
> > > +/* avoid kernel_fpu_begin/end scheduler/rcu stalls */
> > > +static const unsigned int bytes_per_fpu = 337 * 1024;
> > > +
> >
> > Use an enum for constants like this:
> >
> >     enum { BYTES_PER_FPU = ... };
> >
> > You can even make it function-local, so it's near the code that uses it,
> > which will better justify its existence.
> >
> > Also, where did you get this number? Seems kind of weird.
>
> These numbers are highly dependent on hardware and I think having
> them hard-coded is wrong.
>
> Perhaps we should try a different approach.  How about just limiting
> the size to 4K, and then depending on need_resched we break out of
> the loop? Something like:
>
>         if (!len)
>                 return 0;
>
>         kernel_fpu_begin();
>         for (;;) {
>                 unsigned int chunk = min(len, 4096);
>
>                 sha1_base_do_update(desc, data, chunk, sha1_xform);
>
>                 len -= chunk;
>                 data += chunk;
>
>                 if (!len)
>                         break;
>
>                 if (need_resched()) {
>                         kernel_fpu_end();
>                         cond_resched();
>                         kernel_fpu_begin();
>                 }
>         }
>         kernel_fpu_end();
>

On arm64, this is implemented in an assembler macro 'cond_yield' so we
don't need to preserve/restore the SIMD state state at all if the
yield is not going to result in a call to schedule(). For example, the
SHA3 code keeps 400 bytes of state in registers, which we don't want
to save and reload unless needed. (5f6cb2e617681 'crypto:
arm64/sha512-ce - simplify NEON yield')

So the asm routines will call cond_yield, and return early if a yield
is required, with the number of blocks or bytes left to process as the
return value. The C wrapper just calls the asm routine in a loop until
the return value becomes 0.

That way, we don't need magic values at all, and the yield will occur
as soon as the asm inner loop observes the yield condition so the
latency should be much lower as well.

Note that it is only used in shash implementations, given that they
are the only ones that may receive unbounded inputs.

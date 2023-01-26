Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B172267C86A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbjAZKV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbjAZKVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:21:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1419230D4;
        Thu, 26 Jan 2023 02:20:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0353BB81D56;
        Thu, 26 Jan 2023 10:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF96C433A7;
        Thu, 26 Jan 2023 10:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674728432;
        bh=nbZD0mbFWOFbBW54KkHJ6dJ39BENcdubynd8h8jvIDY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ttbq0byW9vU7HgjDM5YuVUPEnKuZdMLS0dPDxWC8ZUw+Pm8VDlbilI5UyRDdEjUaf
         fa5hWN8W9dFr42K0lLsrvT9TCzAbGwUezohGVM88dcsXNlmqD5wYYq0NmhLnjM2roY
         +iJZzHfsnLZFhAQXhPUPIpnOKbiZjaXlOYdsiuIgfglPeYReiLsDq8SVRcceds1Mvg
         aeo3h0Ac7TjTe6r9UZdzC//cQNUhWkfaNVRNEoTLLH4xQOhW9khh1nBzS2lLjxbjdf
         PIEkMTIvkoLsKz8FbH+KqPTe9lIqs4RrinUQSNlQYdAL0Nm4kiCifrsam/ZkC6UqEN
         oymQMmUkzoKWg==
Received: by mail-lf1-f43.google.com with SMTP id bp15so2274502lfb.13;
        Thu, 26 Jan 2023 02:20:32 -0800 (PST)
X-Gm-Message-State: AFqh2koCxEW2TB1849RLqzv/dnqqq2DgvyWphWvwfqXT0blo6cPfGwcl
        iYLp+PDEOrp/s1EPM/rPMkQurp7hWVBv7EDSDTA=
X-Google-Smtp-Source: AMrXdXvdexbfJypyxtSQhhGMLjtDygGf5tMKivVrIgzPI+9yV5w30ETdB4bZqJ1MnFKx8sDEFHzP1ynEqHq8gLr/QBo=
X-Received: by 2002:a19:6511:0:b0:4cb:bea6:dac6 with SMTP id
 z17-20020a196511000000b004cbbea6dac6mr1991225lfb.344.1674728430655; Thu, 26
 Jan 2023 02:20:30 -0800 (PST)
MIME-Version: 1.0
References: <20230125012801.362496-1-ebiggers@kernel.org> <14506678-918f-81e1-2c26-2b347ff50701@intel.com>
 <CAMj1kXEZi1ewVdqXHTi7kWX9aT+j1=rFOVE55LdJYb9LkV9Dkw@mail.gmail.com> <1000ec59-c8b7-e546-5baa-bdd0e878bf76@intel.com>
In-Reply-To: <1000ec59-c8b7-e546-5baa-bdd0e878bf76@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 26 Jan 2023 11:20:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHcUdJQDzF1VYe8uP_-Lb1W6JXxmfTEDYGuMZqSy=2BqA@mail.gmail.com>
Message-ID: <CAMj1kXHcUdJQDzF1VYe8uP_-Lb1W6JXxmfTEDYGuMZqSy=2BqA@mail.gmail.com>
Subject: Re: [PATCH] x86: enable Data Operand Independent Timing Mode
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Roxana Bradescu <roxabee@chromium.org>,
        Adam Langley <agl@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jan 2023 at 17:46, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/25/23 08:22, Ard Biesheuvel wrote:
> ...
> > All the nospec stuff we added for Spectre v1 serves the same purpose,
> > essentially, although the timing variances due to cache misses are
> > likely easier to measure. IOW, some of the kernel is now written that
> > way in fact, although the author of that doc may have had something
> > else in mind.
> >
> > So IMHO, the scope is really not as narrow as you think.
>
> I've spoken with the folks who wrote that doc.  They've told me
> repeatedly that the scope is super narrow.  Seriously, look at just
> *one* thing in the other Intel doc about mitigating timing side-channels[1]:
>
>         be wary of code generated from high-level language source code
>         that appears to adhere to all of these recommendations.
>
> The kernel has a fair amount of code written in high-level languages.
>

This is why we have crypto_memneq(), for instance, which is intended
to be time invariant, whereas the time taken by ordinary memcmp() is
typically correlated with the byte index of the first unequal byte. So
what we do there is compare every byte, instead of returning early on
the first mismatch. We do, however, perform the comparison in the
native word size and not byte by byte.

So if these optimizations result in word comparisons potentially
taking less time if the first byte is a mismatch, we definitely have a
problem. (This particular example may be far fetched but you get my
point)

> The authors of the DOIT doc truly intend the real-world benefits of
> DOITM to be exceedingly narrow.

I understand that this is the intent. But for privileged execution,
this should really be the other way around: the scope for
optimizations relying on data dependent timing is exceedingly narrow
in the kernel, because any data it processes must be assumed to be
confidential by default (wrt user space), and it will probably be
rather tricky to identify CPU bound workloads in the kernel where data
dependent optimizations are guaranteed to be safe and result in a
significant speedup.

This is basically the same argument I made for arm64.

>  I think it would be fair to say that
> they think:
>
>         DOITM is basically useless for most code written in C, including
>         basically the entire kernel.
>
> I'll go forward this on to them and make sure I'm not overstating this
> _too_ much.
>

C code that was not specifically written with data independent timing
in mind may still behave that way today,
C code that *was* specifically written with data independent timing in
mind (such as crypto_memneq()) could potentially lose that property
under these optimizations.

> >> That's _meant_ to be really scary and keep folks from turning this on by
> >> default, aka. what this patch does.  Your new CPU will be really slow if
> >> you turn this on!  Boo!
> >
> > What is the penalty for switching it on and off? On arm64, it is now
> > on by default in the kernel, and off by default in user space, and
> > user space can opt into it using an unprivileged instruction.
>
> Right now, DOITM is controlled by a bit in an MSR and it applies
> everywhere.  It is (thankfully) one of the cheap MSRs and is not
> architecturally serializing.
>
> That's still not ideal and there is a desire to expose the bit to
> userspace *somehow* to make it much, much cheaper to toggle.  But, it'll
> still be an extra bit that needs to get managed and context switched.
>
> When I looked, the arm64 bit seemed to be in some flags register that
> got naturally saved and restored already on user<->kernel transitions.
> Was I reading it right?  It seemed like a really nice, simple mechanism
> to me.
>

Indeed. It is part of PSTATE, which means is gets preserved/restored
along with the rest of the SPSR (saved program state) when an
exception is taken.

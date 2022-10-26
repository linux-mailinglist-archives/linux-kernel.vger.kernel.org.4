Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D3060E605
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbiJZRB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbiJZRBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:01:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672167D788;
        Wed, 26 Oct 2022 10:01:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68A9FB82399;
        Wed, 26 Oct 2022 17:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1822FC433D6;
        Wed, 26 Oct 2022 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666803675;
        bh=gZS5hX+uqYcqQ6nRgjv9ovuIvnnki7D052kUiDqQ88c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VHJBHhcB70RHtFk1nTaHHpZ2A7t3l89kOXaZGcbELoGJwVK5E5qGWNL0oJ3BO14ea
         jEoGvDsjVsjuVQsejejpChRV54aFJol/gQjcwQCYgacj1Je860WaWNCh0h6JGs/SXg
         TiC0r61nqnFAEnbLGI9cezvV8a8fpps98SOd21LpH5xr6LOKFSiKwmMjWpsqTtpIg1
         RjaZJvuK+r5Pynlo038jZi4KrKfMhVB77AgOof4bZTDXDNCUNtBywyQH9jXUIh9jWF
         FtYbdp809ZmUj2ak0l7qxS/kaPFyVOoAoK54vz+v8xmRDjbIyRX4qOdfwUZfwBo51m
         SI4jFTrb5HDZw==
Received: by mail-lj1-f169.google.com with SMTP id a15so18314742ljb.7;
        Wed, 26 Oct 2022 10:01:14 -0700 (PDT)
X-Gm-Message-State: ACrzQf0PmAOojyOu/EIOjmXlUzBk5A/DED/fnrExcF5GI+dDoFgM+xPV
        bui2SzWVyF0woH8NoLbNVecxje/3264jQbC1BLM=
X-Google-Smtp-Source: AMsMyM5JOlFujIoCZrFt4KwYJSeO+5uA0LH8MkxYGMwqH0kzUiRu1b5caMySW44BA2teStC1faTZm2F2vgsmvsnvjAw=
X-Received: by 2002:a05:651c:4d0:b0:26f:cd9b:419f with SMTP id
 e16-20020a05651c04d000b0026fcd9b419fmr15919265lji.415.1666803673035; Wed, 26
 Oct 2022 10:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <YwgCrqutxmX0W72r@gmail.com> <Ywzr2d52ixYXUDWR@zx2c4.com>
 <6ec9cdab-db5b-ab28-c92d-79c3812dd369@intel.com> <YyNmQ2bPvf3B3Xvo@arm.com>
In-Reply-To: <YyNmQ2bPvf3B3Xvo@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 Oct 2022 19:01:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFzSEH=_h6fXDutECwP8=J=q-OaAevOret-MZeTWd6OzQ@mail.gmail.com>
Message-ID: <CAMj1kXFzSEH=_h6fXDutECwP8=J=q-OaAevOret-MZeTWd6OzQ@mail.gmail.com>
Subject: Re: Should Linux set the new constant-time mode CPU flags?
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Adam Langley <agl@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sept 2022 at 19:52, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Aug 30, 2022 at 07:25:29AM -0700, Dave Hansen wrote:
> > On 8/29/22 09:39, Jason A. Donenfeld wrote:
> > > On Thu, Aug 25, 2022 at 11:15:58PM +0000, Eric Biggers wrote:
> > >> I'm wondering if people are aware of this issue, and whether anyone has any
> > >> thoughts on whether/where the kernel should be setting these new CPU flags.
> > >> There don't appear to have been any prior discussions about this.  (Thanks to
> > > Maybe it should be set unconditionally now, until we figure out how to
> > > make it more granular.
> >
> > Personally, I'm in this camp as well.  Let's be safe and set it by
> > default.  There's also this tidbit in the Intel docs (and chopping out a
> > bunch of the noise):
> >
> >       (On) processors based on microarchitectures before Ice Lake ...
> >       the instructions listed here operate as if DOITM is enabled.
> >
> > IOW, setting DOITM=0 isn't going back to the stone age.  At worst, I'd
> > guess that you're giving up some optimization that only shows up in very
> > recent CPUs in the first place.
> >
> > If folks want DOITM=1 on their snazzy new CPUs, then they came come with
> > performance data to demonstrate the gain they'll get from adding kernel
> > code to get DOITM=1.  There are a range of ways we could handle it, all
> > the way from adding a command-line parameter to per-task management.
> >
> > Anybody disagree?
>
> It's not my preferred option for arm64 but I admit the same reasoning
> could equally apply to us. If some existing crypto libraries relied on
> data independent timing for current CPUs but newer ones (with the DIT
> feature) come up with more aggressive, data-dependent optimisations,
> they may be caught off-guard. That said the ARM architecture spec never
> promised any timing, that's a micro-architecture detail and not all
> implementations are done by ARM Ltd. So I can't really tell what's out
> there.
>
> So I guess knobs for finer grained control would do, at least a sysctl
> (or cmdline) to turn it on/off globally and maybe a prctl() for user. We
> don't necessarily need this on arm64 but if x86 adds one, we might as
> well wire it up.
>

With all the effort spent on plugging timing leaks in the kernel over
the past couple of years, not enabling this at EL1 seems silly, no?
Why would we ever permit privileged code to exhibit data dependent
timing variances?

As for a prctl() for user space - wouldn't it make more sense to
enable this by default, and add a hwcap so user space can clear DIT
directly if it feels the need to do so?

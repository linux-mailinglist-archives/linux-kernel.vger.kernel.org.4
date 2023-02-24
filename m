Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4A36A144E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 01:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjBXA1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 19:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXA1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 19:27:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CE52705;
        Thu, 23 Feb 2023 16:27:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABD5DB81B9E;
        Fri, 24 Feb 2023 00:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551F2C433A0;
        Fri, 24 Feb 2023 00:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677198468;
        bh=04HzNiXeZWVQUk21JLryWqtmb0X9RFU/gPUr0yis9Gs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XbIPccfNIEdDHpKlCl5b4JTDQ5O4ni+Wyct/voolXYdrqAe9dZbMCjlmNVIh/Bfqf
         L6YU7iUgZSqCr+Zy9wc8d2zGdjwshN26FYvCkDWQhYfATXmP+coQI+y/KLzVFQvpVY
         tF31txnNjHnNPuaHx5xWYpnJMYAyVIqiIL41Npj7fZ/E/VWkNrB5pS3ZLdkIbAzbb6
         8THdVszjk7ZputT6Yj0OYlTWjbRv+Sj7mfWbCy90aZqUuemaEZpS5HomZTtwAjgVYP
         gLIriAC0uB7qQ6HsOLRwQiDlD/q4Dqt21tbj9E0Xn4pFkcNQMvkMPLUn031gQjGtII
         QWg0ODZCFAUew==
Received: by mail-oi1-f173.google.com with SMTP id q15so6464601oiw.11;
        Thu, 23 Feb 2023 16:27:48 -0800 (PST)
X-Gm-Message-State: AO0yUKX4rW8CZ6k/IhF1soXN5SYWfN+/hgMTKEMuFWTk1Gu2c8b+wL8A
        u7eUe4lT0iZxDPLrGJLIQAPkxAARn9oVI0AKeGQ=
X-Google-Smtp-Source: AK7set8U0qz7dTajr8wKMh2TbmDSLqhSeRhHSczTQAqxiE1PVudX5LoBI0kqCXZkQ1R+EqHAfrZnwvjxfDgH0iMiCcw=
X-Received: by 2002:aca:1b04:0:b0:383:d3ae:2ef4 with SMTP id
 b4-20020aca1b04000000b00383d3ae2ef4mr507233oib.8.1677198467541; Thu, 23 Feb
 2023 16:27:47 -0800 (PST)
MIME-Version: 1.0
References: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
 <63c2936e-6bc7-67e3-eaf3-0123333381f8@landley.net> <CAK7LNASA+Dpe9nv4afnueFeRj4BZDUccOFGJRPr7_rZQ7ZZKaA@mail.gmail.com>
 <380c88ef-eb19-e73e-0ec9-805b8b90e957@landley.net>
In-Reply-To: <380c88ef-eb19-e73e-0ec9-805b8b90e957@landley.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 24 Feb 2023 09:27:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNATzPWoPpKNuZ8LOUw4j=LVsHn2ji-++8i3Cn_4fJGoQSg@mail.gmail.com>
Message-ID: <CAK7LNATzPWoPpKNuZ8LOUw4j=LVsHn2ji-++8i3Cn_4fJGoQSg@mail.gmail.com>
Subject: Re: [PATCH 1/5] try generic compiler name "cc" before falling back to "gcc".
To:     Rob Landley <rob@landley.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 10:36 PM Rob Landley <rob@landley.net> wrote:
>
> On 2/22/23 23:31, Masahiro Yamada wrote:
> > On Wed, Feb 22, 2023 at 5:41 AM Rob Landley <rob@landley.net> wrote:
> >>
> >> Distros like debian install the generic "cc" name for both gcc and clang,
> >> and the plumbing already does CC_VERSION_TEXT to include Makefile.clang.
> >>
> >> Previously: https://lkml.iu.edu/hypermail/linux/kernel/2202.0/01505.html
> >> Signed-off-by: Rob Landley <rob@landley.net>
> >> ---
> >>  Makefile | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Makefile b/Makefile
> >> index 3f6628780eb2..0ac57ae3b45f 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -456,7 +456,7 @@ endif
> >>  HOSTCC = $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
> >>  HOSTCXX        = $(LLVM_PREFIX)clang++$(LLVM_SUFFIX)
> >>  else
> >> -HOSTCC = gcc
> >> +HOSTCC := $(shell cc --version >/dev/null 2>&1 && echo cc || echo gcc)
> >
> > 'cc' only makes sense for the host compiler,
>
> It was the generic posix name for "C compiler" until posix decided to put an
> expiration date in the command name, which seems as widely honored as the
> tar->pax switch or the removal of cpio.
>
> The name "gcc" was like "gmake" and "gawk". (On macos homebrew there's "gsed".)
>
> > which is configured by 'update-alternative'.
>
> Hexagon only has llvm support, not gcc, so I had to add an llvm cross compiler
> to my cross compiler set, prefixed hexagon-unknown-linux-musl-*, but the linux
> kernel wants to call it as hexagon-unknown-linux-musl-gcc.
>
> The kernel builds find with a "gcc" symlink to clang, but there _is_ a generic
> name, which is widely installed.



In the discussion in the past [1], we decided to
go with LLVM=1 switch rather than 'cc'.
We do not need both.

[1]: https://lkml.org/lkml/2020/3/28/494








>
> > I tried it before, but LLVM folks preferred
> > using $(LLVM) to choose clang/gcc.
>
> So if we want generic behavior without having to specify, we should create a
> "gcc" symlink to clang?


If you mean "without LLVM=1 or HOSTCC=clang specified",
I think the answer is yes.






>
> >>  HOSTCXX        = g++
> >>  endif
> >>  HOSTRUSTC = rustc
> >> @@ -503,7 +503,8 @@ OBJDUMP             = $(LLVM_PREFIX)llvm-objdump$(LLVM_SUFFIX)
> >>  READELF                = $(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX)
> >>  STRIP          = $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
> >>  else
> >> -CC             = $(CROSS_COMPILE)gcc
> >> +CC             := $(CROSS_COMPILE)$(shell $(CROSS_COMPILE)cc --version \
> >> +                       >/dev/null 2>&1 && echo cc || echo gcc)
> >
> > This hunk sets up GCC/binutils.
>
> This is the codepath that's taken when you don't explicitly specify "LLVM=1".
> The test there is falling back to (appropriately prefixed) gcc when it can't
> find a working (appropriately prefixed) cc.


Unless LLVM=1 is specified, the toolchain defaults to GCC/binutils,
there is no need for such additional complexity.




>
> > So, cc does not make sense.  NACK.
>
> Do you explicitly specify the "gold" linker vs the previous gnu one vs
> lld.llvm.org on the kernel build command line?


gold is unsupported.
See 75959d44f9dc8e44410667009724e4e238515502


Yes, to override only LD, LD=ld.lld should be given in the command line.





>
> Rob



-- 
Best Regards
Masahiro Yamada

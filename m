Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1553573BEB6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 21:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjFWTQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 15:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFWTQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 15:16:40 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A55E2696
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 12:16:39 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-440ab3566cbso354627137.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 12:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687547798; x=1690139798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2OV0HZ7lds/NcEpAufvexd01rNFbNdtfLFGpTpqJh4=;
        b=mOuqRoloYWXqdXttJ4SiENhK9j3odCSfkF2rSqcDLxcb4xJYeffEYYqXPjbYBPwXlT
         tpF4Su3vdFBellLTQ1mCtn/5IqSWyBdl435TTU9I/lbvQ9xxV8CACCovJVWlWbFdtg+a
         2fnYcd+gpccPpe3D/7Lv+FVsfocP3SYUIqTfh6KAe8yexOyXCNHZ0GYOf3v+1F4JgsCJ
         36hmgHPy6jIoQN4y9lpA1jowTd9oy0dogMNRVuDjcX9wOVNosroEhpVZCIggDgs5H3a4
         P9Day28OQ96qJ7m2P7qoCl/Iwy+Tmm7DrafLBZkCoYe3Qy82+x1/rHeRGNLuGm+hsJve
         q87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687547798; x=1690139798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2OV0HZ7lds/NcEpAufvexd01rNFbNdtfLFGpTpqJh4=;
        b=jGHbeussdhMBZLIc0nnMzh75VDd62w0ifVqltzUk5zKLIPoglS8odZ6p79e1wpeSx5
         jKbW8OWXlhloez3eugnPjT2l5CMWnX+anDIfSk2rO5pilNja1q7uf+EAO9v3oLGC/roG
         12thhs4UmMSn4wgDmsbwLvttIiB831S26L04/KyaBXX29wW1utFcXyteYqbv69seonlu
         qLxuUBM42QqYrfkpY86QOmJQEpi4vewi7c9FrNqlRPQH8QQjcrbr9EC4XfPXnNyqJ7h1
         qlturVmoVSd/UU333nYxR3Tw8Gb1hE0bVMRugycXAdRsauK27tKYc3C0STXVui4pC6Zt
         okkg==
X-Gm-Message-State: AC+VfDzNF0qSO9zH0BKMgt/liN0hEpDWw8U1ajKbVKPLo+k5r7CyXDjr
        o6w/qY1RbwgZIefTsgpNFHcAf059EVdtV63IWn7BhA==
X-Google-Smtp-Source: ACHHUZ7dLdc6iZ0lclvwVLMg0VK4abWzcVY6CYBkgmGUKH3avprHyqDEQY0npO39Tzem12TMy9CbtCNfqZp6RKBzVrI=
X-Received: by 2002:a67:f60e:0:b0:43f:5ad3:1905 with SMTP id
 k14-20020a67f60e000000b0043f5ad31905mr7176733vso.29.1687547797847; Fri, 23
 Jun 2023 12:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twNnV4zMCvrPkw3H-ajZOH-01JVh_kDrxdPYQErz8ZTdA@mail.gmail.com>
 <CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com> <CAHk-=wg9p+oJtzC0582vke8whcWPNSC9eq0Z6kdnSqWMEpah7g@mail.gmail.com>
In-Reply-To: <CAHk-=wg9p+oJtzC0582vke8whcWPNSC9eq0Z6kdnSqWMEpah7g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 23 Jun 2023 12:16:26 -0700
Message-ID: <CAKwvOd=dUWWSzQEWdguhe3SjYTw7a76skx370DbU2Y+5o=M8BA@mail.gmail.com>
Subject: Re: arm32 build warnings in workqueue.c
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:52=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> [ Adding clang people. See this for background:
>
>     https://lore.kernel.org/all/CAHk-=3Dwi=3DeDN4Ub0qSN27ztBAvHSXCyiY2stu=
3_XbTpYpQX4x7w@mail.gmail.com/
>
>   where that patch not only cleans things up, but seems to make a
> difference to clang ]
>
> On Fri, 23 Jun 2023 at 11:24, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So I really think that code needs fixing, and the gcc warning was very =
valid.
> >
> > Maybe something like the attached. Does this fix the gcc warning?
> > Tejun, comments?
>
> Whee. Inexplicably, that patch also improves code generation with
> clang, with things like this:
>
> -       movabsq $137438953440, %rcx             # imm =3D 0x1FFFFFFFE0
> -       andq    %rax, %rcx
> -       movabsq $68719476704, %rdx              # imm =3D 0xFFFFFFFE0
> -       cmpq    %rdx, %rcx
> +       shrq    $5, %rax
> +       cmpl    $2147483647, %eax               # imm =3D 0x7FFFFFFF
>
> in several places.

Sorry, are those equivalent?  Before looks to me like:

if (0xFFFFFFFE0 - (0x1FFFFFFFE0 & rax))

and after

if (0x7FFFFFFF - (rax >> 5))

>
> Or, even more amusingly, this:
>
> -       movabsq $68719476704, %rax              # imm =3D 0xFFFFFFFE0
> -       orq     $1, %rax
> +       movabsq $68719476705, %rax              # imm =3D 0xFFFFFFFE1
>
> where the old code was some truly crazy stuff.

Yeah, that's stupid. Which symbol's disassembly are you looking at? I
couldn't repro with a quick test: https://godbolt.org/z/dz1fEY9Wx.

>
> I have *no* idea what drugs clang is on, but clearly clang does some
> really really bad things with large enums, and doesn't simplify things
> correctly.
>
> That "I can't even do a constant 'or' at compile time when it involves
> an enum" is all kinds of odd.
>
> Does this matter in the big picture? No. But I think the take-away
> here should be that you really shouldn't use enums for random things.
> Compilers know enums are used as small enumerated constants, and get
> pissy and confused when you use them as some kind of generic storage
> pool for values.
>
> My guess is that clang keeps an enum as an enum as long as possible -
> including past some (really) simple simplification phases of the
> optimizer.

I don't think so.
https://godbolt.org/z/M8746c49z
That's LLVM IR as soon as it leaves the front end. Notice the use of
`i32` types. AFAIK, the IR does not contain the notion of enums. Clang
lowers enums to integral values of a specific width in LLVM IR.

>
> With gcc, code generation didn't change from that patch with my
> defconfig on x86-64 (apart from line numbers changing).
>
> Now, clang improving code generation with that patch is obviously a
> good thing for the patch, but it does mean that clang really messed up
> before.
>
>                Linus



--=20
Thanks,
~Nick Desaulniers

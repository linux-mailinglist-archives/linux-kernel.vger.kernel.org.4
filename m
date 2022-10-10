Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD4A5FA6EC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 23:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiJJVXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 17:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJJVXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 17:23:45 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746A879687
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 14:23:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c20so1863613plc.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 14:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+sJ/oweV4chJnDymroBgeN7mOjH5s0c90aIlCoveJ3M=;
        b=at/GzrNip0vvaWZdMtg6b9oC+qdIP9gDHkUbM/9OPUG+MiRzOxwwQbVFm6jxmJzhnD
         vP3qEQ5igJTvzngSoUH8yN3TqvVyKxqnR2a80cbfRCYA4epezytZt4gZJrqDU6vhtgpR
         ZQCcsJ3g6uQ83QzDXWu0lZ0V5ULbWzOfyB2mU+TkGoHCvekxONtqbZFVTNXJPKM9itZI
         Aa6QPe7FTR/eteIiezYGlX55cm2YoYSsZg1qc2yIVC4OOQPz/99ikKVUqV+qybwfvLFY
         pB7CxhRDHAaWyI9OFiwYjztUORXXzvpK/wLJcVC3N7hXmd2Q9LCUH6Wd9Mq8uFx9t6M1
         m3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+sJ/oweV4chJnDymroBgeN7mOjH5s0c90aIlCoveJ3M=;
        b=ADhL+h6QsmSXyH7Zy6ZTRgSykMkdgUo9HgvqKav04ShgqpOMKcgF+b+rtCQ8BN4oJT
         xuU4I47bRoY2tNJKlpUPXxLpWEh53cnLVY9xmPm+XsgOFcJphH5kDQ8KA326y0wwrrrX
         W7vRitKsJTyFnwCb8bqb59RVkbUIoZMJpIl4R9+716WS0ix4L8BlgzlOn5BvqiBho+8P
         hX2OXlkfHhe5nKLVheotLKLKOwbkovq4geVDzbmUvq1m14t+AtE6fd4upAuvLo/gONnr
         o2Lu1imZ+EwJ9Bm3Je5kBOw/vVxT7ow4wrImbHL0vdKe8uZE6bFKWEWSYaz5dJceZhVx
         QP8Q==
X-Gm-Message-State: ACrzQf05kBj0w0/+bxuln3SMGwqcBSshUnHERLfxwnV/mKUu5zroR/Ur
        gHU0btPaw2FHjbTLZD1j4o8vWVdAuBjY3xv/nEHADw==
X-Google-Smtp-Source: AMsMyM58c/JM1tzaEva2PMIuMrUgVzEel+We68/BGcV+MBNQiK2LN2GrNXYcryDyKaRMYyQSycCVwEN8m1GK+h8lyOM=
X-Received: by 2002:a17:90b:3a88:b0:209:f35d:ad53 with SMTP id
 om8-20020a17090b3a8800b00209f35dad53mr33965063pjb.102.1665437020431; Mon, 10
 Oct 2022 14:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220716001616.4052225-1-ndesaulniers@google.com> <CAK8P3a0ky5w82=d2N_iZ2HYujeCDKJJqjT8P25-_+VpsZYWA_A@mail.gmail.com>
In-Reply-To: <CAK8P3a0ky5w82=d2N_iZ2HYujeCDKJJqjT8P25-_+VpsZYWA_A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 10 Oct 2022 14:23:28 -0700
Message-ID: <CAKwvOdnfPeFpkD7zqt0EGk-xC_v_Lxt+2eOciMfbXihYG936Kw@mail.gmail.com>
Subject: Re: [PATCH] arm: lib: implement aeabi_uldivmod via div64_u64_rem
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Ard Biesheuval <ardb@kernel.org>, Gary Guo <gary@garyguo.net>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Craig Topper <craig.topper@sifive.com>,
        Philip Reames <listmail@philipreames.com>, jh@jhauser.us
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 2:47 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Sat, Jul 16, 2022 at 2:16 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Compilers frequently need to defer 64b division to a libcall with this
> > symbol name. It essentially is div64_u64_rem, just with a different
> > signature. Kernel developers know to call div64_u64_rem, but compilers
> > don't.
> >
> > Link: https://lore.kernel.org/lkml/20220524004156.0000790e@garyguo.net/
> > Suggested-by: Gary Guo <gary@garyguo.net>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

So the existing division by constant issues went away, and Craig was
able to improve division by double-word constants in LLVM
1. https://reviews.llvm.org/D130862
2. https://reviews.llvm.org/D135541
But we still have one instance left that's not div/rem by constant via
CONFIG_FPE_NWFPE=y that's now blocking Android's compiler upgrade.
https://github.com/ClangBuiltLinux/linux/issues/1666

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/nwfpe/softfloat.c#n2312
Any creative ideas on how to avoid this? Perhaps putting the `aSig -=
bSig;` in inline asm? Inserting a `barrier()` or empty asm statement
into the loops also seems to work.

Otherwise I'd define __aeabi_uldivmod as static in
arch/arm/nwfpe/softfloat.c (with the body from this patch) only for
clang.

I see this function seems to be based on Berkeley Softfloat
http://www.jhauser.us/arithmetic/SoftFloat.html
v2.  v3 looks like a total rewrite.  Looking at v3e, it looks like
float64_rem() is now called f64_rem() and defined in f64_rem.c.  It
doesn't look like there's anything from v3 that we could backport to
the kernel's v2 to avoid this.

Otherwise perhaps we just disable OABI_COMPAT for clang. Quite a few
defconfigs explicitly enable FPE_NWFPE though.  Are there really a lot
of OABI binaries still in use?

There's also the hidden llvm flag:
`-mllvm -replexitval=never` that seems to work here, though FWICT it's
disabling 3 such loop elisions (I think all three statements in that
do while).  That's probably the best way forward here...

https://reviews.llvm.org/D9800 made the decision to do such a
transformation when a loop can be fully elided ("deleted").

>
> This has historically been strongly NAK'd, and I don't think that position
> has changed in the meantime. A variable-argument 64-bit division is
> really expensive, especially on 32-bit machines that lack a native
> 32-bit division instruction, and we don't want developers to accidentally
> insert one in their driver code.
>
> Explicitly calling one of the division helpers in linux/math64.h is the
> established way for driver writers to declare that a particular division
> cannot be turned into a cheaper operation and is never run in a
> performance critical code path. The compiler of course cannot know
> about either of those.
>
>         Arnd



-- 
Thanks,
~Nick Desaulniers

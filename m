Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2465EE4C6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiI1TG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI1TG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:06:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BF26DFA9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:06:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cv6so3086666pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=W3ASQ/4BEnMmDHF1uq/+A5cnEmR5wykxy9kK3sptaxY=;
        b=o6gF0BIPfROOsR+RzwsAhXruWNZRLqgFj0clWAglKOSG6A8mI2OJ11R071Ajl+7I7x
         eRlCM2OxVKD9YP5SfA5jG3+3W6vrq3FX40SSBJbOsDjO+D7hY9/gxYfJw3kLztM6VHCn
         gO0EFxeVBI+TOuMG0StvdWRvdYIVzNnRTpkW3B0/YK6PMcrJtWFQkD0HhaHDWHSV+Jf7
         AYtjmiMK+pWWigbCORaJMc7qdvSWiJrNOZfbojVi8in8DTf/0OUbT4sMKkPbiCcCQrHX
         bokGF1KrfBdaQpETmNlr8zMoGV04aSDGAxhP3RAfuSeRi3hbRd35wqn2VMhN5L15xVra
         Fp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=W3ASQ/4BEnMmDHF1uq/+A5cnEmR5wykxy9kK3sptaxY=;
        b=dpw/Xb85xzhJq3sEETVcoFjiq0nnyYYZxojOdCLobrrOKqZlcSPFB/GEwjRKSnma7b
         b29X2cOzwtWe0hgak0wNLKwgPeEp+u+M7Z700rXR8vmYqIsrG8af07sqWLAMjTLiw5Sf
         r8wn2aQtABPhJsD+BH3DzTgGTyqKdm8rFr92FMIVVuU4y/7HTnLYVWKhi8ZwZG02Dplb
         1neeAb4xiGNvSs6Oa2L3+AVYAtnIa7YX1phmxI6GRctEPf7xpCRmgINtF2MlTC0NaVTL
         P3ZI0BFOTKJDPeQFFgvmfp034/sCSE9UPnkJB8vesXVDxaXsDEtKJgjP43299VwVyesP
         okjQ==
X-Gm-Message-State: ACrzQf3t/z3H7isSZjufOcwqYb1CpXlwxR6MJUze4gmCwsMIElvMxH4r
        xJbkkqD9aizn0KGIqfuR9m5x4AYscVm+CCMrCmfCsQ==
X-Google-Smtp-Source: AMsMyM4fP4mGUPlpcS8f4HUJXSMvxbW2E37cAr05PH8PpgKS1vmQtjs+RLpeNam1jtgkpIf0o2JRQaLDbTXGtUcjDvs=
X-Received: by 2002:a17:90b:33c9:b0:200:a0ca:e6c8 with SMTP id
 lk9-20020a17090b33c900b00200a0cae6c8mr11977762pjb.147.1664392014929; Wed, 28
 Sep 2022 12:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <202209271333.10AE3E1D@keescook> <20220927210248.3950201-1-ndesaulniers@google.com>
 <a753c608-813a-f880-67ca-f16fe503b152@rasmusvillemoes.dk>
In-Reply-To: <a753c608-813a-f880-67ca-f16fe503b152@rasmusvillemoes.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Sep 2022 12:06:43 -0700
Message-ID: <CAKwvOd=C=yhC5-fBVxD18GSWOibPpSJ1G4bfM=X0bw+LpTsfgg@mail.gmail.com>
Subject: Re: [PATCH v3] x86, mem: move memmove to out of line assembler
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        llvm@lists.linux.dev, Andy Lutomirski <luto@kernel.org>
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

On Wed, Sep 28, 2022 at 12:24 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 27/09/2022 23.02, Nick Desaulniers wrote:
>
> > +     /* Decide forward/backward copy mode */
> > +     cmpl    dest, src
> > +     jb      .Lbackwards_header
>
> I know you're mostly just moving existing code, but for my own education
> I'd like to understand this.
>
> > +     /*
> > +      * movs instruction have many startup latency
> > +      * so we handle small size by general register.
> > +      */
> > +     cmpl    $680, n
> > +     jb      .Ltoo_small_forwards
>
> OK, this I get, there's some overhead, and hence we need _some_ cutoff
> value; 680 is probably chosen by some trial-and-error, but the exact
> value likely doesn't matter too much.

__memmove in arch/x86/lib/memmove_64.S uses the same value.
But I assume this is precisely why FSRM was created.
https://www.phoronix.com/news/Intel-5.6-FSRM-Memmove
commit f444a5ff95dc ("x86/cpufeatures: Add support for fast short REP; MOVSB")

>
> > +     /*
> > +      * movs instruction is only good for aligned case.
> > +      */
> > +     movl    src, tmp0
> > +     xorl    dest, tmp0
> > +     andl    $0xff, tmp0
> > +     jz      .Lforward_movs
>
> But this part I don't understand at all. This checks that the src and
> dest have the same %256 value, which is a rather odd thing, and very
> unlikely to ever be hit in practice. I could understand if it checked
> that they were both 4 or 8 or 16-byte aligned (i.e., (src|dest)&FOO)),
> or if it checked that they had the same offset within a cacheline [say
> (src^dest)&0x3f].
>
> Any idea where that comes from? Or am I just incapable of reading x86 asm?

So I think the above is roughly:
if ((src ^ dest) & 0xff == 0)
  goto .Lforward_movs;

So if src or dest don't have the same bottom byte value, don't use movs?

>
> > +.Ltoo_small_forwards:
> > +     subl    $0x10, n
> > +
> > +     /*
> > +      * We gobble 16 bytes forward in each loop.
> > +      */
> > +.L16_byteswap_forwards_loop:
> > +     subl    $0x10, n
> > +     movl    0*4(src), tmp0
> > +     movl    1*4(src), tmp1
> > +     movl    tmp0, 0*4(dest)
> > +     movl    tmp1, 1*4(dest)
> > +     movl    2*4(src), tmp0
> > +     movl    3*4(src), tmp1
> > +     movl    tmp0, 2*4(dest)
> > +     movl    tmp1, 3*4(dest)
> > +     leal    0x10(src), src
> > +     leal    0x10(dest), dest
> > +     jae     .L16_byteswap_forwards_loop
> > +     addl    $0x10, n
> > +     jmp     .L16_byteswap
> > +
> > +     /*
> > +      * Handle data forward by movs.
> > +      */
> > +.p2align 4
> > +.Lforward_movs:
> > +     movl    -4(src, n), tmp0
> > +     leal    -4(dest, n), tmp1
> > +     shrl    $2, n
> > +     rep     movsl
> > +     movl    tmp0, (tmp1)
> > +     jmp     .Ldone
>
> So in the original code, %1 was forced to be %esi and %2 was forced to
> be %edi and they were initialized by src and dest. But here I fail to
> see how those registers have been properly set up before the rep movs;
> your names for those are tmp0 and tmp2. You have just loaded the last
> word of the source to %edi, and AFAICT %esi aka tmp2 is entirely
> uninitialized at this point (the only use is in L16_byteswap).
>
> I must be missing something. Please enlighten me.

No, you're right.  It looks like rep movsl needs src in %esi and dest
needs to be in %edi, so I can't reuse the input registers from
-mregparm=3; a pair of movs is required.  A v4 is required.

Probably should write a test for memcpy where n > magic constant 680.
-- 
Thanks,
~Nick Desaulniers

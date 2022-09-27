Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85DC5ECDA6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbiI0UDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiI0UCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:02:25 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558FA1C5CBF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:01:48 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id a80so10629150pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SNLo4c9BXtM0z8UOQgf5tFMG8y138Obd6dyre72qoDc=;
        b=YGNnK0RD7gMznPaSdiz+8/9d+mAhbgcMjrKjGfS4Ua0g7pNb438g/v79EXPXkPfnuH
         a5DqrcBgZSyqMknfCCnZfSt2baOkOFcOiroT+L7+Mns7eHGbtweRaw5F1DOX7AN7wicX
         Llm+dO8eq5ifmRMGFFRawrgjjoHFYDxkKzBKoKZZLmxGEmWFUV1/a8n+k5wS8imXAVaC
         QKINXr+UsuuOyH/ho3RNnrdCHxmI6WQ55Ed+OZmL5HR6b/jHFxAjSrzKSRocPL7eQ1j7
         xZ2jVnhxMjMrRnbdIDcBPxHFcgCbvdKyHpNkMiCFxOe57ZZhYrE40AIhvoC15AQYbOOy
         MxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SNLo4c9BXtM0z8UOQgf5tFMG8y138Obd6dyre72qoDc=;
        b=P3a7jJyO+S6g3pwT4StZ6sfRanJIUGUov2Eg7owG497f2KSrFZXspjXbL7UpFIIVon
         YIgz9UhOC1gJeGvdbn/zG0B+7KXmcFX6HRXgF3/RiJweZQ5mLQ646n0EBTnQxIYYfCsn
         wGgG/Q06ZdpfZ5Lb5RdBtX/Ez5mQJ2TMaVzfXOouCR5F+FEgZU4xMvJv1mDTs9T3Sz0I
         eVh0O9mD3k3+1Xa74rUckSVPeXKrsCvFwBPJr+iRttg1Ks51NMTpAIWGZAqBRdvXBwiz
         bHA46rRR6gxJ9rE2e5MSnucxQY1YTTZh5Rs0fg12wKo+KuSp9l0juQSyKtKcccpEzJXJ
         Td3Q==
X-Gm-Message-State: ACrzQf2JVv61bzo8TXcNNVxZ4aPykenGX/1MPUBJAEkzwcOIBROAqbBi
        Ah+bjUdLRIGtVTIVlsbcIgVFzQtRakyvTNnT9PuKoA==
X-Google-Smtp-Source: AMsMyM5nUZ7pJPZM0NapVjvtCoXp0CCfy1zzFCgNJOsgpQxvYoYW8apQuNO9SAObnHlget6TUmiX9lei/L0iloYqEGQ=
X-Received: by 2002:a62:1ad5:0:b0:540:4830:7df6 with SMTP id
 a204-20020a621ad5000000b0054048307df6mr30046652pfa.37.1664308907250; Tue, 27
 Sep 2022 13:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=a+0VNP-d=mHnbM4ujdtPrujru4dxHtfDo+EEM+b6deg@mail.gmail.com>
 <20220927172839.3708280-1-ndesaulniers@google.com> <202209271143.7B7D15D@keescook>
In-Reply-To: <202209271143.7B7D15D@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Sep 2022 13:01:35 -0700
Message-ID: <CAKwvOdk1QM4iZqEVj5MzTW3jMr1FiD_0C065Kub=EHKnH+xNaw@mail.gmail.com>
Subject: Re: [PATCH v2] x86, mem: move memmove to out of line assembler
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Tue, Sep 27, 2022 at 12:24 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Sep 27, 2022 at 10:28:39AM -0700, Nick Desaulniers wrote:
> > In addition to having complex constraints that can't always be resolved,
> > the clobber list seems to be missing %bx and %dx, and possibly %cl. By
> > using numbered operands rather than symbolic operands, the constraints
> > are quite obnoxious to refactor.
> > [...]
> > -             /*
> > -              * Move data from 2 bytes to 3 bytes.
> > -              */
> > -             ".p2align 4\n\t"
> > -             "9:\n\t"
> > -             "cmp $2, %0\n\t"
> > -             "jb 10f\n\t"
> > -             "movw 0*2(%1), %%dx\n\t"
> > -             "movw -1*2(%1, %0), %%bx\n\t"
> > -             "movw %%dx, 0*2(%2)\n\t"
> > -             "movw %%bx, -1*2(%2, %0)\n\t"
> > -             "jmp 11f\n\t"
> > [...]
> > +.set tmp0, %edi
> > [...]
> > +     /*
> > +      * Move data from 2 bytes to 3 bytes.
> > +      */
> > +.p2align 4
> > +.L4_byteswap:
> > +     cmpl    $2, n
> > +     jb      .Lbyteswap
> > +     movw    0*2(src), %di
> > +     movw    -1*2(src, n), %bx
> > +     movw    %dx, 0*2(dest)
> > +     movw    %bx, -1*2(dest, n)
> > +     jmp     .Ldone
>
> Found it (need to use %di instead of %dx). With this changed, the kunit
> test passes again:
>
> diff --git a/arch/x86/lib/memmove_32.S b/arch/x86/lib/memmove_32.S
> index 73314a391a72..9e33c9a1c595 100644
> --- a/arch/x86/lib/memmove_32.S
> +++ b/arch/x86/lib/memmove_32.S
> @@ -179,7 +179,7 @@ SYM_FUNC_START(memmove)
>         jb      .Lbyteswap
>         movw    0*2(src), %di
>         movw    -1*2(src, n), %bx
> -       movw    %dx, 0*2(dest)
> +       movw    %di, 0*2(dest)
>         movw    %bx, -1*2(dest, n)
>         jmp     .Ldone

That was stupid of me, I updated the scratch register operand in the
instruction 2 before the one at issue and forgot to update the operand
for the register in question, breaking the swap.

I'll use .set directives to give these more descriptive names to avoid
such a mistake.

.set tmp0w %di

then use tmp0w everywhere.  I will give names to the remaining
register operands, too.

Off thread, can you show me how to run the kunit tests, please?

Will send a v3 shortly.

>
> -Kees
>
> --
> Kees Cook



-- 
Thanks,
~Nick Desaulniers

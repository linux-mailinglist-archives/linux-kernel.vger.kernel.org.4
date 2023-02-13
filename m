Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEF0693E96
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBMHBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMHBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:01:00 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C06F113EF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:00:56 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id 9so5759096vkq.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cw3Q2nDkJ9Bv8PVsAGDCbfG6m5PVGNiCmox+HLaI3GE=;
        b=qXgprL150OL9B4VJjN93H9lN+jbXJ1nIsMcEhvYQ3EODoACnRLkm5uDPATHWOMJixo
         DrRPLihx6Z3HvpC98A1g/N2LxGYXW59knPSPq+aUYDPri4LHjW7RnrqWCu8GXhXjX2p+
         CgGkySH/C660taFg71aICkmWVwtbkCKlEWwsYw1eFuo+ePQ44uWQW36nR+p3oE7ngyw5
         ZaSK5lnGO//sOwP9x6yyIotta8ZeGcPDpeAx4L3qbBjik2gPqBhy+srZLHvxzSX/4hk8
         D3gQt4Gy6hiy7oRVXNVlUvnmRmmbI+yaD420JPrS3qDG79b6abqpPvEqRwp2+5DzW1ro
         5aXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cw3Q2nDkJ9Bv8PVsAGDCbfG6m5PVGNiCmox+HLaI3GE=;
        b=gU8ZcBKqj0pZAk+M8PVDcRYfySxscYUWN36Pqlje7xKqVJOHujDedmHqu32qX1h/B3
         WNfPbfMMlVpiZv+tbbvJYm41oaGIKT2WqUMxaCKLsqduKw8wcTDOuuj+qZTqSqkWxMgJ
         IK+KSlg4+liPXiKQCSkV9pAwRk3+0MdIfQPkgwBYjiLM0trKyr0AihXEJr3TAvCGo2Tg
         uQpYSMSdTNhRHZOfNRZ0lhFiFenWcLD7J1FhXsjDlXg7jmCvPz2iRKYh7rdo5cna5rSK
         Y5Ow+OP3o+beQr6IFnB1nnVu9yW/ikBX/A7TRKH2dFeQIm8SCdXZ+I0kzHxtNRdqfQEY
         paVw==
X-Gm-Message-State: AO0yUKUXPrGN1xZ5Lf6AMsAKPFbI6xNOwaEC43m9o/z+pbV6XjvsIo/N
        xisuBtBSHlu9kO7cT5BO1RhZtGdieoh3Z6j9Pb9PuA==
X-Google-Smtp-Source: AK7set8PIsvFjgrQwufJLFQT67MNYzMOGV1d7JQLJAehTa092Ya4uJIbrwg+wDH31UncdizZSMR2WGwIMLPKliDCmY4=
X-Received: by 2002:a1f:284e:0:b0:401:42f3:5659 with SMTP id
 o75-20020a1f284e000000b0040142f35659mr1000487vko.44.1676271654615; Sun, 12
 Feb 2023 23:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20230208184203.2260394-1-elver@google.com> <CA+fCnZeU=pRcyiBpj3nyri0ow+ZYp=ewU3dtSVm_6mh73y1NTA@mail.gmail.com>
 <CANpmjNP_Ka6RTqHNRD7xx93ebZhY+iz69GHBusT=A8X1KvViVA@mail.gmail.com>
 <CA+fCnZcNF5kNxNuphwj41P45tQEhQ9wX00ZA4g=KTX4sbUirQg@mail.gmail.com>
 <CANpmjNNH-O+38U6zRWJUCU-eJTfMhUosy==GWEOn1vcu=J2dcw@mail.gmail.com> <CA+fCnZcaNpX6f9fWU2ZU-vMRn1fQ9mkr4w1JyOn3RmmoBK4PmQ@mail.gmail.com>
In-Reply-To: <CA+fCnZcaNpX6f9fWU2ZU-vMRn1fQ9mkr4w1JyOn3RmmoBK4PmQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 13 Feb 2023 08:00:00 +0100
Message-ID: <CANpmjNMdX9gzYEtUpESnFLT-0tPmZhU_GcK-6apW1yA0R2or0A@mail.gmail.com>
Subject: Re: [PATCH -tip] kasan: Emit different calls for instrumentable memintrinsics
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kbuild@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 at 22:37, Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Fri, Feb 10, 2023 at 7:41 PM Marco Elver <elver@google.com> wrote:
> >
> > On Fri, 10 Feb 2023 at 17:13, Andrey Konovalov <andreyknvl@gmail.com> wrote:
> > [...]
> > > > Probably the same should be done for SW_TAGS, because arm64 will be
> > > > GENERIC_ENTRY at one point or another as well.
> > >
> > > Yes, makes sense. I'll file a bug for this once I fully understand the
> > > consequences of these changes.
> > >
> > > > KASAN + GCC on x86 will have no mem*() instrumentation after
> > > > 69d4c0d32186, which is sad, so somebody ought to teach it the same
> > > > param as above.
> > >
> > > Hm, with that patch we would have no KASAN checking within normal mem*
> > > functions (not the ones embedded by the compiler) on GENERIC_ENTRY
> > > arches even with Clang, right?
> >
> > Yes, that's the point - normal mem*() functions cannot be instrumented
> > with GENERIC_ENTRY within noinstr functions, because the compiler
> > sometimes decides to transform normal assignments into
> > memcpy()/memset(). And if mem*() were instrumented (as it was before
> > 69d4c0d32186), that'd break things for these architectures.
> >
> > But since most code is normally instrumented, with the right compiler
> > support (which the patch here enables), we just turn mem*() in
> > instrumented functions into __asan_mem*(), and get the instrumentation
> > as before. 69d4c0d32186 already added those __asan functions. The fact
> > that KASAN used to override mem*() is just the wrong choice in a world
> > where compilers decide to inline or outline these. From an
> > instrumentation point of view at the compiler level, we need to treat
> > them like any other instrumentable instruction (loads, stores,
> > atomics, etc.): transform each instrumentable instruction into
> > something that does the right checks. Only then can we be sure that we
> > don't accidentally instrument something that shouldn't be (noinstr
> > functions), because instead of relying on the compiler, we forced
> > instrumentation on every mem*().
>
> I meant to ask whether the normal mem* calls from instrumented
> functions will also be transformed to __asan_mem*() by the compiler.
> But following the godbolt link you shared, I see that this is true.
>
> Thank you for the explanation!
>
> So the overall negative impact of these changes is that we don't get
> KASAN checking in both normal mem* calls and the ones formed by
> transforming assignments for GENERIC_ENTRY architectures with GCC and
> with older Clang. This is not great. I wonder if we then need to print
> some kind of warning when the kernel is built with these compilers.

Since these changes are already in -tip, and by judging from [1],
there really is no other way. As-is, KASAN on x86 is already broken
per [1] (though we got lucky thus far).

Printing a warning wouldn't hurt, but I think nobody would notice the
warning, and if somebody notices, they wouldn't care. Sooner or later,
we just need to make sure that test robots (syzbot, etc.) have new
compilers.

> If these changes move forward, AFAIU, we can also drop these custom
> mem* definitions for non-instrumented files for x86:
>
> https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/string_64.h#L88

Yes, I think so.

[1] https://lore.kernel.org/all/20230112194314.845371875@infradead.org/

Last but not least are you ok with this patch? This patch ought to be
applied to the same tree as 69d4c0d32186 anyway, so this patch lives
or dies by that change.

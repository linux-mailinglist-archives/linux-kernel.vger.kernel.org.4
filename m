Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71991692961
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjBJVhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjBJVhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:37:13 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618045FE44;
        Fri, 10 Feb 2023 13:37:11 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id s89-20020a17090a2f6200b0023125ebb4b1so6807694pjd.3;
        Fri, 10 Feb 2023 13:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vdG7jpPdQQ/bqJN4zEtXLDG93Zy6CAZv4n243xZFPTc=;
        b=Wel3VrAbkGdGKdXmjGHWsrgMNSaeJ/xOopiIfXB7sK8easZ6HaATbNAN7b2/95UVj1
         RhG1AuIpdldyrRfvLajBB/tEAb/+/BCugGPwxBtOINTgz6ICP+JPzowkLdWKJr5Xxkh5
         A4rEvJyPjn2NbLpQ/ib0jKOgCI0j6dzzsO/Wlh2j/4om9acd7MjeYOMC23ne9zdM2IH7
         IjShiYNvb5jHvqZkbHquyWdQdNYHVQVVq63vNVf01yzb1YUazzSaxSaSH4DlbHJ7zClk
         Ctpfye8bjm6dvaXIesVqOc0eFW6BYc4jIl8fspzaD4ZdBS/YiC0vpNW1wF6e0SmaAxCQ
         qrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdG7jpPdQQ/bqJN4zEtXLDG93Zy6CAZv4n243xZFPTc=;
        b=u0sv4pSO3MqK9/Ii6hkuJxOzMCiO/XekzgPJohZ8ITy/o9aYezKY+TUSWbp7hmQuqD
         zEmg+mpRMmNxK565S6fnilrxK5IJmXalPLIrfVvVHPkHkp0mLRUaDPT8cqLoFw7fi2TQ
         DO914e6yBQm7chO/yvxn1d5FGaPavYjNxDIY/WwnfrHmcM6cooA19ePwczSJgOU2yaB+
         mw8wxredkFiYrFlk6QH99xvK/eGGw/H0iaF8t/U81i5B8/GlMfGutFqOCfospaPYmpGb
         iIiFBpeK+rIWo/vw3bTNWvYjb2ruwNqPGU68XYXmMoJ3EH+1R56JmZRrqRTa+SdNFGWg
         ZCGA==
X-Gm-Message-State: AO0yUKWFPteve0+/0MRSaYwSTxcuS3/2xLJe1sn7Ixv/xdM/dRG915nm
        +XJuL5Kw3ia2NX89MsFD1JewP4QtvvpI9jOJKThQIviS2zXBAg==
X-Google-Smtp-Source: AK7set8KQJmAQJUSanRIbn6OrK2h5nzXnrH5C4OypLWJ/WQga98LPNGMDRYFpK6+mBPPb2VOjxzDxN3ikGhiAfdBqHY=
X-Received: by 2002:a17:90a:d310:b0:233:c521:271f with SMTP id
 p16-20020a17090ad31000b00233c521271fmr84307pju.139.1676065030767; Fri, 10 Feb
 2023 13:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20230208184203.2260394-1-elver@google.com> <CA+fCnZeU=pRcyiBpj3nyri0ow+ZYp=ewU3dtSVm_6mh73y1NTA@mail.gmail.com>
 <CANpmjNP_Ka6RTqHNRD7xx93ebZhY+iz69GHBusT=A8X1KvViVA@mail.gmail.com>
 <CA+fCnZcNF5kNxNuphwj41P45tQEhQ9wX00ZA4g=KTX4sbUirQg@mail.gmail.com> <CANpmjNNH-O+38U6zRWJUCU-eJTfMhUosy==GWEOn1vcu=J2dcw@mail.gmail.com>
In-Reply-To: <CANpmjNNH-O+38U6zRWJUCU-eJTfMhUosy==GWEOn1vcu=J2dcw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 10 Feb 2023 22:36:59 +0100
Message-ID: <CA+fCnZcaNpX6f9fWU2ZU-vMRn1fQ9mkr4w1JyOn3RmmoBK4PmQ@mail.gmail.com>
Subject: Re: [PATCH -tip] kasan: Emit different calls for instrumentable memintrinsics
To:     Marco Elver <elver@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 7:41 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, 10 Feb 2023 at 17:13, Andrey Konovalov <andreyknvl@gmail.com> wrote:
> [...]
> > > Probably the same should be done for SW_TAGS, because arm64 will be
> > > GENERIC_ENTRY at one point or another as well.
> >
> > Yes, makes sense. I'll file a bug for this once I fully understand the
> > consequences of these changes.
> >
> > > KASAN + GCC on x86 will have no mem*() instrumentation after
> > > 69d4c0d32186, which is sad, so somebody ought to teach it the same
> > > param as above.
> >
> > Hm, with that patch we would have no KASAN checking within normal mem*
> > functions (not the ones embedded by the compiler) on GENERIC_ENTRY
> > arches even with Clang, right?
>
> Yes, that's the point - normal mem*() functions cannot be instrumented
> with GENERIC_ENTRY within noinstr functions, because the compiler
> sometimes decides to transform normal assignments into
> memcpy()/memset(). And if mem*() were instrumented (as it was before
> 69d4c0d32186), that'd break things for these architectures.
>
> But since most code is normally instrumented, with the right compiler
> support (which the patch here enables), we just turn mem*() in
> instrumented functions into __asan_mem*(), and get the instrumentation
> as before. 69d4c0d32186 already added those __asan functions. The fact
> that KASAN used to override mem*() is just the wrong choice in a world
> where compilers decide to inline or outline these. From an
> instrumentation point of view at the compiler level, we need to treat
> them like any other instrumentable instruction (loads, stores,
> atomics, etc.): transform each instrumentable instruction into
> something that does the right checks. Only then can we be sure that we
> don't accidentally instrument something that shouldn't be (noinstr
> functions), because instead of relying on the compiler, we forced
> instrumentation on every mem*().

I meant to ask whether the normal mem* calls from instrumented
functions will also be transformed to __asan_mem*() by the compiler.
But following the godbolt link you shared, I see that this is true.

Thank you for the explanation!

So the overall negative impact of these changes is that we don't get
KASAN checking in both normal mem* calls and the ones formed by
transforming assignments for GENERIC_ENTRY architectures with GCC and
with older Clang. This is not great. I wonder if we then need to print
some kind of warning when the kernel is built with these compilers.

If these changes move forward, AFAIU, we can also drop these custom
mem* definitions for non-instrumented files for x86:

https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/string_64.h#L88

Thanks!

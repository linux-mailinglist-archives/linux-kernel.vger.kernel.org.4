Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3FC6914A7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjBIXge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjBIXgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:36:17 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A846D8CA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 15:35:37 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-4c24993965eso46263097b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 15:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E3YfaKNVl2yQShNL4EAUThiXwGLjN3/+eFNVq1mrd+o=;
        b=KKm34kjzFdKs9ylAAOO5dxpyvVi621GkVn85UrRvKHXdOZMPEvXcCu7laq5RU6IhL+
         O8w9o/npc/sxu8tZ2ETGG7RnUfoTia/Q4QTAx5fOnBY19yjUTl+uis9Z5zfvyDZjYl/t
         MsEBP5KmZdQEx7nAfb1ba7uYQHFdggZFoDQ0hNmKsmO8rSmER8nlM71VNT7Zc3tRti27
         2Gg4ZOF33PyjciB4UUo2kSUHKpkP1JNgVNwUdoUhhJ7GERBGdvxceMF8WVp5SORjc7oz
         FsiUBQqke9bK7+n+7UJoW0oWMI7awzTpgWsG1FZEhNfLYkg/bY3ARjukyHNi8N5+k9BX
         brew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3YfaKNVl2yQShNL4EAUThiXwGLjN3/+eFNVq1mrd+o=;
        b=y+98ueKHQ63q6LBlRtoWgdsnVqwroeQfVeN90ngj0LoHNXg+F0XRgS5zVAXJbIL6bG
         1XK8KW/NgcwSylB+UiU2FGprcMMFAP5z9NVbB8azERuL4F13mUA/MGQtSr4/FiJHJ24B
         OFnziYxDgSyfsnirlorUy7rzcG6rjmUnTxBK+TBKXTgHYRPjFeHonHXvJW959P42Z30o
         DC+zl1VWi2Yw3Rj5NHUNQWeK7vIiCisGdQ+aDRfWohivjCWUVHRAC+IxP0s/Iw6vq5Q8
         JJY5rumN5vB44OHzfgtBYFdH2W1SoHYL7a8l54bqHibQPw8oreLyuI4gS7eUY9Pg+/bK
         /nyg==
X-Gm-Message-State: AO0yUKXQlPbzW/ivWn8iByVzkuGhbhnt2mXwZbtCuz/szBWw0FjAliII
        YypXZ9AC+A7oJlCmROhQmzsyOR4H62EppdKFx4Nx6Q==
X-Google-Smtp-Source: AK7set+Pu8P2MLAAhgY/qe2gk0TWUQkshaxRSaoEXuuHO+2AWOBZUjU0Nbfh+s3Nxg0SRAUYMIYN+RoKyv4J4AQ9HpE=
X-Received: by 2002:a0d:c906:0:b0:526:8ea9:49bd with SMTP id
 l6-20020a0dc906000000b005268ea949bdmr1250620ywd.339.1675985735029; Thu, 09
 Feb 2023 15:35:35 -0800 (PST)
MIME-Version: 1.0
References: <20230208184203.2260394-1-elver@google.com> <CA+fCnZeU=pRcyiBpj3nyri0ow+ZYp=ewU3dtSVm_6mh73y1NTA@mail.gmail.com>
In-Reply-To: <CA+fCnZeU=pRcyiBpj3nyri0ow+ZYp=ewU3dtSVm_6mh73y1NTA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 10 Feb 2023 00:34:58 +0100
Message-ID: <CANpmjNP_Ka6RTqHNRD7xx93ebZhY+iz69GHBusT=A8X1KvViVA@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2023 at 23:43, Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Wed, Feb 8, 2023 at 7:42 PM Marco Elver <elver@google.com> wrote:
> >
> > Clang 15 will provide an option to prefix calls to memcpy/memset/memmove
> > with __asan_ in instrumented functions: https://reviews.llvm.org/D122724
>
> Hi Marco,
>
> Does this option affect all functions or only the ones that are marked
> with no_sanitize?

Only functions that are instrumented, i.e. wherever
fsanitize=kernel-address inserts instrumentation.

> Based on the LLVM patch description, should we also change the normal
> memcpy/memset/memmove to be noninstrumented?

They are no longer instrumented as of 69d4c0d32186 (for
CONFIG_GENERIC_ENTRY arches).

> These __asan_mem* functions are not defined in the kernel AFAICS.
> Should we add them?

Peter introduced them in 69d4c0d32186, and we effectively have no
mem*() instrumentation on x86 w/o the compiler-enablement patch here.

> Or maybe we should just use "__" as the prefix, as right now __mem*
> functions are the ones that are not instrumented?

__asan_mem* is for instrumented code, just like ASan userspace does
(actually ASan userspace has been doing it like this forever, just the
kernel was somehow special).

[...]
> > Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >
> > The Fixes tag is just there to show the dependency, and that people
> > shouldn't apply this patch without 69d4c0d32186.

^^^ Depends on this commit, which is only in -tip.

> > +ifdef CONFIG_GENERIC_ENTRY

It also only affects GENERIC_ENTRY arches.

> > +# Instrument memcpy/memset/memmove calls by using instrumented __asan_mem*()
> > +# instead. With compilers that don't support this option, compiler-inserted
> > +# memintrinsics won't be checked by KASAN.
> > +CFLAGS_KASAN += $(call cc-param,asan-kernel-mem-intrinsic-prefix)
> > +endif

Probably the same should be done for SW_TAGS, because arm64 will be
GENERIC_ENTRY at one point or another as well.

KASAN + GCC on x86 will have no mem*() instrumentation after
69d4c0d32186, which is sad, so somebody ought to teach it the same
param as above.

Thanks,
-- Marco

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9191D6913A1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjBIWno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjBIWnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:43:19 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF71188;
        Thu,  9 Feb 2023 14:43:17 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id s89-20020a17090a2f6200b0023125ebb4b1so3758010pjd.3;
        Thu, 09 Feb 2023 14:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zptQebfexw7ADz0p1vyYhnhBqZ69swmuxOP2gn0h68k=;
        b=C2Raiuj9IFUwIbhnGgLmIloYo36QDBax9jsSAruPNUZBziAE/trNC3SorI7xMtAYWx
         fdBcq+//eABAEhGM63hvCQq3YoHaY6Sh0LSGidPgx2qF91NL//LZ6uFKPLXI8oLArIST
         Jh/r+NoGA3YmBujbBifKaTaLqhhCklFE8ZhDJl1lEvUilU8C6jLaux394w2RTQbGrRDk
         iGnZ8l4gTIT3c0Cs+Ali1kPSlal/Kkex9fiqYeMia9YHRnGGS3UhF2fH/jIazDC3S0Cs
         KoFBNBR3pbQKgS5Gcm+Zv2AT8KQIUXrlOqUXlax1u2MmUDOsyfsaeGJo/gTlNqhg82Nv
         UcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zptQebfexw7ADz0p1vyYhnhBqZ69swmuxOP2gn0h68k=;
        b=sr2I8WSzHDBcKUxwXRBG6ck7wFB5Oe10zRkL6gHP1jfIkyKf4uzpuTnk2QYaPY5dyc
         6/yyYM+BlNP6dapMwZYz4yMEICAOwInRaxookpvi6qyOBU8Z40mO11p5VwQKmT79xvC4
         GSiJCucNS9G6JfG8OGCcTE3K5XVUA5pwhBe1dy9S4RaWzpQ3t7e4uhlHEH/LpoxqOhO/
         HWBGHgMi/Zyj8J9FUnkk53D+7QJDSvLAnc8RpA3Xak1vZYHsc27CvPPlkpCsDXwurrPC
         ZxEJXfJ8t3Qm1rnM5w8W7NXjFJKrqijr4Eyy9eewqdI+3Tj5hAa4I0rrxp9nYXNh5ovl
         kHVA==
X-Gm-Message-State: AO0yUKW/lxSYbqA4YX5ly0i0wCOBZ42RzZ+YZzveTPBWyi15c7Dj3bqE
        fqHZ5oqXjTTKCNR8Lr3NEN1dH9eRf3mM2cVfsN4tNDh45w0yXw==
X-Google-Smtp-Source: AK7set/x2t0GTSkMGOB9YiHaJ8Im/tziGOqDwT6L+THb+YdhQwHBZeiuSv0HmKdSgKVaDHVvjjvOOp9JVF+17ec38zU=
X-Received: by 2002:a17:90a:764d:b0:232:ccdc:2687 with SMTP id
 s13-20020a17090a764d00b00232ccdc2687mr955780pjl.100.1675982597028; Thu, 09
 Feb 2023 14:43:17 -0800 (PST)
MIME-Version: 1.0
References: <20230208184203.2260394-1-elver@google.com>
In-Reply-To: <20230208184203.2260394-1-elver@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 9 Feb 2023 23:43:05 +0100
Message-ID: <CA+fCnZeU=pRcyiBpj3nyri0ow+ZYp=ewU3dtSVm_6mh73y1NTA@mail.gmail.com>
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
        linux-toolchains@vger.kernel.org
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

On Wed, Feb 8, 2023 at 7:42 PM Marco Elver <elver@google.com> wrote:
>
> Clang 15 will provide an option to prefix calls to memcpy/memset/memmove
> with __asan_ in instrumented functions: https://reviews.llvm.org/D122724

Hi Marco,

Does this option affect all functions or only the ones that are marked
with no_sanitize?

Based on the LLVM patch description, should we also change the normal
memcpy/memset/memmove to be noninstrumented?

These __asan_mem* functions are not defined in the kernel AFAICS.
Should we add them?

Or maybe we should just use "__" as the prefix, as right now __mem*
functions are the ones that are not instrumented?

Thanks!

> GCC does not yet have similar support.
>
> Use it to regain KASAN instrumentation of memcpy/memset/memmove on
> architectures that require noinstr to be really free from instrumented
> mem*() functions (all GENERIC_ENTRY architectures).
>
> Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>
> The Fixes tag is just there to show the dependency, and that people
> shouldn't apply this patch without 69d4c0d32186.
>
> ---
>  scripts/Makefile.kasan | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> index b9e94c5e7097..78336b04c077 100644
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -38,6 +38,13 @@ endif
>
>  CFLAGS_KASAN += $(call cc-param,asan-stack=$(stack_enable))
>
> +ifdef CONFIG_GENERIC_ENTRY
> +# Instrument memcpy/memset/memmove calls by using instrumented __asan_mem*()
> +# instead. With compilers that don't support this option, compiler-inserted
> +# memintrinsics won't be checked by KASAN.
> +CFLAGS_KASAN += $(call cc-param,asan-kernel-mem-intrinsic-prefix)
> +endif
> +
>  endif # CONFIG_KASAN_GENERIC
>
>  ifdef CONFIG_KASAN_SW_TAGS
> --
> 2.39.1.519.gcb327c4b5f-goog
>

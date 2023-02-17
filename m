Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFD669A9C1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjBQLIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjBQLH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:07:56 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A887644E3;
        Fri, 17 Feb 2023 03:07:32 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id q5-20020a17090a1b0500b00229ca6a4636so1038414pjq.0;
        Fri, 17 Feb 2023 03:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/jA5JR6jmFA0atOq1lU4NeFnNlRF/LnXa1fUxjSCz8E=;
        b=EnMJ6h80J1qErLPgZlJpTRGkCcps7n7R6o6IDgCd6BjfWC0YCoCqAs5fXUKlWEiLXD
         dBc3kmBsiERY/pncllqOOLxkf/U6psaujOjaqzO5UOmF3xxwwIIzOSJa2GL59mDztLGX
         2zp79Q2XPNlnL3pzmquol44icIE9JvZXLZRDYMga/Boz+6YSJCLOhBAIiHhKf5kW5Ud+
         xiDg/hIK9HvHYpxowjZFYBPkdTvOHw6neAvWR9q2ghcFKUvKPpHiOMeHSDPKq2e7dRRm
         RbGTzRA0Da+3LbC2Pcz4xb0g1q2aKEUbcQyYtETfHv9bmfudt1G0NZG38AKd7vftnefS
         FCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jA5JR6jmFA0atOq1lU4NeFnNlRF/LnXa1fUxjSCz8E=;
        b=EEV953o+nF2ouzFUKD41ZqxCm23iyvsh7cce7XmfQCDWhusTtXufGsWFmC1I12Mz+p
         6bX0yfv2t1f0W7MtBsJflWgyWvS5jjSOOc2YA5owQg4TIkHhZnJm3zl1EFwVlLmgD6tE
         60B0JKhxbz6De6+fW3UUipgdxqKtJR0Cu60kMmqnGQISmhs9YQgCJWLdqZ+jllBuSLEU
         BftV+Sy8ABvC7g93G04BM5OAVrwPwMhD+KsbHgpEId+Gi1eySYrx9pAnnnsWC3hvqz0r
         LQJ80catL3S0EvBVqLkmrlw7tx8Hcdth2/C8Ds4oCqVVp8XdV2ZsdaCWoIiUF1zBsKJy
         A3KQ==
X-Gm-Message-State: AO0yUKWWqPXeqO/py4LwfIivAOVdkAinjRxMJU9DaJZ2U6D2S06n8O2p
        MvBUZAyQbVgomg833UBiTYvCvSDMiVBVuwWWs5s=
X-Google-Smtp-Source: AK7set+L0zxQe7K8kbt2mwqElUnWRrsxvWMtas/LO1yjyT7i770qq8v6uZe1XDlAVHcS7O+dKR9ymQH5E0gZaVla91c=
X-Received: by 2002:a17:90b:1f8f:b0:233:3c5a:b41b with SMTP id
 so15-20020a17090b1f8f00b002333c5ab41bmr1428932pjb.133.1676632051210; Fri, 17
 Feb 2023 03:07:31 -0800 (PST)
MIME-Version: 1.0
References: <20230216234522.3757369-1-elver@google.com> <20230216234522.3757369-2-elver@google.com>
In-Reply-To: <20230216234522.3757369-2-elver@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 17 Feb 2023 12:07:20 +0100
Message-ID: <CA+fCnZehvF1o4rQJah=SXaS-AXWs--h2CDaUca-hJK=ZTD8kTg@mail.gmail.com>
Subject: Re: [PATCH -tip v4 2/3] kasan: Treat meminstrinsic as builtins in
 uninstrumented files
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        linux-toolchains@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kbuild@vger.kernel.org
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

On Fri, Feb 17, 2023 at 12:45 AM Marco Elver <elver@google.com> wrote:
>
> Where the compiler instruments meminstrinsics by generating calls to
> __asan/__hwasan_ prefixed functions, let the compiler consider
> memintrinsics as builtin again.
>
> To do so, never override memset/memmove/memcpy if the compiler does the
> correct instrumentation - even on !GENERIC_ENTRY architectures.
>
> Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v4:
> * New patch.
> ---
>  lib/Kconfig.kasan      | 9 +++++++++
>  mm/kasan/shadow.c      | 5 ++++-
>  scripts/Makefile.kasan | 9 +++++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index be6ee6020290..fdca89c05745 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -49,6 +49,15 @@ menuconfig KASAN
>
>  if KASAN
>
> +config CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> +       def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=kernel-address -mllvm -asan-kernel-mem-intrinsic-prefix=1)) || \
> +                (CC_IS_GCC && $(cc-option,-fsanitize=kernel-address --param asan-kernel-mem-intrinsic-prefix=1))
> +       # Don't define it if we don't need it: compilation of the test uses
> +       # this variable to decide how the compiler should treat builtins.
> +       depends on !KASAN_HW_TAGS
> +       help
> +         The compiler is able to prefix memintrinsics with __asan or __hwasan.
> +
>  choice
>         prompt "KASAN mode"
>         default KASAN_GENERIC
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index f8a47cb299cb..43b6a59c8b54 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -38,11 +38,14 @@ bool __kasan_check_write(const volatile void *p, unsigned int size)
>  }
>  EXPORT_SYMBOL(__kasan_check_write);
>
> -#ifndef CONFIG_GENERIC_ENTRY
> +#if !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) && !defined(CONFIG_GENERIC_ENTRY)
>  /*
>   * CONFIG_GENERIC_ENTRY relies on compiler emitted mem*() calls to not be
>   * instrumented. KASAN enabled toolchains should emit __asan_mem*() functions
>   * for the sites they want to instrument.
> + *
> + * If we have a compiler that can instrument meminstrinsics, never override
> + * these, so that non-instrumented files can safely consider them as builtins.
>   */
>  #undef memset
>  void *memset(void *addr, int c, size_t len)
> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> index fa9f836f8039..c186110ffa20 100644
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -1,5 +1,14 @@
>  # SPDX-License-Identifier: GPL-2.0
> +
> +ifdef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> +# Safe for compiler to generate meminstrinsic calls in uninstrumented files.
> +CFLAGS_KASAN_NOSANITIZE :=
> +else
> +# Don't let compiler generate memintrinsic calls in uninstrumented files
> +# because they are instrumented.
>  CFLAGS_KASAN_NOSANITIZE := -fno-builtin
> +endif
> +
>  KASAN_SHADOW_OFFSET ?= $(CONFIG_KASAN_SHADOW_OFFSET)
>
>  cc-param = $(call cc-option, -mllvm -$(1), $(call cc-option, --param $(1)))
> --
> 2.39.2.637.g21b0678d19-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Is it also safe to remove custom mem* definitions from
arch/x86/include/asm/string_64.h now?

https://elixir.bootlin.com/linux/v6.2-rc8/source/arch/x86/include/asm/string_64.h#L88

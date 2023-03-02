Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EB96A80E4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjCBLPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjCBLOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:14:52 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5DB24492
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:14:16 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id f23so21984023vsa.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 03:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zAvzWwN+/2QX88rMyJtxLyzDNIZ57vJV9SRYMAd7t2o=;
        b=BGi2q0M3pQsp3P3WersOoyDXsJStcmtz+k5/jVmmLRuDUMvGGFq2LDS/TfwEwx9/Sc
         /9CglYjDfSOqxZj851kObQnWeyg+4aXpNz5GslfGq7N2qWUduKLNhREXHc31k7nW7UwC
         BFO3NXyl8trKTo6kcgu8CeHWXUiHfHZN4sRPi10dNnsqXm4VVcya4MRZcGGjqsvRGvTa
         S5N7qlicPeph9b47V4s+0MWoZDG24SrnrQ988wFilBuQaNARtpgjhL/dSC93PouxFkO2
         /VsWdKWgECr11t2rvecrvoZdRY9bnQA/IlZPKwq5kYH82UpoAU1vZR6D2J52OUHG383T
         MzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAvzWwN+/2QX88rMyJtxLyzDNIZ57vJV9SRYMAd7t2o=;
        b=WejkhgqLYQ4F+P/04RdEu9+HoD+ejFGSktgJqEg5YVjP4wC5raaBBbxHFpJukechf5
         Z4yxHefbba29kpsLct/htO3BKT5Ct2dyfU3joCBtCU6TN0Vet7BiXkV7nALgGTwUU3yI
         eq03PAkBCj9vkxSdKZfnAqdKssumFoZtsur7kmCCKUST5GJL7bJIb4WUOgjgJ2lRhdSJ
         J24Va4AzB9zNwcvsRMwHiJlvNdYMY/xnqqAVTqVctKFk8SJalWjEG6KZJ05B43uWQbBI
         buILL7R5/NbPMPDw01rMJO5M35Ncy4RU0rutyWUDv+RKSZUEEEu2gZGHiV/+STMffAcz
         vBlA==
X-Gm-Message-State: AO0yUKXMZjk2xPkGFFQCX/8J0WIsDytt2gmV5L3RtNfAO1Q/EocVfKE0
        pFrR+8A9LZYy2zAw6Cp0A6lsXk5ZEdMoy1RejlTWHg==
X-Google-Smtp-Source: AK7set9Hu0kf0ZyhwGcskogvHsCUbxn/OdsfErH/TtpN8lai7RAv9kPElZ9zp70cZIRWF8ix0H8+23FkRAol2ihBINc=
X-Received: by 2002:a67:f311:0:b0:402:9b84:1be2 with SMTP id
 p17-20020a67f311000000b004029b841be2mr6391648vsf.4.1677755644783; Thu, 02 Mar
 2023 03:14:04 -0800 (PST)
MIME-Version: 1.0
References: <20230301143933.2374658-1-glider@google.com>
In-Reply-To: <20230301143933.2374658-1-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 2 Mar 2023 12:13:28 +0100
Message-ID: <CANpmjNMR5ExTdo+EiLs=_b0M=SpN_gKAZTbSZmyfWFpBh4kN-w@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86: kmsan: Don't rename memintrinsics in
 uninstrumented files
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foundation.org, dvyukov@google.com, nathan@kernel.org,
        ndesaulniers@google.com, kasan-dev@googlegroups.com,
        Kees Cook <keescook@chromium.org>
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

On Wed, 1 Mar 2023 at 15:39, Alexander Potapenko <glider@google.com> wrote:
>
> KMSAN should be overriding calls to memset/memcpy/memmove and their

You mean that the compiler will override calls?
All supported compilers that have fsanitize=kernel-memory replace
memintrinsics with __msan_mem*() calls, right?

> __builtin_ versions in instrumented files, so there is no need to
> override them. In non-instrumented versions we are now required to
> leave memset() and friends intact, so we cannot replace them with
> __msan_XXX() functions.
>
> Cc: Kees Cook <keescook@chromium.org>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Other than that,

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  arch/x86/include/asm/string_64.h | 17 -----------------
>  1 file changed, 17 deletions(-)
>
> diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
> index 888731ccf1f67..9be401d971a99 100644
> --- a/arch/x86/include/asm/string_64.h
> +++ b/arch/x86/include/asm/string_64.h
> @@ -15,22 +15,11 @@
>  #endif
>
>  #define __HAVE_ARCH_MEMCPY 1
> -#if defined(__SANITIZE_MEMORY__) && defined(__NO_FORTIFY)
> -#undef memcpy
> -#define memcpy __msan_memcpy
> -#else
>  extern void *memcpy(void *to, const void *from, size_t len);
> -#endif
>  extern void *__memcpy(void *to, const void *from, size_t len);
>
>  #define __HAVE_ARCH_MEMSET
> -#if defined(__SANITIZE_MEMORY__) && defined(__NO_FORTIFY)
> -extern void *__msan_memset(void *s, int c, size_t n);
> -#undef memset
> -#define memset __msan_memset
> -#else
>  void *memset(void *s, int c, size_t n);
> -#endif
>  void *__memset(void *s, int c, size_t n);
>
>  #define __HAVE_ARCH_MEMSET16
> @@ -70,13 +59,7 @@ static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
>  }
>
>  #define __HAVE_ARCH_MEMMOVE
> -#if defined(__SANITIZE_MEMORY__) && defined(__NO_FORTIFY)
> -#undef memmove
> -void *__msan_memmove(void *dest, const void *src, size_t len);
> -#define memmove __msan_memmove
> -#else
>  void *memmove(void *dest, const void *src, size_t count);
> -#endif
>  void *__memmove(void *dest, const void *src, size_t count);
>
>  int memcmp(const void *cs, const void *ct, size_t count);
> --
> 2.39.2.722.g9855ee24e9-goog
>

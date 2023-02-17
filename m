Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E28669A9BF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjBQLIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjBQLHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:07:53 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FA0642F2;
        Fri, 17 Feb 2023 03:07:26 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cp18so2705901pjb.0;
        Fri, 17 Feb 2023 03:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QZTCpwoqSxAuHWQ6Ualf+NSmhnZey5ULzRU2vpqw9C0=;
        b=qZoB6rRnFYOY7dryuDkENPi95+rHGBcbjSiPeGYSwwaIMKwGvzOL8gFCfeccKmvvUe
         VCOrN+aWxyswoIM+nJ9ByeSKhP1Qn6OeTmiyKV3QstDycY6Eyde2EZhjYXEkA11sUBdY
         2PJ4RvE0WTPJYv7wbsUtn3PJDuw/qYUjIECmCKHD7tT594wDF5orRAiCCJpkh8JNLvGg
         SxDRIMXKBMyQA/Bky4Pr19xUkzaF/0oQ+pJrg96SBlPTBTpNFa6stJQwphW9fHO3vic/
         j05wXTtO2RfLi6p2i6yz6PXy3fwqLN2+VFBZAjMrQf/8RAlit1JV745byRDm6cjFccrX
         rCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZTCpwoqSxAuHWQ6Ualf+NSmhnZey5ULzRU2vpqw9C0=;
        b=qOgyPw+54Il761nQNGXGSsX7gsaBam+BqN71vcEedXfJWIhwrb5YmJz0mocZrTNM/N
         OKWwie0F/naw7s6YaNVkNBx4zAaeBG7jkY/x6/EbHfnjHFYXtGTT9ubanR7HWsXjnAIA
         oDHJe4SdlbBhCFdToVBepUdvnxlul4eLF+U15r9uVZshI0M0JB9fGqjaFoQ5WUUvJAhd
         DCBc8wltTC/ujg0K8Aqmmm5z8mQFXJhiVGTAs1eXj5GtqEgiEWsTFDA8l3N6C59gE070
         +SSkUuX0OcHXS/7BuDYajGYujg3CRF/kV1bWtZ/dsvv7RscI4wExTdcegtWnI8aiKsP1
         lJoA==
X-Gm-Message-State: AO0yUKUv1DKxlFW+cFxcVVcCO88yNWDjPfx/EVFOKASWwe5n7sGc/sgI
        HYmixBxVl5e/mKEOmJFSxBCWOd+1EJfo74Jt+q8=
X-Google-Smtp-Source: AK7set+OctLbWFyx5cca3jqHlyQ/eW4S7hLEL2flbX6wuF24mitWOag4ez7LaEr+2z2Sf1CgfI7KR9byU3gyzzjw10w=
X-Received: by 2002:a17:90b:1f8f:b0:233:3c5a:b41b with SMTP id
 so15-20020a17090b1f8f00b002333c5ab41bmr1428877pjb.133.1676632046068; Fri, 17
 Feb 2023 03:07:26 -0800 (PST)
MIME-Version: 1.0
References: <20230216234522.3757369-1-elver@google.com>
In-Reply-To: <20230216234522.3757369-1-elver@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 17 Feb 2023 12:07:15 +0100
Message-ID: <CA+fCnZdrHz12Rs9WYPwdL4DgBu+7ufsZ0iMAUaWNXxvrszHGMg@mail.gmail.com>
Subject: Re: [PATCH -tip v4 1/3] kasan: Emit different calls for
 instrumentable memintrinsics
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
> Clang 15 provides an option to prefix memcpy/memset/memmove calls with
> __asan_/__hwasan_ in instrumented functions: https://reviews.llvm.org/D122724
>
> GCC will add support in future:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108777
>
> Use it to regain KASAN instrumentation of memcpy/memset/memmove on
> architectures that require noinstr to be really free from instrumented
> mem*() functions (all GENERIC_ENTRY architectures).
>
> Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
> Signed-off-by: Marco Elver <elver@google.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> v4:
> * Also enable it for KASAN_SW_TAGS (__hwasan_mem*).
>
> v3:
> * No change.
>
> v2:
> * Use asan-kernel-mem-intrinsic-prefix=1, so that once GCC supports the
>   param, it also works there (it needs the =1).
>
> The Fixes tag is just there to show the dependency, and that people
> shouldn't apply this patch without 69d4c0d32186.
> ---
>  mm/kasan/kasan.h       |  4 ++++
>  mm/kasan/shadow.c      | 11 +++++++++++
>  scripts/Makefile.kasan |  8 ++++++++
>  3 files changed, 23 insertions(+)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 71c15438afcf..172713b87556 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -637,4 +637,8 @@ void __hwasan_storeN_noabort(unsigned long addr, size_t size);
>
>  void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size);
>
> +void *__hwasan_memset(void *addr, int c, size_t len);
> +void *__hwasan_memmove(void *dest, const void *src, size_t len);
> +void *__hwasan_memcpy(void *dest, const void *src, size_t len);
> +
>  #endif /* __MM_KASAN_KASAN_H */
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 98269936a5e4..f8a47cb299cb 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -107,6 +107,17 @@ void *__asan_memcpy(void *dest, const void *src, size_t len)
>  }
>  EXPORT_SYMBOL(__asan_memcpy);
>
> +#ifdef CONFIG_KASAN_SW_TAGS
> +void *__hwasan_memset(void *addr, int c, size_t len) __alias(__asan_memset);
> +EXPORT_SYMBOL(__hwasan_memset);
> +#ifdef __HAVE_ARCH_MEMMOVE
> +void *__hwasan_memmove(void *dest, const void *src, size_t len) __alias(__asan_memmove);
> +EXPORT_SYMBOL(__hwasan_memmove);
> +#endif
> +void *__hwasan_memcpy(void *dest, const void *src, size_t len) __alias(__asan_memcpy);
> +EXPORT_SYMBOL(__hwasan_memcpy);
> +#endif
> +
>  void kasan_poison(const void *addr, size_t size, u8 value, bool init)
>  {
>         void *shadow_start, *shadow_end;
> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> index b9e94c5e7097..fa9f836f8039 100644
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -38,6 +38,11 @@ endif
>
>  CFLAGS_KASAN += $(call cc-param,asan-stack=$(stack_enable))
>
> +# Instrument memcpy/memset/memmove calls by using instrumented __asan_mem*()
> +# instead. With compilers that don't support this option, compiler-inserted
> +# memintrinsics won't be checked by KASAN on GENERIC_ENTRY architectures.
> +CFLAGS_KASAN += $(call cc-param,asan-kernel-mem-intrinsic-prefix=1)
> +
>  endif # CONFIG_KASAN_GENERIC
>
>  ifdef CONFIG_KASAN_SW_TAGS
> @@ -54,6 +59,9 @@ CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
>                 $(call cc-param,hwasan-inline-all-checks=0) \
>                 $(instrumentation_flags)
>
> +# Instrument memcpy/memset/memmove calls by using instrumented __hwasan_mem*().
> +CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
> +
>  endif # CONFIG_KASAN_SW_TAGS
>
>  export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE
> --
> 2.39.2.637.g21b0678d19-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

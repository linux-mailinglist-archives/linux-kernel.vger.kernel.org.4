Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1503F69AC30
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBQNKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBQNKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:10:41 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498B66A07D;
        Fri, 17 Feb 2023 05:10:40 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q15so1936666plx.13;
        Fri, 17 Feb 2023 05:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sIFlAqUfSEj1u08jK3w+qv2YAspHGSL2922Yed+agrA=;
        b=dC0eKp2BWvkVEGjSsfxVq2Kj1I5ANw72HvFPQV6u0K1jU4fjdVKr+HEc2yS9df18kf
         dwSzjgNNGGpPZbL1j7BEElKSckqzOzf1nAWpMPSe3KWBwmTHU8cpdj1yiBKz+iXdJkXL
         i5pX8K6EXhRT+jKdBj0iATVPhYFJgREvCoYvT7Xf9VoWnZhUtsQdZcIXi7d+IlEsZg08
         S1q6qDDY4o5j34LDSWGs6HjSnDp0YfalKuuN5+SYcn3qA9xBP7nO2YL3/JIzvUDEHxWD
         CO4wm/O0L7brD8HvKNQ+2gycENysb2JjNYYuUdJtv3llkHUCQfKz8XmtuMF5pa19c4bU
         NWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIFlAqUfSEj1u08jK3w+qv2YAspHGSL2922Yed+agrA=;
        b=DTqAu3mVu1G+0QvFSsakh++84nhr1a5/RhwO7LTgYT6cZ/uojf46WeHWqn2LMA23HO
         aF2NK+ZURU3jXbqyN0E1+3CmXmDgGPdfU5gfn3RYRepJ0P5qb3MsqJ65mMa+WsjSG6Vn
         IPc6wCofcnjWPBJRlZ98AAjXbxjH6shB+Ow+IET11VnlXx0FHLcSlOtI1ueph/RsACk+
         9AEB/otbEWUc8wC1Ghw6eohwDgPeKGm41ryWVc0HIvSIbQ87LlXgfRiuj/lCX4XfR5sJ
         zM1SX8JVBNk1flWOiybOaXNg2TLLf/nZIA1MYreQSbkcLaY8dasg5YYBzPyohhC2rUkQ
         qaog==
X-Gm-Message-State: AO0yUKXMNaIk7i7769Tb4mN98nvjr+XyAzhwVIJPMlkOGBEpiNjY48Mv
        N2ha2qRCRmR3x6KPzKBqMkTbZrZck6O8b04RrtQ=
X-Google-Smtp-Source: AK7set8LqHEC2iSU+ozWV+3LeFx1hIJa9bL71b7rZOWIfQWNP8Si5RJ5666R/xRB1CxdXIZDXRK/Cn+kildwsShx+1U=
X-Received: by 2002:a17:90b:1f8f:b0:233:3c5a:b41b with SMTP id
 so15-20020a17090b1f8f00b002333c5ab41bmr1514654pjb.133.1676639439623; Fri, 17
 Feb 2023 05:10:39 -0800 (PST)
MIME-Version: 1.0
References: <20230216234522.3757369-1-elver@google.com> <Y+94tm7xoeTGqPgs@elver.google.com>
In-Reply-To: <Y+94tm7xoeTGqPgs@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 17 Feb 2023 14:10:28 +0100
Message-ID: <CA+fCnZd+BQo=+YzhJ4DXz6EK_M9UnGVRi8X1h3tV8cXXYS=T8A@mail.gmail.com>
Subject: Re: [PATCH -tip v4 4/4] kasan, x86: Don't rename memintrinsics in
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

On Fri, Feb 17, 2023 at 1:53 PM Marco Elver <elver@google.com> wrote:
>
> Now that memcpy/memset/memmove are no longer overridden by KASAN, we can
> just use the normal symbol names in uninstrumented files.
>
> Drop the preprocessor redefinitions.
>
> Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v4:
> * New patch.
> ---
>  arch/x86/include/asm/string_64.h | 19 -------------------
>  1 file changed, 19 deletions(-)
>
> diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
> index 888731ccf1f6..c1e14cee0722 100644
> --- a/arch/x86/include/asm/string_64.h
> +++ b/arch/x86/include/asm/string_64.h
> @@ -85,25 +85,6 @@ char *strcpy(char *dest, const char *src);
>  char *strcat(char *dest, const char *src);
>  int strcmp(const char *cs, const char *ct);
>
> -#if (defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__))
> -/*
> - * For files that not instrumented (e.g. mm/slub.c) we
> - * should use not instrumented version of mem* functions.
> - */
> -
> -#undef memcpy
> -#define memcpy(dst, src, len) __memcpy(dst, src, len)
> -#undef memmove
> -#define memmove(dst, src, len) __memmove(dst, src, len)
> -#undef memset
> -#define memset(s, c, n) __memset(s, c, n)
> -
> -#ifndef __NO_FORTIFY
> -#define __NO_FORTIFY /* FORTIFY_SOURCE uses __builtin_memcpy, etc. */
> -#endif
> -
> -#endif
> -
>  #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
>  #define __HAVE_ARCH_MEMCPY_FLUSHCACHE 1
>  void __memcpy_flushcache(void *dst, const void *src, size_t cnt);
> --
> 2.39.2.637.g21b0678d19-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you, Marco!

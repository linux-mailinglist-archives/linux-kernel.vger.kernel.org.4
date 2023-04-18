Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39A76E6BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjDRSUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDRSUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:20:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E2E1445E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:20:27 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-246eebbde1cso2584807a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681842026; x=1684434026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DNDdHABsaakcA7jnUDjSieBuYQRHhRNZYcEhWrZDSY=;
        b=kur/cOjpvSIbg0KQNCVz0ofmvhzaZAv5XVmVJc9qNgH2zdCX/BWEau6siJUSno0N9b
         uBmUFaw7nq4x4xFsQ8rReRCeCwt5YWzfpjj6GKAGWRDtPXAUykGELP9fVEbulLu6NT/e
         QWRJEZEGPZbKT5oyEamSNF0YwnOaYshBbPuluxVKhxyLxZ2iMBtbi07QYyYvPC+aDzHK
         46tQRXFZzBExLC4lOpX6mU4dRs1mCCVXMvL4wMkw46dbNSgYzq4XPG2ao3FZoH649u60
         NFtaqOCeN0dCGvRD8dNsuxkvnAxP0+JmTZlabTYfJCS9yek0y5txyS1dkll6cyfIVUO3
         8tkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681842026; x=1684434026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DNDdHABsaakcA7jnUDjSieBuYQRHhRNZYcEhWrZDSY=;
        b=A8/Hmz/X52UNv/O10C1ELPxvCWoj+Qfs6Fh9PDxKFLju4a+ag310gw/5oG2QC1WYeU
         2gSkg0o++niRgBgw3QP+A6Cgsk0D6igk7sIMyWVZ17PLEkRcvUck4P61uJrS/51Vfoz8
         qqU08GZvtXG1YeFl75ueatXLpGJlA2AQPZ4lu6mpHLQqcMGHA6RoMbtjjZgVY4GjD9bB
         cxSgRcnnoehKeS2WmyoVGzgxkkS+8LphdsbuTtRISkeoad3Nq/ZjvVxZpRjXYPAjjqLf
         WJoWoRaI2Lhmp2KTgeMLxhhVOeZV/4KBWMAtrf7p/M+gct5oLiG/wLuY4uAouFYvlMrT
         wBdQ==
X-Gm-Message-State: AAQBX9f6XZVYSoaziGK2if75hH1feDRBu2YUdPEXEN3+KQJT/lrS9zI7
        B48zBOnu+ukNSCup6tCD9gtMGymhX8wHxpEcRa+WsQ==
X-Google-Smtp-Source: AKy350boFioJgp8wtE1Dr3UOwZAK5o7Q9dtF8zyg/RlPVaopO3qU+LnCEoEoLgghcttNeKteMSY9oMSYHT5iXb+5JVc=
X-Received: by 2002:a17:90b:38c6:b0:237:c209:5b14 with SMTP id
 nn6-20020a17090b38c600b00237c2095b14mr472426pjb.22.1681842026333; Tue, 18 Apr
 2023 11:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230407191904.gonna.522-kees@kernel.org> <20230407192717.636137-8-keescook@chromium.org>
In-Reply-To: <20230407192717.636137-8-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Apr 2023 11:20:15 -0700
Message-ID: <CAKwvOd=qh9WGmD6dAxsfHo7iBxAVr6ethAAavxkMUaOQ6LJEyA@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] fortify: Provide KUnit counters for failure testing
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sander Vanheule <sander@svanheule.net>,
        Eric Biggers <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Latypov <dlatypov@google.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 12:27=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> The standard C string APIs were not designed to have a failure mode;
> they were expected to always succeed without memory safety issues.
> Normally, CONFIG_FORTIFY_SOURCE will use fortify_panic() to stop
> processing, as truncating a read or write may provide an even worse
> system state. However, this creates a problem for testing under things
> like KUnit, which needs a way to survive failures.
>
> When building with CONFIG_KUNIT, provide a failure path for all users
> for fortify_panic, and track whether the failure was a read overflow or
> a write overflow, for KUnit tests to examine. Inspired by similar logic
> in the slab tests.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/fortify-string.h | 45 +++++++++++++++++++---------------
>  lib/fortify_kunit.c            | 44 +++++++++++++++++++++++++++++++++
>  lib/string_helpers.c           |  2 ++
>  3 files changed, 71 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-strin=
g.h
> index 19906b45fb98..5d04c0e95854 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -15,8 +15,12 @@
>  #define FORTIFY_REASON(func, write)    (FIELD_PREP(BIT(0), write) | \
>                                          FIELD_PREP(GENMASK(7, 1), func))
>
> -#define fortify_panic(func, write)     \
> +#ifdef FORTIFY_KUNIT_OVERRIDE
> +# define fortify_panic kunit_fortify_panic
> +#else
> +# define fortify_panic(func, write, retfail)   \
>         __fortify_panic(FORTIFY_REASON(func, write))
> +#endif

Could we provide a different definition of fortify_panic in
lib/string_helpers.c rather than this macro indirection?

>
>  #define FORTIFY_READ            0
>  #define FORTIFY_WRITE           1
> @@ -186,7 +190,7 @@ char *strncpy(char * const POS p, const char *q, __ke=
rnel_size_t size)
>         if (__compiletime_lessthan(p_size, size))
>                 __write_overflow();
>         if (p_size < size)
> -               fortify_panic(FORTIFY_FUNC_strncpy, FORTIFY_WRITE);
> +               fortify_panic(FORTIFY_FUNC_strncpy, FORTIFY_WRITE, p);
>         return __underlying_strncpy(p, q, size);
>  }
>
> @@ -217,7 +221,7 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char *=
 const POS p, __kernel_size
>         /* Do not check characters beyond the end of p. */
>         ret =3D __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
>         if (p_size <=3D ret && maxlen !=3D ret)
> -               fortify_panic(FORTIFY_FUNC_strnlen, FORTIFY_READ);
> +               fortify_panic(FORTIFY_FUNC_strnlen, FORTIFY_READ, ret);
>         return ret;
>  }
>
> @@ -253,7 +257,7 @@ __kernel_size_t __fortify_strlen(const char * const P=
OS p)
>                 return __underlying_strlen(p);
>         ret =3D strnlen(p, p_size);
>         if (p_size <=3D ret)
> -               fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ);
> +               fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ, ret);
>         return ret;
>  }
>
> @@ -295,7 +299,7 @@ __FORTIFY_INLINE size_t strlcpy(char * const POS p, c=
onst char * const POS q, si
>         }
>         if (size) {
>                 if (len >=3D p_size)
> -                       fortify_panic(FORTIFY_FUNC_strlcpy, FORTIFY_WRITE=
);
> +                       fortify_panic(FORTIFY_FUNC_strlcpy, FORTIFY_WRITE=
, q_len);
>                 __underlying_memcpy(p, q, len);
>                 p[len] =3D '\0';
>         }
> @@ -373,7 +377,7 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, =
const char * const POS q, s
>          * p_size.
>          */
>         if (len > p_size)
> -               fortify_panic(FORTIFY_FUNC_strscpy, FORTIFY_WRITE);
> +               fortify_panic(FORTIFY_FUNC_strscpy, FORTIFY_WRITE, -E2BIG=
);
>
>         /*
>          * We can now safely call vanilla strscpy because we are protecte=
d from:
> @@ -431,7 +435,7 @@ size_t strlcat(char * const POS p, const char * const=
 POS q, size_t avail)
>
>         /* Give up if string is already overflowed. */
>         if (p_size <=3D p_len)
> -               fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_READ);
> +               fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_READ, wanted)=
;
>
>         if (actual >=3D avail) {
>                 copy_len =3D avail - p_len - 1;
> @@ -440,7 +444,7 @@ size_t strlcat(char * const POS p, const char * const=
 POS q, size_t avail)
>
>         /* Give up if copy will overflow. */
>         if (p_size <=3D actual)
> -               fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_WRITE);
> +               fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_WRITE, wanted=
);
>         __underlying_memcpy(p + p_len, q, copy_len);
>         p[actual] =3D '\0';
>
> @@ -469,7 +473,7 @@ char *strcat(char * const POS p, const char *q)
>         const size_t p_size =3D __member_size(p);
>
>         if (strlcat(p, q, p_size) >=3D p_size)
> -               fortify_panic(FORTIFY_FUNC_strcat, FORTIFY_WRITE);
> +               fortify_panic(FORTIFY_FUNC_strcat, FORTIFY_WRITE, p);
>         return p;
>  }
>
> @@ -505,13 +509,13 @@ char *strncat(char * const POS p, const char * cons=
t POS q, __kernel_size_t coun
>         p_len =3D strlen(p);
>         copy_len =3D strnlen(q, count);
>         if (p_size < p_len + copy_len + 1)
> -               fortify_panic(FORTIFY_FUNC_strncat, FORTIFY_WRITE);
> +               fortify_panic(FORTIFY_FUNC_strncat, FORTIFY_WRITE, p);
>         __underlying_memcpy(p + p_len, q, copy_len);
>         p[p_len + copy_len] =3D '\0';
>         return p;
>  }
>
> -__FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
> +__FORTIFY_INLINE bool fortify_memset_chk(__kernel_size_t size,
>                                          const size_t p_size,
>                                          const size_t p_size_field)
>  {
> @@ -546,7 +550,8 @@ __FORTIFY_INLINE void fortify_memset_chk(__kernel_siz=
e_t size,
>          * lengths are unknown.)
>          */
>         if (p_size !=3D SIZE_MAX && p_size < size)
> -               fortify_panic(FORTIFY_FUNC_memset, FORTIFY_WRITE);
> +               fortify_panic(FORTIFY_FUNC_memset, FORTIFY_WRITE, true);
> +       return false;
>  }
>
>  #define __fortify_memset_chk(p, c, size, p_size, p_size_field) ({      \
> @@ -645,9 +650,9 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_siz=
e_t size,
>          * lengths are unknown.)
>          */
>         if (p_size !=3D SIZE_MAX && p_size < size)
> -               fortify_panic(func, FORTIFY_WRITE);
> +               fortify_panic(func, FORTIFY_WRITE, true);
>         else if (q_size !=3D SIZE_MAX && q_size < size)
> -               fortify_panic(func, FORTIFY_READ);
> +               fortify_panic(func, FORTIFY_READ, true);
>
>         /*
>          * Warn when writing beyond destination field size.
> @@ -747,7 +752,7 @@ __FORTIFY_INLINE void *memscan(void * const POS0 p, i=
nt c, __kernel_size_t size)
>         if (__compiletime_lessthan(p_size, size))
>                 __read_overflow();
>         if (p_size < size)
> -               fortify_panic(FORTIFY_FUNC_memscan, FORTIFY_READ);
> +               fortify_panic(FORTIFY_FUNC_memscan, FORTIFY_READ, NULL);
>         return __real_memscan(p, c, size);
>  }
>
> @@ -764,7 +769,7 @@ int memcmp(const void * const POS0 p, const void * co=
nst POS0 q, __kernel_size_t
>                         __read_overflow2();
>         }
>         if (p_size < size || q_size < size)
> -               fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ);
> +               fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ, INT_MIN)=
;
>         return __underlying_memcmp(p, q, size);
>  }
>
> @@ -776,7 +781,7 @@ void *memchr(const void * const POS0 p, int c, __kern=
el_size_t size)
>         if (__compiletime_lessthan(p_size, size))
>                 __read_overflow();
>         if (p_size < size)
> -               fortify_panic(FORTIFY_FUNC_memchr, FORTIFY_READ);
> +               fortify_panic(FORTIFY_FUNC_memchr, FORTIFY_READ, NULL);
>         return __underlying_memchr(p, c, size);
>  }
>
> @@ -788,7 +793,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const =
POS0 p, int c, size_t size)
>         if (__compiletime_lessthan(p_size, size))
>                 __read_overflow();
>         if (p_size < size)
> -               fortify_panic(FORTIFY_FUNC_memchr_inv, FORTIFY_READ);
> +               fortify_panic(FORTIFY_FUNC_memchr_inv, FORTIFY_READ, NULL=
);
>         return __real_memchr_inv(p, c, size);
>  }
>
> @@ -801,7 +806,7 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS=
0 p, size_t size, gfp_t gfp
>         if (__compiletime_lessthan(p_size, size))
>                 __read_overflow();
>         if (p_size < size)
> -               fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ);
> +               fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ, NULL);
>         return __real_kmemdup(p, size, gfp);
>  }
>
> @@ -838,7 +843,7 @@ char *strcpy(char * const POS p, const char * const P=
OS q)
>                 __write_overflow();
>         /* Run-time check for dynamic size overflow. */
>         if (p_size < size)
> -               fortify_panic(FORTIFY_FUNC_strcpy, FORTIFY_WRITE);
> +               fortify_panic(FORTIFY_FUNC_strcpy, FORTIFY_WRITE, p);
>         __underlying_memcpy(p, q, size);
>         return p;
>  }
> diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
> index 524132f33cf0..ea2b39f279c2 100644
> --- a/lib/fortify_kunit.c
> +++ b/lib/fortify_kunit.c
> @@ -15,12 +15,28 @@
>   */
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> +/* Call kunit_fortify_panic() instead of fortify_panic() */
> +#define FORTIFY_KUNIT_OVERRIDE
> +void fortify_add_kunit_error(int write);
> +#define kunit_fortify_panic(func, write, retfail)                      \
> +       do {                                                            \
> +               __fortify_report(FORTIFY_REASON(func, write));          \
> +               fortify_add_kunit_error(write);                         \
> +               return (retfail);                                       \

^ Does this return value even matter? Could we just return -1 or some
other constant for all cases? Then you don't need an optional
parameter addition to fortify_panic.

> +       } while (0)
> +
>  #include <kunit/test.h>
> +#include <kunit/test-bug.h>
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/vmalloc.h>
>
> +static struct kunit_resource read_resource;
> +static struct kunit_resource write_resource;
> +static int fortify_read_overflows;
> +static int fortify_write_overflows;
> +
>  static const char array_of_10[] =3D "this is 10";
>  static const char *ptr_of_11 =3D "this is 11!";
>  static char array_unknown[] =3D "compiler thinks I might change";
> @@ -30,6 +46,25 @@ static char array_unknown[] =3D "compiler thinks I mig=
ht change";
>  # define __compiletime_strlen __builtin_strlen
>  #endif
>
> +void fortify_add_kunit_error(int write)
> +{
> +       struct kunit_resource *resource;
> +       struct kunit *current_test;
> +
> +       current_test =3D kunit_get_current_test();
> +       if (!current_test)
> +               return;
> +
> +       resource =3D kunit_find_named_resource(current_test,
> +                       write ? "fortify_write_overflows"
> +                             : "fortify_read_overflows");
> +       if (!resource)
> +               return;
> +
> +       (*(int *)resource->data)++;
> +       kunit_put_resource(resource);
> +}
> +
>  static void known_sizes_test(struct kunit *test)
>  {
>         KUNIT_EXPECT_EQ(test, __compiletime_strlen("88888888"), 8);
> @@ -317,6 +352,15 @@ static int fortify_test_init(struct kunit *test)
>         if (!IS_ENABLED(CONFIG_FORTIFY_SOURCE))
>                 kunit_skip(test, "Not built with CONFIG_FORTIFY_SOURCE=3D=
y");
>
> +       fortify_read_overflows =3D 0;
> +       kunit_add_named_resource(test, NULL, NULL, &read_resource,
> +                                "fortify_read_overflows",
> +                                &fortify_read_overflows);
> +       fortify_write_overflows =3D 0;
> +       kunit_add_named_resource(test, NULL, NULL, &write_resource,
> +                                "fortify_write_overflows",
> +                                &fortify_write_overflows);
> +
>         return 0;
>  }
>
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 96d502e1e578..38edde20e61b 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -18,6 +18,8 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/string_helpers.h>
> +#include <kunit/test.h>
> +#include <kunit/test-bug.h>

Why do we need these headers here?

>
>  /**
>   * string_get_size - get the size in the specified units
> --
> 2.34.1
>


--
Thanks,
~Nick Desaulniers

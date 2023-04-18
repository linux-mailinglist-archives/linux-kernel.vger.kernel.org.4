Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386966E6BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDRSJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjDRSJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:09:55 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EB626BC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:09:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id kx14so7775607pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681841393; x=1684433393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvYJv9dOjy+UuDbqsW2nTRdYTEQVKFBOOB3qhqiqwVk=;
        b=IaEdy0EjS+dkJyFf7jEB4cf+UKn6AFvwFyjTjHw9CYyMSQssUj66B1D7Nv4FoN8khO
         jDzkieXoE9rcTy+iawdFz7ljwwZtZRaSm/S5I1BYNwt3rvpq5uUMww1FxmzB2D5lnp/X
         yLveUunsgUNSDDXaN/suDvGvkeYn7hMdkp6Jukj3pg6//mURtP+3393OQ/JYXsUW2jYK
         L3gJZMxHX6vjfUQFvB4fMxyKHeSZBL8Z9iW7jldxmPqEJ2zXgOvD7H2g7nKDfd/BqmvO
         OZppDJt+Cg3YIAs7nUL64499E4XldMaDSLpRAQFNYhwqBmbhXqH7TrcCidZ8Y6UYGxLm
         Q+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681841393; x=1684433393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvYJv9dOjy+UuDbqsW2nTRdYTEQVKFBOOB3qhqiqwVk=;
        b=SIh3QJ+pTSjH4Z2OGSOYVZZx7J7yCyY7oXiqax59MVRySV8R0Rn2olNqPupqSPXR1s
         Y9QjjuGVEHZxOmlYE2Ukhnf9/YSst+A1VwuJr5qDjzFHCmrON2PkgTfqbLDLxgJzUyUa
         TXfeEbaK3pF/uk6/ppX08MALQO+0k2d5EtQ3njvv6/c+bb5a2vH0E/pnXBMiz8ovEGgC
         R3HmLpmbhjm07SJamcETKMfi0XrdDAhcIw9Qh6qSJu3V+r3ui/XS9jTQNGdbb+E4j3ce
         BrkMyiM65sdtDXBwaa4TJV3FfsvLuWHjEizDwVYEna8xZOLa6sgfFwYiMVNLMXG1Z1BZ
         YX2g==
X-Gm-Message-State: AAQBX9dgDEVh4JKEWjsd8qV1W8dE7AGect71Ci/YHAFXOrQ55DlpoC3l
        eW7Yogni1oILlw0wIqJRyyxLkIbrGZHx2rsgbJXNHA==
X-Google-Smtp-Source: AKy350YWJtgptpWdJFruXeLGCxuNU4bvvRi4laL/0AlgGBB5Ic+fMqnQZtaErwzhGEYzDKQdJzhSYAdpzn0Dqwy8UVc=
X-Received: by 2002:a05:6a20:8422:b0:db:4fae:ad15 with SMTP id
 c34-20020a056a20842200b000db4faead15mr598370pzd.42.1681841392775; Tue, 18 Apr
 2023 11:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230407191904.gonna.522-kees@kernel.org> <20230407192717.636137-6-keescook@chromium.org>
In-Reply-To: <20230407192717.636137-6-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Apr 2023 11:09:41 -0700
Message-ID: <CAKwvOdk+CT6S6LjLb2aRVsMSgnsyHRcoT-yyifNTW8vVVwTA-A@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] fortify: strcat: Move definition to use
 fortified strlcat()
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 12:27=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> Move the definition of fortified strcat() to after strlcat() to use it
> for bounds checking.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/fortify-string.h | 53 +++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 27 deletions(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-strin=
g.h
> index 8cf17ef81905..ab058d092817 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -151,33 +151,6 @@ char *strncpy(char * const POS p, const char *q, __k=
ernel_size_t size)
>         return __underlying_strncpy(p, q, size);
>  }
>
> -/**
> - * strcat - Append a string to an existing string
> - *
> - * @p: pointer to NUL-terminated string to append to
> - * @q: pointer to NUL-terminated source string to append from
> - *
> - * Do not use this function. While FORTIFY_SOURCE tries to avoid
> - * read and write overflows, this is only possible when the
> - * destination buffer size is known to the compiler. Prefer
> - * building the string with formatting, via scnprintf() or similar.
> - * At the very least, use strncat().
> - *
> - * Returns @p.
> - *
> - */
> -__FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
> -char *strcat(char * const POS p, const char *q)
> -{
> -       const size_t p_size =3D __member_size(p);
> -
> -       if (p_size =3D=3D SIZE_MAX)
> -               return __underlying_strcat(p, q);
> -       if (strlcat(p, q, p_size) >=3D p_size)
> -               fortify_panic(__func__);
> -       return p;
> -}
> -
>  extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __R=
ENAME(strnlen);
>  /**
>   * strnlen - Return bounded count of characters in a NUL-terminated stri=
ng
> @@ -435,6 +408,32 @@ size_t strlcat(char * const POS p, const char * cons=
t POS q, size_t avail)
>         return wanted;
>  }
>
> +/* Defined after fortified strlcat() to reuse it. */

I don't follow; the previous location was already defined in terms of
calls to strlcat.  Why is this patch necessary?

Could this be fixed in 5/10
https://lore.kernel.org/linux-hardening/20230407192717.636137-5-keescook@ch=
romium.org/
by just putting strlcat in the expected place in the first place?

> +/**
> + * strcat - Append a string to an existing string
> + *
> + * @p: pointer to NUL-terminated string to append to
> + * @q: pointer to NUL-terminated source string to append from
> + *
> + * Do not use this function. While FORTIFY_SOURCE tries to avoid
> + * read and write overflows, this is only possible when the
> + * destination buffer size is known to the compiler. Prefer
> + * building the string with formatting, via scnprintf() or similar.
> + * At the very least, use strncat().
> + *
> + * Returns @p.
> + *
> + */
> +__FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
> +char *strcat(char * const POS p, const char *q)
> +{
> +       const size_t p_size =3D __member_size(p);
> +

This drops the `p_size =3D=3D SIZE_MAX` guard.  Might it be faster at
runtime to dispatch to __underlying_strcat rather than __real_strlcat
in such cases?

What's the convention for __underlying_ vs __real_ prefixes in
include/linux/fortify-string.h?

> +       if (strlcat(p, q, p_size) >=3D p_size)
> +               fortify_panic(__func__);
> +       return p;
> +}
> +
>  /**
>   * strncat - Append a string to an existing string
>   *
> --
> 2.34.1
>


--=20
Thanks,
~Nick Desaulniers

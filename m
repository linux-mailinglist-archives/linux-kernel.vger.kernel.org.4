Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A641F6D8CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjDFBWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjDFBWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:22:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616616EB9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 18:22:37 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so39092788pjl.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 18:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680744157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/S5sAkZvrgM2hoThDDuFNKo9n2ass/+HSZV217sbv94=;
        b=RxmRRUs1RFpO03FsE49L2kdccmOC2ZpWWAF8DBOzPU+AArPUuFQd4UaWgJZ7bS0WWW
         L4/rmQovKcu9fk7lxlCvWw6nyD5lxIHLuUgI0KG3WQtVgBYZWawprToViqVPlX5RnGjy
         v6beG+ooePS+MagtPMx/nOd7z2/Xve57vR24qgXRHuOf0CPD8VHkp2hxTanrgRgY/rHG
         jWd3QnHHzao4FaB1sHdF4bjSSwYYd/jeK4laCkyaSr7rkC1JA5p1tAMJNhI8QaaKGp44
         pyRb5TCKeUE8hsyt3Z7iBrA9rCGBqGTi37kU1DZrrepR1F6R6euDIVbV7zdLFeYLHtAC
         TZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680744157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/S5sAkZvrgM2hoThDDuFNKo9n2ass/+HSZV217sbv94=;
        b=Z6c+yEO+pO0aErlaj2HeaZveQn22Do+GdadufBNdGFpQqdUeOCKSNEAp5AMz6fxGeY
         PcsxBi1K0BVDmil6+frBC7gqtxWBhz88lTEqUbCKl52O8ZbqtGjWaGVX6Qmkgnm98iih
         PS81c3wxF4TebvFfUWTkps0u540lXJ4/cat3IWfvQ/SRQh1wXgN2sTPHespY7+5I7hvZ
         qbKXJLmQzo2rWboySG+5XQHsNyH4Re1qe0MxtQ7+PqwEyNNdREQ+eWAZWpn+GXjmkXqH
         ZymYqKPxoTzYX+68HmgTN4CQ/8VcnBXo+3Vk5As9tp+TGjikFytqNHUV+Bitwh+f5LO9
         093Q==
X-Gm-Message-State: AAQBX9eyBL2tC5GRPwz1jKpnyMBmgb0H+fVmlM4IEUt2U7g2eg39GMAB
        d/m+d6sycVCtkhtbCA4PL7038x2V8gBj40+cXjvWXg==
X-Google-Smtp-Source: AKy350bVqspGyY9yhD9zjEttPp+oUZh3hYJnsDS/zya+LmAMhijrGcnDEQgrzoMyFQ8aoVCVy6T3zk6ZVgGnYNRzMRk=
X-Received: by 2002:a17:903:2652:b0:1a0:527b:9189 with SMTP id
 je18-20020a170903265200b001a0527b9189mr3186890plb.11.1680744156647; Wed, 05
 Apr 2023 18:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230405235832.never.487-kees@kernel.org> <20230406000212.3442647-2-keescook@chromium.org>
In-Reply-To: <20230406000212.3442647-2-keescook@chromium.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 5 Apr 2023 18:22:25 -0700
Message-ID: <CAGS_qxpk8WsPjN702nhQcEsK4yzzXZCc5n5cTVMSpwnVhCHSvA@mail.gmail.com>
Subject: Re: [PATCH 2/9] fortify: Allow KUnit test to build without FORTIFY
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <kees@outflux.net>,
        Andy Shevchenko <andy@kernel.org>,
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
        Nick Desaulniers <ndesaulniers@google.com>,
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
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 5:08=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> From: Kees Cook <kees@outflux.net>
>
> In order for CI systems to notice all the skipped tests related to
> CONFIG_FORTIFY_SOURCE, allow the FORTIFY_SOURCE KUnit tests to build
> with or without CONFIG_FORTIFY_SOURCE.

Hmm, I wonder if this warrants a deeper discussion.
It's a lot easier to have tests get disabled by kconfig if their deps
aren't met.

If there's pressure to have them compiled and just get marked skipped,
that sounds like that could be annoying.
Esp. in the cases where more code needs to be put behind

#ifdef CONFIG_MY_DEP
<test helpers, etc>
#endif

But I have a suggestion below to simplify this a bit

>
> Signed-off-by: Kees Cook <kees@outflux.net>
> ---
>  lib/Kconfig.debug   |  2 +-
>  lib/fortify_kunit.c | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c8b379e2e9ad..d48a5f4b471e 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2614,7 +2614,7 @@ config STACKINIT_KUNIT_TEST
>
>  config FORTIFY_KUNIT_TEST
>         tristate "Test fortified str*() and mem*() function internals at =
runtime" if !KUNIT_ALL_TESTS
> -       depends on KUNIT && FORTIFY_SOURCE
> +       depends on KUNIT
>         default KUNIT_ALL_TESTS
>         help
>           Builds unit tests for checking internals of FORTIFY_SOURCE as u=
sed
> diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
> index c8c33cbaae9e..d054fc20a7d5 100644
> --- a/lib/fortify_kunit.c
> +++ b/lib/fortify_kunit.c
> @@ -25,8 +25,21 @@ static const char array_of_10[] =3D "this is 10";
>  static const char *ptr_of_11 =3D "this is 11!";
>  static char array_unknown[] =3D "compiler thinks I might change";
>
> +/* Handle being built without CONFIG_FORTIFY_SOURCE */
> +#ifndef __compiletime_strlen
> +# define __compiletime_strlen __builtin_strlen
> +#endif
> +
> +#define skip_without_fortify() \
> +do {                           \
> +       if (!IS_ENABLED(CONFIG_FORTIFY_SOURCE)) \
> +               kunit_skip(test, "Not built with CONFIG_FORTIFY_SOURCE=3D=
y"); \
> +} while (0)

Note: you can add an `init` function to the suite and skip the tests there.

static void fortify_init(struct kunit *test) {
       if (!IS_ENABLED(CONFIG_FORTIFY_SOURCE))
               kunit_skip(test, "Not built with CONFIG_FORTIFY_SOURCE=3Dy")=
;
}

...
  static struct kunit_suite fortify_test_suite =3D {
          .name =3D "fortify",
+         .init =3D fortify_init,
          .test_cases =3D fortify_test_cases,
  };

That way we don't have to add it to each test case.

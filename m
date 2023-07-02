Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1392744E40
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 17:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjGBPHW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Jul 2023 11:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGBPHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 11:07:21 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D91E67;
        Sun,  2 Jul 2023 08:07:18 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-c17534f4c63so4094712276.0;
        Sun, 02 Jul 2023 08:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688310438; x=1690902438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gxOgc8d/Q9KJszIq2CJBH2LgwNmv7XjL6hQ7mmHl9M=;
        b=Ea/YNVk/uZDUkQKHVZBtQBntC8qRULxY9IIQWum03bxsXL3hxzziRB4xYy3sMJqnAI
         xzqLcPPODLEjgQY0ImuKdNZyHZ5geHpUN6MraS4+IdJ0W88l9zKwrFnSixenHLwOwD2S
         Rf+pJCdMX1grxqK2eXLTZ1jI6MSnWbh/06OXHtB9f/k6+s3LQOQH7iJ1apGG+wS6LyRi
         kBPpI+4kDORpovBu8Gfv79n6MVazEOdgemv6y4Id7GlCC4uegfdkhfzNy2hZBRYhKWY+
         YztPoKE/vrMjbmkFK4wWxo+Y1nIA4NFisA6e/jMbITo2adNsUJPGs0RSOtcDTZDWGXIW
         6xqQ==
X-Gm-Message-State: ABy/qLZnzebj2UbZkIMgaMuPMylctGH5oqUzSxOByHrkXHyKUPBm4on3
        sYxINUhoc5dJVZXiRj04vfEdf0nLf+tDQw==
X-Google-Smtp-Source: APBJJlEM9I8bmCkXug1KXkYQxbd4DTCK3yI90lRR0m+yKG+Sszf8wfSNoUqv/++ZGje4KWucnZ7zOg==
X-Received: by 2002:a25:3754:0:b0:c4e:24d:ae7f with SMTP id e81-20020a253754000000b00c4e024dae7fmr2169682yba.58.1688310437769;
        Sun, 02 Jul 2023 08:07:17 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id r21-20020a25ac55000000b00bc8ae5e206csm3978508ybd.51.2023.07.02.08.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 08:07:17 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-bd6446528dcso4089805276.2;
        Sun, 02 Jul 2023 08:07:17 -0700 (PDT)
X-Received: by 2002:a25:aaf0:0:b0:be8:1aab:b3fb with SMTP id
 t103-20020a25aaf0000000b00be81aabb3fbmr8243856ybi.21.1688310436835; Sun, 02
 Jul 2023 08:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230407191904.gonna.522-kees@kernel.org> <20230407192717.636137-2-keescook@chromium.org>
In-Reply-To: <20230407192717.636137-2-keescook@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 2 Jul 2023 17:07:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUrxOEroHVUt7-mAnKSBjY=a-D3jr+XiAifuwv06Ob9Pw@mail.gmail.com>
Message-ID: <CAMuHMdUrxOEroHVUt7-mAnKSBjY=a-D3jr+XiAifuwv06Ob9Pw@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] fortify: Allow KUnit test to build without FORTIFY
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
        Daniel Latypov <dlatypov@google.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Fri, Apr 7, 2023 at 9:27 PM Kees Cook <keescook@chromium.org> wrote:
> In order for CI systems to notice all the skipped tests related to
> CONFIG_FORTIFY_SOURCE, allow the FORTIFY_SOURCE KUnit tests to build
> with or without CONFIG_FORTIFY_SOURCE.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for your patch, which is now commit a9dc8d0442294b42
("fortify: Allow KUnit test to build without FORTIFY") upstream.

> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2614,7 +2614,7 @@ config STACKINIT_KUNIT_TEST
>
>  config FORTIFY_KUNIT_TEST
>         tristate "Test fortified str*() and mem*() function internals at runtime" if !KUNIT_ALL_TESTS
> -       depends on KUNIT && FORTIFY_SOURCE
> +       depends on KUNIT

All other tests depend on the functionality they test.
Which makes sense, as you only want to test the functionality that is
available in the kernel you want to run.

>         default KUNIT_ALL_TESTS
>         help
>           Builds unit tests for checking internals of FORTIFY_SOURCE as used
> diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
> index c8c33cbaae9e..524132f33cf0 100644
> --- a/lib/fortify_kunit.c
> +++ b/lib/fortify_kunit.c

> @@ -307,6 +312,14 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
>  } while (0)
>  DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)
>
> +static int fortify_test_init(struct kunit *test)
> +{
> +       if (!IS_ENABLED(CONFIG_FORTIFY_SOURCE))
> +               kunit_skip(test, "Not built with CONFIG_FORTIFY_SOURCE=y");

I was greeted by this message, which wasn't that helpful, as
CONFIG_FORTIFY_SOURCE depends on CONFIG_ARCH_HAS_FORTIFY_SOURCE,
which is not available yet on all architectures.

So I think the proper thing to do is to revert this patch.
Thanks!

> +
> +       return 0;
> +}
> +
>  static struct kunit_case fortify_test_cases[] = {
>         KUNIT_CASE(known_sizes_test),
>         KUNIT_CASE(control_flow_split_test),

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

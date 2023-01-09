Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689DE6635DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbjAIXtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237964AbjAIXts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:49:48 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9616EC75E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:49:46 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y5so7462450pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 15:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DO2gFEgiDABoY96vqldhsa5IX5CM91xrCTzOJpPuUrY=;
        b=Ewp9ZXvbs6+dHYVP3ZML0r0pXXjliiXz9pzqXOxpkflZPAdA1F36UAnakc7TLXYcEU
         z5RESDS0Zx++emMFDXE0lGz1w4OcXFoOmbSTnRP059kd2zR5bZNHvFz2ZPHGvJAgRQd5
         cJ11vE8MadnikmDvVI82Vx0pbJ9qriGuxB1HcIMFiyBz8vP5SQG1ZduqInjmuR+Uv+Zs
         NTEbyg5YWRDa+QldmR6QWzwMYPyQxemwEAX4B9YSbmTBGZCtr+rWOcHwzhuw8WHXt3H1
         3fnxYs9wq5XDshTVKIREKRhyiK3Kh1ypXfc9Zw4rDKJrewgLC9rA2VxD1Ey4zmBXxduS
         Cfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DO2gFEgiDABoY96vqldhsa5IX5CM91xrCTzOJpPuUrY=;
        b=G7dR66axRqPVjZeDAlGEOa+UEtrKZE5YfpqC5Z45y0DVLiB+gyNjYm/CGZ160qdj99
         kpq8JUK0+hZX6/I+4mHblBwyYaIleXBklbndxQariSgOA3OM9/DJp2RxOCfhGh0kDAFL
         YpwFWLJQTU7rExqmArMtpJrkBlqQvBfXg+q8VXGVahysbKoa9342naS6edeQXkLSnLLa
         5ehhCBroeg661OJUvsY/Q2jbqbnkDghkXOUB4W5m4iZytH7RYSdbtZeXpVaKoDBZoXk9
         s+9DO+h2addINg9/0tj6+D4y+cLhWdThEWi2jIYww6cb5TyqOhv+7njYWkWg2j8w9LuB
         lATQ==
X-Gm-Message-State: AFqh2ko8E8LGdFOHlgpXD9KlXegW6XyI/P3dw3u8TBqjaI1/rYN4aAxx
        wtfeE6LjGJBbQM0FfhFprZciNu4c5Q4iwvQrAlNiHQ==
X-Google-Smtp-Source: AMrXdXt45coC7HUnNiBQa21drck9GXBYNbKYLbddRP7gLYKgaQgvhq245lRGXDS8uniGFu2aS5/0guohSlNeIQ3GRfA=
X-Received: by 2002:aa7:914e:0:b0:578:202d:a33a with SMTP id
 14-20020aa7914e000000b00578202da33amr3376736pfi.23.1673308185711; Mon, 09 Jan
 2023 15:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20230107040203.never.112-kees@kernel.org>
In-Reply-To: <20230107040203.never.112-kees@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Jan 2023 15:49:34 -0800
Message-ID: <CAKwvOdm12OVhGLQJcNJ-c3ixDEvrFibwDJwpayyfg7Jc+M7ZXA@mail.gmail.com>
Subject: Re: [PATCH] kunit: memcpy: Split slow memcpy tests into MEMCPY_SLOW_KUNIT_TEST
To:     Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, David Gow <davidgow@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
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

On Fri, Jan 6, 2023 at 8:02 PM Kees Cook <keescook@chromium.org> wrote:
>
> Since the long memcpy tests may stall a system for tens of seconds
> in virtualized architecture environments, split those tests off under
> CONFIG_MEMCPY_SLOW_KUNIT_TEST so they can be separately disabled.
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/lkml/20221226195206.GA2626419@roeck-us.net
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> Guenter, does this give you the needed flexibility to turn on the memcpy
> kunit tests again in your slower environments?
> ---
>  lib/Kconfig.debug  |  9 +++++++++
>  lib/memcpy_kunit.c | 17 +++++++++++++----
>  2 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c2c78d0e761c..b5e94807f41c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2621,6 +2621,15 @@ config MEMCPY_KUNIT_TEST
>
>           If unsure, say N.
>
> +config MEMCPY_SLOW_KUNIT_TEST
> +       tristate "Include exhaustive memcpy tests" if !KUNIT_ALL_TESTS
> +       depends on MEMCPY_KUNIT_TEST
> +       default KUNIT_ALL_TESTS
> +       help
> +         Some memcpy tests are quite exhaustive in checking for overlaps
> +         and bit ranges. These can be very slow, so they are split out
> +         as a separate config.
> +
>  config IS_SIGNED_TYPE_KUNIT_TEST
>         tristate "Test is_signed_type() macro" if !KUNIT_ALL_TESTS
>         depends on KUNIT
> diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> index 89128551448d..cc1f36335a9b 100644
> --- a/lib/memcpy_kunit.c
> +++ b/lib/memcpy_kunit.c
> @@ -307,8 +307,12 @@ static void set_random_nonzero(struct kunit *test, u8 *byte)
>         }
>  }
>
> -static void init_large(struct kunit *test)
> +static int init_large(struct kunit *test)
>  {
> +       if (!IS_ENABLED(CONFIG_MEMCPY_SLOW_KUNIT_TEST)) {
> +               kunit_skip(test, "Slow test skipped. Enable with CONFIG_MEMCPY_SLOW_KUNIT_TEST=y");
> +               return -EBUSY;
> +       }
>
>         /* Get many bit patterns. */
>         get_random_bytes(large_src, ARRAY_SIZE(large_src));
> @@ -319,6 +323,8 @@ static void init_large(struct kunit *test)
>
>         /* Explicitly zero the entire destination. */
>         memset(large_dst, 0, ARRAY_SIZE(large_dst));
> +
> +       return 0;
>  }
>
>  /*
> @@ -327,7 +333,9 @@ static void init_large(struct kunit *test)
>   */
>  static void copy_large_test(struct kunit *test, bool use_memmove)
>  {
> -       init_large(test);
> +
> +       if (init_large(test))
> +               return;
>
>         /* Copy a growing number of non-overlapping bytes ... */
>         for (int bytes = 1; bytes <= ARRAY_SIZE(large_src); bytes++) {
> @@ -472,7 +480,8 @@ static void memmove_overlap_test(struct kunit *test)
>         static const int bytes_start = 1;
>         static const int bytes_end = ARRAY_SIZE(large_src) + 1;
>
> -       init_large(test);
> +       if (init_large(test))
> +               return;
>
>         /* Copy a growing number of overlapping bytes ... */
>         for (int bytes = bytes_start; bytes < bytes_end;
> @@ -549,8 +558,8 @@ static void strtomem_test(struct kunit *test)
>  static struct kunit_case memcpy_test_cases[] = {
>         KUNIT_CASE(memset_test),
>         KUNIT_CASE(memcpy_test),
> -       KUNIT_CASE(memcpy_large_test),
>         KUNIT_CASE(memmove_test),
> +       KUNIT_CASE(memcpy_large_test),
>         KUNIT_CASE(memmove_large_test),
>         KUNIT_CASE(memmove_overlap_test),
>         KUNIT_CASE(strtomem_test),
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers

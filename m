Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6610A660E20
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 11:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjAGKzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 05:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjAGKzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:55:46 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46131A230;
        Sat,  7 Jan 2023 02:55:44 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id v14so4227389qtq.3;
        Sat, 07 Jan 2023 02:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wr4uS2V33mv2mSI2SJ9um1YZoYCEkmng9DTBKggir08=;
        b=ytxrhFajmf5N5TZepGqFoddXdKsyCgiwYNZcjOX6aBajl7VNDLSRJYGhAIaN7hhKD1
         PzYmqQtbzedyZz299TvgO88jj+10ByP6o3aXHzpwm5vpGmd5u81CYeqoqF0F4yVt3yy9
         YMOKgduQjbbV4hOzwJY/KuRa1rG1bnlG0b0bT/+E6e1qsVy7A3797hetr61mvWvcrqg2
         7indwqUh6I5K3+KxRibWoHERXHBYSKFPJh18Ngj4ThgV+p9e6kPzYk0eiO9TtoerTwhZ
         hMBfe8ksxvE9ZL+POeJdQRk41aXT1hBZmHwtGZG9DO2f7h8YrS6siDfeD6UBOPOBQ975
         jP0g==
X-Gm-Message-State: AFqh2kqERaGMn2bS3AagRS05FRC55OkqRVH3wUkeV7/bm3Lt4xBADEWS
        uToDidx5gnHd0e9r5AYiHAHTDYiM46410A==
X-Google-Smtp-Source: AMrXdXtJpcS4NIBmGgsDaZpo9OaNIXQ1UlU/ErM9ZHM94eINVNBChY6vU6UAE7G1rDj1TPpd8jynWg==
X-Received: by 2002:ac8:4689:0:b0:3a9:9c6a:afdf with SMTP id g9-20020ac84689000000b003a99c6aafdfmr87850210qto.50.1673088943506;
        Sat, 07 Jan 2023 02:55:43 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id x14-20020a05620a258e00b006e07228ed53sm1993735qko.18.2023.01.07.02.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 02:55:42 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id j206so4363246ybj.1;
        Sat, 07 Jan 2023 02:55:41 -0800 (PST)
X-Received: by 2002:a25:d103:0:b0:75d:3ecb:1967 with SMTP id
 i3-20020a25d103000000b0075d3ecb1967mr4975308ybg.604.1673088941335; Sat, 07
 Jan 2023 02:55:41 -0800 (PST)
MIME-Version: 1.0
References: <20230107040203.never.112-kees@kernel.org>
In-Reply-To: <20230107040203.never.112-kees@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 7 Jan 2023 11:55:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdURtDNzzaoBM4DpEHKiDsgnA-7Yc9QO=5gsmwz9PHWK5w@mail.gmail.com>
Message-ID: <CAMuHMdURtDNzzaoBM4DpEHKiDsgnA-7Yc9QO=5gsmwz9PHWK5w@mail.gmail.com>
Subject: Re: [PATCH] kunit: memcpy: Split slow memcpy tests into MEMCPY_SLOW_KUNIT_TEST
To:     Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, David Gow <davidgow@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Sat, Jan 7, 2023 at 5:02 AM Kees Cook <keescook@chromium.org> wrote:
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

Thanks for your patch!

> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2621,6 +2621,15 @@ config MEMCPY_KUNIT_TEST
>
>           If unsure, say N.
>
> +config MEMCPY_SLOW_KUNIT_TEST
> +       tristate "Include exhaustive memcpy tests" if !KUNIT_ALL_TESTS

Why the tristate?

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

So I can't make the slower tests available for when I need them,
but not run them by default?
I guess that's why you made MEMCPY_SLOW_KUNIT_TEST tristate originally,
to have a separate module with the slow tests?

> +               return -EBUSY;
> +       }
>
>         /* Get many bit patterns. */
>         get_random_bytes(large_src, ARRAY_SIZE(large_src));

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

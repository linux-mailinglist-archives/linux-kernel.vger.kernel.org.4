Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63EE656511
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 21:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiLZU4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 15:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLZU4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 15:56:50 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CC02704
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 12:56:48 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id x11so9166710qtv.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 12:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uVJgWXaR1D47xBylteAG+rfamxPgLPiOGu3TSqTrg8o=;
        b=Jkyg0v/siJQ3qDWPnHXA9CkB/7bWzWF+L6lTJkHUWIlDBkmbHiO3nJOBiCj7zVH8pu
         OeT0a4f9apG2rhndzwAtfczF+5xkdqwzPZaOkW7B4Z6ZXGZrQeROVuCtBmYR0ub4bROS
         UmgXXRoXWuXgHPYfjVeVC93F1s2uCnZyHVMPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVJgWXaR1D47xBylteAG+rfamxPgLPiOGu3TSqTrg8o=;
        b=QKSLhzLCjoDTawYg4Yb6OJObsu+kB8hGE9Ocj9a7KxxbrRXyppN18JhYjKoWT7YbiA
         EcrybtPHVfTyeHBj+ShGsdudWrxNDf7NaJo9b7CNMwYvmaJs47+bJREJziRdciVkwJh2
         8RZ23YiDuKOGfylvzk5YzPJMz0I52CJLwXw8kx1LndP9iP/MYO1EnHY19i01k6N1spJD
         XDISP4bMRXTvSyCLMr7p4Fn165lxlks4NGhOnrejAMAXbYsi0BZLsY6ajsiMHTY6CrJG
         lo5pf1FYYWibewfSk03oenE0A3Fk/DS8ZPTRGutQwsxQNZyslrPSNL+Vs5RRUXbCCCwK
         xhOA==
X-Gm-Message-State: AFqh2krLVi1elpKpGLbveamLY8CMV3LI969noq5mp993Rp66rU8WjvRZ
        CUlSQuHq7dtvXAqHbtftDkdp6WyOYkmqG1H4
X-Google-Smtp-Source: AMrXdXvbXm7hXm7vXAOxFtuxSU+0ADZZnI3zGtXB7Cdk/cUuirJofsEEfJamhB++RylCqmjAUqbfFQ==
X-Received: by 2002:ac8:43c7:0:b0:3a8:bad:b530 with SMTP id w7-20020ac843c7000000b003a80badb530mr31523699qtn.34.1672088207501;
        Mon, 26 Dec 2022 12:56:47 -0800 (PST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id i3-20020ac87643000000b003a68f5d98c1sm7355220qtr.93.2022.12.26.12.56.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 12:56:46 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id g7so9219854qts.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 12:56:46 -0800 (PST)
X-Received: by 2002:ac8:4e26:0:b0:3a7:648d:23d4 with SMTP id
 d6-20020ac84e26000000b003a7648d23d4mr1062206qtw.180.1672088205819; Mon, 26
 Dec 2022 12:56:45 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221226195206.GA2626419@roeck-us.net>
In-Reply-To: <20221226195206.GA2626419@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Dec 2022 12:56:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=whD1zMyt4c7g6-+tWvVweyb-6oHMT_+ZVHqe1EXwtFpCQ@mail.gmail.com>
Message-ID: <CAHk-=whD1zMyt4c7g6-+tWvVweyb-6oHMT_+ZVHqe1EXwtFpCQ@mail.gmail.com>
Subject: Re: Linux 6.2-rc1
To:     Guenter Roeck <linux@roeck-us.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 11:52 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> fs/f2fs/inline.c: In function 'f2fs_move_inline_dirents':
> include/linux/fortify-string.h:59:33: error: '__builtin_memset' pointer overflow between offset [28, 898293814] and size [-898293787, -1] [-Werror=array-bounds]
> fs/f2fs/inline.c:430:9: note: in expansion of macro 'memset'
>   430 |         memset(dst.bitmap + src.nr_bitmap, 0, dst.nr_bitmap - src.nr_bitmap);
>       |         ^~~~~~

Well, that's unfortunate.

> kernel/kcsan/kcsan_test.c: In function '__report_matches':
> kernel/kcsan/kcsan_test.c:257:1: error: the frame size of 1680 bytes is larger than 1536 bytes
>
> Bisect for both points to commit e240e53ae0abb08 ("mm, slub: add
> CONFIG_SLUB_TINY").  Reverting it on its own is not possible, but
> reverting the following two patches fixes the problem.
>
> 149b6fa228ed mm, slob: rename CONFIG_SLOB to CONFIG_SLOB_DEPRECATED
> e240e53ae0ab mm, slub: add CONFIG_SLUB_TINY

No, I think CONFIG_SLUB_TINY should probably have a

     depends on !COMPILE_TEST

or something like that instead.

It already has a

        depends on SLUB && EXPERT

which is basically supposed to disable it for any normal builds, but
obviously allmodconfig will enable EXPERT etc anyway.

That said, that f2fs case also sounds like this code triggers the
compiler being unhappy, so it might be worth having some clarification
from the f2fs people.

I'm not sure what triggers that problem just on powerpc, and only with
that CONFIG_SLUB_TINY option. Maybe those make_dentry_ptr_inline() and
make_dentry_ptr_block() functions don't get inlined in that case, and
that then makes gcc not see the values for those bitmap sizes?

Does changing the "inline" to "always_inline" perhaps fix the compiler
unpahhiness too?

> sh:defconfig
> sh:shx3_defconfig
>
> Building sh:defconfig ... failed
> --------------
> Error log:
> In file included from <command-line>:
> In function 'follow_pmd_mask',
>     inlined from 'follow_pud_mask' at mm/gup.c:735:9,
>     inlined from 'follow_p4d_mask' at mm/gup.c:752:9,
>     inlined from 'follow_page_mask' at mm/gup.c:809:9:
> include/linux/compiler_types.h:358:45: error: call to '__compiletime_assert_263' declared with attribute error: Unsupported access size for {READ,WRITE}_ONCE().
>   358 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>
> Bisect points to commit 0862ff059c9e ("sh/mm: Make pmd_t similar to pte_t").
> This commit introduces
>
> -typedef struct { unsigned long long pmd; } pmd_t;
> +typedef struct {
> +       struct {
> +               unsigned long pmd_low;
> +               unsigned long pmd_high;
> +       };
> +       unsigned long long pmd;
> +} pmd_t;
>
> That should probably be "typedef union", not "typedef struct".

Yeah. PeterZ?

> Boot tests of arm:xilinx-zynq-a9 fail after
>
> [    5.849451] ci_hdrc ci_hdrc.0: failed to register ULPI interface
> [    5.849577] ci_hdrc: probe of ci_hdrc.0 failed with error -110
>
> Caused by commit 8a7b31d545d3 ("usb: ulpi: defer ulpi_register on
> ulpi_read_id timeout"). Revert is pending.

Good.

> Not exactly a regression, but worth mentioning:
>
> CONFIG_MEMCPY_KUNIT_TEST now sometimes takes several minutes to
> execute in qemu. On top of that, it may result in hung task timeouts
> if the hung task timeout is set to low values (45 seconds and below).
> Example, seen with s390:
>
> ...
> [   18.494320]     ok 2 memcpy_test
> [   52.969037]     ok 3 memcpy_large_test
> ...
> [   52.974505]     ok 4 memmove_test
> [   87.325400]     ok 5 memmove_large_test
> [  143.562760] INFO: task swapper/0:1 blocked for more than 46 seconds.
> ...
> [  143.564441] Call Trace:
> [  143.564689]  [<0000000000f1ec80>] __schedule+0x370/0x720
> [  143.565175]  [<0000000000f1f098>] schedule+0x68/0x110
> [  143.565374]  [<0000000000f278d4>] schedule_timeout+0xc4/0x160
> [  143.565603]  [<0000000000f1fde2>] __wait_for_common+0xda/0x250
> [  143.565816]  [<0000000000903c90>] kunit_try_catch_run+0x98/0x178
> [  143.566029]  [<0000000000f05c9c>] kunit_run_case_catch_errors+0x7c/0xb8
> [  143.566956]  [<00000000009023c0>] kunit_run_tests+0x220/0x638
> ...
>
> That is too much for my test bed. I dropped this test as result. This means
> that extending the tests has, at least in the context of my testing, the
> opposite effect.

Kees? This indeed seems counter-productive..

           Linus

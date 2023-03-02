Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4716A80EB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjCBLTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCBLTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:19:00 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6134F96D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:18:58 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id o2so22035849vss.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 03:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TQxxCnZY2j28H3XZXEchjSlFpSlW7FKHIgkQwAfvbPo=;
        b=XSmgGg4Vhrwx13LxakImOuKcP8Hd8srPhxRdcA2XGuHU+ItKVJ1SpzMTDYcHLVaovG
         ADHAclwU84yGKH/3HdKEkT6bt/kUPx4NO98aFacuvHlcaoYHaOMmLFxjS6ycdYEFQJWD
         xxad3ExG8GXZzCw003iIfJ+36QV6S64/++uOboC8I1MjIY/K+nfLehgmc1dtyohZL5eF
         xOi9GdSoVsOAPq3C2C/gTD6z4g/0v8vlD+4JH1jjzkSWi8bXCmrRzk+6Oeotq4sGzjwI
         c9Q7MVhyxi9dCfP4W+rSPgs/wgdLcWau+rUxxKoMgKzwAjrdn6hNIGSW+LP3b45VbuRN
         xDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQxxCnZY2j28H3XZXEchjSlFpSlW7FKHIgkQwAfvbPo=;
        b=zcDACIGvieGmHDNKaUjO5S8EO2+qNjXaZFcppsMEeTfBHW7CXpOzBjeXxzJcPpw44T
         cOCb+//vTBzpkH4zjLlNAyAVjg2Y+jagnygnVH2aRls4iwi5X87KvJsiQYZnotL7MWlg
         swyG2UYyAmqotvc5a44H9LqaN4zBq/WWZDzBPu7/z5A8klGyTa0TZ3qTKAVQ5JAJlY1Y
         JOuQzI2OUC7uC1JhkM3S80/FN8UOM0ATGMuRRZBlpMqnBO7jD+T63BSD7PwkYnqhLwU3
         rJ+7ElfIeREKKRRqrEJxekFMbTxbjyFMHQGw1ABg0QpfF38W0sXWffdkrr03yeT3BtM3
         fKeQ==
X-Gm-Message-State: AO0yUKUDNPCnxgtaCaLzaasSgfrG5oy2pQZiJoqw+jdvdk9ZUDSWzR3C
        4idxBFCbmwo6Gqbr+37uFFDN6OjhZxNGT8TfxsKqtg==
X-Google-Smtp-Source: AK7set9rSD1tUqVXc5Q87+BIpd8fSrw6HHVOuJMjEBoDuqqy3fkg6Oa7DqbHlEMIQ+ZtCEmxoXCQnMEqkF1KyaESJoY=
X-Received: by 2002:a67:cb06:0:b0:402:99ce:1d9f with SMTP id
 b6-20020a67cb06000000b0040299ce1d9fmr6216969vsl.4.1677755937832; Thu, 02 Mar
 2023 03:18:57 -0800 (PST)
MIME-Version: 1.0
References: <20230301143933.2374658-1-glider@google.com> <20230301143933.2374658-2-glider@google.com>
In-Reply-To: <20230301143933.2374658-2-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 2 Mar 2023 12:18:21 +0100
Message-ID: <CANpmjNOG=T8R=BXO8PUX3FJQnKQfPjNyLGJ0wG5G_4_mHwJ-gA@mail.gmail.com>
Subject: Re: [PATCH 2/4] kmsan: another take at fixing memcpy tests
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foundation.org, dvyukov@google.com, nathan@kernel.org,
        ndesaulniers@google.com, kasan-dev@googlegroups.com
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

On Wed, 1 Mar 2023 at 15:39, 'Alexander Potapenko' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> 5478afc55a21 ("kmsan: fix memcpy tests") uses OPTIMIZER_HIDE_VAR() to
> hide the uninitialized var from the compiler optimizations.
>
> However OPTIMIZER_HIDE_VAR(uninit) enforces an immediate check of
> @uninit, so memcpy tests did not actually check the behavior of memcpy(),
> because they always contained a KMSAN report.
>
> Replace OPTIMIZER_HIDE_VAR() with a file-local asm macro that just
> clobbers the memory, and add a test case for memcpy() that does not
> expect an error report.
>
> Also reflow kmsan_test.c with clang-format.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  mm/kmsan/kmsan_test.c | 43 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 37 insertions(+), 6 deletions(-)
>
> diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> index 088e21a48dc4b..cc98a3f4e0899 100644
> --- a/mm/kmsan/kmsan_test.c
> +++ b/mm/kmsan/kmsan_test.c
> @@ -407,6 +407,36 @@ static void test_printk(struct kunit *test)
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  }
>
> +/*
> + * Prevent the compiler from optimizing @var away. Without this, Clang may
> + * notice that @var is uninitialized and drop memcpy() calls that use it.
> + *
> + * There is OPTIMIZER_HIDE_VAR() in linux/compier.h that we cannot use here,
> + * because it is implemented as inline assembly receiving @var as a parameter
> + * and will enforce a KMSAN check.
> + */
> +#define DO_NOT_OPTIMIZE(var) asm("" ::: "memory")

That's just a normal "barrier()" - use that instead?

> +/*
> + * Test case: ensure that memcpy() correctly copies initialized values.
> + */
> +static void test_init_memcpy(struct kunit *test)
> +{
> +       EXPECTATION_NO_REPORT(expect);
> +       volatile int src;
> +       volatile int dst = 0;
> +
> +       // Ensure DO_NOT_OPTIMIZE() does not cause extra checks.

^^ this comment seems redundant now, given DO_NOT_OPTIMIZE() has a
comment (it's also using //-style comment).

> +       DO_NOT_OPTIMIZE(src);
> +       src = 1;
> +       kunit_info(
> +               test,
> +               "memcpy()ing aligned initialized src to aligned dst (no reports)\n");
> +       memcpy((void *)&dst, (void *)&src, sizeof(src));
> +       kmsan_check_memory((void *)&dst, sizeof(dst));
> +       KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> +}
> +
>  /*
>   * Test case: ensure that memcpy() correctly copies uninitialized values between
>   * aligned `src` and `dst`.
> @@ -420,7 +450,7 @@ static void test_memcpy_aligned_to_aligned(struct kunit *test)
>         kunit_info(
>                 test,
>                 "memcpy()ing aligned uninit src to aligned dst (UMR report)\n");
> -       OPTIMIZER_HIDE_VAR(uninit_src);
> +       DO_NOT_OPTIMIZE(uninit_src);
>         memcpy((void *)&dst, (void *)&uninit_src, sizeof(uninit_src));
>         kmsan_check_memory((void *)&dst, sizeof(dst));
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> @@ -443,7 +473,7 @@ static void test_memcpy_aligned_to_unaligned(struct kunit *test)
>         kunit_info(
>                 test,
>                 "memcpy()ing aligned uninit src to unaligned dst (UMR report)\n");
> -       OPTIMIZER_HIDE_VAR(uninit_src);
> +       DO_NOT_OPTIMIZE(uninit_src);
>         memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
>         kmsan_check_memory((void *)dst, 4);
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> @@ -467,13 +497,14 @@ static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
>         kunit_info(
>                 test,
>                 "memcpy()ing aligned uninit src to unaligned dst - part 2 (UMR report)\n");
> -       OPTIMIZER_HIDE_VAR(uninit_src);
> +       DO_NOT_OPTIMIZE(uninit_src);
>         memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
>         kmsan_check_memory((void *)&dst[4], sizeof(uninit_src));
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  }
>
> -static noinline void fibonacci(int *array, int size, int start) {
> +static noinline void fibonacci(int *array, int size, int start)
> +{
>         if (start < 2 || (start == size))
>                 return;
>         array[start] = array[start - 1] + array[start - 2];
> @@ -482,8 +513,7 @@ static noinline void fibonacci(int *array, int size, int start) {
>
>  static void test_long_origin_chain(struct kunit *test)
>  {
> -       EXPECTATION_UNINIT_VALUE_FN(expect,
> -                                   "test_long_origin_chain");
> +       EXPECTATION_UNINIT_VALUE_FN(expect, "test_long_origin_chain");
>         /* (KMSAN_MAX_ORIGIN_DEPTH * 2) recursive calls to fibonacci(). */
>         volatile int accum[KMSAN_MAX_ORIGIN_DEPTH * 2 + 2];
>         int last = ARRAY_SIZE(accum) - 1;
> @@ -515,6 +545,7 @@ static struct kunit_case kmsan_test_cases[] = {
>         KUNIT_CASE(test_uaf),
>         KUNIT_CASE(test_percpu_propagate),
>         KUNIT_CASE(test_printk),
> +       KUNIT_CASE(test_init_memcpy),
>         KUNIT_CASE(test_memcpy_aligned_to_aligned),
>         KUNIT_CASE(test_memcpy_aligned_to_unaligned),
>         KUNIT_CASE(test_memcpy_aligned_to_unaligned2),
> --
> 2.39.2.722.g9855ee24e9-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20230301143933.2374658-2-glider%40google.com.

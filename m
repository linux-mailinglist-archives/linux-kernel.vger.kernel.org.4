Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B6D6A9A13
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCCPAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjCCPAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:00:42 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E254B62D99
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 07:00:34 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id m5so1806154uae.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 07:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677855634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ARdODDyEMP84oqzwuXABwvOYvSOQTabE/Zfw0C3mMnU=;
        b=jf6Q6kvx5e+3XsYxUCIuH0FON0AOL3HP1AQGBsQWNQESjtEPmqSw5czUjcojBInnCL
         BlMe7se/fQ+sR+LHr2a16P7iz5lDohlQZ+K6Co5qm0Xjkfz12uH8Tb/mIFP8aCF+bXOZ
         L5v00/PVD13fey8QhXDHS9nMcJB4uyzIcLwUkEQQnG4Tb9b/bHjIKTCvTJmNacd7avae
         0ei9X1fsyJeH0kjZSPIxdv5U7gGDr5ukzjQtnrzz7ioc+AwTWcrq6CWqnCbwpl6KMsXF
         +GHZh/HDMdQ/EdnJNW7NU6F4UH+eDT/nqJ2RXioQqLdnrcHtYs0JedcxmPTlZszYg4tV
         QErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677855634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ARdODDyEMP84oqzwuXABwvOYvSOQTabE/Zfw0C3mMnU=;
        b=CfE/cUfDBWJIIZfsaiAZRbmT09rT0C5zwwoC/ZTJ/dpLr+M775DLdkxTRYIZtbi7fI
         W9lU4AZgeRq/YbWy5xgPpXpZet2WgRs8/hzmMx0HmhBUPgok44/6GYOUBJqqyPnqdNrb
         c0x8DE1P8aXRCgdKmAXJA/fWSv0EpjWW4kspZfWeJQFJcXMEcVHbZQTz53H3ht4rql2k
         K8XYotuPixU3BoRC6zNRAj9vPbI4E4A8LXfB/H0t7QyONy3JnY08gyUFG07OnQ5gqkI6
         wRlIa0E8K07iPglQz/DCFOVMOzu9/2qTWUqLCtb7E4OEUk22q3oahnNY7Yw/hAGav2lH
         +7XA==
X-Gm-Message-State: AO0yUKXRLl9G0uZt4pn5IuIBYiWZsJ8RxUZuGEJVt8Wjxi4SwgUncbmR
        QeruaxvxooUEgpl2GpR69zOFyd8jTQtZTktgHs+iAQ==
X-Google-Smtp-Source: AK7set9mhMp8/9K2QjoSQXw5FO6oGqsxf3qkEkrYI0aONmNxBenh/Z5RyFbjC5WnrWNlqWnyqsh0MonmyGaid/KO+Zc=
X-Received: by 2002:a1f:2dcb:0:b0:401:42e5:6d2e with SMTP id
 t194-20020a1f2dcb000000b0040142e56d2emr1462853vkt.1.1677855633776; Fri, 03
 Mar 2023 07:00:33 -0800 (PST)
MIME-Version: 1.0
References: <20230303141433.3422671-1-glider@google.com> <20230303141433.3422671-2-glider@google.com>
In-Reply-To: <20230303141433.3422671-2-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 3 Mar 2023 15:59:57 +0100
Message-ID: <CANpmjNNT29Zyv78-ZieTQg_kexQrkvOJOVikgH0SzCdve5yygw@mail.gmail.com>
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

On Fri, 3 Mar 2023 at 15:14, Alexander Potapenko <glider@google.com> wrote:
>
> commit 5478afc55a21 ("kmsan: fix memcpy tests") uses OPTIMIZER_HIDE_VAR()
> to hide the uninitialized var from the compiler optimizations.
>
> However OPTIMIZER_HIDE_VAR(uninit) enforces an immediate check of
> @uninit, so memcpy tests did not actually check the behavior of memcpy(),
> because they always contained a KMSAN report.
>
> Replace OPTIMIZER_HIDE_VAR() with a file-local macro that just clobbers
> the memory with a barrier(), and add a test case for memcpy() that does not
> expect an error report.
>
> Also reflow kmsan_test.c with clang-format.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> v2:
>  - replace inline assembly with a barrier(), update comments

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kmsan/kmsan_test.c | 44 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
>
> diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> index 088e21a48dc4b..aeddfdd4f679f 100644
> --- a/mm/kmsan/kmsan_test.c
> +++ b/mm/kmsan/kmsan_test.c
> @@ -407,6 +407,37 @@ static void test_printk(struct kunit *test)
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  }
>
> +/*
> + * Prevent the compiler from optimizing @var away. Without this, Clang may
> + * notice that @var is uninitialized and drop memcpy() calls that use it.
> + *
> + * There is OPTIMIZER_HIDE_VAR() in linux/compier.h that we cannot use here,
> + * because it is implemented as inline assembly receiving @var as a parameter
> + * and will enforce a KMSAN check. Same is true for e.g. barrier_data(var).
> + */
> +#define DO_NOT_OPTIMIZE(var) barrier()
> +
> +/*
> + * Test case: ensure that memcpy() correctly copies initialized values.
> + * Also serves as a regression test to ensure DO_NOT_OPTIMIZE() does not cause
> + * extra checks.
> + */
> +static void test_init_memcpy(struct kunit *test)
> +{
> +       EXPECTATION_NO_REPORT(expect);
> +       volatile int src;
> +       volatile int dst = 0;
> +
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
> @@ -420,7 +451,7 @@ static void test_memcpy_aligned_to_aligned(struct kunit *test)
>         kunit_info(
>                 test,
>                 "memcpy()ing aligned uninit src to aligned dst (UMR report)\n");
> -       OPTIMIZER_HIDE_VAR(uninit_src);
> +       DO_NOT_OPTIMIZE(uninit_src);
>         memcpy((void *)&dst, (void *)&uninit_src, sizeof(uninit_src));
>         kmsan_check_memory((void *)&dst, sizeof(dst));
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> @@ -443,7 +474,7 @@ static void test_memcpy_aligned_to_unaligned(struct kunit *test)
>         kunit_info(
>                 test,
>                 "memcpy()ing aligned uninit src to unaligned dst (UMR report)\n");
> -       OPTIMIZER_HIDE_VAR(uninit_src);
> +       DO_NOT_OPTIMIZE(uninit_src);
>         memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
>         kmsan_check_memory((void *)dst, 4);
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> @@ -467,13 +498,14 @@ static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
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
> @@ -482,8 +514,7 @@ static noinline void fibonacci(int *array, int size, int start) {
>
>  static void test_long_origin_chain(struct kunit *test)
>  {
> -       EXPECTATION_UNINIT_VALUE_FN(expect,
> -                                   "test_long_origin_chain");
> +       EXPECTATION_UNINIT_VALUE_FN(expect, "test_long_origin_chain");
>         /* (KMSAN_MAX_ORIGIN_DEPTH * 2) recursive calls to fibonacci(). */
>         volatile int accum[KMSAN_MAX_ORIGIN_DEPTH * 2 + 2];
>         int last = ARRAY_SIZE(accum) - 1;
> @@ -515,6 +546,7 @@ static struct kunit_case kmsan_test_cases[] = {
>         KUNIT_CASE(test_uaf),
>         KUNIT_CASE(test_percpu_propagate),
>         KUNIT_CASE(test_printk),
> +       KUNIT_CASE(test_init_memcpy),
>         KUNIT_CASE(test_memcpy_aligned_to_aligned),
>         KUNIT_CASE(test_memcpy_aligned_to_unaligned),
>         KUNIT_CASE(test_memcpy_aligned_to_unaligned2),
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog
>

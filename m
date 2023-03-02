Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937A66A80F2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCBLXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBLXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:23:17 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3F3FF2E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:23:16 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id f23so22005690vsa.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 03:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXJcpekVJsbf05nQkG74Sggw1Qq7M2Hhxe/99xjhW+0=;
        b=PIN9Xd0BS6NZmE7GIp9DfduhYOcFG5F3437KwQbDfTMk+mHR9ICEpZcUJWafSRmI2n
         9/hB6hmJmyTZlDgR223DpQt7V8PfZUNWKRqwi2sU+/LS8rHYQmF9otH1guS2aYX1IfCC
         wmFl+5l/Hl0d4ab6+Mn8YficsrHpAwgpyEsmVrCnQVzfKqNqaKIn6eZHcNLfGdooz1Hk
         Pr7Ifvdokus8dk60vHGd7RY6t5LFyGHyn6xfoR4cIaFmdRCU3c2ttyo/LI9/MwtcdyW0
         0KvJWY7AZd/LalYwL2JDhTdDnIhUxygnFD4v1GEJZYez0LCKBTdjTITCIaMVt67g4AAQ
         cJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXJcpekVJsbf05nQkG74Sggw1Qq7M2Hhxe/99xjhW+0=;
        b=jYvTDHYd7aXhld6M1KeUr+lviHVH1qagI2aeA1RomK6Jo/i7fcmlgOu84b5xrw9/gu
         pQeL9RVIRom2argzLOZw5ilzhSz4og6Q9yur5BOqNXsJpXEGu0DUB/wRseudg/wSqDiy
         RYmtHmcpsZ8rBnEtfeYzZLcKObQ4WJr1VtKFwVlEVT3w5iJpLyID6BvCr69nZuexrSlj
         3Sa9BJ7T/u/IVdTZi2FPazgQeVOPOOiJO1+kSrBDEotnBDCICX0Fh8xB17FI2LdVxqnd
         uwZ7iOJEaxu8ebWra1KS00QskHhKLAxWBYSj+03s1a3NcexgfXSsW1NqqTzkNBCLCwj8
         CHhA==
X-Gm-Message-State: AO0yUKWAfNB7xd/RRQgJ0La82wdYt8Vi9Go1safrsALYVfaQs7eP5/e8
        2BE4hwCu/OIOs1+HQ7utPeP6WWcJM7kC1SjdBHKj9w==
X-Google-Smtp-Source: AK7set/jIWJRqDWo7AdMl27Z2cGJ9tTD2Y9soJ5svr/gGiePeoQZ21mQhPpNv0T6BykpxNdBwtsC0lwsoVbx2Cuv/2A=
X-Received: by 2002:a05:6102:10c5:b0:412:6a3:2276 with SMTP id
 t5-20020a05610210c500b0041206a32276mr6437205vsr.4.1677756195604; Thu, 02 Mar
 2023 03:23:15 -0800 (PST)
MIME-Version: 1.0
References: <20230301143933.2374658-1-glider@google.com> <20230301143933.2374658-4-glider@google.com>
In-Reply-To: <20230301143933.2374658-4-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 2 Mar 2023 12:22:39 +0100
Message-ID: <CANpmjNO0GBpfRbT1YnNnoupVG7TOcuBbTHzxNyZwdJaH3W7w5g@mail.gmail.com>
Subject: Re: [PATCH 4/4] kmsan: add memsetXX tests
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

On Wed, 1 Mar 2023 at 15:39, Alexander Potapenko <glider@google.com> wrote:
>
> Add tests ensuring that memset16()/memset32()/memset64() are
> instrumented by KMSAN and correctly initialize the memory.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  mm/kmsan/kmsan_test.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> index cc98a3f4e0899..e450a000441fb 100644
> --- a/mm/kmsan/kmsan_test.c
> +++ b/mm/kmsan/kmsan_test.c
> @@ -503,6 +503,25 @@ static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  }
>
> +/* Generate test cases for memset16(), memset32(), memset64(). */
> +#define DEFINE_TEST_MEMSETXX(size, var_ty)                                  \
> +       static void test_memset##size(struct kunit *test)                   \
> +       {                                                                   \
> +               EXPECTATION_NO_REPORT(expect);                              \
> +               volatile var_ty uninit;                                     \

This could just be 'uint##size##_t' and you can drop 'var_ty'.

> +                                                                            \
> +               kunit_info(test,                                            \
> +                          "memset" #size "() should initialize memory\n"); \
> +               DO_NOT_OPTIMIZE(uninit);                                    \
> +               memset##size((var_ty *)&uninit, 0, 1);                      \
> +               kmsan_check_memory((void *)&uninit, sizeof(uninit));        \
> +               KUNIT_EXPECT_TRUE(test, report_matches(&expect));           \
> +       }
> +
> +DEFINE_TEST_MEMSETXX(16, uint16_t)
> +DEFINE_TEST_MEMSETXX(32, uint32_t)
> +DEFINE_TEST_MEMSETXX(64, uint64_t)
> +
>  static noinline void fibonacci(int *array, int size, int start)
>  {
>         if (start < 2 || (start == size))
> @@ -549,6 +568,9 @@ static struct kunit_case kmsan_test_cases[] = {
>         KUNIT_CASE(test_memcpy_aligned_to_aligned),
>         KUNIT_CASE(test_memcpy_aligned_to_unaligned),
>         KUNIT_CASE(test_memcpy_aligned_to_unaligned2),
> +       KUNIT_CASE(test_memset16),
> +       KUNIT_CASE(test_memset32),
> +       KUNIT_CASE(test_memset64),
>         KUNIT_CASE(test_long_origin_chain),
>         {},
>  };
> --
> 2.39.2.722.g9855ee24e9-goog
>

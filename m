Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D496269A9C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjBQLIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjBQLIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:08:07 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484272A153;
        Fri, 17 Feb 2023 03:07:41 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x8so484171pfh.3;
        Fri, 17 Feb 2023 03:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F6OARyIkWKx6vJWW66deXzKz0d7MrJOxrFV4HQAbnVY=;
        b=G5719LGs7IEAbHMfcATHoXsEMKBorQVayLPlVTxXcSIXDsNpJsf1lFpXYEBTrjXAWS
         dzMyjBVcT8Sr8JR4KCMS9H0Hvs4vndlMY3puCh+lkXmoohJmVHaEvQeTG3/FqeS/PK4Z
         DS3GCJ3d4s7bp5R8SOMWfVKSz5SXkylFRlT9tiv42XiRwbGfQ0oRbBjRARLA4p8MhCnl
         noOICmrMWnb2Ow+4WaBlZf0/+8G1zf4GOM0LpElwoB9InBNnDh3mZGR6EPqR9pLqaFVo
         siNSMrqX231aLRisjnqTKzwj1KSdZ15quiOFF3zy7CiKhCeemNW3NLjqpiyFiNwV09MO
         siaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6OARyIkWKx6vJWW66deXzKz0d7MrJOxrFV4HQAbnVY=;
        b=5DO7amahCp/Cv7MI2t42ftq3kRO13g13B4n/NhM9hjb4LMvc61qT8fUBeqsJFrLQcv
         KzuTs71htltjRzkkI7A+EZjznMx4JGVimFA0ez10uYczcb6KL7daX7FC2G1Q8t48bOZa
         d3gmG6+ET2UMT2JjN40/VUIIFXIOZ0GmEfZruJhj/a58hXV7ZYynQbVxHdiTNy6vUKTb
         6hZzP+/8Yfv75ORIDFJb+adQozZbPvAIRKLyz8IhXGGlhUkk2HlxOBYti2fkycBEqtQt
         +zAF2IeTw1wGjIiQYI18iPfEJ78mbXQieBr30hSHEUNDW3Rpc1ZS1/3rL0FJ3BTdvqC9
         aQMA==
X-Gm-Message-State: AO0yUKULRCqFNRzzNe640iAPY3BN0cW5j3XJD0Ob5BOj8xCbS00upsHK
        CCtdvSsb3OvCgsMepCl4mY6AR9wcxvYmYPe01cU=
X-Google-Smtp-Source: AK7set8IyTOPVdJ0YgCP8kRvR8GDnZO4IFniF640kKrZ8oFaXpTMTUV6YpOuhdXoBmiiiIpDMZ3oyFO0CXM24opVnGM=
X-Received: by 2002:a62:8282:0:b0:5a9:c954:563e with SMTP id
 w124-20020a628282000000b005a9c954563emr240181pfd.6.1676632059648; Fri, 17 Feb
 2023 03:07:39 -0800 (PST)
MIME-Version: 1.0
References: <20230216234522.3757369-1-elver@google.com> <20230216234522.3757369-3-elver@google.com>
In-Reply-To: <20230216234522.3757369-3-elver@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 17 Feb 2023 12:07:28 +0100
Message-ID: <CA+fCnZdsiWjpp9qjsy16SSuOcaOgnk2h6vC+dq6h8GUrqdF1bw@mail.gmail.com>
Subject: Re: [PATCH -tip v4 3/3] kasan: test: Fix test for new meminstrinsic instrumentation
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        linux-toolchains@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 12:45 AM Marco Elver <elver@google.com> wrote:
>
> The tests for memset/memmove have been failing since they haven't been
> instrumented in 69d4c0d32186.
>
> Fix the test to recognize when memintrinsics aren't instrumented, and
> skip test cases accordingly. We also need to conditionally pass
> -fno-builtin to the test, otherwise the instrumentation pass won't
> recognize memintrinsics and end up not instrumenting them either.
>
> Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v4:
> * New patch.
> ---
>  mm/kasan/Makefile     |  9 ++++++++-
>  mm/kasan/kasan_test.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index d4837bff3b60..7634dd2a6128 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -35,7 +35,14 @@ CFLAGS_shadow.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_hw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_sw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
>
> -CFLAGS_KASAN_TEST := $(CFLAGS_KASAN) -fno-builtin $(call cc-disable-warning, vla)
> +CFLAGS_KASAN_TEST := $(CFLAGS_KASAN) $(call cc-disable-warning, vla)
> +ifndef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> +# If compiler instruments memintrinsics by prefixing them with __asan/__hwasan,
> +# we need to treat them normally (as builtins), otherwise the compiler won't
> +# recognize them as instrumentable. If it doesn't instrument them, we need to
> +# pass -fno-builtin, so the compiler doesn't inline them.
> +CFLAGS_KASAN_TEST += -fno-builtin
> +endif
>
>  CFLAGS_kasan_test.o := $(CFLAGS_KASAN_TEST)
>  CFLAGS_kasan_test_module.o := $(CFLAGS_KASAN_TEST)
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index 74cd80c12b25..627eaf1ee1db 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -165,6 +165,15 @@ static void kasan_test_exit(struct kunit *test)
>                 kunit_skip((test), "Test requires " #config "=n");      \
>  } while (0)
>
> +#define KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test) do {              \
> +       if (IS_ENABLED(CONFIG_KASAN_HW_TAGS))                           \
> +               break;  /* No compiler instrumentation. */              \
> +       if (IS_ENABLED(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX))        \
> +               break;  /* Should always be instrumented! */            \
> +       if (IS_ENABLED(CONFIG_GENERIC_ENTRY))                           \
> +               kunit_skip((test), "Test requires checked mem*()");     \
> +} while (0)
> +
>  static void kmalloc_oob_right(struct kunit *test)
>  {
>         char *ptr;
> @@ -454,6 +463,8 @@ static void kmalloc_oob_16(struct kunit *test)
>                 u64 words[2];
>         } *ptr1, *ptr2;
>
> +       KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
> +
>         /* This test is specifically crafted for the generic mode. */
>         KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
>
> @@ -476,6 +487,8 @@ static void kmalloc_uaf_16(struct kunit *test)
>                 u64 words[2];
>         } *ptr1, *ptr2;
>
> +       KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
> +
>         ptr1 = kmalloc(sizeof(*ptr1), GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
>
> @@ -498,6 +511,8 @@ static void kmalloc_oob_memset_2(struct kunit *test)
>         char *ptr;
>         size_t size = 128 - KASAN_GRANULE_SIZE;
>
> +       KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
> +
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> @@ -511,6 +526,8 @@ static void kmalloc_oob_memset_4(struct kunit *test)
>         char *ptr;
>         size_t size = 128 - KASAN_GRANULE_SIZE;
>
> +       KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
> +
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> @@ -524,6 +541,8 @@ static void kmalloc_oob_memset_8(struct kunit *test)
>         char *ptr;
>         size_t size = 128 - KASAN_GRANULE_SIZE;
>
> +       KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
> +
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> @@ -537,6 +556,8 @@ static void kmalloc_oob_memset_16(struct kunit *test)
>         char *ptr;
>         size_t size = 128 - KASAN_GRANULE_SIZE;
>
> +       KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
> +
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> @@ -550,6 +571,8 @@ static void kmalloc_oob_in_memset(struct kunit *test)
>         char *ptr;
>         size_t size = 128 - KASAN_GRANULE_SIZE;
>
> +       KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
> +
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> @@ -566,6 +589,8 @@ static void kmalloc_memmove_negative_size(struct kunit *test)
>         size_t size = 64;
>         size_t invalid_size = -2;
>
> +       KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
> +
>         /*
>          * Hardware tag-based mode doesn't check memmove for negative size.
>          * As a result, this test introduces a side-effect memory corruption,
> @@ -590,6 +615,8 @@ static void kmalloc_memmove_invalid_size(struct kunit *test)
>         size_t size = 64;
>         size_t invalid_size = size;
>
> +       KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
> +
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> @@ -618,6 +645,8 @@ static void kmalloc_uaf_memset(struct kunit *test)
>         char *ptr;
>         size_t size = 33;
>
> +       KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
> +
>         /*
>          * Only generic KASAN uses quarantine, which is required to avoid a
>          * kernel memory corruption this test causes.
> --
> 2.39.2.637.g21b0678d19-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you for taking care of all of this, Marco!

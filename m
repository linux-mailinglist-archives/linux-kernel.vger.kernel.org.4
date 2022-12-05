Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5A5642A22
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiLEOMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiLEOMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:12:05 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CE3E0A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 06:12:03 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id i186so2438980ybc.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 06:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xkjm5Izlgm5W/aCda9yUcdLforY0vsBW8J+dAEU4QI0=;
        b=LutcpLDlD1QUswgOL8FLDDs2fNhaFdhLT+t5r1Ri2e4Xf36LuAn+hl2F/MLSHqV6iQ
         d4Ip0sujOw2tB9ENYLU1bJxv6P9jpniNrgssolh9jO+QMVbXuVKxpqWdc3c56rBTs4Uq
         xIqysrgRzmIghwnEt9LHkN0hdZn3iogj2LnVxyefjyPFwjn6xjStqQyXzD6lZolJCsr6
         G+UIyj4pn6Rp9c+CzKLlm/RUXDWAdK4jhlGyD9CUFUYaJAvdU5r8F7dIB0sZzY1pnv9r
         p1uFaSgW7qXoaZWgzaCDrjMb6xsK3NIg1T8fTsBbxR9agtwhqfqfUErRSE3WNP69gS59
         S2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkjm5Izlgm5W/aCda9yUcdLforY0vsBW8J+dAEU4QI0=;
        b=fVCNKP0thVBkH7sVIQwue+rso6Nuf609fBrLlGmFpLVXljhHhikKcaFB9+8zCLW6UC
         Kr15IoE2viSISyIiiB5tMnAK8zW3xBEqOy2QCK1iZ7sI336FR2lAmXmZJ+cFj0CBInwm
         vtEDZPphR4sHN5ToJwLIX5nQEAOaiYMTjarsGntn0BxYPGqTEaTO1aVSq15/7cOmu8eB
         mnSQwmRm8W2y51YW24jIfCtoOjDutWBt3sA6AYmTnjIFyw/u57aF7VhTL6FeGDCp3dcZ
         0UV6vp+5K+z03FHOtQOiIL28vuxFLoWfol0QGnsujUsGmNp3lsf8Lp74zTZZh63rF0ni
         TNDw==
X-Gm-Message-State: ANoB5pnzDux7eQJW14Dt+sqZU7gK0Y24W+gBj/cSXJJUwhtC+RJsHB1g
        i3Bop5eH5VA6XAli7swKahC0sx4B+/KtpHOJQWthrgGn19ygag==
X-Google-Smtp-Source: AA0mqf66InUYQ4jV/zsNVu7Ndu4kgqu5ytNd5eYn74cJmXovyhEswE58lpm+TRdzeAqh5oHcIJQkslIJPyLM6PyqGes=
X-Received: by 2002:a25:3851:0:b0:6f0:6175:2cc7 with SMTP id
 f78-20020a253851000000b006f061752cc7mr53224010yba.93.1670249522735; Mon, 05
 Dec 2022 06:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20221205132558.63484-1-glider@google.com>
In-Reply-To: <20221205132558.63484-1-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 5 Dec 2022 15:11:26 +0100
Message-ID: <CANpmjNOrm1ED1tRSy9Ap+48zHCrfw1yRffx1G9YHGLt-BtH90g@mail.gmail.com>
Subject: Re: [PATCH] kmsan: fix memcpy tests
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dvyukov@google.com, linux-mm@kvack.org
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

On Mon, 5 Dec 2022 at 14:26, Alexander Potapenko <glider@google.com> wrote:
>
> Recent Clang changes may cause it to delete calls of memcpy(), if the
> source is an uninitialized volatile local.
> This happens because passing a pointer to a volatile local into memcpy()
> discards the volatile qualifier, giving the compiler a free hand to
> optimize the memcpy() call away.
>
> To outsmart the compiler, we call __msan_memcpy() instead of memcpy()
> in test_memcpy_aligned_to_aligned(), test_memcpy_aligned_to_unaligned()
> and test_memcpy_aligned_to_unaligned2(), because it's the behavior of
> __msan_memcpy() we are testing here anyway.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

It might be nice to retain memcpy() calls somehow, as that tests
end-to-end that the compiler does the right thing here i.e. replacing
the memcpy() calls with instrumented versions.

Does OPTIMIZER_HIDE_VAR() help? This should prevent the compiler from
seeing it's uninitialized.

> ---
>  mm/kmsan/kmsan_test.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> index 9a29ea2dbfb9b..8e4f206a900ae 100644
> --- a/mm/kmsan/kmsan_test.c
> +++ b/mm/kmsan/kmsan_test.c
> @@ -406,6 +406,16 @@ static void test_printk(struct kunit *test)
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  }
>
> +/*
> + * The test_memcpy_xxx tests below should be calling memcpy() to copy an
> + * uninitialized value from a volatile int. But such calls discard the volatile
> + * qualifier, so Clang may optimize them away, breaking the tests.
> + * Because KMSAN instrumentation pass would just replace memcpy() with
> + * __msan_memcpy(), do that explicitly to trick the optimizer into preserving
> + * the calls.
> + */
> +void *__msan_memcpy(void *, const void *, size_t);
> +
>  /*
>   * Test case: ensure that memcpy() correctly copies uninitialized values between
>   * aligned `src` and `dst`.
> @@ -419,7 +429,7 @@ static void test_memcpy_aligned_to_aligned(struct kunit *test)
>         kunit_info(
>                 test,
>                 "memcpy()ing aligned uninit src to aligned dst (UMR report)\n");
> -       memcpy((void *)&dst, (void *)&uninit_src, sizeof(uninit_src));
> +       __msan_memcpy((void *)&dst, (void *)&uninit_src, sizeof(uninit_src));
>         kmsan_check_memory((void *)&dst, sizeof(dst));
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  }
> @@ -441,7 +451,7 @@ static void test_memcpy_aligned_to_unaligned(struct kunit *test)
>         kunit_info(
>                 test,
>                 "memcpy()ing aligned uninit src to unaligned dst (UMR report)\n");
> -       memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
> +       __msan_memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
>         kmsan_check_memory((void *)dst, 4);
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  }
> @@ -464,7 +474,7 @@ static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
>         kunit_info(
>                 test,
>                 "memcpy()ing aligned uninit src to unaligned dst - part 2 (UMR report)\n");
> -       memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
> +       __msan_memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
>         kmsan_check_memory((void *)&dst[4], sizeof(uninit_src));
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  }
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog
>

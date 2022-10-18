Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6509A6032A5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJRSkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiJRSkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:40:06 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958DC4E619
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:40:02 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id fw14so14836756pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F4eD4rv8AiiMXaxAhbdeV46dd3yYa3AhkQEwj0mAajQ=;
        b=KFK9t6HLlzZyDhtW3A4hfP/doAvobb3pchBBuBuSCE95IpvfME/jsHXV+JzO3npy9p
         FlQPCMT7S68QUiix2drxX61yDq8jn/vFY8LysHe/765t4u5Prj+syRWrF71pxH4O9vFG
         Zt9OjtfPVjW/kk9TF1e4THmvCX5L3WmJAYIvNbZ2i5Z7TMUVlpBct644rQeA2REOhHSQ
         xbl98rNKsaRcjUpFQBcZpFSerPX2YE8z8Poe6NX1dGEFr4vXCybMMG8APgFIAenD7uGH
         kbrSSAreGMD/v9uihynLYsrff39si5+pvdsENmiZYVoNeL4cI3wCkDc2VTC5CLuO5R2W
         tC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4eD4rv8AiiMXaxAhbdeV46dd3yYa3AhkQEwj0mAajQ=;
        b=Dnh7EcPmaaAbH1THHjIjx3v7n4u9fMHXEFPexYN0C2sgAPcGMNk9G8HAGn9liysnbg
         f2rsNPv3Xqxf/BRc1noDBeVWN+1P0RRS5urk6gv7QyGGp6wZvY3RQS6FTpRcqULc8dA+
         GrHdfrgcTMunrKOfnxprM+NTXM5qoCmuglatZnDLcyfFOnvXPXCVM8TtQODtwT34SiGy
         1uBWhIg46h6tPsZg4iOBGCHunjPm+bLfMBvsQmH6r3IIBL12Q5sJtKKy+8x9KAeFuaJ8
         o5ChJFCwtIoM9F1cpnmBVw6G+3qSLroDVe3BZGuUDvmgAvILQ1ijDZUsevtZpUIFm9TD
         tfTw==
X-Gm-Message-State: ACrzQf1NblpDuf06gIHUjE1Rjv0UlngDQGMhRfjIMbnEc1hUvhDbNwjF
        OHB9zjMaPwP6nvxARoGOMWs6vtvzAPnychODozJTkw6yorqsZQ==
X-Google-Smtp-Source: AMsMyM5wZQ0xZpC//R2A/iaSnFL0H/24M1Q0whOO/N5iWExP4leMdNgBqX8O/7CAxnfKKN1fJRrxHUR/X3utMG6iIsY=
X-Received: by 2002:a17:90b:1a8d:b0:20d:be0b:a320 with SMTP id
 ng13-20020a17090b1a8d00b0020dbe0ba320mr26480711pjb.107.1666118401853; Tue, 18
 Oct 2022 11:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221018082038.gonna.300-kees@kernel.org>
In-Reply-To: <20221018082038.gonna.300-kees@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Oct 2022 11:39:50 -0700
Message-ID: <CAKwvOdnHz9yW1XcnY_hAz9ux5TPeXrzUyDxmmR+mxzntG+XZuQ@mail.gmail.com>
Subject: Re: [PATCH v2] kunit/memcpy: Adding dynamic size and window tests
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

 On Tue, Oct 18, 2022 at 1:21 AM Kees Cook <keescook@chromium.org> wrote:
>
> The "side effects" memmove() test accidentally found[1] a corner case in
> the recent refactoring of the i386 assembly memmove(), but missed another
> corner case. Instead of hoping to get lucky next time, implement much
> more complete tests of memcpy() and memmove() -- especially the moving
> window overlap for memmove() -- which catches all the issues encountered
> and should catch anything new.
>
> [1] https://lore.kernel.org/lkml/CAKwvOdkaKTa2aiA90VzFrChNQM6O_ro+b7VWs=op70jx-DKaXA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Minor comments on qualifiers/storage/int vs stize_t below.

> ---
>  MAINTAINERS        |   1 +
>  lib/memcpy_kunit.c | 205 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 206 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf0f18502372..9dd8d74c4df0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8044,6 +8044,7 @@ S:        Supported
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
>  F:     include/linux/fortify-string.h
>  F:     lib/fortify_kunit.c
> +F:     lib/memcpy_kunit.c
>  F:     lib/test_fortify/*
>  F:     scripts/test_fortify.sh
>  K:     \b__NO_FORTIFY\b
> diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> index 2b5cc70ac53f..c4a7107edd43 100644
> --- a/lib/memcpy_kunit.c
> +++ b/lib/memcpy_kunit.c
> @@ -270,6 +270,208 @@ static void memset_test(struct kunit *test)
>  #undef TEST_OP
>  }
>
> +static u8 large_src[1024];
> +static u8 large_dst[2048];
> +static const u8 large_zero[2048];
> +
> +static void set_random_nonzero(struct kunit *test, u8 *byte)
> +{
> +       int failed_rng = 0;
> +
> +       while (*byte == 0) {
> +               get_random_bytes(byte, 1);
> +               KUNIT_ASSERT_LT_MSG(test, failed_rng++, 100,
> +                                   "Is the RNG broken?");
> +       }
> +}
> +
> +static void init_large(struct kunit *test)
> +{
> +
> +       /* Get many bit patterns. */
> +       get_random_bytes(large_src, ARRAY_SIZE(large_src));
> +
> +       /* Make sure we have non-zero edges. */
> +       set_random_nonzero(test, &large_src[0]);
> +       set_random_nonzero(test, &large_src[ARRAY_SIZE(large_src) - 1]);
> +
> +       /* Explicitly zero the entire destination. */
> +       memset(large_dst, 0, ARRAY_SIZE(large_dst));
> +}
> +
> +/*
> + * Instead of an indirect function call for "copy" or a giant macro,
> + * use a bool to pick memcpy or memmove.
> + */
> +static void copy_large_test(struct kunit *test, bool use_memmove)
> +{
> +       init_large(test);
> +
> +       /* Copy a growing number of non-overlapping bytes ... */
> +       for (int bytes = 1; bytes <= ARRAY_SIZE(large_src); bytes++) {
> +               /* Over a shifting destination window ... */
> +               for (int offset = 0; offset < ARRAY_SIZE(large_src); offset++) {
> +                       int right_zero_pos = offset + bytes;
> +                       int right_zero_size = ARRAY_SIZE(large_dst) - right_zero_pos;
> +
> +                       /* Copy! */
> +                       if (use_memmove)
> +                               memmove(large_dst + offset, large_src, bytes);
> +                       else
> +                               memcpy(large_dst + offset, large_src, bytes);
> +
> +                       /* Did we touch anything before the copy area? */
> +                       KUNIT_ASSERT_EQ_MSG(test,
> +                               memcmp(large_dst, large_zero, offset), 0,
> +                               "with size %d at offset %d", bytes, offset);
> +                       /* Did we touch anything after the copy area? */
> +                       KUNIT_ASSERT_EQ_MSG(test,
> +                               memcmp(&large_dst[right_zero_pos], large_zero, right_zero_size), 0,
> +                               "with size %d at offset %d", bytes, offset);
> +
> +                       /* Are we byte-for-byte exact across the copy? */
> +                       KUNIT_ASSERT_EQ_MSG(test,
> +                               memcmp(large_dst + offset, large_src, bytes), 0,
> +                               "with size %d at offset %d", bytes, offset);
> +
> +                       /* Zero out what we copied for the next cycle. */
> +                       memset(large_dst + offset, 0, bytes);
> +               }
> +               /* Avoid stall warnings if this loop gets slow. */
> +               cond_resched();
> +       }
> +}
> +
> +static void memcpy_large_test(struct kunit *test)
> +{
> +       copy_large_test(test, false);
> +}
> +
> +static void memmove_large_test(struct kunit *test)
> +{
> +       copy_large_test(test, true);
> +}
> +
> +/*
> + * On the assumption that boundary conditions are going to be the most
> + * sensitive, instead of taking a full step (inc) each iteration,
> + * take single index steps for at least the first "inc"-many indexes
> + * from the "start" and at least the last "inc"-many indexes before
> + * the "end". When in the middle, take full "inc"-wide steps. For
> + * example, calling next_step(idx, 1, 15, 3) with idx starting at 0
> + * would see the following pattern: 1 2 3 4 7 10 11 12 13 14 15.
> + */
> +static int next_step(int idx, int start, int end, int inc)
> +{
> +       start += inc;
> +       end -= inc;
> +
> +       if (idx < start || idx + inc > end)
> +               inc = 1;
> +       return idx + inc;
> +}

How painful would it be to request that you use size_t for these
(d_off, s_off, most of the variables in inner_loop) rather than int?
It looks like none of the values should be less than 0 IIUC, but I
think it would help make this code more robust if we reuse or update
it in the future.

> +
> +static void inner_loop(struct kunit *test, int bytes, int d_off, int s_off)
> +{
> +       int left_zero_pos, left_zero_size;
> +       int right_zero_pos, right_zero_size;
> +       int src_pos, src_orig_pos, src_size;
> +       int pos;
> +
> +       /* Place the source in the destination buffer. */
> +       memcpy(&large_dst[s_off], large_src, bytes);
> +
> +       /* Copy to destination offset. */
> +       memmove(&large_dst[d_off], &large_dst[s_off], bytes);
> +
> +       /* Make sure destination entirely matches. */
> +       KUNIT_ASSERT_EQ_MSG(test, memcmp(&large_dst[d_off], large_src, bytes), 0,
> +               "with size %d at src offset %d and dest offset %d",
> +               bytes, s_off, d_off);
> +
> +       /* Calculate the expected zero spans. */
> +       if (s_off < d_off) {
> +               left_zero_pos = 0;
> +               left_zero_size = s_off;
> +
> +               right_zero_pos = d_off + bytes;
> +               right_zero_size = ARRAY_SIZE(large_dst) - right_zero_pos;
> +
> +               src_pos = s_off;
> +               src_orig_pos = 0;
> +               src_size = d_off - s_off;
> +       } else {
> +               left_zero_pos = 0;
> +               left_zero_size = d_off;
> +
> +               right_zero_pos = s_off + bytes;
> +               right_zero_size = ARRAY_SIZE(large_dst) - right_zero_pos;
> +
> +               src_pos = d_off + bytes;
> +               src_orig_pos = src_pos - s_off;
> +               src_size = right_zero_pos - src_pos;
> +       }
> +
> +       /* Check non-overlapping source is unchanged.*/
> +       KUNIT_ASSERT_EQ_MSG(test,
> +               memcmp(&large_dst[src_pos], &large_src[src_orig_pos], src_size), 0,
> +               "with size %d at src offset %d and dest offset %d",
> +               bytes, s_off, d_off);
> +
> +       /* Check leading buffer contents are zero. */
> +       KUNIT_ASSERT_EQ_MSG(test,
> +               memcmp(&large_dst[left_zero_pos], large_zero, left_zero_size), 0,
> +               "with size %d at src offset %d and dest offset %d",
> +               bytes, s_off, d_off);
> +       /* Check trailing buffer contents are zero. */
> +       KUNIT_ASSERT_EQ_MSG(test,
> +               memcmp(&large_dst[right_zero_pos], large_zero, right_zero_size), 0,
> +               "with size %d at src offset %d and dest offset %d",
> +               bytes, s_off, d_off);
> +
> +       /* Zero out everything not already zeroed.*/
> +       pos = left_zero_pos + left_zero_size;
> +       memset(&large_dst[pos], 0, right_zero_pos - pos);
> +}
> +
> +static void memmove_overlap_test(struct kunit *test)
> +{
> +       /*
> +        * Running all possible offset and overlap combinations takes a
> +        * very long time. Instead, only check up to 128 bytes offset
> +        * into the destination buffer (which should result in crossing
> +        * cachelines), with a step size of 1 through 7 to try to skip some
> +        * redundancy.
> +        */
> +       static const int offset_max = 128; /* less than ARRAY_SIZE(large_src); */
> +       static const int bytes_step = 7;
> +       static const int window_step = 7;
> +
> +       static const int bytes_start = 1;
> +       static const int bytes_end = ARRAY_SIZE(large_src) + 1;

Sorry I missed this in v1, but I don't think you meant to use static
storage for these variables?

> +
> +       init_large(test);
> +
> +       /* Copy a growing number of overlapping bytes ... */
> +       for (int bytes = bytes_start; bytes < bytes_end;
> +            bytes = next_step(bytes, bytes_start, bytes_end, bytes_step)) {
> +
> +               /* Over a shifting destination window ... */
> +               for (int d_off = 0; d_off < offset_max; d_off++) {
> +                       int s_start = max(d_off - bytes, 0);
> +                       int s_end = min_t(int, d_off + bytes, ARRAY_SIZE(large_src));

^ These could probably be const.  Looking at the patch, so could
right_zero_pos and right_zero_size in copy_large_test(), and maybe a
few function parameters.  Doesn't matter to me; I can be overzealous
in my use of const, which makes refactoring more difficult. But if
code is using const (like memmove_overlap_testis is above), it might
be worth visiting whether the qualifier is applied everywhere it
could/should be.  Up to you how much const you want, but there could
be more, as a heads up.

> +
> +                       /* Over a shifting source window ... */
> +                       for (int s_off = s_start; s_off < s_end;
> +                            s_off = next_step(s_off, s_start, s_end, window_step))
> +                               inner_loop(test, bytes, d_off, s_off);
> +
> +                       /* Avoid stall warnings. */
> +                       cond_resched();
> +               }
> +       }
> +}
> +
>  static void strtomem_test(struct kunit *test)
>  {
>         static const char input[sizeof(unsigned long)] = "hi";
> @@ -325,7 +527,10 @@ static void strtomem_test(struct kunit *test)
>  static struct kunit_case memcpy_test_cases[] = {
>         KUNIT_CASE(memset_test),
>         KUNIT_CASE(memcpy_test),
> +       KUNIT_CASE(memcpy_large_test),
>         KUNIT_CASE(memmove_test),
> +       KUNIT_CASE(memmove_large_test),
> +       KUNIT_CASE(memmove_overlap_test),
>         KUNIT_CASE(strtomem_test),
>         {}
>  };
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers

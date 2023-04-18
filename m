Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523126E5E45
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjDRKJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjDRKJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:09:28 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBA961B7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:09:27 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-760bba6404cso72373539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681812566; x=1684404566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cIRQdv6iYYC6I1RqYwDtorj0pIGGotKUqAJL8F9Nl60=;
        b=0U4F1LJOltCDxAjdDTUrahLDzO1XwqkRTfEt5euRQj4JpgKME8KAbbpcDIkML7a+aZ
         h/M6094D0adpX6HAv+aOrkX/mXp9IXZJ87ewSOQQ9CHrym7eYbMdPynurKrtuUHsBJvH
         r5eH/yUyiHcHa4Cyof11UlHgHHDmoRFp0FeA650bbcAKhB1JtthxbicsacjM2cLUgx35
         IjHoZydA9uowhO6xtYfheRbqGbz0dGJ1XvC0DQzVXLedsjfB4XUDTLfcmaokQRtZStgI
         Y8si0rK5Uyu4XpEpP5yL8El2TzoVMFlzZ1L6qWwqMV5xtTDyZgsjeiMXXQGx1BbddAbv
         yxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681812566; x=1684404566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cIRQdv6iYYC6I1RqYwDtorj0pIGGotKUqAJL8F9Nl60=;
        b=lk+806qTQDaEBaYcCvcnRzSXhXkyzWqLRhAVkLKqDhGXH1cMqLWQ7A3WyXyDIOa3Jy
         478PYcIUD05niKcnSmxC6Xhu9DJQTWY5QeWQLK7WK6bDZaMRrE7cqSO3Pb3aqHe85Gcy
         vhLb8gy+tEICCNvKHvPDGFy2/MhQw3j0RfhV++tCsAzFhzx6S03dkKXyuLc0bLazDfoi
         7Qqauk7zAJ7aUyA00IaUxalLPOr+UPBde59NDhH1Usjsg9M9zQQcfv1I0kJqFaTMkN4e
         CvXDoV/ckukx1iS0QlRs8lwLseW6JjPRjEXr1/Q3f1cyBcWggWEDtMFKLiomrxcFi5+j
         GBvQ==
X-Gm-Message-State: AAQBX9fJh7zxOohRrMF+71Nu1F5IxVkVIQ0djD7dgGKfkOtIO2+UKQ27
        qJf6FJVQ5FMTMj6CeUyrZPdDREHZS8ohifghfcWPOA==
X-Google-Smtp-Source: AKy350bjw1Th1BsGmyooEfwEzHpPWCjXNDK6ekyspSS5g40M28XFe2V74kGiB1Ckq156bWRFgxtRB05m0uXEiOLemrE=
X-Received: by 2002:a6b:ea09:0:b0:760:eab2:71b1 with SMTP id
 m9-20020a6bea09000000b00760eab271b1mr1310660ioc.20.1681812566273; Tue, 18 Apr
 2023 03:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230413160644.490976-1-mark.rutland@arm.com>
In-Reply-To: <20230413160644.490976-1-mark.rutland@arm.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 18 Apr 2023 12:08:49 +0200
Message-ID: <CANpmjNPfmFcAGFnZRY_G_34DqW4MRSHObfZhKBNh0X1Up00fGA@mail.gmail.com>
Subject: Re: [PATCH] locking/atomic: correct (cmp)xhcg instrumentation
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        peterz@infradead.org, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023 at 18:06, Mark Rutland <mark.rutland@arm.com> wrote:
>
> All xchg() and cmpxchg() ops are atomic RMWs, but currently we
> instrument these with instrument_atomic_write() rather than
> instrument_atomic_read_write(), missing the read aspect.
>
> Similarly, all try_cmpxchg() ops are non-atomic RMWs on *oldp, but we
> instrument these accesses with instrument_atomic_write() rather than
> instrument_read_write(), missing the read aspect and erroneously marking
> these as atomic.
>
> Fix the instrumentation for both points.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>

Reviewed-by: Marco Elver <elver@google.com>

Thanks!

> ---
>  include/linux/atomic/atomic-instrumented.h | 76 +++++++++++-----------
>  scripts/atomic/gen-atomic-instrumented.sh  |  6 +-
>  2 files changed, 41 insertions(+), 41 deletions(-)
>
> Note: this is based on tip locking/core, with the head commit being:
>
>   561b081f19655a46 ("locking/x86: Define arch_try_cmpxchg_local")
>
> Mark.
>
> diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
> index 245ba661c4938..03a232a1fa578 100644
> --- a/include/linux/atomic/atomic-instrumented.h
> +++ b/include/linux/atomic/atomic-instrumented.h
> @@ -1948,14 +1948,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
>         kcsan_mb(); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>         arch_xchg(__ai_ptr, __VA_ARGS__); \
>  })
>
>  #define xchg_acquire(ptr, ...) \
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>         arch_xchg_acquire(__ai_ptr, __VA_ARGS__); \
>  })
>
> @@ -1963,14 +1963,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
>         kcsan_release(); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>         arch_xchg_release(__ai_ptr, __VA_ARGS__); \
>  })
>
>  #define xchg_relaxed(ptr, ...) \
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>         arch_xchg_relaxed(__ai_ptr, __VA_ARGS__); \
>  })
>
> @@ -1978,14 +1978,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
>         kcsan_mb(); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>         arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
>  })
>
>  #define cmpxchg_acquire(ptr, ...) \
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>         arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__); \
>  })
>
> @@ -1993,14 +1993,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
>         kcsan_release(); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>         arch_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
>  })
>
>  #define cmpxchg_relaxed(ptr, ...) \
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>         arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
>  })
>
> @@ -2008,14 +2008,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
>         kcsan_mb(); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>         arch_cmpxchg64(__ai_ptr, __VA_ARGS__); \
>  })
>
>  #define cmpxchg64_acquire(ptr, ...) \
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>         arch_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__); \
>  })
>
> @@ -2023,14 +2023,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
>         kcsan_release(); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>         arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__); \
>  })
>
>  #define cmpxchg64_relaxed(ptr, ...) \
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>         arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
>  })
>
> @@ -2039,8 +2039,8 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>         typeof(ptr) __ai_ptr = (ptr); \
>         typeof(oldp) __ai_oldp = (oldp); \
>         kcsan_mb(); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -       instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
>         arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>  })
>
> @@ -2048,8 +2048,8 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
>         typeof(oldp) __ai_oldp = (oldp); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -       instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
>         arch_try_cmpxchg_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>  })
>
> @@ -2058,8 +2058,8 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>         typeof(ptr) __ai_ptr = (ptr); \
>         typeof(oldp) __ai_oldp = (oldp); \
>         kcsan_release(); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -       instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
>         arch_try_cmpxchg_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>  })
>
> @@ -2067,8 +2067,8 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
>         typeof(oldp) __ai_oldp = (oldp); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -       instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
>         arch_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>  })
>
> @@ -2077,8 +2077,8 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>         typeof(ptr) __ai_ptr = (ptr); \
>         typeof(oldp) __ai_oldp = (oldp); \
>         kcsan_mb(); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -       instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
>         arch_try_cmpxchg64(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>  })
>
> @@ -2086,8 +2086,8 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
>         typeof(oldp) __ai_oldp = (oldp); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -       instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
>         arch_try_cmpxchg64_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>  })
>
> @@ -2096,8 +2096,8 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>         typeof(ptr) __ai_ptr = (ptr); \
>         typeof(oldp) __ai_oldp = (oldp); \
>         kcsan_release(); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -       instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
>         arch_try_cmpxchg64_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>  })
>
> @@ -2105,22 +2105,22 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
>         typeof(oldp) __ai_oldp = (oldp); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -       instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
>         arch_try_cmpxchg64_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>  })
>
>  #define cmpxchg_local(ptr, ...) \
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>         arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
>  })
>
>  #define cmpxchg64_local(ptr, ...) \
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>         arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__); \
>  })
>
> @@ -2128,7 +2128,7 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
>         kcsan_mb(); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>         arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__); \
>  })
>
> @@ -2136,8 +2136,8 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
>         typeof(oldp) __ai_oldp = (oldp); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -       instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
>         arch_try_cmpxchg_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>  })
>
> @@ -2145,8 +2145,8 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
>         typeof(oldp) __ai_oldp = (oldp); \
> -       instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> -       instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +       instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +       instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
>         arch_try_cmpxchg64_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>  })
>
> @@ -2154,7 +2154,7 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
>         kcsan_mb(); \
> -       instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
> +       instrument_atomic_read_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
>         arch_cmpxchg_double(__ai_ptr, __VA_ARGS__); \
>  })
>
> @@ -2162,9 +2162,9 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  #define cmpxchg_double_local(ptr, ...) \
>  ({ \
>         typeof(ptr) __ai_ptr = (ptr); \
> -       instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
> +       instrument_atomic_read_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
>         arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__); \
>  })
>
>  #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
> -// 97fe4d79aa058d2164df824632cbc4f716d2a407
> +// 6b513a42e1a1b5962532a019b7fc91eaa044ad5e
> diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> index c8165e9431bf8..d9ffd74f73ca2 100755
> --- a/scripts/atomic/gen-atomic-instrumented.sh
> +++ b/scripts/atomic/gen-atomic-instrumented.sh
> @@ -104,8 +104,8 @@ cat <<EOF
>  EOF
>  [ -n "$kcsan_barrier" ] && printf "\t${kcsan_barrier}; \\\\\n"
>  cat <<EOF
> -       instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
> -       instrument_atomic_write(__ai_oldp, ${mult}sizeof(*__ai_oldp)); \\
> +       instrument_atomic_read_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
> +       instrument_read_write(__ai_oldp, ${mult}sizeof(*__ai_oldp)); \\
>         arch_${xchg}${order}(__ai_ptr, __ai_oldp, __VA_ARGS__); \\
>  })
>  EOF
> @@ -119,7 +119,7 @@ cat <<EOF
>  EOF
>  [ -n "$kcsan_barrier" ] && printf "\t${kcsan_barrier}; \\\\\n"
>  cat <<EOF
> -       instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
> +       instrument_atomic_read_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
>         arch_${xchg}${order}(__ai_ptr, __VA_ARGS__); \\
>  })
>  EOF
> --
> 2.30.2
>

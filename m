Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42CD6827D6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjAaI70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjAaI65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:58:57 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC31D518DA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:55:05 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5063029246dso194253177b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q1SrdDNUlC8jwW9ILBpZQKsxZB0Kk6bmk1dzxOugPqw=;
        b=rAIko5S656uXYnMEPKcMcp9zgAKiuhyYIHq+CtfD0P4YTXB5pDrenATm8Z9aEUO5SS
         xiSUxuAQOxSGKKFaWmNCMvrwiBWQRZlRPztdqGRL/gHUxdJRfz6BVxqJqI+5v7mWXxcr
         Kx/nStRUuqMsFlHJ51LQUwmAozVWOmKptPg+kuOthAqQReD57P/bZZS6Sg9Fm1HqJDkV
         8XnwiErjgZ+BxdBmZxCjiTwxsFkNF7Aek9A/O091/dZPgvxSbR86nkOxqL4CL2EBrc7u
         q/D5Fy53PmD3E5mfIL3lgADH0brpnWjGHmdVFr05+fXPACY7AlWbsKluf+YZQcA1r77x
         UDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1SrdDNUlC8jwW9ILBpZQKsxZB0Kk6bmk1dzxOugPqw=;
        b=Ib0Wu45Qlzm88aINIai0I+Wyai3EozCHQtlISOj9DFlhDi2fQ/2SKqKqvRlH/EGSYD
         NRpw06ZcGq/ZlCnQZvrGfhedCVXMLjvLFcJtc2nGANrL+xkhoSZU1ofpLXCwJvh1gTik
         H9697CoVJjuaniYURKqkFlH5psfCj7vQcOntwkswB7K8lxkeBnc+beSFbDgnm0+sf18/
         X273oHf9dXnpIVZ0m7Ug4p+FnOf4BboOx0K9y7hv/5Sm5uaTlmdIDE2zbXd757I3ukcg
         dLrIoukn2BQqWMuDnO8TxMnlj8uO9Wm/of4czCUyiqV8afSfjK76RCsadRs/XXQIQjUH
         oRTw==
X-Gm-Message-State: AFqh2koVXLLs9JSCpxxKSj8nkmt9mMd4bLAD5F1IYAG+LDpQbCAyeH6J
        rasorVXTZsyz0iMcWfIaK16Cmgj5YmQ0dtwvPXaV5A==
X-Google-Smtp-Source: AMrXdXuFN4s20Kx9T5tmNLJ44z59TdEQU7GqKqHCpApJ5dnP9JbjylkFb83+PoHMtS5f4TPercZLAZZI9kkdd+3E1Wo=
X-Received: by 2002:a81:6d4:0:b0:468:5fe3:7771 with SMTP id
 203-20020a8106d4000000b004685fe37771mr6562874ywg.267.1675155254079; Tue, 31
 Jan 2023 00:54:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <fbe58d38b7d93a9ef8500a72c0c4f103222418e6.1675111415.git.andreyknvl@google.com>
In-Reply-To: <fbe58d38b7d93a9ef8500a72c0c4f103222418e6.1675111415.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 31 Jan 2023 09:53:37 +0100
Message-ID: <CANpmjNPakvS5OAp3DEvH=5mdtped8K5WC4j4yRfPEJtJOv4OhA@mail.gmail.com>
Subject: Re: [PATCH 15/18] lib/stacktrace, kasan, kmsan: rework extra_bits interface
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Mon, 30 Jan 2023 at 21:51, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> The current implementation of the extra_bits interface is confusing:
> passing extra_bits to __stack_depot_save makes it seem that the extra
> bits are somehow stored in stack depot. In reality, they are only
> embedded into a stack depot handle and are not used within stack depot.
>
> Drop the extra_bits argument from __stack_depot_save and instead provide
> a new stack_depot_set_extra_bits function (similar to the exsiting
> stack_depot_get_extra_bits) that saves extra bits into a stack depot
> handle.
>
> Update the callers of __stack_depot_save to use the new interace.
>
> This change also fixes a minor issue in the old code: __stack_depot_save
> does not return NULL if saving stack trace fails and extra_bits is used.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  include/linux/stackdepot.h |  4 +++-
>  lib/stackdepot.c           | 38 +++++++++++++++++++++++++++++---------
>  mm/kasan/common.c          |  2 +-
>  mm/kmsan/core.c            | 10 +++++++---
>  4 files changed, 40 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index c4e3abc16b16..f999811c66d7 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -57,7 +57,6 @@ static inline int stack_depot_early_init(void)        { return 0; }
>
>  depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>                                         unsigned int nr_entries,
> -                                       unsigned int extra_bits,
>                                         gfp_t gfp_flags, bool can_alloc);
>
>  depot_stack_handle_t stack_depot_save(unsigned long *entries,
> @@ -71,6 +70,9 @@ void stack_depot_print(depot_stack_handle_t stack);
>  int stack_depot_snprint(depot_stack_handle_t handle, char *buf, size_t size,
>                        int spaces);
>
> +depot_stack_handle_t stack_depot_set_extra_bits(depot_stack_handle_t handle,
> +                                               unsigned int extra_bits);

Can you add __must_check to this function? Either that or making
handle an in/out param, as otherwise it might be easy to think that it
doesn't return anything ("set_foo()" seems like it sets the
information in the handle-associated data but not handle itself ... in
case someone missed the documentation).

>  unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle);
>
>  #endif
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 7282565722f2..f291ad6a4e72 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -346,7 +346,6 @@ static inline struct stack_record *find_stack(struct stack_record *bucket,
>   *
>   * @entries:           Pointer to storage array
>   * @nr_entries:                Size of the storage array
> - * @extra_bits:                Flags to store in unused bits of depot_stack_handle_t
>   * @alloc_flags:       Allocation gfp flags
>   * @can_alloc:         Allocate stack slabs (increased chance of failure if false)
>   *
> @@ -358,10 +357,6 @@ static inline struct stack_record *find_stack(struct stack_record *bucket,
>   * If the stack trace in @entries is from an interrupt, only the portion up to
>   * interrupt entry is saved.
>   *
> - * Additional opaque flags can be passed in @extra_bits, stored in the unused
> - * bits of the stack handle, and retrieved using stack_depot_get_extra_bits()
> - * without calling stack_depot_fetch().
> - *
>   * Context: Any context, but setting @can_alloc to %false is required if
>   *          alloc_pages() cannot be used from the current context. Currently
>   *          this is the case from contexts where neither %GFP_ATOMIC nor
> @@ -371,7 +366,6 @@ static inline struct stack_record *find_stack(struct stack_record *bucket,
>   */
>  depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>                                         unsigned int nr_entries,
> -                                       unsigned int extra_bits,
>                                         gfp_t alloc_flags, bool can_alloc)
>  {
>         struct stack_record *found = NULL, **bucket;
> @@ -461,8 +455,6 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>         if (found)
>                 retval.handle = found->handle.handle;
>  fast_exit:
> -       retval.extra = extra_bits;
> -
>         return retval.handle;
>  }
>  EXPORT_SYMBOL_GPL(__stack_depot_save);
> @@ -483,7 +475,7 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
>                                       unsigned int nr_entries,
>                                       gfp_t alloc_flags)
>  {
> -       return __stack_depot_save(entries, nr_entries, 0, alloc_flags, true);
> +       return __stack_depot_save(entries, nr_entries, alloc_flags, true);
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_save);
>
> @@ -566,6 +558,34 @@ int stack_depot_snprint(depot_stack_handle_t handle, char *buf, size_t size,
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_snprint);
>
> +/**
> + * stack_depot_set_extra_bits - Set extra bits in a stack depot handle
> + *
> + * @handle:    Stack depot handle
> + * @extra_bits:        Value to set the extra bits
> + *
> + * Return: Stack depot handle with extra bits set
> + *
> + * Stack depot handles have a few unused bits, which can be used for storing
> + * user-specific information. These bits are transparent to the stack depot.
> + */
> +depot_stack_handle_t stack_depot_set_extra_bits(depot_stack_handle_t handle,
> +                                               unsigned int extra_bits)
> +{
> +       union handle_parts parts = { .handle = handle };
> +
> +       parts.extra = extra_bits;
> +       return parts.handle;
> +}
> +EXPORT_SYMBOL(stack_depot_set_extra_bits);
> +
> +/**
> + * stack_depot_get_extra_bits - Retrieve extra bits from a stack depot handle
> + *
> + * @handle:    Stack depot handle with extra bits saved
> + *
> + * Return: Extra bits retrieved from the stack depot handle
> + */
>  unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle)
>  {
>         union handle_parts parts = { .handle = handle };
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 833bf2cfd2a3..50f4338b477f 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -43,7 +43,7 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
>         unsigned int nr_entries;
>
>         nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> -       return __stack_depot_save(entries, nr_entries, 0, flags, can_alloc);
> +       return __stack_depot_save(entries, nr_entries, flags, can_alloc);
>  }
>
>  void kasan_set_track(struct kasan_track *track, gfp_t flags)
> diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
> index 112dce135c7f..f710257d6867 100644
> --- a/mm/kmsan/core.c
> +++ b/mm/kmsan/core.c
> @@ -69,13 +69,15 @@ depot_stack_handle_t kmsan_save_stack_with_flags(gfp_t flags,
>  {
>         unsigned long entries[KMSAN_STACK_DEPTH];
>         unsigned int nr_entries;
> +       depot_stack_handle_t handle;
>
>         nr_entries = stack_trace_save(entries, KMSAN_STACK_DEPTH, 0);
>
>         /* Don't sleep (see might_sleep_if() in __alloc_pages_nodemask()). */
>         flags &= ~__GFP_DIRECT_RECLAIM;
>
> -       return __stack_depot_save(entries, nr_entries, extra, flags, true);
> +       handle = __stack_depot_save(entries, nr_entries, flags, true);
> +       return stack_depot_set_extra_bits(handle, extra);
>  }
>
>  /* Copy the metadata following the memmove() behavior. */
> @@ -215,6 +217,7 @@ depot_stack_handle_t kmsan_internal_chain_origin(depot_stack_handle_t id)
>         u32 extra_bits;
>         int depth;
>         bool uaf;
> +       depot_stack_handle_t handle;
>
>         if (!id)
>                 return id;
> @@ -250,8 +253,9 @@ depot_stack_handle_t kmsan_internal_chain_origin(depot_stack_handle_t id)
>          * positives when __stack_depot_save() passes it to instrumented code.
>          */
>         kmsan_internal_unpoison_memory(entries, sizeof(entries), false);
> -       return __stack_depot_save(entries, ARRAY_SIZE(entries), extra_bits,
> -                                 GFP_ATOMIC, true);
> +       handle = __stack_depot_save(entries, ARRAY_SIZE(entries), GFP_ATOMIC,
> +                                   true);
> +       return stack_depot_set_extra_bits(handle, extra_bits);
>  }
>
>  void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
> --
> 2.25.1
>

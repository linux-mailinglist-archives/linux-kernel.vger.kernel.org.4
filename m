Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872E766712B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjALLor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbjALLoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:44:21 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DC354737
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:35:14 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id a9so1625426ybb.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sZdRy8QTItnLRyny4d2jEHrecgEcHxwrD4J8NtmTL7Y=;
        b=SmA+oCE6TuGwbe2Xxh1HHB85rLlmPcddh1Tg8ni226DuXlH4RYgHFgwTNjWnK+hIys
         wbwhICrZRvoXjfR3033PKcTsF5+Zb9yl2OcZDq6+Vu20nsMUgERxpMHaz9DsCCSsKds9
         pKwALp0zEfZxMQRvR/NRnF8fYZRMmvKnPtuGfg2soZ4w4iSPkWisa0K2npbmQn0k0Dww
         Pil4sA0iEjKKxQE8Qa6pry2EJGIG2nXl/ag3OsJUo7wv/n5QfE8M7N4Sf+FFR2rZ2Dq5
         l5jY0BDLbd1+KDAtPtTqIxjgWji5tWY6t307XezHRSS5amR7ZG7eMLg/9nnEv2/OpiJ6
         9kAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZdRy8QTItnLRyny4d2jEHrecgEcHxwrD4J8NtmTL7Y=;
        b=ZtZxHbZSy3jkZ95VLMU7rmXFEXo9LYgZplhQZvf1hKy/4pWkhfflDlA+NkLzmF5BE+
         BLuYZrWNoeZ6hL6NfTS//RmN7RdTai614B1IdAH7V7h/8Te+Fjs9t6vKrQM0qiC1taHU
         TITh53V9beN3Sw7sR6Fr+4yyNKg+GJvOOICX9VEHjft+0q9dDG7/ZOKaZDjB/E9zwENP
         o4PaBJKRwxUpcoHOBc+mnMRqDUqKEvP0AFBQlfam/WyhTl9W+IU83JEE3vhAm1Z9JdSV
         cbKkuARC6Am8vb1PiuLFE+37K2103PvkmEmgdBFRSCdU+EH3RLxkI+ZrBMPd8mTISd7J
         NI7Q==
X-Gm-Message-State: AFqh2koORfGdjyCrBook6ex6rBRL6d416F1oTW8m9ci2Q3ZlGtsCLkGw
        vQb7/Dp8L+5Q47Yym80US9K/GD9BLV3IwR3O50zSpQ==
X-Google-Smtp-Source: AMrXdXsKOjoo2EXnu3Tqsyki97VXA+55QinQw21cvlQPMGCjj8pLnIr5qWtWkgNPBXQn0krLQs14d6T11dXADaRCx4E=
X-Received: by 2002:a5b:a90:0:b0:70b:87d5:4a73 with SMTP id
 h16-20020a5b0a90000000b0070b87d54a73mr5919340ybq.584.1673523313774; Thu, 12
 Jan 2023 03:35:13 -0800 (PST)
MIME-Version: 1.0
References: <20230112103147.382416-1-glider@google.com>
In-Reply-To: <20230112103147.382416-1-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Jan 2023 12:34:37 +0100
Message-ID: <CANpmjNMznQsC6ftzy7MCa7uQVCFv=MFg6JW28QdnGPyzFEZn5A@mail.gmail.com>
Subject: Re: [PATCH] kmsan: silence -Wmissing-prototypes warnings
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, dvyukov@google.com,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        kernel test robot <lkp@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
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

On Thu, 12 Jan 2023 at 11:31, Alexander Potapenko <glider@google.com> wrote:
>
> When building the kernel with W=1, the compiler reports numerous
> warnings about the missing prototypes for KMSAN instrumentation hooks.
>
> Because these functions are not supposed to be called explicitly by the
> kernel code (calls to them are emitted by the compiler), they do not
> have to be declared in the headers. Instead, we add forward declarations
> right before the definitions to silence the warnings produced by
> -Wmissing-prototypes.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202301020356.dFruA4I5-lkp@intel.com/T/
> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kmsan/instrumentation.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/mm/kmsan/instrumentation.c b/mm/kmsan/instrumentation.c
> index 770fe02904f36..cf12e9616b243 100644
> --- a/mm/kmsan/instrumentation.c
> +++ b/mm/kmsan/instrumentation.c
> @@ -38,7 +38,15 @@ get_shadow_origin_ptr(void *addr, u64 size, bool store)
>         return ret;
>  }
>
> +/*
> + * KMSAN instrumentation functions follow. They are not declared elsewhere in
> + * the kernel code, so they are preceded by prototypes, to silence
> + * -Wmissing-prototypes warnings.
> + */
> +
>  /* Get shadow and origin pointers for a memory load with non-standard size. */
> +struct shadow_origin_ptr __msan_metadata_ptr_for_load_n(void *addr,
> +                                                       uintptr_t size);
>  struct shadow_origin_ptr __msan_metadata_ptr_for_load_n(void *addr,
>                                                         uintptr_t size)
>  {
> @@ -47,6 +55,8 @@ struct shadow_origin_ptr __msan_metadata_ptr_for_load_n(void *addr,
>  EXPORT_SYMBOL(__msan_metadata_ptr_for_load_n);
>
>  /* Get shadow and origin pointers for a memory store with non-standard size. */
> +struct shadow_origin_ptr __msan_metadata_ptr_for_store_n(void *addr,
> +                                                        uintptr_t size);
>  struct shadow_origin_ptr __msan_metadata_ptr_for_store_n(void *addr,
>                                                          uintptr_t size)
>  {
> @@ -59,12 +69,16 @@ EXPORT_SYMBOL(__msan_metadata_ptr_for_store_n);
>   * with fixed size.
>   */
>  #define DECLARE_METADATA_PTR_GETTER(size)                                  \
> +       struct shadow_origin_ptr __msan_metadata_ptr_for_load_##size(      \
> +               void *addr);                                               \
>         struct shadow_origin_ptr __msan_metadata_ptr_for_load_##size(      \
>                 void *addr)                                                \
>         {                                                                  \
>                 return get_shadow_origin_ptr(addr, size, /*store*/ false); \
>         }                                                                  \
>         EXPORT_SYMBOL(__msan_metadata_ptr_for_load_##size);                \
> +       struct shadow_origin_ptr __msan_metadata_ptr_for_store_##size(     \
> +               void *addr);                                               \
>         struct shadow_origin_ptr __msan_metadata_ptr_for_store_##size(     \
>                 void *addr)                                                \
>         {                                                                  \
> @@ -86,6 +100,7 @@ DECLARE_METADATA_PTR_GETTER(8);
>   * entering or leaving IRQ. We omit the check for kmsan_in_runtime() to ensure
>   * the memory written to in these cases is also marked as initialized.
>   */
> +void __msan_instrument_asm_store(void *addr, uintptr_t size);
>  void __msan_instrument_asm_store(void *addr, uintptr_t size)
>  {
>         unsigned long ua_flags;
> @@ -138,6 +153,7 @@ static inline void set_retval_metadata(u64 shadow, depot_stack_handle_t origin)
>  }
>
>  /* Handle llvm.memmove intrinsic. */
> +void *__msan_memmove(void *dst, const void *src, uintptr_t n);
>  void *__msan_memmove(void *dst, const void *src, uintptr_t n)
>  {
>         depot_stack_handle_t origin;
> @@ -162,6 +178,7 @@ void *__msan_memmove(void *dst, const void *src, uintptr_t n)
>  EXPORT_SYMBOL(__msan_memmove);
>
>  /* Handle llvm.memcpy intrinsic. */
> +void *__msan_memcpy(void *dst, const void *src, uintptr_t n);
>  void *__msan_memcpy(void *dst, const void *src, uintptr_t n)
>  {
>         depot_stack_handle_t origin;
> @@ -188,6 +205,7 @@ void *__msan_memcpy(void *dst, const void *src, uintptr_t n)
>  EXPORT_SYMBOL(__msan_memcpy);
>
>  /* Handle llvm.memset intrinsic. */
> +void *__msan_memset(void *dst, int c, uintptr_t n);
>  void *__msan_memset(void *dst, int c, uintptr_t n)
>  {
>         depot_stack_handle_t origin;
> @@ -217,6 +235,7 @@ EXPORT_SYMBOL(__msan_memset);
>   * uninitialized value to memory. When reporting an error, KMSAN unrolls and
>   * prints the whole chain of stores that preceded the use of this value.
>   */
> +depot_stack_handle_t __msan_chain_origin(depot_stack_handle_t origin);
>  depot_stack_handle_t __msan_chain_origin(depot_stack_handle_t origin)
>  {
>         depot_stack_handle_t ret = 0;
> @@ -237,6 +256,7 @@ depot_stack_handle_t __msan_chain_origin(depot_stack_handle_t origin)
>  EXPORT_SYMBOL(__msan_chain_origin);
>
>  /* Poison a local variable when entering a function. */
> +void __msan_poison_alloca(void *address, uintptr_t size, char *descr);
>  void __msan_poison_alloca(void *address, uintptr_t size, char *descr)
>  {
>         depot_stack_handle_t handle;
> @@ -272,6 +292,7 @@ void __msan_poison_alloca(void *address, uintptr_t size, char *descr)
>  EXPORT_SYMBOL(__msan_poison_alloca);
>
>  /* Unpoison a local variable. */
> +void __msan_unpoison_alloca(void *address, uintptr_t size);
>  void __msan_unpoison_alloca(void *address, uintptr_t size)
>  {
>         if (!kmsan_enabled || kmsan_in_runtime())
> @@ -287,6 +308,7 @@ EXPORT_SYMBOL(__msan_unpoison_alloca);
>   * Report that an uninitialized value with the given origin was used in a way
>   * that constituted undefined behavior.
>   */
> +void __msan_warning(u32 origin);
>  void __msan_warning(u32 origin)
>  {
>         if (!kmsan_enabled || kmsan_in_runtime())
> @@ -303,6 +325,7 @@ EXPORT_SYMBOL(__msan_warning);
>   * At the beginning of an instrumented function, obtain the pointer to
>   * `struct kmsan_context_state` holding the metadata for function parameters.
>   */
> +struct kmsan_context_state *__msan_get_context_state(void);
>  struct kmsan_context_state *__msan_get_context_state(void)
>  {
>         return &kmsan_get_context()->cstate;
> --
> 2.39.0.314.g84b9a713c41-goog
>

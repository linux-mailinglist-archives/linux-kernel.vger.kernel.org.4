Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9FE619CC7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiKDQOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiKDQOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:14:43 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F80CCFB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:14:42 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3701a0681daso47949017b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 09:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5v+p27CQOVhNMAHqQDcwxjRC8M+4widvhWkHJPKXMs=;
        b=AXRWCewjuXhedfBrKWvvPqSzfOVriX6QCVwtDUll2wKd2I2uZnd/2SlvN1stVFRp/R
         lVm+bftjR6+F62WJCVtTXblVHk0ZW056KDMSrBkbnhZoMvfEAoTbjdBCs+G1zYv3kLql
         D3NA9rYHVE3IrVKb3JS5x2m/xNq0HqMrHZ+pg1vzSBjssACNuF4oHBSVjjQwSBfLgb6C
         tNxq4WnbddlrDqnz9nptTZMMADb2XzYG4xLsoAW8nsRRycl1Iz7VTI5ffa/vSHdQ08lQ
         qRn8/Af4Lc8FFMi4WKk0SA/uFREYNOb1kOkiduRSwtwjWWOHZrjn6kXrVAP7kVp8LAHv
         zYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5v+p27CQOVhNMAHqQDcwxjRC8M+4widvhWkHJPKXMs=;
        b=J1NdCp+CQHAQsBA4z9fvrcQaqj9DEnqZzvRy0Ob/gktlSs1RX0ZHyNz++tZYrxmrwA
         A3cee+O6+fwXTRM7jsnC2bxQ4t9+pgluCJ3sjuscLftI1OhsqoxPZsxSY5yrsSH2ejZq
         V5PIgwM9WK0w9ALcRbv+T5ys7MbGmwkAM8nBybO30ckgyV9EfJ4ZNxCl99GJ+vz50bdF
         Uc8zX17rftj9YfsvXgntkzDPPI9znNPnm2zeGC9kvF5PKSibtJ+YE8HO5KNWgSytYgWJ
         6wn5jelQti4kQbCoG0SPc09P+fKcG7H3TQf1dY4bl9lifsDYyCR/Mn4Hr3NrCXCtCJgr
         tBYw==
X-Gm-Message-State: ACrzQf1oAJyXWRql0x4933Zjmg5r65lEQe1aQyvk2LR394JjrAMfGSBv
        Tr/cJ9uHBv8RdUj+UobAfZKDnsPxFSPJp7oKHE5rYg==
X-Google-Smtp-Source: AMsMyM6vBz93ef4FpclTlA4uL2F8f2wtAWuh3Ns0SLMDZeyJ2Vrq9XRuJOHPOF93Brj8mGR78TySZx/EuIk7GWaGLQ4=
X-Received: by 2002:a0d:da03:0:b0:368:5712:5795 with SMTP id
 c3-20020a0dda03000000b0036857125795mr35335357ywe.428.1667578481544; Fri, 04
 Nov 2022 09:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221104093354.6218-1-osalvador@suse.de> <20221104093354.6218-2-osalvador@suse.de>
In-Reply-To: <20221104093354.6218-2-osalvador@suse.de>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 4 Nov 2022 17:14:04 +0100
Message-ID: <CAG_fn=UtAT2J9PPqEg64THGAWwWVV_Bk+ER9bj3VYK_6KfjcTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] lib/stackdepot: Add a refcount field in stack_record
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Nov 4, 2022 at 10:34 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> We want to filter out page_owner output and print only those
> stacks that have been repeated beyond a certain threshold.
> This gives us the chance to get rid of a lot of noise.
> In order to do that, we need to keep track of how many repeated stacks
> (for allocation) do we have, so we add a new refcount_t field
> in the stack_record struct.
>
> Note that this might increase the size of the struct for some
> architectures.
> E.g: x86_64 is not affected due to alignment, but x86 32bits might.
>
> The alternative would be to have some kind of struct like this:
>
> struct track_stacks {
>         struct stack_record *stack;
>         struct track_stacks *next;
>         refcount_t stack_count;
>
> But ithat would imply to perform more allocations and glue everything
> together, which would make the code more complex, so I think that
> going with a new field in the struct stack_record is good enough.
>
> Note that on __set_page_owner_handle(), page_owner->handle is set,
> and on __reset_page_owner(), page_owner->free_handle is set.
>
> We are interested in page_owner->handle, so when __set_page_owner()
> gets called, we derive the stack_record struct from page_owner->handle,
> and we increment its refcount_t field; and when __reset_page_owner()
> gets called, we derive its stack_record from page_owner->handle()
> and we decrement its refcount_t field.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/stackdepot.h | 13 ++++++-
>  lib/stackdepot.c           | 79 +++++++++++++++++++++++++++++++-------
>  mm/kasan/common.c          |  3 +-
>  mm/page_owner.c            | 14 +++++--
>  4 files changed, 89 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index bc2797955de9..4e3a88f135ee 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -15,9 +15,16 @@
>
>  typedef u32 depot_stack_handle_t;
>
> +enum stack_depot_action {
> +       STACK_DEPOT_ACTION_NONE,
> +       STACK_DEPOT_ACTION_COUNT,
> +};

For the sake of simplicity, can it be just a boolean? What other kinds
of actions do you anticipate?
Another question is maybe we can afford incrementing the counter
unconditionally? It costs almost nothing compared to stack
unwinding/hashing, and this is a debug-only feature anyway (right?)

>  depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>                                         unsigned int nr_entries,
> -                                       gfp_t gfp_flags, bool can_alloc);
> +                                       gfp_t gfp_flags, bool can_alloc,
> +                                       enum stack_depot_action action);
> +void stack_depot_dec_count(depot_stack_handle_t handle);
>
>  /*
>   * Every user of stack depot has to call stack_depot_init() during its o=
wn init
> @@ -55,6 +62,10 @@ static inline int stack_depot_early_init(void)       {=
 return 0; }
>
>  depot_stack_handle_t stack_depot_save(unsigned long *ent=D0=B0, =D0=B2=
=D1=81=D0=B5ries,
>                                       unsigned int nr_entries, gfp_t gfp_=
flags);
> +depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
> +                                            unsigned int nr_entries,
> +                                            gfp_t gfp_flags,
> +                                            enum stack_depot_action acti=
on);
>
>  unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>                                unsigned long **entries);
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index e73fda23388d..a806ef58a385 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -64,6 +64,7 @@ struct stack_record {
>         u32 hash;                       /* Hash in the hastable */
>         u32 size;                       /* Number of frames in the stack =
*/
>         union handle_parts handle;
> +       refcount_t count;               /* Number of the same repeated st=
acks */
>         unsigned long entries[];        /* Variable-sized array of entrie=
s. */
>  };
>
> @@ -140,6 +141,7 @@ depot_alloc_stack(unsigned long *entries, int size, u=
32 hash, void **prealloc)
>         stack->handle.slabindex =3D depot_index;
>         stack->handle.offset =3D depot_offset >> STACK_ALLOC_ALIGN;
>         stack->handle.valid =3D 1;
> +       refcount_set(&stack->count, 1);

If we decide to only maintain the refcount for the page owner,
wouldn't it be simpler to decouple the counter increment from stack
allocation?
In that case other users won't need to be updated, and page owner will
just get an extra call to stack_depot_inc_count().

>         memcpy(stack->entries, entries, flex_array_size(stack, entries, s=
ize));
>         depot_offset +=3D required_size;
>
> @@ -341,6 +343,29 @@ void stack_depot_print(depot_stack_handle_t stack)
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_print);
>
> +static struct stack_record *stack_depot_getstack(depot_stack_handle_t ha=
ndle)
> +{
> +       union handle_parts parts =3D { .handle =3D handle };
> +       void *slab;
> +       size_t offset =3D parts.offset << STACK_ALLOC_ALIGN;
> +       struct stack_record *stack;
> +
> +       if(!handle)
> +               return NULL;
> +
> +       if (parts.slabindex > depot_index) {
> +               WARN(1, "slab index %d out of bounds (%d) for stack id %0=
8x\n",
> +                    parts.slabindex, depot_index, handle);
> +               return NULL;
> +       }
> +       slab =3D stack_slabs[parts.slabindex];
> +       if (!slab)
> +               return NULL;
> +
> +       stack =3D slab + offset;
> +       return stack;
> +}
> +
>  /**
>   * stack_depot_fetch - Fetch stack entries from a depot
>   *
> @@ -353,30 +378,42 @@ EXPORT_SYMBOL_GPL(stack_depot_print);
>  unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>                                unsigned long **entries)
>  {
> -       union handle_parts parts =3D { .handle =3D handle };
> -       void *slab;
> -       size_t offset =3D parts.offset << STACK_ALLOC_ALIGN;
>         struct stack_record *stack;
>
>         *entries =3D NULL;
>         if (!handle)
>                 return 0;
>
> -       if (parts.slabindex > depot_index) {
> -               WARN(1, "slab index %d out of bounds (%d) for stack id %0=
8x\n",
> -                       parts.slabindex, depot_index, handle);
> -               return 0;
> -       }
> -       slab =3D stack_slabs[parts.slabindex];
> -       if (!slab)
> +       stack =3D stack_depot_getstack(handle);
> +       if (!stack)
>                 return 0;
> -       stack =3D slab + offset;
>
>         *entries =3D stack->entries;
>         return stack->size;
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_fetch);
>
> +static void stack_depot_inc_count(struct stack_record *stack)
> +{
> +       refcount_inc(&stack->count);
> +}
> +
> +void stack_depot_dec_count(depot_stack_handle_t handle)
> +{
> +       struct stack_record *stack =3D NULL;
> +
> +       stack =3D stack_depot_getstack(handle);
> +       if (stack) {
> +               /*
> +                * page_owner creates some stacks via create_dummy_stack(=
).
> +                * We are not interested in those, so make sure we only d=
ecrement
> +                * "valid" stacks.
> +                */
> +               if (refcount_read(&stack->count) > 1)

I don't see why we cannot decrement the refcounter when it is 1 -
looks like a normal situation when the number of deallocations matches
the number of allocations.
But maybe we should warn about an overflow here instead?

> +                       refcount_dec(&stack->count);
> +       }
> +}
> +
>  /**
>   * __stack_depot_save - Save a stack trace from an array
>   *
> @@ -402,7 +439,8 @@ EXPORT_SYMBOL_GPL(stack_depot_fetch);
>   */
>  depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>                                         unsigned int nr_entries,
> -                                       gfp_t alloc_flags, bool can_alloc=
)
> +                                       gfp_t alloc_flags, bool can_alloc=
,
> +                                       enum stack_depot_action action)
>  {
>         struct stack_record *found =3D NULL, **bucket;
>         depot_stack_handle_t retval =3D 0;
> @@ -488,8 +526,11 @@ depot_stack_handle_t __stack_depot_save(unsigned lon=
g *entries,
>                 /* Nobody used this memory, ok to free it. */
>                 free_pages((unsigned long)prealloc, STACK_ALLOC_ORDER);
>         }
> -       if (found)
> +       if (found) {
>                 retval =3D found->handle.handle;
> +               if (action =3D=3D STACK_DEPOT_ACTION_COUNT)
> +                       stack_depot_inc_count(found);
> +       }
>  fast_exit:
>         return retval;
>  }
> @@ -511,6 +552,16 @@ depot_stack_handle_t stack_depot_save(unsigned long =
*entries,
>                                       unsigned int nr_entries,
>                                       gfp_t alloc_flags)
>  {
> -       return __stack_depot_save(entries, nr_entries, alloc_flags, true)=
;
> +       return __stack_depot_save(entries, nr_entries, alloc_flags, true,
> +                                 STACK_DEPOT_ACTION_NONE);
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_save);
> +
> +depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
> +                                            unsigned int nr_entries,
> +                                            gfp_t alloc_flags,
> +                                            enum stack_depot_action acti=
on)
> +{
> +       return __stack_depot_save(entries, nr_entries, alloc_flags, true,=
 action);
> +}
> +EXPORT_SYMBOL_GPL(stack_depot_save_action);
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 69f583855c8b..8077c6e70815 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -36,7 +36,8 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, bool=
 can_alloc)
>         unsigned int nr_entries;
>
>         nr_entries =3D stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> -       return __stack_depot_save(entries, nr_entries, flags, can_alloc);
> +       return __stack_depot_save(entries, nr_entries, flags, can_alloc,
> +                                 STACK_DEPOT_ACTION_NONE);
>  }
>
>  void kasan_set_track(struct kasan_track *track, gfp_t flags)
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index e4c6f3f1695b..8730f377fa91 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -106,7 +106,8 @@ static inline struct page_owner *get_page_owner(struc=
t page_ext *page_ext)
>         return (void *)page_ext + page_owner_ops.offset;
>  }
>
> -static noinline depot_stack_handle_t save_stack(gfp_t flags)
> +static noinline depot_stack_handle_t save_stack(gfp_t flags,
> +                                               enum stack_depot_action a=
ction)
>  {
>         unsigned long entries[PAGE_OWNER_STACK_DEPTH];
>         depot_stack_handle_t handle;
> @@ -125,7 +126,7 @@ static noinline depot_stack_handle_t save_stack(gfp_t=
 flags)
>         current->in_page_owner =3D 1;
>
>         nr_entries =3D stack_trace_save(entries, ARRAY_SIZE(entries), 2);
> -       handle =3D stack_depot_save(entries, nr_entries, flags);
> +       handle =3D stack_depot_save_action(entries, nr_entries, flags, ac=
tion);
>         if (!handle)
>                 handle =3D failure_handle;
>
> @@ -138,6 +139,7 @@ void __reset_page_owner(struct page *page, unsigned s=
hort order)
>         int i;
>         struct page_ext *page_ext;
>         depot_stack_handle_t handle;
> +       depot_stack_handle_t alloc_handle;
>         struct page_owner *page_owner;
>         u64 free_ts_nsec =3D local_clock();
>
> @@ -145,7 +147,10 @@ void __reset_page_owner(struct page *page, unsigned =
short order)
>         if (unlikely(!page_ext))
>                 return;
>
> -       handle =3D save_stack(GFP_NOWAIT | __GFP_NOWARN);
> +       page_owner =3D get_page_owner(page_ext);
> +       alloc_handle =3D page_owner->handle;
> +
> +       handle =3D save_stack(GFP_NOWAIT | __GFP_NOWARN, STACK_DEPOT_ACTI=
ON_NONE);
>         for (i =3D 0; i < (1 << order); i++) {
>                 __clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
>                 page_owner =3D get_page_owner(page_ext);
> @@ -153,6 +158,7 @@ void __reset_page_owner(struct page *page, unsigned s=
hort order)
>                 page_owner->free_ts_nsec =3D free_ts_nsec;
>                 page_ext =3D page_ext_next(page_ext);
>         }
> +       stack_depot_dec_count(alloc_handle);
>  }
>
>  static inline void __set_page_owner_handle(struct page_ext *page_ext,
> @@ -189,7 +195,7 @@ noinline void __set_page_owner(struct page *page, uns=
igned short order,
>         if (unlikely(!page_ext))
>                 return;
>
> -       handle =3D save_stack(gfp_mask);
> +       handle =3D save_stack(gfp_mask, STACK_DEPOT_ACTION_COUNT);
>         __set_page_owner_handle(page_ext, handle, order, gfp_mask);
>  }
>
> --
> 2.35.3
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

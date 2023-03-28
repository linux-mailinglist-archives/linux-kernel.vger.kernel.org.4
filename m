Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8326CC005
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjC1NAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjC1NAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:00:35 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54195B463
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:00:26 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-536af432ee5so228536567b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680008425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+huGA2Pj+bVMB5ImXYOSsvTzp1LUROSbW9q/pibPfZk=;
        b=tUw9ivkOFvOutpO3vZF1294VVPaqjFYRzSTC8ta9jaGGvrB7OVcIFUvr1dN2buhuDY
         ObMOc71gnqyMgj+JMBsF50M4lfvc/z8iWdduY/waRvHGWEtT+9XXZ/Zd5/FYdFzbu6oy
         OwuH3h2YoV5v3mCrMEL4FOJci3DegXTF0QQf94T3nzi6A5tPRqallcteny/XxcCxHhip
         1IkFEj+2DDINaSTOjA0oDRM8b679kyYr49R6PHVXc/07Z5cEYxKHiKfpHSGdBkHHIKFQ
         3JkKjJJ1UKTc//4AMeQnPiR90Au2IkEtl0GE9CuY9/MFw0NDKfBEAYR4Zgt+j4sJeSTA
         /Osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680008425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+huGA2Pj+bVMB5ImXYOSsvTzp1LUROSbW9q/pibPfZk=;
        b=qCrWyOJrIPa3ZDmS7xgGaZcW4HrAtxGoj07d/BDjzmRgnajsdoAIXhqepthM0yFm0K
         3tl+HDbA/KFZ4ymCPxpA+d8aJRTLyKReFphWoL9t3V+p0YAVuYZZp63l2UiaNmpCAFpI
         h0fijplH60jg+59GWWC2KNFiPpoF3LHm6JooQmRPckMrwJ4Gu0UcoBI31jVu/VUftxwZ
         PPzm7iNIS5ewtqCsOtNaUh/Wf3mhKIx7dLwS8o07S0+cWtTpOqFOdqFXqRugW+OXx5d3
         GcJjg/Yfgcqqkqz9NQDSgnFvhFvO5ZqWW1iGhY9vBGYd7lTUrB1f/KI2BsSL/xe46heo
         GVmw==
X-Gm-Message-State: AAQBX9dsGwLA+eUYayM5xygkW7bhfUXgTFe2uwvMxjfLO6ud+f8UtjO1
        hrdm1s7j6pPFo81hKnAZKdSTJvEf8Qr4Vh4sJkSe8w==
X-Google-Smtp-Source: AKy350YACvUMAelvnSZlTYMgg5DNeiYkah+uj1gFLlg6pWuOcKuRZWK2bogfhyYR8w7emQspC1Az9WMoV0N+hmBDcS8=
X-Received: by 2002:a0d:c787:0:b0:542:471d:ec62 with SMTP id
 j129-20020a0dc787000000b00542471dec62mr14895469ywd.25.1680008425050; Tue, 28
 Mar 2023 06:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230328095807.7014-1-songmuchun@bytedance.com> <20230328095807.7014-6-songmuchun@bytedance.com>
In-Reply-To: <20230328095807.7014-6-songmuchun@bytedance.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Mar 2023 14:59:48 +0200
Message-ID: <CANpmjNPZxDYPYzEjr55ONydwH1FZF_Eh_gu7XKg=4-+HK6vL9Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] mm: kfence: change kfence pool page layout
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        jannh@google.com, sjpark@amazon.de, muchun.song@linux.dev,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 at 11:58, 'Muchun Song' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> The original kfence pool layout (Given a layout with 2 objects):
>
>  +------------+------------+------------+------------+------------+------------+
>  | guard page | guard page |   object   | guard page |   object   | guard page |
>  +------------+------------+------------+------------+------------+------------+
>                            |                         |                         |
>                            +----kfence_metadata[0]---+----kfence_metadata[1]---+
>
> The comment says "the additional page in the beginning gives us an even
> number of pages, which simplifies the mapping of address to metadata index".
>
> However, removing the additional page does not complicate any mapping
> calculations. So changing it to the new layout to save a page. And remmove
> the KFENCE_ERROR_INVALID test since we cannot test this case easily.
>
> The new kfence pool layout (Given a layout with 2 objects):
>
>  +------------+------------+------------+------------+------------+
>  | guard page |   object   | guard page |   object   | guard page |
>  +------------+------------+------------+------------+------------+
>  |                         |                         |
>  +----kfence_metadata[0]---+----kfence_metadata[1]---+
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/kfence.h  |  8 ++------
>  mm/kfence/core.c        | 40 ++++++++--------------------------------
>  mm/kfence/kfence.h      |  2 +-
>  mm/kfence/kfence_test.c | 14 --------------
>  4 files changed, 11 insertions(+), 53 deletions(-)
>
> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> index 726857a4b680..25b13a892717 100644
> --- a/include/linux/kfence.h
> +++ b/include/linux/kfence.h
> @@ -19,12 +19,8 @@
>
>  extern unsigned long kfence_sample_interval;
>
> -/*
> - * We allocate an even number of pages, as it simplifies calculations to map
> - * address to metadata indices; effectively, the very first page serves as an
> - * extended guard page, but otherwise has no special purpose.
> - */
> -#define KFENCE_POOL_SIZE ((CONFIG_KFENCE_NUM_OBJECTS + 1) * 2 * PAGE_SIZE)
> +/* The last page serves as an extended guard page. */

The last page is just a normal guard page? I.e. the last 2 pages are:
<object page> | <guard page>

Or did I misunderstand?

> +#define KFENCE_POOL_SIZE       ((CONFIG_KFENCE_NUM_OBJECTS * 2 + 1) * PAGE_SIZE)
>  extern char *__kfence_pool;
>
>  DECLARE_STATIC_KEY_FALSE(kfence_allocation_key);
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 41befcb3b069..f205b860f460 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -240,24 +240,7 @@ static inline void kfence_unprotect(unsigned long addr)
>
>  static inline unsigned long metadata_to_pageaddr(const struct kfence_metadata *meta)
>  {
> -       unsigned long offset = (meta - kfence_metadata + 1) * PAGE_SIZE * 2;
> -       unsigned long pageaddr = (unsigned long)&__kfence_pool[offset];
> -
> -       /* The checks do not affect performance; only called from slow-paths. */
> -
> -       /* Only call with a pointer into kfence_metadata. */
> -       if (KFENCE_WARN_ON(meta < kfence_metadata ||
> -                          meta >= kfence_metadata + CONFIG_KFENCE_NUM_OBJECTS))
> -               return 0;

Could we retain this WARN_ON? Or just get rid of
metadata_to_pageaddr() altogether, because there's only 1 use left and
the function would now just be a simple ALIGN_DOWN() anyway.

> -       /*
> -        * This metadata object only ever maps to 1 page; verify that the stored
> -        * address is in the expected range.
> -        */
> -       if (KFENCE_WARN_ON(ALIGN_DOWN(meta->addr, PAGE_SIZE) != pageaddr))
> -               return 0;
> -
> -       return pageaddr;
> +       return ALIGN_DOWN(meta->addr, PAGE_SIZE);
>  }
>
>  /*
> @@ -535,34 +518,27 @@ static void kfence_init_pool(void)
>         unsigned long addr = (unsigned long)__kfence_pool;
>         int i;
>
> -       /*
> -        * Protect the first 2 pages. The first page is mostly unnecessary, and
> -        * merely serves as an extended guard page. However, adding one
> -        * additional page in the beginning gives us an even number of pages,
> -        * which simplifies the mapping of address to metadata index.
> -        */
> -       for (i = 0; i < 2; i++, addr += PAGE_SIZE)
> -               kfence_protect(addr);
> -
>         for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++, addr += 2 * PAGE_SIZE) {
>                 struct kfence_metadata *meta = &kfence_metadata[i];
> -               struct slab *slab = page_slab(virt_to_page(addr));
> +               struct slab *slab = page_slab(virt_to_page(addr + PAGE_SIZE));
>
>                 /* Initialize metadata. */
>                 INIT_LIST_HEAD(&meta->list);
>                 raw_spin_lock_init(&meta->lock);
>                 meta->state = KFENCE_OBJECT_UNUSED;
> -               meta->addr = addr; /* Initialize for validation in metadata_to_pageaddr(). */
> +               meta->addr = addr + PAGE_SIZE;
>                 list_add_tail(&meta->list, &kfence_freelist);
>
> -               /* Protect the right redzone. */
> -               kfence_protect(addr + PAGE_SIZE);
> +               /* Protect the left redzone. */
> +               kfence_protect(addr);
>
>                 __folio_set_slab(slab_folio(slab));
>  #ifdef CONFIG_MEMCG
>                 slab->memcg_data = (unsigned long)&meta->objcg | MEMCG_DATA_OBJCGS;
>  #endif
>         }
> +
> +       kfence_protect(addr);
>  }
>
>  static bool __init kfence_init_pool_early(void)
> @@ -1043,7 +1019,7 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
>
>         atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
>
> -       if (page_index % 2) {
> +       if (page_index % 2 == 0) {
>                 /* This is a redzone, report a buffer overflow. */
>                 struct kfence_metadata *meta;
>                 int distance = 0;
> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> index 600f2e2431d6..249d420100a7 100644
> --- a/mm/kfence/kfence.h
> +++ b/mm/kfence/kfence.h
> @@ -110,7 +110,7 @@ static inline struct kfence_metadata *addr_to_metadata(unsigned long addr)
>          * __kfence_pool, in which case we would report an "invalid access"
>          * error.
>          */
> -       index = (addr - (unsigned long)__kfence_pool) / (PAGE_SIZE * 2) - 1;
> +       index = (addr - (unsigned long)__kfence_pool) / (PAGE_SIZE * 2);
>         if (index < 0 || index >= CONFIG_KFENCE_NUM_OBJECTS)
>                 return NULL;

Assume there is a right OOB that hit the last guard page. In this case

  addr >= __kfence_pool + (NUM_OBJECTS * 2 * PAGE_SIZE) && addr <
__kfence_pool + POOL_SIZE

therefore

  index >= (NUM_OBJECTS * 2 * PAGE_SIZE) / (PAGE_SIZE * 2) && index <
POOL_SIZE / (PAGE_SIZE * 2)
  index == NUM_OBJECTS

And according to the above comparison, this will return NULL and
report KFENCE_ERROR_INVALID, which is wrong.

> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index b5d66a69200d..d479f9c8afb1 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -637,19 +637,6 @@ static void test_gfpzero(struct kunit *test)
>         KUNIT_EXPECT_FALSE(test, report_available());
>  }
>
> -static void test_invalid_access(struct kunit *test)
> -{
> -       const struct expect_report expect = {
> -               .type = KFENCE_ERROR_INVALID,
> -               .fn = test_invalid_access,
> -               .addr = &__kfence_pool[10],
> -               .is_write = false,
> -       };
> -
> -       READ_ONCE(__kfence_pool[10]);
> -       KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> -}
> -
>  /* Test SLAB_TYPESAFE_BY_RCU works. */
>  static void test_memcache_typesafe_by_rcu(struct kunit *test)
>  {
> @@ -787,7 +774,6 @@ static struct kunit_case kfence_test_cases[] = {
>         KUNIT_CASE(test_kmalloc_aligned_oob_write),
>         KUNIT_CASE(test_shrink_memcache),
>         KUNIT_CASE(test_memcache_ctor),
> -       KUNIT_CASE(test_invalid_access),

The test can be retained by doing an access to a guard page in between
2 unallocated objects. But it's probably not that easy to reliably set
that up (could try to allocate 2 objects and see if they're next to
each other, then free them).

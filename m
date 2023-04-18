Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DB76E5E53
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjDRKLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjDRKLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:11:09 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A176A4E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:10:39 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7606df33c42so50705739f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681812639; x=1684404639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=galNuw/biFG4LXA5HDGOsFD5DzMSzVWuBOk2kSXMjaQ=;
        b=q6JfMBnuReWJl6/1zXE1nYutbcRaaaEXv9F9KYqOh9WNYwM5cV8dnLrLMS+ab/Rmg4
         R6MjOR4zcSFzibYpW9dVsQ5kjBb7ktKYbFqhAPu/RKUPlBBSk4cTBOyhTeyUzVFL4MMC
         iGd2gKTsXoA+auZkAJ0G3MGxsjD+fpQNdJoNd8fMZn2IQCueMK08vv3be4hFgzNDFkEO
         OUPZsBH6fnKrKkLAZXkZCemQUFhVLHF5q5v50gfyX72O23eEv0eiITQjTqHWhaWQGtjx
         8zL7/u4WJ9DGqs3nuQ8ujsdMTpTL6JW0sQvb3pHJErvJJkQeLrWfh/R4g1536x28rmMI
         4hWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681812639; x=1684404639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=galNuw/biFG4LXA5HDGOsFD5DzMSzVWuBOk2kSXMjaQ=;
        b=Sp+QHy6/YFixX0sCAM5TI4wwE+9BkK7zMbhTm6qzSmC4Cc1IVL0eHxLAPyQipyfjsN
         I+SPegtFIWrlXjvx1RreKmYoUvpbV3is7XpMMebN89HMnYtzwqnL9wOIVQxgbjvoW1vz
         oJUpL2VbWa330ESR5OKVM24ZCq6WogvcDcYbRCx8oqj6oVfjjb/DlL9G5PbUAfopwu7m
         lU/xQea9SxOcwyMbzC5JwCnAhT9lqQKHRIVeJEnzfHa/Gcf8h00BzcjM7UcYEo9Tk1hq
         9L+E0hDJRMYzg4X3lMHUdZhi2XpHA1bkjiYEAsMVOP81m8TZnlyVOMf33qYbGNEbVoGq
         FroA==
X-Gm-Message-State: AAQBX9ewAJ5CB8qDTe3pKB9ueG1x7+NBgtYfURaFJ40gj9AXHrZEL4Qa
        6AOE+zKd1ASta84ofOX8Ma4uCtkbNdLR3BkywBbiMA==
X-Google-Smtp-Source: AKy350YVy3JmfQcviI31LBq4X5LNVqsne/W6d19FhvX/nKVWXNgZd5NpWsZ4AsaUF6j81qIqnDHEcwqg1ATjJVoXzj4=
X-Received: by 2002:a6b:7210:0:b0:75d:b1:b718 with SMTP id n16-20020a6b7210000000b0075d00b1b718mr1205992ioc.9.1681812639142;
 Tue, 18 Apr 2023 03:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230413131223.4135168-1-glider@google.com>
In-Reply-To: <20230413131223.4135168-1-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 18 Apr 2023 12:10:02 +0200
Message-ID: <CANpmjNMd-p6ejwsMugOM84mkqcuLrXpNg1EUJTYRUsEtV1swpQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()
To:     Alexander Potapenko <glider@google.com>
Cc:     urezki@gmail.com, hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, dvyukov@google.com,
        kasan-dev@googlegroups.com,
        Dipanjan Das <mail.dipanjan.das@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023 at 15:12, Alexander Potapenko <glider@google.com> wrote:
>
> As reported by Dipanjan Das, when KMSAN is used together with kernel
> fault injection (or, generally, even without the latter), calls to
> kcalloc() or __vmap_pages_range_noflush() may fail, leaving the
> metadata mappings for the virtual mapping in an inconsistent state.
> When these metadata mappings are accessed later, the kernel crashes.
>
> To address the problem, we return a non-zero error code from
> kmsan_vmap_pages_range_noflush() in the case of any allocation/mapping
> failure inside it, and make vmap_pages_range_noflush() return an error
> if KMSAN fails to allocate the metadata.
>
> This patch also removes KMSAN_WARN_ON() from vmap_pages_range_noflush(),
> as these allocation failures are not fatal anymore.
>
> Reported-by: Dipanjan Das <mail.dipanjan.das@gmail.com>
> Link: https://lore.kernel.org/linux-mm/CANX2M5ZRrRA64k0hOif02TjmY9kbbO2aCBPyq79es34RXZ=cAw@mail.gmail.com/
> Fixes: b073d7f8aee4 ("mm: kmsan: maintain KMSAN metadata for page operations")
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Marco Elver <elver@google.com>

Looks reasonable, thanks.

> ---
> v2:
>  -- return 0 from the inline version of kmsan_vmap_pages_range_noflush()
>     (spotted by kernel test robot <lkp@intel.com>)
> ---
>  include/linux/kmsan.h | 20 +++++++++++---------
>  mm/kmsan/shadow.c     | 27 ++++++++++++++++++---------
>  mm/vmalloc.c          |  6 +++++-
>  3 files changed, 34 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
> index e38ae3c346184..c7ff3aefc5a13 100644
> --- a/include/linux/kmsan.h
> +++ b/include/linux/kmsan.h
> @@ -134,11 +134,12 @@ void kmsan_kfree_large(const void *ptr);
>   * @page_shift:        page_shift passed to vmap_range_noflush().
>   *
>   * KMSAN maps shadow and origin pages of @pages into contiguous ranges in
> - * vmalloc metadata address range.
> + * vmalloc metadata address range. Returns 0 on success, callers must check
> + * for non-zero return value.
>   */
> -void kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
> -                                   pgprot_t prot, struct page **pages,
> -                                   unsigned int page_shift);
> +int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
> +                                  pgprot_t prot, struct page **pages,
> +                                  unsigned int page_shift);
>
>  /**
>   * kmsan_vunmap_kernel_range_noflush() - Notify KMSAN about a vunmap.
> @@ -281,12 +282,13 @@ static inline void kmsan_kfree_large(const void *ptr)
>  {
>  }
>
> -static inline void kmsan_vmap_pages_range_noflush(unsigned long start,
> -                                                 unsigned long end,
> -                                                 pgprot_t prot,
> -                                                 struct page **pages,
> -                                                 unsigned int page_shift)
> +static inline int kmsan_vmap_pages_range_noflush(unsigned long start,
> +                                                unsigned long end,
> +                                                pgprot_t prot,
> +                                                struct page **pages,
> +                                                unsigned int page_shift)
>  {
> +       return 0;
>  }
>
>  static inline void kmsan_vunmap_range_noflush(unsigned long start,
> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
> index a787c04e9583c..b8bb95eea5e3d 100644
> --- a/mm/kmsan/shadow.c
> +++ b/mm/kmsan/shadow.c
> @@ -216,27 +216,29 @@ void kmsan_free_page(struct page *page, unsigned int order)
>         kmsan_leave_runtime();
>  }
>
> -void kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
> -                                   pgprot_t prot, struct page **pages,
> -                                   unsigned int page_shift)
> +int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
> +                                  pgprot_t prot, struct page **pages,
> +                                  unsigned int page_shift)
>  {
>         unsigned long shadow_start, origin_start, shadow_end, origin_end;
>         struct page **s_pages, **o_pages;
> -       int nr, mapped;
> +       int nr, mapped, err = 0;
>
>         if (!kmsan_enabled)
> -               return;
> +               return 0;
>
>         shadow_start = vmalloc_meta((void *)start, KMSAN_META_SHADOW);
>         shadow_end = vmalloc_meta((void *)end, KMSAN_META_SHADOW);
>         if (!shadow_start)
> -               return;
> +               return 0;
>
>         nr = (end - start) / PAGE_SIZE;
>         s_pages = kcalloc(nr, sizeof(*s_pages), GFP_KERNEL);
>         o_pages = kcalloc(nr, sizeof(*o_pages), GFP_KERNEL);
> -       if (!s_pages || !o_pages)
> +       if (!s_pages || !o_pages) {
> +               err = -ENOMEM;
>                 goto ret;
> +       }
>         for (int i = 0; i < nr; i++) {
>                 s_pages[i] = shadow_page_for(pages[i]);
>                 o_pages[i] = origin_page_for(pages[i]);
> @@ -249,10 +251,16 @@ void kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
>         kmsan_enter_runtime();
>         mapped = __vmap_pages_range_noflush(shadow_start, shadow_end, prot,
>                                             s_pages, page_shift);
> -       KMSAN_WARN_ON(mapped);
> +       if (mapped) {
> +               err = mapped;
> +               goto ret;
> +       }
>         mapped = __vmap_pages_range_noflush(origin_start, origin_end, prot,
>                                             o_pages, page_shift);
> -       KMSAN_WARN_ON(mapped);
> +       if (mapped) {
> +               err = mapped;
> +               goto ret;
> +       }
>         kmsan_leave_runtime();
>         flush_tlb_kernel_range(shadow_start, shadow_end);
>         flush_tlb_kernel_range(origin_start, origin_end);
> @@ -262,6 +270,7 @@ void kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
>  ret:
>         kfree(s_pages);
>         kfree(o_pages);
> +       return err;
>  }
>
>  /* Allocate metadata for pages allocated at boot time. */
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a50072066221a..1355d95cce1ca 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -605,7 +605,11 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>  int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>                 pgprot_t prot, struct page **pages, unsigned int page_shift)
>  {
> -       kmsan_vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
> +       int ret = kmsan_vmap_pages_range_noflush(addr, end, prot, pages,
> +                                                page_shift);
> +
> +       if (ret)
> +               return ret;
>         return __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
>  }
>
> --
> 2.40.0.577.gac1e443424-goog
>

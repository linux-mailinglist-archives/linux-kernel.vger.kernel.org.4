Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581396E5E59
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjDRKLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjDRKLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:11:19 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437A859C1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:11:04 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-32b2485c0b1so1847675ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681812663; x=1684404663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qkfA+RN8+NxglUFBtFLBAQbfb++ZPOPFuIp98xxhha0=;
        b=MmwB5ib1jiB1vveishoJODEjHtjcRFokuTQ+zoReKj4y6MHzILRvRxPxQikoUZ3gpg
         OzDLNgHEdo17gJTBx4c6NcHJYTqHtZkfFeJbNgY9nvxcxjDA1+D99cfiApUuBfECaNUW
         yn2RbQ1mGm/WgRlOmRkfOr0afQMeRiP80XJAPzYWduLXDm0+qOuS0RugqlO3FQbbKLMb
         NZPzmmHxLyRPXXJ3ixqfD9axn9QJlYi45/FUj9a6EqSBtCAth5OUUwqqStXgbx012Qb4
         yCEmf8bMROeA78mVQh/64uLXqnxilN/Kguv4LTDZOHuEQ/RfCax5irsd+jHMI/Rq0Olc
         L+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681812663; x=1684404663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkfA+RN8+NxglUFBtFLBAQbfb++ZPOPFuIp98xxhha0=;
        b=MwTRbbPujBV5Vy+NisTsuxIBQRqauNWWkBdc7WoIAD5lywD7liIl6PVAb6K4/49mfE
         Pl15IN4WIZuPzGDc9vFckkH+2OQBuLIYbe7UrSIiLe5T3aZYAsWq7FAuWuhdBDVV1/rP
         VJR9cp8NX1eh6ZgbUsff3uvPbZ6oe/uG2uM8YFR42uyGkptBaJ/hagMLRXZPNlth8eqC
         AFttl3P+T4hnzZodFx5IyRL/kUz6vQbvDQTfHHT+PT/TW+n3OUMalVueP7rvZF0WD/lN
         7PAEW+vzxwmBMIFQgHWiK/E0m6/KDU3W8SYPJRPO1FiOAEGpq1hDKooJ6cKr6/gvXwA8
         Soog==
X-Gm-Message-State: AAQBX9c/6uOKT+uh2gVPBxOGfDkVzYyV7JhtyfxnCkOGmKycND4UXo6N
        eF4W1KDrN4bRzEYedcE7pkb57CTcfQ9QDA+9SDnCORA98XKniQUQIyhdhw==
X-Google-Smtp-Source: AKy350aerQraOJZ/IlNOLQy+h6vs4wtRqD4ScpxSOOhcGpktvkaRORLvGcdmd2MNK01I92oGFDmBNJrDwPeRokzyzGs=
X-Received: by 2002:a92:1301:0:b0:326:68bc:b423 with SMTP id
 1-20020a921301000000b0032668bcb423mr12482145ilt.20.1681812663485; Tue, 18 Apr
 2023 03:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230413131223.4135168-1-glider@google.com> <20230413131223.4135168-2-glider@google.com>
In-Reply-To: <20230413131223.4135168-2-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 18 Apr 2023 12:10:27 +0200
Message-ID: <CANpmjNML3wQjaxujkAxWiTVwgBaUtbCPEQES7duh0ktyT2ddTQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mm: kmsan: handle alloc failures in kmsan_ioremap_page_range()
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
> Similarly to kmsan_vmap_pages_range_noflush(),
> kmsan_ioremap_page_range() must also properly handle allocation/mapping
> failures. In the case of such, it must clean up the already created
> metadata mappings and return an error code, so that the error can be
> propagated to ioremap_page_range(). Without doing so, KMSAN may silently
> fail to bring the metadata for the page range into a consistent state,
> which will result in user-visible crashes when trying to access them.
>
> Reported-by: Dipanjan Das <mail.dipanjan.das@gmail.com>
> Link: https://lore.kernel.org/linux-mm/CANX2M5ZRrRA64k0hOif02TjmY9kbbO2aCBPyq79es34RXZ=cAw@mail.gmail.com/
> Fixes: b073d7f8aee4 ("mm: kmsan: maintain KMSAN metadata for page operations")
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> v2:
>  -- updated patch description as requested by Andrew Morton
>  -- check the return value of __vmap_pages_range_noflush(), as suggested by Dipanjan Das
>  -- return 0 from the inline version of kmsan_ioremap_page_range()
>     (spotted by kernel test robot <lkp@intel.com>)
> ---
>  include/linux/kmsan.h | 19 ++++++++-------
>  mm/kmsan/hooks.c      | 55 ++++++++++++++++++++++++++++++++++++-------
>  mm/vmalloc.c          |  4 ++--
>  3 files changed, 59 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
> index c7ff3aefc5a13..30b17647ce3c7 100644
> --- a/include/linux/kmsan.h
> +++ b/include/linux/kmsan.h
> @@ -160,11 +160,12 @@ void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end);
>   * @page_shift:        page_shift argument passed to vmap_range_noflush().
>   *
>   * KMSAN creates new metadata pages for the physical pages mapped into the
> - * virtual memory.
> + * virtual memory. Returns 0 on success, callers must check for non-zero return
> + * value.
>   */
> -void kmsan_ioremap_page_range(unsigned long addr, unsigned long end,
> -                             phys_addr_t phys_addr, pgprot_t prot,
> -                             unsigned int page_shift);
> +int kmsan_ioremap_page_range(unsigned long addr, unsigned long end,
> +                            phys_addr_t phys_addr, pgprot_t prot,
> +                            unsigned int page_shift);
>
>  /**
>   * kmsan_iounmap_page_range() - Notify KMSAN about a iounmap_page_range() call.
> @@ -296,12 +297,12 @@ static inline void kmsan_vunmap_range_noflush(unsigned long start,
>  {
>  }
>
> -static inline void kmsan_ioremap_page_range(unsigned long start,
> -                                           unsigned long end,
> -                                           phys_addr_t phys_addr,
> -                                           pgprot_t prot,
> -                                           unsigned int page_shift)
> +static inline int kmsan_ioremap_page_range(unsigned long start,
> +                                          unsigned long end,
> +                                          phys_addr_t phys_addr, pgprot_t prot,
> +                                          unsigned int page_shift)
>  {
> +       return 0;
>  }
>
>  static inline void kmsan_iounmap_page_range(unsigned long start,
> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> index 3807502766a3e..ec0da72e65aa0 100644
> --- a/mm/kmsan/hooks.c
> +++ b/mm/kmsan/hooks.c
> @@ -148,35 +148,74 @@ void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end)
>   * into the virtual memory. If those physical pages already had shadow/origin,
>   * those are ignored.
>   */
> -void kmsan_ioremap_page_range(unsigned long start, unsigned long end,
> -                             phys_addr_t phys_addr, pgprot_t prot,
> -                             unsigned int page_shift)
> +int kmsan_ioremap_page_range(unsigned long start, unsigned long end,
> +                            phys_addr_t phys_addr, pgprot_t prot,
> +                            unsigned int page_shift)
>  {
>         gfp_t gfp_mask = GFP_KERNEL | __GFP_ZERO;
>         struct page *shadow, *origin;
>         unsigned long off = 0;
> -       int nr;
> +       int nr, err = 0, clean = 0, mapped;
>
>         if (!kmsan_enabled || kmsan_in_runtime())
> -               return;
> +               return 0;
>
>         nr = (end - start) / PAGE_SIZE;
>         kmsan_enter_runtime();
> -       for (int i = 0; i < nr; i++, off += PAGE_SIZE) {
> +       for (int i = 0; i < nr; i++, off += PAGE_SIZE, clean = i) {
>                 shadow = alloc_pages(gfp_mask, 1);
>                 origin = alloc_pages(gfp_mask, 1);
> -               __vmap_pages_range_noflush(
> +               if (!shadow || !origin) {
> +                       err = -ENOMEM;
> +                       goto ret;
> +               }
> +               mapped = __vmap_pages_range_noflush(
>                         vmalloc_shadow(start + off),
>                         vmalloc_shadow(start + off + PAGE_SIZE), prot, &shadow,
>                         PAGE_SHIFT);
> -               __vmap_pages_range_noflush(
> +               if (mapped) {
> +                       err = mapped;
> +                       goto ret;
> +               }
> +               shadow = NULL;
> +               mapped = __vmap_pages_range_noflush(
>                         vmalloc_origin(start + off),
>                         vmalloc_origin(start + off + PAGE_SIZE), prot, &origin,
>                         PAGE_SHIFT);
> +               if (mapped) {
> +                       __vunmap_range_noflush(
> +                               vmalloc_shadow(start + off),
> +                               vmalloc_shadow(start + off + PAGE_SIZE));
> +                       err = mapped;
> +                       goto ret;
> +               }
> +               origin = NULL;
> +       }
> +       /* Page mapping loop finished normally, nothing to clean up. */
> +       clean = 0;
> +
> +ret:
> +       if (clean > 0) {
> +               /*
> +                * Something went wrong. Clean up shadow/origin pages allocated
> +                * on the last loop iteration, then delete mappings created
> +                * during the previous iterations.
> +                */
> +               if (shadow)
> +                       __free_pages(shadow, 1);
> +               if (origin)
> +                       __free_pages(origin, 1);
> +               __vunmap_range_noflush(
> +                       vmalloc_shadow(start),
> +                       vmalloc_shadow(start + clean * PAGE_SIZE));
> +               __vunmap_range_noflush(
> +                       vmalloc_origin(start),
> +                       vmalloc_origin(start + clean * PAGE_SIZE));
>         }
>         flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
>         flush_cache_vmap(vmalloc_origin(start), vmalloc_origin(end));
>         kmsan_leave_runtime();
> +       return err;
>  }
>
>  void kmsan_iounmap_page_range(unsigned long start, unsigned long end)
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 1355d95cce1ca..31ff782d368b0 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -313,8 +313,8 @@ int ioremap_page_range(unsigned long addr, unsigned long end,
>                                  ioremap_max_page_shift);
>         flush_cache_vmap(addr, end);
>         if (!err)
> -               kmsan_ioremap_page_range(addr, end, phys_addr, prot,
> -                                        ioremap_max_page_shift);
> +               err = kmsan_ioremap_page_range(addr, end, phys_addr, prot,
> +                                              ioremap_max_page_shift);
>         return err;
>  }
>
> --
> 2.40.0.577.gac1e443424-goog
>

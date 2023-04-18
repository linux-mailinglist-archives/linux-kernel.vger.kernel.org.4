Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397406E5E5B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjDRKLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjDRKLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:11:31 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9057E7ED8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:11:18 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-760a5e0f752so50790339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681812678; x=1684404678;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ng21oiPWmKz3a89ft5u8IMQfso9W3BdH67nYr79Gs5M=;
        b=ifC3WCXPk8UcG4wyc+rvnaSmSdINDXl0eyT373IDLH/LxDOum5KlsJaWXB/9tPCEdG
         yLVcZP8pO3assuuduh5Lu8Z3cwF8GkiToZPMk+ql1+8wdNrRW2LZy3oGVHf5/LQ4upP8
         mLXNuHh0L+z0EeGyR2S2A3s6IEvHW/1j6GY51NzdpPk7FeUzZvHwsfuWAImMZvl6vL3C
         7RHmPKMMI8BCRfeBzQGNtVZLwBTINn/76H3IBUS6/92kpg8Hk/8A6Yf5lJ8l1f3Dy6cn
         ltGzpoBNDvn7RFsjJe59cvqzpnK55fW2U7zAYcicgB1t9e9TQr2xO66f9WeBk8V5ydQk
         eHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681812678; x=1684404678;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ng21oiPWmKz3a89ft5u8IMQfso9W3BdH67nYr79Gs5M=;
        b=ftmECoHCWnomvgRvB+NCyl9ptzkJIc2ElHyRKRiVd5wenQ9C7t6/UQwf5ZmHZ/t7g+
         7VYHp0a/fKKQeuUYffppJ4Yewc0VBY5XymuDUIc7e44DdKgUglsCLGGue2LfrfvaGF7Q
         Ziz6cr6gcncpzOoEFf3y0kYjVC/xSfkyR0isoQYhzLZc6prN3WAbQVwoj9Gby5oFCaCT
         lOcTAo2fzbXSRn3lbl1IskKTeN2msfrvY9BLq0WH9vv1d47hS/sLOZKi6ZF5xXA16/QD
         Wprwpx9ei2fLrTIM8CZENbato1xetApf6JiFT1AQ8F3AAXeeyZqjkiRNs8WSgYn5NS3J
         +EFA==
X-Gm-Message-State: AAQBX9d4lwU0oy0E1iWKHjS4Kfzj0p1UVj2OyMCmpa3NAe6Q+wQ7LmFM
        a3oSyj6GNOo48B7ZQh6+kjQV/h7YmOn+b5BdeK+yfA==
X-Google-Smtp-Source: AKy350ah4A8lF6+VI7JYsQ1JDa4qs8My/dWN3qsWVOlA7+aCrVzqNcvEDRfc02xEpUlbDgVOabsGM8ljVnDvAKMuIUs=
X-Received: by 2002:a6b:ec1a:0:b0:763:5f51:aff7 with SMTP id
 c26-20020a6bec1a000000b007635f51aff7mr1394065ioh.5.1681812677553; Tue, 18 Apr
 2023 03:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230413131223.4135168-1-glider@google.com> <20230413131223.4135168-3-glider@google.com>
In-Reply-To: <20230413131223.4135168-3-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 18 Apr 2023 12:10:41 +0200
Message-ID: <CANpmjNPuKyOOKptYU19E2Q=YX7rNv6EuY9ajnVw6BYRw-g79vg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mm: kmsan: apply __must_check to non-void functions
To:     Alexander Potapenko <glider@google.com>
Cc:     urezki@gmail.com, hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, dvyukov@google.com,
        kasan-dev@googlegroups.com
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

On Thu, 13 Apr 2023 at 15:12, 'Alexander Potapenko' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Non-void KMSAN hooks may return error codes that indicate that KMSAN
> failed to reflect the changed memory state in the metadata (e.g. it
> could not create the necessary memory mappings). In such cases the
> callers should handle the errors to prevent the tool from using the
> inconsistent metadata in the future.
>
> We mark non-void hooks with __must_check so that error handling is not
> skipped.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  include/linux/kmsan.h | 43 ++++++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
> index 30b17647ce3c7..e0c23a32cdf01 100644
> --- a/include/linux/kmsan.h
> +++ b/include/linux/kmsan.h
> @@ -54,7 +54,8 @@ void __init kmsan_init_runtime(void);
>   * Freed pages are either returned to buddy allocator or held back to be used
>   * as metadata pages.
>   */
> -bool __init kmsan_memblock_free_pages(struct page *page, unsigned int order);
> +bool __init __must_check kmsan_memblock_free_pages(struct page *page,
> +                                                  unsigned int order);
>
>  /**
>   * kmsan_alloc_page() - Notify KMSAN about an alloc_pages() call.
> @@ -137,9 +138,11 @@ void kmsan_kfree_large(const void *ptr);
>   * vmalloc metadata address range. Returns 0 on success, callers must check
>   * for non-zero return value.
>   */
> -int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
> -                                  pgprot_t prot, struct page **pages,
> -                                  unsigned int page_shift);
> +int __must_check kmsan_vmap_pages_range_noflush(unsigned long start,
> +                                               unsigned long end,
> +                                               pgprot_t prot,
> +                                               struct page **pages,
> +                                               unsigned int page_shift);
>
>  /**
>   * kmsan_vunmap_kernel_range_noflush() - Notify KMSAN about a vunmap.
> @@ -163,9 +166,9 @@ void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end);
>   * virtual memory. Returns 0 on success, callers must check for non-zero return
>   * value.
>   */
> -int kmsan_ioremap_page_range(unsigned long addr, unsigned long end,
> -                            phys_addr_t phys_addr, pgprot_t prot,
> -                            unsigned int page_shift);
> +int __must_check kmsan_ioremap_page_range(unsigned long addr, unsigned long end,
> +                                         phys_addr_t phys_addr, pgprot_t prot,
> +                                         unsigned int page_shift);
>
>  /**
>   * kmsan_iounmap_page_range() - Notify KMSAN about a iounmap_page_range() call.
> @@ -237,8 +240,8 @@ static inline void kmsan_init_runtime(void)
>  {
>  }
>
> -static inline bool kmsan_memblock_free_pages(struct page *page,
> -                                            unsigned int order)
> +static inline bool __must_check kmsan_memblock_free_pages(struct page *page,
> +                                                         unsigned int order)
>  {
>         return true;
>  }
> @@ -251,10 +254,9 @@ static inline void kmsan_task_exit(struct task_struct *task)
>  {
>  }
>
> -static inline int kmsan_alloc_page(struct page *page, unsigned int order,
> -                                  gfp_t flags)
> +static inline void kmsan_alloc_page(struct page *page, unsigned int order,
> +                                   gfp_t flags)
>  {
> -       return 0;
>  }
>
>  static inline void kmsan_free_page(struct page *page, unsigned int order)
> @@ -283,11 +285,9 @@ static inline void kmsan_kfree_large(const void *ptr)
>  {
>  }
>
> -static inline int kmsan_vmap_pages_range_noflush(unsigned long start,
> -                                                unsigned long end,
> -                                                pgprot_t prot,
> -                                                struct page **pages,
> -                                                unsigned int page_shift)
> +static inline int __must_check kmsan_vmap_pages_range_noflush(
> +       unsigned long start, unsigned long end, pgprot_t prot,
> +       struct page **pages, unsigned int page_shift)
>  {
>         return 0;
>  }
> @@ -297,10 +297,11 @@ static inline void kmsan_vunmap_range_noflush(unsigned long start,
>  {
>  }
>
> -static inline int kmsan_ioremap_page_range(unsigned long start,
> -                                          unsigned long end,
> -                                          phys_addr_t phys_addr, pgprot_t prot,
> -                                          unsigned int page_shift)
> +static inline int __must_check kmsan_ioremap_page_range(unsigned long start,
> +                                                       unsigned long end,
> +                                                       phys_addr_t phys_addr,
> +                                                       pgprot_t prot,
> +                                                       unsigned int page_shift)
>  {
>         return 0;
>  }
> --
> 2.40.0.577.gac1e443424-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20230413131223.4135168-3-glider%40google.com.

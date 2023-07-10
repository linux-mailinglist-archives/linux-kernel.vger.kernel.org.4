Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB8874D339
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjGJKUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjGJKUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:20:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFA510D9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:20:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso45120495e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688984427; x=1691576427;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KO1SxVtMO5vB92CZUE0zhLXTJjAA8Kw6VkcMKrG36Wg=;
        b=hrK+K2RBJk+T3MdMLp8EadIPwWxixUSriE/4t9PrkQYRX8fkZxQ1XvVX6Bej8VhhGN
         KtMbNphsSEl6eDMbGcoTL0Hcxk1BgFEkeLe73diEBHvMBYINp1J3LrrWlPAag/Drmskt
         qTpfAy5duNPGl3FvlgjI4xxfKVJo97nhOeuzrrVhUyuGwcFvhj7FG5Ne6VwR8ijLMwPY
         tduUjHumhml9vD1qc0Xb2oimPBuN/8PyNxx/Vd4hOoFpYpP5qZ0WNOlA7A7e1PzO7DAu
         RPVngDayC2V7eXQLYBIC68yFpQ9JoNH11AM3Qj4DkSpIlJxL5yYI47pWXHzsH4pJg6nC
         6Znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688984427; x=1691576427;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KO1SxVtMO5vB92CZUE0zhLXTJjAA8Kw6VkcMKrG36Wg=;
        b=K/GPnOOasds0G0AGQ5MGxGTujnG+xf6aWomZcbdVpOXS0WeRXiB4qz46faXszpfN3y
         HnSO8QjSwnEYhWze2+acJg9E9tFWRkkAaLmtKYlMLUKJ3JLT2hN3rjbHgD7HiVl7FtSD
         PFzY/+LZ9a+KwWPPd/lh12inFjDajhujKgAnDGCnlSM6fjj89husu6t/bzCFE8aEu6l8
         yI0HjJ+cbk0a4RKp4GNfKG18c0Nb0KX65sQXkj9lyK+C7c+yYqbH8rWKbTuNQjyQmSYV
         VPhlW8WTe39E6pPDplb/klOzr+z8FsTdsqhXVmnYWsg8EImz5K+zvHBsgp3sk4IPpMiN
         S3HA==
X-Gm-Message-State: ABy/qLZ3XL5A/MBZ6+iHT7L3FDEposmuhN4cgYQ/g+09nSXFCaubPoK/
        m7Lh6/xhw+/OB0S2q3PsLZ0VeImUbGqbrapsswgqLw==
X-Google-Smtp-Source: APBJJlHSXQc+ESPjEz52ZdkpQXzwhCD9qowDHN/4ZXQXgmMSYrietThrhrEqs/C9aalWUxrOkMJ2l5vlEAJaV8/4PN8=
X-Received: by 2002:a1c:7c15:0:b0:3fb:9ef2:157 with SMTP id
 x21-20020a1c7c15000000b003fb9ef20157mr10147681wmc.28.1688984426752; Mon, 10
 Jul 2023 03:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230710032714.26200-1-zhangpeng.00@bytedance.com>
In-Reply-To: <20230710032714.26200-1-zhangpeng.00@bytedance.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 10 Jul 2023 12:19:49 +0200
Message-ID: <CANpmjNOHz+dRbJsAyg29nksPMcd2P6109iPxTem_-b2qfUvXtw@mail.gmail.com>
Subject: Re: [PATCH] mm: kfence: allocate kfence_metadata at runtime
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 at 05:27, 'Peng Zhang' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> kfence_metadata is currently a static array. For the purpose of
> allocating scalable __kfence_pool, we first change it to runtime
> allocation of metadata. Since the size of an object of kfence_metadata
> is 1160 bytes, we can save at least 72 pages (with default 256 objects)
> without enabling kfence.
>
> Below is the numbers obtained in qemu (with default 256 objects).
> before: Memory: 8134692K/8388080K available (3668K bss)
> after: Memory: 8136740K/8388080K available (1620K bss)
> More than expected, it saves 2MB memory.
>
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Seems like a reasonable optimization, but see comments below.

Also with this patch applied on top of v6.5-rc1, KFENCE just doesn't
init at all anymore (early init). Please fix.

> ---
>  mm/kfence/core.c   | 102 ++++++++++++++++++++++++++++++++-------------
>  mm/kfence/kfence.h |   5 ++-
>  2 files changed, 78 insertions(+), 29 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index dad3c0eb70a0..b9fec1c46e3d 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -116,7 +116,7 @@ EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
>   * backing pages (in __kfence_pool).
>   */
>  static_assert(CONFIG_KFENCE_NUM_OBJECTS > 0);
> -struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
> +struct kfence_metadata *kfence_metadata;
>
>  /* Freelist with available objects. */
>  static struct list_head kfence_freelist = LIST_HEAD_INIT(kfence_freelist);
> @@ -643,13 +643,56 @@ static unsigned long kfence_init_pool(void)
>         return addr;
>  }
>
> +static int kfence_alloc_metadata(void)
> +{
> +       unsigned long nr_pages = KFENCE_METADATA_SIZE / PAGE_SIZE;
> +
> +#ifdef CONFIG_CONTIG_ALLOC
> +       struct page *pages;
> +
> +       pages = alloc_contig_pages(nr_pages, GFP_KERNEL, first_online_node,
> +                                  NULL);
> +       if (pages)
> +               kfence_metadata = page_to_virt(pages);
> +#else
> +       if (nr_pages > MAX_ORDER_NR_PAGES) {
> +               pr_warn("KFENCE_NUM_OBJECTS too large for buddy allocator\n");

Does this mean that KFENCE won't work at all if we can't allocate the
metadata? I.e. it won't work either in early nor late init modes?

I know we already have this limitation for _late init_ of the KFENCE pool.

So I have one major question: when doing _early init_, what is the
maximum size of the KFENCE pool (#objects) with this change?

> +               return -EINVAL;
> +       }
> +       kfence_metadata = alloc_pages_exact(KFENCE_METADATA_SIZE,
> +                                           GFP_KERNEL);
> +#endif
> +
> +       if (!kfence_metadata)
> +               return -ENOMEM;
> +
> +       memset(kfence_metadata, 0, KFENCE_METADATA_SIZE);

memzero_explicit, or pass __GFP_ZERO to alloc_pages?

> +       return 0;
> +}
> +
> +static void kfence_free_metadata(void)
> +{
> +       if (WARN_ON(!kfence_metadata))
> +               return;
> +#ifdef CONFIG_CONTIG_ALLOC
> +       free_contig_range(page_to_pfn(virt_to_page((void *)kfence_metadata)),
> +                         KFENCE_METADATA_SIZE / PAGE_SIZE);
> +#else
> +       free_pages_exact((void *)kfence_metadata, KFENCE_METADATA_SIZE);
> +#endif
> +       kfence_metadata = NULL;
> +}
> +
>  static bool __init kfence_init_pool_early(void)
>  {
> -       unsigned long addr;
> +       unsigned long addr = (unsigned long)__kfence_pool;
>
>         if (!__kfence_pool)
>                 return false;
>
> +       if (!kfence_alloc_metadata())
> +               goto free_pool;
> +
>         addr = kfence_init_pool();
>
>         if (!addr) {
> @@ -663,6 +706,7 @@ static bool __init kfence_init_pool_early(void)
>                 return true;
>         }
>
> +       kfence_free_metadata();
>         /*
>          * Only release unprotected pages, and do not try to go back and change
>          * page attributes due to risk of failing to do so as well. If changing
> @@ -670,31 +714,12 @@ static bool __init kfence_init_pool_early(void)
>          * fails for the first page, and therefore expect addr==__kfence_pool in
>          * most failure cases.
>          */
> +free_pool:
>         memblock_free_late(__pa(addr), KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool));
>         __kfence_pool = NULL;
>         return false;
>  }
>
> -static bool kfence_init_pool_late(void)
> -{
> -       unsigned long addr, free_size;
> -
> -       addr = kfence_init_pool();
> -
> -       if (!addr)
> -               return true;
> -
> -       /* Same as above. */
> -       free_size = KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool);
> -#ifdef CONFIG_CONTIG_ALLOC
> -       free_contig_range(page_to_pfn(virt_to_page((void *)addr)), free_size / PAGE_SIZE);
> -#else
> -       free_pages_exact((void *)addr, free_size);
> -#endif
> -       __kfence_pool = NULL;
> -       return false;
> -}
> -
>  /* === DebugFS Interface ==================================================== */
>
>  static int stats_show(struct seq_file *seq, void *v)
> @@ -896,6 +921,10 @@ void __init kfence_init(void)
>  static int kfence_init_late(void)
>  {
>         const unsigned long nr_pages = KFENCE_POOL_SIZE / PAGE_SIZE;
> +       unsigned long addr = (unsigned long)__kfence_pool;
> +       unsigned long free_size = KFENCE_POOL_SIZE;
> +       int ret;
> +
>  #ifdef CONFIG_CONTIG_ALLOC
>         struct page *pages;
>
> @@ -913,15 +942,29 @@ static int kfence_init_late(void)
>                 return -ENOMEM;
>  #endif
>
> -       if (!kfence_init_pool_late()) {
> -               pr_err("%s failed\n", __func__);
> -               return -EBUSY;
> +       ret = kfence_alloc_metadata();
> +       if (!ret)
> +               goto free_pool;
> +
> +       addr = kfence_init_pool();
> +       if (!addr) {
> +               kfence_init_enable();
> +               kfence_debugfs_init();
> +               return 0;
>         }
>
> -       kfence_init_enable();
> -       kfence_debugfs_init();
> +       pr_err("%s failed\n", __func__);
> +       kfence_free_metadata();
> +       free_size = KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool);
> +       ret = -EBUSY;
>
> -       return 0;
> +free_pool:
> +#ifdef CONFIG_CONTIG_ALLOC
> +       free_contig_range(page_to_pfn(virt_to_page((void *)addr)), free_size / PAGE_SIZE);
> +#else
> +       free_pages_exact((void *)addr, free_size);
> +#endif

You moved this from kfence_init_pool_late - that did "__kfence_pool =
NULL" which is missing now.

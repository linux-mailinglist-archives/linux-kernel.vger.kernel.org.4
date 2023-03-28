Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D8B6CBE33
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjC1L4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjC1Lz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:55:59 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDBF8A43
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:55:52 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id y5so14655680ybu.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680004551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0RDSxhLBnZBh5cghIRz0nx4zak4on0GX/pcez2mBW0M=;
        b=KcnVfpk4uE9LTauMzRtmeaGv6EDTWomuW68Wt1R9t7TDQjJJyonzJoEHnhyZSbPwAZ
         mSsz4GpBx20cdYqKrs5WoZn2ZtLvtc9M0CnlgIcvoVcxz9q1cRMZGucn4B8bjjaGpCl1
         E6ixYfQfPrXX2FT8YKrvzE5TwSEuNoXNU0zSkE4cAKu2yJfGFhzGc7bYFgmJ93wYEyjv
         BdoeXns3puLazFBRiLe24+o7SJpThwWkXoRihACe4JdId9OBVRwThIoeyr4K2UUEQgjT
         TxaEvLyFChd3GKxyB75W4x36OcPpTTkW3OwE2wiAm0GCgpbeKh/i5jOXdIoug4F3iSlK
         LULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680004551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RDSxhLBnZBh5cghIRz0nx4zak4on0GX/pcez2mBW0M=;
        b=dg5OOlpFTAjEovEcfyqM8h8L54l77/PEu0azd4Cw996vBGlB4uRDw8/quCjyu3zZaP
         5YkCKftOwIHESxKjEdWojVgPz7z/h8sqnHdBBizIFmS6jZUZSgLFNcSxdAu3Ss8f51OY
         eq3sEdN9qOBwpcXaElZxrqsOJCQxJQpz0yVSnK5Uj9GEEBl7TgK+1AjDhHUKPE4Sx27t
         85PfY/e2CdNtEej+KlHo38UzUswX57FROATfvQDBlFDhVnqdBtWeUKzJYKLdpD2mZg8j
         h2Z9MOjUZ+OqTS4otyj1wV3+aTzqBTxZIj8SJeGTNsNssHfyZykGaPNZLVCi8gNgLXre
         Wn1Q==
X-Gm-Message-State: AAQBX9duFaV+69Fy6RG3vkVZbm+O5AIYiJIKVHnu0RDMJP5/UlOEWueC
        4I9MehB5sHChM5wKQl2YLnh46apShkNq7RYBDW3pcg==
X-Google-Smtp-Source: AKy350bpMF0iG9vvFnl6UfhgS9CZaqsCywXajuAsuWTFvpxABXm0eM8yTmha9tF1+A5JipBch1pj3eVw5kpyS6QjboI=
X-Received: by 2002:a25:add7:0:b0:871:fad3:b2ab with SMTP id
 d23-20020a25add7000000b00871fad3b2abmr13285046ybe.65.1680004551546; Tue, 28
 Mar 2023 04:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230328095807.7014-1-songmuchun@bytedance.com> <20230328095807.7014-2-songmuchun@bytedance.com>
In-Reply-To: <20230328095807.7014-2-songmuchun@bytedance.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Mar 2023 13:55:14 +0200
Message-ID: <CANpmjNP+nLfMKLj-4L4wXBfQpO5N0Y6q_TEkxjM+Z0WXxPvVxg@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: kfence: simplify kfence pool initialization
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

On Tue, 28 Mar 2023 at 11:58, Muchun Song <songmuchun@bytedance.com> wrote:
>
> There are three similar loops to initialize kfence pool, we could merge
> all of them into one loop to simplify the code and make code more
> efficient.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kfence/core.c | 47 ++++++-----------------------------------------
>  1 file changed, 6 insertions(+), 41 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 7d01a2c76e80..de62a84d4830 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -539,35 +539,10 @@ static void rcu_guarded_free(struct rcu_head *h)
>  static unsigned long kfence_init_pool(void)
>  {
>         unsigned long addr = (unsigned long)__kfence_pool;
> -       struct page *pages;
>         int i;
>
>         if (!arch_kfence_init_pool())
>                 return addr;
> -
> -       pages = virt_to_page(__kfence_pool);
> -
> -       /*
> -        * Set up object pages: they must have PG_slab set, to avoid freeing
> -        * these as real pages.
> -        *
> -        * We also want to avoid inserting kfence_free() in the kfree()
> -        * fast-path in SLUB, and therefore need to ensure kfree() correctly
> -        * enters __slab_free() slow-path.
> -        */
> -       for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
> -               struct slab *slab = page_slab(nth_page(pages, i));
> -
> -               if (!i || (i % 2))
> -                       continue;
> -
> -               __folio_set_slab(slab_folio(slab));
> -#ifdef CONFIG_MEMCG
> -               slab->memcg_data = (unsigned long)&kfence_metadata[i / 2 - 1].objcg |
> -                                  MEMCG_DATA_OBJCGS;
> -#endif
> -       }
> -
>         /*
>          * Protect the first 2 pages. The first page is mostly unnecessary, and
>          * merely serves as an extended guard page. However, adding one
> @@ -581,8 +556,9 @@ static unsigned long kfence_init_pool(void)
>                 addr += PAGE_SIZE;
>         }
>
> -       for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
> +       for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++, addr += 2 * PAGE_SIZE) {
>                 struct kfence_metadata *meta = &kfence_metadata[i];
> +               struct slab *slab = page_slab(virt_to_page(addr));
>
>                 /* Initialize metadata. */
>                 INIT_LIST_HEAD(&meta->list);
> @@ -593,26 +569,15 @@ static unsigned long kfence_init_pool(void)
>
>                 /* Protect the right redzone. */
>                 if (unlikely(!kfence_protect(addr + PAGE_SIZE)))
> -                       goto reset_slab;
> -
> -               addr += 2 * PAGE_SIZE;
> -       }
> -
> -       return 0;
> -
> -reset_slab:
> -       for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
> -               struct slab *slab = page_slab(nth_page(pages, i));
> +                       return addr;
>
> -               if (!i || (i % 2))
> -                       continue;
> +               __folio_set_slab(slab_folio(slab));
>  #ifdef CONFIG_MEMCG
> -               slab->memcg_data = 0;
> +               slab->memcg_data = (unsigned long)&meta->objcg | MEMCG_DATA_OBJCGS;
>  #endif
> -               __folio_clear_slab(slab_folio(slab));
>         }
>
> -       return addr;
> +       return 0;
>  }
>
>  static bool __init kfence_init_pool_early(void)
> --
> 2.11.0
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A94A5BF9F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIUJAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiIUJAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:00:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4724F13F6C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:00:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dv25so11963653ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=C4VPMMY4HXw4Oekj8wk8jcgdOutzg+K1mTd8apbGcww=;
        b=RCziy0AjXqscuqvV5yiptKJgwG5cCQp6yTrfQi2XtYK/V/An1ZiHlfucaPYAglNhR/
         iQ8ZnrGiPebgr750t7qCXhBMhtl5HGJv+1JXmmeAE4qri6NDJuhHdSwIkQ/eaGzE0+ZX
         H/b+qIK1ebI5L+6n+tUbXuG/qGLPUbFNsDzZBKjY9gfjcTmusJ6tXFk/c7C1DU8uYa8A
         X7PuMZUui32qsu8OWRhRcMalPSnfjRNuGdLuZe5Tfwnu+1MYXkWX3pBhjaKcQSvq6e3F
         wcNMXJoBzCBA1qbrqAcjtVr/SFhI/VsDXZM2KJQclZGXGqPNLaFLcwI6dm015DrAdxaD
         LJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=C4VPMMY4HXw4Oekj8wk8jcgdOutzg+K1mTd8apbGcww=;
        b=Da9TcfLvk9Ybf5zJo/1AJwrnS+kvBdK692Qsad/aLxp9vPEhXZ7a9aJ71ZstT2iV8t
         qsAwMSsnZOhlO6XuR+Z+O4FngJpCL4kX/rR2dCfzlEciQhI14pOdPKhvDENAiOLJZwON
         qSDrtuwSxXv7+qD6B4h2pv0+ZwHR/9Nnzi2YEGfT/uBUhFdIgekp01+gnpgxX5ml/kU7
         Ld+ZPHdBMvvjJjLchmVdTxWQHba7bghNX/2el64wR041Ha00PmPdIeg8SjzP/ZaCSXDB
         Pes54f3u8Dm9YFsb28/iR/frCQa5voPjA7IM9aEiTYbmGejv0hjjKsZ44jf3J1S9ovux
         GQkw==
X-Gm-Message-State: ACrzQf2CGJgdYaNXgX83SFEqUDxjLZ4SIDMoVKIKsAhHSYGtuokCS+Y6
        rc5MHzOeR9BLEVnQ60oo/9RKtXsNuwNPMMYTEfE=
X-Google-Smtp-Source: AMsMyM6cwjcI/x6qSq+0ZRJAQqFKygt/4E7JIgAA3LMBWrQp4UhSCSz3AjiRlDEU1MclMyoig+ZVs3IC3mxcHByXYRc=
X-Received: by 2002:a17:907:7f8e:b0:780:ec2b:bcc5 with SMTP id
 qk14-20020a1709077f8e00b00780ec2bbcc5mr14450418ejc.192.1663750839653; Wed, 21
 Sep 2022 02:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220921074841.382615-1-rppt@kernel.org>
In-Reply-To: <20220921074841.382615-1-rppt@kernel.org>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 21 Sep 2022 21:00:28 +1200
Message-ID: <CAGsJ_4yMOC5M9rnfgv9TXWAm2aMDUVOdDYvNjzqzu_oj9DBn8Q@mail.gmail.com>
Subject: Re: [PATCH] arm64/mm: fold check for KFENCE into can_set_direct_map()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 8:26 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> KFENCE requires linear map to be mapped at page granularity, so that it
> is possible to protect/unprotect single pages, just like with
> rodata_full and DEBUG_PAGEALLOC.
>
> Instead of repating
>
>         can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE)
>
> make can_set_direct_map() handle the KFENCE case.
>
> This also prevents potential false positives in kernel_page_present()
> that may return true for non-present page if CONFIG_KFENCE is enabled.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm64/mm/mmu.c      | 8 ++------
>  arch/arm64/mm/pageattr.c | 8 +++++++-
>  2 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index e7ad44585f40..c5065abec55a 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -535,7 +535,7 @@ static void __init map_mem(pgd_t *pgdp)
>          */
>         BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end));
>
> -       if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
> +       if (can_set_direct_map())
>                 flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>
>         /*
> @@ -1547,11 +1547,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>
>         VM_BUG_ON(!mhp_range_allowed(start, size, true));
>
> -       /*
> -        * KFENCE requires linear map to be mapped at page granularity, so that
> -        * it is possible to protect/unprotect single pages in the KFENCE pool.
> -        */
> -       if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
> +       if (can_set_direct_map())
>                 flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>
>         __create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 64e985eaa52d..d107c3d434e2 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -21,7 +21,13 @@ bool rodata_full __ro_after_init = IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED
>
>  bool can_set_direct_map(void)
>  {
> -       return rodata_full || debug_pagealloc_enabled();
> +       /*
> +        * rodata_full, DEBUG_PAGEALLOC and KFENCE require linear map to be
> +        * mapped at page granularity, so that it is possible to
> +        * protect/unprotect single pages.
> +        */
> +       return rodata_full || debug_pagealloc_enabled() ||
> +               IS_ENABLED(CONFIG_KFENCE);

might be irrelevant, i wonder if rodata_full is too strict as
rodata_full is almost
always true since RODATA_FULL_DEFAULT_ENABLED is default true.


>  }
>
>  static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
> --
> 2.35.3
>

Thanks
Barry

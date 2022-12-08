Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565DD647858
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiLHV4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiLHV4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:56:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09336B988
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:56:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C0E30CE26F8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 21:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FEDC433D2;
        Thu,  8 Dec 2022 21:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670536590;
        bh=bFNu3vNOxRzISUHbhrcGwqprv78edRC0TLjOn0yrO78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jgg7917lyxodDm1WbIW+2Tx+zBacForxyiPmNzhfg6WQBEX9JAXM3Jn46tHhaTcAN
         C9rOtlO1PHDlbL1jjSAjp52xrx+axl9hp2KyZk4HoWiLFh3pQbYlo+A8aeDuKfc7o6
         mw6cxE6S5wGxkZmJmkPX7FUjSXHlxgZ1EOxoo6lqkbTsrzEyKrj/3dlenhdGtrT5VD
         FMeANQ2guYHBdQO2BTsXk0yr4wm47pskJ0vHDor432z2HK4mrJvHRSmropCawyGgyu
         z4ebrnz/2eDrxvNSHX93Q5702Hi/IW8Eyj2qBqwaimluETtvYXYYgNdKhT9yT33yel
         Yz/2RyOIlKVkQ==
From:   SeongJae Park <sj@kernel.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, damon@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        sj@kernel.org
Subject: Re: [PATCH v3 4/4] mm/swap: Convert deactivate_page() to folio_deactivate()
Date:   Thu,  8 Dec 2022 21:56:27 +0000
Message-Id: <20221208215627.116940-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208203503.20665-5-vishal.moola@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2022 12:35:03 -0800 "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:

> Deactivate_page() has already been converted to use folios, this change
> converts it to take in a folio argument instead of calling page_folio().
> It also renames the function folio_deactivate() to be more consistent
> with other folio functions.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  include/linux/swap.h |  2 +-
>  mm/damon/paddr.c     |  2 +-
>  mm/madvise.c         |  4 ++--
>  mm/swap.c            | 14 ++++++--------
>  4 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index a18cf4b7c724..6427b3af30c3 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -409,7 +409,7 @@ extern void lru_add_drain(void);
>  extern void lru_add_drain_cpu(int cpu);
>  extern void lru_add_drain_cpu_zone(struct zone *zone);
>  extern void lru_add_drain_all(void);
> -extern void deactivate_page(struct page *page);
> +void folio_deactivate(struct folio *folio);
>  extern void mark_page_lazyfree(struct page *page);
>  extern void swap_setup(void);
>  
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 73548bc82297..6b36de1396a4 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -247,7 +247,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
>  		if (mark_accessed)
>  			folio_mark_accessed(folio);
>  		else
> -			deactivate_page(&folio->page);
> +			folio_deactivate(folio);
>  		folio_put(folio);
>  		applied += folio_nr_pages(folio);
>  	}
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 2a84b5dfbb4c..1ab293019862 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -396,7 +396,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  					list_add(&folio->lru, &folio_list);
>  			}
>  		} else
> -			deactivate_page(&folio->page);
> +			folio_deactivate(folio);
>  huge_unlock:
>  		spin_unlock(ptl);
>  		if (pageout)
> @@ -485,7 +485,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  					list_add(&folio->lru, &folio_list);
>  			}
>  		} else
> -			deactivate_page(&folio->page);
> +			folio_deactivate(folio);
>  	}
>  
>  	arch_leave_lazy_mmu_mode();
> diff --git a/mm/swap.c b/mm/swap.c
> index 955930f41d20..9cc8215acdbb 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -720,17 +720,15 @@ void deactivate_file_folio(struct folio *folio)
>  }
>  
>  /*
> - * deactivate_page - deactivate a page
> - * @page: page to deactivate
> + * folio_deactivate - deactivate a folio
> + * @folio: folio to deactivate
>   *
> - * deactivate_page() moves @page to the inactive list if @page was on the active
> - * list and was not an unevictable page.  This is done to accelerate the reclaim
> - * of @page.
> + * folio_deactivate() moves @folio to the inactive list if @folio was on the
> + * active list and was not unevictable. This is done to accelerate the
> + * reclaim of @folio.
>   */
> -void deactivate_page(struct page *page)
> +void folio_deactivate(struct folio *folio)
>  {
> -	struct folio *folio = page_folio(page);
> -
>  	if (folio_test_lru(folio) && !folio_test_unevictable(folio) &&
>  	    (folio_test_active(folio) || lru_gen_enabled())) {
>  		struct folio_batch *fbatch;
> -- 
> 2.38.1
> 

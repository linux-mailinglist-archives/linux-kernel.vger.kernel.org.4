Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169F764783D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLHVwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLHVwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:52:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8348B82F91
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:52:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FEA26208F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 21:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0661BC433EF;
        Thu,  8 Dec 2022 21:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670536323;
        bh=/G9rwfNNi1MXUfSnwUZ+XorKWRaIE52XaI7gJIzsvmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Erh52IW4k2ZEKHIjEznhcfh57Axz56QI/4fjinktS4BXRfWZG8inFM8bBJNZu5zj+
         qqO1FVq8RtGOpHJcudE4u9FJh4aNCjxiaL2RVMD70V4U9i86Og/yTIxaRDO1SfAoNV
         MMvgHpf1IrXf/82zQQVb798v0LwpOInszswFKJObyUEgVKOQgCqR9xkNylewhnXKCz
         aVycStGuOgOsRbNVz0daxFJdAkqSCN08jX9qwwZjwn5RJ2w41a4NXw061nkuKN8BaG
         TYEqCUfzP79BqS7L9NxfVBe0m6TTgdSpYB9T4fwULCtX4zjt4qJBGOK/m5uIK6GKGg
         7+wCNx5kPZXfg==
From:   SeongJae Park <sj@kernel.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, damon@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        sj@kernel.org
Subject: Re: [PATCH v3 3/4] mm/damon: Convert damon_pa_mark_accessed_or_deactivate() to use folios
Date:   Thu,  8 Dec 2022 21:52:01 +0000
Message-Id: <20221208215201.116835-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208203503.20665-4-vishal.moola@gmail.com>
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

On Thu, 8 Dec 2022 12:35:02 -0800 "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:

> This change replaces 2 calls to compound_head() with one.

I hoped this to be more detailed (e.g., 2 calls from mark_page_accessed() and
put_page() with 1 call from page_folio()), but it wouldn't be a blocker as we
had the discussion in v1 of this patch.

> This is in preparation for the conversion of deactivate_page() to
> folio_deactivate().
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

Please note that this conflicts with one of my patches that under review[1] at
the moment.  I will rebase and send the patch again if Andrew merge this first.

[1] https://lore.kernel.org/damon/20221205230830.144349-3-sj@kernel.org/


Thanks,
SJ

> ---
>  mm/damon/paddr.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index e1a4315c4be6..73548bc82297 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -238,15 +238,18 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
>  
>  	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
>  		struct page *page = damon_get_page(PHYS_PFN(addr));
> +		struct folio *folio;
>  
>  		if (!page)
>  			continue;
> +		folio = page_folio(page);
> +
>  		if (mark_accessed)
> -			mark_page_accessed(page);
> +			folio_mark_accessed(folio);
>  		else
> -			deactivate_page(page);
> -		put_page(page);
> -		applied++;
> +			deactivate_page(&folio->page);
> +		folio_put(folio);
> +		applied += folio_nr_pages(folio);
>  	}
>  	return applied * PAGE_SIZE;
>  }
> -- 
> 2.38.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502FA70FDFC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbjEXSrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjEXSrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:47:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5383EFC
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D574D64025
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 18:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA8DC433D2;
        Wed, 24 May 2023 18:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684954064;
        bh=ktiLabnYKAG3KyFEF2Q6zpiOpHDgr/G8xrLKc5nzBjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDhgWVlhdFx2XOrl59CnlL8BCPXIMfC+H/ZrYgxlSTU/cxDxdzw6f8fj2mG+bCQi5
         ud56NFMt0XN6a6loUJdqBOFEB+YJH7VJ40kjA+diqLGn7k5idmQDjfU+3Esf2Ul7RK
         8nfAe0OIOMTzwV6i7qWZhzy25VOY7PAf8JT/yT2ClShfOX1lP9rc0jsbbAml6Ubvr1
         th8Ke5DyOsxggNYqIOKSJdso9ZfdAvIYFa5tk8miCeEEq/iTRcBmTdz3LD3tFNIT7n
         +o+82EPvJLH+Tn+8B0SJxMuCAlGGSFR0m8ie22YsLO0HSHvucH5AGvLqbsdSM+WMir
         9SzqIKKbARrHQ==
Date:   Wed, 24 May 2023 21:47:21 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        damon@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/5] mm: vmalloc must set pte via arch code
Message-ID: <20230524184721.GO4967@kernel.org>
References: <20230518110727.2106156-1-ryan.roberts@arm.com>
 <20230518110727.2106156-2-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518110727.2106156-2-ryan.roberts@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 12:07:23PM +0100, Ryan Roberts wrote:
> It is bad practice to directly set pte entries within a pte table.
> Instead all modifications must go through arch-provided helpers such as
> set_pte_at() to give the arch code visibility and allow it to check
> (and potentially modify) the operation.
> 
> Fixes: 3e9a9e256b1e ("mm: add a vmap_pfn function")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/vmalloc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 9683573f1225..48202ec5f79a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2899,10 +2899,16 @@ struct vmap_pfn_data {
>  static int vmap_pfn_apply(pte_t *pte, unsigned long addr, void *private)
>  {
>  	struct vmap_pfn_data *data = private;
> +	unsigned long pfn = data->pfns[data->idx];
> +	pte_t ptent;
>  
> -	if (WARN_ON_ONCE(pfn_valid(data->pfns[data->idx])))
> +	if (WARN_ON_ONCE(pfn_valid(pfn)))
>  		return -EINVAL;
> -	*pte = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
> +
> +	ptent = pte_mkspecial(pfn_pte(pfn, data->prot));
> +	set_pte_at(&init_mm, addr, pte, ptent);
> +
> +	data->idx++;
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F760742326
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjF2JWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjF2JW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:22:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519A62110
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:22:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC59D61507
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 09:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7567C433C0;
        Thu, 29 Jun 2023 09:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688030547;
        bh=jVDjd/o37C0Cf9dg1UYazLEIVGmHrxmK46BrCrEJGnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V1LU0vBLQZPC4lfeGTRRiEouRysmfdhRmJOivThq/993EaEn9G2Ixn/qNj81p9nLP
         6INwZbKehtC/RsTro9VdpsNrD969Ych9fd0ohvd1u9B8/7riYcKawxPT2gQxD5ltpq
         OBLY06MeA9mh0r8t8DLfqGIAgPpRsq4rnuokfDJKx+y10phlM+ktLuGD0JFNN/holy
         CES61AwdK0QT+pQFye8aOgxoApb1iGgJOHHOoSbWozjr+eSCx3QuKWdCsqvYqgBVJO
         BoJxYwMCo1WFhoXb/LoYQxgePzJ4Ne7AUwlQZAc7++hRCky+Kke82pNwrGUdK6Er8r
         Hiqu2IwBG5iEA==
Date:   Thu, 29 Jun 2023 12:21:32 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Liam Ni <zhiguangni01@gmail.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V2] x86,NUMA:improve the execution efficiency of
 numa_meminfo_cover_memory()
Message-ID: <20230629092132.GP52412@kernel.org>
References: <20230619075315.49114-1-zhiguangni01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619075315.49114-1-zhiguangni01@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 03:53:15PM +0800, Liam Ni wrote:
> The number of pages in memblock that doesn't have the node
> assigned,which also means that these pages are not in numa_info.
> So these pages can represent the number of lose pages.
> 
> Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
> ---
>  arch/x86/mm/numa.c | 25 ++++++-------------------
>  include/linux/mm.h |  2 ++
>  mm/mm_init.c       | 26 ++++++++++++++++++++++++++
>  3 files changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 2aadb2019b4f..ffe3b771eac7 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -451,28 +451,15 @@ EXPORT_SYMBOL(__node_distance);
>   * Sanity check to catch more bad NUMA configurations (they are amazingly
>   * common).  Make sure the nodes cover all memory.
>   */
> -static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
> +static bool __init numa_meminfo_cover_memory(void)
>  {
> -	u64 numaram, e820ram;
> -	int i;
> -
> -	numaram = 0;
> -	for (i = 0; i < mi->nr_blks; i++) {
> -		u64 s = mi->blk[i].start >> PAGE_SHIFT;
> -		u64 e = mi->blk[i].end >> PAGE_SHIFT;
> -		numaram += e - s;
> -		numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
> -		if ((s64)numaram < 0)
> -			numaram = 0;
> -	}
> +	u64 lo_pages;
>  
> -	e820ram = max_pfn - absent_pages_in_range(0, max_pfn);
> +	lo_pages = without_node_pages_in_range(0, max_pfn);

The entire validation of NUMA coverage can be done in memblock, it's enough
to pass the threshold to that function and it can verify that amount or
memory without the node id set is less than that threshold.
Then the call to numa_meminfo_cover_memory() can be replaced with, say,
memblock_validate_numa_coverage(SZ_1M).

This applies not only to x86, but to loongarch as well.

And once architecture specific code does not use *absent_pages_in_range(),
that can be made static in mm/mm_init.c

>  
>  	/* We seem to lose 3 pages somewhere. Allow 1M of slack. */
> -	if ((s64)(e820ram - numaram) >= (1 << (20 - PAGE_SHIFT))) {
> -		printk(KERN_ERR "NUMA: nodes only cover %LuMB of your %LuMB e820 RAM. Not used.\n",
> -		       (numaram << PAGE_SHIFT) >> 20,
> -		       (e820ram << PAGE_SHIFT) >> 20);
> +	if (lo_pages >= (1 << (20 - PAGE_SHIFT))) {
> +		printk(KERN_ERR "NUMA: we lose more than 1M pages\n");
>  		return false;
>  	}
>  	return true;
> @@ -583,7 +570,7 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
>  			return -EINVAL;
>  		}
>  	}
> -	if (!numa_meminfo_cover_memory(mi))
> +	if (!numa_meminfo_cover_memory())
>  		return -EINVAL;
>  
>  	/* Finally register nodes. */
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 3ddd18a89b66..1d5085a8f93b 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1132,6 +1132,32 @@ static void __init adjust_zone_range_for_zone_movable(int nid,
>  	}
>  }
>  
> +/**
> + * @start_pfn: The start PFN to start searching for holes
> + * @end_pfn: The end PFN to stop searching for holes
> + *
> + * Return: Return the number of page frames without node assigned within a range.
> + */
> +unsigned long __init without_node_pages_in_range(unsigned long start_pfn,
> +						unsigned long end_pfn)
> +{
> +	struct memblock_type *type = &memblock.memory;
> +	struct memblock_region *r;
> +	unsigned long num_pages;
> +	int i, nid;
> +
> +	for (i = 0; i < type->cnt; i++) {

Please use for_each_mem_pfn_range() or for_each_mem_region() loop here.

> +		r = &type->regions[i];
> +		nid = memblock_get_region_node(r);
> +
> +		if (PFN_UP(r->base) >= PFN_DOWN(r->base + r->size))
> +			continue;
> +		if (nid == NUMA_NO_NODE)
> +			num_pages += PFN_DOWN(r->base + r->size) - PFN_UP(r->base);
> +	}
> +	return num_pages;
> +}
> +
>  /*
>   * Return the number of holes in a range on a node. If nid is MAX_NUMNODES,
>   * then all holes in the requested range will be accounted for.
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.

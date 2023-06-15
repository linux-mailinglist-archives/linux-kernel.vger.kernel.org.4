Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2F7731E98
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjFORBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjFORBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:01:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896812959
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:00:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D681463599
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 17:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B314C433C0;
        Thu, 15 Jun 2023 17:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686848447;
        bh=Kt68JHUeOhDerRP2RZ9sTpahMgEkSX3vVTlKMeVTh1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GxF42cMfY0HUChiikg+RCCMhCwu89z0N6EI24JViOFkR6o1sIQbEWNPZY6hPif1LU
         J4luxsIOIWxZxRUKTLiWd7tl97uTnrx7MJIUg3z6Jrv2nrRw+RiNBat4Jz4CQkF+PQ
         ape9wq+MqDUgaS+RRZCOuNgT5fFweisge6aj1Ns7juQuJqXGw3zQzMkjKtPixIuByd
         1ZvrXvyOYtdEr90PYIfsqnOeWpESJmFsD6ggDBlqUaJ9UTy6G52H9snDi+jmtjlzhV
         D8htqpJUdjHceYxo62CR31ahp3aWky4fA43i6TZGzYfGxso70nhWfno7rihwDUAe0a
         HXxH63gXK/+gQ==
Date:   Thu, 15 Jun 2023 20:00:11 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Liam Ni <zhiguangni01@gmail.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        akpm@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] x86,NUMA:Get the number of ram pages directly in
 numa_meminfo_cover_memory()
Message-ID: <20230615170011.GK52412@kernel.org>
References: <20230615142016.419570-1-zhiguangni01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615142016.419570-1-zhiguangni01@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 16, 2023 at 12:20:16AM +1000, Liam Ni wrote:
> In a previous implementation,The ram page is calculated
> by counting the number of holes,
> however,the number of ram pages is calculated during hole calculation.
> Therefore,we can directly calculate the amount of ram pages.
> 
> Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
> ---
>  arch/x86/mm/numa.c |  4 ++--
>  include/linux/mm.h |  4 ++++
>  mm/mm_init.c       | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 2aadb2019b4f..8ea0e956e3d7 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -461,12 +461,12 @@ static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
>  		u64 s = mi->blk[i].start >> PAGE_SHIFT;
>  		u64 e = mi->blk[i].end >> PAGE_SHIFT;
>  		numaram += e - s;
> -		numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
> +		numaram += __available_pages_in_range(mi->blk[i].nid, s, e);

This is wrong. You add number of pages in range core MM sees to the number
of pages covered by the numa_meminfo.

More generally, rather than traverse all the numa_meminfo's and for each of
them traverse all the regions in memblock.memory it's enough to count
memory in memblock that doesn't have the node assigned and compare it to
memblock_phys_mem_size().

>  		if ((s64)numaram < 0)
>  			numaram = 0;
>  	}
>  
> -	e820ram = max_pfn - absent_pages_in_range(0, max_pfn);
> +	e820ram = available_pages_in_range(0, max_pfn);
>  
>  	/* We seem to lose 3 pages somewhere. Allow 1M of slack. */
>  	if ((s64)(e820ram - numaram) >= (1 << (20 - PAGE_SHIFT))) {
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0daef3f2f029..f7f8c3476d1e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3041,8 +3041,12 @@ void free_area_init(unsigned long *max_zone_pfn);
>  unsigned long node_map_pfn_alignment(void);
>  unsigned long __absent_pages_in_range(int nid, unsigned long start_pfn,
>  						unsigned long end_pfn);
> +unsigned long __available_pages_in_range(int nid, unsigned long start_pfn,
> +						unsigned long end_pfn);
>  extern unsigned long absent_pages_in_range(unsigned long start_pfn,
>  						unsigned long end_pfn);
> +extern unsigned long available_pages_in_range(unsigned long start_pfn,
> +						unsigned long end_pfn);
>  extern void get_pfn_range_for_nid(unsigned int nid,
>  			unsigned long *start_pfn, unsigned long *end_pfn);
>  
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 3ddd18a89b66..33451afbc040 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1165,6 +1165,39 @@ unsigned long __init absent_pages_in_range(unsigned long start_pfn,
>  	return __absent_pages_in_range(MAX_NUMNODES, start_pfn, end_pfn);
>  }
>  
> +/*
> + * Return the number of avalible pages in a range on a node. If nid is MAX_NUMNODES,
> + * then all avalible pages in the requested range will be accounted for.
> + */
> +unsigned long __init __available_pages_in_range(int nid,
> +				unsigned long range_start_pfn,
> +				unsigned long range_end_pfn)
> +{
> +	unsigned long nr_avalible;
> +	unsigned long start_pfn, end_pfn;
> +	int i;
> +
> +	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> +		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
> +		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
> +		nr_avalible += end_pfn - start_pfn;
> +	}
> +	return nr_avalible;
> +}
> +
> +/**
> + * available_pages_in_range - Return the number of available page frames within a range
> + * @start_pfn: The start PFN to start searching for holes
> + * @end_pfn: The end PFN to stop searching for holes
> + *
> + * Return: the number of available pages frames within a range.
> + */
> +unsigned long __init available_pages_in_range(unsigned long start_pfn,
> +							unsigned long end_pfn)
> +{
> +	return __available_pages_in_range(MAX_NUMNODES, start_pfn, end_pfn);
> +}
> +
>  /* Return the number of page frames in holes in a zone on a node */
>  static unsigned long __init zone_absent_pages_in_node(int nid,
>  					unsigned long zone_type,
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.

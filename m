Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ECF67396F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjASNG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjASNF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:05:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCB6521C3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:04:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5209E61183
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B790C433F0;
        Thu, 19 Jan 2023 13:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674133497;
        bh=zviOFyfevw+hoK5UnH3O85aVKCM479kmlJkkL5nCyR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=urzKR+0UZ7gVDXdL14hB7vWE6Ggp+20+f0u1wy7CObyWRyhDoydEv6i96o14OKwtY
         3TaJiuco1X3O/jLrRP8suGd33FCp4eNt3TtIOkE7QV59HPC1rS6kXh/exNwOHA1PWC
         GSce4S4hDim28G7qglyDJRFDb1BD1d/dlK8N0ab7GzMP0YPqtfVuEyUTz+dGSRnE5i
         KTldWtiGlgDikxAmbSRoYlwr/+swX3gi0satCer4JoyhG/EVYITrYd6klviiX59iZL
         fSualy8+je3AIMqXDRDRDQLB/8WT6pJA5lIKe+qzqH0LSnVyKgBUwlFRquONanpMz5
         KDGv3V7YfXCmw==
Date:   Thu, 19 Jan 2023 15:04:46 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] memblock: Avoid useless checks in
 memblock_merge_regions().
Message-ID: <Y8k/7snAXgnHrspr@kernel.org>
References: <20230113082659.65276-1-zhangpeng.00@bytedance.com>
 <20230113082659.65276-4-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113082659.65276-4-zhangpeng.00@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 04:26:59PM +0800, Peng Zhang wrote:
> memblock_merge_regions() is called after regions have been modified to
> merge the neighboring compatible regions. That will check all regions
> but most checks is useless.
> 
> Most of the time we only insert one or a few new regions, or modify one
> or a few regions. At this time, we don't need to check all regions. We
> only need to check the changed regions, because other not related
> regions cannot be merged. So this patch add two parameters to
> memblock_merge_regions() to indicate the lower and upper boundary to scan.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  mm/memblock.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index cb92770ac22e..e19eb08efc73 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -523,15 +523,18 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
>  /**
>   * memblock_merge_regions - merge neighboring compatible regions
>   * @type: memblock type to scan
> - *
> - * Scan @type and merge neighboring compatible regions.
> + * @start_rgn: start scanning from (@start_rgn - 1)
> + * @end_rgn: end scanning at (@end_rgn - 1)
> + * Scan @type and merge neighboring compatible regions in [@start_rgn - 1, @end_rgn)
>   */
> -static void __init_memblock memblock_merge_regions(struct memblock_type *type)
> +static void __init_memblock memblock_merge_regions(struct memblock_type *type,
> +						   int start_rgn,
> +						   int end_rgn)

Make start_rgn and end_rgn unsigned longs and ...

>  {
> -	int i = 0;
> +	int i = max(start_rgn - 1, 0);
  
... open code max() as 

	if (start_rgn)
		i = start_rgn;

> -	/* cnt never goes below 1 */
> -	while (i < type->cnt - 1) {
> +	end_rgn = min(end_rgn, (int)type->cnt - 1);

... and drop the casting here.

> +	while (i < end_rgn) {
>  		struct memblock_region *this = &type->regions[i];
>  		struct memblock_region *next = &type->regions[i + 1];
>  
> @@ -548,6 +551,7 @@ static void __init_memblock memblock_merge_regions(struct memblock_type *type)
>  		/* move forward from next + 1, index of which is i + 2 */
>  		memmove(next, next + 1, (type->cnt - (i + 2)) * sizeof(*next));
>  		type->cnt--;
> +		end_rgn--;
>  	}
>  }
>  
> @@ -604,7 +608,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  	bool insert = false;
>  	phys_addr_t obase = base;
>  	phys_addr_t end = base + memblock_cap_size(base, &size);
> -	int idx, start_idx, nr_new;
> +	int idx, start_idx, nr_new, start_rgn = -1, end_rgn;
>  	struct memblock_region *rgn;
>  
>  	if (!size)
> @@ -659,10 +663,14 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  #endif
>  			WARN_ON(flags != rgn->flags);
>  			nr_new++;
> -			if (insert)
> +			if (insert) {
> +				if (start_rgn == -1)

you can initialize start_rgn with 0 and use if(!start_rgn) here.

> +					start_rgn = idx;
> +				end_rgn = idx + 1;
>  				memblock_insert_region(type, idx++, base,
>  						       rbase - base, nid,
>  						       flags);
> +			}
>  		}
>  		/* area below @rend is dealt with, forget about it */
>  		base = min(rend, end);
> @@ -671,9 +679,13 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  	/* insert the remaining portion */
>  	if (base < end) {
>  		nr_new++;
> -		if (insert)
> +		if (insert) {
> +			if (start_rgn == -1)

Ditto.

> +				start_rgn = idx;
> +			end_rgn = idx + 1;
>  			memblock_insert_region(type, idx, base, end - base,
>  					       nid, flags);
> +		}
>  	}
>  
>  	if (!nr_new)
> @@ -690,7 +702,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  		insert = true;
>  		goto repeat;
>  	} else {
> -		memblock_merge_regions(type);
> +		memblock_merge_regions(type, start_rgn, end_rgn);
>  		return 0;
>  	}
>  }
> @@ -927,7 +939,7 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
>  			r->flags &= ~flag;
>  	}
>  
> -	memblock_merge_regions(type);
> +	memblock_merge_regions(type, start_rgn, end_rgn);
>  	return 0;
>  }
>  
> @@ -1300,7 +1312,7 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
>  	for (i = start_rgn; i < end_rgn; i++)
>  		memblock_set_region_node(&type->regions[i], nid);
>  
> -	memblock_merge_regions(type);
> +	memblock_merge_regions(type, start_rgn, end_rgn);
>  #endif
>  	return 0;
>  }
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

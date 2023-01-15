Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48B066B15D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 15:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjAOOCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 09:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjAOOCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 09:02:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE85113D9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:02:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D39EB80B44
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 14:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8111C433D2;
        Sun, 15 Jan 2023 14:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673791365;
        bh=Iz7nC6DDEeDN9U0y1HI37zzfchxJz+j/YXBBMI+uEng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9UU0i3Z9VC1fchiKPWZ4R2wyM/Mq9yTMKMwkmW04WRnyeRBukQcnBZCuMMgd0b6i
         zhwPUtDBE3iL98MqBIoMkna3SL5pGPodjkablrc5hbqe6Nvq4ZzXE00yUnBzumLQrs
         rk4s2Myu/Q1bSUzwx0YhlsgIsDUtqYfoYFlYqJ3oQLht1vBHAgwp0XkO4753kVW5Ul
         5MqNhAQruZreXZQ1pgfx1eMVFVMezP7V0tYemst7R5eKTks2pNHM2/xaSEfvtzAlig
         Z2OyIvV14ep5BQ8Eq83eJBEAA2fj3czPeyfWQHyuvp12xxZ8IK3qUmRnRSUn47jSdu
         ymKCKyS2T1BDQ==
Date:   Sun, 15 Jan 2023 16:02:34 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] memblock: Make finding index faster when modify
 regions.
Message-ID: <Y8QHehG1L+kuyqoR@kernel.org>
References: <20230113082659.65276-1-zhangpeng.00@bytedance.com>
 <20230113082659.65276-3-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113082659.65276-3-zhangpeng.00@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 13, 2023 at 04:26:58PM +0800, Peng Zhang wrote:
> We can use binary search to find the index to modify regions in
> memblock_add_range() and memblock_isolate_range(). Because the
> arrangement of regions is ordered. It may be faster when there are
> many regions. So implemented a binary search and a new macro to walk
> regions.

Did you see a measurable speedup with this optimization?
I'm not in favor of micro-optimizations that complicate code.

> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  mm/memblock.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 6eedcfc5dcc1..cb92770ac22e 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -149,6 +149,11 @@ static __refdata struct memblock_type *memblock_memory = &memblock.memory;
>  	     i < memblock_type->cnt;					\
>  	     i++, rgn = &memblock_type->regions[i])
>  
> +#define for_each_memblock_type_start(i, start, memblock_type, rgn)	\
> +	for (i = start, rgn = &memblock_type->regions[i];		\
> +	     i < memblock_type->cnt;					\
> +	     i++, rgn = &memblock_type->regions[i])
> +
>  #define memblock_dbg(fmt, ...)						\
>  	do {								\
>  		if (memblock_debug)					\
> @@ -181,6 +186,24 @@ static unsigned long __init_memblock memblock_addrs_overlap(phys_addr_t base1, p
>  	return ((base1 < (base2 + size2)) && (base2 < (base1 + size1)));
>  }
>  
> +/*
> + * Binary search for the first region not to the left of @base.
> + */
> +static unsigned long __init_memblock memblock_lower_bound_region(struct memblock_type *type,
> +								 phys_addr_t base)
> +{
> +	unsigned long idx, low_idx = 0, high_idx = type->cnt;
> +
> +	while (low_idx < high_idx) {
> +		idx = (low_idx + high_idx) >> 1;
> +		if (type->regions[idx].base + type->regions[idx].size <= base)
> +			low_idx = idx + 1;
> +		else
> +			high_idx = idx;
> +	}
> +	return low_idx;
> +}
> +
>  bool __init_memblock memblock_overlaps_region(struct memblock_type *type,
>  					phys_addr_t base, phys_addr_t size)
>  {
> @@ -581,7 +604,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  	bool insert = false;
>  	phys_addr_t obase = base;
>  	phys_addr_t end = base + memblock_cap_size(base, &size);
> -	int idx, nr_new;
> +	int idx, start_idx, nr_new;
>  	struct memblock_region *rgn;
>  
>  	if (!size)
> @@ -607,6 +630,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  	 */
>  	if (type->cnt * 2 + 1 <= type->max)
>  		insert = true;
> +	start_idx = memblock_lower_bound_region(type, base);
>  
>  repeat:
>  	/*
> @@ -617,7 +641,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>  	base = obase;
>  	nr_new = 0;
>  
> -	for_each_memblock_type(idx, type, rgn) {
> +	for_each_memblock_type_start(idx, start_idx, type, rgn) {
>  		phys_addr_t rbase = rgn->base;
>  		phys_addr_t rend = rbase + rgn->size;
>  
> @@ -737,7 +761,7 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>  					int *start_rgn, int *end_rgn)
>  {
>  	phys_addr_t end = base + memblock_cap_size(base, &size);
> -	int idx;
> +	int idx, start_idx;
>  	struct memblock_region *rgn;
>  
>  	*start_rgn = *end_rgn = 0;
> @@ -750,7 +774,8 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>  		if (memblock_double_array(type, base, size) < 0)
>  			return -ENOMEM;
>  
> -	for_each_memblock_type(idx, type, rgn) {
> +	start_idx = memblock_lower_bound_region(type, base);
> +	for_each_memblock_type_start(idx, start_idx, type, rgn) {
>  		phys_addr_t rbase = rgn->base;
>  		phys_addr_t rend = rbase + rgn->size;
>  
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

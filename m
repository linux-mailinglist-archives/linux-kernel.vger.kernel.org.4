Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1555F733F53
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346220AbjFQH51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjFQH5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:57:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A3826B1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52C4860EA5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 07:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49539C433C0;
        Sat, 17 Jun 2023 07:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686988643;
        bh=71Ax7u5SuPLYDI/74tz6rUT0RgQ36kct5YVfGA7hK9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O9/Ij6xqWi72oU5ofv6YGVb2Mkb4cDcxY2tckzBOecNlSrpX+kwAqqJ9mrJHnp/G3
         6yvXW/Bng+3I069LbafOMSgciTT9Dgl/BlQcr1HSZ5ZUGirmPi8A7pXmzd3Lqm5/mG
         jqwszGQAfe38Qy8us1TEGH11ZakOOI+/dgbKSTTM8oS5XBpmdceUbABH6ngWSJv0yg
         LR6rh5MAhP81D3JhgifZAcq3fthsFyCwOO28OHEOsXXWrLfUGWK6X4DxyLYXo15vwo
         3CtgKQKnpy7/juS5krh3D2N0xYhw0AVXdU+p12jxOY7kReYCvhIAAkMTq38u6pQUN+
         ann7Ze+tUSgTQ==
Date:   Sat, 17 Jun 2023 10:56:44 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mm_init.c: remove obsolete macro HASH_SMALL
Message-ID: <20230617075644.GV52412@kernel.org>
References: <20230617070955.1751393-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617070955.1751393-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 03:09:55PM +0800, Miaohe Lin wrote:
> HASH_SMALL only works when parameter numentries is 0. But the sole caller
> futex_init() never calls alloc_large_system_hash() with numentries set to
> 0. 

Doesn't it? 
What happens when CONFIG_BASE_SMALL is set?

> So HASH_SMALL is obsolete and remove it.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/memblock.h |  2 --
>  kernel/futex/core.c      |  3 +--
>  mm/mm_init.c             | 10 +---------
>  3 files changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index f71ff9f0ec81..346d80809517 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -581,8 +581,6 @@ extern void *alloc_large_system_hash(const char *tablename,
>  				     unsigned long high_limit);
>  
>  #define HASH_EARLY	0x00000001	/* Allocating during early boot? */
> -#define HASH_SMALL	0x00000002	/* sub-page allocation allowed, min
> -					 * shift passed via *_hash_shift */
>  #define HASH_ZERO	0x00000004	/* Zero allocated hash table */
>  
>  /* Only NUMA needs hash distribution. 64bit NUMA architectures have
> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> index 514e4582b863..f10587d1d481 100644
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -1132,8 +1132,7 @@ static int __init futex_init(void)
>  #endif
>  
>  	futex_queues = alloc_large_system_hash("futex", sizeof(*futex_queues),
> -					       futex_hashsize, 0,
> -					       futex_hashsize < 256 ? HASH_SMALL : 0,
> +					       futex_hashsize, 0, 0,
>  					       &futex_shift, NULL,
>  					       futex_hashsize, futex_hashsize);
>  	futex_hashsize = 1UL << futex_shift;
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index d393631599a7..fab3c4649d5b 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2492,15 +2492,7 @@ void *__init alloc_large_system_hash(const char *tablename,
>  		else
>  			numentries <<= (PAGE_SHIFT - scale);
>  
> -		/* Make sure we've got at least a 0-order allocation.. */
> -		if (unlikely(flags & HASH_SMALL)) {
> -			/* Makes no sense without HASH_EARLY */
> -			WARN_ON(!(flags & HASH_EARLY));
> -			if (!(numentries >> *_hash_shift)) {
> -				numentries = 1UL << *_hash_shift;
> -				BUG_ON(!numentries);
> -			}
> -		} else if (unlikely((numentries * bucketsize) < PAGE_SIZE))
> +		if (unlikely((numentries * bucketsize) < PAGE_SIZE))
>  			numentries = PAGE_SIZE / bucketsize;
>  	}
>  	numentries = roundup_pow_of_two(numentries);
> -- 
> 2.27.0
> 

-- 
Sincerely yours,
Mike.

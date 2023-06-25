Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09DF73CE82
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 07:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjFYFHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 01:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjFYFHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 01:07:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E711CE6A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 22:07:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7713F60AC9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 05:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B072C433C8;
        Sun, 25 Jun 2023 05:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687669658;
        bh=QEGMK/nIcCRSIZuUkcNFbpZd5QkBuBV+sNTfdoKNEUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=raXchhf8oVL81o1TKe8oiBYbY7VS7jNDUfcIcHgQgselP+9I04CMumcuwkF2say2S
         suRkDee/YTY7etHCOYQ11wXgPX0a0ihZmUEw0LfULehDs7AOSo0lGuSL3eiqxtm7+v
         bG02q4dBnz9wHQmyzu0bzhpU7Z4A6t5g2r2OMOlRzEEWiBgmFZ4WNwQXWBMG8LOOQi
         KlntaGTxysrU4yFw9tOJWwd4XZYXpLcXazgBfW+8KMWaFeip3kdzadda2TZMW058rj
         OjwTjxLyMMFseXqvvQH9VVO0w1mnvc1ObB1Nzc5FcvX2ukmfFxVGivqcmfIeYNlsWb
         lBupJCEM6BNJA==
Date:   Sun, 25 Jun 2023 08:06:51 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/mm_init.c: remove obsolete macro HASH_SMALL
Message-ID: <20230625050651.GI52412@kernel.org>
References: <20230625021323.849147-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625021323.849147-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 10:13:23AM +0800, Miaohe Lin wrote:
> HASH_SMALL only works when parameter numentries is 0. But the sole caller
> futex_init() never calls alloc_large_system_hash() with numentries set to
> 0. So HASH_SMALL is obsolete and remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
> v2:
>   update HASH_ZERO to 0x2 per Mike
> ---
>  include/linux/memblock.h |  4 +---
>  kernel/futex/core.c      |  3 +--
>  mm/mm_init.c             | 10 +---------
>  3 files changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index f71ff9f0ec81..0d031fbfea25 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -581,9 +581,7 @@ extern void *alloc_large_system_hash(const char *tablename,
>  				     unsigned long high_limit);
>  
>  #define HASH_EARLY	0x00000001	/* Allocating during early boot? */
> -#define HASH_SMALL	0x00000002	/* sub-page allocation allowed, min
> -					 * shift passed via *_hash_shift */
> -#define HASH_ZERO	0x00000004	/* Zero allocated hash table */
> +#define HASH_ZERO	0x00000002	/* Zero allocated hash table */
>  
>  /* Only NUMA needs hash distribution. 64bit NUMA architectures have
>   * sufficient vmalloc space.
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
> index a1963c3322af..999723dee8cc 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2490,15 +2490,7 @@ void *__init alloc_large_system_hash(const char *tablename,
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

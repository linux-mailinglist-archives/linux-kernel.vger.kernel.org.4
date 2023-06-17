Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3F5734061
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 12:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbjFQKwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 06:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFQKwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 06:52:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F02CCD
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 03:52:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1EC260AE4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 10:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D959DC433C0;
        Sat, 17 Jun 2023 10:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686999136;
        bh=WiB5tt+dGicCP1dSR4iRdltEOzqRT8XN4J7t5k3g/Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7B4It7yaepq/T7zRX2xmX4h1hL1m/4+tS9nUaeaAxGMk+hqyYvsRMT7i9q4J6MuK
         ZayyYI+B7VqTIGQXVqqryhxtSaqOCDDnVJbYMFLXGJt7DWjS3Y4rk3FftC8f2S2W/Z
         R2oN0QwNFBYyoqIcovohJbG4OykTcgk820egxAPElplcBT58jcRBercnS5tvi6cDp4
         hUIlyDW66VVCGydIB2U78f9u88mRK7K+UiAVbbxe8zPHF8aoFy8zvgSRlYFE5roxjQ
         Hafko6JXt6PuJTeK5reH7UdAE78Du348x/nD6q3SqdJiQRnaiBeb5m+6xmjhLGoK6y
         C/4swd4WLnMqQ==
Date:   Sat, 17 Jun 2023 13:51:37 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mm_init.c: remove obsolete macro HASH_SMALL
Message-ID: <20230617105137.GX52412@kernel.org>
References: <20230617070955.1751393-1-linmiaohe@huawei.com>
 <20230617075644.GV52412@kernel.org>
 <6d149902-a944-7961-89c1-f07047953c7f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d149902-a944-7961-89c1-f07047953c7f@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 04:39:44PM +0800, Miaohe Lin wrote:
> On 2023/6/17 15:56, Mike Rapoport wrote:
> > On Sat, Jun 17, 2023 at 03:09:55PM +0800, Miaohe Lin wrote:
> >> HASH_SMALL only works when parameter numentries is 0. But the sole caller
> >> futex_init() never calls alloc_large_system_hash() with numentries set to
> >> 0. 
> > 
> 
> Thanks for your quick review.
> 
> > Doesn't it? 
> > What happens when CONFIG_BASE_SMALL is set?
> 
> When CONFIG_BASE_SMALL is set, futex_hashsize is set to 16 and alloc_large_system_hash() is called with
> numentries == 16 && flags == HASH_SMALL. But in the alloc_large_system_hash(), we have the below logic:
> 
> alloc_large_system_hash()
> {
>   if (!numentries) { /* numentries == 16 here, so this code block is skipped. */
>     ...
>     if (unlikely(flags & HASH_SMALL)) { /* So as here. */
>       ...
>   }
>   ...
> }
> 
> So HASH_SMALL is just unused. Or am I miss something?

You are right, I've missed that. 

> Thanks.
> 
> > 
> >> So HASH_SMALL is obsolete and remove it.
> > 
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  include/linux/memblock.h |  2 --
> >>  kernel/futex/core.c      |  3 +--
> >>  mm/mm_init.c             | 10 +---------
> >>  3 files changed, 2 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> >> index f71ff9f0ec81..346d80809517 100644
> >> --- a/include/linux/memblock.h
> >> +++ b/include/linux/memblock.h
> >> @@ -581,8 +581,6 @@ extern void *alloc_large_system_hash(const char *tablename,
> >>  				     unsigned long high_limit);
> >>  
> >>  #define HASH_EARLY	0x00000001	/* Allocating during early boot? */
> >> -#define HASH_SMALL	0x00000002	/* sub-page allocation allowed, min
> >> -					 * shift passed via *_hash_shift */
> >>  #define HASH_ZERO	0x00000004	/* Zero allocated hash table */

Can you update HASH_ZERO to 0x2?

> >>  
> >>  /* Only NUMA needs hash distribution. 64bit NUMA architectures have
> >> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> >> index 514e4582b863..f10587d1d481 100644
> >> --- a/kernel/futex/core.c
> >> +++ b/kernel/futex/core.c
> >> @@ -1132,8 +1132,7 @@ static int __init futex_init(void)
> >>  #endif
> >>  
> >>  	futex_queues = alloc_large_system_hash("futex", sizeof(*futex_queues),
> >> -					       futex_hashsize, 0,
> >> -					       futex_hashsize < 256 ? HASH_SMALL : 0,
> >> +					       futex_hashsize, 0, 0,
> >>  					       &futex_shift, NULL,
> >>  					       futex_hashsize, futex_hashsize);
> >>  	futex_hashsize = 1UL << futex_shift;
> >> diff --git a/mm/mm_init.c b/mm/mm_init.c
> >> index d393631599a7..fab3c4649d5b 100644
> >> --- a/mm/mm_init.c
> >> +++ b/mm/mm_init.c
> >> @@ -2492,15 +2492,7 @@ void *__init alloc_large_system_hash(const char *tablename,
> >>  		else
> >>  			numentries <<= (PAGE_SHIFT - scale);
> >>  
> >> -		/* Make sure we've got at least a 0-order allocation.. */
> >> -		if (unlikely(flags & HASH_SMALL)) {
> >> -			/* Makes no sense without HASH_EARLY */
> >> -			WARN_ON(!(flags & HASH_EARLY));
> >> -			if (!(numentries >> *_hash_shift)) {
> >> -				numentries = 1UL << *_hash_shift;
> >> -				BUG_ON(!numentries);
> >> -			}
> >> -		} else if (unlikely((numentries * bucketsize) < PAGE_SIZE))
> >> +		if (unlikely((numentries * bucketsize) < PAGE_SIZE))
> >>  			numentries = PAGE_SIZE / bucketsize;
> >>  	}
> >>  	numentries = roundup_pow_of_two(numentries);
> >> -- 
> >> 2.27.0
> >>
> > 
> 

-- 
Sincerely yours,
Mike.

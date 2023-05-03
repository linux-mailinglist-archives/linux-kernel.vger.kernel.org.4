Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DCF6F60B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 23:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjECV7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 17:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjECV7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 17:59:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA7C7A84
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 14:59:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DC4362D21
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 21:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F34C433EF;
        Wed,  3 May 2023 21:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683151173;
        bh=tjJqnJEPyEi7KhsaIkP4sflEqPlbtWhnDQ9Sf+EXXxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ddo3i+iTqycg9cgxQrWgYpu9HoFw1oXEuS+HbTlk7fYpyGWDoFM6WCaz5HJi89stj
         0rixswKfkvjUCa5TYAQeVLeZJ91yaNKqCtMO+IIuh3YI7z9Z3f5o5Nx/jbpzNSzE6Q
         G/eh8hIDqshYIoEpGoyJ4PXWgoB6XI7JAo0K63gt0NgjshNXTkhfXHSYSS9fSmESn4
         mEKxEQ6wAoNYI9oDBMoHzwS8DuBFdQtGM8U8K8NaA0RCQhEhvEyg0wcxDDLKT4gv0Z
         s+gUDzDJYZVTqHGlBsMi3npfysKRRWcYXkg37zaM+AxIOSum/2c2RZP/1kFARQOvPh
         omfwLNOeLm0Wg==
Date:   Wed, 3 May 2023 14:59:31 -0700
From:   Chris Li <chrisl@kernel.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        minchan@kernel.org, ngupta@vflare.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hannes@cmpxchg.org
Subject: Re: [PATCH v2] mm: fix zswap writeback race condition
Message-ID: <ZFLZQ/hJarV+iNYd@google.com>
References: <20230503151200.19707-1-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503151200.19707-1-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Domenico,

On Wed, May 03, 2023 at 05:12:00PM +0200, Domenico Cerasuolo wrote:
> 1. a page with data A and swap offset X is stored in zswap
> 2. page A is removed off the LRU by zpool driver for writeback in
> zswap-shrink work, data for A is mapped by zpool driver
> 3. user space program faults and invalidates page entry A, offset X is
> considered free
> 4. kswapd stores page B at offset X in zswap (zswap could also be full,
> if so, page B would then be IOed to X, then skip step 5.)
> 5. entry A is replaced by B in tree->rbroot, this doesn't affect the
> local reference held by zswap-shrink work
> 6. zswap-shrink work writes back A at X, and frees zswap entry A
> 7. swapin of slot X brings A in memory instead of B

Thanks for the interesting discovery.

> V2:
> - updated comment with better explaination of the situation being
> addressed in the check
> 
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/zswap.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f6c89049cf70..5d5977c9ea45 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -995,6 +995,22 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
>  		goto fail;
>  
>  	case ZSWAP_SWAPCACHE_NEW: /* page is locked */
> +		/*
> +		 * Having a local reference to the zswap entry doesn't exclude
> +		 * swapping from invalidating and recycling the swap slot. Once
> +		 * the swapcache is secured against concurrent swapping to and
> +		 * from the slot, recheck that the entry is still current before
> +		 * writing.
> +		 */
> +		spin_lock(&tree->lock);
> +		if (zswap_rb_search(&tree->rbroot, entry->offset) != entry) {
> +			spin_unlock(&tree->lock);
> +			delete_from_swap_cache(page_folio(page));
> +			ret = -ENOMEM;
> +			goto fail;
> +		}
> +		spin_unlock(&tree->lock);
> +

The race condition is still there, just making it much harder to hit.
What happens after you perform the rb tree search, release tree lock.
Then the entry gets invalid and recycled right here before the decompress
step?

>  		/* decompress */
>  		acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
>  		dlen = PAGE_SIZE;
>

Chris
 

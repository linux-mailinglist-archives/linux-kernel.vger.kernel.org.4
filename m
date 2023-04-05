Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B926D7CFF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbjDEMz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237975AbjDEMzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:55:23 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Apr 2023 05:55:21 PDT
Received: from outbound-smtp44.blacknight.com (outbound-smtp44.blacknight.com [46.22.136.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD9755B3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 05:55:21 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id EC4BBF850F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 13:45:20 +0100 (IST)
Received: (qmail 19508 invoked from network); 5 Apr 2023 12:45:20 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Apr 2023 12:45:20 -0000
Date:   Wed, 5 Apr 2023 13:45:19 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Alexander Halbuer <halbuer@sra.uni-hannover.de>
Subject: Re: [PATCH] mm, page_alloc: reduce page alloc/free sanity checks
Message-ID: <20230405124519.ir7y54aunmyg3tcn@techsingularity.net>
References: <20230216095131.17336-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230216095131.17336-1-vbabka@suse.cz>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 10:51:31AM +0100, Vlastimil Babka wrote:
> Historically, we have performed sanity checks on all struct pages being
> allocated or freed, making sure they have no unexpected page flags or
> certain field values. This can detect insufficient cleanup and some
> cases of use-after-free, although on its own it can't always identify
> the culprit. The result is a warning and the "bad page" being leaked.
> 
> The checks do need some cpu cycles, so in 4.7 with commits 479f854a207c
> ("mm, page_alloc: defer debugging checks of pages allocated from the
> PCP") and 4db7548ccbd9 ("mm, page_alloc: defer debugging checks of freed
> pages until a PCP drain") they were no longer performed in the hot paths
> when allocating and freeing from pcplists, but only when pcplists are
> bypassed, refilled or drained. For debugging purposes, with
> CONFIG_DEBUG_VM enabled the checks were instead still done in the
> hot paths and not when refilling or draining pcplists.
> 
> With 4462b32c9285 ("mm, page_alloc: more extensive free page checking
> with debug_pagealloc"), enabling debug_pagealloc also moved the sanity
> checks back to hot pahs. When both debug_pagealloc and CONFIG_DEBUG_VM
> are enabled, the checks are done both in hotpaths and pcplist
> refill/drain.
> 
> Even though the non-debug default today might seem to be a sensible
> tradeoff between overhead and ability to detect bad pages, on closer
> look it's arguably not. As most allocations go through the pcplists,
> catching any bad pages when refilling or draining pcplists has only a
> small chance, insufficient for debugging or serious hardening purposes.
> On the other hand the cost of the checks is concentrated in the already
> expensive drain/refill batching operations, and those are done under the
> often contended zone lock. That was recently identified as an issue for
> page allocation and the zone lock contention reduced by moving the
> checks outside of the locked section with a patch "mm: reduce lock
> contention of pcp buffer refill", but the cost of the checks is still
> visible compared to their removal [1]. In the pcplist draining path
> free_pcppages_bulk() the checks are still done under zone->lock.
> 
> Thus, remove the checks from pcplist refill and drain paths completely.
> Introduce a static key check_pages_enabled to control checks during page
> allocation a freeing (whether pcplist is used or bypassed). The static
> key is enabled if either is true:
> - kernel is built with CONFIG_DEBUG_VM=y (debugging)
> - debug_pagealloc or page poisoning is boot-time enabled (debugging)
> - init_on_alloc or init_on_free is boot-time enabled (hardening)
> 
> The resulting user visible changes:
> - no checks when draining/refilling pcplists - less overhead, with
>   likely no practical reduction of ability to catch bad pages
> - no checks when bypassing pcplists in default config (no
>   debugging/hardening) - less overhead etc. as above
> - on typical hardened kernels [2], checks are now performed on each page
>   allocation/free (previously only when bypassing/draining/refilling
>   pcplists) - the init_on_alloc/init_on_free enabled should be sufficient
>   indication for preferring more costly alloc/free operations for
>   hardening purposes and we shouldn't need to introduce another toggle
> - code (various wrappers) removal and simplification
> 
> [1] https://lore.kernel.org/all/68ba44d8-6899-c018-dcb3-36f3a96e6bea@sra.uni-hannover.de/
> [2] https://lore.kernel.org/all/63ebc499.a70a0220.9ac51.29ea@mx.google.com/
> 
> Reported-by: Alexander Halbuer <halbuer@sra.uni-hannover.de>
> Reported-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

Some minor comments below

> @@ -1432,9 +1448,11 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  		for (i = 1; i < (1 << order); i++) {
>  			if (compound)
>  				bad += free_tail_pages_check(page, page + i);

free_tail_pages_check is also a function that only does something useful
when CONFIG_DEBUG_VM is set. While it might be outside the scope of the
patch, it might also benefit from check_pages_enabled checks?

> -			if (unlikely(free_page_is_bad(page + i))) {
> -				bad++;
> -				continue;
> +			if (static_branch_unlikely(&check_pages_enabled)) {
> +				if (unlikely(free_page_is_bad(page + i))) {
> +					bad++;
> +					continue;
> +				}
>  			}
>  			(page + i)->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
>  		}

The unlikely() within a static_branch_unlikely probably adds very little
given the block is so tiny. 

> @@ -2392,56 +2369,20 @@ static inline int check_new_page(struct page *page)
>  	return 1;
>  }
>  
> -static bool check_new_pages(struct page *page, unsigned int order)
> +static inline bool check_new_pages(struct page *page, unsigned int order)
>  {
> -	int i;
> -	for (i = 0; i < (1 << order); i++) {
> -		struct page *p = page + i;
> +	if (static_branch_unlikely(&check_pages_enabled)) {
> +		for (int i = 0; i < (1 << order); i++) {
> +			struct page *p = page + i;
>  
> -		if (unlikely(check_new_page(p)))
> -			return true;
> +			if (unlikely(check_new_page(p)))
> +				return true;
> +		}
>  	}
>  

unlikely() within static_branch_unlikely probably adds very little.

Otherwise, looks good. I agree that with changes over time that the ability
of the checks to detect anything is reduced and it's probably at the point
where it can only detect a very specific bit corruption instead of broken
code. Commit 44042b449872 ("mm/page_alloc: allow high-order pages to be
stored on the per-cpu lists") also likely reduced the ability of the checks
to find anything.

-- 
Mel Gorman
SUSE Labs

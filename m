Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27769647604
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiLHTOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLHTOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:14:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCF328738
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0uwthzCinj77lhOFlJtbRaN2SPsCgH53sRB6S+9jybM=; b=VhWSQh5nAy1Tc/aDBJOzNFtxM7
        WjDctl7sLwr+V4OTuuhPg33yHaLQOsaUOPBS5dGnQ41UTiwG+xWYuxQojZdyr43uryNXElRdcFKj8
        FL7VaY5rrh212pZecIiMNbVDLUWcUR/r536hoGL0U4Ual66QG0uFewHDaNQCPDjNvmCrcmrR+xm/4
        qfeZd6yiCIcgW/3tSIwMuw2a8Cd6qfDE2fwEQtHRvy+OkXp48EkQaisLBSQjBZChzNITTgEBVUWb9
        9bYhqcwyYVcQ+SZX91AE5oBEd62G9wb3UEgOu1+15SsXr8U1OMhkZ8GuMCd7W8PAsEslKxzf+ydDV
        nCPEc1VQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p3MLl-007ElF-1s; Thu, 08 Dec 2022 19:14:29 +0000
Date:   Thu, 8 Dec 2022 19:14:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kairui Song <kasong@tencent.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 5/5] swap: avoid ra statistic lost when swapin races
Message-ID: <Y5I3lSfsTmZ6tlJk@casper.infradead.org>
References: <20221208180209.50845-1-ryncsn@gmail.com>
 <20221208180209.50845-6-ryncsn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208180209.50845-6-ryncsn@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 02:02:09AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> __read_swap_cache_async should just call swap_cache_get_folio for trying
> to look up the swap cache. Because swap_cache_get_folio handles the
> readahead statistic, and clears the RA flag, looking up the cache
> directly will skip these parts.
> 
> And the comment no longer applies after commit 442701e7058b
> ("mm/swap: remove swap_cache_info statistics"), just remove them.

But what about the readahead stats?

> Fixes: 442701e7058b ("mm/swap: remove swap_cache_info statistics")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap_state.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index eba388f67741..f39cfb62551d 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -418,15 +418,12 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  	for (;;) {
>  		int err;
>  		/*
> -		 * First check the swap cache.  Since this is normally
> -		 * called after swap_cache_get_folio() failed, re-calling
> -		 * that would confuse statistics.
> +		 * First check the swap cache in case of race.
>  		 */
>  		si = get_swap_device(entry);
>  		if (!si)
>  			return NULL;
> -		folio = filemap_get_folio(swap_address_space(entry),
> -						swp_offset(entry));
> +		folio = swap_cache_get_folio(entry, vma, addr);
>  		put_swap_device(si);
>  		if (folio)
>  			return folio_file_page(folio, swp_offset(entry));
> -- 
> 2.35.2
> 
> 

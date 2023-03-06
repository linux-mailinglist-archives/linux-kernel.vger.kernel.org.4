Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4966ACA7F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjCFRbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCFRbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:31:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A738A54
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:30:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B1FFC21C5B;
        Mon,  6 Mar 2023 17:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678123774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2wJ/1+qCv7YJhFivtXnn5Inza/T/kAvFe4cwUGE/7M=;
        b=jfDfCOyJy1ndJDHGQIejrU8vCh7aokmH29RLQCXz/jl890atMS2KY6sTEhqV4Yckagg0bq
        PS9XH+mp84EQV1Bp6Jfk2EvP76nXPDa1zWtkrWwQz5ZKRcXw7dsgPxJMA5YK4wY0jWU9F/
        r/1w2r76fhQQ5T0ziaQka6JoReF2wLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678123774;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2wJ/1+qCv7YJhFivtXnn5Inza/T/kAvFe4cwUGE/7M=;
        b=TuxUQJJJqSUaCGEdVCeXRRPvro8cH6NkICIu/rAz6JOQxhRwuqoXqM1Sw99mW9DAn31GN+
        tui4w0zlhUozh0AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8217213A66;
        Mon,  6 Mar 2023 17:29:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oVXAHv4iBmRScwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 06 Mar 2023 17:29:34 +0000
Message-ID: <6452176f-4c17-8e09-8561-c659cbea4014@suse.cz>
Date:   Mon, 6 Mar 2023 18:29:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm, vmalloc: fix high order __GFP_NOFAIL allocations
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>
References: <20230305053035.1911-1-hsiangkao@linux.alibaba.com>
 <ZAWbjIJCarmxGa8k@dhcp22.suse.cz> <ZAXZMz0n+CpWPVqy@pc636>
 <ZAXynvdNqcI0f6Us@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZAXynvdNqcI0f6Us@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 15:03, Michal Hocko wrote:

> --- 
> From 3ccfaa15bf2587b8998c129533a0404fedf5a484 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Mon, 6 Mar 2023 09:15:17 +0100
> Subject: [PATCH] mm, vmalloc: fix high order __GFP_NOFAIL allocations
> 
> Gao Xiang has reported that the page allocator complains about high
> order __GFP_NOFAIL request coming from the vmalloc core:
> 
>  __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5549
>  alloc_pages+0x1aa/0x270 mm/mempolicy.c:2286
>  vm_area_alloc_pages mm/vmalloc.c:2989 [inline]
>  __vmalloc_area_node mm/vmalloc.c:3057 [inline]
>  __vmalloc_node_range+0x978/0x13c0 mm/vmalloc.c:3227
>  kvmalloc_node+0x156/0x1a0 mm/util.c:606
>  kvmalloc include/linux/slab.h:737 [inline]
>  kvmalloc_array include/linux/slab.h:755 [inline]
>  kvcalloc include/linux/slab.h:760 [inline]
> 
> it seems that I have completely missed high order allocation backing
> vmalloc areas case when implementing __GFP_NOFAIL support. This means
> that [k]vmalloc at al. can allocate higher order allocations with
> __GFP_NOFAIL which can trigger OOM killer for non-costly orders easily
> or cause a lot of reclaim/compaction activity if those requests cannot
> be satisfied.
> 
> Fix the issue by falling back to zero order allocations for __GFP_NOFAIL
> requests if the high order request fails.
> 
> Fixes: 9376130c390a ("mm/vmalloc: add support for __GFP_NOFAIL")
> Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/vmalloc.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ef910bf349e1..bef6cf2b4d46 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2883,6 +2883,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  		unsigned int order, unsigned int nr_pages, struct page **pages)
>  {
>  	unsigned int nr_allocated = 0;
> +	gfp_t alloc_gfp = gfp;
> +	bool nofail = false;
>  	struct page *page;
>  	int i;
>  
> @@ -2893,6 +2895,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  	 * more permissive.
>  	 */
>  	if (!order) {
> +		/* bulk allocator doesn't support nofail req. officially */
>  		gfp_t bulk_gfp = gfp & ~__GFP_NOFAIL;
>  
>  		while (nr_allocated < nr_pages) {
> @@ -2931,20 +2934,35 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  			if (nr != nr_pages_request)
>  				break;
>  		}
> +	} else if (gfp & __GFP_NOFAIL) {
> +		/*
> +		 * Higher order nofail allocations are really expensive and
> +		 * potentially dangerous (pre-mature OOM, disruptive reclaim
> +		 * and compaction etc.

				      ^ unclosed parenthesis

> +		 */
> +		alloc_gfp &= ~__GFP_NOFAIL;
> +		nofail = true;
>  	}
>  
>  	/* High-order pages or fallback path if "bulk" fails. */
> -
>  	while (nr_allocated < nr_pages) {
>  		if (fatal_signal_pending(current))
>  			break;
>  
>  		if (nid == NUMA_NO_NODE)
> -			page = alloc_pages(gfp, order);
> +			page = alloc_pages(alloc_gfp, order);
>  		else
> -			page = alloc_pages_node(nid, gfp, order);
> -		if (unlikely(!page))
> -			break;
> +			page = alloc_pages_node(nid, alloc_gfp, order);
> +		if (unlikely(!page)) {
> +			if (!nofail)
> +				break;
> +
> +			/* fall back to the zero order allocations */
> +			alloc_gfp |= __GFP_NOFAIL;
> +			order = 0;
> +			continue;
> +		}
> +
>  		/*
>  		 * Higher order allocations must be able to be treated as
>  		 * indepdenent small pages by callers (as they can with

		   ^ while at it the typo could also be fixed

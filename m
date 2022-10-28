Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D053661102A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJ1L5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJ1L5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:57:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1871D2F53
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24CA6B829B5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A713C433C1;
        Fri, 28 Oct 2022 11:57:29 +0000 (UTC)
Date:   Fri, 28 Oct 2022 12:57:25 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com
Subject: Re: [RFC PATCH] mm: track bad page via kmemleak
Message-ID: <Y1vDpfGrG1biTGoC@arm.com>
References: <1663679468-16757-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663679468-16757-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry, I missed this last month when it was posted)

On Tue, Sep 20, 2022 at 09:11:08PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Bad pages will failed go back to allocator and leaved as orphan pages, track
> them down via kmemleak.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/page_alloc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e5486d4..24f682e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1408,7 +1408,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  			__memcg_kmem_uncharge_page(page, order);
>  		reset_page_owner(page, order);
>  		page_table_check_free(page, order);
> -		return false;
> +		goto err;
>  	}
>  
>  	/*
> @@ -1442,7 +1442,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  	if (check_free)
>  		bad += check_free_page(page);
>  	if (bad)
> -		return false;
> +		goto err;
>  
>  	page_cpupid_reset_last(page);
>  	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
> @@ -1486,6 +1486,10 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  	debug_pagealloc_unmap_pages(page, 1 << order);
>  
>  	return true;
> +err:
> +	kmemleak_alloc(page_address(page), PAGE_SIZE << order, 1, GFP_KERNEL);
> +	return false;
> +
>  }

What's the aim of this tracking? First of all, that's a HWPoison page
and it should note be touched, so the min_count should be -1 otherwise
kmemleak will try to read it for references to other objects.

Now, if all you need is a list of the bad pages, I don't think that's
kmemleak's job. Maybe add them to a list and expose it somewhere else
via debugfs.

-- 
Catalin

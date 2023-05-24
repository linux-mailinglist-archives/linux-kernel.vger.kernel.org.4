Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934A770FE5D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjEXTQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjEXTQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:16:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF01D12E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 12:16:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DC8661861
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 19:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C75C4339B;
        Wed, 24 May 2023 19:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684955769;
        bh=4mFWjvJ+t1kSPCQ+e4sFDTvSwcTu1Vk+zaiSOpA9zes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UdOk8ktRA7imVgBv39lMLCuKeq676Uwm7qBwKZ7BVB6XwTU6VH0cCnIbUJXw1O7C0
         qMjEPdaTmBUVaZPJT4+uvgpVe1pmq2x9vxEppccPJqxfWxEtDsdifumefUaVAS7U4Y
         v/2G2mQrg7oopC04Vv7E/CIr7GKzE8fDt0XRgnYvkXQW6cHqqVFQUBejKBVpWp6bZk
         ixcsF3T6Tii9Ij1GDKhTxRAI8E0QzrKx/f1Hs/seVqpSzjf3TInUP1sB8q+prHF0uq
         tG0Q4LpFewo7MKG9rPj8sLy/B/l40HPAGnpZvdMrdwNhSMVFaSrsaQBbccKcmJSEgM
         ph9WRDRgDvF8w==
Date:   Wed, 24 May 2023 22:15:49 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: page_isolation: write proper kerneldoc
Message-ID: <20230524191549.GS4967@kernel.org>
References: <20230519111652.40658-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519111652.40658-1-hannes@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 01:16:52PM +0200, Johannes Weiner wrote:
> And remove the incorrect header comments.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/page-isolation.h | 24 ++++++------------------
>  mm/page_isolation.c            | 29 ++++++++++++++++++++++++-----
>  2 files changed, 30 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
> index 5456b7be38ae..0ab089e89db4 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -37,24 +37,12 @@ void set_pageblock_migratetype(struct page *page, int migratetype);
>  int move_freepages_block(struct zone *zone, struct page *page,
>  				int migratetype, int *num_movable);
>  
> -/*
> - * Changes migrate type in [start_pfn, end_pfn) to be MIGRATE_ISOLATE.
> - */
> -int
> -start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
> -			 int migratetype, int flags, gfp_t gfp_flags);
> -
> -/*
> - * Changes MIGRATE_ISOLATE to MIGRATE_MOVABLE.
> - * target range is [start_pfn, end_pfn)
> - */
> -void
> -undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
> -			int migratetype);
> -
> -/*
> - * Test all pages in [start_pfn, end_pfn) are isolated or not.
> - */
> +int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
> +			     int migratetype, int flags, gfp_t gfp_flags);
> +
> +void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
> +			     int migratetype);
> +
>  int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
>  			int isol_flags);
>  
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index c6f3605e37ab..e7d7685104de 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -481,8 +481,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>  }
>  
>  /**
> - * start_isolate_page_range() - make page-allocation-type of range of pages to
> - * be MIGRATE_ISOLATE.
> + * start_isolate_page_range() - mark page range MIGRATE_ISOLATE
>   * @start_pfn:		The lower PFN of the range to be isolated.
>   * @end_pfn:		The upper PFN of the range to be isolated.

I don't remember seeing lower and upper to describe memory ranges in our
docs. Do you mind changing these to first/last?

>   * @migratetype:	Migrate type to set in error recovery.
> @@ -571,8 +570,14 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  	return 0;
>  }
>  
> -/*
> - * Make isolated pages available again.
> +/**
> + * undo_isolate_page_range - undo effects of start_isolate_page_range()
> + * @start_pfn:		The lower PFN of the isolated range
> + * @end_pfn:		The upper PFN of the isolated range

Here as well

> + * @migratetype:	New migrate type to set on the range
> + *
> + * This finds every MIGRATE_ISOLATE page block in the given range
> + * and switches it to @migratetype.
>   */
>  void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  			    int migratetype)
> @@ -631,7 +636,21 @@ __test_page_isolated_in_pageblock(unsigned long pfn, unsigned long end_pfn,
>  	return pfn;
>  }
>  
> -/* Caller should ensure that requested range is in a single zone */
> +/**
> + * test_pages_isolated - check if pageblocks in range are isolated
> + * @start_pfn:		The first PFN of the isolated range
> + * @end_pfn:		The first PFN *after* the isolated range
> + * @isol_flags:		Testing mode flags
> + *
> + * This tests if all in the specified range are free.
> + *
> + * If %MEMORY_OFFLINE is specified in @flags, it will consider
> + * poisoned and offlined pages free as well.
> + *
> + * Caller must ensure the requested range doesn't span zones.
> + *
> + * Returns 0 if true, -EBUSY if one or more pages are in use.
> + */
>  int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
>  			int isol_flags)
>  {
> -- 
> 2.40.0
> 
> 

-- 
Sincerely yours,
Mike.

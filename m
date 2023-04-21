Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9674F6EA3F7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 08:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjDUGrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 02:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjDUGrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 02:47:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A414EE3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 23:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682059624; x=1713595624;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=GVrdmfaOJ8LgmgQ7cFs6j/XJvkFAHodlEd2c9Y8HU1k=;
  b=UWN1DpshORi1AyHL8MFIFlU41T1zVXIROk5nM/yQHL0vEK65IfpQfWlW
   0lzh2uG2TrlH9De5nJZ+vemIdORpBvqZ3vGtdAequFhMUjW2XwscHpBD/
   M0kn1amQ0ACLet/pl/LQtL+8Hw4nHNHQnmZxAAsdwAGKUpmQbZR8s3ORe
   SGub54krTw3P1XqZTiXZ0PI5DkSwELK3KsQq0bv/mAyeoASKJdkphhh4Q
   Df6uVOm/r5hlq6PwHPIMz+KGYWrIxfonEziMeqSPn7LKKaUnyTI/sJ/ZC
   TQl9J5ziAk1GzDhzI2/Hgk8IG3f7pPf1rH/uaefWHrn2wJnt4+4bEkX6q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="408868292"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="408868292"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 23:47:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="694868869"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="694868869"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 23:47:02 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: Re: [PATCHv2] mm: skip CMA pages when they are not available
References: <1681979577-11360-1-git-send-email-zhaoyang.huang@unisoc.com>
Date:   Fri, 21 Apr 2023 14:45:53 +0800
In-Reply-To: <1681979577-11360-1-git-send-email-zhaoyang.huang@unisoc.com>
        (zhaoyang huang's message of "Thu, 20 Apr 2023 16:32:57 +0800")
Message-ID: <87v8hpspge.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"zhaoyang.huang" <zhaoyang.huang@unisoc.com> writes:

> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> This patch fixes unproductive reclaiming of CMA pages by skipping them when they
> are not available for current context. It is arise from bellowing OOM issue, which
> caused by large proportion of MIGRATE_CMA pages among free pages. There has been
> commit(168676649) to fix it by trying CMA pages first instead of fallback in
> rmqueue. I would like to propose another one from reclaiming perspective.
>
> 04166 < 4> [   36.172486] [03-19 10:05:52.172] ActivityManager: page allocation failure: order:0, mode:0xc00(GFP_NOIO), nodemask=(null),cpuset=foreground,mems_allowed=0
> 0419C < 4> [   36.189447] [03-19 10:05:52.189] DMA32: 0*4kB 447*8kB (C) 217*16kB (C) 124*32kB (C) 136*64kB (C) 70*128kB (C) 22*256kB (C) 3*512kB (C) 0*1024kB 0*2048kB 0*4096kB = 35848kB
> 0419D < 4> [   36.193125] [03-19 10:05:52.193] Normal: 231*4kB (UMEH) 49*8kB (MEH) 14*16kB (H) 13*32kB (H) 8*64kB (H) 2*128kB (H) 0*256kB 1*512kB (H) 0*1024kB 0*2048kB 0*4096kB = 3236kB
> 	......
> 041EA < 4> [   36.234447] [03-19 10:05:52.234] SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
> 041EB < 4> [   36.234455] [03-19 10:05:52.234] cache: ext4_io_end, object size: 64, buffer size: 64, default order: 0, min order: 0
> 041EC < 4> [   36.234459] [03-19 10:05:52.234] node 0: slabs: 53,objs: 3392, free: 0

From the above description, you are trying to resolve an issue that has
been resolved already.  If so, why do we need your patch?  What is the
issue it try to resolve in current upstream kernel?

At the first glance, I don't think your patch doesn't make sense.  But
you really need to show the value of the patch.

Best Regards,
Huang, Ying

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: update commit message and fix build error when CONFIG_CMA is not set
> ---
> ---
>  mm/vmscan.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bd6637f..19fb445 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2225,10 +2225,16 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>  	unsigned long nr_skipped[MAX_NR_ZONES] = { 0, };
>  	unsigned long skipped = 0;
>  	unsigned long scan, total_scan, nr_pages;
> +	bool cma_cap = true;
> +	struct page *page;
>  	LIST_HEAD(folios_skipped);
>  
>  	total_scan = 0;
>  	scan = 0;
> +	if ((IS_ENABLED(CONFIG_CMA)) && !current_is_kswapd()
> +		&& (gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE))
> +		cma_cap = false;
> +
>  	while (scan < nr_to_scan && !list_empty(src)) {
>  		struct list_head *move_to = src;
>  		struct folio *folio;
> @@ -2239,12 +2245,17 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>  		nr_pages = folio_nr_pages(folio);
>  		total_scan += nr_pages;
>  
> -		if (folio_zonenum(folio) > sc->reclaim_idx) {
> +		page = &folio->page;
> +
> +		if ((folio_zonenum(folio) > sc->reclaim_idx)
> +#ifdef CONFIG_CMA
> +			|| (get_pageblock_migratetype(page) == MIGRATE_CMA && !cma_cap)
> +#endif
> +		) {
>  			nr_skipped[folio_zonenum(folio)] += nr_pages;
>  			move_to = &folios_skipped;
>  			goto move;
>  		}
> -
>  		/*
>  		 * Do not count skipped folios because that makes the function
>  		 * return with no isolated folios if the LRU mostly contains

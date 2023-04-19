Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1AC6E72D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjDSGHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjDSGHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:07:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D264159F5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681884440; x=1713420440;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=HL4/IpuRxVTfl2tt7aPzdAuCiKtCuY7ygljEjn2Iws4=;
  b=M+Y2szsDxdFrNZkyFky0XjdTW2/1SPQ2KPuqJja9LLJ723lnSX4EA5Os
   Avm+Ys8qY2F8uuUxTVsK6ONhGRIbIKfCcq4QzTmmX364mqzAm+SXUmE+m
   UShUz5aZn0jJe2e3YlotzgkvKLIIUIaehdoHh40VD8J0vnQqH2QkSsAwh
   VyqcnqnpcF8RtCOlDyI71hHuiKYIakCXb9BAUyyMQVjcstKcCJlv84vzk
   Rr9o70F5NPrsUTJuuKMCOoR0jLTLSaSoG9wKnqd4UVpRIGxSb5R06lSTb
   yf2wbInMTRC8J9MJpobtI2tu6g9hdc5s2wQw+vdYn88rXTvXzimHTxL2K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="410593566"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="410593566"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 23:07:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="721783828"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="721783828"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 23:07:18 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: Re: [PATCH] mm: skip CMA pages when they are not available
References: <1681882824-17532-1-git-send-email-zhaoyang.huang@unisoc.com>
Date:   Wed, 19 Apr 2023 14:06:05 +0800
In-Reply-To: <1681882824-17532-1-git-send-email-zhaoyang.huang@unisoc.com>
        (zhaoyang huang's message of "Wed, 19 Apr 2023 13:40:24 +0800")
Message-ID: <87pm80tnhu.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"zhaoyang.huang" <zhaoyang.huang@unisoc.com> writes:

> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> It is wasting of effort to reclaim CMA pages if they are not availabe
> for current context during direct reclaim. Skip them when under corresponding
> circumstance.

Do you have any performance number for this change?

Best Regards,
Huang, Ying

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/vmscan.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bd6637f..04424d9 100644
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
> @@ -2239,7 +2245,10 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>  		nr_pages = folio_nr_pages(folio);
>  		total_scan += nr_pages;
>  
> -		if (folio_zonenum(folio) > sc->reclaim_idx) {
> +		page = &folio->page;
> +
> +		if (folio_zonenum(folio) > sc->reclaim_idx ||
> +			(get_pageblock_migratetype(page) == MIGRATE_CMA && !cma_cap)) {
>  			nr_skipped[folio_zonenum(folio)] += nr_pages;
>  			move_to = &folios_skipped;
>  			goto move;

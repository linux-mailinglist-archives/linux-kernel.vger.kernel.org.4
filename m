Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9581272B8FF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbjFLHqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbjFLHqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:46:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E041729
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686555972; x=1718091972;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=SAQMgb3bEhPtdx+c6WuJkLQHwIW8d3NCrLoMI96JZRU=;
  b=nn85LcOWC6p1IBbdQ0D2bxGuEVn9yA9LT5My8vJier8uMLQSjQp/z2Ol
   aUoP9CgOCTGgJU1bPiH5MpJhc6aAKA+g3VVUoy3WnOf+83ZzYBK+Y8NXR
   l38KhaViYiU8nkCOr3LJKnrMMBeZsdeot8aUWS/T8xUBnPoTawFqSU0RS
   QXRW3+zsw3Lq0PZk6OlQqD1HjVMFA9GlcrhNpq8u0WBoOM3RrOK0CAxj9
   plAD5+xPYOISNVcsCXZttE2jYkYO5wNKOllQ1EFn0meRCZpPB06orFCwu
   xBfWQAa4gt1uuUkc4+97wfd9VYu3sicbg8AAEfYFcj66ax1PS45chRkVG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="423839310"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="423839310"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 23:40:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="776234058"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="776234058"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 23:40:11 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: compaction: skip memory hole rapidly when isolating
 migratable pages
References: <8cc668b77c8eb2fa78058b3d81386ebed9c5a9cd.1686294549.git.baolin.wang@linux.alibaba.com>
Date:   Mon, 12 Jun 2023 14:39:03 +0800
In-Reply-To: <8cc668b77c8eb2fa78058b3d81386ebed9c5a9cd.1686294549.git.baolin.wang@linux.alibaba.com>
        (Baolin Wang's message of "Fri, 9 Jun 2023 17:45:54 +0800")
Message-ID: <87sfax6v7c.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On some machines, the normal zone can have a large memory hole like
> below memory layout, and we can see the range from 0x100000000 to
> 0x1800000000 is a hole. So when isolating some migratable pages, the
> scanner can meet the hole and it will take more time to skip the large
> hole. From my measurement, I can see the isolation scanner will take
> 80us ~ 100us to skip the large hole [0x100000000 - 0x1800000000].
>
> So adding a new helper to fast search next online memory section
> to skip the large hole can help to find next suitable pageblock
> efficiently. With this patch, I can see the large hole scanning only
> takes < 1us.
>
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   [mem 0x0000000100000000-0x0000001fa7ffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000040000000-0x0000000fffffffff]
> [    0.000000]   node   0: [mem 0x0000001800000000-0x0000001fa3c7ffff]
> [    0.000000]   node   0: [mem 0x0000001fa3c80000-0x0000001fa3ffffff]
> [    0.000000]   node   0: [mem 0x0000001fa4000000-0x0000001fa402ffff]
> [    0.000000]   node   0: [mem 0x0000001fa4030000-0x0000001fa40effff]
> [    0.000000]   node   0: [mem 0x0000001fa40f0000-0x0000001fa73cffff]
> [    0.000000]   node   0: [mem 0x0000001fa73d0000-0x0000001fa745ffff]
> [    0.000000]   node   0: [mem 0x0000001fa7460000-0x0000001fa746ffff]
> [    0.000000]   node   0: [mem 0x0000001fa7470000-0x0000001fa758ffff]
> [    0.000000]   node   0: [mem 0x0000001fa7590000-0x0000001fa7ffffff]
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  include/linux/mmzone.h | 10 ++++++++++
>  mm/compaction.c        | 23 ++++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 5a7ada0413da..87e6c535d895 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -2000,6 +2000,16 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
>  	return -1;
>  }
>  
> +static inline unsigned long next_online_section_nr(unsigned long section_nr)
> +{
> +	while (++section_nr <= __highest_present_section_nr) {
> +		if (online_section_nr(section_nr))
> +			return section_nr;
> +	}
> +
> +	return -1UL;
> +}
> +
>  /*
>   * These are _only_ used during initialisation, therefore they
>   * can use __initdata ...  They could have names to indicate
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 3398ef3a55fe..3a55fdd20c49 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -229,6 +229,21 @@ static void reset_cached_positions(struct zone *zone)
>  				pageblock_start_pfn(zone_end_pfn(zone) - 1);
>  }
>  
> +static unsigned long skip_hole_pageblock(unsigned long start_pfn)
> +{
> +	unsigned long next_online_nr;
> +	unsigned long start_nr = pfn_to_section_nr(start_pfn);
> +
> +	if (online_section_nr(start_nr))
> +		return -1UL;

Define a macro for the maigic "-1UL"?  Which is used for multiple times
in the patch.

> +
> +	next_online_nr = next_online_section_nr(start_nr);
> +	if (next_online_nr != -1UL)
> +		return section_nr_to_pfn(next_online_nr);
> +
> +	return -1UL;
> +}
> +
>  /*
>   * Compound pages of >= pageblock_order should consistently be skipped until
>   * released. It is always pointless to compact pages of such order (if they are
> @@ -1991,8 +2006,14 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>  
>  		page = pageblock_pfn_to_page(block_start_pfn,
>  						block_end_pfn, cc->zone);
> -		if (!page)
> +		if (!page) {
> +			unsigned long next_pfn;
> +
> +			next_pfn = skip_hole_pageblock(block_start_pfn);
> +			if (next_pfn != -1UL)
> +				block_end_pfn = next_pfn;
>  			continue;
> +		}
>  
>  		/*
>  		 * If isolation recently failed, do not retry. Only check the

Do we need to do similar change in isolate_freepages()?

Best Regards,
Huang, Ying

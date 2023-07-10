Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFC874CCB0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjGJGNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjGJGNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:13:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3BB9C
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688969595; x=1720505595;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=4aybMDCc0kzO4ssUfb3GudNz2ZedSVSfcl287JTXCjU=;
  b=n1sA1WhfuPXt+O5e8mXRIB75TiSsfIk749NeApRK/NT6Yi4si3RV5KIM
   IJXJ6JWY+z1HM2/iAiXZp1UcP0r3Zm233O7d97iQQILsMXdvWCg8w/wLC
   UXXrxguwJCQsu+rdI41y8p5hqEHFT41zsYrfVlOLJqZYrChLyskzhqcCA
   27fXqSBtKSy/GXdxeCl1bqVCp+gmC8L+BhOxNINIRj8FE0PuJEJyCipZV
   V7iCasMKMDwjT2fUDh+y7MnZ+MaXkuVgUFIsY0S9dlgQanGYjBvRzakLh
   bmsskyCdRpplYAKRwr4dONWQ2O4huaqn39GSLC5gCUZ6KtQCc5jvUfceE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="354123141"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="354123141"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 23:13:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="1051242704"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="1051242704"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 23:13:12 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <vbabka@suse.cz>, <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm: compaction: skip the memory hole rapidly when
 isolating free pages
References: <b21cd8e2e32b9a1d9bc9e43ebf8acaf35e87f8df.1688715750.git.baolin.wang@linux.alibaba.com>
        <d2ba7e41ee566309b594311207ffca736375fc16.1688715750.git.baolin.wang@linux.alibaba.com>
Date:   Mon, 10 Jul 2023 14:11:35 +0800
In-Reply-To: <d2ba7e41ee566309b594311207ffca736375fc16.1688715750.git.baolin.wang@linux.alibaba.com>
        (Baolin Wang's message of "Fri, 7 Jul 2023 16:51:47 +0800")
Message-ID: <87pm50fg88.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On my machine with below memory layout, and I can see it will take more
> time to skip the larger memory hole (range: 0x100000000 - 0x1800000000)
> when isolating free pages. So adding a new helper to skip the memory
> hole rapidly, which can reduce the time consumed from about 70us to less
> than 1us.
>
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   [mem 0x0000000100000000-0x0000001fa7ffffff]

The memory hole is at the beginning of zone NORMAL?  If so, should zone
NORMAL start at 0x1800000000?  And, the free pages will not be scanned
there?  Or my understanding were wrong?

Best Regards,
Huang, Ying

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
>  mm/compaction.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 43358efdbdc2..9641e2131901 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -249,11 +249,31 @@ static unsigned long skip_offline_sections(unsigned long start_pfn)
>  
>  	return 0;
>  }
> +
> +static unsigned long skip_offline_sections_reverse(unsigned long start_pfn)
> +{
> +	unsigned long start_nr = pfn_to_section_nr(start_pfn);
> +
> +	if (!start_nr || online_section_nr(start_nr))
> +		return 0;
> +
> +	while (start_nr-- > 0) {
> +		if (online_section_nr(start_nr))
> +			return section_nr_to_pfn(start_nr) + PAGES_PER_SECTION - 1;
> +	}
> +
> +	return 0;
> +}
>  #else
>  static unsigned long skip_offline_sections(unsigned long start_pfn)
>  {
>  	return 0;
>  }
> +
> +static unsigned long skip_offline_sections_reverse(unsigned long start_pfn)
> +{
> +	return 0;
> +}
>  #endif
>  
>  /*
> @@ -1668,8 +1688,16 @@ static void isolate_freepages(struct compact_control *cc)
>  
>  		page = pageblock_pfn_to_page(block_start_pfn, block_end_pfn,
>  									zone);
> -		if (!page)
> +		if (!page) {
> +			unsigned long next_pfn;
> +
> +			next_pfn = skip_offline_sections_reverse(block_start_pfn);
> +			if (next_pfn)
> +				block_start_pfn = max(pageblock_start_pfn(next_pfn),
> +						      low_pfn);
> +
>  			continue;
> +		}
>  
>  		/* Check the block is suitable for migration */
>  		if (!suitable_migration_target(cc, page))

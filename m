Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6B06EEBE2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 03:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbjDZBYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 21:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjDZBYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 21:24:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4387285
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682472272; x=1714008272;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=yYghjDk70DgBitqXEYyYD8wI/oOC8o5/z6yF0dEbrYo=;
  b=BqBDD+3j0+6hf6tdJc02qsN8DIJCixKWEBpor3nsUGGsD/EXERUVr6rY
   8qSEHoEjU7B4M0jvmJYWZu5AGNR1cfXOJV7XramLU8o7UJx7AmEXS2lA/
   4oDWRdtGQIC3YszrYt2OC/NrD+fZOUBt218rHifU4sS7pS7rDrE+63DJJ
   qCXdnl1DLPlC70zKilCuPHnTvLdN2FqqpMnwi7YAjEVma52xZQdOQKD/g
   mW8r4i/rzCAx0ThNsCCIHpSOPLviGfMHhW04eDsZDxxOW75xfMnpeWIOc
   Jc4X9XOxn1EiL9JZgtiEfV1yh2SkNpR4mLm4WrAj8CkvO0W+CB9z/HVMr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="433231465"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="433231465"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 18:24:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="805289286"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="805289286"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 18:24:30 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <rppt@kernel.org>,
        <mgorman@techsingularity.net>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] mm/page_alloc: add some comments to explain the
 possible hole in __pageblock_pfn_to_page()
References: <98fa0a22-77d1-cdb3-1ce2-48a00c3ed5a9@linux.alibaba.com>
        <5c26368865e79c743a453dea48d30670b19d2e4f.1682425534.git.baolin.wang@linux.alibaba.com>
Date:   Wed, 26 Apr 2023 09:23:25 +0800
In-Reply-To: <5c26368865e79c743a453dea48d30670b19d2e4f.1682425534.git.baolin.wang@linux.alibaba.com>
        (Baolin Wang's message of "Tue, 25 Apr 2023 20:44:53 +0800")
Message-ID: <87sfcne8s2.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(), which
> checks whether the given zone contains holes, and uses pfn_to_online_page()
> to validate if the start pfn is online and valid, as well as using pfn_valid()
> to validate the end pfn.
>
> However, the __pageblock_pfn_to_page() function may return non-NULL even
> if the end pfn of a pageblock is in a memory hole in some situations. For
> example, if the pageblock order is MAX_ORDER, which will fall into 2
> sub-sections, and the end pfn of the pageblock may be hole even though
> the start pfn is online and valid.
>
> See below memory layout as an example and suppose the pageblock order
> is MAX_ORDER.
>
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   [mem 0x0000000100000000-0x0000001fa7ffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000040000000-0x0000001fa3c7ffff]
> [    0.000000]   node   0: [mem 0x0000001fa3c80000-0x0000001fa3ffffff]
> [    0.000000]   node   0: [mem 0x0000001fa4000000-0x0000001fa402ffff]
> [    0.000000]   node   0: [mem 0x0000001fa4030000-0x0000001fa40effff]
> [    0.000000]   node   0: [mem 0x0000001fa40f0000-0x0000001fa73cffff]
> [    0.000000]   node   0: [mem 0x0000001fa73d0000-0x0000001fa745ffff]
> [    0.000000]   node   0: [mem 0x0000001fa7460000-0x0000001fa746ffff]
> [    0.000000]   node   0: [mem 0x0000001fa7470000-0x0000001fa758ffff]
> [    0.000000]   node   0: [mem 0x0000001fa7590000-0x0000001fa7dfffff]
>
> Focus on the last memory range, and there is a hole for the range [mem
> 0x0000001fa7590000-0x0000001fa7dfffff]. That means the last pageblock
> will contain the range from 0x1fa7c00000 to 0x1fa7ffffff, since the
> pageblock must be 4M aligned. And in this pageblock, these pfns will
> fall into 2 sub-section (the sub-section size is 2M aligned).
>
> So, the 1st sub-section (indicates pfn range: 0x1fa7c00000 -
> 0x1fa7dfffff ) in this pageblock is valid by calling subsection_map_init()
> in free_area_init(), but the 2nd sub-section (indicates pfn range:
> 0x1fa7e00000 - 0x1fa7ffffff ) in this pageblock is not valid.
>
> This did not break anything until now, but the zone continuous is fragile
> in this possible scenario. So as previous discussion[1], it is better to
> add some comments to explain this possible issue in case there are some
> future pfn walkers that rely on this.
>
> [1] https://lore.kernel.org/all/87r0sdsmr6.fsf@yhuang6-desk2.ccr.corp.intel.com/
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
> Changes from v3:
>  - Update the comments to make it clear.
>  - Add acked tag from Michal.
> Changes from v2:
>  - Update the commit log and comments per Michal, thanks.
> Changes from v1:
>  - Update the comments per Ying and Mike, thanks.
> ---
>  mm/page_alloc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6457b64fe562..af9c995d3c1e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1502,6 +1502,15 @@ void __free_pages_core(struct page *page, unsigned int order)
>   * interleaving within a single pageblock. It is therefore sufficient to check
>   * the first and last page of a pageblock and avoid checking each individual
>   * page in a pageblock.
> + *
> + * Note: the function may return non-NULL struct page even for a page block
> + * which contains a memory hole (i.e. there is no physical memory for a subset
> + * of the pfn range). For example, if the pageblock order is MAX_ORDER, which
> + * will fall into 2 sub-sections, and the end pfn of the pageblock may be hole
> + * even though the start pfn is online and valid. This should be safe most of
> + * the time because struct pages are still initialized via init_unavailable_range()
> + * and pfn walkers shouldn't touch any physical memory range for which they do
> + * not recognize any specific metadata in struct pages.
>   */
>  struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
>  				     unsigned long end_pfn, struct zone *zone)

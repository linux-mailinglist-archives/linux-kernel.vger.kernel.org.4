Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DD86ED94F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 02:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjDYAYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 20:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDYAYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 20:24:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CC259FF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 17:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682382247; x=1713918247;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Ggl6Dk7a57sbHO8EsDno0qdkPR9T5Q9oeWBPCCIvkIc=;
  b=b19uWuBU5oNPCODesglnjjKyo2QX1cJGmWBVk/iL7bOVVnpUTsCJHbEX
   R4baoLNlrOF3q1P9jKH3mDvDJNVQLOYS9wai5JOlxb83LqnlikNC5+5Ue
   zFHHS9uJCWRlDEfChdCZM7NVD46E2mHQRKYhXsICGPT+gXNQcY2HUtQIZ
   Jvna6CQ4FNDtXA7oHnDrZoNgCz9JpUGVpx3yEMsvtyMoW7D5WIxHbQJjU
   xF87HHMosrr5N1wLx+WOMEwrpdPagu/gXmmTjlQka3VTodLueCeUZbuFL
   8hvbBOzFX7w374JmWxbvYmZ3nwHe+v0W8DzQZbOzeRQJUQWH0H05ROMWz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="326216071"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="326216071"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 17:24:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="693276416"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="693276416"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 17:24:04 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <rppt@kernel.org>,
        <mgorman@techsingularity.net>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] mm/page_alloc: add some comments to explain the
 possible hole in __pageblock_pfn_to_page()
References: <c3868b58c6714c09a43440d7d02c7b4eed6e03f6.1682342634.git.baolin.wang@linux.alibaba.com>
        <50b5e05dbb007e3a969ac946bc9ee0b2b77b185f.1682342634.git.baolin.wang@linux.alibaba.com>
Date:   Tue, 25 Apr 2023 08:22:55 +0800
In-Reply-To: <50b5e05dbb007e3a969ac946bc9ee0b2b77b185f.1682342634.git.baolin.wang@linux.alibaba.com>
        (Baolin Wang's message of "Mon, 24 Apr 2023 21:45:40 +0800")
Message-ID: <87zg6wkdy8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
> ---
> Changes from v2:
>  - Update the commit log and comments per Michal, thanks.
> Changes from v1:
>  - Update the comments per Ying and Mike, thanks.
>
> Note, I did not add Huang Ying's reviewed tag, since there are some
> updates per Michal's suggestion. Ying, please review the v3. Thanks.
> ---
>  mm/page_alloc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6457b64fe562..bd124390c79b 100644
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
> + * the time because struct pages are still zero pre-filled and pfn walkers

I don't think the pfn is just zero-filled even it's a hole.  Can you
confirm that?  In memmap_init() and memmap_init_zone_range(),
init_unavailable_range() is called to initialize the struct page.

Best Regards,
Huang, Ying

> + * shouldn't touch any physical memory range for which they do not recognize
> + * any specific metadata in struct pages.
>   */
>  struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
>  				     unsigned long end_pfn, struct zone *zone)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8DF6059A7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiJTIZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJTIZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:25:04 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AADBAD9B1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666254303; x=1697790303;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=N/IkiQgsQXyxu6iYoSAwhE2auxZ8xnMdjB2X/PD31M0=;
  b=F7xSDkciq4rFgCS4yTtruRAqORyIMlcgde2lka4rfh4Y816VR0NjR9If
   7K3KvJd7FG55S6tPLlWSoJuJR0++IhivMtWL7E+lBN9PUOgo/pTWSjCw0
   MabfbtG/vA6PZYoSPrt0EdDI7A5IoFy7NRlRhtdN8zIWdCZAGDiJtrqJb
   u2uh0HCOALtxR9V6zD344Yv4vlMtLhR9LDx1uWYGXvT0dC58Sac32r0/6
   aG2hij06pbVB82hXtDcNekLe6ikHEhoajeSOhBtApsIwEU1fArkKlE50L
   M8+V3G3NNPsldmnNDb8+kKrV7OlZ6Sc6n43/9BabJngxaqwMpr/xFGh8m
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="307747095"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="307747095"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 01:25:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="958787937"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="958787937"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 01:25:00 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <david@redhat.com>, <ziy@nvidia.com>,
        <shy828301@gmail.com>, <jingshan@linux.alibaba.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm: migrate: Try again if THP split is failed due
 to page refcnt
References: <cc48dc1e4db8c33289f168cf380ab3641f45f8ad.1666251624.git.baolin.wang@linux.alibaba.com>
        <c44225ae71b1be21e32891e2143044863a0b91b1.1666251624.git.baolin.wang@linux.alibaba.com>
Date:   Thu, 20 Oct 2022 16:24:20 +0800
In-Reply-To: <c44225ae71b1be21e32891e2143044863a0b91b1.1666251624.git.baolin.wang@linux.alibaba.com>
        (Baolin Wang's message of "Thu, 20 Oct 2022 15:49:01 +0800")
Message-ID: <87mt9qnbrf.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> When creating a virtual machine, we will use memfd_create() to get
> a file descriptor which can be used to create share memory mappings
> using the mmap function, meanwhile the mmap() will set the MAP_POPULATE
> flag to allocate physical pages for the virtual machine.
>
> When allocating physical pages for the guest, the host can fallback to
> allocate some CMA pages for the guest when over half of the zone's free
> memory is in the CMA area.
>
> In guest os, when the application wants to do some data transaction with
> DMA, our QEMU will call VFIO_IOMMU_MAP_DMA ioctl to do longterm-pin and
> create IOMMU mappings for the DMA pages. However, when calling
> VFIO_IOMMU_MAP_DMA ioctl to pin the physical pages, we found it will be
> failed to longterm-pin sometimes.
>
> After some invetigation, we found the pages used to do DMA mapping can
> contain some CMA pages, and these CMA pages will cause a possible
> failure of the longterm-pin, due to failed to migrate the CMA pages.
> The reason of migration failure may be temporary reference count or
> memory allocation failure. So that will cause the VFIO_IOMMU_MAP_DMA
> ioctl returns error, which makes the application failed to start.
>
> I observed one migration failure case (which is not easy to reproduce) is
> that, the 'thp_migration_fail' count is 1 and the 'thp_split_page_failed'
> count is also 1.
>
> That means when migrating a THP which is in CMA area, but can not allocate
> a new THP due to memory fragmentation, so it will split the THP. However
> THP split is also failed, probably the reason is temporary reference count
> of this THP. And the temporary reference count can be caused by dropping
> page caches (I observed the drop caches operation in the system), but we
> can not drop the shmem page caches due to they are already dirty at that time.
>
> Especially for THP split failure, which is caused by temporary reference
> count, we can try again to mitigate the failure of migration in this case
> according to previous discussion [1].

Does the patch solved your problem?

> [1] https://lore.kernel.org/all/470dc638-a300-f261-94b4-e27250e42f96@redhat.com/
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/huge_memory.c |  4 ++--
>  mm/migrate.c     | 18 +++++++++++++++---
>  2 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ad17c8d..a79f03b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2666,7 +2666,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  	 * split PMDs
>  	 */
>  	if (!can_split_folio(folio, &extra_pins)) {
> -		ret = -EBUSY;
> +		ret = -EAGAIN;
>  		goto out_unlock;
>  	}
>  
> @@ -2716,7 +2716,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  			xas_unlock(&xas);
>  		local_irq_enable();
>  		remap_page(folio, folio_nr_pages(folio));
> -		ret = -EBUSY;
> +		ret = -EAGAIN;
>  	}
>  
>  out_unlock:
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8e5eb6e..55c7855 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1506,9 +1506,21 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  				if (is_thp) {
>  					nr_thp_failed++;
>  					/* THP NUMA faulting doesn't split THP to retry. */
> -					if (!nosplit && !try_split_thp(page, &thp_split_pages)) {
> -						nr_thp_split++;
> -						break;
> +					if (!nosplit) {
> +						rc = try_split_thp(page, &thp_split_pages);
> +						if (!rc) {
> +							nr_thp_split++;
> +							break;
> +						} else if (reason == MR_LONGTERM_PIN &&
> +							   rc == -EAGAIN) {

In case reason != MR_LONGTERM_PIN, you change the return value of
migrate_pages().  So you need to use another variable for return value.

> +							/*
> +							 * Try again to split THP to mitigate
> +							 * the failure of longterm pinning.
> +							 */
> +							thp_retry++;
> +							nr_retry_pages += nr_subpages;
> +							break;
> +						}
>  					}
>  				} else if (!no_subpage_counting) {
>  					nr_failed++;

Best Regards,
Huang, Ying

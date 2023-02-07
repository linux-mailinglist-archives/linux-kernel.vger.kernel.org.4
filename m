Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D7E68DF30
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjBGRoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjBGRoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:44:13 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD333BD8A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:44:10 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vb8Lda5_1675791845;
Received: from 30.25.213.166(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Vb8Lda5_1675791845)
          by smtp.aliyun-inc.com;
          Wed, 08 Feb 2023 01:44:06 +0800
Message-ID: <8464725c-40ce-3e3f-baaf-5c2c136cc870@linux.alibaba.com>
Date:   Wed, 8 Feb 2023 01:44:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH -v4 8/9] migrate_pages: batch flushing TLB
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20230206063313.635011-1-ying.huang@intel.com>
 <20230206063313.635011-9-ying.huang@intel.com>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20230206063313.635011-9-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/2/6 下午2:33, Huang Ying 写道:
> The TLB flushing will cost quite some CPU cycles during the folio
> migration in some situations.  For example, when migrate a folio of a
> process with multiple active threads that run on multiple CPUs.  After
> batching the _unmap and _move in migrate_pages(), the TLB flushing can
> be batched easily with the existing TLB flush batching mechanism.
> This patch implements that.
>
> We use the following test case to test the patch.
>
> On a 2-socket Intel server,
>
> - Run pmbench memory accessing benchmark
>
> - Run `migratepages` to migrate pages of pmbench between node 0 and
>    node 1 back and forth.
>
> With the patch, the TLB flushing IPI reduces 99.1% during the test and
> the number of pages migrated successfully per second increases 291.7%.
>
> NOTE: TLB flushing is batched only for normal folios, not for THP
> folios.  Because the overhead of TLB flushing for THP folios is much
> lower than that for normal folios (about 1/512 on x86 platform).
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: haoxin <xhao@linux.alibaba.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>   mm/migrate.c |  4 +++-
>   mm/rmap.c    | 20 +++++++++++++++++---
>   2 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 9378fa2ad4a5..ca6e2ff02a09 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1230,7 +1230,7 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
>   		/* Establish migration ptes */
>   		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
>   			       !folio_test_ksm(src) && !anon_vma, src);
> -		try_to_migrate(src, 0);
> +		try_to_migrate(src, TTU_BATCH_FLUSH);
>   		page_was_mapped = 1;
>   	}
>   
> @@ -1781,6 +1781,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   	stats->nr_thp_failed += thp_retry;
>   	stats->nr_failed_pages += nr_retry_pages;
>   move:
> +	try_to_unmap_flush();
> +
>   	retry = 1;
>   	for (pass = 0;
>   	     pass < NR_MAX_MIGRATE_PAGES_RETRY && (retry || large_retry);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index b616870a09be..2e125f3e462e 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1976,7 +1976,21 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>   		} else {
>   			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
>   			/* Nuke the page table entry. */
> -			pteval = ptep_clear_flush(vma, address, pvmw.pte);
> +			if (should_defer_flush(mm, flags)) {
> +				/*
> +				 * We clear the PTE but do not flush so potentially
> +				 * a remote CPU could still be writing to the folio.
> +				 * If the entry was previously clean then the
> +				 * architecture must guarantee that a clear->dirty
> +				 * transition on a cached TLB entry is written through
> +				 * and traps if the PTE is unmapped.
> +				 */
> +				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
Nice work， Reviewed-by: Xin Hao <xhao@linux.alibaba.com>
> +
> +				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
> +			} else {
> +				pteval = ptep_clear_flush(vma, address, pvmw.pte);
> +			}
>   		}
>   
>   		/* Set the dirty flag on the folio now the pte is gone. */
> @@ -2148,10 +2162,10 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
>   
>   	/*
>   	 * Migration always ignores mlock and only supports TTU_RMAP_LOCKED and
> -	 * TTU_SPLIT_HUGE_PMD and TTU_SYNC flags.
> +	 * TTU_SPLIT_HUGE_PMD, TTU_SYNC, and TTU_BATCH_FLUSH flags.
>   	 */
>   	if (WARN_ON_ONCE(flags & ~(TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
> -					TTU_SYNC)))
> +					TTU_SYNC | TTU_BATCH_FLUSH)))
>   		return;
>   
>   	if (folio_is_zone_device(folio) &&

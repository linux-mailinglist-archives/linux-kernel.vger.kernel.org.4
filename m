Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12294714233
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 05:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjE2DCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 23:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2DCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 23:02:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB17B1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 20:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685329366; x=1716865366;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=cpAx3C+taT+Gelle0teqM12QyhLpw86X0NIl0V5m6xo=;
  b=YNDZmVlWMq7vRWw2WcXFU8uIivjtBVXHEOWQmAKcowajRok/6UrTGixd
   mrTALg6W2+TAtSnd+vYm1q2yzcACpptioGWYmBWGTv8xZSer1H6Ulya+X
   yIOyxoMchiKBVt8RlcwjOJZ1XJBaSV/RqyI6hJrf52ikjmuM1Mm5Eord/
   /JZzLsDv6zT+p9naM+eq0dwfbk8SiifT5s0wk0U5cCywrb5byfaj6k0j2
   p/vfCrYtmBBdsHLe9FecPtmt+5TEFX52ysLIGXSuhEZpcuWzy7yOTtrK7
   lKKnHDVgC2fORpZDVucnD3jWZ5Yfzz607LuhX3EHBvkzcYdzlPJIGDUdi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="356981096"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="356981096"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 20:02:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="795767167"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="795767167"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 20:02:42 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        steven.sistare@oracle.com, david@redhat.com,
        mgorman@techsingularity.net, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Khalid Aziz <khalid@kernel.org>
Subject: Re: [PATCH v4] mm, compaction: Skip all non-migratable pages during
 scan
References: <20230525191507.160076-1-khalid.aziz@oracle.com>
Date:   Mon, 29 May 2023 11:01:40 +0800
In-Reply-To: <20230525191507.160076-1-khalid.aziz@oracle.com> (Khalid Aziz's
        message of "Thu, 25 May 2023 13:15:07 -0600")
Message-ID: <87ttvvx2ln.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Khalid Aziz <khalid.aziz@oracle.com> writes:

> Pages pinned in memory through extra refcounts can not be migrated.
> Currently as isolate_migratepages_block() scans pages for
> compaction, it skips any pinned anonymous pages. All non-migratable
> pages should be skipped and not just the anonymous pinned pages.
> This patch adds a check for extra refcounts on a page to determine
> if the page can be migrated.  This was seen as a real issue on a
> customer workload where a large number of pages were pinned by vfio
> on the host and any attempts to allocate hugepages resulted in
> significant amount of cpu time spent in either direct compaction or
> in kcompactd scanning vfio pinned pages over and over again that can
> not be migrated. These are the changes in relevant stats with this
> patch for a test run of this scenario:
>
> 				Before			After
> compact_migrate_scanned		329,798,858		370,984,387
> compact_free_scanned		40,478,406		25,843,262
> compact_isolated		135,470,452		777,235
> pgmigrate_success		544,255			507,325
> pgmigrate_fail			134,616,282		47
> kcompactd CPU time		5:12.81			0:12.28
>
> Before the patch, large number of pages were isolated but most of
> them failed to migrate.
>
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> Suggested-by: Steve Sistare <steven.sistare@oracle.com>
> Cc: Khalid Aziz <khalid@kernel.org>
> ---
> v4:
> 	- Use existing folio_expected_refs() function (Suggested
> 	  by Huang, Ying)
> 	- Use folio functions
> 	- Take into account contig allocations when checking for
> 	  long temr pinning and skip pages in ZONE_MOVABLE and
> 	  MIGRATE_CMA type pages (Suggested by David Hildenbrand)
> 	- Use folio version of total_mapcount() instead of
> 	  page_mapcount() (Suggested by Baolin Wang)
>
> v3:
> 	- Account for extra ref added by get_page_unless_zero() earlier
> 	  in isolate_migratepages_block() (Suggested by Huang, Ying)
> 	- Clean up computation of extra refs to be consistent 
> 	  (Suggested by Huang, Ying)
>
> v2:
> 	- Update comments in the code (Suggested by Andrew)
> 	- Use PagePrivate() instead of page_has_private() (Suggested
> 	  by Matthew)
> 	- Pass mapping to page_has_extrarefs() (Suggested by Matthew)
> 	- Use page_ref_count() (Suggested by Matthew)
> 	- Rename is_pinned_page() to reflect its function more
> 	  accurately (Suggested by Matthew)
>
>  include/linux/migrate.h | 16 +++++++++++++++
>  mm/compaction.c         | 44 +++++++++++++++++++++++++++++++++++++----
>  mm/migrate.c            | 14 -------------
>  3 files changed, 56 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 6241a1596a75..4f59e15eae99 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -141,6 +141,22 @@ const struct movable_operations *page_movable_ops(struct page *page)
>  		((unsigned long)page->mapping - PAGE_MAPPING_MOVABLE);
>  }
>  
> +static inline
> +int folio_expected_refs(struct address_space *mapping,
> +		struct folio *folio)

I don't think that it's necessary to make this function inline.  It
isn't called in hot path.

> +{
> +	int refs = 1;
> +
> +	if (!mapping)
> +		return refs;
> +
> +	refs += folio_nr_pages(folio);
> +	if (folio_test_private(folio))
> +		refs++;
> +
> +	return refs;
> +}
> +
>  #ifdef CONFIG_NUMA_BALANCING
>  int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>  			   int node);
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 5a9501e0ae01..b548e05f0349 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -764,6 +764,42 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  	return too_many;
>  }
>  
> +/*
> + * Check if this base page should be skipped from isolation because
> + * it has extra refcounts that will prevent it from being migrated.
> + * This code is inspired by similar code in migrate_vma_check_page(),
> + * can_split_folio() and folio_migrate_mapping()
> + */
> +static inline bool page_has_extra_refs(struct page *page,
> +					struct address_space *mapping)
> +{
> +	unsigned long extra_refs;

s/extra_refs/expected_refs/
?

> +	struct folio *folio;
> +
> +	/*
> +	 * Skip this check for pages in ZONE_MOVABLE or MIGRATE_CMA
> +	 * pages that can not be long term pinned
> +	 */
> +	if (is_zone_movable_page(page) || is_migrate_cma_page(page))
> +		return false;

I suggest to move these 2 checks out to the place before calling the
function.  Or change the name of the function.

> +
> +	folio = page_folio(page);
> +
> +	/*
> +	 * caller holds a ref already from get_page_unless_zero()
> +	 * which is accounted for in folio_expected_refs()
> +	 */
> +	extra_refs = folio_expected_refs(mapping, folio);
> +
> +	/*
> +	 * This is an admittedly racy check but good enough to determine
> +	 * if a page is pinned and can not be migrated
> +	 */
> +	if ((folio_ref_count(folio) - extra_refs) > folio_mapcount(folio))
> +		return true;
> +	return false;
> +}
> +
>  /**
>   * isolate_migratepages_block() - isolate all migrate-able pages within
>   *				  a single pageblock
> @@ -992,12 +1028,12 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  			goto isolate_fail;
>  
>  		/*
> -		 * Migration will fail if an anonymous page is pinned in memory,
> -		 * so avoid taking lru_lock and isolating it unnecessarily in an
> -		 * admittedly racy check.
> +		 * Migration will fail if a page has extra refcounts
> +		 * from long term pinning preventing it from migrating,
> +		 * so avoid taking lru_lock and isolating it unnecessarily.
>  		 */
>  		mapping = page_mapping(page);
> -		if (!mapping && (page_count(page) - 1) > total_mapcount(page))
> +		if (!cc->alloc_contig && page_has_extra_refs(page, mapping))
>  			goto isolate_fail_put;
>  
>  		/*
> diff --git a/mm/migrate.c b/mm/migrate.c
> index db3f154446af..a2f3e5834996 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -385,20 +385,6 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
>  }
>  #endif
>  
> -static int folio_expected_refs(struct address_space *mapping,
> -		struct folio *folio)
> -{
> -	int refs = 1;
> -	if (!mapping)
> -		return refs;
> -
> -	refs += folio_nr_pages(folio);
> -	if (folio_test_private(folio))
> -		refs++;
> -
> -	return refs;
> -}
> -
>  /*
>   * Replace the page in the mapping.
>   *

Best Regards,
Huang, Ying

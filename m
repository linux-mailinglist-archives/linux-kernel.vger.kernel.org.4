Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946B070278A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbjEOItP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbjEOIsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:48:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C901BDD
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 01:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684140513; x=1715676513;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=NP9grGktDYmSW/y0bEvt2e7TpvQ9W2Et0cmTgeeaOa8=;
  b=noL66pbr4bYDXddk7Y3UG8CGKmf5WYSDiILIIiYKK0mYJt1EgZnzD4kB
   h1JbHN+NdETPmqIz27b05yh/jFE/QZzZqLHP3CjbypwxucG3zXVogbT5T
   Zc0/LVk+S3Ju2ZZzsibWdmsD6eDGhbejGbcdctBNrr4lJWk2ThqUn7d+D
   lX+kDdDHQQR5bzj2gdD3T7X8XYXZKb//S8P9PIBMLflp+MJz2iQRKaY4m
   NTnyV7khhrzJ9kP7ShH7m9YWYPVrluUT246rQjGvofXMtohSEL3tjisHk
   +h2ZP8DGURh8OeXQlaEsy6ItFqcF+x3yQ75hqS76re1OoCYVE9312v2JI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="379307406"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="379307406"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 01:48:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="845163661"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="845163661"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 01:48:27 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Steve Sistare <steven.sistare@oracle.com>,
        Khalid Aziz <khalid@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v2] mm, compaction: Skip all non-migratable pages during
 scan
References: <20230512190000.103737-1-khalid.aziz@oracle.com>
Date:   Mon, 15 May 2023 16:47:17 +0800
In-Reply-To: <20230512190000.103737-1-khalid.aziz@oracle.com> (Khalid Aziz's
        message of "Fri, 12 May 2023 13:00:00 -0600")
Message-ID: <871qji7zhm.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
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

Hi, Khalid,

Cced Mel.

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
> in kcompatd scanning vfio pinned pages over and over again that can

s/kcompatd/kcompactd/

> not be migrated.

With the patch below, the cycles for kcompactd disappeared?

> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> Suggested-by: Steve Sistare <steven.sistare@oracle.com>
> Cc: Khalid Aziz <khalid@kernel.org>
> ---
> v2:
> 	- Update comments in the code (Suggested by Andrew)
> 	- Use PagePrivate() instead of page_has_private() (Suggested
> 	  by Matthew)
> 	- Pass mapping to page_has_extrarefs() (Suggested by Matthew)
> 	- Use page_ref_count() (Suggested by Matthew)
> 	- Rename is_pinned_page() to reflect its function more
> 	  accurately (Suggested by Matthew)
>
>  mm/compaction.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 5a9501e0ae01..837f20df2bbb 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -764,6 +764,34 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  	return too_many;
>  }
>  
> +/*
> + * Check if this base page should be skipped from isolation because
> + * it has extra refcounts that will prevent it from being migrated.
> + * This function is called for regular pages only, and not
> + * for THP or hugetlbfs pages. This code is inspired by similar code
> + * in migrate_vma_check_page(), can_split_folio() and
> + * folio_migrate_mapping()
> + */
> +static inline bool page_has_extrarefs(struct page *page,

Better to be named as page_has_extra_refs()?

> +					struct address_space *mapping)
> +{
> +	unsigned long extra_refs;
> +
> +	/* anonymous page can have extra ref from swap cache */
> +	if (mapping)
> +		extra_refs = 1 + PagePrivate(page);
> +	else
> +		extra_refs = PageSwapCache(page) ? 1 : 0;

IIUC, mapping != NULL if PageSwapCache(page) is true.  Please check the
implementation of page_mapping().

And even if mapping == NULL, the extra_refs should be 1, because we have
elevated the page refcount in isolate_migratepages_block() before
checking whether the page is pinned.  IIUC, this is the original
behavior.  Or, we can add "- 1" in the following checking.

> +
> +	/*
> +	 * This is an admittedly racy check but good enough to determine
> +	 * if a page is pinned and can not be migrated
> +	 */
> +	if ((page_ref_count(page) - extra_refs) > page_mapcount(page))
> +		return true;
> +	return false;
> +}
> +
>  /**
>   * isolate_migratepages_block() - isolate all migrate-able pages within
>   *				  a single pageblock
> @@ -992,12 +1020,12 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  			goto isolate_fail;
>  
>  		/*
> -		 * Migration will fail if an anonymous page is pinned in memory,
> -		 * so avoid taking lru_lock and isolating it unnecessarily in an
> -		 * admittedly racy check.
> +		 * Migration will fail if a page has extra refcounts
> +		 * preventing it from migrating, so avoid taking
> +		 * lru_lock and isolating it unnecessarily
>  		 */
>  		mapping = page_mapping(page);
> -		if (!mapping && (page_count(page) - 1) > total_mapcount(page))
> +		if (page_has_extrarefs(page, mapping))
>  			goto isolate_fail_put;
>  
>  		/*

Best Regards,
Huang, Ying

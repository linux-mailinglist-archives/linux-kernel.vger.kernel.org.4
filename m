Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299D2708CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjESAWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjESAWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:22:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F324170B
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684455718; x=1715991718;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=WTuK+vaLLwzgrdOsRK3ZECGUwV3wsnYB4PehJqDqJis=;
  b=enQUv8+JH8udTQ2eY3SFq1cnKAUMlmM3Xs0p2DqTLpNCO2m0oWnUaabg
   gyTD+UDYD/rxdiZLbJGyWxFwg6RsNDvbpNw5zNfIrgNEEy4HjJByOOD4s
   FW/DfEgHMecPbgvBWyiGfdQo36duMEur9e4Q7c7m3jpz6O7oKYBDmGn0R
   rebv1FuSCC3hkU3mD1mwuKr6fwWsEwK8cwuOrYPc4qb1//URccQsa09ub
   2+pqtgFsTcO2Mzy6duD2n+Y0rV+Sc9jx3m/v+RJ+ux3JkulEDCMR2ZtEe
   IS5WJQvhtMCvLxpPhNanSP45L7jqc/NDAF4CNebCk4znHuqdPj5viaRR4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="336819403"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="336819403"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:20:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="733084244"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="733084244"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:20:37 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        steven.sistare@oracle.com, mgorman@techsingularity.net,
        khalid@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm, compaction: Skip all non-migratable pages during
 scan
References: <20230517161555.84776-1-khalid.aziz@oracle.com>
        <87o7mibfj0.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <7616301d-d7a7-bfb4-234b-eb83fb248cac@oracle.com>
Date:   Fri, 19 May 2023 08:19:28 +0800
In-Reply-To: <7616301d-d7a7-bfb4-234b-eb83fb248cac@oracle.com> (Khalid Aziz's
        message of "Thu, 18 May 2023 09:07:46 -0600")
Message-ID: <87pm6x6ulr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Khalid Aziz <khalid.aziz@oracle.com> writes:

> On 5/17/23 19:21, Huang, Ying wrote:
>> Khalid Aziz <khalid.aziz@oracle.com> writes:
>> 
>>> Pages pinned in memory through extra refcounts can not be migrated.
>>> Currently as isolate_migratepages_block() scans pages for
>>> compaction, it skips any pinned anonymous pages. All non-migratable
>>> pages should be skipped and not just the anonymous pinned pages.
>>> This patch adds a check for extra refcounts on a page to determine
>>> if the page can be migrated.  This was seen as a real issue on a
>>> customer workload where a large number of pages were pinned by vfio
>>> on the host and any attempts to allocate hugepages resulted in
>>> significant amount of cpu time spent in either direct compaction or
>>> in kcompactd scanning vfio pinned pages over and over again that can
>>> not be migrated.
>>>
>>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>>> Suggested-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>> v3:
>>> 	- Account for extra ref added by get_page_unless_zero() earlier
>>> 	  in isolate_migratepages_block() (Suggested by Huang, Ying)
>>> 	- Clean up computation of extra refs to be consistent
>>> 	  (Suggested by Huang, Ying)
>>>
>>> v2:
>>> 	- Update comments in the code (Suggested by Andrew)
>>> 	- Use PagePrivate() instead of page_has_private() (Suggested
>>> 	  by Matthew)
>>> 	- Pass mapping to page_has_extrarefs() (Suggested by Matthew)
>>> 	- Use page_ref_count() (Suggested by Matthew)
>>> 	- Rename is_pinned_page() to reflect its function more
>>> 	  accurately (Suggested by Matthew)
>>>
>>>   mm/compaction.c | 36 ++++++++++++++++++++++++++++++++----
>>>   1 file changed, 32 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>> index 5a9501e0ae01..f04c00981172 100644
>>> --- a/mm/compaction.c
>>> +++ b/mm/compaction.c
>>> @@ -764,6 +764,34 @@ static bool too_many_isolated(pg_data_t *pgdat)
>>>   	return too_many;
>>>   }
>>>   +/*
>>> + * Check if this base page should be skipped from isolation because
>>> + * it has extra refcounts that will prevent it from being migrated.
>> This appears duplicated with the comments in caller.  It's OK to
>> keep
>> one only?
>
> I don't see any harm in explaining what the function is doing and then
> why this function is being called. This allows one to understand code
> in either place without having to refer to the function and function
> call both to understand what the code is doing.

Duplicated comments will waste reader's time.

>> 
>>> + * This function is called for regular pages only, and not
>>> + * for THP or hugetlbfs pages. This code is inspired by similar code
>>> + * in migrate_vma_check_page(), can_split_folio() and
>>> + * folio_migrate_mapping()
>> It's not good to duplicate code.  Why not just use
>> folio_expected_refs()?
>
> compaction.c has not been converted over to folios, so I want to not
> do piecemeal conversion. When compaction code is converted over, it
> would make sense to see if this could also use the folio function.
> folio_expected_refs() currently is a static function in mm/migrate.c.

page_folio() is handy.

Best Regards,
Huang, Ying

>> 
>>> + */
>>> +static inline bool page_has_extra_refs(struct page *page)
>>> +{
>>> +	/* caller holds a ref already from get_page_unless_zero() */
>>> +	unsigned long extra_refs = 1;
>>> +
>>> +	/* anonymous page can have extra ref from swap cache */
>>> +	if (PageAnon(page))
>>> +		extra_refs += PageSwapCache(page) ? 1 : 0;
>>> +	else
>>> +		extra_refs += 1 + PagePrivate(page);
>>> +
>>> +	/*
>>> +	 * This is an admittedly racy check but good enough to determine
>>> +	 * if a page is pinned and can not be migrated
>>> +	 */
>>> +	if ((page_ref_count(page) - extra_refs) > page_mapcount(page))
>>> +		return true;
>>> +	return false;
>>> +}
>>> +
>>>   /**
>>>    * isolate_migratepages_block() - isolate all migrate-able pages within
>>>    *				  a single pageblock
>>> @@ -992,12 +1020,12 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>>   			goto isolate_fail;
>>>     		/*
>>> -		 * Migration will fail if an anonymous page is pinned in memory,
>>> -		 * so avoid taking lru_lock and isolating it unnecessarily in an
>>> -		 * admittedly racy check.
>>> +		 * Migration will fail if a page has extra refcounts
>>> +		 * preventing it from migrating, so avoid taking
>>> +		 * lru_lock and isolating it unnecessarily
>>>   		 */
>>>   		mapping = page_mapping(page);
>>> -		if (!mapping && (page_count(page) - 1) > total_mapcount(page))
>>> +		if (page_has_extra_refs(page))
>>>   			goto isolate_fail_put;
>>>     		/*

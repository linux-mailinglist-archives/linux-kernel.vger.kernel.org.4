Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E447D661F2B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjAIHYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbjAIHYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:24:18 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CDD1260F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 23:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673249057; x=1704785057;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=7IuvSph9kr4u0JaBkExjjY/5PCAEw1jXvnA0UpXIL2Y=;
  b=AOJtAEf9nOdyA0BAGR4/zK+x+F7yxnlw3K/VgeE/fTk4B7LwC/WWtRtG
   ay6PNr0Ohl3P5C2t13eFpIPB+jg5R2NTIethToT9VnnD09D2pfRADqCGG
   7V1J52/WTmxRMc3P5ruYbXMkMG+XVOM5gqjxEG9OQwN6GDNBjUd3lgx/r
   HF71NhjHGvNFmxPKzqA22Qz5E0ZpNHfdp1Hj2Sn0QDNfoKbHGRZqn+qSS
   lj10WNTqTAqiExxrnJfoPg/jWtvMUUEpmeVvgFdl22/gmXLiKfttT42/L
   UZyahAytgdAC3+g71mwAQsFt9YtEG5fG7qfYg0YnFCssOAqImZ7vZkpEr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="350023791"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="350023791"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 23:24:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="725072753"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="725072753"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 23:24:13 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Oscar Salvador" <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        "Bharata B Rao" <bharata@amd.com>, haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 2/8] migrate_pages: separate hugetlb folios migration
References: <20221227002859.27740-1-ying.huang@intel.com>
        <20221227002859.27740-3-ying.huang@intel.com>
        <87pmbttxmj.fsf@nvidia.com>
        <87pmbtedfp.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <877cy1scg5.fsf@nvidia.com>
        <87k021bfpj.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87y1qhqv5k.fsf@nvidia.com>
Date:   Mon, 09 Jan 2023 15:23:03 +0800
In-Reply-To: <87y1qhqv5k.fsf@nvidia.com> (Alistair Popple's message of "Thu,
        05 Jan 2023 18:39:59 +1100")
Message-ID: <87fsck5fzc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Popple <apopple@nvidia.com> writes:

> "Huang, Ying" <ying.huang@intel.com> writes:
>
>> [snip]
>>
>>>
>>>>>> @@ -1462,30 +1549,28 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>>>>  		nr_retry_pages = 0;
>>>>>>  
>>>>>>  		list_for_each_entry_safe(folio, folio2, from, lru) {
>>>>>> +			if (folio_test_hugetlb(folio)) {
>>>>>
>>>>> How do we hit this case? Shouldn't migrate_hugetlbs() have already moved
>>>>> any hugetlb folios off the from list?
>>>>
>>>> Retried hugetlb folios will be kept in from list.
>>>
>>> Couldn't migrate_hugetlbs() remove the failing retried pages from the
>>> list on the final pass? That seems cleaner to me.
>>
>> To do that, we need to go through the folio list again to remove all
>> hugetlb pages.  It could be time-consuming in some cases.  So I think
>> that it's better to keep this.
>
> Why? Couldn't we test pass == 9 and remove it from the list if it fails
> the final retry in migrate_hugetlbs()? In any case if it's on the list
> due to failed retries we have already passed over it 10 times, so the
> extra loop hardly seems like a problem.

Yes.  That's possible.  But "test pass == 9" looks more tricky than the
current code.

Feel free to change the code as you suggested on top this series.  If no
others object, I'm OK with that.  OK?

Best Regards,
Huang, Ying

>>
>>>>>> +				list_move_tail(&folio->lru, &ret_folios);
>>>>>> +				continue;
>>>>>> +			}
>>>>>> +
>>>>>>  			/*
>>>>>>  			 * Large folio statistics is based on the source large
>>>>>>  			 * folio. Capture required information that might get
>>>>>>  			 * lost during migration.
>>>>>>  			 */
>>>>>> -			is_large = folio_test_large(folio) && !folio_test_hugetlb(folio);
>>>>>> +			is_large = folio_test_large(folio);
>>>>>>  			is_thp = is_large && folio_test_pmd_mappable(folio);
>>>>>>  			nr_pages = folio_nr_pages(folio);
>>>>>> +
>>>>>>  			cond_resched();
>>>>>>  
>>>>>> -			if (folio_test_hugetlb(folio))
>>>>>> -				rc = unmap_and_move_huge_page(get_new_page,
>>>>>> -						put_new_page, private,
>>>>>> -						&folio->page, pass > 2, mode,
>>>>>> -						reason,
>>>>>> -						&ret_folios);
>>>>>> -			else
>>>>>> -				rc = unmap_and_move(get_new_page, put_new_page,
>>>>>> -						private, folio, pass > 2, mode,
>>>>>> -						reason, &ret_folios);
>>>>>> +			rc = unmap_and_move(get_new_page, put_new_page,
>>>>>> +					    private, folio, pass > 2, mode,
>>>>>> +					    reason, &ret_folios);
>>>>>>  			/*
>>>>>>  			 * The rules are:
>>>>>> -			 *	Success: non hugetlb folio will be freed, hugetlb
>>>>>> -			 *		 folio will be put back
>>>>>> +			 *	Success: folio will be freed
>>>>>>  			 *	-EAGAIN: stay on the from list
>>>>>>  			 *	-ENOMEM: stay on the from list
>>>>>>  			 *	-ENOSYS: stay on the from list
>>>>>> @@ -1512,7 +1597,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>>>>  						stats.nr_thp_split += is_thp;
>>>>>>  						break;
>>>>>>  					}
>>>>>> -				/* Hugetlb migration is unsupported */
>>>>>>  				} else if (!no_split_folio_counting) {
>>>>>>  					nr_failed++;
>>>>>>  				}

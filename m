Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B91074CC49
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjGJFjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGJFjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:39:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53476B3
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 22:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688967555; x=1720503555;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Ys8L0Hbye36COw2RYLz/SroMuaxGWFfQb1sQCRJw2nM=;
  b=VbnklF0YH6N5cAfiENU33UHWPYZd1mYJ9/Kcn7bmfCNmYMuapUywq5i3
   kr37IArI4ZABCWUKrM3N9GikaljKOR3vRjINsyNsg4qlUilzAVVT8Juho
   G+RLtrCFVlHA9AOt0wUFNw1xsJEhf6NG0lmyOtuqI+dMaXvfF/gqoxEzv
   EEp7hmsbFRPNYVYffkEPx8ZtdIqYhczcbWRf08egcvxMr4d9KiM9F3mHt
   ozLgfn+DXCC+RhwKlyWQNu0MOeMUo0ruTDE/tkzinQj1ZaJ8UCTvkDZ8O
   ZfTGbDaTuOW+6PPctC7Wz7nqxc5uEEo0EDXwLFS9ds8dFqkEoQZZTN8S+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="366839046"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="366839046"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 22:39:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="967312758"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="967312758"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 22:39:11 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        "David Hildenbrand" <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v2 2/5] mm: Allow deferred splitting of arbitrary large
 anon folios
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
        <20230703135330.1865927-3-ryan.roberts@arm.com>
        <877crcgmj1.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <6379dd13-551e-3c73-422a-56ce40b27deb@arm.com>
Date:   Mon, 10 Jul 2023 13:37:24 +0800
In-Reply-To: <6379dd13-551e-3c73-422a-56ce40b27deb@arm.com> (Ryan Roberts's
        message of "Fri, 7 Jul 2023 10:42:26 +0100")
Message-ID: <87ttucfht7.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Ryan Roberts <ryan.roberts@arm.com> writes:

> Somehow I managed to reply only to the linux-arm-kernel list on first attempt so
> resending:
>
> On 07/07/2023 09:21, Huang, Ying wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> 
>>> With the introduction of large folios for anonymous memory, we would
>>> like to be able to split them when they have unmapped subpages, in order
>>> to free those unused pages under memory pressure. So remove the
>>> artificial requirement that the large folio needed to be at least
>>> PMD-sized.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>>> ---
>>>  mm/rmap.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 82ef5ba363d1..bbcb2308a1c5 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1474,7 +1474,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>>>  		 * page of the folio is unmapped and at least one page
>>>  		 * is still mapped.
>>>  		 */
>>> -		if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
>>> +		if (folio_test_large(folio) && folio_test_anon(folio))
>>>  			if (!compound || nr < nr_pmdmapped)
>>>  				deferred_split_folio(folio);
>>>  	}
>> 
>> One possible issue is that even for large folios mapped only in one
>> process, in zap_pte_range(), we will always call deferred_split_folio()
>> unnecessarily before freeing a large folio.
>
> Hi Huang, thanks for reviewing!
>
> I have a patch that solves this problem by determining a range of ptes covered
> by a single folio and doing a "batch zap". This prevents the need to add the
> folio to the deferred split queue, only to remove it again shortly afterwards.
> This reduces lock contention and I can measure a performance improvement for the
> kernel compilation benchmark. See [1].
>
> However, I decided to remove it from this patch set on Yu Zhao's advice. We are
> aiming for the minimal patch set to start with and wanted to focus people on
> that. I intend to submit it separately later on.
>
> [1] https://lore.kernel.org/linux-mm/20230626171430.3167004-8-ryan.roberts@arm.com/

Thanks for your information!  "batch zap" can solve the problem.

And, I agree with Matthew's comments to fix the large folios interaction
issues before merging the patches to allocate large folios as in the
following email.

https://lore.kernel.org/linux-mm/ZKVdUDuwNWDUCWc5@casper.infradead.org/

If so, we don't need to introduce the above problem or a large patchset.

Best Regards,
Huang, Ying

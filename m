Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB417615763
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKBCMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKBCMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:12:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A611EC77
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 19:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667355127; x=1698891127;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=MI6zhkObRenGpcSUR87/Sz4mYR5sSxARjEOEUywXhME=;
  b=ND4P5zXzzBpYAaaCwk5TTJOLQfAe1FNEpzWUnwSsTL1BE85ciuHKnefE
   gA6uz4sJuo721jkJZq2dOt4RD0l0nIymPG4QGVD66WdSLcbwJOZ5vX/IR
   TcS6F1c0RlfsFWbS74AeYJUAEMXJFjXhp4f4byv7r8PlXlF7pj+UuMdgn
   OsF0KQeObvzUtz/MfvarlTm6CzGBMT0FowJoPDkNsbPmslous4XoK7gug
   gTiS+77mcwWKoghXh2iYF5SqnKnBBNTsWS9gl/MeGC9JGcNozM+y0zmmK
   ErK3mEElAE2BdfxNWdyfUVAsWSBJL81wyOTiH2o2RrMzcWoePrOPZ5DUo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="395602225"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="395602225"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 19:12:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="739563098"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="739563098"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 19:12:05 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     <linux-mm@kvack.org>, Matthew Wilcox <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC 1/2] migrate: convert unmap_and_move() to use folios
References: <20221101062137.83649-1-ying.huang@intel.com>
        <20221101062137.83649-2-ying.huang@intel.com>
        <E53AAFFD-C10D-44AE-BD20-47BC7037BCC1@nvidia.com>
Date:   Wed, 02 Nov 2022 10:11:26 +0800
In-Reply-To: <E53AAFFD-C10D-44AE-BD20-47BC7037BCC1@nvidia.com> (Zi Yan's
        message of "Tue, 01 Nov 2022 10:54:48 -0400")
Message-ID: <87y1suaywh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zi Yan <ziy@nvidia.com> writes:

> On 1 Nov 2022, at 2:21, Huang Ying wrote:
>
>> Quite straightforward, the page functions are converted to
>> corresponding folio functions.  Same for comments.
>>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> ---
>>  mm/migrate.c | 54 ++++++++++++++++++++++++++--------------------------
>>  1 file changed, 27 insertions(+), 27 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index dff333593a8a..e625fd84b824 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1150,79 +1150,79 @@ static int __unmap_and_move(struct folio *src, struct folio *dst,
>>  }
>>
>>  /*
>> - * Obtain the lock on page, remove all ptes and migrate the page
>> - * to the newly allocated page in newpage.
>> + * Obtain the lock on folio, remove all ptes and migrate the folio
>> + * to the newly allocated folio in dst.
>>   */
>>  static int unmap_and_move(new_page_t get_new_page,
>>  				   free_page_t put_new_page,
>> -				   unsigned long private, struct page *page,
>> +				   unsigned long private, struct folio *src,
>>  				   int force, enum migrate_mode mode,
>>  				   enum migrate_reason reason,
>>  				   struct list_head *ret)
>>  {
>> -	struct folio *dst, *src = page_folio(page);
>> +	struct folio *dst;
>>  	int rc = MIGRATEPAGE_SUCCESS;
>>  	struct page *newpage = NULL;
>>
>> -	if (!thp_migration_supported() && PageTransHuge(page))
>> +	if (!thp_migration_supported() && folio_test_large(src))
>
> folio_test_transhuge() should be used.

Sure.  Will change.

>>  		return -ENOSYS;
>>
>> -	if (page_count(page) == 1) {
>> -		/* Page was freed from under us. So we are done. */
>> -		ClearPageActive(page);
>> -		ClearPageUnevictable(page);
>> +	if (folio_ref_count(src) == 1) {
>> +		/* Folio was freed from under us. So we are done. */
>> +		folio_clear_active(src);
>> +		folio_clear_unevictable(src);
>>  		/* free_pages_prepare() will clear PG_isolated. */
>>  		goto out;
>>  	}
>>
>> -	newpage = get_new_page(page, private);
>> +	newpage = get_new_page(&src->page, private);
>>  	if (!newpage)
>>  		return -ENOMEM;
>>  	dst = page_folio(newpage);
>>
>> -	newpage->private = 0;
>> +	dst->private = 0;
>>  	rc = __unmap_and_move(src, dst, force, mode);
>>  	if (rc == MIGRATEPAGE_SUCCESS)
>> -		set_page_owner_migrate_reason(newpage, reason);
>> +		set_page_owner_migrate_reason(&dst->page, reason);
>>
>>  out:
>>  	if (rc != -EAGAIN) {
>>  		/*
>> -		 * A page that has been migrated has all references
>> -		 * removed and will be freed. A page that has not been
>> +		 * A folio that has been migrated has all references
>> +		 * removed and will be freed. A folio that has not been
>>  		 * migrated will have kept its references and be restored.
>>  		 */
>> -		list_del(&page->lru);
>> +		list_del(&src->lru);
>>  	}
>>
>>  	/*
>>  	 * If migration is successful, releases reference grabbed during
>> -	 * isolation. Otherwise, restore the page to right list unless
>> +	 * isolation. Otherwise, restore the folio to right list unless
>>  	 * we want to retry.
>>  	 */
>>  	if (rc == MIGRATEPAGE_SUCCESS) {
>>  		/*
>> -		 * Compaction can migrate also non-LRU pages which are
>> +		 * Compaction can migrate also non-LRU folios which are
>>  		 * not accounted to NR_ISOLATED_*. They can be recognized
>> -		 * as __PageMovable
>> +		 * as __folio_test_movable
>>  		 */
>> -		if (likely(!__PageMovable(page)))
>> -			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
>> -					page_is_file_lru(page), -thp_nr_pages(page));
>> +		if (likely(!__folio_test_movable(src)))
>> +			mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
>> +					folio_is_file_lru(src), -folio_nr_pages(src));
>>
>>  		if (reason != MR_MEMORY_FAILURE)
>>  			/*
>> -			 * We release the page in page_handle_poison.
>> +			 * We release the folio in page_handle_poison.
>>  			 */
>> -			put_page(page);
>> +			folio_put(src);
>>  	} else {
>>  		if (rc != -EAGAIN)
>> -			list_add_tail(&page->lru, ret);
>> +			list_add_tail(&src->lru, ret);
>>
>>  		if (put_new_page)
>> -			put_new_page(newpage, private);
>> +			put_new_page(&dst->page, private);
>>  		else
>> -			put_page(newpage);
>> +			folio_put(dst);
>>  	}
>>
>>  	return rc;
>> @@ -1459,7 +1459,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  						&ret_pages);
>>  			else
>>  				rc = unmap_and_move(get_new_page, put_new_page,
>> -						private, page, pass > 2, mode,
>> +						private, page_folio(page), pass > 2, mode,
>>  						reason, &ret_pages);
>>  			/*
>>  			 * The rules are:
>> -- 
>> 2.35.1
>
> Everything else looks good to me.

Thanks!

Best Regards,
Huang, Ying

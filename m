Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECE261575C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKBCLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiKBCLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:11:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1021F2C0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 19:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667355078; x=1698891078;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=O6XTGElfGoUAX2ClG0cppHS3e2wQBWvL3CUDavNdeKk=;
  b=JIhHNitfqjqG8JTwkYg5PUbi20LuErEfdb56vXyZE6DPgmXDnLec/rI1
   KSQs709gQNXJ3+P993GdIcJZdY7S6dkFztazbPnw9zsgKKypmfXCxnWXf
   Q28U6NfK2Z+6TpMtJs7rsCOPY56UIfuFl2AYzV/+JkQbd5tigWueS5zl0
   Hx3KvGvlvVqiHLmbgnz1EOo0EuVBV3awmv/uOnMzVMsSGHqElOkZAFXX3
   rnCABbis5HwxNIdwRJT0C5pnCUA/R/dVCD2Ucvknf61zYd6+U1V3RpZsf
   l66C1vouzi/axjqckKJ1w+dMZZLEQ+dn5kBRqljsHzreKt2yDzPyLLgTN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="289679550"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="289679550"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 19:11:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="776716072"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="776716072"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 19:11:16 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC 2/2] migrate: convert migrate_pages() to use folios
References: <20221101062137.83649-1-ying.huang@intel.com>
        <20221101062137.83649-3-ying.huang@intel.com>
        <Y2EY9zK0phgfQYE1@casper.infradead.org>
Date:   Wed, 02 Nov 2022 10:10:37 +0800
In-Reply-To: <Y2EY9zK0phgfQYE1@casper.infradead.org> (Matthew Wilcox's message
        of "Tue, 1 Nov 2022 13:02:47 +0000")
Message-ID: <8735b2cdia.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Matthew Wilcox <willy@infradead.org> writes:

> On Tue, Nov 01, 2022 at 02:21:37PM +0800, Huang Ying wrote:
>> -			is_thp = PageTransHuge(page) && !PageHuge(page);
>> -			nr_subpages = compound_nr(page);
>> +			is_large = folio_test_large(folio) && !PageHuge(&folio->page);
>
> We have folio_test_hugetlb() to replace PageHuge().

Thanks!  Will change this in the next version.

>>  	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
>>  	count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
>> -	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
>> -	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
>> -	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
>> -	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_thp_succeeded,
>> -			       nr_thp_failed, nr_thp_split, mode, reason);
>> +	count_vm_events(THP_MIGRATION_SUCCESS, nr_large_succeeded);
>> +	count_vm_events(THP_MIGRATION_FAIL, nr_large_failed);
>> +	count_vm_events(THP_MIGRATION_SPLIT, nr_split);
>> +	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_large_succeeded,
>> +			       nr_large_failed, nr_split, mode, reason);
>
> I think this is the biggest question with this patch -- how (or whether)
> to account folios in size between PMD and PTE size.  Since it's
> _called_ THP, I've tended to make the statistics conditional on
> folio_test_pmd_mappable() rather than simply being folio_test_large().

Yes.  This is my biggest concern during development too.  In the next
version, I will distinguish THP and other large folios (between PMD and
PTE size) and do statistics accordingly.

Best Regards,
Huang, Ying

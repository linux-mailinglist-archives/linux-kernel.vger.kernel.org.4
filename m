Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743016A678E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 07:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCAGKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 01:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjCAGKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 01:10:07 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F7E30EB5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 22:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677651005; x=1709187005;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=WWshl4dK3+R9OwEb435b+D4HXgqFVC207zqrd+7KQQc=;
  b=l9XkYa9YyslmZeIVPCYgEqsp5bKMkfJ8Xr/MQw3AW6EqswsSCMYmsLC6
   Z5EufiRdBsLsHPoUAqmedY+eKBGg485nsUcFzVQJcsU+m9/GUaKtSORPF
   MBoYisJpvQH88O6H9lSPvowM3P1EsBUWe7vBCy3o3PWsq87DZfZhFJIua
   z25cD1w/5g/kopQc0HdBTc155QabsLaRRNJJ/tT//MJNCgKzmylBah714
   dn9j/3RiGMfZdegufrbKQu+NXahz5ytem6ZcAjuQbqrXBaD2BFKPHQOVg
   gqjIPBg0KNHJft5DuWXab9/T+F+8D4unyy/HIoijakrN3xuMQIxl98Tsl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="396897799"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="396897799"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 22:10:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="651878705"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="651878705"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 22:10:01 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Xu, Pengfei" <pengfei.xu@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefan Roesch <shr@devkernel.io>, Tejun Heo <tj@kernel.org>,
        Xin Hao <xhao@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 3/3] migrate_pages: try migrate in batch asynchronously
 firstly
References: <20230224141145.96814-1-ying.huang@intel.com>
        <20230224141145.96814-4-ying.huang@intel.com>
        <bdc873-3367-9aa7-79c6-91c68fecac41@google.com>
        <87cz5ub5dr.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <070f71-9af-c29a-30b9-758b5cdf6766@google.com>
Date:   Wed, 01 Mar 2023 14:08:56 +0800
In-Reply-To: <070f71-9af-c29a-30b9-758b5cdf6766@google.com> (Hugh Dickins's
        message of "Tue, 28 Feb 2023 13:22:59 -0800 (PST)")
Message-ID: <874jr5atqf.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hughd@google.com> writes:

> On Tue, 28 Feb 2023, Huang, Ying wrote:
>> Hugh Dickins <hughd@google.com> writes:
>> > On Fri, 24 Feb 2023, Huang Ying wrote:
>> >> 
>> >> diff --git a/mm/migrate.c b/mm/migrate.c
>> >> index 91198b487e49..c17ce5ee8d92 100644
>> >> --- a/mm/migrate.c
>> >> +++ b/mm/migrate.c
>> >> @@ -1843,6 +1843,51 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>> >>  	return rc;
>> >>  }
>> >>  
>> >> +static int migrate_pages_sync(struct list_head *from, new_page_t get_new_page,
>> >> +		free_page_t put_new_page, unsigned long private,
>> >> +		enum migrate_mode mode, int reason, struct list_head *ret_folios,
>> >> +		struct list_head *split_folios, struct migrate_pages_stats *stats)
>> >> +{
>> >> +	int rc, nr_failed = 0;
>> >> +	LIST_HEAD(folios);
>> >> +	struct migrate_pages_stats astats;
>> >> +
>> >> +	memset(&astats, 0, sizeof(astats));
>> >> +	/* Try to migrate in batch with MIGRATE_ASYNC mode firstly */
>> >> +	rc = migrate_pages_batch(from, get_new_page, put_new_page, private, MIGRATE_ASYNC,
>> >> +				 reason, &folios, split_folios, &astats,
>> >> +				 NR_MAX_MIGRATE_PAGES_RETRY);
>> >
>> > I wonder if that and below would better be NR_MAX_MIGRATE_PAGES_RETRY / 2.
>> >
>> > Though I've never got down to adjusting that number (and it's not a job
>> > to be done in this set of patches), those 10 retries sometimes terrify
>> > me, from a latency point of view.  They can have such different weights:
>> > in the unmapped case, 10 retries is okay; but when a pinned page is mapped
>> > into 1000 processes, the thought of all that unmapping and TLB flushing
>> > and remapping is terrifying.
>> >
>> > Since you're retrying below, halve both numbers of retries for now?
>> 
>> Yes.  These are reasonable concerns.
>> 
>> And in the original implementation, we only wait to lock page and wait
>> the writeback to complete if pass > 2.  This is kind of trying to
>> migrate asynchronously for 3 times before the real synchronous
>> migration.  So, should we delete the "force" logic (in
>> migrate_folio_unmap()), and try to migrate asynchronously for 3 times in
>> batch before migrating synchronously for 7 times one by one?
>
> Oh, that's a good idea (but please don't imagine I've thought it through):
> I hadn't realized the way in which your migrate_pages_sync() addition is
> kind of duplicating the way that the "force" argument conditions behaviour,
> It would be very appealing to delete the "force" argument now if you can.

Sure.  Will do that in the next version.

> But aside from that, you've also made me wonder (again, please remember I
> don't have a good picture of the new migrate_pages() sequence in my head)
> whether you have already made a *great* strike against my 10 retries
> terror.  Am I reading it right, that the unmapping is now done on the
> first try, and the remove_migration_ptes after the last try (all the
> pages involved having remained locked throughout)?

Yes.  You are right.  Now, unmapping and moving are two separate steps,
and they are retried separately.  After a folio has been unmapped
successfully, we will not remap/unmap it 10 times if the folio is pinned
so that failed to move (migrate_folio_move()).  So the latency caused by
retrying is much better now.  But I still tend to keep the total retry
number as before.  Do you agree?

Best Regards,
Huang, Ying

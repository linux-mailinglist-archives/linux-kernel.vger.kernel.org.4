Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50EE5E57E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIVBQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiIVBP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:15:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59372AA4E3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 18:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663809320; x=1695345320;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=JJj1wIiwpnC3/y7bxztkVaqbmNboYLIvqTym1Ql1Hpw=;
  b=drJiWQwrhDICuhT4ch1JQ/qj4dY5InE+dFsFNyT1QsLsE5BdVgvFzMKG
   lNmFjc9Zk5Kuwhg0NlwcK0TKQdM9XuO56R4/LdNXPRsz5FVZVHTV++Hub
   W30jYmWWvF3k2jJz7XFLDU/1ZqnxewA3R/3Y/HLDL5Zd6fYqepbOh1LX0
   Pakj9dt5B5CO7ciR5Wowi3cmzBybxEhOrb14A4BPTsIPqwWCsftGgKnPh
   265ZDl8msaLqU9NdavZt5uDWITiopiQlhoK1EVNP89TdkdX/gv95ClEti
   gIaLccfTY9GtNtWafhoZmiw0ItaYUhTBlRWdlmyMZbyaPT4YK2MaxKfKU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="301010120"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="301010120"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 18:15:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="761985649"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 18:15:09 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Matthew Wilcox" <willy@infradead.org>
Subject: Re: [RFC 2/6] mm/migrate_pages: split unmap_and_move() to _unmap()
 and _move()
References: <20220921060616.73086-1-ying.huang@intel.com>
        <20220921060616.73086-3-ying.huang@intel.com>
        <9AF1028D-D939-4F20-9830-F60FEAC6152C@nvidia.com>
Date:   Thu, 22 Sep 2022 09:15:09 +0800
In-Reply-To: <9AF1028D-D939-4F20-9830-F60FEAC6152C@nvidia.com> (Zi Yan's
        message of "Wed, 21 Sep 2022 12:08:29 -0400")
Message-ID: <87illgky5e.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Zi Yan <ziy@nvidia.com> writes:

> On 21 Sep 2022, at 2:06, Huang Ying wrote:
>
>> This is a preparation patch to batch the page unmapping and moving
>> for the normal pages and THP.
>>
>> In this patch, unmap_and_move() is split to migrate_page_unmap() and
>> migrate_page_move().  So, we can batch _unmap() and _move() in
>> different loops later.  To pass some information between unmap and
>> move, the original unused newpage->mapping and newpage->private are
>> used.
>>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> ---
>>  mm/migrate.c | 164 ++++++++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 122 insertions(+), 42 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 117134f1c6dc..4a81e0bfdbcd 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -976,13 +976,32 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
>>  	return rc;
>>  }
>>
>> -static int __unmap_and_move(struct page *page, struct page *newpage,
>> +static void __migrate_page_record(struct page *newpage,
>> +				  int page_was_mapped,
>> +				  struct anon_vma *anon_vma)
>> +{
>> +	newpage->mapping = (struct address_space *)anon_vma;
>> +	newpage->private = page_was_mapped;
>> +}
>> +
>> +static void __migrate_page_extract(struct page *newpage,
>> +				   int *page_was_mappedp,
>> +				   struct anon_vma **anon_vmap)
>> +{
>> +	*anon_vmap = (struct anon_vma *)newpage->mapping;
>> +	*page_was_mappedp = newpage->private;
>> +	newpage->mapping = NULL;
>> +	newpage->private = 0;
>> +}
>> +
>> +#define MIGRATEPAGE_UNMAP		1
>
> It is better to move this to migrate.h with MIGRATEPAGE_SUCCESS and
> make them an enum.

Make sense!  Will do this in the next version.

Best Regards,
Huang, Ying

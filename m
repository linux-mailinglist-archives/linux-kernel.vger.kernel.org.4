Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B505565B831
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 00:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbjABXa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 18:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbjABXax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 18:30:53 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CC4C1F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 15:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672702252; x=1704238252;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=GfRdTCqFw3/YOwKfNj0pyl2bOMS0Gwt3rwu1Fi2bRcM=;
  b=NHMueCU2gurLL1Nw2Ol6qQMBuyQapTkPNFmY1OUqh+gsClaaJnoBFrbo
   ZiuihQAa+SxKX1XJd3Eq2X2AUlppOElpkh5H+tOzEluNjX8XRKw/Q/aXW
   5JPZ0ylwbny4y2V4BOgnZHqQIUkXk2+xqV3HW0L6ZpOEd7jDmUsnDkZwz
   1UdKLRTHFCtomxDUJIXxEm9XVLUFolKJ4PHZuCkXoMGt9zGnrYXO9EP5O
   tsXaiebqsh1o/sPKg6hnB3pTZFFGm6RRv7i0jMulHhHWYiNVve+8VfM2r
   HNYoEQUsERBvDMcmLqzTucpPIwoB2l6UjaGUM2SuaIpQ9jMoNSlkwgez3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="385985861"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="385985861"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 15:30:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="604640922"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="604640922"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 15:30:42 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 5/8] migrate_pages: batch _unmap and _move
References: <20221227002859.27740-1-ying.huang@intel.com>
        <20221227002859.27740-6-ying.huang@intel.com>
        <20221228152206.52435aef4072c4cad9087541@linux-foundation.org>
Date:   Tue, 03 Jan 2023 07:29:42 +0800
In-Reply-To: <20221228152206.52435aef4072c4cad9087541@linux-foundation.org>
        (Andrew Morton's message of "Wed, 28 Dec 2022 15:22:06 -0800")
Message-ID: <87edscy0pl.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue, 27 Dec 2022 08:28:56 +0800 Huang Ying <ying.huang@intel.com> wrote:
>
>> In this patch the _unmap and _move stage of the folio migration is
>> batched.  That for, previously, it is,
>> 
>>   for each folio
>>     _unmap()
>>     _move()
>> 
>> Now, it is,
>> 
>>   for each folio
>>     _unmap()
>>   for each folio
>>     _move()
>> 
>> Based on this, we can batch the TLB flushing and use some hardware
>> accelerator to copy folios between batched _unmap and batched _move
>> stages.
>> 
>> ...
>>
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1027,8 +1027,32 @@ static void __migrate_folio_extract(struct folio *dst,
>>  	dst->private = NULL;
>>  }
>>  
>> +static void migrate_folio_undo_src(struct folio *src,
>> +				   int page_was_mapped,
>> +				   struct anon_vma *anon_vma,
>> +				   struct list_head *ret)
>> +{
>> +	if (page_was_mapped)
>> +		remove_migration_ptes(src, src, false);
>> +	if (anon_vma)
>> +		put_anon_vma(anon_vma);
>> +	folio_unlock(src);
>> +	list_move_tail(&src->lru, ret);
>> +}
>> +
>> +static void migrate_folio_undo_dst(struct folio *dst,
>> +				   free_page_t put_new_page,
>> +				   unsigned long private)
>> +{
>> +	folio_unlock(dst);
>> +	if (put_new_page)
>> +		put_new_page(&dst->page, private);
>> +	else
>> +		folio_put(dst);
>> +}
>
> What do the above do?  Are they so obvious that no comments are needed?

Thank you for reminding, will add comments.

>
>>  static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>> -				int force, enum migrate_mode mode)
>> +				 int force, bool force_lock, enum migrate_mode mode)
>>  {
>>  	int rc = -EAGAIN;
>>  	int page_was_mapped = 0;
>> @@ -1055,6 +1079,11 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>>  		if (current->flags & PF_MEMALLOC)
>>  			goto out;
>>  
>> +		if (!force_lock) {
>> +			rc = -EDEADLOCK;
>> +			goto out;
>> +		}
>
> Please document the use of EDEADLOCK in this code.  What does it signify?

Sure.  Will do that in the next version.

Best Regards,
Huang, Ying

>>  		folio_lock(src);
>>  	}
>>  

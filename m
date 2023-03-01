Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B946A649D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCABTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCABTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:19:02 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2021B6590
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 17:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677633541; x=1709169541;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=fZsB5bJfnU6ahxA81sxhKotfuRk7A5vALSgv3ixDuQw=;
  b=MZI+8+iupYTeeRNTppzEdKPwW8GhCosXijJrH8aYHyUvYMUugz5Z04E7
   hXa59kSqZr0QAxCHZTt8hKC+I6X6a6763lFC+60paxl561954pbchUCjR
   ubTEKMrZIOzuUs9s71XUQkwvIHDoDu6eo1Uz0TtdqgE/ITIiISjfRYpwZ
   kYFHne/meoOYW5blKGyqCLZolwl+X4zQQielPFmAUISCXZfsLe//7Iza3
   9Fobv6MpP9W3UKneIH7JM7T5W5nu/l6zzHuiWtrQJaKMGdhGqFWaNLG6L
   DE5Og29PJSJP3ff65buZAFBu5D8Qc8wUpdYcpfiWbG9dgOBQUkRYmV51r
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="399073962"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="399073962"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 17:19:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="704632698"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="704632698"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 17:18:56 -0800
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
Subject: Re: [PATCH 1/3] migrate_pages: fix deadlock in batched migration
References: <20230224141145.96814-1-ying.huang@intel.com>
        <20230224141145.96814-2-ying.huang@intel.com>
        <ea4dc95a-e6b2-ff6-62df-1590b93269f@google.com>
        <87h6v6b6er.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <da5ba36a-dba-f44-926a-c5c912148b@google.com>
Date:   Wed, 01 Mar 2023 09:17:50 +0800
In-Reply-To: <da5ba36a-dba-f44-926a-c5c912148b@google.com> (Hugh Dickins's
        message of "Tue, 28 Feb 2023 13:07:41 -0800 (PST)")
Message-ID: <878rghb77l.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
>> >> @@ -1247,7 +1236,7 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
>> >>  		/* Establish migration ptes */
>> >>  		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
>> >>  			       !folio_test_ksm(src) && !anon_vma, src);
>> >> -		try_to_migrate(src, TTU_BATCH_FLUSH);
>> >> +		try_to_migrate(src, mode == MIGRATE_ASYNC ? TTU_BATCH_FLUSH : 0);
>> >
>> > Why that change, I wonder? The TTU_BATCH_FLUSH can still be useful for
>> > gathering multiple cross-CPU TLB flushes into one, even when it's only
>> > a single page in the batch.
>> 
>> Firstly, I would have thought that we have no opportunities to batch the
>> TLB flushing now.  But as you pointed out, it is still possible to batch
>> if mapcount > 1.  Secondly, without TTU_BATCH_FLUSH, we may flush the
>> TLB for a single page (with invlpg instruction), otherwise, we will
>> flush the TLB for all pages.  The former is faster and will not
>> influence other TLB entries of the process.
>> 
>> Or we use TTU_BATCH_FLUSH only if mapcount > 1?
>
> I had not thought at all of the "invlpg" advantage (which I imagine
> some other architectures than x86 share) to not delaying the TLB flush
> of a single PTE.
>
> Frankly, I just don't have any feeling for the tradeoff between
> multiple remote invlpgs versus one remote batched TLB flush of all.
> Which presumably depends on number of CPUs, size of TLBs, etc etc.
>
> Your "mapcount > 1" idea might be good, but I cannot tell: I'd say
> now that there's no reason to change your "mode == MIGRATE_ASYNC ?
> TTU_BATCH_FLUSH : 0" without much more thought, or a quick insight
> from someone else.  Some other time maybe.

Yes.  I think that this is reasonable.  We can revisit this later.

Best Regards,
Huang, Ying

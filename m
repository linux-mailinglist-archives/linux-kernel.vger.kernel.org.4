Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DD6666B87
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbjALHTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbjALHS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:18:58 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF97814D02
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673507935; x=1705043935;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=x1v7f6BMYNWzU0mcsYHL+JCdP7VIQOxKIM7YiNatl6Q=;
  b=QBMch84JOcwWQEAukrzHizoQdQwDLmRttC/+DnamAYthCofVi3gkmJYr
   d6G04RJdlb2AH8iQt9Bv35cPcX0eeywUPtmJV91egsp8nXWe34RigTq4J
   yl8Xn1+Jv0B1CeYosz8i5uniT/zPw6dT/WjYp66TIQPCYugceJeui8Tw6
   ZirUnQnEjJ4hlGEFc9MtSIyTcOLnq+gfWK1tf+djXX/xqZ4TJ68re1fJu
   Oga9ORPoJDngpqY0RslNJ4NZOu2uyclb3WDkvaJ/p9qBsPlEbibUiadbE
   emWHW1N5HnArHiSw1BmbD6ZbH+k9SPBqlRRv5w5sIxMaOVxb21mxap4Z8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="409872544"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="409872544"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 23:18:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="635275312"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="635275312"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 23:18:49 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH -v2 0/9] migrate_pages(): batch TLB flushing
References: <20230110075327.590514-1-ying.huang@intel.com>
        <Y74WsWCFGh2wFGji@monkey> <Y782h7t10uRVW0RC@monkey>
        <87a62oy5o9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y79tTXgEeuzzqFho@monkey>
Date:   Thu, 12 Jan 2023 15:17:56 +0800
In-Reply-To: <Y79tTXgEeuzzqFho@monkey> (Mike Kravetz's message of "Wed, 11 Jan
        2023 18:15:41 -0800")
Message-ID: <87ilhcrzkr.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Mike Kravetz <mike.kravetz@oracle.com> writes:

> On 01/12/23 08:09, Huang, Ying wrote:
>> Hi, Mike,
>> 
>> Mike Kravetz <mike.kravetz@oracle.com> writes:
>> 
>> > On 01/10/23 17:53, Mike Kravetz wrote:
>> >> Just saw the following easily reproducible issue on next-20230110.  Have not
>> >> verified it is related to/caused by this series, but it looks suspicious.
>> >
>> > Verified this is caused by the series,
>> >
>> > 734cbddcfe72 migrate_pages: organize stats with struct migrate_pages_stats
>> > to
>> > 323b933ba062 migrate_pages: batch flushing TLB
>> >
>> > in linux-next.
>> 
>> Thanks for reporting.
>> 
>> I tried this yesterday (next-20230111), but failed to reproduce it.  Can
>> you share your kernel config?  Is there any other setup needed?
>
> Config file is attached.

Thanks!

> Are you writing a REALLY big value to nr_hugepages?  By REALLY big I
> mean a value that is impossible to fulfill.  This will result in
> successful hugetlb allocations until __alloc_pages starts to fail.  At
> this point we will be stressing compaction/migration trying to find more
> contiguous pages.
>
> Not sure if it matters, but I am running on a 2 node VM.  The 2 nodes
> may be important as the hugetlb allocation code will try a little harder
> alternating between nodes that may perhaps stress compaction/migration
> more.

Tried again on a 2-node machine.  Still cannot reproduce it.

>> BTW: can you bisect to one specific commit which causes the bug in the
>> series?
>
> I should have some time to isolate in the next day or so.

Thanks!

Best Regards,
Huang, Ying

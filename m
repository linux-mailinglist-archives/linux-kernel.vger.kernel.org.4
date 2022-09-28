Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F245ED407
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 06:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiI1EyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 00:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiI1EyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 00:54:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E71AE848
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 21:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664340850; x=1695876850;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=f9MN350BGqDDYUQsEVdG+13gHJrSzXi+S20DhSnJekw=;
  b=P1Om4u7HFZRjbhmPBFzmeBgs/uYbqUAkfPQGYN3M1mxIw0HlttGRE8fk
   bsq/pElLjII67GAQuToRPaxuaS/0I6NmsBeInD6nkmpvlN/SjOXDrsxWT
   3TA5GrtBuQohjnjsfjAoEGP1wx8QIzm6zMaBf28fUAIvRYVbTZvFZNM2/
   xbBIHwLNM/PDO0IXJyMsQfPLWISLs+GBvQTx8Yfit51zrXe7jt2TssccK
   L0/jwJNTcLXlX6DXMyHxggz1gkm1Kxrzy9QE2s7+FQQGABPcWPdJoJvpr
   s5sl8v79ZgmELwiQkU9Z6+K6qfIL3roheVXd0XOe1W7j4uCEtWoyrvxZn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="300221865"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="300221865"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 21:54:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="572895866"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="572895866"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 21:54:04 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     haoxin <xhao@linux.alibaba.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Oscar Salvador" <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        <yangyicong@hisilicon.com>, <v-songbaohua@oppo.com>,
        <21cnbao@gmail.com>
Subject: Re: [RFC 0/6] migrate_pages(): batch TLB flushing
References: <20220921060616.73086-1-ying.huang@intel.com>
        <393d6318-aa38-01ed-6ad8-f9eac89bf0fc@linux.alibaba.com>
        <874jws2r6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <02e9da8a-39af-f6bd-b7f3-c60b3f2a59fb@linux.alibaba.com>
Date:   Wed, 28 Sep 2022 12:53:18 +0800
In-Reply-To: <02e9da8a-39af-f6bd-b7f3-c60b3f2a59fb@linux.alibaba.com>
        (haoxin's message of "Wed, 28 Sep 2022 11:33:13 +0800")
Message-ID: <87zgek14n5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

haoxin <xhao@linux.alibaba.com> writes:

> ( 2022/9/28 H10:01, Huang, Ying S:
>> haoxin <xhao@linux.alibaba.com> writes:
>>
>>> Hi, Huang
>>>
>>> ( 2022/9/21 H2:06, Huang Ying S:
>>>> From: "Huang, Ying" <ying.huang@intel.com>
>>>>
>>>> Now, migrate_pages() migrate pages one by one, like the fake code as
>>>> follows,
>>>>
>>>>     for each page
>>>>       unmap
>>>>       flush TLB
>>>>       copy
>>>>       restore map
>>>>
>>>> If multiple pages are passed to migrate_pages(), there are
>>>> opportunities to batch the TLB flushing and copying.  That is, we can
>>>> change the code to something as follows,
>>>>
>>>>     for each page
>>>>       unmap
>>>>     for each page
>>>>       flush TLB
>>>>     for each page
>>>>       copy
>>>>     for each page
>>>>       restore map
>>>>
>>>> The total number of TLB flushing IPI can be reduced considerably.  And
>>>> we may use some hardware accelerator such as DSA to accelerate the
>>>> page copying.
>>>>
>>>> So in this patch, we refactor the migrate_pages() implementation and
>>>> implement the TLB flushing batching.  Base on this, hardware
>>>> accelerated page copying can be implemented.
>>>>
>>>> If too many pages are passed to migrate_pages(), in the naive batched
>>>> implementation, we may unmap too many pages at the same time.  The
>>>> possibility for a task to wait for the migrated pages to be mapped
>>>> again increases.  So the latency may be hurt.  To deal with this
>>>> issue, the max number of pages be unmapped in batch is restricted to
>>>> no more than HPAGE_PMD_NR.  That is, the influence is at the same
>>>> level of THP migration.
>>>>
>>>> We use the following test to measure the performance impact of the
>>>> patchset,
>>>>
>>>> On a 2-socket Intel server,
>>>>
>>>>    - Run pmbench memory accessing benchmark
>>>>
>>>>    - Run `migratepages` to migrate pages of pmbench between node 0 and
>>>>      node 1 back and forth.
>>>>
>>> As the pmbench can not run on arm64 machine, so i use lmbench instead.
>>> I test case like this:  (i am not sure whether it is reasonable, but it seems worked)
>>> ./bw_mem -N10000 10000m rd &
>>> time migratepages pid node0 node1
>>>
>>> o/patch      		w/patch
>>> real	0m0.035s  	real	0m0.024s
>>> user	0m0.000s  	user	0m0.000s
>>> sys	0m0.035s        sys	0m0.024s
>>>
>>> the migratepages time is reduced above 32%.
>>>
>>> But there has a problem, i see the batch flush is called by
>>> migrate_pages_batch
>>> 	try_to_unmap_flush
>>> 		arch_tlbbatch_flush(&tlb_ubc->arch); // there batch flush really work.
>>>
>>> But in arm64, the arch_tlbbatch_flush are not supported, becasue it not support CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH yet.
>>>
>>> So, the tlb batch flush means no any flush is did, it is a empty func.
>> Yes.  And should_defer_flush() will always return false too.  That is,
>> the TLB will still be flushed, but will not be batched.
> Oh, yes, i ignore this, thank you.
>>
>>> Maybe this patch can help solve this problem.
>>> https://lore.kernel.org/linux-arm-kernel/20220921084302.43631-1-yangyicong@huawei.com/T/
>> Yes.  This will bring TLB flush batching to ARM64.
> Next time, i will combine with this patch, and do some test again,
> do you have any suggestion about benchmark ?

I think your benchmark should be OK.  If multiple threads are used, the
effect of patchset will be better.

Best Regards,
Huang, Ying

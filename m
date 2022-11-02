Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA756159AD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiKBDQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiKBDPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:15:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B808624BF3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 20:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667358941; x=1698894941;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=m48/xeNHXwikdkMS7hl7niHQHFI4b3Rpl1Ik4bOU1Mg=;
  b=ZpjXUsckfKQah9dBf6v0L1g8n2WAEIkWDHAdkquSXxD7D6TNyuGobXyV
   nXCjhk4zpwZXdrB9BFx26fjSFuEReRa83EvUwxPCPqiL8mMJ16Q3Qq/X4
   FkSNtVvK/0jBX1EnBK54npff5fCY/hRkqnOlmEbpFzJPvtDJp53dcfVxC
   soT6WCYsBcHrnhvxb47If32pgx79GcJdLB9Gw/VOhGMUDNdsdS46Yn2rV
   uF2W2A1fDP7cu7tTdNyntmipVXwblAeOne5Ec3lqxb46pp2rsRQtP8lXm
   hrH/TjfsSAlehWmPwUK4wJ2ygyOVsQYeoAYTAiVrwWFaCqx+WYEnWx0KD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="309299210"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="309299210"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 20:15:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="703106234"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="703106234"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 20:15:25 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Hesham Almatary <hesham.almatary@huawei.com>
Cc:     haoxin <xhao@linux.alibaba.com>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Matthew Wilcox" <willy@infradead.org>, <yangyicong@hisilicon.com>,
        <v-songbaohua@oppo.com>, <21cnbao@gmail.com>, <linux-mm@kvack.org>
Subject: Re: [RFC 0/6] migrate_pages(): batch TLB flushing
References: <20220921060616.73086-1-ying.huang@intel.com>
        <393d6318-aa38-01ed-6ad8-f9eac89bf0fc@linux.alibaba.com>
        <520d44e0-b7a9-b841-047a-d2707f3df3fe@huawei.com>
Date:   Wed, 02 Nov 2022 11:14:41 +0800
In-Reply-To: <520d44e0-b7a9-b841-047a-d2707f3df3fe@huawei.com> (Hesham
        Almatary's message of "Tue, 1 Nov 2022 14:49:17 +0000")
Message-ID: <87h6ziavz2.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_SBL_A autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hesham Almatary <hesham.almatary@huawei.com> writes:

> On 9/27/2022 12:21 PM, haoxin wrote:
>> Hi, Huang
>>
>> ( 2022/9/21 H2:06, Huang Ying S:
>>> From: "Huang, Ying" <ying.huang@intel.com>
>>>
>>> Now, migrate_pages() migrate pages one by one, like the fake code as
>>> follows,
>>>
>>>   for each page
>>>    unmap
>>>    flush TLB
>>>    copy
>>>    restore map
>>>
>>> If multiple pages are passed to migrate_pages(), there are
>>> opportunities to batch the TLB flushing and copying. That is, we can
>>> change the code to something as follows,
>>>
>>>   for each page
>>>    unmap
>>>   for each page
>>>    flush TLB
>>>   for each page
>>>    copy
>>>   for each page
>>>    restore map
>>>
>>> The total number of TLB flushing IPI can be reduced considerably. And
>>> we may use some hardware accelerator such as DSA to accelerate the
>>> page copying.
>>>
>>> So in this patch, we refactor the migrate_pages() implementation and
>>> implement the TLB flushing batching. Base on this, hardware
>>> accelerated page copying can be implemented.
>>>
>>> If too many pages are passed to migrate_pages(), in the naive batched
>>> implementation, we may unmap too many pages at the same time. The
>>> possibility for a task to wait for the migrated pages to be mapped
>>> again increases. So the latency may be hurt. To deal with this
>>> issue, the max number of pages be unmapped in batch is restricted to
>>> no more than HPAGE_PMD_NR. That is, the influence is at the same
>>> level of THP migration.
>>>
>>> We use the following test to measure the performance impact of the
>>> patchset,
>>>
>>> On a 2-socket Intel server,
>>>
>>>  - Run pmbench memory accessing benchmark
>>>
>>>  - Run `migratepages` to migrate pages of pmbench between node 0 and
>>>   node 1 back and forth.
>>>
>> As the pmbench can not run on arm64 machine, so i use lmbench instead.
>> I test case like this: (i am not sure whether it is reasonable,
>> but it seems worked)
>> ./bw_mem -N10000 10000m rd &
>> time migratepages pid node0 node1
>>
> FYI, I have ported pmbench to AArch64 [1]. The project seems to be
> abandoned on bitbucket,
>
> I wonder if it makes sense to fork it elsewhere and push the pending PRs there.
>
>
> [1] https://bitbucket.org/jisooy/pmbench/pull-requests/5

Maybe try to contact the original author with email firstly?

Best Regards,
Huang, Ying

>> o/patch w/patch
>> real  0m0.035s   real  0m0.024s
>> user  0m0.000s   user  0m0.000s
>> sys  0m0.035s    sys  0m0.024s
>>
>> the migratepages time is reduced above 32%.
>>
>> But there has a problem, i see the batch flush is called by
>> migrate_pages_batch
>>   try_to_unmap_flush
>>     arch_tlbbatch_flush(&tlb_ubc->arch); // there batch flush really work.
>>
>> But in arm64, the arch_tlbbatch_flush are not supported, becasue it
>> not support CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH yet.
>>
>> So, the tlb batch flush means no any flush is did, it is a empty func.
>>
>> Maybe this patch can help solve this problem.
>> https://lore.kernel.org/linux-arm-kernel/20220921084302.43631-1-yangyicong@huawei.com/T/ 
>>
>>
>>
>>
>>
>>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A93610889
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 05:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiJ1DEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 23:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiJ1DDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:03:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CA27F272
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 20:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666926234; x=1698462234;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=d4g/WkxhxP3clLiqPsAN8+c7o+p4HweRQSra1ss6Fz8=;
  b=LchRjOS6Qy9AqOEo0AIrEzdYOnZlNNsBsylKWYc/uuCDTiYkjR+ZCnEb
   qPy/liC2w1ZvFeBCQTQllM1oGsa83K3vILMgb07ir2dK2tcAEll81sl6w
   lHx07/jIkOpMFL22Mf1Xh10iN8Jac3zy/FvsXYsU5yGhCIDc/hzmSnRqd
   GUfHhcm87x7UopvkufU84nPDxg+iu2I7LOP8ta0srXjw1YpWyyguHzJbb
   rdOQOnHj2c2UK3zPOtoEpKXkPWSh5BMw1pYfM2b9jXZ0Gqa8gWz14iFeZ
   el1XINDbodDvDbOPHq4QOJQC5nN9L7gllRr/4LKyKTujPtbR3j0EjWb74
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="310093926"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="310093926"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 20:03:53 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="807678714"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="807678714"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 20:03:49 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Bharata B Rao <bharata@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Jagdish Gediya <jvgediya.oss@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [RFC] memory tiering: use small chunk size and more tiers
References: <20221027065925.476955-1-ying.huang@intel.com>
        <578c9b89-10eb-1e23-8868-cdd6685d8d4e@linux.ibm.com>
Date:   Fri, 28 Oct 2022 11:03:04 +0800
In-Reply-To: <578c9b89-10eb-1e23-8868-cdd6685d8d4e@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Thu, 27 Oct 2022 16:15:40 +0530")
Message-ID: <877d0kk5uf.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Aneesh,

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 10/27/22 12:29 PM, Huang Ying wrote:
>> We need some way to override the system default memory tiers.  For
>> the example system as follows,
>> 
>> type		abstract distance
>> ----		-----------------
>> HBM		300
>> DRAM		1000
>> CXL_MEM		5000
>> PMEM		5100
>> 
>> Given the memory tier chunk size is 100, the default memory tiers
>> could be,
>> 
>> tier		abstract distance	types
>>                 range
>> ----		-----------------       -----
>> 3		300-400			HBM
>> 10		1000-1100		DRAM
>> 50		5000-5100		CXL_MEM
>> 51		5100-5200		PMEM
>> 
>> If we want to group CXL MEM and PMEM into one tier, we have 2 choices.
>> 
>> 1) Override the abstract distance of CXL_MEM or PMEM.  For example, if
>> we change the abstract distance of PMEM to 5050, the memory tiers
>> become,
>> 
>> tier		abstract distance	types
>>                 range
>> ----		-----------------       -----
>> 3		300-400			HBM
>> 10		1000-1100		DRAM
>> 50		5000-5100		CXL_MEM, PMEM
>> 
>> 2) Override the memory tier chunk size.  For example, if we change the
>> memory tier chunk size to 200, the memory tiers become,
>> 
>> tier		abstract distance	types
>>                 range
>> ----		-----------------       -----
>> 1		200-400			HBM
>> 5		1000-1200		DRAM
>> 25		5000-5200		CXL_MEM, PMEM
>> 
>> But after some thoughts, I think choice 2) may be not good.  The
>> problem is that even if 2 abstract distances are almost same, they may
>> be put in 2 tier if they sit in the different sides of the tier
>> boundary.  For example, if the abstract distance of CXL_MEM is 4990,
>> while the abstract distance of PMEM is 5010.  Although the difference
>> of the abstract distances is only 20, CXL_MEM and PMEM will put in
>> different tiers if the tier chunk size is 50, 100, 200, 250, 500, ....
>> This makes choice 2) hard to be used, it may become tricky to find out
>> the appropriate tier chunk size that satisfying all requirements.
>> 
>
> Shouldn't we wait for gaining experience w.r.t how we would end up
> mapping devices with different latencies and bandwidth before tuning these values? 

Just want to discuss the overall design.

>> So I suggest to abandon choice 2) and use choice 1) only.  This makes
>> the overall design and user space interface to be simpler and easier
>> to be used.  The overall design of the abstract distance could be,
>> 
>> 1. Use decimal for abstract distance and its chunk size.  This makes
>>    them more user friendly.
>> 
>> 2. Make the tier chunk size as small as possible.  For example, 10.
>>    This will put different memory types in one memory tier only if their
>>    performance is almost same by default.  And we will not provide the
>>    interface to override the chunk size.
>> 
>
> this could also mean we can end up with lots of memory tiers with relative
> smaller performance difference between them. Again it depends how HMAT
> attributes will be used to map to abstract distance.

Per my understanding, there will not be many memory types in a system.
So, there will not be many memory tiers too.  In most systems, there are
only 2 or 3 memory tiers in the system, for example, HBM, DRAM, CXL,
etc.  Do you know systems with many memory types?  The basic idea is to
put different memory types in different memory tiers by default.  If
users want to group them, they can do that via overriding the abstract
distance of some memory type.

>
>> 3. Make the abstract distance of normal DRAM large enough.  For
>>    example, 1000, then 100 tiers can be defined below DRAM, this is
>>    more than enough in practice.
>
> Why 100? Will we really have that many tiers below/faster than DRAM? As of now 
> I see only HBM below it.

Yes.  100 is more than enough.  We just want to avoid to group different
memory types by default.

Best Regards,
Huang, Ying

>> 
>> 4. If we want to override the default memory tiers, just override the
>>    abstract distances of some memory types with a per memory type
>>    interface.
>> 
>> This patch is to apply the design choices above in the existing code.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Bharata B Rao <bharata@amd.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Hesham Almatary <hesham.almatary@huawei.com>
>> Cc: Jagdish Gediya <jvgediya.oss@gmail.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Tim Chen <tim.c.chen@intel.com>
>> Cc: Wei Xu <weixugc@google.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> ---
>>  include/linux/memory-tiers.h | 7 +++----
>>  mm/memory-tiers.c            | 7 +++----
>>  2 files changed, 6 insertions(+), 8 deletions(-)
>> 
>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>> index 965009aa01d7..2e39d9a6c8ce 100644
>> --- a/include/linux/memory-tiers.h
>> +++ b/include/linux/memory-tiers.h
>> @@ -7,17 +7,16 @@
>>  #include <linux/kref.h>
>>  #include <linux/mmzone.h>
>>  /*
>> - * Each tier cover a abstrace distance chunk size of 128
>> + * Each tier cover a abstrace distance chunk size of 10
>>   */
>> -#define MEMTIER_CHUNK_BITS	7
>> -#define MEMTIER_CHUNK_SIZE	(1 << MEMTIER_CHUNK_BITS)
>> +#define MEMTIER_CHUNK_SIZE	10
>>  /*
>>   * Smaller abstract distance values imply faster (higher) memory tiers. Offset
>>   * the DRAM adistance so that we can accommodate devices with a slightly lower
>>   * adistance value (slightly faster) than default DRAM adistance to be part of
>>   * the same memory tier.
>>   */
>> -#define MEMTIER_ADISTANCE_DRAM	((4 * MEMTIER_CHUNK_SIZE) + (MEMTIER_CHUNK_SIZE >> 1))
>> +#define MEMTIER_ADISTANCE_DRAM	((100 * MEMTIER_CHUNK_SIZE) + (MEMTIER_CHUNK_SIZE / 2))
>>  #define MEMTIER_HOTPLUG_PRIO	100
>>  
>>  struct memory_tier;
>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> index fa8c9d07f9ce..e03011428fa5 100644
>> --- a/mm/memory-tiers.c
>> +++ b/mm/memory-tiers.c
>> @@ -165,11 +165,10 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
>>  	bool found_slot = false;
>>  	struct memory_tier *memtier, *new_memtier;
>>  	int adistance = memtype->adistance;
>> -	unsigned int memtier_adistance_chunk_size = MEMTIER_CHUNK_SIZE;
>>  
>>  	lockdep_assert_held_once(&memory_tier_lock);
>>  
>> -	adistance = round_down(adistance, memtier_adistance_chunk_size);
>> +	adistance = rounddown(adistance, MEMTIER_CHUNK_SIZE);
>>  	/*
>>  	 * If the memtype is already part of a memory tier,
>>  	 * just return that.
>> @@ -204,7 +203,7 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
>>  	else
>>  		list_add_tail(&new_memtier->list, &memory_tiers);
>>  
>> -	new_memtier->dev.id = adistance >> MEMTIER_CHUNK_BITS;
>> +	new_memtier->dev.id = adistance / MEMTIER_CHUNK_SIZE;
>>  	new_memtier->dev.bus = &memory_tier_subsys;
>>  	new_memtier->dev.release = memory_tier_device_release;
>>  	new_memtier->dev.groups = memtier_dev_groups;
>> @@ -641,7 +640,7 @@ static int __init memory_tier_init(void)
>>  #endif
>>  	mutex_lock(&memory_tier_lock);
>>  	/*
>> -	 * For now we can have 4 faster memory tiers with smaller adistance
>> +	 * For now we can have 100 faster memory tiers with smaller adistance
>>  	 * than default DRAM tier.
>>  	 */
>>  	default_dram_type = alloc_memory_type(MEMTIER_ADISTANCE_DRAM);

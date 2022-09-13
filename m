Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBE25B6567
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 04:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiIMCJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 22:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiIMCJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:09:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FDE10FE3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 19:09:50 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MRRdn5cFBzmVMS;
        Tue, 13 Sep 2022 10:06:05 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 10:09:49 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 10:09:48 +0800
Message-ID: <1ce6413a-23c8-699d-cc2d-11e1fce40982@huawei.com>
Date:   Tue, 13 Sep 2022 10:09:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
CC:     <mawupeng1@huawei.com>, <akpm@linux-foundation.org>,
        <david@redhat.com>, <npiggin@suse.de>, <ying.huang@intel.com>,
        <hannes@cmpxchg.org>, <corbet@lwn.net>, <mcgrof@kernel.org>,
        <mgorman@suse.de>, <keescook@chromium.org>, <yzaikin@google.com>,
        <songmuchun@bytedance.com>, <mike.kravetz@oracle.com>,
        <osalvador@suse.de>, <surenb@google.com>, <rppt@kernel.org>,
        <charante@codeaurora.org>, <jsavitz@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <lkp@intel.com>
Subject: Re: [PATCH -next v3 2/2] mm: sysctl: Introduce per zone
 watermark_scale_factor
To:     <gonehacking@gmail.com>
References: <20220905032858.1462927-1-mawupeng1@huawei.com>
 <20220905032858.1462927-3-mawupeng1@huawei.com>
 <c670c3f07a7187b4f5cef2d3dfe0f09f0cf81e09.camel@oracle.com>
Content-Language: en-US
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <c670c3f07a7187b4f5cef2d3dfe0f09f0cf81e09.camel@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/10 5:41, Khalid Aziz wrote:
> On Mon, 2022-09-05 at 11:28 +0800, Wupeng Ma wrote:
>> From: Ma Wupeng <mawupeng1@huawei.com>
>>
>> System may have little normal zone memory and huge movable memory in
>> the
>> following situations:
>>   - for system with kernelcore=nn% or kernelcore=mirror, movable zone
>> will
>>   be added and movable zone is bigger than normal zone in most cases.
>>   - system with movable nodes, they will have multiple numa nodes
>> with
>>   only movable zone and movable zone will have plenty of memory.
>>
>> Since kernel/driver can only use memory from non-movable zone in most
>> cases, normal zone need to increase its watermark to reserve more
>> memory.
>>
>> However, current watermark_scale_factor is used to control all zones
>> at once and can't be set separately. To reserve memory in non-movable
>> zones, the watermark is increased in movable zones as well. Which
>> will
>> lead to inefficient kswapd.
> 
> Similar issues happen on systems with large amount of memory (1 TB or
> more). Most of the memory ends up in Normal zone while DMA and DMA32
> zones have very little memory. For the watermark scale factor that
> results in a reasonable low watermark for Normal zone, low watermark
> can be too low for DMA and DMA32 zones. Being able to tune those
> watermarks independently can be helpful. The trouble with this approach
> is it introduces another level of complexity to tuning knobs with no
> clear guidelines for system admins on how to tune these. I already see
> multiple customers struggling with setting simple min_free_kbytes or
> watermark_scale_factor. Once we add the complexity of per zone
> watermark scale factor, it only gets to be a more daunting task for
> system admins. NUMA systems with multiple nodes with hot-pluggable
> memory can have sizeable number of zones.
> 
> I see the usefulness of per-zone watermark but what guidance would you
> give to a sysadmin on how to set these values for their systems?
> 
> Thanks,
> Khalid

Thanks for your reply.

Like the vanilla watermark_scale_factor, this per-zone one just introduce
the ability to tune this watermark separately. The overall usage of the
per-zone one is similar to to vanilla one.

Memory allocation below the low watermark will awake the kswapd and drop
cache or swap out until the memory's watermark reach the high watermark.
Since memory allocation can get their page in fast path(watermark above
low), the following memory allocation can benefit from this background
kswapd.

Since memory below min is used for emergency and below min means system
is low on memory, And higher zones(movable) allocations indirectly pin
pages in lower zones(page table..), boost the watermark for the lower
zones can reserve enough memory for kernel/driver to use.

So bigger watermark for lower zones if the higher zones is huge may be
the solution.

> 
> 
>>
>> To solve this problem, per zone watermark is introduced to tune each
>> zone's
>> watermark separately. This can bring the following advantages:
>>   - each zone can set its own watermark which bring flexibility
>>   - lead to more efficient kswapd if this watermark is set fine
>>
>> Here is real watermark data in my qemu machine(with THP disabled).
>>
>> With watermark_scale_factor = 10, there is only 1440(772-68+807-71)
>> pages(5.76M) reserved for a system with 96G of memory. However if the
>> watermark is set to 100, the movable zone's watermark increased to
>> 231908(93M), which is too much.
>> This situation is even worse with 32G of normal zone memory and 1T of
>> movable zone memory.
>>
>>        Modified        | Vanilla wm_factor = 10 | Vanilla wm_factor =
>> 30
>> Node 0, zone      DMA  | Node 0, zone      DMA  | Node 0, zone     
>> DMA
>>         min      68    |         min      68    |         min      68
>>         low      7113  |         low      772   |         low     
>> 7113
>>         high **14158** |         high **1476**  |         high
>> **14158**
>> Node 0, zone   Normal  | Node 0, zone   Normal  | Node 0, zone  
>> Normal
>>         min      71    |         min      71    |         min      71
>>         low      7438  |         low      807   |         low     
>> 7438
>>         high     14805 |         high     1543  |         high    
>> 14805
>> Node 0, zone  Movable  | Node 0, zone  Movable  | Node 0, zone 
>> Movable
>>         min      1455  |         min      1455  |         min     
>> 1455
>>         low      16388 |         low      16386 |         low     
>> 150787
>>         high **31321** |         high **31317** |         high
>> **300119**
>> Node 1, zone  Movable  | Node 1, zone  Movable  | Node 1, zone 
>> Movable
>>         min      804   |         min      804   |         min     
>> 804
>>         low      9061  |         low      9061  |         low     
>> 83379
>>         high **17318** |         high **17318** |         high
>> **165954**
>>
>> With the modified per zone watermark_scale_factor, only dma/normal
>> zone
>> will increase its watermark via the following command which the huge
>> movable zone stay the same.
>>
>>   % echo 100 100 100 10 > /proc/sys/vm/watermark_scale_factor
>>
>> The reason to disable THP is khugepaged_min_free_kbytes_update() will
>> update min watermark.
>>
>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> ---
>>  Documentation/admin-guide/sysctl/vm.rst |  6 ++++
>>  include/linux/mm.h                      |  2 +-
>>  kernel/sysctl.c                         |  2 --
>>  mm/page_alloc.c                         | 37 ++++++++++++++++++++---
>> --
>>  4 files changed, 37 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/sysctl/vm.rst
>> b/Documentation/admin-guide/sysctl/vm.rst
>> index 9b833e439f09..ec240aa45322 100644
>> --- a/Documentation/admin-guide/sysctl/vm.rst
>> +++ b/Documentation/admin-guide/sysctl/vm.rst
>> @@ -1002,6 +1002,12 @@ that the number of free pages kswapd maintains
>> for latency reasons is
>>  too small for the allocation bursts occurring in the system. This
>> knob
>>  can then be used to tune kswapd aggressiveness accordingly.
>>  
>> +The watermark_scale_factor is an array. You can set each zone's
>> watermark
>> +separately and can be seen by reading this file::
>> +
>> +       % cat /proc/sys/vm/watermark_scale_factor
>> +       10      10      10      10
>> +
>>  
>>  zone_reclaim_mode
>>  =================
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 21f8b27bd9fd..b291c795f9db 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2532,7 +2532,7 @@ extern void setup_per_cpu_pageset(void);
>>  /* page_alloc.c */
>>  extern int min_free_kbytes;
>>  extern int watermark_boost_factor;
>> -extern int watermark_scale_factor;
>> +extern int watermark_scale_factor[MAX_NR_ZONES];
>>  extern bool arch_has_descending_max_zone_pfns(void);
>>  
>>  /* nommu.c */
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 205d605cacc5..d16d06c71e5a 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -2251,8 +2251,6 @@ static struct ctl_table vm_table[] = {
>>                 .maxlen         = sizeof(watermark_scale_factor),
>>                 .mode           = 0644,
>>                 .proc_handler   =
>> watermark_scale_factor_sysctl_handler,
>> -               .extra1         = SYSCTL_ONE,
>> -               .extra2         = SYSCTL_THREE_THOUSAND,
>>         },
>>         {
>>                 .procname       = "percpu_pagelist_high_fraction",
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index f1e4474879f1..7a6ac3b4ebb6 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -421,7 +421,6 @@ compound_page_dtor * const
>> compound_page_dtors[NR_COMPOUND_DTORS] = {
>>  int min_free_kbytes = 1024;
>>  int user_min_free_kbytes = -1;
>>  int watermark_boost_factor __read_mostly = 15000;
>> -int watermark_scale_factor = 10;
>>  
>>  static unsigned long nr_kernel_pages __initdata;
>>  static unsigned long nr_all_pages __initdata;
>> @@ -449,6 +448,20 @@ EXPORT_SYMBOL(nr_online_nodes);
>>  
>>  int page_group_by_mobility_disabled __read_mostly;
>>  
>> +int watermark_scale_factor[MAX_NR_ZONES] = {
>> +#ifdef CONFIG_ZONE_DMA
>> +       [ZONE_DMA] = 10,
>> +#endif
>> +#ifdef CONFIG_ZONE_DMA32
>> +       [ZONE_DMA32] = 10,
>> +#endif
>> +       [ZONE_NORMAL] = 10,
>> +#ifdef CONFIG_HIGHMEM
>> +       [ZONE_HIGHMEM] = 10,
>> +#endif
>> +       [ZONE_MOVABLE] = 10,
>> +};
>> +
>>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>>  /*
>>   * During boot we initialize deferred pages on-demand, as needed,
>> but once
>> @@ -8643,6 +8656,7 @@ static void __setup_per_zone_wmarks(void)
>>         }
>>  
>>         for_each_zone(zone) {
>> +               int zone_wm_factor;
>>                 u64 tmp;
>>  
>>                 spin_lock_irqsave(&zone->lock, flags);
>> @@ -8676,9 +8690,10 @@ static void __setup_per_zone_wmarks(void)
>>                  * scale factor in proportion to available memory,
>> but
>>                  * ensure a minimum size on small systems.
>>                  */
>> +               zone_wm_factor =
>> watermark_scale_factor[zone_idx(zone)];
>>                 tmp = max_t(u64, tmp >> 2,
>> -                           mult_frac(zone_managed_pages(zone),
>> -                                     watermark_scale_factor,
>> 10000));
>> +                           mult_frac(zone_managed_pages(zone),
>> zone_wm_factor,
>> +                                     10000));
>>  
>>                 zone->watermark_boost = 0;
>>                 zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone)
>> + tmp;
>> @@ -8798,11 +8813,19 @@ int min_free_kbytes_sysctl_handler(struct
>> ctl_table *table, int write,
>>  int watermark_scale_factor_sysctl_handler(struct ctl_table *table,
>> int write,
>>                 void *buffer, size_t *length, loff_t *ppos)
>>  {
>> -       int rc;
>> +       int i;
>>  
>> -       rc = proc_dointvec_minmax(table, write, buffer, length,
>> ppos);
>> -       if (rc)
>> -               return rc;
>> +       proc_dointvec_minmax(table, write, buffer, length, ppos);
>> +
>> +       /*
>> +        * The unit is in fractions of 10,000. The default value of
>> 10
>> +        * means the distances between watermarks are 0.1% of the
>> available
>> +        * memory in the node/system. The maximum value is 3000, or
>> 30% of
>> +        * memory.
>> +        */
>> +       for (i = 0; i < MAX_NR_ZONES; i++)
>> +               watermark_scale_factor[i] =
>> +                       clamp(watermark_scale_factor[i], 1, 3000);
>>  
>>         if (write)
>>                 setup_per_zone_wmarks();
> 

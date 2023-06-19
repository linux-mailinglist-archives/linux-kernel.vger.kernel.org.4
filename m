Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D2973571E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjFSMob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFSMo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:44:29 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEEAAE77
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:43:59 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.218:51431.826311313
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.84 (unknown [172.18.0.218])
        by chinatelecom.cn (HERMES) with SMTP id 2CE112800AF;
        Mon, 19 Jun 2023 20:42:52 +0800 (CST)
X-189-SAVE-TO-SEND: liuq131@chinatelecom.cn
Received: from  ([36.111.64.84])
        by app0025 with ESMTP id 1ab8e237609f49c095ccbc84f2f25768 for ying.huang@intel.com;
        Mon, 19 Jun 2023 20:42:56 CST
X-Transaction-ID: 1ab8e237609f49c095ccbc84f2f25768
X-Real-From: liuq131@chinatelecom.cn
X-Receive-IP: 36.111.64.84
X-MEDUSA-Status: 0
Sender: liuq131@chinatelecom.cn
Message-ID: <4f3bac46-6dbe-653b-bcb9-ace46c4d4c9e@chinatelecom.cn>
Date:   Mon, 19 Jun 2023 20:42:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/min_free_kbytes: modify min_free_kbytes calculation
 rules
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20230609032552.218010-1-liuq131@chinatelecom.cn>
 <87edm88765.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   liuq <liuq131@chinatelecom.cn>
In-Reply-To: <87edm88765.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/6/19 11:25, Huang, Ying 写道:
> Added Mel and Vlastimil.
>
> liuq <liuq131@chinatelecom.cn> writes:
>
>> The current calculation of min_free_kbytes only uses ZONE_DMA and
>> ZONE_NORMAL pages,but the ZONE_MOVABLE zone->_watermark[WMARK_MIN]
>> will also divide part of min_free_kbytes.This will cause the min
>> watermark of ZONE_NORMAL to be too small in the presence of ZONE_MOVEABLE.
> This seems like a real problem per my understanding.  Can you show the
> contents of /proc/zoneinfo on a problem system?
>
> But, per my understanding, min_free_kbytes are used for __GFP_HIGH and
> PF_MEMALLOC allocations.  While ZONE_MOVABLE will not be used for them
> usually.  So I think we should treat ZONE_MOVABLE as ZONE_HIGHMEM in
> __setup_per_zone_wmarks().
>
> Best Regards,
> Huang, Ying
On my testing machine with 16GB of memory (transparent hugepage is 
turned off by default), when movable zone is not configured, 
min_free_kbytes  is 15806 (15806*15806/16=15614352kbytes, approximatel
y 16G).
The detailed info is as follows:
[root@lq-workstation ~]# cat /proc/cmdline
BOOT_IMAGE=/vmlinuz-6.2.0-rc7-00018-g0983f6bf2bfc-dirty 
root=/dev/mapper/ctyunos00-root ro resume=/dev/mapper/ctyunos00-swap 
rd.lvm.lv=ctyunos00/root rd.lvm.lv=ctyunos00/swap crashkernel=512M
[root@lq-workstation ~]#  cat /proc/zoneinfo |grep -A 5 min
         min      3
         low      6
         high     9
         spanned  4095
         present  3998
         managed  3840
--
         min      328
         low      652
         high     976
         spanned  1044480
         present  478802
         managed  330969
--
         min      3618
         low      7193
         high     10768
         spanned  3655680
         present  3655680
         managed  3575787
--
         min      0
         low      0
         high     0
         spanned  0
         present  0
         managed  0
[root@lq-workstation ~]# cat /proc/sys/vm/min_free_kbytes
15806

If movablecore=12G is configured, at this time, min_free_kbytes is 7326 
(7326 * 7326/16=3354392, approximately 16G-12G)
The detailed info is as follows:
[root@lq-workstation ~]# cat /proc/cmdline
BOOT_IMAGE=/vmlinuz-6.2.0-rc7-00018-g0983f6bf2bfc-dirty 
root=/dev/mapper/ctyunos00-root ro resume=/dev/mapper/ctyunos00-swap 
rd.lvm.lv=ctyunos00/root rd.lvm.lv=ctyunos00/swap crashkernel=512M 
movablecore=12G
[root@lq-workstation ~]# cat /proc/zoneinfo |grep -A 5 min
         min      1
         low      4
         high     7
         spanned  4095
         present  3998
         managed  3840
--
         min      152
         low      476
         high     800
         spanned  1044480
         present  478802
         managed  330969
--
         min      239
         low      748
         high     1257
         spanned  509952
         present  509952
         managed  509952
--
         min      1437
         low      4502
         high     7567
         spanned  3145728
         present  3145728
         managed  3065833
[root@lq-workstation ~]# cat /proc/sys/vm/min_free_kbytes
7326

After this patch is added, the configuration of the movable zone no 
longer affects the size of the min_free_kbytes, which is only affected 
by the size of the available memory.
>> Signed-off-by: liuq <liuq131@chinatelecom.cn>
>> ---
>>   include/linux/mm.h |  1 +
>>   mm/khugepaged.c    |  2 +-
>>   mm/page_alloc.c    | 15 ++++++++++++++-
>>   3 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index cf3d0d673f6b..1f91d035bcaf 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -863,6 +863,7 @@ void split_page(struct page *page, unsigned int order);
>>   void folio_copy(struct folio *dst, struct folio *src);
>>   
>>   unsigned long nr_free_buffer_pages(void);
>> +unsigned long nr_free_pagecache_pages(void);
>>   
>>   /*
>>    * Compound pages have a destructor function.  Provide a
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 16be62d493cd..6632264b951c 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -2342,7 +2342,7 @@ static void set_recommended_min_free_kbytes(void)
>>   
>>   	/* don't ever allow to reserve more than 5% of the lowmem */
>>   	recommended_min = min(recommended_min,
>> -			      (unsigned long) nr_free_buffer_pages() / 20);
>> +			      (unsigned long) nr_free_pagecache_pages() / 20);
>>   	recommended_min <<= (PAGE_SHIFT-10);
>>   
>>   	if (recommended_min > min_free_kbytes) {
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index e008a3df0485..489b564526dd 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -5775,6 +5775,19 @@ unsigned long nr_free_buffer_pages(void)
>>   }
>>   EXPORT_SYMBOL_GPL(nr_free_buffer_pages);
>>   
>> +/**
>> + * nr_free_pagecache_pages - count number of pages beyond high watermark
>> + *
>> + * nr_free_pagecache_pages() counts the number of pages which are beyond the
>> + * high watermark within all zones.
>> + *
>> + * Return: number of pages beyond high watermark within all zones.
>> + */
>> +unsigned long nr_free_pagecache_pages(void)
>> +{
>> +	return nr_free_zone_pages(gfp_zone(GFP_HIGHUSER_MOVABLE));
>> +}
>> +
>>   static inline void show_node(struct zone *zone)
>>   {
>>   	if (IS_ENABLED(CONFIG_NUMA))
>> @@ -8651,7 +8664,7 @@ void calculate_min_free_kbytes(void)
>>   	unsigned long lowmem_kbytes;
>>   	int new_min_free_kbytes;
>>   
>> -	lowmem_kbytes = nr_free_buffer_pages() * (PAGE_SIZE >> 10);
>> +	lowmem_kbytes = nr_free_pagecache_pages() * (PAGE_SIZE >> 10);
>>   	new_min_free_kbytes = int_sqrt(lowmem_kbytes * 16);
>>   
>>   	if (new_min_free_kbytes > user_min_free_kbytes)

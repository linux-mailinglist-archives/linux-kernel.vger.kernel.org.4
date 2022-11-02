Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA7F6164A8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiKBONm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiKBONi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:13:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3407A5FE8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:13:36 -0700 (PDT)
Received: from frapeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N2TN23bb2z6HJLk;
        Wed,  2 Nov 2022 22:11:46 +0800 (CST)
Received: from lhrpeml500004.china.huawei.com (7.191.163.9) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 15:13:30 +0100
Received: from [10.202.227.118] (10.202.227.118) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 14:13:30 +0000
Message-ID: <e94cffd0-a820-e73c-7b6a-a0272d95151d@huawei.com>
Date:   Wed, 2 Nov 2022 14:13:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC 0/6] migrate_pages(): batch TLB flushing
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     haoxin <xhao@linux.alibaba.com>, <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Oscar Salvador" <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        <yangyicong@hisilicon.com>, <v-songbaohua@oppo.com>,
        <21cnbao@gmail.com>, <linux-mm@kvack.org>
References: <20220921060616.73086-1-ying.huang@intel.com>
 <393d6318-aa38-01ed-6ad8-f9eac89bf0fc@linux.alibaba.com>
 <520d44e0-b7a9-b841-047a-d2707f3df3fe@huawei.com>
 <87h6ziavz2.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Hesham Almatary <hesham.almatary@huawei.com>
In-Reply-To: <87h6ziavz2.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.118]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_SBL_A
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/2/2022 3:14 AM, Huang, Ying wrote:
> Hesham Almatary <hesham.almatary@huawei.com> writes:
>
>> On 9/27/2022 12:21 PM, haoxin wrote:
>>> Hi, Huang
>>>
>>> ( 2022/9/21 H2:06, Huang Ying S:
>>>> From: "Huang, Ying" <ying.huang@intel.com>
>>>>
>>>> Now, migrate_pages() migrate pages one by one, like the fake code as
>>>> follows,
>>>>
>>>> ? for each page
>>>> ?? unmap
>>>> ?? flush TLB
>>>> ?? copy
>>>> ?? restore map
>>>>
>>>> If multiple pages are passed to migrate_pages(), there are
>>>> opportunities to batch the TLB flushing and copying. That is, we can
>>>> change the code to something as follows,
>>>>
>>>> ? for each page
>>>> ?? unmap
>>>> ? for each page
>>>> ?? flush TLB
>>>> ? for each page
>>>> ?? copy
>>>> ? for each page
>>>> ?? restore map
>>>>
>>>> The total number of TLB flushing IPI can be reduced considerably. And
>>>> we may use some hardware accelerator such as DSA to accelerate the
>>>> page copying.
>>>>
>>>> So in this patch, we refactor the migrate_pages() implementation and
>>>> implement the TLB flushing batching. Base on this, hardware
>>>> accelerated page copying can be implemented.
>>>>
>>>> If too many pages are passed to migrate_pages(), in the naive batched
>>>> implementation, we may unmap too many pages at the same time. The
>>>> possibility for a task to wait for the migrated pages to be mapped
>>>> again increases. So the latency may be hurt. To deal with this
>>>> issue, the max number of pages be unmapped in batch is restricted to
>>>> no more than HPAGE_PMD_NR. That is, the influence is at the same
>>>> level of THP migration.
>>>>
>>>> We use the following test to measure the performance impact of the
>>>> patchset,
>>>>
>>>> On a 2-socket Intel server,
>>>>
>>>>   - Run pmbench memory accessing benchmark
>>>>
>>>>   - Run `migratepages` to migrate pages of pmbench between node 0 and
>>>> ? node 1 back and forth.
>>>>
>>> As the pmbench can not run on arm64 machine, so i use lmbench instead.
>>> I test case like this: (i am not sure whether it is reasonable,
>>> but it seems worked)
>>> ./bw_mem -N10000 10000m rd &
>>> time migratepages pid node0 node1
>>>
>> FYI, I have ported pmbench to AArch64 [1]. The project seems to be
>> abandoned on bitbucket,
>>
>> I wonder if it makes sense to fork it elsewhere and push the pending PRs there.
>>
>>
>> [1] https://bitbucket.org/jisooy/pmbench/pull-requests/5
> Maybe try to contact the original author with email firstly?

That's  a good idea. I'm not planning to fork/maintain it myself, but if anyone

is interested in doing so, I am happy to help out and submit PRs there.


> Best Regards,
> Huang, Ying
>
>>> o/patch w/patch
>>> real? 0m0.035s?? real? 0m0.024s
>>> user? 0m0.000s?? user? 0m0.000s
>>> sys? 0m0.035s??? sys? 0m0.024s
>>>
>>> the migratepages time is reduced above 32%.
>>>
>>> But there has a problem, i see the batch flush is called by
>>> migrate_pages_batch
>>> ??try_to_unmap_flush
>>> ??? arch_tlbbatch_flush(&tlb_ubc->arch); // there batch flush really work.
>>>
>>> But in arm64, the arch_tlbbatch_flush are not supported, becasue it
>>> not support CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH yet.
>>>
>>> So, the tlb batch flush means no any flush is did, it is a empty func.
>>>
>>> Maybe this patch can help solve this problem.
>>> https://lore.kernel.org/linux-arm-kernel/20220921084302.43631-1-yangyicong@huawei.com/T/
>>>
>>>
>>>
>>>
>>>
>>>

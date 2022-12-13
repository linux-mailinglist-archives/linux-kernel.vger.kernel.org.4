Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B3264B4F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbiLMMQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbiLMMQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:16:01 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C7F1F2DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:13:33 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NWcnb0yDsz15NHW;
        Tue, 13 Dec 2022 20:12:35 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 20:13:31 +0800
Message-ID: <801ccbe2-08b8-e1cb-9aee-614d59a807d2@huawei.com>
Date:   Tue, 13 Dec 2022 20:13:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next 1/8] mm: memory_hotplug: add pfn_to_online_folio()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        SeongJae Park <sj@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <damon@lists.linux.dev>, <vishal.moola@gmail.com>,
        <willy@infradead.org>
References: <20221213092735.187924-1-wangkefeng.wang@huawei.com>
 <20221213092735.187924-2-wangkefeng.wang@huawei.com>
 <f07d1c95-f13c-682b-0519-0b137ccdc631@redhat.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <f07d1c95-f13c-682b-0519-0b137ccdc631@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/12/13 19:40, David Hildenbrand wrote:
> On 13.12.22 10:27, Kefeng Wang wrote:
>> Introduce a wrapper function pfn_to_online_folio(), which calls
>> pfn_to_online_page() and returns the folio of the page found,
>> or null if no page.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   include/linux/memory_hotplug.h | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/include/linux/memory_hotplug.h 
>> b/include/linux/memory_hotplug.h
>> index 9fcbf5706595..e841e4fb52a7 100644
>> --- a/include/linux/memory_hotplug.h
>> +++ b/include/linux/memory_hotplug.h
>> @@ -265,6 +265,13 @@ static inline void pgdat_kswapd_unlock(pg_data_t 
>> *pgdat) {}
>>   static inline void pgdat_kswapd_lock_init(pg_data_t *pgdat) {}
>>   #endif /* ! CONFIG_MEMORY_HOTPLUG */
>>   +static inline struct folio *pfn_to_online_folio(unsigned long pfn)
>> +{
>> +    struct page *page = pfn_to_online_page(pfn);
>> +
>> +    return page ? page_folio(page) : NULL;
>> +}
>
> Who guarantees that page_folio() is safe and stable at that point?
>
> IIRC, that's very tricky. We could have the page concurrently getting 
> freed and the folio dissolved.
So the caller should consider this,  lock or get the folio in the caller?

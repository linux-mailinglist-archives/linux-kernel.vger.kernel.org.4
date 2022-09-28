Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43F85ED32D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 04:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiI1Cy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 22:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiI1CyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 22:54:25 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB921BA3A3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 19:54:23 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mcgvd6hNwz1P6r6;
        Wed, 28 Sep 2022 10:50:05 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 10:54:21 +0800
Received: from [10.67.109.54] (10.67.109.54) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 10:54:20 +0800
Subject: Re: [PATCH] mm/hwpoison: fix build error without
 CONFIG_MEMORY_FAILURE
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
References: <20220927102946.98622-1-tanghui20@huawei.com>
 <20220927125350.GA500539@u2004.lan>
CC:     <naoya.horiguchi@nec.com>, <linmiaohe@huawei.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
From:   Hui Tang <tanghui20@huawei.com>
Message-ID: <c7b234ae-db3a-ef9e-714d-a911d37a272a@huawei.com>
Date:   Wed, 28 Sep 2022 10:54:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220927125350.GA500539@u2004.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.54]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/27 20:53, Naoya Horiguchi wrote:
> On Tue, Sep 27, 2022 at 06:29:46PM +0800, Hui Tang wrote:
>> Building without CONFIG_MEMORY_FAILURE will fail:
>>
>> mm/memory-failure.o: In function `action_result':
>> memory-failure.c: undefined reference to `memblk_nr_poison_inc'
>> mm/memory-failure.o: In function `page_handle_poison':
>> memory-failure.c: undefined reference to `memblk_nr_poison_inc'
>> mm/memory-failure.o: In function `__get_huge_page_for_hwpoison':
>> memory-failure.c: undefined reference to `memblk_nr_poison_inc'
>> mm/memory-failure.o: In function `unpoison_memory':
>> memory-failure.c: undefined reference to `memblk_nr_poison_sub'
>> mm/memory-failure.o: In function `num_poisoned_pages_inc':
>> memory-failure.c: undefined reference to `memblk_nr_poison_inc'
>>
>> Add CONFIG_MEMORY_FAILURE wrapper for invoking memblk_nr_poison_{inc|sub}.
>>
>> Fixes: 69b496f03bb4 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
>> Signed-off-by: Hui Tang <tanghui20@huawei.com>
>
> Thank you for the patch.  I have a question.
> If you disables CONFIG_MEMORY_FAILURE, mm/memory-failure.c should
> not be compiled, so I wonder why you saw the compile error.
> Could you share your .config file?
>
> Acutally I saw the similar report a few days ago
> https://lore.kernel.org/lkml/20220923095013.1151252-1-michael@walle.cc/
> , where the build error happened in aarch64,  so I likely missed some arch
> dependency.  I responded to the report by updating the patch by applying
> "#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_MEMORY_HOTPLUG)"
> to the definition of memblk_nr_poison_{inc,sub}.
> https://lore.kernel.org/lkml/20220923141204.GA1484969@ik1-406-35019.vs.sakura.ne.jp/
>
> I did not confirm that this fix is really right, because I can't reproduced
> the build error in my environment.  So could you check that v5 patch fixes
> the build error you're seeing?  (The current version in mm-unstable is v4,
> so that should be replaced with v5.)

   Yes, when appling the latest patch, this build error is gone, thanks.

>
>> ---
>>  mm/memory-failure.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 03479895086d..5bb9d2d20234 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -77,14 +77,18 @@ static bool hw_memory_failure __read_mostly = false;
>>  void num_poisoned_pages_inc(unsigned long pfn)
>>  {
>>  	atomic_long_inc(&num_poisoned_pages);
>> +#ifdef CONFIG_MEMORY_FAILURE
>>  	memblk_nr_poison_inc(pfn);
>> +#endif
>>  }
>>
>>  static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
>>  {
>>  	atomic_long_sub(i, &num_poisoned_pages);
>> +#ifdef CONFIG_MEMORY_FAILURE
>>  	if (pfn != -1UL)
>>  		memblk_nr_poison_sub(pfn, i);
>> +#endif
>>  }
>>
>>  /*
>> --
>> 2.17.1
>>
>>
>>
> .
>

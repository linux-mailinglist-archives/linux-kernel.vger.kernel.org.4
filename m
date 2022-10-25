Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECB560C3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiJYGRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJYGRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:17:07 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46C2DF8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 23:17:04 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MxM8n2hyrzJnFP;
        Tue, 25 Oct 2022 14:14:17 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 14:17:02 +0800
Subject: Re: [PATCH v8 1/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove
 memory section with hwpoisoned hugepage
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>
References: <20221024062012.1520887-1-naoya.horiguchi@linux.dev>
 <20221024062012.1520887-2-naoya.horiguchi@linux.dev>
 <2484c6be-5075-2203-4f16-9cfdc4876e11@huawei.com>
 <20221025053559.GA2104800@ik1-406-35019.vs.sakura.ne.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6decf924-1743-d67e-8222-0f02f83b05c1@huawei.com>
Date:   Tue, 25 Oct 2022 14:17:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221025053559.GA2104800@ik1-406-35019.vs.sakura.ne.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/25 13:35, Naoya Horiguchi wrote:
> On Tue, Oct 25, 2022 at 10:38:11AM +0800, Miaohe Lin wrote:
>> On 2022/10/24 14:20, Naoya Horiguchi wrote:
>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>
>>> HWPoisoned page is not supposed to be accessed once marked, but currently
>>> such accesses can happen during memory hotremove because do_migrate_range()
>>> can be called before dissolve_free_huge_pages() is called.
>>>
>>> Clear HPageMigratable for hwpoisoned hugepages to prevent them from being
>>> migrated.  This should be done in hugetlb_lock to avoid race against
>>> isolate_hugetlb().
>>>
>>> get_hwpoison_huge_page() needs to have a flag to show it's called from
>>> unpoison to take refcount of hwpoisoned hugepages, so add it.
>>>
>>> Reported-by: Miaohe Lin <linmiaohe@huawei.com>
>>> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>>> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>> ChangeLog v3 -> v7:
>>> - introduce TESTCLEARHPAGEFLAG() to determine the value of migratable_cleared
>>
>> Many thanks for update, Naoya. I'm sorry but TestClearHPageMigratable() might be somewhat
>> overkill. As we discussed in previous thread:
>>
>> """
>> I think I might be nitpicking... But it seems ClearHPageMigratable is not enough here.
>>   1. In MF_COUNT_INCREASED case, we don't know whether HPageMigratable is set.
>>   2. Even if HPageMigratable is set, there might be a race window before we clear HPageMigratable?
>> So "*migratable_cleared = TestClearHPageMigratable" might be better? But I might be wrong.
>> """
>>
>> The case 2 should be a dumb problem(sorry about it). HPageMigratable() is always cleared while holding
>> the hugetlb_lock which is already held by get_huge_page_for_hwpoison(). So the only case we should care
>> about is case 1 and that can be handled by below more efficient pattern:
>> 	if (HPageMigratable)
>> 		ClearHPageMigratable()
>>
>> So the overhead of test and clear atomic ops can be avoided. But this is trival.
>>
>> Anyway, this patch still looks good to me. And my Reviewed-by tag still applies. Many thanks.
> 
> OK, so I replace this 1/4 with the following one, thank you.

Many thanks for your update, Naoya. ;) This version looks good to me too.

Thanks,
Miaohe Lin


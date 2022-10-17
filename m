Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D66F60103B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJQN34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiJQN3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:29:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91167316
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 06:29:47 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mrd5g2JjMzVhvS;
        Mon, 17 Oct 2022 21:25:11 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 21:29:45 +0800
Subject: Re: [PATCH v6 1/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove
 memory section with hwpoisoned hugepage
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221007010706.2916472-1-naoya.horiguchi@linux.dev>
 <20221007010706.2916472-2-naoya.horiguchi@linux.dev>
 <b2658c5d-2ae3-e6ea-393b-56d54498a9ee@huawei.com>
 <20221017072423.GA3660733@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8a89e602-f80c-f5b9-ca54-7082a429bd52@huawei.com>
Date:   Mon, 17 Oct 2022 21:29:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221017072423.GA3660733@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2022/10/17 15:24, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Sat, Oct 15, 2022 at 09:58:09AM +0800, Miaohe Lin wrote:
>> On 2022/10/7 9:07, Naoya Horiguchi wrote:
> ...
>>> @@ -1785,7 +1785,8 @@ void hugetlb_clear_page_hwpoison(struct page *hpage)
>>>   *   -EBUSY        - the hugepage is busy (try to retry)
>>>   *   -EHWPOISON    - the hugepage is already hwpoisoned
>>>   */
>>> -int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>>> +int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>>> +				 bool *migratable_cleared)
>>>  {
>>>  	struct page *page = pfn_to_page(pfn);
>>>  	struct page *head = compound_head(page);
>>> @@ -1815,6 +1816,15 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>>>  		goto out;
>>>  	}
>>>  
>>> +	/*
>>> +	 * Clearing HPageMigratable for hwpoisoned hugepages to prevent them
>>> +	 * from being migrated by memory hotremove.
>>> +	 */
>>> +	if (count_increased) {
>>> +		*migratable_cleared = true;
>>> +		ClearHPageMigratable(head);
>>
>> I think I might be nitpicking... But it seems ClearHPageMigratable is not enough here.
>>   1. In MF_COUNT_INCREASED case, we don't know whether HPageMigratable is set.
>>   2. Even if HPageMigratable is set, there might be a race window before we clear HPageMigratable?
> 
> Maybe this race is what I mentioned in
> https://lore.kernel.org/linux-mm/20220928012647.GA597297@u2004.lan/
> (the second scenario).  My stance to this case is that the hugepage is not
> hwpoisoned even if some hardware (not visible to kernel) issue is in it,
> so hwpoison handler can/may not cope with the race.
> I guess that this could be handled by applying memcpy_mcsafe() mechanism
> to page migration, but I'm not sure of the feasibility.

Thanks Naoya. memcpy_mcsafe() might be a good idea to handle hwpoison with the memory copy in
page migration path. And [1] is doing the similar thing. If this mechanism is applicable, then
we could handle more memory failure scene. ;)

[1] https://lore.kernel.org/linux-mm/20221010160142.1087120-1-jiaqiyan@google.com/

> 
>> So "*migratable_cleared = TestClearHPageMigratable" might be better? But I might be wrong.
> 
> Thanks, this seems work for 1 (I need testing to check it), so I'll do this
> in the next post.

Many thanks for your work.

Thanks,
Miaohe Lin

> 
>>
>> With above fixed (if it's really a problem), this patch looks good to me.
>>
>> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Thank you very much.
> 
> - Naoya Horiguchi
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331CA60103C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJQNbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiJQNbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:31:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC002CE29
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 06:31:35 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mrd9F1t32zpVtf;
        Mon, 17 Oct 2022 21:28:17 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 21:31:33 +0800
Subject: Re: [PATCH v6 4/4] mm/hwpoison: introduce per-memory_block hwpoison
 counter
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
 <20221007010706.2916472-5-naoya.horiguchi@linux.dev>
 <3a6e403d-15d1-f419-698a-b1c825f59472@huawei.com>
 <20221017114311.GA3679212@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <86df156c-2f87-2653-c1b9-495d724d2113@huawei.com>
Date:   Mon, 17 Oct 2022 21:31:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221017114311.GA3679212@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2022/10/17 19:43, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Sat, Oct 15, 2022 at 10:28:00AM +0800, Miaohe Lin wrote:
>> On 2022/10/7 9:07, Naoya Horiguchi wrote:
> ...
>>> diff --git a/include/linux/memory.h b/include/linux/memory.h
>>> index aa619464a1df..ad8cd9bb3239 100644
>>> --- a/include/linux/memory.h
>>> +++ b/include/linux/memory.h
>>> @@ -85,6 +85,9 @@ struct memory_block {
>>>  	unsigned long nr_vmemmap_pages;
>>>  	struct memory_group *group;	/* group (if any) for this block */
>>>  	struct list_head group_next;	/* next block inside memory group */
>>> +#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_MEMORY_HOTPLUG)
>>> +	atomic_long_t nr_hwpoison;
>>> +#endif
>>>  };
>>>  
>>>  int arch_get_memory_phys_device(unsigned long start_pfn);
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 17119dbf8fad..f80269e90772 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -3280,6 +3280,7 @@ extern int soft_offline_page(unsigned long pfn, int flags);
>>>  extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>>>  					bool *migratable_cleared);
>>>  extern void num_poisoned_pages_inc(unsigned long pfn);
>>> +extern void num_poisoned_pages_sub(unsigned long pfn, long i);
>>
>> The prototype of this function is: *inline* void num_poisoned_pages_sub(unsigned long pfn, long i).
>> The combination of inline and extern looks weird to me. Is this a common use case?
> 
> No, it seems not.  I can find a few place of such a comination like task_curr()
> and raise_softirq_irqoff(), but as long as I understand, there's little meaning
> (showing explicitly but redundant) to add extern keyword to functions in shared
> header files. So I think of dropping the extern keyword.

That looks fine to me. My Reviewed-by tag still applies. Thanks Naoya.

Thanks,
Miaohe Lin

> 
>>
>> Anyway, this patch looks good to me. Thanks.
>> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Thank you.
> 
> - Naoya Horiguchi
> 


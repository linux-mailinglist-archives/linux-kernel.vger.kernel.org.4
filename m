Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F675F826D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 04:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiJHCd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 22:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJHCd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 22:33:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB007DB74E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 19:33:56 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mkpyg25mxzHtv1;
        Sat,  8 Oct 2022 10:28:59 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 10:33:54 +0800
Subject: Re: [PATCH v3 1/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove
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
References: <20220921091359.25889-1-naoya.horiguchi@linux.dev>
 <20220921091359.25889-2-naoya.horiguchi@linux.dev>
 <91a4759f-88e4-f9ac-aff5-41d2db5ecfdd@huawei.com>
 <20220928012647.GA597297@u2004.lan>
 <e75128b5-ea83-48b4-8371-d146ed391f86@huawei.com>
 <20221007004501.GA3227576@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <87ca9ce8-46bb-0b3e-2c84-aa24c0bad555@huawei.com>
Date:   Sat, 8 Oct 2022 10:33:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221007004501.GA3227576@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/7 8:45, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Wed, Sep 28, 2022 at 05:32:12PM +0800, Miaohe Lin wrote:
>> On 2022/9/28 9:26, Naoya Horiguchi wrote:
>>>>> @@ -1815,6 +1815,13 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
> ...
>>>>> @@ -1862,6 +1869,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>>>>>  
>>>>>  	if (hwpoison_filter(p)) {
>>>>>  		hugetlb_clear_page_hwpoison(head);
>>>>> +		SetHPageMigratable(head);
>>>>
>>>> Would we set HPageMigratable flag for free hugetlb pages here? IIUC, they're not expected to have this flag set.
>>>
>>> Thank you, you're right.  This should be done in "if (res == 1)" block.
>>
>> If res == 1, it means hugetlb page refcnt is incremented. But it seems this does not necessarily mean
>> HPageMigratable is cleared by __get_huge_page_for_hwpoison() if the hugetlb page is already isolated.
>> If so, we might set HPageMigratable flag back for already isolated hugetlb pages?
> 
> # sorry for my late reply, I was busy with personal matters these days...

That's all right. I was back from my vacation too. Thanks for your work. :)

> 
> Yes, that could happen (and also in the case where MF_COUNT_INCREASED is
> set).  We need store whether HPageMigratable flag is cleared or not in
> __get_huge_page_for_hwpoison().  I'll add a parameter to
> __get_huge_page_for_hwpoison() to return the flag change to the caller.
> But I also think that there're a few internal states during error handling,
> so it might be good to add some structure like "struct hwpoison_control"
> to save such internal states over related functions (not in this series).

That sounds like a good idea.

Thanks,
Miaohe Lin

> 
> Thanks,
> Naoya Horiguchi
> 


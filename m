Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65942685C98
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjBABXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjBABXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:23:32 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AAD2DE6E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:23:30 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P63z95QwVznVDY;
        Wed,  1 Feb 2023 09:21:25 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 1 Feb 2023 09:23:27 +0800
Message-ID: <fe90fffc-3693-6fbe-6fbf-805616dd022e@huawei.com>
Date:   Wed, 1 Feb 2023 09:23:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next resend v3] mm: hwposion: support recovery from
 ksm_might_need_to_copy()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
References: <20221213030557.143432-1-wangkefeng.wang@huawei.com>
 <20221213120523.141588-1-wangkefeng.wang@huawei.com>
 <20221216014729.GA2116060@hori.linux.bs1.fc.nec.co.jp>
 <dbb212bb-fac9-cb38-a32e-b64755a67d29@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <dbb212bb-fac9-cb38-a32e-b64755a67d29@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/17 10:24, Miaohe Lin wrote:
> On 2022/12/16 9:47, HORIGUCHI NAOYA(堀口 直也) wrote:
>> On Tue, Dec 13, 2022 at 08:05:23PM +0800, Kefeng Wang wrote:
>>> When the kernel copy a page from ksm_might_need_to_copy(), but runs
>>> into an uncorrectable error, it will crash since poisoned page is
>>> consumed by kernel, this is similar to Copy-on-write poison recovery,
>>
>> Maybe you mean "this is similar to the issue recently fixed by
>> Copy-on-write poison recovery."?  And if this sentence ends here,
>> please put "." instead of ",".
>>
>>> When an error is detected during the page copy, return VM_FAULT_HWPOISON
>>> in do_swap_page(), and install a hwpoison entry in unuse_pte() when
>>> swapoff, which help us to avoid system crash.  Note, memory failure on
>>> a KSM page will be skipped, but still call memory_failure_queue() to
>>> be consistent with general memory failure process.
>>
>> Thank you for the work.  I have a few comment below ...
> 
> Thanks both.
> 
>>> -	if (unlikely(!PageUptodate(page))) {
>>> -		pte_t pteval;
>>> +	if (hwposioned || !PageUptodate(page)) {
>>> +		swp_entry_t swp_entry;
>>>   
>>>   		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
>>> -		pteval = swp_entry_to_pte(make_swapin_error_entry());
>>> -		set_pte_at(vma->vm_mm, addr, pte, pteval);
>>> -		swap_free(entry);
>>> +		if (hwposioned) {
>>> +			swp_entry = make_hwpoison_entry(swapcache);
>>> +			page = swapcache;
>>
>> This might work for the process accessing to the broken page, but ksm
>> pages are likely to be shared by multiple processes, so it would be
>> much nicer if you can convert all mapping entries for the error ksm page
>> into hwpoisoned ones.  Maybe in this thorough approach,
>> hwpoison_user_mappings() is updated to call try_to_unmap() for ksm pages.
>> But it's not necessary to do this together with applying mcsafe-memcpy,
>> because recovery action and mcsafe-memcpy can be done independently.
>>
> 
> I'm afraid leaving the ksm page in the cache will repeatedly trigger uncorrectable error for the
> same page if ksm pages are shared by multiple processes. This might reach the hardware threshold
> and result in fatal uncorrectable error (thus casuing system to panic). So IMHO it might be better
> to check if page is hwpoisoned before calling ksm_might_need_to_copy() if above thorough approach
> is not implemented. But I can easily be wrong.
> 
Oh，missing this one，there are only two caller, one in do_swap_page(),
it has already check whether the page is hwpoisoned or not, another is 
in unuse_pte() which only called from swapoff, it is not a hot patch, so
I don't think it is an urgent requirement. Thanks.

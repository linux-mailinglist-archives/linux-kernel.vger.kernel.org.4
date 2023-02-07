Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFDB68CBE1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjBGBY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjBGBYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:24:24 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B411166C6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:24:22 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P9llS2PttzfYwx;
        Tue,  7 Feb 2023 09:24:04 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 7 Feb 2023 09:24:19 +0800
Message-ID: <c74516a1-9f9d-6c5f-0dc5-7ea07c975dfb@huawei.com>
Date:   Tue, 7 Feb 2023 09:24:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
CC:     <mawupeng1@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kuleshovmail@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v3 1/4] mm/mlock: return EINVAL if len overflows for
 mlock/munlock
Content-Language: en-US
To:     <david@redhat.com>, <akpm@linux-foundation.org>
References: <20230128063229.989058-1-mawupeng1@huawei.com>
 <20230128063229.989058-2-mawupeng1@huawei.com>
 <753c53d3-84a6-da73-4121-0db4a71e4fde@redhat.com>
 <a5ae7d0c-61dc-3071-434d-5152c46c05e8@huawei.com>
 <10a3929a-7109-169f-6e42-e51c83305567@redhat.com>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <10a3929a-7109-169f-6e42-e51c83305567@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/7 1:05, David Hildenbrand wrote:
> On 06.02.23 01:48, mawupeng wrote:
>>
>>
>> On 2023/2/4 1:14, David Hildenbrand wrote:
>>> On 28.01.23 07:32, Wupeng Ma wrote:
>>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>>
>>>> While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
>>>> The return value of mlock is zero. But nothing will be locked since the
>>>> len in do_mlock overflows to zero due to the following code in mlock:
>>>>
>>>>     len = PAGE_ALIGN(len + (offset_in_page(start)));
>>>>
>>>> The same problem happens in munlock.
>>>>
>>>> Add new check and return -EINVAL to fix this overflowing scenarios since
>>>> they are absolutely wrong.
>>>>
>>>> Return 0 early to avoid burn a bunch of cpu cycles if len == 0.
>>>>
>>>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>>>> ---
>>>>    mm/mlock.c | 14 ++++++++++++--
>>>>    1 file changed, 12 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/mlock.c b/mm/mlock.c
>>>> index 7032f6dd0ce1..eb09968ba27f 100644
>>>> --- a/mm/mlock.c
>>>> +++ b/mm/mlock.c
>>>> @@ -478,8 +478,6 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
>>>>        end = start + len;
>>>>        if (end < start)
>>>>            return -EINVAL;
>>>> -    if (end == start)
>>>> -        return 0;
>>>>        vma = mas_walk(&mas);
>>>>        if (!vma)
>>>>            return -ENOMEM;
>>>> @@ -575,7 +573,13 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
>>>>        if (!can_do_mlock())
>>>>            return -EPERM;
>>>>    +    if (!len)
>>>> +        return 0;
>>>> +
>>>>        len = PAGE_ALIGN(len + (offset_in_page(start)));
>>>> +    if (!len)
>>>> +        return -EINVAL;
>>>> +
>>>>        start &= PAGE_MASK;
>>>
>>> The "ordinary" overflows are detected in apply_vma_lock_flags(), correct?
>>
>> Overflow is not checked anywhere however the ordinary return early if len == 0 is detected in apply_vma_lock_flags().
>>
> 
> I meant the
> 
> end = start + len;
> if (end < start)
>     return -EINVAL;
> 
> Essentially, what I wanted to double-check is that with your changes, we catch all kinds of overflows as documented in the man page, correct?

Oh i see. You are right, The "ordinary" overflows are detected for mlock/munlock in apply_vma_lock_flags().

Yes, we may need to update the man page for all these four syscalls.

Thanks, 

mawupeng.


> 

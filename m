Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF1C6C46A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjCVJji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCVJjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:39:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38CD1989
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:39:35 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PhNCl4h5wzSmkh;
        Wed, 22 Mar 2023 17:17:23 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 17:20:48 +0800
Message-ID: <7473311c-b259-c90d-e19b-66c27fd49dba@huawei.com>
Date:   Wed, 22 Mar 2023 17:20:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
CC:     <mawupeng1@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kuleshovmail@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v4 1/4] mm/mlock: return EINVAL if len overflows for
 mlock/munlock
Content-Language: en-US
To:     <david@redhat.com>, <akpm@linux-foundation.org>
References: <20230320024739.224850-1-mawupeng1@huawei.com>
 <20230320024739.224850-2-mawupeng1@huawei.com>
 <27b9cb5b-0118-f989-80c2-6a143a4232af@redhat.com>
 <3ef9520c-6713-527a-0214-ac7a8bb2d49c@huawei.com>
 <6dd844f7-d43b-c744-f295-9f14c68d3928@redhat.com>
 <8be13253-b4ca-b134-3e85-b4097484bb29@huawei.com>
 <9583bc53-716d-f2ff-38e7-1dda7e57dd5d@redhat.com>
 <9b531543-9f97-178f-8a97-494322410806@redhat.com>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <9b531543-9f97-178f-8a97-494322410806@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/22 17:01, David Hildenbrand wrote:
> On 22.03.23 09:54, David Hildenbrand wrote:
>> On 22.03.23 03:14, mawupeng wrote:
>>>
>>>
>>> On 2023/3/21 22:19, David Hildenbrand wrote:
>>>> On 21.03.23 08:44, mawupeng wrote:
>>>>>
>>>>>
>>>>> On 2023/3/20 18:54, David Hildenbrand wrote:
>>>>>> On 20.03.23 03:47, Wupeng Ma wrote:
>>>>>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>>>>>
>>>>>>> While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
>>>>>>> The return value of mlock is zero. But nothing will be locked since the
>>>>>>> len in do_mlock overflows to zero due to the following code in mlock:
>>>>>>>
>>>>>>>       len = PAGE_ALIGN(len + (offset_in_page(start)));
>>>>>>>
>>>>>>> The same problem happens in munlock.
>>>>>>>
>>>>>>> Add new check and return -EINVAL to fix this overflowing scenarios since
>>>>>>> they are absolutely wrong.
>>>>>>
>>>>>> Thinking again, wouldn't we reject mlock(0, ULONG_MAX) now as well?
>>>>>
>>>>> mlock will return 0 if len is zero which is the same w/o this patchset.
>>>>> Here is the calltrace if len is zero.
>>>>>
>>>>> mlock(len == 0)
>>>>>       do_mlock(len == 0)
>>>>>           if (!len)
>>>>>               return 0
>>>>>
>>>>
>>>> I was asking about addr=0, len=ULONG_MAX.
>>>>
>>>> IIUC, that used to work but could now fail? I haven't played with it, though.
>>>
>>> Thanks for reviewing.
>>>
>>> Previous for add = 0 and len == ULONG_MAX, mlock will return ok(0) since len overflows to zero.
>>> IFAICT, this is not right since mlock do noting(lock nothing) and return ok(0).
>>>
>>> With this patch, for the same situation, mlock can return EINVAL as expected.
>>
>> Quoting the man page:
>>
>> "EINVAL (mlock(),  mlock2(),  and  munlock()) The result of the addition
>> addr+len was less than addr (e.g., the addition may have resulted in an
>> overflow)."
>>
>> ULONG_MAX+0 = ULONG_MAX
>>
>> There is no overflow expected. The proper way to implement it would be
>> to handle that case and not fail with EINVAL.
>>
>> At least that would be expected when reading the man page.
>>
> 
> As a side note, I agree that failing with EINVAL is better than doing noting (mlocking nothing). But I am not sure what we are expected to do in that case ... the man page is a bit vague on that.

Thanks for you reviewing.

Can we try to expand the man page since overflow is considered in man page?

> 

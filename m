Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB22F717A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbjEaI1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjEaI1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:27:00 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49508C5
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:26:58 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QWMgq6QC8zqTfn;
        Wed, 31 May 2023 16:22:15 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 16:26:54 +0800
Subject: Re: [PATCH 2/6] kexec: delete a useless check in
 crash_shrink_memory()
To:     Baoquan He <bhe@redhat.com>
CC:     Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
 <20230527123439.772-3-thunder.leizhen@huawei.com>
 <ZHaSF4EGNwSGhGAL@MiWiFi-R3L-srv>
 <5beb1883-5391-1b75-d8cd-2152478b9e72@huawei.com>
 <ZHb6IFhwRMkAkNjt@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <e8f84a24-5c8a-4b98-db0b-68630d58ebd0@huawei.com>
Date:   Wed, 31 May 2023 16:26:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZHb6IFhwRMkAkNjt@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/31 15:41, Baoquan He wrote:
> On 05/31/23 at 10:19am, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2023/5/31 8:17, Baoquan He wrote:
>>> On 05/27/23 at 08:34pm, Zhen Lei wrote:
>>>> The check '(crashk_res.parent != NULL)' is added by
>>>> commit e05bd3367bd3 ("kexec: fix Oops in crash_shrink_memory()"), but it's
>>>> stale now. Because if 'crashk_res' is not reserved, it will be zero in
>>>> size and will be intercepted by the above 'if (new_size >= old_size)'.
>>>>
>>>> Ago:
>>>> 	if (new_size >= end - start + 1)
>>>>
>>>> Now:
>>>> 	old_size = (end == 0) ? 0 : end - start + 1;
>>>> 	if (new_size >= old_size)
>>>
>>> Hmm, I would strongly suggest we keep that check. Even though the
>>> current code like above can do the acutal checking, but its actual usage
>>> is not obvious for checking of crashk_res existence. In the future,
>>> someone may change above calculation and don't notice the hidden
>>> functionality at all behind the calculation. The cost of the check is
>>> almost zero, right?
>>
>> The cost of the check is negligible. The only downside is that it's hard to
>> understand why it's added, and I only found out why by looking at the history
>> log. In my opinion, the above 'Now:' is the right fix.
> 
> It checks if the resource exists before releasing, just a normal
> checking?

If resource_size(&crashk_res) is zero, it means that crashk_res has not been
added(insert_resource) or has been deleted(release_resource). I've tested it. It's okay.

>>
>>>
>>>>
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>> ---
>>>>  kernel/kexec_core.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>>>> index 22acee18195a591..d1ab139dd49035e 100644
>>>> --- a/kernel/kexec_core.c
>>>> +++ b/kernel/kexec_core.c
>>>> @@ -1137,7 +1137,7 @@ int crash_shrink_memory(unsigned long new_size)
>>>>  	end = start + new_size;
>>>>  	crash_free_reserved_phys_range(end, crashk_res.end);
>>>>  
>>>> -	if ((start == end) && (crashk_res.parent != NULL))
>>>> +	if (start == end)
>>>>  		release_resource(&crashk_res);
>>>>  
>>>>  	ram_res->start = end;
>>>> -- 
>>>> 2.25.1
>>>>
>>>
>>> .
>>>
>>
>> -- 
>> Regards,
>>   Zhen Lei
>>
> 
> 
> .
> 

-- 
Regards,
  Zhen Lei

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA51F61E841
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 02:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiKGB0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 20:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiKGB0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 20:26:03 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41453656C
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 17:26:01 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N5D3x3WYCzpWCd;
        Mon,  7 Nov 2022 09:22:21 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 09:25:59 +0800
Message-ID: <017634f7-fa60-64d3-6c4f-e82f4d5e4cbd@huawei.com>
Date:   Mon, 7 Nov 2022 09:25:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH -next v2] checkpatch: Add check for array allocator family
 argument order
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Joe Perches <joe@perches.com>, <apw@canonical.com>,
        <dwaipayanray1@gmail.com>, <lukas.bulwahn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <pbonzini@redhat.com>
References: <20221104070523.60296-1-liaochang1@huawei.com>
 <dc5a7c79-af45-0e64-80fa-9f1ca8907033@wanadoo.fr>
 <85bcafd00fbbf9c8199ce9d10cfa959791a1b96a.camel@perches.com>
 <e22ecdd4-5a46-b573-6a41-f0c980722f0b@wanadoo.fr>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <e22ecdd4-5a46-b573-6a41-f0c980722f0b@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/6 5:36, Christophe JAILLET 写道:
> 
> Le 05/11/2022 à 18:24, Joe Perches a écrit :
>> On Fri, 2022-11-04 at 18:08 +0100, Christophe JAILLET wrote:
>>> Le 04/11/2022 à 08:05, Liao Chang a écrit :
>>>> These array allocator family are sometimes misused with the first and
>>>> second arguments switchted.
>>>>
>>>> Same issue with calloc, kvcalloc, kvmalloc_array etc.
>>>>
>>>> Bleat if sizeof is the first argument.
>>>>
>>>> Link: https://lore.kernel.org/lkml/5374345c-7973-6a3c-d559-73bf4ac15079@redhat.com/
>>>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>>>> Acked-by: Joe Perches <joe@perches.com>
>>>> ---
>>>> v2:
>>>> 1. Acked-by Joe Perches.
>>>> 2. Use lore links in Link tag.
>>>>
>>>> ---
>>>>    scripts/checkpatch.pl | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>>> index 1e5e66ae5a52..a9a9dc277cff 100755
>>>> --- a/scripts/checkpatch.pl
>>>> +++ b/scripts/checkpatch.pl
>>>> @@ -7128,7 +7128,7 @@ sub process {
>>>>            }
>>>>       # check for alloc argument mismatch
>>>> -        if ($line =~ /\b((?:devm_)?(?:kcalloc|kmalloc_array))\s*\(\s*sizeof\b/) {
>>>> +        if ($line =~ /\b((?:devm_)?((?:k|kv)?(calloc|malloc_array)(?:_node)?))\s*\(\s*sizeof\b/) {
>>>>                WARN("ALLOC_ARRAY_ARGS",
>>>>                     "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
>>>>            }
>>> Hi,
>>>
>>> Should the devm_ and not devm_ cases be separated?
>>>
>>> In the devm_case, sizeof will never be just after the first '('.
>> Right.
>>
>> Likely this works better:
>> ---
>>   scripts/checkpatch.pl | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 7be93c3df2bcb..7f37976a9f8b5 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -7145,12 +7145,18 @@ sub process {
>>                    "Reusing the krealloc arg is almost always a bug\n" . $herecurr);
>>           }
>>   -# check for alloc argument mismatch
>> -        if ($line =~ /\b((?:devm_)?(?:kcalloc|kmalloc_array))\s*\(\s*sizeof\b/) {
>> +# check for alloc argument mismatch in alloc functions
>> +        if ($line =~ /\b(((?:k|kv)?(calloc|malloc_array)(?:_node)?))\s*\(\s*sizeof\b/) {
>>               WARN("ALLOC_ARRAY_ARGS",
>>                    "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
>>           }
>>   +# check for alloc argument mismatch in devm_ alloc functions
>> +        if ($line =~ /\b(devm_((?:k|kv)?(calloc|malloc_array)(?:_node)?))\s*\(\s*$FuncArg\s*,\s*sizeof\b/) {
>> +            WARN("ALLOC_ARRAY_ARGS",
>> +                 "$1 uses number as second arg, sizeof is generally wrong\n" . $herecurr);
>> +        }
>> +
>>   # check for multiple semicolons
>>           if ($line =~ /;\s*;\s*$/) {
>>               if (WARN("ONE_SEMICOLON",
>>
> +1
> 
+1, thanks.

BTW, i find the v2 has been added to the -mm mm-nonmm-unstable branch,
do i need to submit new version includes above change?

> 
> .

-- 
BR,
Liao, Chang

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D6F7349BA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 03:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjFSBek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 21:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFSBef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 21:34:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7BE1BF
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 18:34:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qksjs0JnKzTlWv;
        Mon, 19 Jun 2023 09:33:53 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 19 Jun 2023 09:34:30 +0800
Subject: Re: [PATCH] mm/mm_init.c: remove obsolete macro HASH_SMALL
To:     Mike Rapoport <rppt@kernel.org>
CC:     <akpm@linux-foundation.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <peterz@infradead.org>, <dvhart@infradead.org>,
        <dave@stgolabs.net>, <andrealmeid@igalia.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230617070955.1751393-1-linmiaohe@huawei.com>
 <20230617075644.GV52412@kernel.org>
 <6d149902-a944-7961-89c1-f07047953c7f@huawei.com>
 <20230617105137.GX52412@kernel.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e9c0f02e-d848-1d7f-624d-311fe0368fc1@huawei.com>
Date:   Mon, 19 Jun 2023 09:34:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230617105137.GX52412@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/17 18:51, Mike Rapoport wrote:
> On Sat, Jun 17, 2023 at 04:39:44PM +0800, Miaohe Lin wrote:
>> On 2023/6/17 15:56, Mike Rapoport wrote:
>>> On Sat, Jun 17, 2023 at 03:09:55PM +0800, Miaohe Lin wrote:
>>>> HASH_SMALL only works when parameter numentries is 0. But the sole caller
>>>> futex_init() never calls alloc_large_system_hash() with numentries set to
>>>> 0. 
>>>
>>
>> Thanks for your quick review.
>>
>>> Doesn't it? 
>>> What happens when CONFIG_BASE_SMALL is set?
>>
>> When CONFIG_BASE_SMALL is set, futex_hashsize is set to 16 and alloc_large_system_hash() is called with
>> numentries == 16 && flags == HASH_SMALL. But in the alloc_large_system_hash(), we have the below logic:
>>
>> alloc_large_system_hash()
>> {
>>   if (!numentries) { /* numentries == 16 here, so this code block is skipped. */
>>     ...
>>     if (unlikely(flags & HASH_SMALL)) { /* So as here. */
>>       ...
>>   }
>>   ...
>> }
>>
>> So HASH_SMALL is just unused. Or am I miss something?
> 
> You are right, I've missed that. 
> 
>> Thanks.
>>
>>>
>>>> So HASH_SMALL is obsolete and remove it.
>>>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>  include/linux/memblock.h |  2 --
>>>>  kernel/futex/core.c      |  3 +--
>>>>  mm/mm_init.c             | 10 +---------
>>>>  3 files changed, 2 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>>>> index f71ff9f0ec81..346d80809517 100644
>>>> --- a/include/linux/memblock.h
>>>> +++ b/include/linux/memblock.h
>>>> @@ -581,8 +581,6 @@ extern void *alloc_large_system_hash(const char *tablename,
>>>>  				     unsigned long high_limit);
>>>>  
>>>>  #define HASH_EARLY	0x00000001	/* Allocating during early boot? */
>>>> -#define HASH_SMALL	0x00000002	/* sub-page allocation allowed, min
>>>> -					 * shift passed via *_hash_shift */
>>>>  #define HASH_ZERO	0x00000004	/* Zero allocated hash table */
> 
> Can you update HASH_ZERO to 0x2?

Will do. Thanks.

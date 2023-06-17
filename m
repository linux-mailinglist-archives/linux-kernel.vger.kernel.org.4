Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E96733FB3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 10:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjFQIkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 04:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjFQIjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 04:39:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6BF10F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:39:47 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QjqCz4cvNzLmrR;
        Sat, 17 Jun 2023 16:37:51 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 17 Jun 2023 16:39:44 +0800
Subject: Re: [PATCH] mm/mm_init.c: remove obsolete macro HASH_SMALL
To:     Mike Rapoport <rppt@kernel.org>
CC:     <akpm@linux-foundation.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <peterz@infradead.org>, <dvhart@infradead.org>,
        <dave@stgolabs.net>, <andrealmeid@igalia.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230617070955.1751393-1-linmiaohe@huawei.com>
 <20230617075644.GV52412@kernel.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6d149902-a944-7961-89c1-f07047953c7f@huawei.com>
Date:   Sat, 17 Jun 2023 16:39:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230617075644.GV52412@kernel.org>
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

On 2023/6/17 15:56, Mike Rapoport wrote:
> On Sat, Jun 17, 2023 at 03:09:55PM +0800, Miaohe Lin wrote:
>> HASH_SMALL only works when parameter numentries is 0. But the sole caller
>> futex_init() never calls alloc_large_system_hash() with numentries set to
>> 0. 
> 

Thanks for your quick review.

> Doesn't it? 
> What happens when CONFIG_BASE_SMALL is set?

When CONFIG_BASE_SMALL is set, futex_hashsize is set to 16 and alloc_large_system_hash() is called with
numentries == 16 && flags == HASH_SMALL. But in the alloc_large_system_hash(), we have the below logic:

alloc_large_system_hash()
{
  if (!numentries) { /* numentries == 16 here, so this code block is skipped. */
    ...
    if (unlikely(flags & HASH_SMALL)) { /* So as here. */
      ...
  }
  ...
}

So HASH_SMALL is just unused. Or am I miss something?

Thanks.

> 
>> So HASH_SMALL is obsolete and remove it.
> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  include/linux/memblock.h |  2 --
>>  kernel/futex/core.c      |  3 +--
>>  mm/mm_init.c             | 10 +---------
>>  3 files changed, 2 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index f71ff9f0ec81..346d80809517 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -581,8 +581,6 @@ extern void *alloc_large_system_hash(const char *tablename,
>>  				     unsigned long high_limit);
>>  
>>  #define HASH_EARLY	0x00000001	/* Allocating during early boot? */
>> -#define HASH_SMALL	0x00000002	/* sub-page allocation allowed, min
>> -					 * shift passed via *_hash_shift */
>>  #define HASH_ZERO	0x00000004	/* Zero allocated hash table */
>>  
>>  /* Only NUMA needs hash distribution. 64bit NUMA architectures have
>> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
>> index 514e4582b863..f10587d1d481 100644
>> --- a/kernel/futex/core.c
>> +++ b/kernel/futex/core.c
>> @@ -1132,8 +1132,7 @@ static int __init futex_init(void)
>>  #endif
>>  
>>  	futex_queues = alloc_large_system_hash("futex", sizeof(*futex_queues),
>> -					       futex_hashsize, 0,
>> -					       futex_hashsize < 256 ? HASH_SMALL : 0,
>> +					       futex_hashsize, 0, 0,
>>  					       &futex_shift, NULL,
>>  					       futex_hashsize, futex_hashsize);
>>  	futex_hashsize = 1UL << futex_shift;
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index d393631599a7..fab3c4649d5b 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -2492,15 +2492,7 @@ void *__init alloc_large_system_hash(const char *tablename,
>>  		else
>>  			numentries <<= (PAGE_SHIFT - scale);
>>  
>> -		/* Make sure we've got at least a 0-order allocation.. */
>> -		if (unlikely(flags & HASH_SMALL)) {
>> -			/* Makes no sense without HASH_EARLY */
>> -			WARN_ON(!(flags & HASH_EARLY));
>> -			if (!(numentries >> *_hash_shift)) {
>> -				numentries = 1UL << *_hash_shift;
>> -				BUG_ON(!numentries);
>> -			}
>> -		} else if (unlikely((numentries * bucketsize) < PAGE_SIZE))
>> +		if (unlikely((numentries * bucketsize) < PAGE_SIZE))
>>  			numentries = PAGE_SIZE / bucketsize;
>>  	}
>>  	numentries = roundup_pow_of_two(numentries);
>> -- 
>> 2.27.0
>>
> 


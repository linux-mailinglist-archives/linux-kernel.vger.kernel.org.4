Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852556C2B04
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjCUHFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCUHFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:05:05 -0400
Received: from out-24.mta1.migadu.com (out-24.mta1.migadu.com [95.215.58.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03E414EBB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:05:02 -0700 (PDT)
Message-ID: <c22e1d58-e16f-fde5-cee7-c13dedbe1656@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679382299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+McZTV1kAS70sseCFB9E43G9HETXQ3b8ag52JbteiD0=;
        b=CJL06fy9Y/XNtRhQXe1npEGcF1jFne3go0w6cCUnG7ZySGZtj8jkIWiMXOiMlNC1gWEP9f
        fR1vAOULQZrNyar2EDI+qg5PsTB9vKe6mP4Es8h4IzlElQAI209GZcBkFuSWRiZ9O2QLQw
        /YQngQDOs65kiseKrpdVlavJoQUSVls=
Date:   Tue, 21 Mar 2023 15:04:46 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] mm: kfence: fix PG_slab and memcg_data clearing
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dvyukov@google.com,
        roman.gushchin@linux.dev, jannh@google.com, sjpark@amazon.de,
        akpm@linux-foundation.org, elver@google.com, glider@google.com,
        Muchun Song <songmuchun@bytedance.com>
References: <20230320030059.20189-1-songmuchun@bytedance.com>
 <974ef73e-ab4f-7b24-d070-c981654e8c22@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <974ef73e-ab4f-7b24-d070-c981654e8c22@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/21 12:14, Peng Zhang wrote:
>
> 在 2023/3/20 11:00, Muchun Song 写道:
>> It does not reset PG_slab and memcg_data when KFENCE fails to initialize
>> kfence pool at runtime. It is reporting a "Bad page state" message when
>> kfence pool is freed to buddy. The checking of whether it is a compound
>> head page seems unnecessary sicne we already guarantee this when 
>> allocating
>> kfence pool, removing the check to simplify the code.
>>
>> Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
>> Fixes: 8f0b36497303 ("mm: kfence: fix objcgs vector allocation")
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>   mm/kfence/core.c | 30 +++++++++++++++---------------
>>   1 file changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
>> index 79c94ee55f97..d66092dd187c 100644
>> --- a/mm/kfence/core.c
>> +++ b/mm/kfence/core.c
>> @@ -561,10 +561,6 @@ static unsigned long kfence_init_pool(void)
>>           if (!i || (i % 2))
>>               continue;
>>   -        /* Verify we do not have a compound head page. */
>> -        if (WARN_ON(compound_head(&pages[i]) != &pages[i]))
>> -            return addr;
>> -
>>           __folio_set_slab(slab_folio(slab));
>>   #ifdef CONFIG_MEMCG
>>           slab->memcg_data = (unsigned long)&kfence_metadata[i / 2 - 
>> 1].objcg |
>> @@ -597,12 +593,26 @@ static unsigned long kfence_init_pool(void)
>>             /* Protect the right redzone. */
>>           if (unlikely(!kfence_protect(addr + PAGE_SIZE)))
>> -            return addr;
>> +            goto reset_slab;
>>             addr += 2 * PAGE_SIZE;
>>       }
>>         return 0;
>> +
>> +reset_slab:
>> +    for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
>> +        struct slab *slab = page_slab(&pages[i]);
>> +
>> +        if (!i || (i % 2))
>> +            continue;
>> +#ifdef CONFIG_MEMCG
>> +        slab->memcg_data = 0;
>> +#endif
>> +        __folio_clear_slab(slab_folio(slab));
>> +    }
> Can this loop be simplified to this?
>
>     for (i = 2; i < KFENCE_POOL_SIZE / PAGE_SIZE; i+=2) {
>         struct slab *slab = page_slab(&pages[i]);
> #ifdef CONFIG_MEMCG
>         slab->memcg_data = 0;
> #endif
>         __folio_clear_slab(slab_folio(slab));
>     }
>

It's a good simplification. The loop setting Pg_slab before this
also can be simplified in the same way. However, I choose a
consistent way to fix this bug. I'd like to send a separate
simplification patch to simplify both two loops instead of
in a bugfix patch.

Thanks.

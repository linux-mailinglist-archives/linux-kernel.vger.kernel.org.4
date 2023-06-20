Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0410D7363F4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjFTHFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFTHFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:05:08 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C71CC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:05:04 -0700 (PDT)
X-QQ-mid: bizesmtp68t1687244697t5j1vrfc
Received: from [192.168.1.114] ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 20 Jun 2023 15:04:55 +0800 (CST)
X-QQ-SSF: 00200000000000B08000000A0000000
X-QQ-FEAT: J5JfekO1WsjPosBijC6AUvsD8qiWRMfmiqOBKJ2jPS0mNmwhUxXYF2849gB0/
        88ldsBiRsnqOAnCs4rPW3d/sO2JqkLFBfsbwrAIvNkSqDJXTCabS/lwB++SOpmUOkZhe+41
        eyYUM1ni6LJTW92kCR23uaHISKqsdpOG59j7qFCN7zX4aR+5kwptACrhSSUWwmLFStqaFJL
        hfb4ixh2r/8aiDc3uIQkyDk34/x+cq9KIexbGIN+4JYtfeO627sfGoFGZTmkc1ZCV0QWCXh
        RVFYiZBXx1lMYC6Jvw6ZsegtIyOoQNS8CLRdaA87WcqxaPDnntgGJAatkRtCY0puz1AxHj+
        BMcXbw7fAY2dO4puZCma/EO3VXdJA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16156462231222719866
Message-ID: <6EA2B512AB4F2017+9d56e9b9-a875-9799-147b-1c8adc693507@tinylab.org>
Date:   Tue, 20 Jun 2023 15:04:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] memblock: Add error message when memblock_can_resize is
 not ready
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230614131746.3670303-1-songshuaishuai@tinylab.org>
 <20230614160710.GH52412@kernel.org>
From:   Song Shuai <songshuaishuai@tinylab.org>
In-Reply-To: <20230614160710.GH52412@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for not replying to you in time

在 2023/6/15 00:07, Mike Rapoport 写道:
> Hi,
> 
> On Wed, Jun 14, 2023 at 09:17:46PM +0800, Song Shuai wrote:
>> The memblock APIs are always correct, thus the callers usually don't
>> handle the return code. But the failure caused by unready memblock_can_resize
>> is hard to recognize without the return code. Like this piece of log:
> 
> Please make it clear that failure is in memblock_double_array(), e.g.
> 

Having numerous memblock reservations at early boot where 
memblock_can_resize is unset
may exhaust the INIT_MEMBLOCK_REGIONS sized memblock.reserved regions 
and try to
double the region array via memblock_double_array() which fails and 
returns -1 to the caller.

You can find the numerous memblock reservations reported by this commit
24cc61d8cb5a ("arm64: memblock: don't permit memblock resizing until 
linear mapping is up").
And the similar test sense can be simulated by a constructed dtb with 
numerous discrete
/memreserve/ or /reserved-memory regions.

> But when memblock_double_array() is called before memblock_can_resize
> is true, it is hard to understand the actual reason for the failure.
> 
>>
>> ```
>> [    0.000000] memblock_phys_alloc_range: 4096 bytes align=0x1000 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_pmd_fixmap+0x14/0x1c
>> [    0.000000] memblock_reserve: [0x000000017ffff000-0x000000017fffffff] memblock_alloc_range_nid+0xb8/0x128
>> [    0.000000] Oops - store (or AMO) access fault [#1]
>> ```
>>
>> So add an error message for this kind of failure:
>>
>> ```
>> [    0.000000] memblock_phys_alloc_range: 4096 bytes align=0x1000 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_pmd_fixmap+0x14/0x1c
>> [    0.000000] memblock_reserve: [0x000000017ffff000-0x000000017fffffff] memblock_alloc_range_nid+0xb8/0x128
>> [    0.000000] memblock: Can't double reserved array for area start 0x000000017ffff000 size 4096
>> [    0.000000] Oops - store (or AMO) access fault [#1]
>> ```
>>
>> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
>> ---
>>   mm/memblock.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 3feafea06ab2..ab952a164f62 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -418,8 +418,11 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
>>   	/* We don't allow resizing until we know about the reserved regions
>>   	 * of memory that aren't suitable for allocation
>>   	 */
>> -	if (!memblock_can_resize)
>> +	if (!memblock_can_resize) {
>> +		pr_err("memblock: Can't double %s array for area start %pa size %ld\n",
>> +			type->name, &new_area_start, (unsigned long)new_area_size);
> 
> Most of the time memblock uses %llu and cast to u64 to print size, please
> make this consistent.
I will fix it in next version if the above description is ok for you.
> 
>>   		return -1;
>> +	}
>>   
>>   	/* Calculate new doubled size */
>>   	old_size = type->max * sizeof(struct memblock_region);
>> -- 
>> 2.20.1
>>
>>
> 

-- 
Thanks
Song Shuai


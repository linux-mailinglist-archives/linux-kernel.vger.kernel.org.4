Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3188F6B67DA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCLQOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCLQOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:14:30 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF225868A;
        Sun, 12 Mar 2023 09:14:27 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id EC8CA1C0002;
        Sun, 12 Mar 2023 16:14:20 +0000 (UTC)
Message-ID: <8b338d50-d790-a2e9-9ba9-fde444309bfc@ghiti.fr>
Date:   Sun, 12 Mar 2023 17:14:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 2/4] mm: Introduce memblock_isolate_memory
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org
References: <20230310094539.764357-1-alexghiti@rivosinc.com>
 <20230310094539.764357-3-alexghiti@rivosinc.com>
 <ZA2c4X+acRLHKV38@kernel.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <ZA2c4X+acRLHKV38@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/12/23 10:35, Mike Rapoport wrote:
> Hi Alexandre,
>
> On Fri, Mar 10, 2023 at 10:45:37AM +0100, Alexandre Ghiti wrote:
>> This function allows to split a region in memblock.memory and will be
>> useful when setting up the linear mapping with STRICT_KERNEL_RWX: it
>> allows to isolate the kernel text/rodata and then avoid to map those
>> regions with a PUD/P4D/PGD.
>>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>   include/linux/memblock.h |  1 +
>>   mm/memblock.c            | 22 +++++++++++++++++++++-
>>   2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index 50ad19662a32..2f7ef97c0da7 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -125,6 +125,7 @@ int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
>>   int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
>>   int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
>>   int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
>> +int memblock_isolate_memory(phys_addr_t base, phys_addr_t size);
>>   
>>   void memblock_free_all(void);
>>   void memblock_free(void *ptr, size_t size);
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 25fd0626a9e7..d8cf1c9eccf0 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -753,7 +753,8 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>>   	int idx;
>>   	struct memblock_region *rgn;
>>   
>> -	*start_rgn = *end_rgn = 0;
>> +	if (start_rgn && end_rgn)
>> +		*start_rgn = *end_rgn = 0;
> Generally, it's possible that either start_rgn or end_rgn will be a valid
> pointer and this should be handled here and below.
>
> My preference, though would be to leave memblock_isolate_range() as is and
> have unused start_rgn and end_rgn in memblock_isolate_memory().


Sure, I'll do that then.


>
>>   
>>   	if (!size)
>>   		return 0;
>> @@ -795,6 +796,9 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>>   					       memblock_get_region_node(rgn),
>>   					       rgn->flags);
>>   		} else {
>> +			if (!end_rgn || !start_rgn)
>> +				continue;
>> +
>>   			/* @rgn is fully contained, record it */
>>   			if (!*end_rgn)
>>   				*start_rgn = idx;
>> @@ -805,6 +809,22 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>>   	return 0;
>>   }
>>   
>> +/**
>> + * memblock_isolate_memory - isolate given range from memblock.memory
> I think it'd better to use "... range in memblock.memory"


Ok


>
>> + * @base: base of range to isolate
>> + * @size: size of range to isolate
>> + *
>> + * Call memblock_isolate_range on memblock.memory to isolate the given range.
> Please elaborate that isolate means that the range does not share regions
> with other ranges.


Sure, thanks, I'll come up with a v8 tomorrow along with other fixes 
(rv32 and arm64 comments that I forgot to remove).

Thanks again,

Alex


>> + *
>> + * Return:
>> + * 0 on success, -errno on failure.
>> + */
>> +
>> +int __init_memblock memblock_isolate_memory(phys_addr_t base, phys_addr_t size)
>> +{
>> +	return memblock_isolate_range(&memblock.memory, base, size, NULL, NULL);
>> +}
>> +
>>   static int __init_memblock memblock_remove_range(struct memblock_type *type,
>>   					  phys_addr_t base, phys_addr_t size)
>>   {
>> -- 
>> 2.37.2
>>

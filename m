Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3306C1004
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjCTK7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCTK6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:58:35 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8580B274BF;
        Mon, 20 Mar 2023 03:55:04 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 2F98D20003;
        Mon, 20 Mar 2023 10:54:14 +0000 (UTC)
Message-ID: <efe1ef6b-b1c2-8d5b-82b7-3cd64053643e@ghiti.fr>
Date:   Mon, 20 Mar 2023 11:54:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 2/4] mm: Introduce memblock_isolate_memory
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
References: <20230316131711.1284451-1-alexghiti@rivosinc.com>
 <20230316131711.1284451-3-alexghiti@rivosinc.com>
 <ZBN4Hoo99DNd5wKx@kernel.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <ZBN4Hoo99DNd5wKx@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 3/16/23 21:12, Mike Rapoport wrote:
> Hi Alexandre,
>
> On Thu, Mar 16, 2023 at 02:17:09PM +0100, Alexandre Ghiti wrote:
>> This function allows to split a region in memblock.memory and will be
>> useful when setting up the linear mapping with STRICT_KERNEL_RWX: it
>> allows to isolate the kernel text/rodata and then avoid to map those
>> regions with a PUD/P4D/PGD.
>   
> Sorry I've missed it last time. The changelog is fine in the context of


No worries :)


> this series, but if you look at it as a part of memblock changelog it
> doesn't provide enough background on why memblock_isolate_memory() is
> useful.
>
> Can you please add more context so it would be self explanatory?


What about: "memblock.memory contains the list of memory regions and a 
memory region can cover memory that will be mapped with different 
permissions. So to ease the mapping process, allow to isolate those 
regions by introducing a new function called memblock_isolate_memory. 
This will be used in arch specific code to isolate the kernel 
text/rodata regions when STRICT_KERNEL_RWX is enabled so that we avoid 
mapping them with PUD/P4D/PGD mappings."

Thanks,

Alex


>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> Reviewed-by: Anup Patel <anup@brainfault.org>
>> Tested-by: Anup Patel <anup@brainfault.org>
>> ---
>>   include/linux/memblock.h |  1 +
>>   mm/memblock.c            | 20 ++++++++++++++++++++
>>   2 files changed, 21 insertions(+)
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
>> index 25fd0626a9e7..e8c651a37012 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -805,6 +805,26 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>>   	return 0;
>>   }
>>   
>> +/**
>> + * memblock_isolate_memory - isolate given range in memblock.memory
>> + * @base: base of range to isolate
>> + * @size: size of range to isolate
>> + *
>> + * Isolates the given range in memblock.memory so that it does not share any
>> + * region with other ranges.
>> + *
>> + * Return:
>> + * 0 on success, -errno on failure.
>> + */
>> +
>> +int __init_memblock memblock_isolate_memory(phys_addr_t base, phys_addr_t size)
>> +{
>> +	int start_rgn, end_rgn;
>> +
>> +	return memblock_isolate_range(&memblock.memory, base, size,
>> +				      &start_rgn, &end_rgn);
>> +}
>> +
>>   static int __init_memblock memblock_remove_range(struct memblock_type *type,
>>   					  phys_addr_t base, phys_addr_t size)
>>   {
>> -- 
>> 2.37.2
>>

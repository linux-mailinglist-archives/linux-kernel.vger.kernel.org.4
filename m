Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75B570EC63
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 06:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjEXENS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 00:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEXEMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 00:12:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08002C1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:12:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 655FF1042;
        Tue, 23 May 2023 21:13:30 -0700 (PDT)
Received: from [10.163.72.91] (unknown [10.163.72.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C42F3F840;
        Tue, 23 May 2023 21:12:42 -0700 (PDT)
Message-ID: <323ae5c0-8cb1-6ca8-a16f-541c1765a2e3@arm.com>
Date:   Wed, 24 May 2023 09:42:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] memblock: Add flags and nid info in memblock debugfs
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, Yuwei Guan <ssawgyw@gmail.com>
Cc:     akpm@linux-foundation.org, tsahu@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230519105321.333-1-ssawgyw@gmail.com>
 <20230523160539.GH4967@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230523160539.GH4967@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/23 21:35, Mike Rapoport wrote:
> Hi,
> 
> On Fri, May 19, 2023 at 06:53:21PM +0800, Yuwei Guan wrote:
>> Currently, the memblock debugfs can display the count of memblock_type and
>> the base and end of the reg. However, when memblock_mark_*() or
>> memblock_set_node() is executed on some range, the information in the
>> existing debugfs cannot make it clear why the address is not consecutive.
>>
>> For example,
>> cat /sys/kernel/debug/memblock/memory
>>    0: 0x0000000080000000..0x00000000901fffff
>>    1: 0x0000000090200000..0x00000000905fffff
>>    2: 0x0000000090600000..0x0000000092ffffff
>>    3: 0x0000000093000000..0x00000000973fffff
>>    4: 0x0000000097400000..0x00000000b71fffff
>>    5: 0x00000000c0000000..0x00000000dfffffff
>>    6: 0x00000000e2500000..0x00000000f87fffff
>>    7: 0x00000000f8800000..0x00000000fa7fffff
>>    8: 0x00000000fa800000..0x00000000fd3effff
>>    9: 0x00000000fd3f0000..0x00000000fd3fefff
>>   10: 0x00000000fd3ff000..0x00000000fd7fffff
>>   11: 0x00000000fd800000..0x00000000fd901fff
>>   12: 0x00000000fd902000..0x00000000fd909fff
>>   13: 0x00000000fd90a000..0x00000000fd90bfff
>>   14: 0x00000000fd90c000..0x00000000ffffffff
>>   15: 0x0000000880000000..0x0000000affffffff
>>
>> So we can add flags and nid to this debugfs.
>>
>> For example,
>> cat /sys/kernel/debug/memblock/memory
>>    0: 0x0000000080000000..0x00000000901fffff    0 NONE
>>    1: 0x0000000090200000..0x00000000905fffff    0 NOMAP
>>    2: 0x0000000090600000..0x0000000092ffffff    0 NONE
>>    3: 0x0000000093000000..0x00000000973fffff    0 NOMAP
>>    4: 0x0000000097400000..0x00000000b71fffff    0 NONE
>>    5: 0x00000000c0000000..0x00000000dfffffff    0 NONE
>>    6: 0x00000000e2500000..0x00000000f87fffff    0 NONE
>>    7: 0x00000000f8800000..0x00000000fa7fffff    0 NOMAP
>>    8: 0x00000000fa800000..0x00000000fd3effff    0 NONE
>>    9: 0x00000000fd3f0000..0x00000000fd3fefff    0 NOMAP
>>   10: 0x00000000fd3ff000..0x00000000fd7fffff    0 NONE
>>   11: 0x00000000fd800000..0x00000000fd901fff    0 NOMAP
>>   12: 0x00000000fd902000..0x00000000fd909fff    0 NONE
>>   13: 0x00000000fd90a000..0x00000000fd90bfff    0 NOMAP
>>   14: 0x00000000fd90c000..0x00000000ffffffff    0 NONE
>>   15: 0x0000000880000000..0x0000000affffffff    0 NONE
>>
>> Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
>> ---
>> v4:
>> - show string value for each memblock flag
>> ---
>>  mm/memblock.c | 24 ++++++++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 511d4783dcf1..10d0ddbeebc1 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -2136,12 +2136,19 @@ void __init memblock_free_all(void)
>>  }
>>  
>>  #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
>> +static const char * const flagname[] = {
>> +	[ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",
>> +	[ilog2(MEMBLOCK_MIRROR)] = "MIRROR",
>> +	[ilog2(MEMBLOCK_NOMAP)] = "NOMAP",
>> +	[ilog2(MEMBLOCK_DRIVER_MANAGED)] = "DRV_MNG",
>> +};
>>  
>>  static int memblock_debug_show(struct seq_file *m, void *private)
>>  {
>>  	struct memblock_type *type = m->private;
>>  	struct memblock_region *reg;
>> -	int i;
>> +	int i, j;
>> +	unsigned int count = ARRAY_SIZE(flagname);
>>  	phys_addr_t end;
>>  
>>  	for (i = 0; i < type->cnt; i++) {
>> @@ -2149,7 +2156,20 @@ static int memblock_debug_show(struct seq_file *m, void *private)
>>  		end = reg->base + reg->size - 1;
>>  
>>  		seq_printf(m, "%4d: ", i);
>> -		seq_printf(m, "%pa..%pa\n", &reg->base, &end);
>> +		seq_printf(m, "%pa..%pa ", &reg->base, &end);
>> +		seq_printf(m, "%4d ", memblock_get_region_node(reg));
>> +		if (reg->flags) {
>> +			for (j = 0; j < count; j++) {
>> +				if (reg->flags & (1U << j)) {
>> +					seq_printf(m, "%s\n", flagname[j]);
>> +					break;
> 
> The flags are mostly mutually exclusive because it's unlikely they are used
> together, but not because there are some restrictions on possible flags
> combinations. So generally it's possible to have multiple flags set on the
> same region.

But do we really need to account for that as of now, when no memblock region
carries more than a single flag ? But in that case all flags here need to be
printed with "|" in between ?

> 
> Sorry, I missed that in v3.
> 
>> +				}
>> +			}
>> +			if (j == count)
>> +				seq_printf(m, "%s\n", "UNKNOWN");
>> +		} else {
>> +			seq_printf(m, "%s\n", "NONE");
>> +		}
>>  	}
>>  	return 0;
>>  }
>> -- 
>> 2.34.1
>>
> 

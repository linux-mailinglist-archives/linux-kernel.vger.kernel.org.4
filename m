Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8A4652F09
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiLUJ7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbiLUJ61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:58:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B61D2339B;
        Wed, 21 Dec 2022 01:53:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E543A2F4;
        Wed, 21 Dec 2022 01:54:18 -0800 (PST)
Received: from [10.57.44.6] (unknown [10.57.44.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C57AE3F71E;
        Wed, 21 Dec 2022 01:53:33 -0800 (PST)
Message-ID: <43780b8b-d358-ba8f-a4af-06165dbbf18a@arm.com>
Date:   Wed, 21 Dec 2022 10:53:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 1/5] cacheinfo: Use RISC-V's init_cache_level() as
 generic OF implementation
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, palmer@rivosinc.com,
        Ionela.Voinescu@arm.com, Conor Dooley <conor.dooley@microchip.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20221209103130.572196-1-pierre.gondois@arm.com>
 <20221209103130.572196-2-pierre.gondois@arm.com>
 <20221220233912.GA1193943-robh@kernel.org>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20221220233912.GA1193943-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On 12/21/22 00:39, Rob Herring wrote:
> On Fri, Dec 09, 2022 at 11:31:23AM +0100, Pierre Gondois wrote:
>> RISC-V's implementation of init_of_cache_level() is following
>> the Devicetree Specification v0.3 regarding caches, cf.:
>> - s3.7.3 'Internal (L1) Cache Properties'
>> - s3.8 'Multi-level and Shared Cache Nodes'
>>
>> Allow reusing the implementation by moving it.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>>   arch/riscv/kernel/cacheinfo.c | 39 +------------------------------
>>   drivers/base/cacheinfo.c      | 44 +++++++++++++++++++++++++++++++++++
>>   include/linux/cacheinfo.h     |  1 +
>>   3 files changed, 46 insertions(+), 38 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
>> index 90deabfe63ea..440a3df5944c 100644
>> --- a/arch/riscv/kernel/cacheinfo.c
>> +++ b/arch/riscv/kernel/cacheinfo.c
>> @@ -115,44 +115,7 @@ static void fill_cacheinfo(struct cacheinfo **this_leaf,
>>   
>>   int init_cache_level(unsigned int cpu)
>>   {
>> -	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>> -	struct device_node *np = of_cpu_device_node_get(cpu);
>> -	struct device_node *prev = NULL;
>> -	int levels = 0, leaves = 0, level;
>> -
>> -	if (of_property_read_bool(np, "cache-size"))
>> -		++leaves;
>> -	if (of_property_read_bool(np, "i-cache-size"))
>> -		++leaves;
>> -	if (of_property_read_bool(np, "d-cache-size"))
>> -		++leaves;
>> -	if (leaves > 0)
>> -		levels = 1;
>> -
>> -	prev = np;
>> -	while ((np = of_find_next_cache_node(np))) {
>> -		of_node_put(prev);
>> -		prev = np;
>> -		if (!of_device_is_compatible(np, "cache"))
>> -			break;
>> -		if (of_property_read_u32(np, "cache-level", &level))
>> -			break;
>> -		if (level <= levels)
>> -			break;
>> -		if (of_property_read_bool(np, "cache-size"))
>> -			++leaves;
>> -		if (of_property_read_bool(np, "i-cache-size"))
>> -			++leaves;
>> -		if (of_property_read_bool(np, "d-cache-size"))
>> -			++leaves;
>> -		levels = level;
>> -	}
>> -
>> -	of_node_put(np);
>> -	this_cpu_ci->num_levels = levels;
>> -	this_cpu_ci->num_leaves = leaves;
>> -
>> -	return 0;
>> +	return init_of_cache_level(cpu);
> 
> Not in this patch, but in patch 5, shouldn't riscv init_cache_level() be
> removed? The topology code already called init_of_cache_level() and
> RiscV has nothing architectural to add/change. IOW, init_cache_level()
> should only do architecture defined init, and not anything DT or ACPI
> related (unless those are non-standard).
> 
> Rob

I think you are right. Just to re-phrase your point:
init_of_cache_level() is called through this path:
init_cpu_topology()
\-fetch_cache_info()
   \-init_of_cache_level()

If there is missing information in the DT and it's not possible to create the
cacheinfo, then the arch specific implementation i.e. init_cache_level() is
called through:
update_siblings_masks() | cacheinfo_cpu_online()
\-detect_cache_attributes()
   \-init_cache_level()

This is useful for arm to call init_cache_level() since it is possible
to extract some information from some registers. For RISC-V, if
init_of_cache_level() fails, then init_cache_level() will fail again.
So removing RISC-V's init_cache_level() makes sense.

Regards,
Pierre


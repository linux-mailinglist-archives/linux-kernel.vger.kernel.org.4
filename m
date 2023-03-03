Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE886A9645
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjCCLaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjCCL3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:29:55 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7985F22E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 03:29:21 -0800 (PST)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PSm2j1cP8znVcr;
        Fri,  3 Mar 2023 19:29:17 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 19:29:18 +0800
Subject: Re: [PATCH v3] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
To:     Baoquan He <bhe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>,
        <horms@kernel.org>, <John.p.donnelly@oracle.com>,
        <will@kernel.org>, <kexec@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230223124532.128744-1-bhe@redhat.com>
 <7971ddbe-aefb-271e-647c-59d81c5840a7@huawei.com>
 <ZAFi/+J7WITdcUWb@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <b26641a4-1df4-19bf-50c7-6411da7cdb97@huawei.com>
Date:   Fri, 3 Mar 2023 19:29:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZAFi/+J7WITdcUWb@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/3 11:01, Baoquan He wrote:
> On 03/02/23 at 11:32am, Leizhen (ThunderTown) wrote:
> ......
>>> @@ -166,31 +169,51 @@ static void __init reserve_crashkernel(void)
>>>  	/* User specifies base address explicitly. */
>>>  	if (crash_base) {
>>>  		fixed_base = true;
>>> +		search_base = crash_base;
>>>  		crash_max = crash_base + crash_size;
>>>  	}
>>>  
>>>  retry:
>>>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>>> -					       crash_base, crash_max);
>>> +					       search_base, crash_max);
>>>  	if (!crash_base) {
>>>  		/*
>>> -		 * If the first attempt was for low memory, fall back to
>>> -		 * high memory, the minimum required low memory will be
>>> -		 * reserved later.
>>> +		 * For crashkernel=size[KMG]@offset[KMG], print out failure
>>> +		 * message if can't reserve the specified region.
>>>  		 */
>>> -		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
>>> +		if (fixed_base) {
>>> +			pr_info("crashkernel reservation failed - memory is in use.\n");
>>
>> How about changing pr_info to pr_warn?
>>
>>> +			return;
>>> +		}
>>> +
>>> +		/*
>>> +		 * For crashkernel=size[KMG], if the first attempt was for
>>> +		 * low memory, fall back to high memory, the minimum required
>>> +		 * low memory will be reserved later.
>>> +		 */
>>> +		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
>>>  			crash_max = CRASH_ADDR_HIGH_MAX;
>>> +			search_base = CRASH_ADDR_LOW_MAX;
>>>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>>>  			goto retry;
>>>  		}
>>>  
>>> +		/*
>>> +		 * For crashkernel=size[KMG],high, if the first attempt was
>>> +		 * for high memory, fall back to low memory.
>>> +		 */
>>> +		if (high && crash_max == CRASH_ADDR_HIGH_MAX) {
>>
>> Adding unlikely to indicate that it is rare would be better.
>>
>> if (unlikely(high && crash_max == CRASH_ADDR_HIGH_MAX))
> 
> Rethink about this and checked code in kernel, seems likely|unlikely are
> mostly used in highly frequent execution branch optimize code path, while 
> crashkernel resevatoin is one time execution during boot, we may not
> need to bother to add unlikely. What do you think?

OK.

> 
> 
>>
>>> +			crash_max = CRASH_ADDR_LOW_MAX;
>>> +			search_base = 0;
>>> +			goto retry;
>>> +		}
>>>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>>>  			crash_size);
>>>  		return;
>>>  	}
>>>  
>>> -	if ((crash_base > CRASH_ADDR_LOW_MAX - crash_low_size) &&
>>> -	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
>>> +	if ((crash_base >= CRASH_ADDR_LOW_MAX) && crash_low_size &&
>>> +	     reserve_crashkernel_low(crash_low_size)) {
>>>  		memblock_phys_free(crash_base, crash_size);
>>>  		return;
>>>  	}
>>>
>>
>> -- 
>> Regards,
>>   Zhen Lei
>>
> 
> .
> 

-- 
Regards,
  Zhen Lei

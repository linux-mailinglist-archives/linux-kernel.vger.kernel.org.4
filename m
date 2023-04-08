Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A676DB814
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 04:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjDHCBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 22:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjDHCA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 22:00:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B209CA32;
        Fri,  7 Apr 2023 19:00:57 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PtdfG0fWTznYd8;
        Sat,  8 Apr 2023 09:57:26 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 8 Apr 2023 10:00:54 +0800
Subject: Re: [PATCH -next v3 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     Simon Horman <horms@kernel.org>,
        Chen Jiahao <chenjiahao16@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <conor.dooley@microchip.com>, <guoren@kernel.org>,
        <heiko@sntech.de>, <bjorn@rivosinc.com>, <alex@ghiti.fr>,
        <akpm@linux-foundation.org>, <atishp@rivosinc.com>,
        <bhe@redhat.com>
References: <20230406220206.3067006-1-chenjiahao16@huawei.com>
 <20230406220206.3067006-2-chenjiahao16@huawei.com>
 <ZDAGi2/+1q0oEUZ5@kernel.org>
 <ee6434f7-8e94-bae5-7d63-4b9bce3aec24@huawei.com>
Message-ID: <f87d33e7-3a30-35b1-8612-0ff1eae63807@huawei.com>
Date:   Sat, 8 Apr 2023 10:00:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ee6434f7-8e94-bae5-7d63-4b9bce3aec24@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/7 20:58, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/4/7 20:03, Simon Horman wrote:
>> On Fri, Apr 07, 2023 at 06:02:05AM +0800, Chen Jiahao wrote:
>>> On riscv, the current crash kernel allocation logic is trying to
>>> allocate within 32bit addressible memory region by default, if
>>> failed, try to allocate without 4G restriction.
>>>
>>> In need of saving DMA zone memory while allocating a relatively large
>>> crash kernel region, allocating the reserved memory top down in
>>> high memory, without overlapping the DMA zone, is a mature solution.
>>> Here introduce the parameter option crashkernel=X,[high,low].
>>>
>>> One can reserve the crash kernel from high memory above DMA zone range
>>> by explicitly passing "crashkernel=X,high"; or reserve a memory range
>>> below 4G with "crashkernel=X,low".
>>>
>>> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
>>
>> ...
>>
>>> @@ -1180,14 +1206,37 @@ static void __init reserve_crashkernel(void)
>>>  		return;
>>>  	}
>>>  
>>> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>>> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>>>  				&crash_size, &crash_base);
>>> -	if (ret || !crash_size)
>>> +	if (ret == -ENOENT) {
>>> +		/*
>>> +		 * crashkernel=X,[high,low] can be specified or not, but
>>> +		 * invalid value is not allowed.
>>
>> nit: Perhaps something like this would be easier to correlate with the
>>      code that follows:
>>
>> 		/* Fallback to crashkernel=X,[high,low] */
> 
> The description "crashkernel=X,[high,low] can be specified or not" is not
> correct, because crashkernel=X,high must be specified when walking into this
> branch. So use Simon's comments or copy arm64's comments(it's written for
> parse_crashkernel_low()).

I rethink it a little bit, if it's relative to crashkernel=X[@offset],
that's also true.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
>>
>>
>>> +		 */
>>> +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
>>> +		if (ret || !crash_size)
>>> +			return;
>>> +
>>> +		/*
>>> +		 * crashkernel=Y,low is valid only when crashkernel=X,high
>>> +		 * is passed and high memory is reserved successful.
>>
>> nit: s/successful/successfully/
> 
> Seems like the whole "and high memory is reserved successful" needs to be deleted.
> Only the dependency between the two boot options should be described here,
> regardless of whether their memory is successfully allocated.
> 
>>
>>> +		 */
>>> +		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
>>> +		if (ret == -ENOENT)
>>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>>> +		else if (ret)
>>> +			return;
>>> +
>>> +		search_start = search_low_max;
>>> +	} else if (ret || !crash_size) {
>>> +		/* Invalid argument value specified */
>>>  		return;
>>> +	}
>>
>> ...
>> .
>>
> 

-- 
Regards,
  Zhen Lei

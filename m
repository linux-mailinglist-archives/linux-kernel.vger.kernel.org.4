Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6C36DC583
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 12:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjDJKE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 06:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDJKEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 06:04:49 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844A9212D;
        Mon, 10 Apr 2023 03:04:48 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pw4HZ1ymSz17Rtt;
        Mon, 10 Apr 2023 18:01:14 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Apr
 2023 17:52:37 +0800
Message-ID: <20dd1890-273b-3a5b-7a4e-6feaf722cf8a@huawei.com>
Date:   Mon, 10 Apr 2023 17:52:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v3 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Content-Language: en-US
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Simon Horman <horms@kernel.org>
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
 <f87d33e7-3a30-35b1-8612-0ff1eae63807@huawei.com>
From:   "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <f87d33e7-3a30-35b1-8612-0ff1eae63807@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/8 10:00, Leizhen (ThunderTown) wrote:
>
> On 2023/4/7 20:58, Leizhen (ThunderTown) wrote:
>>
>> On 2023/4/7 20:03, Simon Horman wrote:
>>> On Fri, Apr 07, 2023 at 06:02:05AM +0800, Chen Jiahao wrote:
>>>> On riscv, the current crash kernel allocation logic is trying to
>>>> allocate within 32bit addressible memory region by default, if
>>>> failed, try to allocate without 4G restriction.
>>>>
>>>> In need of saving DMA zone memory while allocating a relatively large
>>>> crash kernel region, allocating the reserved memory top down in
>>>> high memory, without overlapping the DMA zone, is a mature solution.
>>>> Here introduce the parameter option crashkernel=X,[high,low].
>>>>
>>>> One can reserve the crash kernel from high memory above DMA zone range
>>>> by explicitly passing "crashkernel=X,high"; or reserve a memory range
>>>> below 4G with "crashkernel=X,low".
>>>>
>>>> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
>>> ...
>>>
>>>> @@ -1180,14 +1206,37 @@ static void __init reserve_crashkernel(void)
>>>>   		return;
>>>>   	}
>>>>   
>>>> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>>>> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>>>>   				&crash_size, &crash_base);
>>>> -	if (ret || !crash_size)
>>>> +	if (ret == -ENOENT) {
>>>> +		/*
>>>> +		 * crashkernel=X,[high,low] can be specified or not, but
>>>> +		 * invalid value is not allowed.
>>> nit: Perhaps something like this would be easier to correlate with the
>>>       code that follows:
>>>
>>> 		/* Fallback to crashkernel=X,[high,low] */
>> The description "crashkernel=X,[high,low] can be specified or not" is not
>> correct, because crashkernel=X,high must be specified when walking into this
>> branch. So use Simon's comments or copy arm64's comments(it's written for
>> parse_crashkernel_low()).
> I rethink it a little bit, if it's relative to crashkernel=X[@offset],
> that's also true.
>
> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

Sure, The commit should not be ambiguous like this, Simon's comment above is

a better option.


>>>
>>>> +		 */
>>>> +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
>>>> +		if (ret || !crash_size)
>>>> +			return;
>>>> +
>>>> +		/*
>>>> +		 * crashkernel=Y,low is valid only when crashkernel=X,high
>>>> +		 * is passed and high memory is reserved successful.
>>> nit: s/successful/successfully/
>> Seems like the whole "and high memory is reserved successful" needs to be deleted.
>> Only the dependency between the two boot options should be described here,
>> regardless of whether their memory is successfully allocated.

The comment here is imprecise, since there is absolutely no check whether

the allocation is successful before "parse_crashkernel_low"


>>
>>>> +		 */
>>>> +		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
>>>> +		if (ret == -ENOENT)
>>>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>>>> +		else if (ret)
>>>> +			return;
>>>> +
>>>> +		search_start = search_low_max;
>>>> +	} else if (ret || !crash_size) {
>>>> +		/* Invalid argument value specified */
>>>>   		return;
>>>> +	}
>>> ...
>>> .
>>>
BR,

Jiahao


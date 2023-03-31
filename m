Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9D86D1F38
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 13:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjCaLgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 07:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCaLgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:36:48 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A83210D;
        Fri, 31 Mar 2023 04:36:45 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PnypX3DWVz17RGV;
        Fri, 31 Mar 2023 19:33:24 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 31 Mar
 2023 19:36:42 +0800
Message-ID: <f1fcf149-4d40-f10e-39d4-6580f025629c@huawei.com>
Date:   Fri, 31 Mar 2023 19:36:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v2 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <conor.dooley@microchip.com>, <guoren@kernel.org>,
        <heiko@sntech.de>, <bjorn@rivosinc.com>, <alex@ghiti.fr>,
        <akpm@linux-foundation.org>, <atishp@rivosinc.com>,
        <thunder.leizhen@huawei.com>, <horms@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>
References: <20230328115150.2700016-1-chenjiahao16@huawei.com>
 <20230328115150.2700016-2-chenjiahao16@huawei.com>
 <ZCQewkvSpaI52DSM@MiWiFi-R3L-srv>
 <b8a32e3c-c083-20de-16d1-f628b02b739b@huawei.com>
 <ZCYcJos4MLBvpP9/@MiWiFi-R3L-srv>
From:   "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <ZCYcJos4MLBvpP9/@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/3/31 7:32, Baoquan He wrote:
> On 03/30/23 at 09:40pm, chenjiahao (C) wrote:
> ......
>> Agreed, I will clean this up later in next version.
>>>> +		if (ret || !crash_size)
>>>> +			return;
>>>> +
>>>> +		/*
>>>> +		 * crashkernel=Y,low is valid only when crashkernel=X,high
>>>> +		 * is passed and high memory is reserved successful.
>>>> +		 */
>>>> +		ret = parse_crashkernel_low(boot_command_line, 0, &crash_low_size, &crash_base);
>>>> +		if (ret == -ENOENT)
>>>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>>>> +		else if (ret)
>>>> +			return;
>>>> +
>>>> +		search_start = dma32_phys_limit;
>>>> +	} else if (ret || !crash_size) {
>>>> +		/* Invalid argument value specified */
>>>>    		return;
>>>> +	}
>>>>    	crash_size = PAGE_ALIGN(crash_size);
>>>> @@ -1201,16 +1246,26 @@ static void __init reserve_crashkernel(void)
>>>>    	 */
>>>>    	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
>>>>    					       search_start,
>>>> -					       min(search_end, (unsigned long) SZ_4G));
>>>> +					       min(search_end, (unsigned long)dma32_phys_limit));
>>>>    	if (crash_base == 0) {
>>> The above conditional check isn't right. If crashkernel=size@offset
>>> specified, the reservation failure won't trigger retry. This seems to be
>>> originally introduced by old commit, while this need be fixed firstly.
>> Just a little curious about the rule to cope with this specific case. If
>> "crashkernel=size@offset" was passed
>>
>> but reserve failed, should try again to allocate in high memory, regardless
>> the specified size@offset,
>>
>> or just throw a warning and return? Since I noticed the current logic here
>> on Arm64 is to check if !fixed_base first
> Yeah, we need mark the "crashkernel=size@offset" case and avoid to
> retry. Because you won't succeed if  memblock has already failed to
> reserve an unavailable memory region, retry is meaningless. This has
> been done in x86, arm64.

Make sense, thanks.

Actually, in my previous tests, the result in this case is the same
as expectation, i.e. when allocating "crashkernel=size@offset" failed
on low memory, it would retry but return on failure. Since the
search_end is assigned with offset + size, which is lower than DMA32
limit, the second allocation is definitely invalid.

But for sure, to make the code easy to read and eradicate other
possible corner cases, I will check if !fixed_base first on retry.

>

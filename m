Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA38620678
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbiKHCGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiKHCGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:06:42 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D0C13CEE;
        Mon,  7 Nov 2022 18:06:41 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N5rx81X4gzJnYV;
        Tue,  8 Nov 2022 10:03:40 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 10:06:40 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 10:06:39 +0800
Subject: Re: [PATCH v3 2/2] arm64: kdump: Support crashkernel=X fall back to
 reserve region above DMA zones
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        "Dave Kleikamp" <dave.kleikamp@oracle.com>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <20220711090319.1604-3-thunder.leizhen@huawei.com> <Y2k8yuUghrbQE6da@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <6b20a203-6aab-2b87-9b95-814aeb79b5bd@huawei.com>
Date:   Tue, 8 Nov 2022 10:06:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y2k8yuUghrbQE6da@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/8 1:13, Catalin Marinas wrote:
> On Mon, Jul 11, 2022 at 05:03:19PM +0800, Zhen Lei wrote:
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 5390f361208ccf7..8539598f9e58b4d 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -138,6 +138,7 @@ static void __init reserve_crashkernel(void)
>>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>>  	char *cmdline = boot_command_line;
>>  	int ret;
>> +	bool fixed_base;
>>  
>>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>>  		return;
>> @@ -166,15 +167,28 @@ static void __init reserve_crashkernel(void)
>>  		return;
>>  	}
>>  
>> +	fixed_base = !!crash_base;
>>  	crash_size = PAGE_ALIGN(crash_size);
>>  
>>  	/* User specifies base address explicitly. */
>> -	if (crash_base)
>> +	if (fixed_base)
>>  		crash_max = crash_base + crash_size;
> 
> Not a fan of '!!', it is converted automatically. If you don't like the
> conversion, just initialise fixed_base to false and here:
> 
> 	if (crash_base) {
> 		fixed_base = true;

OK, This way would be better.

> 		crash_max = crash_base + crash_size;
> 	}
> 
>> +retry:
>>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>>  					       crash_base, crash_max);
>>  	if (!crash_base) {
>> +		/*
>> +		 * Attempt to fully allocate low memory failed, fall back
>> +		 * to high memory, the minimum required low memory will be
>> +		 * reserved later.
>> +		 */
> 
> I'm not sure this comment makes sense. If !crash_base, it doesn't mean
> the kernel failed to fully allocate low memory. crash_max here could be
> CRASH_ADDR_HIGH_MAX if crashkerne=X,high was specified. Maybe says
> something like "If the first attempt was for low memory, fall back to
> high ..."

This description is accurate. I'll update. Thanks.

> 
>> +		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
>> +			crash_max = CRASH_ADDR_HIGH_MAX;
>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>> +			goto retry;
>> +		}
> 
> The retry logic looks fine, it only happens once as crash_max is
> updated.
> 

-- 
Regards,
  Zhen Lei

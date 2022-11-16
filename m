Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6686762BCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiKPL6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiKPL56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:57:58 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4386AE7E;
        Wed, 16 Nov 2022 03:50:07 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NC1Tk0vqbzqSTl;
        Wed, 16 Nov 2022 19:46:18 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 19:50:06 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 19:50:05 +0800
Subject: Re: [PATCH v3 1/2] arm64: kdump: Provide default size when
 crashkernel=Y,low is not specified
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
 <20220711090319.1604-2-thunder.leizhen@huawei.com> <Y2kRC7JALMQQRsxE@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <7c474745-1bec-93d6-0b82-9171e8149c0d@huawei.com>
Date:   Wed, 16 Nov 2022 19:50:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y2kRC7JALMQQRsxE@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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



On 2022/11/7 22:07, Catalin Marinas wrote:
> On Mon, Jul 11, 2022 at 05:03:18PM +0800, Zhen Lei wrote:
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 339ee84e5a61a0b..5390f361208ccf7 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -96,6 +96,14 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
>>  #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
>>  #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
>>  
>> +/*
>> + * This is an empirical value in x86_64 and taken here directly. Please
>> + * refer to the code comment in reserve_crashkernel_low() of x86_64 for more
>> + * details.
>> + */
>> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE	\
>> +	max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20)
> 
> I agree with Will here, we need a better comment and we might as well
> change the default value to something else until someone tells us that
> the default is not large enough. The default swiotlb size is 64M, so we
> need to cover that. The extra 8MB for any additional low allocations are
> ok as well but the 256MB doesn't make much sense to me, or at least not
> together with the rest.
> 
> If the main kernel got a command line option for a larger swiotlb, does
> the crash kernel boot with the same command line? If not, we can just go

Sometimes the image is shared, but the command line is often different.
The command line of the crash kernel is specified by kexec --append=.

> for a fixed 128M value here, which is double the default swiotlb buffer.

Sorry, I missed this e-mail. Yes, fixed 128M would be better. I haven't
seen anyone adding "swiotlb=" to the crash kernel. And, if the default size
isn't enough, he can use crashkernel=Y,low.

> 

-- 
Regards,
  Zhen Lei

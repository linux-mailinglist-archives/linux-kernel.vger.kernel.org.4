Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5805B634D91
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbiKWCGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbiKWCGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:06:07 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4787C8DA4E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 18:06:06 -0800 (PST)
Received: from kwepemi500022.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NH4GQ1Bf0z15Mpd;
        Wed, 23 Nov 2022 10:05:34 +0800 (CST)
Received: from [10.67.111.83] (10.67.111.83) by kwepemi500022.china.huawei.com
 (7.221.188.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 10:06:03 +0800
Message-ID: <28a90ac0-dc8f-f0dd-74d8-d2884e2cbd30@huawei.com>
Date:   Wed, 23 Nov 2022 10:06:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: armv8_deprecated: fix unused-function error
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <yusongping@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221122032010.202956-1-renzhijie2@huawei.com>
 <Y3z9dEkMdCeWAWq0@FVFF77S0Q05N.cambridge.arm.com>
From:   Ren Zhijie <renzhijie2@huawei.com>
In-Reply-To: <Y3z9dEkMdCeWAWq0@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500022.china.huawei.com (7.221.188.64)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/11/23 0:48, Mark Rutland 写道:
> On Tue, Nov 22, 2022 at 03:20:10AM +0000, Ren Zhijie wrote:
>> If CONFIG_SWP_EMULATION is not set and
>> CONFIG_CP15_BARRIER_EMULATION is not set,
>> aarch64-linux-gnu complained about unused-function :
>>
>> arch/arm64/kernel/armv8_deprecated.c:67:21: error: ‘aarch32_check_condition’ defined but not used [-Werror=unused-function]
>>   static unsigned int aarch32_check_condition(u32 opcode, u32 psr)
>>                       ^~~~~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>>
>> To fix this error, warp the definition of
>> aarch32_check_condition() by defined(CONFIG_SWP_EMULATION) ||
>> defined(CONFIG_CP15_BARRIER_EMULATION)
>>
>> Fixes: 0c5f416219da ("arm64: armv8_deprecated: move aarch32 helper earlier")
> This also depends on building with additional options to turn warnings into
> errors, no?

No，i just run the normal command as follow:

make ARCH="arm64" CROSS_COMPILE="aarch64-linux-gnu-"

>> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
>> ---
>>   arch/arm64/kernel/armv8_deprecated.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
>> index ed0788cf6bbb..3f29ceb6653a 100644
>> --- a/arch/arm64/kernel/armv8_deprecated.c
>> +++ b/arch/arm64/kernel/armv8_deprecated.c
>> @@ -64,6 +64,7 @@ struct insn_emulation {
>>   
>>   #define	ARM_OPCODE_CONDITION_UNCOND	0xf
>>   
>> +#if defined(CONFIG_SWP_EMULATION) || defined(CONFIG_CP15_BARRIER_EMULATION)
>>   static unsigned int aarch32_check_condition(u32 opcode, u32 psr)
>>   {
>>   	u32 cc_bits  = opcode >> 28;
>> @@ -76,6 +77,7 @@ static unsigned int aarch32_check_condition(u32 opcode, u32 psr)
>>   	}
>>   	return ARM_OPCODE_CONDTEST_UNCOND;
>>   }
>> +#endif
> Could we mark this as '__maybe_unused' or 'inline' instead? I think that's
> preferable to the ifdeferry.

sure, i will use __maybe_unused in v2.

Thanks,

Ren.

> Thanks,
> Mark.
>
>>   
>>   #ifdef CONFIG_SWP_EMULATION
>>   /*
>> -- 
>> 2.17.1
>>
> .

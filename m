Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C825C5F8B4F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 14:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJIMog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 08:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJIMoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:44:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682982CDDF
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 05:44:29 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MlhVl3w7zzpVYZ;
        Sun,  9 Oct 2022 20:41:19 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 20:44:27 +0800
Subject: Re: [PATCH] x86/alternative: fix undefined reference to
 __ibt_endbr_seal[_end]
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221009154532.1100121-1-linmiaohe@huawei.com>
 <Y0K+YbcwyLJg9Iwr@hirez.programming.kicks-ass.net>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1ed246ea-2960-4893-f84a-c24b3c3832d7@huawei.com>
Date:   Sun, 9 Oct 2022 20:44:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Y0K+YbcwyLJg9Iwr@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/9 20:28, Peter Zijlstra wrote:
> On Sun, Oct 09, 2022 at 11:45:32PM +0800, Miaohe Lin wrote:
>> When I compile the kernel bzImage, there are several compile errors:
>>
>> ld: arch/x86/kernel/alternative.o: in function
>> `alternative_instructions':
>> alternative.c:(.init.text+0x15d): undefined reference to
>> `__ibt_endbr_seal_end'
>> ld: alternative.c:(.init.text+0x164): undefined reference to
>> `__ibt_endbr_seal'
>>
>> It's because __ibt_endbr_seal and __ibt_endbr_seal_end are not optimized
>> away when CONFIG_X86_KERNEL_IBT isn't enabled. Remove noinline attribute
>> to help gcc optimize them away.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  arch/x86/kernel/alternative.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
>> index 5cadcea035e0..beaf9fc44e2f 100644
>> --- a/arch/x86/kernel/alternative.c
>> +++ b/arch/x86/kernel/alternative.c
>> @@ -624,7 +624,7 @@ void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end)
>>  
>>  #else
>>  
>> -void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end) { }
>> +void __init_or_module apply_ibt_endbr(s32 *start, s32 *end) { }
>>  
>>  #endif /* CONFIG_X86_KERNEL_IBT */
>>  
> 
> None of this makes any sense...

This compile error occurs in my env when CONFIG_X86_KERNEL_IBT isn't enabled with gcc version 7.3.0 (GCC).
And the generated assembly code looks like below:

0000000000000104 <alternative_instructions>:
 104:   e8 90 ff ff ff          callq  99 <int3_selftest>
 109:   e8 00 00 00 00          callq  10e <alternative_instructions+0xa>
 10e:   48 c7 c6 00 00 00 00    mov    $0x0,%rsi
 115:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
 11c:   e8 00 00 00 00          callq  121 <alternative_instructions+0x1d>
 121:   48 c7 c6 00 00 00 00    mov    $0x0,%rsi
 128:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
 12f:   e8 00 00 00 00          callq  134 <alternative_instructions+0x30>
 134:   48 c7 c6 00 00 00 00    mov    $0x0,%rsi
 13b:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
 142:   e8 00 00 00 00          callq  147 <alternative_instructions+0x43>
 147:   48 c7 c6 00 00 00 00    mov    $0x0,%rsi
 14e:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
 155:   e8 00 00 00 00          callq  15a <alternative_instructions+0x56>
 >15a:   48 c7 c6 00 00 00 00    mov    $0x0,%rsi
 >161:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
 >168:   e8 00 00 00 00          callq  16d <alternative_instructions+0x69>
 >16d:   83 3d 00 00 00 00 00    cmpl   $0x0,0x0(%rip)        # 174 <alternative_instructions+0x70>
 >174:   75 4a                   jne    1c0 <alternative_instructions+0xbc>

It seems the call to apply_ibt_endbr() is not optimized out when CONFIG_X86_KERNEL_IBT isn't enabled.
And after the patch, the generated assembly code looks like below:

0000000000000104 <alternative_instructions>:
 104:   e8 90 ff ff ff          callq  99 <int3_selftest>
 109:   e8 00 00 00 00          callq  10e <alternative_instructions+0xa>
 10e:   48 c7 c6 00 00 00 00    mov    $0x0,%rsi
 115:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
 11c:   e8 00 00 00 00          callq  121 <alternative_instructions+0x1d>
 121:   48 c7 c6 00 00 00 00    mov    $0x0,%rsi
 128:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
 12f:   e8 00 00 00 00          callq  134 <alternative_instructions+0x30>
 134:   48 c7 c6 00 00 00 00    mov    $0x0,%rsi
 13b:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
 142:   e8 00 00 00 00          callq  147 <alternative_instructions+0x43>
 147:   48 c7 c6 00 00 00 00    mov    $0x0,%rsi
 14e:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
 155:   e8 00 00 00 00          callq  15a <alternative_instructions+0x56>
 >15a:   83 3d 00 00 00 00 00    cmpl   $0x0,0x0(%rip)        # 161 <alternative_instructions+0x5d>
 >161:   75 4a                   jne    1ad <alternative_instructions+0xa9>

The call to apply_ibt_endbr() is optimized out this time. Maybe it's the problem of gcc. But remove
noinline attribute make compile works in my env. Am I miss something?

Thanks,
Miaohe Lin


> 
> .
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBF35FAA98
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJKC0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJKC0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:26:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85447B1D5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:26:40 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mmfhx2LmVzpVc4;
        Tue, 11 Oct 2022 10:23:29 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 10:26:38 +0800
Subject: Re: [PATCH] x86/alternative: fix undefined reference to
 __ibt_endbr_seal[_end]
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221009154532.1100121-1-linmiaohe@huawei.com>
 <Y0K+YbcwyLJg9Iwr@hirez.programming.kicks-ass.net>
 <1ed246ea-2960-4893-f84a-c24b3c3832d7@huawei.com>
 <Y0LIcwJKRDJVOW7o@hirez.programming.kicks-ass.net>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <69523133-ad61-1fcf-e78a-d2017608faff@huawei.com>
Date:   Tue, 11 Oct 2022 10:26:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Y0LIcwJKRDJVOW7o@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/9 21:11, Peter Zijlstra wrote:
> On Sun, Oct 09, 2022 at 08:44:26PM +0800, Miaohe Lin wrote:
>> On 2022/10/9 20:28, Peter Zijlstra wrote:
>>> On Sun, Oct 09, 2022 at 11:45:32PM +0800, Miaohe Lin wrote:
>>>> When I compile the kernel bzImage, there are several compile errors:
>>>>
>>>> ld: arch/x86/kernel/alternative.o: in function
>>>> `alternative_instructions':
>>>> alternative.c:(.init.text+0x15d): undefined reference to
>>>> `__ibt_endbr_seal_end'
>>>> ld: alternative.c:(.init.text+0x164): undefined reference to
>>>> `__ibt_endbr_seal'
>>>>
>>>> It's because __ibt_endbr_seal and __ibt_endbr_seal_end are not optimized
>>>> away when CONFIG_X86_KERNEL_IBT isn't enabled. Remove noinline attribute
>>>> to help gcc optimize them away.
>>>>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>  arch/x86/kernel/alternative.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
>>>> index 5cadcea035e0..beaf9fc44e2f 100644
>>>> --- a/arch/x86/kernel/alternative.c
>>>> +++ b/arch/x86/kernel/alternative.c
>>>> @@ -624,7 +624,7 @@ void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end)
>>>>  
>>>>  #else
>>>>  
>>>> -void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end) { }
>>>> +void __init_or_module apply_ibt_endbr(s32 *start, s32 *end) { }
>>>>  
>>>>  #endif /* CONFIG_X86_KERNEL_IBT */
>>>>  
>>>
>>> None of this makes any sense...
>>
>> This compile error occurs in my env when CONFIG_X86_KERNEL_IBT isn't
>> enabled with gcc version 7.3.0 (GCC).
> 
> *sigh*... geriatric GCC :/

Yes, a geriatric GCC problem. :(

> 
> Anyway; perhaps clarify the changelog to state something like:
> 
> Due to the explicit 'noinline' GCC-7.3 is not able to optimize away the
> argument setup of:
> 
> 	apply_ibt_endbr(__ibt_endbr_seal, __ibt_enbr_seal_end);
> 
> even when X86_KERNEL_IBT=n and the function is an empty stub -- leading
> to link errors due to missing __ibt_endbr_seal* symbols.

Will do it in v2. Thanks for your suggestion and comment.

Thanks,
Miaohe Lin

> 
> 
> .
> 


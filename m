Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10704747D85
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjGEGxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjGEGwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:52:54 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4EC18E;
        Tue,  4 Jul 2023 23:52:31 -0700 (PDT)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Qwqyq2DgvzLngB;
        Wed,  5 Jul 2023 14:49:39 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemi500019.china.huawei.com (7.221.188.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 14:51:51 +0800
Subject: Re: [PATCH 5.10] kprobes/x86: Fix kprobe debug exception handling
 logic
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>, <mhiramat@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <sashal@kernel.org>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <xukuohai@huawei.com>
References: <20230630020845.227939-1-lihuafei1@huawei.com>
 <2023063039-dotted-improper-7b3c@gregkh>
 <6cbfbd13-b2f6-4c76-8d0d-ac07f59b23e7@huawei.com>
 <2023070308-garland-smilingly-8b03@gregkh>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <37a3a2aa-5af5-6cf6-a074-28b929556dab@huawei.com>
Date:   Wed, 5 Jul 2023 14:51:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <2023070308-garland-smilingly-8b03@gregkh>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500019.china.huawei.com (7.221.188.117)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/4 2:34, Greg KH wrote:
> On Sat, Jul 01, 2023 at 04:43:46PM +0800, Li Huafei wrote:
>>
>>
>> On 2023/6/30 13:21, Greg KH wrote:
>>> On Fri, Jun 30, 2023 at 10:08:45AM +0800, Li Huafei wrote:
>>>> We get the following crash caused by a null pointer access:
>>>>
>>>>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>>>>  ...
>>>>  RIP: 0010:resume_execution+0x35/0x190
>>>>  ...
>>>>  Call Trace:
>>>>   <#DB>
>>>>   kprobe_debug_handler+0x41/0xd0
>>>>   exc_debug+0xe5/0x1b0
>>>>   asm_exc_debug+0x19/0x30
>>>>  RIP: 0010:copy_from_kernel_nofault.part.0+0x55/0xc0
>>>>  ...
>>>>   </#DB>
>>>>   process_fetch_insn+0xfb/0x720
>>>>   kprobe_trace_func+0x199/0x2c0
>>>>   ? kernel_clone+0x5/0x2f0
>>>>   kprobe_dispatcher+0x3d/0x60
>>>>   aggr_pre_handler+0x40/0x80
>>>>   ? kernel_clone+0x1/0x2f0
>>>>   kprobe_ftrace_handler+0x82/0xf0
>>>>   ? __se_sys_clone+0x65/0x90
>>>>   ftrace_ops_assist_func+0x86/0x110
>>>>   ? rcu_nocb_try_bypass+0x1f3/0x370
>>>>   0xffffffffc07e60c8
>>>>   ? kernel_clone+0x1/0x2f0
>>>>   kernel_clone+0x5/0x2f0
>>>>
>>>> The analysis reveals that kprobe and hardware breakpoints conflict in
>>>> the use of debug exceptions.
>>>>
>>>> If we set a hardware breakpoint on a memory address and also have a
>>>> kprobe event to fetch the memory at this address. Then when kprobe
>>>> triggers, it goes to read the memory and triggers hardware breakpoint
>>>> monitoring. This time, since kprobe handles debug exceptions earlier
>>>> than hardware breakpoints, it will cause kprobe to incorrectly assume
>>>> that the exception is a kprobe trigger.
>>>>
>>>> Notice that after the mainline commit 6256e668b7af ("x86/kprobes: Use
>>>> int3 instead of debug trap for single-step"), kprobe no longer uses
>>>> debug trap, avoiding the conflict with hardware breakpoints here. This
>>>> commit is to remove the IRET that returns to kernel, not to fix the
>>>> problem we have here. Also there are a bunch of merge conflicts when
>>>> trying to apply this commit to older kernels, so fixing it directly in
>>>> older kernels is probably a better option.
>>>
>>> What is the list of commits that it would take to resolve this in these
>>> kernels?  We would almost always prefer to do that instead of taking
>>> changes that are not upstream.
>>
>> I have sorted out that for 5.10 there are 9 patches that need to be
>> backported:
>>
>>   #9 8924779df820 ("x86/kprobes: Fix JNG/JNLE emulation")
>>   #8 dec8784c9088 ("x86/kprobes: Update kcb status flag after singlestepping")
>>   #7 2304d14db659 ("x86/kprobes: Move 'inline' to the beginning of the kprobe_is_ss() declaration")
>>   #6 2f706e0e5e26 ("x86/kprobes: Fix to identify indirect jmp and others using range case")
>>   #5 6256e668b7af ("x86/kprobes: Use int3 instead of debug trap for single-step")
>>   #4 a194acd316f9 ("x86/kprobes: Identify far indirect JMP correctly")
>>   #3 d60ad3d46f1d ("x86/kprobes: Retrieve correct opcode for group instruction")
>>   #2 abd82e533d88 ("x86/kprobes: Do not decode opcode in resume_execution()")
>>   #1 e689b300c99c ("kprobes/x86: Fix fall-through warnings for Clang e689b300c99c")
>>   
>> The main one we need to backport is patch 5, patche 1-6 are pre-patches,
>> and patche 6-9 are fix patches for patch 5. The major modifications are
>> patch 2 and patch 4. Patch 2 optimizes resume_execution() to avoid
>> repeated instruction decoding, and patch 5 uses int3 instead of debug
>> trap, and as Masami said in the commit message this patch will change
>> some behavior of kprobe, but it has almost no effect on the actual
>> usage.
>>
>> I'm not sure backport these patches are acceptable, do I need to send
>> them out for review?
> 
> Yes, please make up the patch series for these, that's not all that bad,
> and looks like it is more "correct" than just your one-off patch.
> 

Okay, I've sent out the patch set, thanks for the suggestion!

Thanks,
Huafei

> thanks,
> 
> greg k-h
> .
> 

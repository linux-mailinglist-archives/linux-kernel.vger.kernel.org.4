Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B99698AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 03:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBPC4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 21:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPC4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 21:56:39 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982274609A;
        Wed, 15 Feb 2023 18:56:38 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PHKKz62wFzJsSq;
        Thu, 16 Feb 2023 10:54:47 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Feb 2023 10:56:35 +0800
Subject: Re: [PATCH 3/3] x86/kprobes: Fix arch_check_optimized_kprobe check
 within optimized_kprobe range
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <ast@kernel.org>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20230215115430.236046-1-yangjihong1@huawei.com>
 <20230215115430.236046-4-yangjihong1@huawei.com>
 <20230216004859.ab66b42e2e0029cf042fe194@kernel.org>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <885eb39e-bf49-fdb2-5404-5ddd08561bbe@huawei.com>
Date:   Thu, 16 Feb 2023 10:56:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20230216004859.ab66b42e2e0029cf042fe194@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Masami,

On 2023/2/15 23:48, Masami Hiramatsu (Google) wrote:
> On Wed, 15 Feb 2023 19:54:30 +0800
> Yang Jihong <yangjihong1@huawei.com> wrote:
> 
>> When arch_prepare_optimized_kprobe calculating jump destination address,
>> it copies original instructions from jmp-optimized kprobe (see
>> __recover_optprobed_insn), and calculated based on length of original
>> instruction.
>>
>> arch_check_optimized_kprobe does not check KPROBE_FLAG_OPTIMATED when
>> checking whether jmp-optimized kprobe exists.
>> As a result, setup_detour_execution may jump to a range that has been
>> overwritten by jump destination address, resulting in an inval opcode error.
> 
> OK, good catch !! I missed "delayed unoptimization" case here too.
> 
>>
>> For example, assume that register two kprobes whose addresses are
>> <func+9> and <func+11> in "func" function.
>> The original code of "func" function is as follows:
>>
>>     0xffffffff816cb5e9 <+9>:     push   %r12
>>     0xffffffff816cb5eb <+11>:    xor    %r12d,%r12d
>>     0xffffffff816cb5ee <+14>:    test   %rdi,%rdi
>>     0xffffffff816cb5f1 <+17>:    setne  %r12b
>>     0xffffffff816cb5f5 <+21>:    push   %rbp
>>
>> 1.Register the kprobe for <func+11>, assume that is kp1, corresponding optimized_kprobe is op1.
>>    After the optimization, "func" code changes to:
>>
>>     0xffffffff816cc079 <+9>:     push   %r12
>>     0xffffffff816cc07b <+11>:    jmp    0xffffffffa0210000
>>     0xffffffff816cc080 <+16>:    incl   0xf(%rcx)
>>     0xffffffff816cc083 <+19>:    xchg   %eax,%ebp
>>     0xffffffff816cc084 <+20>:    (bad)
>>     0xffffffff816cc085 <+21>:    push   %rbp
>>
>> Now op1->flags == KPROBE_FLAG_OPTIMATED;
>>
>> 2. Register the kprobe for <func+9>, assume that is kp2, corresponding optimized_kprobe is op2.
>>
>> register_kprobe(kp2)
>>    register_aggr_kprobe
>>      alloc_aggr_kprobe
>>        __prepare_optimized_kprobe
>>          arch_prepare_optimized_kprobe
>>            __recover_optprobed_insn    // copy original bytes from kp1->optinsn.copied_insn,
>>                                        // jump address = <func+14>
>>
>> 3. disable kp1:
>>
>> disable_kprobe(kp1)
>>    __disable_kprobe
>>      ...
>>      if (p == orig_p || aggr_kprobe_disabled(orig_p)) {
>>        ret = disarm_kprobe(orig_p, true)       // add op1 in unoptimizing_list, not unoptimized
>>        orig_p->flags |= KPROBE_FLAG_DISABLED;  // op1->flags ==  KPROBE_FLAG_OPTIMATED | KPROBE_FLAG_DISABLED
>>      ...
>>
>> 4. unregister kp2
>> __unregister_kprobe_top
>>    ...
>>    if (!kprobe_disabled(ap) && !kprobes_all_disarmed) {
>>      optimize_kprobe(op)
>>        ...
>>        if (arch_check_optimized_kprobe(op) < 0) // because op1 has KPROBE_FLAG_DISABLED, here not return
>>          return;
>>        p->kp.flags |= KPROBE_FLAG_OPTIMIZED;   //  now op2 has KPROBE_FLAG_OPTIMIZED
>>    }
>>
>> "func" code now is:
>>
>>     0xffffffff816cc079 <+9>:     int3
>>     0xffffffff816cc07a <+10>:    push   %rsp
>>     0xffffffff816cc07b <+11>:    jmp    0xffffffffa0210000
>>     0xffffffff816cc080 <+16>:    incl   0xf(%rcx)
>>     0xffffffff816cc083 <+19>:    xchg   %eax,%ebp
>>     0xffffffff816cc084 <+20>:    (bad)
>>     0xffffffff816cc085 <+21>:    push   %rbp
>>
>> 5. if call "func", int3 handler call setup_detour_execution:
>>
>>    if (p->flags & KPROBE_FLAG_OPTIMIZED) {
>>      ...
>>      regs->ip = (unsigned long)op->optinsn.insn + TMPL_END_IDX;
>>      ...
>>    }
>>
>> The code for the destination address is
>>
>>     0xffffffffa021072c:  push   %r12
>>     0xffffffffa021072e:  xor    %r12d,%r12d
>>     0xffffffffa0210731:  jmp    0xffffffff816cb5ee <func+14>
>>
>> However, <func+14> is not a valid start instruction address. As a result, an error occurs.
> 
> OK, it has been introduced by the same commit as previous one. (delayed unoptimization)
> 

OK, will add "Fixes: f66c0447cca1 ("kprobes: Set unoptimized flag after 
unoptimizing code")" in next version

In addition, "
Cc: stable@vger.kernel.org" is required, same as the previous patch.

>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>   arch/x86/kernel/kprobes/opt.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
>> index 3718d6863555..e6d9bd038401 100644
>> --- a/arch/x86/kernel/kprobes/opt.c
>> +++ b/arch/x86/kernel/kprobes/opt.c
>> @@ -353,7 +353,7 @@ int arch_check_optimized_kprobe(struct optimized_kprobe *op)
>>   
>>   	for (i = 1; i < op->optinsn.size; i++) {
>>   		p = get_kprobe(op->kp.addr + i);
>> -		if (p && !kprobe_disabled(p))
>> +		if (p && (!kprobe_disabled(p) || kprobe_optimized(p)))
> 
> Hmm, can you rewrite this with kprobe_disarmed() instead of kprobe_disabled()?
> Since this is checking there are any other kprobes are "armed" on the address
> where it will be replaced by jump. So it is natural to use "disarmed" check.
> 

Yes, It is better to change it to use "kprobe_disarmed", will modify in 
next version.

Thanks,
Yang

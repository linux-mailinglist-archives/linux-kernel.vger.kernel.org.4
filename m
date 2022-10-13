Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D325FD870
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJMLeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJMLeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:34:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DD7114DFE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 04:34:20 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mp6qX6HCtzHv1g;
        Thu, 13 Oct 2022 19:34:16 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 19:34:18 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 19:34:18 +0800
Subject: Re: [PATCH v2 1/2] ARM: Fix some check warnings of tool sparse
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221010095346.1957-1-thunder.leizhen@huawei.com>
 <20221010095346.1957-2-thunder.leizhen@huawei.com>
 <CAMj1kXHOv23JY35fZ45k=Pzi=ROd6BOCxqPkfXLh2520qhoFzQ@mail.gmail.com>
 <1ab4c651-f0ab-1107-1784-ad255dabc33a@huawei.com>
 <CAMj1kXHn70rRaB=BgCrMoqQxRcq=HzZ0NWFYL+FqV_037PaY3w@mail.gmail.com>
 <c262c991-ad1e-81e6-4909-b8c4a1c036ff@huawei.com>
 <Y0ftvEl3JAkYqkQ1@shell.armlinux.org.uk>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <bf52c912-7a05-3f66-31a0-50131bf0c810@huawei.com>
Date:   Thu, 13 Oct 2022 19:34:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y0ftvEl3JAkYqkQ1@shell.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/10/13 18:51, Russell King (Oracle) wrote:
> On Tue, Oct 11, 2022 at 10:29:58AM +0800, Leizhen (ThunderTown) wrote:
>> On 2022/10/10 19:06, Ard Biesheuvel wrote:
>>> On Mon, 10 Oct 2022 at 12:58, Leizhen (ThunderTown)
>>> <thunder.leizhen@huawei.com> wrote:
>>>> On 2022/10/10 18:20, Ard Biesheuvel wrote:
>>>>> On Mon, 10 Oct 2022 at 11:56, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>>>>>
>>>>>> Fix the following warnings:
>>>>>>  warning: incorrect type in initializer (different address spaces)
>>>>>>     expected unsigned short [noderef] __user *register __p
>>>>>>     got unsigned short [usertype] *
>>>>>>  warning: cast removes address space '__user' of expression
>>>>>>
>>>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>>>> ---
>>>>>>  arch/arm/kernel/traps.c | 10 +++++-----
>>>>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
>>>>>> index 20b2db6dcd1ced7..34aa80c09c508c1 100644
>>>>>> --- a/arch/arm/kernel/traps.c
>>>>>> +++ b/arch/arm/kernel/traps.c
>>>>>> @@ -188,9 +188,9 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
>>>>>>                         }
>>>>>>                 } else {
>>>>>>                         if (thumb)
>>>>>> -                               bad = get_user(val, &((u16 *)addr)[i]);
>>>>>> +                               bad = get_user(val, &((u16 __user *)addr)[i]);
>>>>>>                         else
>>>>>> -                               bad = get_user(val, &((u32 *)addr)[i]);
>>>>>> +                               bad = get_user(val, &((u32 __user *)addr)[i]);
>>>>>>                 }
>>>>>>
>>>>>>                 if (!bad)
>>>>>> @@ -455,15 +455,15 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
>>>>>>         if (processor_mode(regs) == SVC_MODE) {
>>>>>>  #ifdef CONFIG_THUMB2_KERNEL
>>>>>>                 if (thumb_mode(regs)) {
>>>>>> -                       instr = __mem_to_opcode_thumb16(((u16 *)pc)[0]);
>>>>>> +                       instr = __mem_to_opcode_thumb16(((__force u16 *)pc)[0]);
>>>>>
>>>>> Shouldn't this be __user as well? (and below)
>>>>
>>>> unsigned int instr;
>>>> void __user *pc;
>>>>
>>>> The __user can clear the warning, but a new warning will be generated.
>>>>
>>>> instr = __mem_to_opcode_thumb16(((u16 *)pc)[0]);
>>>>       ^new                           ^old
>>>>
>>>> arch/arm/kernel/traps.c:473:33: warning: dereference of noderef expression
>>>>
>>>
>>> This is because dereferencing a __user pointer is not permitted.
>>>
>>> So this code should be using get_kernel_nofault() here not a plain
>>> dereference of PC. So better to fix that properly instead of papering
>>> over it with a __force cast just to make sparse happy.
>>
>> How about:
>> @@ -451,9 +451,9 @@ int call_undef_hook(struct pt_regs *regs, unsigned int instr)
>>  asmlinkage void do_undefinstr(struct pt_regs *regs)
>>  {
>>         unsigned int instr;
>> -       void __user *pc;
>> +       void *pc;
>>
>> -       pc = (void __user *)instruction_pointer(regs);
>> +       pc = (void *)instruction_pointer(regs);
>>
>>         if (processor_mode(regs) == SVC_MODE) {
>>  #ifdef CONFIG_THUMB2_KERNEL
>> @@ -497,7 +497,7 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
>>         }
>>  #endif
>>         arm_notify_die("Oops - undefined instruction", regs,
>> -                      SIGILL, ILL_ILLOPC, pc, 0, 6);
>> +                      SIGILL, ILL_ILLOPC, (void __user *)pc, 0, 6);
>>  }
>>  NOKPROBE_SYMBOL(do_undefinstr)
>>
>>
>> The 'pc' may come from kernel or user. And I found that all the get_user()
>> calls have already done type casts to the pc, except arm_notify_die().
>> I think the above changes are reasonable.
> 
> If we're going to do that, lets do it properly - I think the above would
> need some __force usage to stop sparse complaining, whereas I don't

No need to add __force. I sent it after testing.

$ cat .config | grep THUMB2
CONFIG_THUMB2_KERNEL=y
$ make C=2 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- arch/arm/kernel/traps.o
  CHECK   scripts/mod/empty.c
  CALL    scripts/checksyscalls.sh
  CHECK   arch/arm/kernel/traps.c
arch/arm/kernel/traps.c:97:6: warning: symbol 'dump_backtrace_stm' was not declared. Should it be static?
arch/arm/kernel/traps.c:451:17: warning: symbol 'do_undefinstr' was not declared. Should it be static?
arch/arm/kernel/traps.c:516:39: warning: symbol 'handle_fiq_as_nmi' was not declared. Should it be static?
arch/arm/kernel/traps.c:535:17: warning: symbol 'bad_mode' was not declared. Should it be static?
arch/arm/kernel/traps.c:608:16: warning: symbol 'arm_syscall' was not declared. Should it be static?
arch/arm/kernel/traps.c:734:1: warning: symbol 'baddataabort' was not declared. Should it be static?
arch/arm/kernel/traps.c:774:17: warning: symbol '__div0' was not declared. Should it be static?
arch/arm/kernel/traps.c:781:6: warning: symbol 'abort' was not declared. Should it be static?
arch/arm/kernel/traps.c:905:12: warning: symbol 'overflow_stack_ptr' was not declared. Should it be static?
arch/arm/kernel/traps.c:922:17: warning: symbol 'handle_bad_stack' was not declared. Should it be static?

> think this will (untested):
> 
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 3f468ac98592..827cbc022900 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -449,36 +449,45 @@ int call_undef_hook(struct pt_regs *regs, unsigned int instr)
>  asmlinkage void do_undefinstr(struct pt_regs *regs)
>  {
>  	unsigned int instr;
> -	void __user *pc;
> +	unsigned long pc;
>  
> -	pc = (void __user *)instruction_pointer(regs);
> +	pc = instruction_pointer(regs);
>  
>  	if (processor_mode(regs) == SVC_MODE) {
> -#ifdef CONFIG_THUMB2_KERNEL
> -		if (thumb_mode(regs)) {
> -			instr = __mem_to_opcode_thumb16(((u16 *)pc)[0]);
> +		if (IS_ENABLED(CONFIG_THUMB2_KERNEL) && thumb_mode(regs)) {
> +			u16 *tpc = (u16 *)pc;
> +
> +			instr = __mem_to_opcode_thumb16(tpc[0]);
>  			if (is_wide_instruction(instr)) {
>  				u16 inst2;
> -				inst2 = __mem_to_opcode_thumb16(((u16 *)pc)[1]);
> +
> +				inst2 = __mem_to_opcode_thumb16(tpc[1]);
>  				instr = __opcode_thumb32_compose(instr, inst2);
>  			}
> -		} else
> -#endif
> -			instr = __mem_to_opcode_arm(*(u32 *) pc);
> +		} else {
> +			u32 *apc = (u32 *)pc;
> +
> +			instr = __mem_to_opcode_arm(*apc);
> +		}
>  	} else if (thumb_mode(regs)) {
> -		if (get_user(instr, (u16 __user *)pc))
> +		u16 __user *tpc = (u16 __user *)pc;
> +
> +		if (get_user(instr, tpc))
>  			goto die_sig;
>  		instr = __mem_to_opcode_thumb16(instr);
>  		if (is_wide_instruction(instr)) {
>  			unsigned int instr2;
> -			if (get_user(instr2, (u16 __user *)pc+1))
> +			if (get_user(instr2, tpc + 1))
>  				goto die_sig;
>  			instr2 = __mem_to_opcode_thumb16(instr2);
>  			instr = __opcode_thumb32_compose(instr, instr2);
>  		}
>  	} else {
> -		if (get_user(instr, (u32 __user *)pc))
> +		u32 __user *apc = (u32 __user *)pc;
> +
> +		if (get_user(instr, apc))
>  			goto die_sig;
> +
>  		instr = __mem_to_opcode_arm(instr);
>  	}
>  
> @@ -495,7 +504,7 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
>  	}
>  #endif
>  	arm_notify_die("Oops - undefined instruction", regs,
> -		       SIGILL, ILL_ILLOPC, pc, 0, 6);
> +		       SIGILL, ILL_ILLOPC, (void __user *)pc, 0, 6);
>  }
>  NOKPROBE_SYMBOL(do_undefinstr)
>  
> 

-- 
Regards,
  Zhen Lei

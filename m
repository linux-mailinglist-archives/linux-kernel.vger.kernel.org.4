Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A6365845A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbiL1Q5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbiL1Q4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:56:17 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E214910CB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:51:38 -0800 (PST)
Received: from loongson.cn (unknown [60.166.162.119])
        by gateway (Coremail) with SMTP id _____8CxpfAYdKxjSgsJAA--.19508S3;
        Thu, 29 Dec 2022 00:51:36 +0800 (CST)
Received: from [192.168.31.101] (unknown [60.166.162.119])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxsOQVdKxjA74OAA--.49348S3;
        Thu, 29 Dec 2022 00:51:34 +0800 (CST)
Message-ID: <b267cab1-3df4-6263-9c83-0061f20dd4a4@loongson.cn>
Date:   Thu, 29 Dec 2022 00:51:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] LoongArch: Fix irq enable in exception handlers
Content-Language: en-US
To:     Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221221074238.6699-1-hejinyang@loongson.cn>
 <CAAhV-H6VX=d1oymY0rh-mwOPMuBsYd7C9RzQat8BmmnrJ7apng@mail.gmail.com>
 <8eaea09e-67b0-5e51-4632-2c31a4c56a3e@loongson.cn>
 <CAAhV-H7maW1YWhfvCzYVix=aCMMFbx0KkGodaBjka4ThunBO5Q@mail.gmail.com>
 <1c578efd-ae8a-2d80-e505-a09b1a2f7eaa@loongson.cn>
From:   Qi Hu <huqi@loongson.cn>
In-Reply-To: <1c578efd-ae8a-2d80-e505-a09b1a2f7eaa@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxsOQVdKxjA74OAA--.49348S3
X-CM-SenderInfo: pkxtxqxorr0wxvrqhubq/1tbiAQAOCWOsMeoCBgABsX
X-Coremail-Antispam: 1Uk129KBjvJXoWxKw4UtryUJr4kJF1fAw4DXFb_yoWfXw1fpF
        1kAF1UGry5Ar1kXr12qr1jyryUtr1Ut3WUXr18Ja4rJrsFyrn0gr18Xr1qgr1UAr48Jr1U
        Xr15tF1293WUJF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bx8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVWUJVW8JwAS0I0E
        0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJUUUUU=
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/12/27 18:10, Jinyang He wrote:
> On 2022-12-27 17:52, Huacai Chen wrote:
>
>> On Tue, Dec 27, 2022 at 5:30 PM Jinyang He <hejinyang@loongson.cn> 
>> wrote:
>>>
>>> On 2022-12-27 15:37, Huacai Chen wrote:
>>>> Hi, Jinyang,
>>>>
>>>> Move die_if_kernel to irq disabled context to solve what?
>>> For more strict logical. If the code flow go to die in die_if_kernel(),
>>> its interrupt state is enable, that means it may cause schedule.
>>> So I think it is better to call die_if_kernel() firstly.
>> die_if_kernel is called with irq enabled in old kernels for several
>> years, and has no problems.
>
>
> I think because it never call die() in die_if_kernel(). What I do
> emphasize is that there needs to be more strict logic here than
> it worked well in the past. I bet if die_if_kernel() was removed,
> it will still work well in the future.
>
>
>>
>>>
>>>>    And LBT is
>>>> surely allowed to be triggered in kernel context.
>>> I'm not familar with lbt, I just not see any lbt codes in kernel. Plz,
>>> how lbt exception triggered, and how kernel trigger lbt exception?
>> You can ask Huqi for more details, and this was discussed publicly 
>> last week.
>
> To: Qi Hu
>
>
> Hi,
>
>
> We really need some help. Can you give us some ideas?
>
>
> Thanks,
>
> Jinyang
>
Huacai is correct. The LBT disable exception (BTD) can be triggered in 
kernel context.

If the CSR.ENEU.BTE == 0 [^1], the LBT instructions (these [^2] will be 
used in the kernel) will trigger the exception.

Unfortunately, when you want to do some fpu_{save, restore}, you need to 
use some LBT instructions [^3] [^4]. So if FPD is triggered, LBT might 
still not be enabled, and the 'do_lbt' will be called in the kernel context.

Hope the information can help. Thanks.


[1] 
https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#extended-component-unit-enable

[2] 
https://github.com/loongson/linux/pull/4/files#diff-381d03cf86e2796d280e2fc82c005409d5e44b4bbbf90dd0dc17f5f0fa5553f1R140-R184

[3] 
https://github.com/loongson/linux/pull/4/files#diff-381d03cf86e2796d280e2fc82c005409d5e44b4bbbf90dd0dc17f5f0fa5553f1R218-R230

[4] 
https://github.com/loongson/linux/pull/4/files#diff-381d03cf86e2796d280e2fc82c005409d5e44b4bbbf90dd0dc17f5f0fa5553f1R236-R263


Qi

>
>> Huacai
>>>
>>> Thanks,
>>>
>>> Jinyang
>>>
>>>
>>>> Huacai
>>>>
>>>> On Wed, Dec 21, 2022 at 3:43 PM Jinyang He <hejinyang@loongson.cn> 
>>>> wrote:
>>>>> The interrupt state can be got by regs->csr_prmd. Once previous
>>>>> interrupt state is disable, we shouldn't enable interrupt if we
>>>>> triggered exception which can be triggered in kernel mode. So
>>>>> conditionally enable interrupt. For those do_\exception which
>>>>> can not triggered in kernel mode but need enable interrupt, call
>>>>> die_if_kernel() firstly. And for do_lsx, do_lasx and do_lbt cannot
>>>>> triggered in kernel mode, too.
>>>>>
>>>>> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
>>>>> ---
>>>>>    arch/loongarch/kernel/traps.c | 19 ++++++++++---------
>>>>>    1 file changed, 10 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/arch/loongarch/kernel/traps.c 
>>>>> b/arch/loongarch/kernel/traps.c
>>>>> index 1ea14f6c18d3..3ac7b32d1e15 100644
>>>>> --- a/arch/loongarch/kernel/traps.c
>>>>> +++ b/arch/loongarch/kernel/traps.c
>>>>> @@ -340,9 +340,9 @@ asmlinkage void noinstr do_fpe(struct pt_regs 
>>>>> *regs, unsigned long fcsr)
>>>>>
>>>>>           /* Clear FCSR.Cause before enabling interrupts */
>>>>>           write_fcsr(LOONGARCH_FCSR0, fcsr & ~mask_fcsr_x(fcsr));
>>>>> -       local_irq_enable();
>>>>>
>>>>>           die_if_kernel("FP exception in kernel code", regs);
>>>>> +       local_irq_enable();
>>>>>
>>>>>           sig = SIGFPE;
>>>>>           fault_addr = (void __user *) regs->csr_era;
>>>>> @@ -432,7 +432,8 @@ asmlinkage void noinstr do_bp(struct pt_regs 
>>>>> *regs)
>>>>>           unsigned long era = exception_era(regs);
>>>>>           irqentry_state_t state = irqentry_enter(regs);
>>>>>
>>>>> -       local_irq_enable();
>>>>> +       if (regs->csr_prmd & CSR_PRMD_PIE)
>>>>> +               local_irq_enable();
>>>>>           current->thread.trap_nr = read_csr_excode();
>>>>>           if (__get_inst(&opcode, (u32 *)era, user))
>>>>>                   goto out_sigsegv;
>>>>> @@ -514,7 +515,8 @@ asmlinkage void noinstr do_ri(struct pt_regs 
>>>>> *regs)
>>>>>           unsigned int __user *era = (unsigned int __user 
>>>>> *)exception_era(regs);
>>>>>           irqentry_state_t state = irqentry_enter(regs);
>>>>>
>>>>> -       local_irq_enable();
>>>>> +       if (regs->csr_prmd & CSR_PRMD_PIE)
>>>>> +               local_irq_enable();
>>>>>           current->thread.trap_nr = read_csr_excode();
>>>>>
>>>>>           if (notify_die(DIE_RI, "RI Fault", regs, 0, 
>>>>> current->thread.trap_nr,
>>>>> @@ -606,8 +608,8 @@ asmlinkage void noinstr do_fpu(struct pt_regs 
>>>>> *regs)
>>>>>    {
>>>>>           irqentry_state_t state = irqentry_enter(regs);
>>>>>
>>>>> -       local_irq_enable();
>>>>>           die_if_kernel("do_fpu invoked from kernel context!", regs);
>>>>> +       local_irq_enable();
>>>>>           BUG_ON(is_lsx_enabled());
>>>>>           BUG_ON(is_lasx_enabled());
>>>>>
>>>>> @@ -623,13 +625,13 @@ asmlinkage void noinstr do_lsx(struct 
>>>>> pt_regs *regs)
>>>>>    {
>>>>>           irqentry_state_t state = irqentry_enter(regs);
>>>>>
>>>>> +       die_if_kernel("do_lsx invoked from kernel context!", regs);
>>>>>           local_irq_enable();
>>>>>           if (!cpu_has_lsx) {
>>>>>                   force_sig(SIGILL);
>>>>>                   goto out;
>>>>>           }
>>>>>
>>>>> -       die_if_kernel("do_lsx invoked from kernel context!", regs);
>>>>>           BUG_ON(is_lasx_enabled());
>>>>>
>>>>>           preempt_disable();
>>>>> @@ -645,14 +647,13 @@ asmlinkage void noinstr do_lasx(struct 
>>>>> pt_regs *regs)
>>>>>    {
>>>>>           irqentry_state_t state = irqentry_enter(regs);
>>>>>
>>>>> +       die_if_kernel("do_lasx invoked from kernel context!", regs);
>>>>>           local_irq_enable();
>>>>>           if (!cpu_has_lasx) {
>>>>>                   force_sig(SIGILL);
>>>>>                   goto out;
>>>>>           }
>>>>>
>>>>> -       die_if_kernel("do_lasx invoked from kernel context!", regs);
>>>>> -
>>>>>           preempt_disable();
>>>>>           init_restore_lasx();
>>>>>           preempt_enable();
>>>>> @@ -666,6 +667,7 @@ asmlinkage void noinstr do_lbt(struct pt_regs 
>>>>> *regs)
>>>>>    {
>>>>>           irqentry_state_t state = irqentry_enter(regs);
>>>>>
>>>>> +       die_if_kernel("do_lbt invoked from kernel context!", regs);
>>>>>           local_irq_enable();
>>>>>           force_sig(SIGILL);
>>>>>           local_irq_disable();
>>>>> @@ -677,7 +679,6 @@ asmlinkage void noinstr do_reserved(struct 
>>>>> pt_regs *regs)
>>>>>    {
>>>>>           irqentry_state_t state = irqentry_enter(regs);
>>>>>
>>>>> -       local_irq_enable();
>>>>>           /*
>>>>>            * Game over - no way to handle this if it ever occurs. 
>>>>> Most probably
>>>>>            * caused by a fatal error after another 
>>>>> hardware/software error.
>>>>> @@ -685,8 +686,8 @@ asmlinkage void noinstr do_reserved(struct 
>>>>> pt_regs *regs)
>>>>>           pr_err("Caught reserved exception %u on pid:%d [%s] - 
>>>>> should not happen\n",
>>>>>                   read_csr_excode(), current->pid, current->comm);
>>>>>           die_if_kernel("do_reserved exception", regs);
>>>>> +       local_irq_enable();
>>>>>           force_sig(SIGUNUSED);
>>>>> -
>>>>>           local_irq_disable();
>>>>>
>>>>>           irqentry_exit(regs, state);
>>>>> -- 
>>>>> 2.34.3
>>>>>
>>>
>


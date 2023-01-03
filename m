Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB56665BC63
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbjACImu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbjACImq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:42:46 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7965632D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:42:44 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8AxDOuD6rNj6hYKAA--.22126S3;
        Tue, 03 Jan 2023 16:42:43 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxUuV_6rNj4csSAA--.60257S3;
        Tue, 03 Jan 2023 16:42:40 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Fix irq enable in exception handlers
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Qi Hu <huqi@loongson.cn>, WANG Xuerui <kernel@xen0n.name>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221221074238.6699-1-hejinyang@loongson.cn>
 <CAAhV-H6VX=d1oymY0rh-mwOPMuBsYd7C9RzQat8BmmnrJ7apng@mail.gmail.com>
 <8eaea09e-67b0-5e51-4632-2c31a4c56a3e@loongson.cn>
 <CAAhV-H7maW1YWhfvCzYVix=aCMMFbx0KkGodaBjka4ThunBO5Q@mail.gmail.com>
 <1c578efd-ae8a-2d80-e505-a09b1a2f7eaa@loongson.cn>
 <b267cab1-3df4-6263-9c83-0061f20dd4a4@loongson.cn>
 <2364400d-bb1e-cbe2-8a65-adbe87186938@loongson.cn>
 <7a028a4d-71f0-7064-cc1c-0ca50749ef2e@loongson.cn>
 <2190a195-53bb-09a8-9130-101c040edd09@loongson.cn>
 <CAAhV-H7--u0aXy-aAdkJ_KBwimcJ-V+yfbFqS8MsAOHpArWJ2g@mail.gmail.com>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <f0192bb6-2a5c-d51e-ef11-190fd61af0b9@loongson.cn>
Date:   Tue, 3 Jan 2023 16:42:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7--u0aXy-aAdkJ_KBwimcJ-V+yfbFqS8MsAOHpArWJ2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxUuV_6rNj4csSAA--.60257S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWfGrWDtF1xAr1fGFWUtw4UXFb_yoWDAFWrpF
        17AF4UGF4UJr17Xr12qw1jvr1UtrW8tr18Wr1UAw15Gw1qyr1DJr18Jr4UGF1UZr1UGr10
        qr1UtF12g3WUJFUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-01-03 12:54, Huacai Chen wrote:
> On Fri, Dec 30, 2022 at 1:58 PM Jinyang He <hejinyang@loongson.cn> wrote:
>>
>> On 2022-12-29 14:54, Qi Hu wrote:
>>> On 2022/12/29 14:13, Jinyang He wrote:
>>>> On 2022-12-29 00:51, Qi Hu wrote:
>>>>
>>>>> On 2022/12/27 18:10, Jinyang He wrote:
>>>>>> On 2022-12-27 17:52, Huacai Chen wrote:
>>>>>>
>>>>>>> On Tue, Dec 27, 2022 at 5:30 PM Jinyang He <hejinyang@loongson.cn>
>>>>>>> wrote:
>>>>>>>> On 2022-12-27 15:37, Huacai Chen wrote:
>>>>>>>>> Hi, Jinyang,
>>>>>>>>>
>>>>>>>>> Move die_if_kernel to irq disabled context to solve what?
>>>>>>>> For more strict logical. If the code flow go to die in
>>>>>>>> die_if_kernel(),
>>>>>>>> its interrupt state is enable, that means it may cause schedule.
>>>>>>>> So I think it is better to call die_if_kernel() firstly.
>>>>>>> die_if_kernel is called with irq enabled in old kernels for several
>>>>>>> years, and has no problems.
>>>>>>
>>>>>> I think because it never call die() in die_if_kernel(). What I do
>>>>>> emphasize is that there needs to be more strict logic here than
>>>>>> it worked well in the past. I bet if die_if_kernel() was removed,
>>>>>> it will still work well in the future.
>>>>>>
>>>>>>
>>>>>>>>>     And LBT is
>>>>>>>>> surely allowed to be triggered in kernel context.
>>>>>>>> I'm not familar with lbt, I just not see any lbt codes in kernel.
>>>>>>>> Plz,
>>>>>>>> how lbt exception triggered, and how kernel trigger lbt exception?
>>>>>>> You can ask Huqi for more details, and this was discussed publicly
>>>>>>> last week.
>>>>>> To: Qi Hu
>>>>>>
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>>
>>>>>> We really need some help. Can you give us some ideas?
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Jinyang
>>>>>>
>>>>> Huacai is correct. The LBT disable exception (BTD) can be triggered
>>>>> in kernel context.
>>>>>
>>>>> If the CSR.ENEU.BTE == 0 [^1], the LBT instructions (these [^2] will
>>>>> be used in the kernel) will trigger the exception.
>>>>>
>>>>> Unfortunately, when you want to do some fpu_{save, restore}, you
>>>>> need to use some LBT instructions [^3] [^4]. So if FPD is triggered,
>>>>> LBT might still not be enabled, and the 'do_lbt' will be called in
>>>>> the kernel context.
>>>>>
>>>>> Hope the information can help. Thanks.
>>>>>
>>>>>
>>>>> [1]
>>>>> https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#extended-component-unit-enable
>>>>>
>>>>> [2]
>>>>> https://github.com/loongson/linux/pull/4/files#diff-381d03cf86e2796d280e2fc82c005409d5e44b4bbbf90dd0dc17f5f0fa5553f1R140-R184
>>>>>
>>>>> [3]
>>>>> https://github.com/loongson/linux/pull/4/files#diff-381d03cf86e2796d280e2fc82c005409d5e44b4bbbf90dd0dc17f5f0fa5553f1R218-R230
>>>>>
>>>>> [4]
>>>>> https://github.com/loongson/linux/pull/4/files#diff-381d03cf86e2796d280e2fc82c005409d5e44b4bbbf90dd0dc17f5f0fa5553f1R236-R263
>>>>>
>>>>>
>>>> Hi,
>>>>
>>>>
>>>> That's helpful. Thanks!
>>>>
>>>>
>>>> But I still wonder if SXD or ASXD have the same possibility of being
>>>> triggered in the kernel mode by sc_save_{lsx, lasx} or other place.
>>>> Do we need remove these die_if_kernel codes in do_lasx() and do_lsx()?
>>>>
>>>>
>>>> Jinyang
>>>>
>>> Hi Jinyang,
>>>
>>> I think only BTD has this tricky situation, because there is some
>>> overlap between FPD/SXD/ASXD and BTD.
>>>
>>> So, in my view, SXD or ASXD will not be triggered in kernel mode.
>>>
>>> Thanks.
>>>
>>>
>>> Qi
>> Got it. Thanks for your help. And I'll fix my patch in next version.
> In my opinion only the do_bp() modification is useful, and that part
> can be squashed to Tiezhu's kprobe patches.

Yes, I have to admit that only the modification of do_bp() is useful,
in fact other modification are not triggered, I think. Most do_xxx is
irq enabled or in user mode before triggered. Although I can give a test
in Qemu that make do_ri() triggered in irq disable state, and then it
will hang if unconditionally call local_irq_enable, I know it makes no sense
because these codes can not be triggered currently, just like this BUG
cannot be found only before Tiezhu supporting kprobe on LoongArch.

If leaving potentially illogical codes is allowed, squash it to Tiezhu's
kprobe patches.

Jinyang

>
> Huacai
>>
>> Jinyang
>>
>>
>>>>> Qi
>>>>>
>>>>>>> Huacai
>>>>>>>> Thanks,
>>>>>>>>
>>>>>>>> Jinyang
>>>>>>>>
>>>>>>>>
>>>>>>>>> Huacai
>>>>>>>>>
>>>>>>>>> On Wed, Dec 21, 2022 at 3:43 PM Jinyang He
>>>>>>>>> <hejinyang@loongson.cn> wrote:
>>>>>>>>>> The interrupt state can be got by regs->csr_prmd. Once previous
>>>>>>>>>> interrupt state is disable, we shouldn't enable interrupt if we
>>>>>>>>>> triggered exception which can be triggered in kernel mode. So
>>>>>>>>>> conditionally enable interrupt. For those do_\exception which
>>>>>>>>>> can not triggered in kernel mode but need enable interrupt, call
>>>>>>>>>> die_if_kernel() firstly. And for do_lsx, do_lasx and do_lbt cannot
>>>>>>>>>> triggered in kernel mode, too.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
>>>>>>>>>> ---
>>>>>>>>>>     arch/loongarch/kernel/traps.c | 19 ++++++++++---------
>>>>>>>>>>     1 file changed, 10 insertions(+), 9 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/arch/loongarch/kernel/traps.c
>>>>>>>>>> b/arch/loongarch/kernel/traps.c
>>>>>>>>>> index 1ea14f6c18d3..3ac7b32d1e15 100644
>>>>>>>>>> --- a/arch/loongarch/kernel/traps.c
>>>>>>>>>> +++ b/arch/loongarch/kernel/traps.c
>>>>>>>>>> @@ -340,9 +340,9 @@ asmlinkage void noinstr do_fpe(struct
>>>>>>>>>> pt_regs *regs, unsigned long fcsr)
>>>>>>>>>>
>>>>>>>>>>            /* Clear FCSR.Cause before enabling interrupts */
>>>>>>>>>>            write_fcsr(LOONGARCH_FCSR0, fcsr & ~mask_fcsr_x(fcsr));
>>>>>>>>>> -       local_irq_enable();
>>>>>>>>>>
>>>>>>>>>>            die_if_kernel("FP exception in kernel code", regs);
>>>>>>>>>> +       local_irq_enable();
>>>>>>>>>>
>>>>>>>>>>            sig = SIGFPE;
>>>>>>>>>>            fault_addr = (void __user *) regs->csr_era;
>>>>>>>>>> @@ -432,7 +432,8 @@ asmlinkage void noinstr do_bp(struct
>>>>>>>>>> pt_regs *regs)
>>>>>>>>>>            unsigned long era = exception_era(regs);
>>>>>>>>>>            irqentry_state_t state = irqentry_enter(regs);
>>>>>>>>>>
>>>>>>>>>> -       local_irq_enable();
>>>>>>>>>> +       if (regs->csr_prmd & CSR_PRMD_PIE)
>>>>>>>>>> +               local_irq_enable();
>>>>>>>>>>            current->thread.trap_nr = read_csr_excode();
>>>>>>>>>>            if (__get_inst(&opcode, (u32 *)era, user))
>>>>>>>>>>                    goto out_sigsegv;
>>>>>>>>>> @@ -514,7 +515,8 @@ asmlinkage void noinstr do_ri(struct
>>>>>>>>>> pt_regs *regs)
>>>>>>>>>>            unsigned int __user *era = (unsigned int __user
>>>>>>>>>> *)exception_era(regs);
>>>>>>>>>>            irqentry_state_t state = irqentry_enter(regs);
>>>>>>>>>>
>>>>>>>>>> -       local_irq_enable();
>>>>>>>>>> +       if (regs->csr_prmd & CSR_PRMD_PIE)
>>>>>>>>>> +               local_irq_enable();
>>>>>>>>>>            current->thread.trap_nr = read_csr_excode();
>>>>>>>>>>
>>>>>>>>>>            if (notify_die(DIE_RI, "RI Fault", regs, 0,
>>>>>>>>>> current->thread.trap_nr,
>>>>>>>>>> @@ -606,8 +608,8 @@ asmlinkage void noinstr do_fpu(struct
>>>>>>>>>> pt_regs *regs)
>>>>>>>>>>     {
>>>>>>>>>>            irqentry_state_t state = irqentry_enter(regs);
>>>>>>>>>>
>>>>>>>>>> -       local_irq_enable();
>>>>>>>>>>            die_if_kernel("do_fpu invoked from kernel context!",
>>>>>>>>>> regs);
>>>>>>>>>> +       local_irq_enable();
>>>>>>>>>>            BUG_ON(is_lsx_enabled());
>>>>>>>>>>            BUG_ON(is_lasx_enabled());
>>>>>>>>>>
>>>>>>>>>> @@ -623,13 +625,13 @@ asmlinkage void noinstr do_lsx(struct
>>>>>>>>>> pt_regs *regs)
>>>>>>>>>>     {
>>>>>>>>>>            irqentry_state_t state = irqentry_enter(regs);
>>>>>>>>>>
>>>>>>>>>> +       die_if_kernel("do_lsx invoked from kernel context!",
>>>>>>>>>> regs);
>>>>>>>>>>            local_irq_enable();
>>>>>>>>>>            if (!cpu_has_lsx) {
>>>>>>>>>>                    force_sig(SIGILL);
>>>>>>>>>>                    goto out;
>>>>>>>>>>            }
>>>>>>>>>>
>>>>>>>>>> -       die_if_kernel("do_lsx invoked from kernel context!",
>>>>>>>>>> regs);
>>>>>>>>>>            BUG_ON(is_lasx_enabled());
>>>>>>>>>>
>>>>>>>>>>            preempt_disable();
>>>>>>>>>> @@ -645,14 +647,13 @@ asmlinkage void noinstr do_lasx(struct
>>>>>>>>>> pt_regs *regs)
>>>>>>>>>>     {
>>>>>>>>>>            irqentry_state_t state = irqentry_enter(regs);
>>>>>>>>>>
>>>>>>>>>> +       die_if_kernel("do_lasx invoked from kernel context!",
>>>>>>>>>> regs);
>>>>>>>>>>            local_irq_enable();
>>>>>>>>>>            if (!cpu_has_lasx) {
>>>>>>>>>>                    force_sig(SIGILL);
>>>>>>>>>>                    goto out;
>>>>>>>>>>            }
>>>>>>>>>>
>>>>>>>>>> -       die_if_kernel("do_lasx invoked from kernel context!",
>>>>>>>>>> regs);
>>>>>>>>>> -
>>>>>>>>>>            preempt_disable();
>>>>>>>>>>            init_restore_lasx();
>>>>>>>>>>            preempt_enable();
>>>>>>>>>> @@ -666,6 +667,7 @@ asmlinkage void noinstr do_lbt(struct
>>>>>>>>>> pt_regs *regs)
>>>>>>>>>>     {
>>>>>>>>>>            irqentry_state_t state = irqentry_enter(regs);
>>>>>>>>>>
>>>>>>>>>> +       die_if_kernel("do_lbt invoked from kernel context!",
>>>>>>>>>> regs);
>>>>>>>>>>            local_irq_enable();
>>>>>>>>>>            force_sig(SIGILL);
>>>>>>>>>>            local_irq_disable();
>>>>>>>>>> @@ -677,7 +679,6 @@ asmlinkage void noinstr do_reserved(struct
>>>>>>>>>> pt_regs *regs)
>>>>>>>>>>     {
>>>>>>>>>>            irqentry_state_t state = irqentry_enter(regs);
>>>>>>>>>>
>>>>>>>>>> -       local_irq_enable();
>>>>>>>>>>            /*
>>>>>>>>>>             * Game over - no way to handle this if it ever
>>>>>>>>>> occurs. Most probably
>>>>>>>>>>             * caused by a fatal error after another
>>>>>>>>>> hardware/software error.
>>>>>>>>>> @@ -685,8 +686,8 @@ asmlinkage void noinstr do_reserved(struct
>>>>>>>>>> pt_regs *regs)
>>>>>>>>>>            pr_err("Caught reserved exception %u on pid:%d [%s] -
>>>>>>>>>> should not happen\n",
>>>>>>>>>>                    read_csr_excode(), current->pid, current->comm);
>>>>>>>>>>            die_if_kernel("do_reserved exception", regs);
>>>>>>>>>> +       local_irq_enable();
>>>>>>>>>>            force_sig(SIGUNUSED);
>>>>>>>>>> -
>>>>>>>>>>            local_irq_disable();
>>>>>>>>>>
>>>>>>>>>>            irqentry_exit(regs, state);
>>>>>>>>>> --
>>>>>>>>>> 2.34.3
>>>>>>>>>>


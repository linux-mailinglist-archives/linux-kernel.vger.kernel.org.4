Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D43364564E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiLGJSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiLGJR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:17:59 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C0D6F5A3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 01:17:47 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Dx9vA6WpBjTcgDAA--.8757S3;
        Wed, 07 Dec 2022 17:17:46 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxDuI5WpBjVyYnAA--.31308S3;
        Wed, 07 Dec 2022 17:17:46 +0800 (CST)
Subject: Re: [PATCH v7 2/4] LoongArch: Add kprobe support
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1669986505-11322-1-git-send-email-yangtiezhu@loongson.cn>
 <1669986505-11322-3-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H7nVtZRMpqpK6bi9-OqH+_pHxB=qPb5fTisb+EnaKKPAw@mail.gmail.com>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <c76b6b50-246e-f325-5f4b-b67327e06c10@loongson.cn>
Date:   Wed, 7 Dec 2022 17:17:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7nVtZRMpqpK6bi9-OqH+_pHxB=qPb5fTisb+EnaKKPAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxDuI5WpBjVyYnAA--.31308S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZr4DJFyktF4xJF4UZry7Jrb_yoW5KF1DpF
        ZxA3yfK3ykXry0yFW2qw1Ykr1ftr1rArW8C3yUKFy3Jw1DC34rKr1xCw47WFy8CrnY9F4S
        vr12vFZ3uas3ArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04
        k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
        MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr4
        1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l
        IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
        A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8P5r7UUUUU==
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/07/2022 11:08 AM, Huacai Chen wrote:
> Hi, Tiezhu,
>
> On Fri, Dec 2, 2022 at 9:08 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> Kprobes allows you to trap at almost any kernel address and
>> execute a callback function, this commit adds kprobe support
>> for LoongArch.

...

>> +
>> +       if (p->ainsn.insn->word == breakpoint_insn.word) {
>> +               regs->csr_prmd &= ~CSR_PRMD_PIE;
>> +               regs->csr_prmd |= kcb->kprobe_saved_irq;
>> +               preempt_enable_no_resched();
>> +               return;
>> +       }
>> +
>> +       regs->csr_prmd &= ~CSR_PRMD_PIE;
> You can put this line before the previous if, then the line in the if
> can be removed.

OK, will modify it.

>> +
>> +       if (insns_are_not_simulated(p, regs)) {
>> +               kcb->kprobe_status = KPROBE_HIT_SS;
>> +               regs->csr_era = (unsigned long)&p->ainsn.insn[0];
>> +       } else {
>> +               kcb->kprobe_status = KPROBE_HIT_SSDONE;
>> +               if (p->post_handler)
>> +                       p->post_handler(p, regs, 0);
>> +               reset_current_kprobe();
>> +               preempt_enable_no_resched();
>> +       }
>> +}
>> +NOKPROBE_SYMBOL(setup_singlestep);

...

>> +bool kprobe_singlestep_handler(struct pt_regs *regs)
>> +{
>> +       struct kprobe *cur = kprobe_running();
>> +       struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +
>> +       if (!cur)
>> +               return false;
>> +
>> +       /* Restore back the original saved kprobes variables and continue */
>> +       if (kcb->kprobe_status == KPROBE_REENTER) {
>> +               restore_previous_kprobe(kcb);
>> +               goto out;
>> +       }
>> +
>> +       /* Call post handler */
>> +       kcb->kprobe_status = KPROBE_HIT_SSDONE;
>> +       if (cur->post_handler)
>> +               cur->post_handler(cur, regs, 0);
>> +
>> +       regs->csr_era = kcb->kprobe_saved_era + LOONGARCH_INSN_SIZE;
>> +       regs->csr_prmd |= kcb->kprobe_saved_irq;
>> +
>> +       reset_current_kprobe();
>> +out:
>> +       preempt_enable_no_resched();
> You didn't disable preemption, why enable preemption here? I think you
> should do similar things like kprobe_breakpoint_handler().
>
>> +       return true;
>> +}
>> +NOKPROBE_SYMBOL(kprobe_singlestep_handler);
>> +
>> +bool kprobe_fault_handler(struct pt_regs *regs, int trapnr)
>> +{
>> +       struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +
>> +       if (kcb->kprobe_status & KPROBE_HIT_SS) {
>> +               regs->csr_era = kcb->kprobe_saved_era + LOONGARCH_INSN_SIZE;
>> +               regs->csr_prmd |= kcb->kprobe_saved_irq;
>> +
>> +               reset_current_kprobe();
>> +               preempt_enable_no_resched();
> Here has the same problem as before, I doubt you haven't tested your
> code (at least insufficient), and this is completely unacceptable for
> me.

preempt_disable() in kprobe_breakpoint_handler() is valid for
the entire duration of kprobe processing, so call the function
preempt_enable_no_resched() in kprobe_singlestep_handler() and
kprobe_fault_handler() has no problem, let me add a code comment
before preempt_disable(), like this:

+       /*
+        * We don't want to be preempted for the entire
+        * duration of kprobe processing.
+        */
         preempt_disable();

>> +       }
>> +
>> +       return false;
>> +}
>> +NOKPROBE_SYMBOL(kprobe_fault_handler);

...

>> diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
>> index 1ccd536..fc9225a 100644
>> --- a/arch/loongarch/mm/fault.c
>> +++ b/arch/loongarch/mm/fault.c
>> @@ -253,12 +253,16 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
>>  {
>>         irqentry_state_t state = irqentry_enter(regs);
>>
>> +       if (kprobe_page_fault(regs, current->thread.trap_nr))
>> +               goto out;
>> +
> This should be after the conditional local_irq_enable(), I think.

OK, will modify it.

Thanks,
Tiezhu


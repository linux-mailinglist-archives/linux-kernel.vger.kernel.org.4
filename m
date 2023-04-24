Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980D16ECB3A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDXLXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjDXLXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:23:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C080211F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:23:13 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8Cx_eqfZkZkcQUAAA--.50S3;
        Mon, 24 Apr 2023 19:23:11 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxAeWeZkZktrE4AA--.40489S3;
        Mon, 24 Apr 2023 19:23:11 +0800 (CST)
Message-ID: <71678ebe-db31-bbcd-7b32-8b29b874d635@loongson.cn>
Date:   Mon, 24 Apr 2023 19:23:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Loongson (and other $ARCHs?) idle VS timer enqueue
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <ZEKDZEQmKExv0O7Q@lothringen> <87leil2r7v.ffs@tglx>
 <20230422081700.GB1214746@hirez.programming.kicks-ass.net>
 <ZEPteS82TbIhMQxe@lothringen>
 <20230422150409.GL1214746@hirez.programming.kicks-ass.net>
 <7d91fa2a-57c5-6c78-8e2d-7fbdd6a11cba@loongson.cn>
 <ZEY9UvvuTXYx3QEA@lothringen>
Content-Language: en-US
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <ZEY9UvvuTXYx3QEA@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxAeWeZkZktrE4AA--.40489S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Cr13Cw15KF15Wr4fJF1DWrg_yoW8Cr47p3
        48Aa1qkFWktr95K34ayw1v9Fn8Kr1DKry5uwn5Kry8AFs0vr15Jw1jqrZ0ga4Sqr4rX3WI
        qF4rXa4a93W5AaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTmDUUUU
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/24 16:26, Frederic Weisbecker 写道:
> On Sun, Apr 23, 2023 at 09:52:49PM +0800, bibo, mao wrote:
>>
>>
>> 在 2023/4/22 23:04, Peter Zijlstra 写道:
>>> On Sat, Apr 22, 2023 at 04:21:45PM +0200, Frederic Weisbecker wrote:
>>>> On Sat, Apr 22, 2023 at 10:17:00AM +0200, Peter Zijlstra wrote:
>>>>> diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
>>>>> index 44ff1ff64260..5a102ff80de0 100644
>>>>> --- a/arch/loongarch/kernel/genex.S
>>>>> +++ b/arch/loongarch/kernel/genex.S
>>>>> @@ -40,6 +40,7 @@ SYM_FUNC_START(handle_vint)
>>>>>   	ori	t0, t0, 0x1f
>>>>>   	xori	t0, t0, 0x1f
>>>>>   	bne	t0, t1, 1f
>>>>> +	addi.d	t0, t0, 0x20
>>>>>   	LONG_S	t0, sp, PT_ERA
>>>>>   1:	move	a0, sp
>>>>>   	move	a1, sp
>>>>
>>>> But the interrupts are enabled in C from arch_cpu_idle(), which
>>>> only then calls the ASM __arch_cpu_idle(). So if the interrupt happens
>>>> somewhere in between the call, the rollback (or fast-forward now)
>>>> doesn't apply.
>> I do not know much details about scheduler and timer, if the interrupt
>> happens between the call, will flag _TIF_NEED_RESCHED be set? If it is set,
>> the rollback will still apply.
> 
> Nop, TIF_NEED_RESCHED is set only if a task is ready to run after the interrupt,
> not if the interrupt only modified/added a timer.
Got it, thanks for your explanation, it is actually one issue in the LoongArch
ASM code __arch_cpu_idle().

Regards
Bibo, Mao

> 
>>> @@ -40,6 +40,7 @@ SYM_FUNC_START(handle_vint)
>>>   	ori	t0, t0, 0x1f
>>>   	xori	t0, t0, 0x1f
>>>   	bne	t0, t1, 1f
>>> +	addi.d	t0, t0, 0x20
>> It is more reasonable with this patch, this will jump out of idle function
>> directly after interrupt returns. If so, can we remove checking
>> _TIF_NEED_RESCHED in idle ASM function?
> 
> Indeed we can remove the check to TIF_RESCHED!
> 
> Thanks!


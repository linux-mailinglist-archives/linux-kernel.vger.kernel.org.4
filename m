Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66DB6EBFD5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 15:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjDWNwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 09:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjDWNwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 09:52:53 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D8941737
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 06:52:50 -0700 (PDT)
Received: from loongson.cn (unknown [223.72.41.205])
        by gateway (Coremail) with SMTP id _____8DxAf8xOEVkMBkhAA--.52021S3;
        Sun, 23 Apr 2023 21:52:49 +0800 (CST)
Received: from [192.168.1.14] (unknown [223.72.41.205])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx37MwOEVkX_A2AA--.8749S3;
        Sun, 23 Apr 2023 21:52:49 +0800 (CST)
Message-ID: <7d91fa2a-57c5-6c78-8e2d-7fbdd6a11cba@loongson.cn>
Date:   Sun, 23 Apr 2023 21:52:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Loongson (and other $ARCHs?) idle VS timer enqueue
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <ZEKDZEQmKExv0O7Q@lothringen> <87leil2r7v.ffs@tglx>
 <20230422081700.GB1214746@hirez.programming.kicks-ass.net>
 <ZEPteS82TbIhMQxe@lothringen>
 <20230422150409.GL1214746@hirez.programming.kicks-ass.net>
From:   "bibo, mao" <maobibo@loongson.cn>
In-Reply-To: <20230422150409.GL1214746@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx37MwOEVkX_A2AA--.8749S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxGFy5Xw48Xry3uw18Wr1kAFb_yoW5XFWrpr
        y8ua1vkFWvgr95W3sxtw1vqrn8JasrKrya9an5AFWrAF47ur1UXw18Z3s09FyFgw4fJr40
        gFnYqayS9a13JaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42
        xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
        GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI4
        8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4U
        MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
        8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1YL9UUUUU=
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/22 23:04, Peter Zijlstra 写道:
> On Sat, Apr 22, 2023 at 04:21:45PM +0200, Frederic Weisbecker wrote:
>> On Sat, Apr 22, 2023 at 10:17:00AM +0200, Peter Zijlstra wrote:
>>> diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
>>> index 44ff1ff64260..5a102ff80de0 100644
>>> --- a/arch/loongarch/kernel/genex.S
>>> +++ b/arch/loongarch/kernel/genex.S
>>> @@ -40,6 +40,7 @@ SYM_FUNC_START(handle_vint)
>>>   	ori	t0, t0, 0x1f
>>>   	xori	t0, t0, 0x1f
>>>   	bne	t0, t1, 1f
>>> +	addi.d	t0, t0, 0x20
>>>   	LONG_S	t0, sp, PT_ERA
>>>   1:	move	a0, sp
>>>   	move	a1, sp
>>
>> But the interrupts are enabled in C from arch_cpu_idle(), which
>> only then calls the ASM __arch_cpu_idle(). So if the interrupt happens
>> somewhere in between the call, the rollback (or fast-forward now)
>> doesn't apply.
I do not know much details about scheduler and timer, if the interrupt 
happens between the call, will flag _TIF_NEED_RESCHED be set? If it is 
set, the rollback will still apply.


>>
>> I guess interrupts need to be re-enabled from ASM in the beginning
>> of __arch_cpu_idle() so that it's part of the fast-forward region.
> 
> Right; something like so I suppose, but at this point I'm really just
> guessing... Loongarch person will have to do.
> 
> diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
> index 44ff1ff64260..4814ac5334ef 100644
> --- a/arch/loongarch/kernel/genex.S
> +++ b/arch/loongarch/kernel/genex.S
> @@ -19,13 +19,13 @@
>   	.align	5
>   SYM_FUNC_START(__arch_cpu_idle)
>   	/* start of rollback region */
> +	move	t0, CSR_CRMD_IE
> +	csrxchg	t0, t0, LOONGARCH_CSR_CRMD
>   	LONG_L	t0, tp, TI_FLAGS
>   	nop
>   	andi	t0, t0, _TIF_NEED_RESCHED
>   	bnez	t0, 1f
>   	nop
> -	nop
> -	nop
>   	idle	0
>   	/* end of rollback region */
>   1:	jr	ra
> @@ -40,6 +40,7 @@ SYM_FUNC_START(handle_vint)
>   	ori	t0, t0, 0x1f
>   	xori	t0, t0, 0x1f
>   	bne	t0, t1, 1f
> +	addi.d	t0, t0, 0x20
It is more reasonable with this patch, this will jump out of idle 
function directly after interrupt returns. If so, can we remove checking 
_TIF_NEED_RESCHED in idle ASM function?

 > +	move	t0, CSR_CRMD_IE
 > +	csrxchg	t0, t0, LOONGARCH_CSR_CRMD
-   	LONG_L	t0, tp, TI_FLAGS
+	nop
 >   	nop
-	andi	t0, t0, _TIF_NEED_RESCHED
-	bnez	t0, 1f
+	nop
+	nop
 >   	nop
 > -	nop
 > -	nop
 >   	idle	0

Regards
Bibo, Mao
>   	LONG_S	t0, sp, PT_ERA
>   1:	move	a0, sp
>   	move	a1, sp
> diff --git a/arch/loongarch/kernel/idle.c b/arch/loongarch/kernel/idle.c
> index 0b5dd2faeb90..5ba72d229920 100644
> --- a/arch/loongarch/kernel/idle.c
> +++ b/arch/loongarch/kernel/idle.c
> @@ -11,7 +11,6 @@
>   
>   void __cpuidle arch_cpu_idle(void)
>   {
> -	raw_local_irq_enable();
>   	__arch_cpu_idle(); /* idle instruction needs irq enabled */
>   	raw_local_irq_disable();
>   }


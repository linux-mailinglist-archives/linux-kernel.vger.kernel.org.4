Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8296EE2E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjDYNZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjDYNZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:25:30 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD89A273D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:25:28 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8CxvOrH1Edk0ocAAA--.845S3;
        Tue, 25 Apr 2023 21:25:27 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxwOTG1Edkg746AA--.43146S3;
        Tue, 25 Apr 2023 21:25:26 +0800 (CST)
Message-ID: <5ba79220-683f-a78a-8c3b-bc0b118226f8@loongson.cn>
Date:   Tue, 25 Apr 2023 21:25:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Loongson (and other $ARCHs?) idle VS timer enqueue
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
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
 <20230425114937.GC1335080@hirez.programming.kicks-ass.net>
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <20230425114937.GC1335080@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxwOTG1Edkg746AA--.43146S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxJF45KF4DXryDtrWrtry5urg_yoW5ArWrp3
        4Uuan8KF4ktr95W3sxJa1q9r98C34DKr4a9an8GryxJF48Gr1rXw1kt3sIga4Sg3y8Gw40
        vF1rXFWI93W7AaUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bq8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCa
        FVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUc9a9UUUUU
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/25 19:49, Peter Zijlstra 写道:
> On Sun, Apr 23, 2023 at 09:52:49PM +0800, bibo, mao wrote:
> 
>>> @@ -40,6 +40,7 @@ SYM_FUNC_START(handle_vint)
>>>   	ori	t0, t0, 0x1f
>>>   	xori	t0, t0, 0x1f
>>>   	bne	t0, t1, 1f
>>> +	addi.d	t0, t0, 0x20
>> It is more reasonable with this patch, this will jump out of idle function
>> directly after interrupt returns. If so, can we remove checking
>> _TIF_NEED_RESCHED in idle ASM function?
>>
>>> +	move	t0, CSR_CRMD_IE
>>> +	csrxchg	t0, t0, LOONGARCH_CSR_CRMD
>> -   	LONG_L	t0, tp, TI_FLAGS
>> +	nop
>>>   	nop
>> -	andi	t0, t0, _TIF_NEED_RESCHED
>> -	bnez	t0, 1f
>> +	nop
>> +	nop
>>>   	nop
>>> -	nop
>>> -	nop
>>>   	idle	0
> 
> Would not something like the below be a more compact form?
> That is; afaict there is no reason to keep it 32 bytes, we can easily go
> 16 and drop 4 nops.
> 
> Additionally, instead of truncating to the start, increase to the end by
> doing:
> 
> 	ip |= 0xf;
> 	ip++;
> 
> Also; I added a wee comment.
Excellent, you are so smart, I test the patch, it works.

> 
> 
> diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
> index 44ff1ff64260..3c8a6bab98fe 100644
> --- a/arch/loongarch/kernel/genex.S
> +++ b/arch/loongarch/kernel/genex.S
> @@ -18,27 +18,31 @@
>  
>  	.align	5
>  SYM_FUNC_START(__arch_cpu_idle)
> -	/* start of rollback region */
> -	LONG_L	t0, tp, TI_FLAGS
> -	nop
> -	andi	t0, t0, _TIF_NEED_RESCHED
> -	bnez	t0, 1f
> -	nop
> -	nop
> -	nop
> +	/* start of idle interrupt region */
> +	move	t0, CSR_CRMD_IE
addi.d  t0, zero, CSR_CRMD_IE can be used here, move is used for reg to reg

> +	csrxchg	t0, t0, LOONGARCH_CSR_CRMD
> +	/*
> +	 * If an interrupt lands here; between enabling interrupts above and
> +	 * going idle on the next instruction, we must *NOT* go idle since the
> +	 * interrupt could have set TIF_NEED_RESCHED or caused an timer to need
> +	 * reprogramming. Fall through -- see handle_vint() below -- and have
> +	 * the idle loop take care of things.
> +	 */
>  	idle	0
> -	/* end of rollback region */
> -1:	jr	ra
> +	nop
> +	/* end of idle interrupt region */
> +SYM_INNER_LBEL(__arch_cpu_idle_exit, SYM_L_LOCAL)
typo SYM_INNER_LABEL

otherwise LGTM

Tested-by: Bibo, Mao <maobibo@loongson.cn>

> +	jr	ra
>  SYM_FUNC_END(__arch_cpu_idle)
>  
>  SYM_FUNC_START(handle_vint)
>  	BACKUP_T0T1
>  	SAVE_ALL
> -	la_abs	t1, __arch_cpu_idle
> +	la_abs	t1, __arch_cpu_idle_exit
>  	LONG_L	t0, sp, PT_ERA
> -	/* 32 byte rollback region */
> -	ori	t0, t0, 0x1f
> -	xori	t0, t0, 0x1f
> +	/* 16 byte idle interrupt region */
> +	ori	t0, t0, 0x0f
> +	addi.d	t0, t0, 1
>  	bne	t0, t1, 1f
>  	LONG_S	t0, sp, PT_ERA
>  1:	move	a0, sp
> diff --git a/arch/loongarch/kernel/idle.c b/arch/loongarch/kernel/idle.c
> index 0b5dd2faeb90..5ba72d229920 100644
> --- a/arch/loongarch/kernel/idle.c
> +++ b/arch/loongarch/kernel/idle.c
> @@ -11,7 +11,6 @@
>  
>  void __cpuidle arch_cpu_idle(void)
>  {
> -	raw_local_irq_enable();
>  	__arch_cpu_idle(); /* idle instruction needs irq enabled */
>  	raw_local_irq_disable();
>  }


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E2E656797
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 07:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiL0Gnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 01:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiL0Gnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 01:43:45 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 802AF62FF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 22:43:38 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxjusYlKpjA8wIAA--.19816S3;
        Tue, 27 Dec 2022 14:43:36 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxIL8XlKpjScANAA--.44756S3;
        Tue, 27 Dec 2022 14:43:36 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Fix irq enable in exception handlers
To:     Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
References: <20221221074238.6699-1-hejinyang@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <c6477e2e-2950-ac27-97c9-38fb0c089c80@loongson.cn>
Date:   Tue, 27 Dec 2022 14:43:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20221221074238.6699-1-hejinyang@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxIL8XlKpjScANAA--.44756S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxGFy7GF4xJr1DKFW3GFy3Arb_yoWrZw15pF
        W7CFs5KFW8ZFn7Xa9rJ340vFy5X392qa1xC3yvka93Wan0yr95Wr1vqFW7XFyjv34Dur40
        vry0y3Z2q3WUJFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUUU
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/21/2022 03:42 PM, Jinyang He wrote:
> The interrupt state can be got by regs->csr_prmd. Once previous
> interrupt state is disable, we shouldn't enable interrupt if we
> triggered exception which can be triggered in kernel mode. So
> conditionally enable interrupt. For those do_\exception which
> can not triggered in kernel mode but need enable interrupt, call
> die_if_kernel() firstly. And for do_lsx, do_lasx and do_lbt cannot
> triggered in kernel mode, too.
>
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> ---
>  arch/loongarch/kernel/traps.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> index 1ea14f6c18d3..3ac7b32d1e15 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -340,9 +340,9 @@ asmlinkage void noinstr do_fpe(struct pt_regs *regs, unsigned long fcsr)
>
>  	/* Clear FCSR.Cause before enabling interrupts */
>  	write_fcsr(LOONGARCH_FCSR0, fcsr & ~mask_fcsr_x(fcsr));
> -	local_irq_enable();
>
>  	die_if_kernel("FP exception in kernel code", regs);
> +	local_irq_enable();
>
>  	sig = SIGFPE;
>  	fault_addr = (void __user *) regs->csr_era;
> @@ -432,7 +432,8 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
>  	unsigned long era = exception_era(regs);
>  	irqentry_state_t state = irqentry_enter(regs);
>
> -	local_irq_enable();
> +	if (regs->csr_prmd & CSR_PRMD_PIE)
> +		local_irq_enable();
>  	current->thread.trap_nr = read_csr_excode();
>  	if (__get_inst(&opcode, (u32 *)era, user))
>  		goto out_sigsegv;
> @@ -514,7 +515,8 @@ asmlinkage void noinstr do_ri(struct pt_regs *regs)
>  	unsigned int __user *era = (unsigned int __user *)exception_era(regs);
>  	irqentry_state_t state = irqentry_enter(regs);
>
> -	local_irq_enable();
> +	if (regs->csr_prmd & CSR_PRMD_PIE)
> +		local_irq_enable();
>  	current->thread.trap_nr = read_csr_excode();
>
>  	if (notify_die(DIE_RI, "RI Fault", regs, 0, current->thread.trap_nr,
> @@ -606,8 +608,8 @@ asmlinkage void noinstr do_fpu(struct pt_regs *regs)
>  {
>  	irqentry_state_t state = irqentry_enter(regs);
>
> -	local_irq_enable();
>  	die_if_kernel("do_fpu invoked from kernel context!", regs);
> +	local_irq_enable();
>  	BUG_ON(is_lsx_enabled());
>  	BUG_ON(is_lasx_enabled());
>
> @@ -623,13 +625,13 @@ asmlinkage void noinstr do_lsx(struct pt_regs *regs)
>  {
>  	irqentry_state_t state = irqentry_enter(regs);
>
> +	die_if_kernel("do_lsx invoked from kernel context!", regs);
>  	local_irq_enable();
>  	if (!cpu_has_lsx) {
>  		force_sig(SIGILL);
>  		goto out;
>  	}
>
> -	die_if_kernel("do_lsx invoked from kernel context!", regs);
>  	BUG_ON(is_lasx_enabled());
>
>  	preempt_disable();
> @@ -645,14 +647,13 @@ asmlinkage void noinstr do_lasx(struct pt_regs *regs)
>  {
>  	irqentry_state_t state = irqentry_enter(regs);
>
> +	die_if_kernel("do_lasx invoked from kernel context!", regs);
>  	local_irq_enable();
>  	if (!cpu_has_lasx) {
>  		force_sig(SIGILL);
>  		goto out;
>  	}
>
> -	die_if_kernel("do_lasx invoked from kernel context!", regs);
> -
>  	preempt_disable();
>  	init_restore_lasx();
>  	preempt_enable();
> @@ -666,6 +667,7 @@ asmlinkage void noinstr do_lbt(struct pt_regs *regs)
>  {
>  	irqentry_state_t state = irqentry_enter(regs);
>
> +	die_if_kernel("do_lbt invoked from kernel context!", regs);
>  	local_irq_enable();
>  	force_sig(SIGILL);
>  	local_irq_disable();
> @@ -677,7 +679,6 @@ asmlinkage void noinstr do_reserved(struct pt_regs *regs)
>  {
>  	irqentry_state_t state = irqentry_enter(regs);
>
> -	local_irq_enable();
>  	/*
>  	 * Game over - no way to handle this if it ever occurs.	Most probably
>  	 * caused by a fatal error after another hardware/software error.
> @@ -685,8 +686,8 @@ asmlinkage void noinstr do_reserved(struct pt_regs *regs)
>  	pr_err("Caught reserved exception %u on pid:%d [%s] - should not happen\n",
>  		read_csr_excode(), current->pid, current->comm);
>  	die_if_kernel("do_reserved exception", regs);
> +	local_irq_enable();
>  	force_sig(SIGUNUSED);
> -
>  	local_irq_disable();
>
>  	irqentry_exit(regs, state);
>

With this patch, the kprobe hang problem can be fixed, it is better
to merge this patch before the kprobe patches, or I can put it as
the first patch when submit the new kprobe series.

Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thanks,
Tiezhu


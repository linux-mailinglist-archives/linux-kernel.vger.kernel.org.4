Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E792E5BF8FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiIUIWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiIUIWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:22:43 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CFA74D27B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:22:41 -0700 (PDT)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx5OHPySpj9lIfAA--.51833S3;
        Wed, 21 Sep 2022 16:22:40 +0800 (CST)
Subject: Re: [PATCH 2/4] LoongArch: Add kretprobe support
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <1663645034-967-1-git-send-email-yangtiezhu@loongson.cn>
 <1663645034-967-3-git-send-email-yangtiezhu@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <27e77068-012b-ef7d-986f-818c651ba853@loongson.cn>
Date:   Wed, 21 Sep 2022 16:22:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1663645034-967-3-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Bx5OHPySpj9lIfAA--.51833S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4Dtw4UKr1rJr4kAFWkJFb_yoW5Ar45pF
        yDAF9xGr4rWr97Zr9xJ345ZF1S9rs7u3y7Wr17JFyrCF98X34UJr1xXrZFvFWrGrZ0vr1F
        qF4FqFyjkFW7J37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaUUUUU
        U==
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/2022 11:37 AM, Tiezhu Yang wrote:

> Use the generic kretprobe trampoline handler to add kretprobe
> support for LoongArch.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/loongarch/Kconfig          |  1 +
>   arch/loongarch/kernel/kprobes.c | 49 ++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 6b01073..5f8503a 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -95,6 +95,7 @@ config LOONGARCH
>   	select HAVE_IRQ_EXIT_ON_IRQ_STACK
>   	select HAVE_IRQ_TIME_ACCOUNTING
>   	select HAVE_KPROBES
> +	select HAVE_KRETPROBES
>   	select HAVE_MOD_ARCH_SPECIFIC
>   	select HAVE_NMI
>   	select HAVE_PCI
> diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kprobes.c
> index b2c73a5..8c3efe5 100644
> --- a/arch/loongarch/kernel/kprobes.c
> +++ b/arch/loongarch/kernel/kprobes.c
> @@ -303,7 +303,54 @@ int kprobe_exceptions_notify(struct notifier_block *self,
>   }
>   NOKPROBE_SYMBOL(kprobe_exceptions_notify);
>   
> +/*
> + * For function-return probes, init_kprobes() establishes a probepoint
> + * here. When a retprobed function returns, this probe is hit and
> + * trampoline_probe_handler() runs, calling the kretprobe's handler.
> + */
> +static void __used kretprobe_trampoline_holder(void)
> +{
> +	asm volatile(".global __kretprobe_trampoline\n"
> +		     "__kretprobe_trampoline:\n"
> +		     "nop\n");
> +}
> +
> +/* Called when the probe at kretprobe trampoline is hit */
> +static int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
> +{
> +	instruction_pointer(regs) = __kretprobe_trampoline_handler(regs, NULL);
> +	/*
> +	 * By returning a non-zero value, we are telling
> +	 * kprobe_handler() that we don't want the post_handler
> +	 * to run (and have re-enabled preemption)
> +	 */
> +	return 1;
> +}
> +NOKPROBE_SYMBOL(trampoline_probe_handler);
> +
> +static struct kprobe trampoline_p = {
> +	.addr = (kprobe_opcode_t *)__kretprobe_trampoline,
> +	.pre_handler = trampoline_probe_handler
> +};
> +
> +void arch_prepare_kretprobe(struct kretprobe_instance *ri,
> +			    struct pt_regs *regs)
> +{
> +	ri->ret_addr = (kprobe_opcode_t *)regs->regs[1];
> +	ri->fp = NULL;
> +
> +	/* Replace the return addr with trampoline addr */
> +	regs->regs[1] = (unsigned long)__kretprobe_trampoline;
> +}
> +NOKPROBE_SYMBOL(arch_prepare_kretprobe);
> +
> +int arch_trampoline_kprobe(struct kprobe *p)
> +{
> +	return p->addr == trampoline_p.addr;
> +}
> +NOKPROBE_SYMBOL(arch_trampoline_kprobe);
> +
>   int __init arch_init_kprobes(void)
>   {
> -	return 0;
> +	return register_kprobe(&trampoline_p);
Hi, Tiezhu,

For kretprobe, we can do things like arm64/riscv... did. It avoid
the break exception when function return.

Thanks,
Jinyang
>   }


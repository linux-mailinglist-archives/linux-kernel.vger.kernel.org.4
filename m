Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D7672DBF9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbjFMIEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240817AbjFMIE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:04:28 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EE2210EA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:04:25 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cx+ekHI4hkzIMEAA--.9645S3;
        Tue, 13 Jun 2023 16:04:23 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxVeQFI4hkN60YAA--.5284S3;
        Tue, 13 Jun 2023 16:04:22 +0800 (CST)
Subject: Re: [PATCH v3] LoongArch/rethook: Replace kretprobe with rethook on
 LoongArch
To:     Haoran Jiang <jianghaoran@kylinos.cn>
References: <20230613011439.59168-1-jianghaoran@kylinos.cn>
 <20230613060329.356201-1-jianghaoran@kylinos.cn>
Cc:     chenhuacai@kernel.org, conor.dooley@microchip.com,
        hejinyang@loongson.cn, jhrhhao@163.com, kernel@xen0n.name,
        l3b2w1@gmail.com, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, masahiroy@kernel.org,
        mhiramat@kernel.org, palmer@rivosinc.com, tangyouling@loongson.cn,
        zhangqing@loongson.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <8ffd58dd-2e0c-0078-5e3f-a1139f05720b@loongson.cn>
Date:   Tue, 13 Jun 2023 16:04:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230613060329.356201-1-jianghaoran@kylinos.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxVeQFI4hkN60YAA--.5284S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxur1rArW8tr45uF1rCF4rJFc_yoW5CFWxpF
        9rArn5Cr4Uur1qvryDAw1rZF40vrn3ua17WF1DG34fCF90qrZ8JryxXrWqvFWrKwnYvr4F
        qF4FqryqyFZrJ3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUU
        UU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/13/2023 02:03 PM, Haoran Jiang wrote:
> That's an adaptation of commit f3a112c0c40d ("x86,rethook,kprobes:
> Replace kretprobe with rethook on x86")and commit b57c2f124098
> ("riscv: add riscv rethook implementation") to LoongArch.
> Mainly refer to this commit
> b57c2f124098 ("riscv: add riscv rethook implementation").
>
> Replaces the kretprobe code with rethook on LoongArch. With this patch,
> kretprobe on LoongArch uses the rethook instead of kretprobe specific
> trampoline code.

Maybe Huacai can refine the commit message.

>
> Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>

...

> diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kprobes.c
> index 56c8c4b09a42..dbce23ba9970 100644
> --- a/arch/loongarch/kernel/kprobes.c
> +++ b/arch/loongarch/kernel/kprobes.c
> @@ -378,26 +378,6 @@ int __init arch_init_kprobes(void)
>  	return 0;
>  }
>
> -/* ASM function that handles the kretprobes must not be probed */
> -NOKPROBE_SYMBOL(__kretprobe_trampoline);
> -
> -/* Called from __kretprobe_trampoline */
> -void __used *trampoline_probe_handler(struct pt_regs *regs)
> -{
> -	return (void *)kretprobe_trampoline_handler(regs, NULL);
> -}
> -NOKPROBE_SYMBOL(trampoline_probe_handler);
> -
> -void arch_prepare_kretprobe(struct kretprobe_instance *ri,
> -			    struct pt_regs *regs)
> -{
> -	ri->ret_addr = (kprobe_opcode_t *)regs->regs[1];
> -	ri->fp = NULL;
> -
> -	/* Replace the return addr with trampoline addr */
> -	regs->regs[1] = (unsigned long)&__kretprobe_trampoline;
> -}
> -NOKPROBE_SYMBOL(arch_prepare_kretprobe);
>

Please remove the blank line.

>  int arch_trampoline_kprobe(struct kprobe *p)
>  {
> diff --git a/arch/loongarch/kernel/rethook.c b/arch/loongarch/kernel/rethook.c
> new file mode 100644
> index 000000000000..b5e7f62f7dea
> --- /dev/null
> +++ b/arch/loongarch/kernel/rethook.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic return hook for LoongArch.
> + */
> +
> +#include <linux/kprobes.h>
> +#include <linux/rethook.h>
> +#include "rethook.h"
> +
> +/* This is called from arch_rethook_trampoline() */
> +unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
> +{
> +	return rethook_trampoline_handler(regs, 0);
> +}
> +

Ditto

> +NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
> +
> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
> +{
> +	rhn->ret_addr = regs->regs[1];
> +	rhn->frame = 0;
> +
> +	/* replace return addr with trampoline */
> +	regs->regs[1] = (unsigned long)arch_rethook_trampoline;
> +}
> +

Ditto

> +NOKPROBE_SYMBOL(arch_rethook_prepare);

Like s390 and x86, please add:

/* assembler function that handles the rethook must not be probed itself */
NOKPROBE_SYMBOL(arch_rethook_trampoline);

> diff --git a/arch/loongarch/kernel/rethook.h b/arch/loongarch/kernel/rethook.h

...

> -SYM_CODE_END(__kretprobe_trampoline)
> +SYM_CODE_END(arch_rethook_trampoline)

Thanks,
Tiezhu


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1CC72B8F3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbjFLHoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbjFLHoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:44:12 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9EBD10E9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:43:33 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cxd+mryIZkOIgDAA--.5737S3;
        Mon, 12 Jun 2023 15:26:35 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxZuSnyIZkmzkVAA--.61198S3;
        Mon, 12 Jun 2023 15:26:32 +0800 (CST)
Subject: Re: [PATCH] LoongArch/rethook: Replace kretprobe with rethook on
 loongarch
To:     jianghaoran <jianghaoran@kylinos.cn>, chenhuacai@kernel.org
References: <20230612054949.305652-1-jianghaoran@kylinos.cn>
Cc:     kernel@xen0n.name, zhangqing@loongson.cn, hejinyang@loongson.cn,
        tangyouling@loongson.cn, masahiroy@kernel.org,
        conor.dooley@microchip.com, l3b2w1@gmail.com, palmer@rivosinc.com,
        mhiramat@kernel.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, jhrhhao <jhrhhao@163.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <63c16a5a-ea60-6607-a4ff-23ad9d47cd73@loongson.cn>
Date:   Mon, 12 Jun 2023 15:26:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230612054949.305652-1-jianghaoran@kylinos.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxZuSnyIZkmzkVAA--.61198S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw4UXw13KFWkAr4UXw4kKrX_yoW5Ar18pF
        9xArn8Gr4rCr9rAF9xJ3yrXF4Fvrn3Cw42gFnxt348Ca4Fvr1kJr1IgrZIvFWrK3sYvr1S
        qF4FgryDtFy7J3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUU
        UU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2023 01:49 PM, jianghaoran wrote:
> That's an adaptation of commit f3a112c0c40d ("x86,rethook,kprobes:
> Replace kretprobe with rethook on x86") to loongarch.
>
> Replaces the kretprobe code with rethook on loongarch. With this patch,
> kretprobe on loongarch uses the rethook instead of kretprobe specific
> trampoline code.
>
> Signed-off-by: jianghaoran<jianghaoran@kylinos.cn>
> Signed-off-by: jhrhhao<jhrhhao@163.com>

Please check Signed-off-by's "<first> <last> <email>" order
and spelling. Should it be "Haoran Jiang <jianghaoran@kylinos.cn>"?
Please refer the following link:
https://lore.kernel.org/all/CAEf4BzYS5mj+0ZBA2HKW3=kB1cjZ3wdiJZ2OP9gSLE4e7WB_wQ@mail.gmail.com/

> ---
>  arch/loongarch/Kconfig                        |  1 +
>  arch/loongarch/include/asm/kprobes.h          |  3 ---
>  arch/loongarch/kernel/Makefile                |  3 ++-
>  arch/loongarch/kernel/kprobes.c               | 20 --------------
>  arch/loongarch/kernel/rethook.c               | 27 +++++++++++++++++++
>  arch/loongarch/kernel/rethook.h               |  9 +++++++
>  ...obes_trampoline.S => rethook_trampoline.S} |  6 ++---
>  7 files changed, 42 insertions(+), 27 deletions(-)
>  create mode 100644 arch/loongarch/kernel/rethook.c
>  create mode 100644 arch/loongarch/kernel/rethook.h
>  rename arch/loongarch/kernel/{kprobes_trampoline.S => rethook_trampoline.S} (93%)

...

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

When git am this patch, there exists the following warning:

Applying: LoongArch/rethook: Replace kretprobe with rethook on loongarch
.git/rebase-apply/patch:131: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

So please remove the blank line.

>  int arch_trampoline_kprobe(struct kprobe *p)

...

> -SYM_CODE_END(__kretprobe_trampoline)
> +SYM_CODE_END(arch_rethook_trampoline)

This patch is almost same with commit b57c2f124098 ("riscv: add
riscv rethook implementation"), it is better to provide this info
in the commit message.

The code itself looks good to me, I am doing the test.

Thanks,
Tiezhu


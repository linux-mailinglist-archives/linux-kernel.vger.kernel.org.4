Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD8667F427
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 03:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjA1Czk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 21:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjA1Czj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 21:55:39 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D389B1717C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 18:55:37 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4P3fCR0dt0z16Mn6;
        Sat, 28 Jan 2023 10:53:39 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 28 Jan 2023 10:55:35 +0800
Message-ID: <0871074a-cafb-a172-f062-6ada6d2a3a41@huawei.com>
Date:   Sat, 28 Jan 2023 10:55:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] riscv: kprobe: Fixup kernel panic when probing an illegal
 position
To:     <guoren@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <mhiramat@kernel.org>,
        <conor.dooley@microchip.com>, <penberg@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
References: <20230126130509.1418251-1-guoren@kernel.org>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <20230126130509.1418251-1-guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/26 21:05, guoren@kernel.org 写道:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The kernel would panic when probed for an illegal position. eg:
> 
> (CONFIG_RISCV_ISA_C=n)
> 
> echo 'p:hello kernel_clone+0x16 a0=%a0' >> kprobe_events
> echo 1 > events/kprobes/hello/enable
> cat trace
> 
> Kernel panic - not syncing: stack-protector: Kernel stack
> is corrupted in: __do_sys_newfstatat+0xb8/0xb8
> CPU: 0 PID: 111 Comm: sh Not tainted
> 6.2.0-rc1-00027-g2d398fe49a4d #490
> Hardware name: riscv-virtio,qemu (DT)
> Call Trace:
> [<ffffffff80007268>] dump_backtrace+0x38/0x48
> [<ffffffff80c5e83c>] show_stack+0x50/0x68
> [<ffffffff80c6da28>] dump_stack_lvl+0x60/0x84
> [<ffffffff80c6da6c>] dump_stack+0x20/0x30
> [<ffffffff80c5ecf4>] panic+0x160/0x374
> [<ffffffff80c6db94>] generic_handle_arch_irq+0x0/0xa8
> [<ffffffff802deeb0>] sys_newstat+0x0/0x30
> [<ffffffff800158c0>] sys_clone+0x20/0x30
> [<ffffffff800039e8>] ret_from_syscall+0x0/0x4
> ---[ end Kernel panic - not syncing: stack-protector:
> Kernel stack is corrupted in: __do_sys_newfstatat+0xb8/0xb8 ]---
> 
> That is because the kprobe's ebreak instruction broke the kernel's
> original code. The user should guarantee the correction of the probe
> position, but it couldn't make the kernel panic.
> 
> This patch adds arch_check_kprobe in arch_prepare_kprobe to prevent an
> illegal position (Such as the middle of an instruction).
> 
> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/kernel/probes/kprobes.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> index f21592d20306..475989f06d6d 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -48,6 +48,21 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
>  	post_kprobe_handler(p, kcb, regs);
>  }
>  
> +static bool __kprobes arch_check_kprobe(struct kprobe *p)
> +{
> +	unsigned long tmp  = (unsigned long)p->addr - p->offset;
> +	unsigned long addr = (unsigned long)p->addr;
> +
> +	while (tmp <= addr) {
> +		if (tmp == addr)
> +			return true;
> +
> +		tmp += GET_INSN_LENGTH(*(kprobe_opcode_t *)tmp);
> +	}
> +
> +	return false;
> +}

LGTM.

I have submit a patch to fix the same problem, found at:

https://lore.kernel.org/lkml/20230127130541.1250865-11-chenguokai17@mails.ucas.ac.cn/

So this boundary check is necessary no matter CONFIG_RISCV_ISA_C is enable or not, right?


> +
>  int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  {
>  	unsigned long probe_addr = (unsigned long)p->addr;
> @@ -55,6 +70,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  	if (probe_addr & 0x1)
>  		return -EILSEQ;
>  
> +	if (!arch_check_kprobe(p))
> +		return -EILSEQ;
> +
>  	/* copy instruction */
>  	p->opcode = *p->addr;
>  

-- 
BR,
Liao, Chang

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AF167F472
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 04:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjA1DxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 22:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjA1DxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 22:53:03 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D92359E7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 19:53:01 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P3gTZ6nlFznVxm;
        Sat, 28 Jan 2023 11:50:58 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 28 Jan 2023 11:52:55 +0800
Message-ID: <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
Date:   Sat, 28 Jan 2023 11:52:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   "liaochang (A)" <liaochang1@huawei.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
To:     <guoren@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <mhiramat@kernel.org>,
        <conor.dooley@microchip.com>, <penberg@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
References: <20230126161559.1467374-1-guoren@kernel.org>
In-Reply-To: <20230126161559.1467374-1-guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Hi, Guo Ren

在 2023/1/27 0:15, guoren@kernel.org 写道:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The previous implementation was based on the stop_matchine mechanism,
> which reduced the speed of arm/disarm_kprobe. Using minimum ebreak
> instruction would get accurate atomicity.
> 
> This patch removes the patch_text of riscv, which is based on
> stop_machine. Then riscv only reserved patch_text_nosync, and developers
> need to be more careful in dealing with patch_text atomicity.

In the serie of RISCV OPTPROBES [1], it patches a long-jump instructions pair
AUIPC/JALR in kernel text, so in order to ensure other CPUs does not execute
in the instructions that will be modified, it is still need to stop other CPUs
via patch_text API, or you have any better solution to achieve the purpose?

Thanks.

> 
> When CONFIG_RISCV_ISA_C=n, the ebreak could replace the whole
> instruction. When CONFIG_RISCV_ISA_C=y, the patch uses 16-bit length
> c.ebreak instruction, which may occupy the first part of the 32-bit
> instruction and leave half the rest of the broken instruction. Because
> ebreak could detour the flow to skip it, leaving it in the kernel text
> memory is okay.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/patch.h     |  1 -
>  arch/riscv/kernel/patch.c          | 33 ------------------------------
>  arch/riscv/kernel/probes/kprobes.c | 29 ++++++++++++++++++--------
>  3 files changed, 21 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
> index 9a7d7346001e..2500782e6f5b 100644
> --- a/arch/riscv/include/asm/patch.h
> +++ b/arch/riscv/include/asm/patch.h
> @@ -7,6 +7,5 @@
>  #define _ASM_RISCV_PATCH_H
>  
>  int patch_text_nosync(void *addr, const void *insns, size_t len);
> -int patch_text(void *addr, u32 insn);
>  
>  #endif /* _ASM_RISCV_PATCH_H */
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 765004b60513..8bd51ed8b806 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -98,36 +98,3 @@ int patch_text_nosync(void *addr, const void *insns, size_t len)
>  	return ret;
>  }
>  NOKPROBE_SYMBOL(patch_text_nosync);
> -
> -static int patch_text_cb(void *data)
> -{
> -	struct patch_insn *patch = data;
> -	int ret = 0;
> -
> -	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
> -		ret =
> -		    patch_text_nosync(patch->addr, &patch->insn,
> -					    GET_INSN_LENGTH(patch->insn));
> -		atomic_inc(&patch->cpu_count);
> -	} else {
> -		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
> -			cpu_relax();
> -		smp_mb();
> -	}
> -
> -	return ret;
> -}
> -NOKPROBE_SYMBOL(patch_text_cb);
> -
> -int patch_text(void *addr, u32 insn)
> -{
> -	struct patch_insn patch = {
> -		.addr = addr,
> -		.insn = insn,
> -		.cpu_count = ATOMIC_INIT(0),
> -	};
> -
> -	return stop_machine_cpuslocked(patch_text_cb,
> -				       &patch, cpu_online_mask);
> -}
> -NOKPROBE_SYMBOL(patch_text);
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> index 475989f06d6d..27f8960c321c 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -24,12 +24,18 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
>  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>  {
>  	unsigned long offset = GET_INSN_LENGTH(p->opcode);
> +#ifdef CONFIG_RISCV_ISA_C
> +	u32 opcode = __BUG_INSN_16;
> +#else
> +	u32 opcode = __BUG_INSN_32;
> +#endif
>  
>  	p->ainsn.api.restore = (unsigned long)p->addr + offset;
>  
> -	patch_text(p->ainsn.api.insn, p->opcode);
> -	patch_text((void *)((unsigned long)(p->ainsn.api.insn) + offset),
> -		   __BUG_INSN_32);
> +	patch_text_nosync(p->ainsn.api.insn, &p->opcode, offset);
> +	patch_text_nosync((void *)((unsigned long)(p->ainsn.api.insn) + offset),
> +			  &opcode, GET_INSN_LENGTH(opcode));
> +

I have submit a similar optimization for patching single-step slot [2].
And it is indeed safe to use compact breakpoint in single-step slot no matter
what type of patched instruction is.

Thanks.

>  }
>  
>  static void __kprobes arch_prepare_simulate(struct kprobe *p)
> @@ -114,16 +120,23 @@ void *alloc_insn_page(void)
>  /* install breakpoint in text */
>  void __kprobes arch_arm_kprobe(struct kprobe *p)
>  {
> -	if ((p->opcode & __INSN_LENGTH_MASK) == __INSN_LENGTH_32)
> -		patch_text(p->addr, __BUG_INSN_32);
> -	else
> -		patch_text(p->addr, __BUG_INSN_16);
> +#ifdef CONFIG_RISCV_ISA_C
> +	u32 opcode = __BUG_INSN_16;
> +#else
> +	u32 opcode = __BUG_INSN_32;
> +#endif
> +	patch_text_nosync(p->addr, &opcode, GET_INSN_LENGTH(opcode));

Sounds good, but it will leave some RVI instruction truncated in kernel text,
i doubt kernel behavior depends on the rest of the truncated instruction, well,
it needs more strict testing to prove my concern :)

>  }
>  
>  /* remove breakpoint from text */
>  void __kprobes arch_disarm_kprobe(struct kprobe *p)
>  {
> -	patch_text(p->addr, p->opcode);
> +#ifdef CONFIG_RISCV_ISA_C
> +	u32 opcode = __BUG_INSN_16;
> +#else
> +	u32 opcode = __BUG_INSN_32;
> +#endif
> +	patch_text_nosync(p->addr, &p->opcode, GET_INSN_LENGTH(opcode));
>  }
>  
>  void __kprobes arch_remove_kprobe(struct kprobe *p)

[1] - https://lore.kernel.org/lkml/20230127130541.1250865-9-chenguokai17@mails.ucas.ac.cn/
[2] - https://lore.kernel.org/lkml/20220927022435.129965-1-liaochang1@huawei.com/T/

-- 
BR,
Liao, Chang

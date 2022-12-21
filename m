Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1A5652D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 08:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLUHmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 02:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUHmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 02:42:17 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FA386555
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 23:42:14 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8BxGenUuKJjdIgHAA--.13592S3;
        Wed, 21 Dec 2022 15:42:12 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxHuTRuKJjwk0GAA--.24091S3;
        Wed, 21 Dec 2022 15:42:11 +0800 (CST)
Subject: Re: [PATCH v10 1/4] LoongArch: Simulate branch and PC instructions
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1670575981-14389-1-git-send-email-yangtiezhu@loongson.cn>
 <1670575981-14389-2-git-send-email-yangtiezhu@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <954b71af-f70b-16cc-19a1-c17331ef1ebb@loongson.cn>
Date:   Wed, 21 Dec 2022 15:42:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1670575981-14389-2-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxHuTRuKJjwk0GAA--.24091S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3JrWrWrW3Kw4xGr4fWryfWFg_yoWxXrWxpr
        ZrZr4kGr4DuryxurWjqw1kuw15trs5ur43uwnxC343CFy5ZFy8GrykGw1jvF9Yyw48Jr10
        9a1aqw12yFsIyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUUU
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-09 16:52, Tiezhu Yang wrote:

> According to LoongArch Reference Manual, simulate branch and
> PC instructions, this is preparation for later patch.
>
> Link: https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#branch-instructions
> Link: https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#_pcaddi_pcaddu121_pcaddu18l_pcalau12i
>
> Co-developed-by: Jinyang He <hejinyang@loongson.cn>
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/loongarch/include/asm/inst.h   |   5 ++
>   arch/loongarch/include/asm/ptrace.h |   1 +
>   arch/loongarch/kernel/inst.c        | 123 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 129 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index c00e151..e25fd54 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -7,6 +7,7 @@
>   
>   #include <linux/types.h>
>   #include <asm/asm.h>
> +#include <asm/ptrace.h>
>   
>   #define INSN_NOP		0x03400000
>   #define INSN_BREAK		0x002a0000
> @@ -32,6 +33,7 @@ enum reg1i20_op {
>   	lu12iw_op	= 0x0a,
>   	lu32id_op	= 0x0b,
>   	pcaddi_op	= 0x0c,
> +	pcalau12i_op	= 0x0d,
>   	pcaddu12i_op	= 0x0e,
>   	pcaddu18i_op	= 0x0f,
>   };
> @@ -367,6 +369,9 @@ u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
>   u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
>   u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned long pc, unsigned long dest);
>   
> +void simu_branch(struct pt_regs *regs, union loongarch_instruction insn);
> +void simu_pc(struct pt_regs *regs, union loongarch_instruction insn);
> +
>   static inline bool signed_imm_check(long val, unsigned int bit)
>   {
>   	return -(1L << (bit - 1)) <= val && val < (1L << (bit - 1));
> diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
> index 59c4608..58596c4 100644
> --- a/arch/loongarch/include/asm/ptrace.h
> +++ b/arch/loongarch/include/asm/ptrace.h
> @@ -6,6 +6,7 @@
>   #define _ASM_PTRACE_H
>   
>   #include <asm/page.h>
> +#include <asm/irqflags.h>
>   #include <asm/thread_info.h>
>   #include <uapi/asm/ptrace.h>
>   
> diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
> index 512579d..af48faf 100644
> --- a/arch/loongarch/kernel/inst.c
> +++ b/arch/loongarch/kernel/inst.c
> @@ -165,3 +165,126 @@ u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned l
>   
>   	return insn.word;
>   }
> +
> +void simu_branch(struct pt_regs *regs, union loongarch_instruction insn)
> +{
> +	unsigned int imm, imm_l, imm_h, rd, rj;
> +	unsigned long pc = regs->csr_era;
> +
> +	if (pc & 3) {
> +		pr_warn("%s: invalid pc 0x%lx\n", __func__, pc);
> +		return;
> +	}
> +
> +	imm_l = insn.reg0i26_format.immediate_l;
> +	imm_h = insn.reg0i26_format.immediate_h;
> +	switch (insn.reg0i26_format.opcode) {
> +	case b_op:
> +		regs->csr_era = pc + sign_extend((imm_h << 16 | imm_l) << 2, 27);


Hi, Tiezhu,


We can use sign_extend64() in linux/bitops.h. Its assembly sequence

is slli.d+srai.d, which is more efficient and clear.


Jinyang


> +		return;
> +	case bl_op:
> +		regs->csr_era = pc + sign_extend((imm_h << 16 | imm_l) << 2, 27);
> +		regs->regs[1] = pc + LOONGARCH_INSN_SIZE;
> +		return;
> +	}
> +
> +	imm_l = insn.reg1i21_format.immediate_l;
> +	imm_h = insn.reg1i21_format.immediate_h;
> +	rj = insn.reg1i21_format.rj;
> +	switch (insn.reg1i21_format.opcode) {
> +	case beqz_op:
> +		if (regs->regs[rj] == 0)
> +			regs->csr_era = pc + sign_extend((imm_h << 16 | imm_l) << 2, 22);
> +		else
> +			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +		return;
> +	case bnez_op:
> +		if (regs->regs[rj] != 0)
> +			regs->csr_era = pc + sign_extend((imm_h << 16 | imm_l) << 2, 22);
> +		else
> +			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +		return;
> +	}
> +
> +	imm = insn.reg2i16_format.immediate;
> +	rj = insn.reg2i16_format.rj;
> +	rd = insn.reg2i16_format.rd;
> +	switch (insn.reg2i16_format.opcode) {
> +	case beq_op:
> +		if (regs->regs[rj] == regs->regs[rd])
> +			regs->csr_era = pc + sign_extend(imm << 2, 17);
> +		else
> +			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +		break;
> +	case bne_op:
> +		if (regs->regs[rj] != regs->regs[rd])
> +			regs->csr_era = pc + sign_extend(imm << 2, 17);
> +		else
> +			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +		break;
> +	case blt_op:
> +		if ((long)regs->regs[rj] < (long)regs->regs[rd])
> +			regs->csr_era = pc + sign_extend(imm << 2, 17);
> +		else
> +			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +		break;
> +	case bge_op:
> +		if ((long)regs->regs[rj] >= (long)regs->regs[rd])
> +			regs->csr_era = pc + sign_extend(imm << 2, 17);
> +		else
> +			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +		break;
> +	case bltu_op:
> +		if (regs->regs[rj] < regs->regs[rd])
> +			regs->csr_era = pc + sign_extend(imm << 2, 17);
> +		else
> +			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +		break;
> +	case bgeu_op:
> +		if (regs->regs[rj] >= regs->regs[rd])
> +			regs->csr_era = pc + sign_extend(imm << 2, 17);
> +		else
> +			regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +		break;
> +	case jirl_op:
> +		regs->csr_era = regs->regs[rj] + sign_extend(imm << 2, 17);
> +		regs->regs[rd] = pc + LOONGARCH_INSN_SIZE;
> +		break;
> +	default:
> +		pr_info("%s: unknown opcode\n", __func__);
> +		return;
> +	}
> +}
> +
> +void simu_pc(struct pt_regs *regs, union loongarch_instruction insn)
> +{
> +	unsigned long pc = regs->csr_era;
> +	unsigned int rd = insn.reg1i20_format.rd;
> +	unsigned int imm = insn.reg1i20_format.immediate;
> +
> +	if (pc & 3) {
> +		pr_warn("%s: invalid pc 0x%lx\n", __func__, pc);
> +		return;
> +	}
> +
> +	switch (insn.reg1i20_format.opcode) {
> +	case pcaddi_op:
> +		regs->regs[rd] = pc + sign_extend(imm << 2, 21);
> +		break;
> +	case pcaddu12i_op:
> +		regs->regs[rd] = pc + sign_extend(imm << 12, 31);
> +		break;
> +	case pcaddu18i_op:
> +		regs->regs[rd] = pc + sign_extend(imm << 18, 37);
> +		break;
> +	case pcalau12i_op:
> +		regs->regs[rd] = pc + sign_extend(imm << 12, 31);
> +		regs->regs[rd] &= ~((1 << 12) - 1);
> +		break;
> +	default:
> +		pr_info("%s: unknown opcode\n", __func__);
> +		return;
> +	}
> +
> +	regs->csr_era += LOONGARCH_INSN_SIZE;
> +}


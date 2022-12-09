Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3F4647BD9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 03:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiLICFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 21:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiLICFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 21:05:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A8FA1984
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 18:05:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23A9DB8264C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 02:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32F7C433F0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 02:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670551541;
        bh=034c5SNu0eN+TDcSr1lJwuT4M0I7LHpEvy7Re0uO4kM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L5/2/42L+J0mGJe9v7Sg+CPk3oLgSCJVra7+479VfTOnB2JTIpCXQ0Ow1DgberheH
         JGVfzW65vi7tmlB3M1QwbpwF3UagHnUNLgr1sOYsDAuSP0iY7mJiLeDSOZx0/+PrA9
         DZa1tx/CZyi1dGrpvdKg6vQaKogqKphg3qMO30hZL0jBj/FTO1hyMlw0e0YEfnBr47
         /+inXuxGh0yiLuYCpAT1LH0MX5EBjm7duyHVJDRIr1uITkFglop2E+Ll/uCuiQAx7G
         wzmGfesj9ihmbTRGwshh3u/GjIm+mlN1YfgdOH7rQJ7CeU9IxJUXJMzKU5Tcea8f8p
         atxRtpu/NCRTQ==
Received: by mail-ej1-f44.google.com with SMTP id b2so8273574eja.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 18:05:41 -0800 (PST)
X-Gm-Message-State: ANoB5pkohX1XKM2K9bcphCtYVwr05YdhCoH2qiUIiy3RfeabWgBIN5jY
        fgDJrWY/dJmLgCXvR6wccmb1OfdRVGzOA1rBkbw=
X-Google-Smtp-Source: AA0mqf4gMknRxQ0nMWyiNCNkPsOukZkqp4RNw9fVK/61cMeeUzmkgNvYLZLND3sOuMRTg+pfD//kSKggGjcL1G/6RZ8=
X-Received: by 2002:a17:906:f116:b0:7c1:764:5e08 with SMTP id
 gv22-20020a170906f11600b007c107645e08mr10164149ejb.72.1670551540112; Thu, 08
 Dec 2022 18:05:40 -0800 (PST)
MIME-Version: 1.0
References: <1670506868-15771-1-git-send-email-yangtiezhu@loongson.cn> <1670506868-15771-2-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1670506868-15771-2-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 9 Dec 2022 10:05:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H774S2+TxMtgxLA6VcSb0kPwqTmK_i8_K1rsqGyhvH-ZQ@mail.gmail.com>
Message-ID: <CAAhV-H774S2+TxMtgxLA6VcSb0kPwqTmK_i8_K1rsqGyhvH-ZQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] LoongArch: Simulate branch and PC instructions
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu,

On Thu, Dec 8, 2022 at 9:41 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
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
>  arch/loongarch/include/asm/inst.h   |  12 ++++
>  arch/loongarch/include/asm/ptrace.h |   1 +
>  arch/loongarch/kernel/inst.c        | 123 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 136 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index 6cd994d..19cf692 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -7,6 +7,7 @@
>
>  #include <linux/types.h>
>  #include <asm/asm.h>
> +#include <asm/ptrace.h>
>
>  #define INSN_NOP               0x03400000
>  #define INSN_BREAK             0x002a0000
> @@ -32,6 +33,7 @@ enum reg1i20_op {
>         lu12iw_op       = 0x0a,
>         lu32id_op       = 0x0b,
>         pcaddi_op       = 0x0c,
> +       pcalau12i_op    = 0x0d,
>         pcaddu12i_op    = 0x0e,
>         pcaddu18i_op    = 0x0f,
>  };
> @@ -366,6 +368,16 @@ u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int imm);
>  u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
>  u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
>  u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned long pc, unsigned long dest);
> +void simu_branch(struct pt_regs *regs, union loongarch_instruction insn);
> +void simu_pc(struct pt_regs *regs, union loongarch_instruction insn);
> +
> +static inline unsigned long sign_extend(unsigned long val, unsigned int idx)
> +{
> +       if (val & (1UL << idx))
> +               return ~((1UL << (idx + 1)) - 1) | val;
> +       else
> +               return ((1UL << (idx + 1)) - 1) & val;
> +}
I have rebased https://github.com/loongson/linux/commits/loongarch-next,
this function is already there.

Huacai
>
>  static inline bool signed_imm_check(long val, unsigned int bit)
>  {
> diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
> index 59c4608..58596c4 100644
> --- a/arch/loongarch/include/asm/ptrace.h
> +++ b/arch/loongarch/include/asm/ptrace.h
> @@ -6,6 +6,7 @@
>  #define _ASM_PTRACE_H
>
>  #include <asm/page.h>
> +#include <asm/irqflags.h>
>  #include <asm/thread_info.h>
>  #include <uapi/asm/ptrace.h>
>
> diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
> index 512579d..af48faf 100644
> --- a/arch/loongarch/kernel/inst.c
> +++ b/arch/loongarch/kernel/inst.c
> @@ -165,3 +165,126 @@ u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned l
>
>         return insn.word;
>  }
> +
> +void simu_branch(struct pt_regs *regs, union loongarch_instruction insn)
> +{
> +       unsigned int imm, imm_l, imm_h, rd, rj;
> +       unsigned long pc = regs->csr_era;
> +
> +       if (pc & 3) {
> +               pr_warn("%s: invalid pc 0x%lx\n", __func__, pc);
> +               return;
> +       }
> +
> +       imm_l = insn.reg0i26_format.immediate_l;
> +       imm_h = insn.reg0i26_format.immediate_h;
> +       switch (insn.reg0i26_format.opcode) {
> +       case b_op:
> +               regs->csr_era = pc + sign_extend((imm_h << 16 | imm_l) << 2, 27);
> +               return;
> +       case bl_op:
> +               regs->csr_era = pc + sign_extend((imm_h << 16 | imm_l) << 2, 27);
> +               regs->regs[1] = pc + LOONGARCH_INSN_SIZE;
> +               return;
> +       }
> +
> +       imm_l = insn.reg1i21_format.immediate_l;
> +       imm_h = insn.reg1i21_format.immediate_h;
> +       rj = insn.reg1i21_format.rj;
> +       switch (insn.reg1i21_format.opcode) {
> +       case beqz_op:
> +               if (regs->regs[rj] == 0)
> +                       regs->csr_era = pc + sign_extend((imm_h << 16 | imm_l) << 2, 22);
> +               else
> +                       regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +               return;
> +       case bnez_op:
> +               if (regs->regs[rj] != 0)
> +                       regs->csr_era = pc + sign_extend((imm_h << 16 | imm_l) << 2, 22);
> +               else
> +                       regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +               return;
> +       }
> +
> +       imm = insn.reg2i16_format.immediate;
> +       rj = insn.reg2i16_format.rj;
> +       rd = insn.reg2i16_format.rd;
> +       switch (insn.reg2i16_format.opcode) {
> +       case beq_op:
> +               if (regs->regs[rj] == regs->regs[rd])
> +                       regs->csr_era = pc + sign_extend(imm << 2, 17);
> +               else
> +                       regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +               break;
> +       case bne_op:
> +               if (regs->regs[rj] != regs->regs[rd])
> +                       regs->csr_era = pc + sign_extend(imm << 2, 17);
> +               else
> +                       regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +               break;
> +       case blt_op:
> +               if ((long)regs->regs[rj] < (long)regs->regs[rd])
> +                       regs->csr_era = pc + sign_extend(imm << 2, 17);
> +               else
> +                       regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +               break;
> +       case bge_op:
> +               if ((long)regs->regs[rj] >= (long)regs->regs[rd])
> +                       regs->csr_era = pc + sign_extend(imm << 2, 17);
> +               else
> +                       regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +               break;
> +       case bltu_op:
> +               if (regs->regs[rj] < regs->regs[rd])
> +                       regs->csr_era = pc + sign_extend(imm << 2, 17);
> +               else
> +                       regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +               break;
> +       case bgeu_op:
> +               if (regs->regs[rj] >= regs->regs[rd])
> +                       regs->csr_era = pc + sign_extend(imm << 2, 17);
> +               else
> +                       regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +               break;
> +       case jirl_op:
> +               regs->csr_era = regs->regs[rj] + sign_extend(imm << 2, 17);
> +               regs->regs[rd] = pc + LOONGARCH_INSN_SIZE;
> +               break;
> +       default:
> +               pr_info("%s: unknown opcode\n", __func__);
> +               return;
> +       }
> +}
> +
> +void simu_pc(struct pt_regs *regs, union loongarch_instruction insn)
> +{
> +       unsigned long pc = regs->csr_era;
> +       unsigned int rd = insn.reg1i20_format.rd;
> +       unsigned int imm = insn.reg1i20_format.immediate;
> +
> +       if (pc & 3) {
> +               pr_warn("%s: invalid pc 0x%lx\n", __func__, pc);
> +               return;
> +       }
> +
> +       switch (insn.reg1i20_format.opcode) {
> +       case pcaddi_op:
> +               regs->regs[rd] = pc + sign_extend(imm << 2, 21);
> +               break;
> +       case pcaddu12i_op:
> +               regs->regs[rd] = pc + sign_extend(imm << 12, 31);
> +               break;
> +       case pcaddu18i_op:
> +               regs->regs[rd] = pc + sign_extend(imm << 18, 37);
> +               break;
> +       case pcalau12i_op:
> +               regs->regs[rd] = pc + sign_extend(imm << 12, 31);
> +               regs->regs[rd] &= ~((1 << 12) - 1);
> +               break;
> +       default:
> +               pr_info("%s: unknown opcode\n", __func__);
> +               return;
> +       }
> +
> +       regs->csr_era += LOONGARCH_INSN_SIZE;
> +}
> --
> 2.1.0
>
>

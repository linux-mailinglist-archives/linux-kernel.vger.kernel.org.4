Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF67645267
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 04:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiLGDHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 22:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLGDHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 22:07:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C638537E6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 19:07:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 793EB61632
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB88C433C1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670382420;
        bh=zLuBGwcCS8p9HQhyt9nCfneZASnqsp3I1IkRxV5ZNRs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cq0iWTle6o15RLIDpGBiLa/PGPfimtyPk4zqtM8GzgR3zkXFGtLTxRMzbvhT2PJie
         T7ggmrsG+q395KkTZY7Ekh5S3ls8Jnd4mFN0+JZ/09fua9CtSDx/W5ZXFlHab/PXc3
         /mR8EkwfJl2jpA4z1cNCwsMJs6CZ+gypt0hrhZMLk++/OV4zsCOEiJ+yzqTwi9WFE+
         rf+y/7ZsKLZJfKqCbEMVty0rm9jzJIl25A6ZS7buvpfMub2z27R8Xe6Gb8lP0hkUeu
         VhpbLEWfjixTQwGt7017EevHczQuqLwguf9kQhl+hfJ3lWlkjJFu2wE6WBZ2Rn2jD4
         j7o9HnSIBrDfw==
Received: by mail-ej1-f52.google.com with SMTP id kw15so7452305ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 19:07:00 -0800 (PST)
X-Gm-Message-State: ANoB5pkqKKvvD4pU7iwen1TxuGGj4rYFXnIV4fhf3nGCS3iBOomOTHbC
        nAUrgwE0MCj+FJ2et5VczH8TrehprVplH1TSEBg=
X-Google-Smtp-Source: AA0mqf48WhSZz1up+iRWyLN3ImNePE6fZF5gntDbPdzZ7R9rdj/4gKInbZH+Ii9SSH/JuzOZJzqvBTDv7rcq0sWcfYk=
X-Received: by 2002:a17:907:37a:b0:7c0:e4b6:132e with SMTP id
 rs26-20020a170907037a00b007c0e4b6132emr11923291ejb.224.1670382419076; Tue, 06
 Dec 2022 19:06:59 -0800 (PST)
MIME-Version: 1.0
References: <1669986505-11322-1-git-send-email-yangtiezhu@loongson.cn> <1669986505-11322-2-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1669986505-11322-2-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 7 Dec 2022 11:06:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7CmTu4uF1F655N2dDcPxPBpYAe93HqQ38U_Lg84HVBAQ@mail.gmail.com>
Message-ID: <CAAhV-H7CmTu4uF1F655N2dDcPxPBpYAe93HqQ38U_Lg84HVBAQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] LoongArch: Simulate branch and PC instructions
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

On Fri, Dec 2, 2022 at 9:08 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
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
> index 6cd994d..a91798b 100644
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
> +static inline unsigned long sign_extended(unsigned long val, unsigned int idx)
> +{
> +       if (val & (1UL << idx))
> +               return ~((1UL << (idx + 1)) - 1) | val;
> +       else
> +               return ((1UL << (idx + 1)) - 1) & val;
> +}
You can use existing __SIGNEX and its friends rather than reinvent them.

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
> index 512579d..aaaf9de 100644
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
> +               regs->csr_era = pc + sign_extended((imm_h << 16 | imm_l) << 2, 27);
> +               return;
> +       case bl_op:
> +               regs->csr_era = pc + sign_extended((imm_h << 16 | imm_l) << 2, 27);
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
> +                       regs->csr_era = pc + sign_extended((imm_h << 16 | imm_l) << 2, 22);
> +               else
> +                       regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +               return;
> +       case bnez_op:
> +               if (regs->regs[rj] != 0)
> +                       regs->csr_era = pc + sign_extended((imm_h << 16 | imm_l) << 2, 22);
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
> +                       regs->csr_era = pc + sign_extended(imm << 2, 17);
> +               else
> +                       regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +               break;
> +       case bne_op:
> +               if (regs->regs[rj] != regs->regs[rd])
> +                       regs->csr_era = pc + sign_extended(imm << 2, 17);
> +               else
> +                       regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +               break;
> +       case blt_op:
> +               if ((long)regs->regs[rj] < (long)regs->regs[rd])
> +                       regs->csr_era = pc + sign_extended(imm << 2, 17);
> +               else
> +                       regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +               break;
> +       case bge_op:
> +               if ((long)regs->regs[rj] >= (long)regs->regs[rd])
> +                       regs->csr_era = pc + sign_extended(imm << 2, 17);
> +               else
> +                       regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +               break;
> +       case bltu_op:
> +               if (regs->regs[rj] < regs->regs[rd])
> +                       regs->csr_era = pc + sign_extended(imm << 2, 17);
> +               else
> +                       regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +               break;
> +       case bgeu_op:
> +               if (regs->regs[rj] >= regs->regs[rd])
> +                       regs->csr_era = pc + sign_extended(imm << 2, 17);
> +               else
> +                       regs->csr_era = pc + LOONGARCH_INSN_SIZE;
> +               break;
> +       case jirl_op:
> +               regs->csr_era = regs->regs[rj] + sign_extended(imm << 2, 17);
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
> +               regs->regs[rd] = pc + sign_extended(imm << 2, 21);
> +               break;
> +       case pcaddu12i_op:
> +               regs->regs[rd] = pc + sign_extended(imm << 12, 31);
> +               break;
> +       case pcaddu18i_op:
> +               regs->regs[rd] = pc + sign_extended(imm << 18, 37);
> +               break;
> +       case pcalau12i_op:
> +               regs->regs[rd] = pc + sign_extended(imm << 12, 31);
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

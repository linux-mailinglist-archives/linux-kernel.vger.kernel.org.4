Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCD4627553
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 05:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbiKNEiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 23:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiKNEiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 23:38:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A139FC8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 20:38:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0407960EB9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFD1C433B5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668400681;
        bh=FoQPvTfRPT4LUjYxLDCjmwNAxLW8iYB5RwIRmZxXABk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s6qAWd07QcOKKbNxcqS2uU9njQ8oXY89fioGuBoKqJ6qZJIQiLRc5kxEh19npJ+KV
         biT6qH+H2e3iPhBkDT7jBY1dcxtw1dSg7LloJ3/nH/we3mQmWrMzGwbX+0w5XB9zZG
         2h3y9NOrt/vjInZYbOSEJqPS5+NfBZGTiVzy0WLPSS1peei/Xl/Wdu8YeKY9vBfbgr
         zayc+QkjrHChxPAig1E2XX/73CGbiB1OSJPy6v/51rucPhKjEJcHqnMV9PM5N0e5sz
         +apOFAaA063Q/nW8MLCy8MC+BAxgsETO327i0XODyiZY3QzeLwZ3hjFUa/tZfFNNuA
         enKq56+MRqKBg==
Received: by mail-ed1-f52.google.com with SMTP id x102so363705ede.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 20:38:01 -0800 (PST)
X-Gm-Message-State: ANoB5pnaEB51S4mbxJavNJfsUABTbcDOCY5cRL+h9+5JiXBjO2qf/4EI
        luJcfu6IHDEqT3gL0fTlKgG5/1+7Ru+7hs8KaSA=
X-Google-Smtp-Source: AA0mqf6ttnpu/qz90g2wc63RuQGpQrq3rR3zFPhV+a4RtStTDBH1P334AupVjV7QwfB3xcq+1RUhCGu3TZgxOaUxosg=
X-Received: by 2002:aa7:db85:0:b0:463:f3a:32ce with SMTP id
 u5-20020aa7db85000000b004630f3a32cemr9936699edt.366.1668400679555; Sun, 13
 Nov 2022 20:37:59 -0800 (PST)
MIME-Version: 1.0
References: <1664326209-13995-1-git-send-email-yangtiezhu@loongson.cn> <1664326209-13995-2-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1664326209-13995-2-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 14 Nov 2022 12:37:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H55bZxA2T9P81UAa140JeKA7uS6R7NjHowDs54V_krHrg@mail.gmail.com>
Message-ID: <CAAhV-H55bZxA2T9P81UAa140JeKA7uS6R7NjHowDs54V_krHrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] LoongArch: Simulate branch and PC instructions
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

On Wed, Sep 28, 2022 at 8:50 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
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
>  arch/loongarch/include/asm/inst.h   |  19 ++++++
>  arch/loongarch/include/asm/ptrace.h |   1 +
>  arch/loongarch/kernel/inst.c        | 113 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 133 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index fce1843..93d5cd4 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -7,6 +7,7 @@
>
>  #include <linux/types.h>
>  #include <asm/asm.h>
> +#include <asm/ptrace.h>
>
>  #define INSN_BREAK             0x002a0000
>
> @@ -28,6 +29,8 @@ enum reg0i26_op {
>  enum reg1i20_op {
>         lu12iw_op       = 0x0a,
>         lu32id_op       = 0x0b,
> +       pcaddi_op       = 0x0c,
> +       pcalau12i_op    = 0x0d,
>         pcaddu12i_op    = 0x0e,
>         pcaddu18i_op    = 0x0f,
>  };
> @@ -313,6 +316,12 @@ static inline bool is_branch_ins(union loongarch_instruction *ip)
>                 ip->reg1i21_format.opcode <= bgeu_op;
>  }
>
> +static inline bool is_pc_ins(union loongarch_instruction *ip)
> +{
> +       return ip->reg1i20_format.opcode >= pcaddi_op &&
> +               ip->reg1i20_format.opcode <= pcaddu18i_op;
> +}
> +
>  static inline bool is_ra_save_ins(union loongarch_instruction *ip)
>  {
>         /* st.d $ra, $sp, offset */
> @@ -334,6 +343,16 @@ static inline bool is_stack_alloc_ins(union loongarch_instruction *ip)
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
>
>  static inline bool signed_imm_check(long val, unsigned int bit)
>  {
> diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
> index 17838c6..eb9538a 100644
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
> index b1df0ec..f5c1eff6 100644
> --- a/arch/loongarch/kernel/inst.c
> +++ b/arch/loongarch/kernel/inst.c
> @@ -38,3 +38,116 @@ u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned l
>
>         return insn.word;
>  }
> +
> +void simu_branch(struct pt_regs *regs, union loongarch_instruction insn)
> +{
> +       unsigned int imm, imm_l, imm_h, rd, rj;
> +       unsigned long pc = regs->csr_era;
> +
In previous versions we checked the alignment of era in simu_branch()
and simu_pc(), now they are unnecessary?

Huacai
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

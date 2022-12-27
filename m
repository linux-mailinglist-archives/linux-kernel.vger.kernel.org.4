Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2BF65688E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 09:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiL0It7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 03:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiL0Ity (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 03:49:54 -0500
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C15116E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 00:49:49 -0800 (PST)
Received: from mta-01.yadro.com (localhost.localdomain [127.0.0.1])
        by mta-01.yadro.com (Proxmox) with ESMTP id 200EA34138A;
        Tue, 27 Dec 2022 11:49:47 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=mta-01; bh=nUAZXagPuZ8UjJFXfq
        GMxmIgVGXOk0EcH+b7dyPn6ug=; b=Z4dldRIG3Qj0hQeIwQsZ7g4Shpd6Z30PK/
        yfe0TGACBVbRCB307b59+tYpO7FPgtIoowCKAr9+aQUPJ//PMdNiLrKG+yMh4QfW
        6c8hqBI8t7ipbzkHSfXPOdcd+t7M7HzaNcFoq7vaG79tmnhq6Ff2V5G5icof0rJD
        7tmTUcQOQ=
Received: from T-EXCH-08.corp.yadro.com (unknown [172.17.10.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Proxmox) with ESMTPS id 12B96341265;
        Tue, 27 Dec 2022 11:49:47 +0300 (MSK)
Received: from [10.199.21.212] (10.199.21.212) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Tue, 27 Dec
 2022 11:49:46 +0300
Message-ID: <d7d5730b-ebef-68e5-5046-e763e1ee6164@yadro.com>
Date:   Tue, 27 Dec 2022 11:49:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH -next V5 3/7] riscv: ftrace: Reduce the detour code size
 to half
Content-Language: en-US
To:     Guo Ren <guoren@kernel.org>
CC:     <anup@brainfault.org>, <andy.chiu@sifive.com>,
        <suagrfillet@gmail.com>, <jpoimboe@kernel.org>, <jolsa@redhat.com>,
        <rostedt@goodmis.org>, <bp@suse.de>, <paul.walmsley@sifive.com>,
        <mhiramat@kernel.org>, <palmer@dabbelt.com>, <heiko@sntech.de>,
        <conor.dooley@microchip.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Guo Ren <guoren@linux.alibaba.com>,
        <linux@yadro.com>
References: <20221208091244.203407-1-guoren@kernel.org>
 <20221208091244.203407-4-guoren@kernel.org>
From:   Evgenii Shatokhin <e.shatokhin@yadro.com>
In-Reply-To: <20221208091244.203407-4-guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.21.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08.12.2022 12:12, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Use a temporary register to reduce the size of detour code from
> 16 bytes to 8 bytes. The previous implementation is from
> afc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of
> MCOUNT").
> 
> Before the patch:
> <func_prolog>:
>   0: REG_S  ra, -SZREG(sp)
>   4: auipc  ra, ?
>   8: jalr   ?(ra)
> 12: REG_L  ra, -SZREG(sp)
>   (func_boddy)
> 
> After the patch:
> <func_prolog>:
>   0: auipc  t0, ?
>   4: jalr   t0, ?(t0)
>   (func_boddy)
> 

This patch not just reduces the size of detour code, but also fixes an 
important issue.

An Ftrace callback registered with FTRACE_OPS_FL_IPMODIFY flag can 
actually change the instruction pointer, e.g. to "replace" the given 
kernel function with a new one, which is needed for livepatching, etc.

In this case, the trampoline (ftrace_regs_caller) would not return to 
<func_prolog+12> but would rather jump to the new function. So, "REG_L 
ra, -SZREG(sp)" would not run and the original return address would not 
be restored. The kernel is likely to hang or crash as a result.

This can be easily demonstrated if one tries to "replace", say, 
cmdline_proc_show() with a new function with the same signature using 
instruction_pointer_set(&fregs->regs, new_func_addr) in the Ftrace callback.

Your patch fixes the issue, and such "function replacement" starts 
working, which is great.

> Link: https://lore.kernel.org/linux-riscv/20221122075440.1165172-1-suagrfillet@gmail.com/
> Co-developed-by: Song Shuai <suagrfillet@gmail.com>
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
> Changes in v4:
>   - Add Sob of Song Shuai
> 
> Changes in v3:
>   - Fixup ftrace_modify_call without "caller = rec->ip + 4". [Song Shuai]
>   - Optimize .macro make_call_ra & make_call_t0
> ---
>   arch/riscv/Makefile             |  4 +-
>   arch/riscv/include/asm/ftrace.h | 50 +++++++++++++++++++------
>   arch/riscv/kernel/ftrace.c      | 65 ++++++++++-----------------------
>   arch/riscv/kernel/mcount-dyn.S  | 43 +++++++++-------------
>   4 files changed, 76 insertions(+), 86 deletions(-)
> 
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 36cc609c5d03..d60939e2c596 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -12,9 +12,9 @@ ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
>          LDFLAGS_vmlinux := --no-relax
>          KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
>   ifeq ($(CONFIG_RISCV_ISA_C),y)
> -       CC_FLAGS_FTRACE := -fpatchable-function-entry=8
> -else
>          CC_FLAGS_FTRACE := -fpatchable-function-entry=4
> +else
> +       CC_FLAGS_FTRACE := -fpatchable-function-entry=2
>   endif
>   endif
> 
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
> index 04dad3380041..9e73922e1e2e 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -42,6 +42,14 @@ struct dyn_arch_ftrace {
>    * 2) jalr: setting low-12 offset to ra, jump to ra, and set ra to
>    *          return address (original pc + 4)
>    *
> + *<ftrace enable>:
> + * 0: auipc  t0/ra, 0x?
> + * 4: jalr   t0/ra, ?(t0/ra)
> + *
> + *<ftrace disable>:
> + * 0: nop
> + * 4: nop
> + *
>    * Dynamic ftrace generates probes to call sites, so we must deal with
>    * both auipc and jalr at the same time.
>    */
> @@ -52,25 +60,43 @@ struct dyn_arch_ftrace {
>   #define AUIPC_OFFSET_MASK      (0xfffff000)
>   #define AUIPC_PAD              (0x00001000)
>   #define JALR_SHIFT             20
> -#define JALR_BASIC             (0x000080e7)
> -#define AUIPC_BASIC            (0x00000097)
> +#define JALR_RA                        (0x000080e7)
> +#define AUIPC_RA               (0x00000097)
> +#define JALR_T0                        (0x000282e7)
> +#define AUIPC_T0               (0x00000297)
>   #define NOP4                   (0x00000013)
> 
> -#define make_call(caller, callee, call)                                        \
> +#define to_jalr_t0(offset)                                             \
> +       (((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_T0)
> +
> +#define to_auipc_t0(offset)                                            \
> +       ((offset & JALR_SIGN_MASK) ?                                    \
> +       (((offset & AUIPC_OFFSET_MASK) + AUIPC_PAD) | AUIPC_T0) :       \
> +       ((offset & AUIPC_OFFSET_MASK) | AUIPC_T0))
> +
> +#define make_call_t0(caller, callee, call)                             \
>   do {                                                                   \
> -       call[0] = to_auipc_insn((unsigned int)((unsigned long)callee -  \
> -                               (unsigned long)caller));                \
> -       call[1] = to_jalr_insn((unsigned int)((unsigned long)callee -   \
> -                              (unsigned long)caller));                 \
> +       unsigned int offset =                                           \
> +               (unsigned long) callee - (unsigned long) caller;        \
> +       call[0] = to_auipc_t0(offset);                                  \
> +       call[1] = to_jalr_t0(offset);                                   \
>   } while (0)
> 
> -#define to_jalr_insn(offset)                                           \
> -       (((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_BASIC)
> +#define to_jalr_ra(offset)                                             \
> +       (((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_RA)
> 
> -#define to_auipc_insn(offset)                                          \
> +#define to_auipc_ra(offset)                                            \
>          ((offset & JALR_SIGN_MASK) ?                                    \
> -       (((offset & AUIPC_OFFSET_MASK) + AUIPC_PAD) | AUIPC_BASIC) :    \
> -       ((offset & AUIPC_OFFSET_MASK) | AUIPC_BASIC))
> +       (((offset & AUIPC_OFFSET_MASK) + AUIPC_PAD) | AUIPC_RA) :       \
> +       ((offset & AUIPC_OFFSET_MASK) | AUIPC_RA))
> +
> +#define make_call_ra(caller, callee, call)                             \
> +do {                                                                   \
> +       unsigned int offset =                                           \
> +               (unsigned long) callee - (unsigned long) caller;        \
> +       call[0] = to_auipc_ra(offset);                                  \
> +       call[1] = to_jalr_ra(offset);                                   \
> +} while (0)
> 
>   /*
>    * Let auipc+jalr be the basic *mcount unit*, so we make it 8 bytes here.
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 2086f6585773..61b24d767e2e 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -55,12 +55,15 @@ static int ftrace_check_current_call(unsigned long hook_pos,
>   }
> 
>   static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
> -                               bool enable)
> +                               bool enable, bool ra)
>   {
>          unsigned int call[2];
>          unsigned int nops[2] = {NOP4, NOP4};
> 
> -       make_call(hook_pos, target, call);
> +       if (ra)
> +               make_call_ra(hook_pos, target, call);
> +       else
> +               make_call_t0(hook_pos, target, call);
> 
>          /* Replace the auipc-jalr pair at once. Return -EPERM on write error. */
>          if (patch_text_nosync
> @@ -70,42 +73,13 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
>          return 0;
>   }
> 
> -/*
> - * Put 5 instructions with 16 bytes at the front of function within
> - * patchable function entry nops' area.
> - *
> - * 0: REG_S  ra, -SZREG(sp)
> - * 1: auipc  ra, 0x?
> - * 2: jalr   -?(ra)
> - * 3: REG_L  ra, -SZREG(sp)
> - *
> - * So the opcodes is:
> - * 0: 0xfe113c23 (sd)/0xfe112e23 (sw)
> - * 1: 0x???????? -> auipc
> - * 2: 0x???????? -> jalr
> - * 3: 0xff813083 (ld)/0xffc12083 (lw)
> - */
> -#if __riscv_xlen == 64
> -#define INSN0  0xfe113c23
> -#define INSN3  0xff813083
> -#elif __riscv_xlen == 32
> -#define INSN0  0xfe112e23
> -#define INSN3  0xffc12083
> -#endif
> -
> -#define FUNC_ENTRY_SIZE        16
> -#define FUNC_ENTRY_JMP 4
> -
>   int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>   {
> -       unsigned int call[4] = {INSN0, 0, 0, INSN3};
> -       unsigned long target = addr;
> -       unsigned long caller = rec->ip + FUNC_ENTRY_JMP;
> +       unsigned int call[2];
> 
> -       call[1] = to_auipc_insn((unsigned int)(target - caller));
> -       call[2] = to_jalr_insn((unsigned int)(target - caller));
> +       make_call_t0(rec->ip, addr, call);
> 
> -       if (patch_text_nosync((void *)rec->ip, call, FUNC_ENTRY_SIZE))
> +       if (patch_text_nosync((void *)rec->ip, call, 8))

A small nit: how about using sizeof(call) or MCOUNT_INSN_SIZE here 
rather than 8?

Besides, adding BUILD_BUG_ON(sizeof(call) != MCOUNT_INSN_SIZE) would 
help catch the errors if someone changes the sizes in the future.

>                  return -EPERM;
> 
>          return 0;
> @@ -114,15 +88,14 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>   int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>                      unsigned long addr)
>   {
> -       unsigned int nops[4] = {NOP4, NOP4, NOP4, NOP4};
> +       unsigned int nops[2] = {NOP4, NOP4};
> 
> -       if (patch_text_nosync((void *)rec->ip, nops, FUNC_ENTRY_SIZE))
> +       if (patch_text_nosync((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
>                  return -EPERM;
> 
>          return 0;
>   }
> 
> -
>   /*
>    * This is called early on, and isn't wrapped by
>    * ftrace_arch_code_modify_{prepare,post_process}() and therefor doesn't hold
> @@ -144,10 +117,10 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
>   int ftrace_update_ftrace_func(ftrace_func_t func)
>   {
>          int ret = __ftrace_modify_call((unsigned long)&ftrace_call,
> -                                      (unsigned long)func, true);
> +                                      (unsigned long)func, true, true);
>          if (!ret) {
>                  ret = __ftrace_modify_call((unsigned long)&ftrace_regs_call,
> -                                          (unsigned long)func, true);
> +                                          (unsigned long)func, true, true);
>          }
> 
>          return ret;
> @@ -159,16 +132,16 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
>                         unsigned long addr)
>   {
>          unsigned int call[2];
> -       unsigned long caller = rec->ip + FUNC_ENTRY_JMP;
> +       unsigned long caller = rec->ip;
>          int ret;
> 
> -       make_call(caller, old_addr, call);
> +       make_call_t0(caller, old_addr, call);
>          ret = ftrace_check_current_call(caller, call);
> 
>          if (ret)
>                  return ret;
> 
> -       return __ftrace_modify_call(caller, addr, true);
> +       return __ftrace_modify_call(caller, addr, true, false);
>   }
>   #endif
> 
> @@ -203,12 +176,12 @@ int ftrace_enable_ftrace_graph_caller(void)
>          int ret;
> 
>          ret = __ftrace_modify_call((unsigned long)&ftrace_graph_call,
> -                                   (unsigned long)&prepare_ftrace_return, true);
> +                                   (unsigned long)&prepare_ftrace_return, true, true);
>          if (ret)
>                  return ret;
> 
>          return __ftrace_modify_call((unsigned long)&ftrace_graph_regs_call,
> -                                   (unsigned long)&prepare_ftrace_return, true);
> +                                   (unsigned long)&prepare_ftrace_return, true, true);
>   }
> 
>   int ftrace_disable_ftrace_graph_caller(void)
> @@ -216,12 +189,12 @@ int ftrace_disable_ftrace_graph_caller(void)
>          int ret;
> 
>          ret = __ftrace_modify_call((unsigned long)&ftrace_graph_call,
> -                                   (unsigned long)&prepare_ftrace_return, false);
> +                                   (unsigned long)&prepare_ftrace_return, false, true);
>          if (ret)
>                  return ret;
> 
>          return __ftrace_modify_call((unsigned long)&ftrace_graph_regs_call,
> -                                   (unsigned long)&prepare_ftrace_return, false);
> +                                   (unsigned long)&prepare_ftrace_return, false, true);
>   }
>   #endif /* CONFIG_DYNAMIC_FTRACE */
>   #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
> index d171eca623b6..64bc79816f5e 100644
> --- a/arch/riscv/kernel/mcount-dyn.S
> +++ b/arch/riscv/kernel/mcount-dyn.S
> @@ -13,8 +13,8 @@
> 
>          .text
> 
> -#define FENTRY_RA_OFFSET       12
> -#define ABI_SIZE_ON_STACK      72
> +#define FENTRY_RA_OFFSET       8
> +#define ABI_SIZE_ON_STACK      80
>   #define ABI_A0                 0
>   #define ABI_A1                 8
>   #define ABI_A2                 16
> @@ -23,10 +23,10 @@
>   #define ABI_A5                 40
>   #define ABI_A6                 48
>   #define ABI_A7                 56
> -#define ABI_RA                 64
> +#define ABI_T0                 64
> +#define ABI_RA                 72
> 
>          .macro SAVE_ABI
> -       addi    sp, sp, -SZREG
>          addi    sp, sp, -ABI_SIZE_ON_STACK
> 
>          REG_S   a0, ABI_A0(sp)
> @@ -37,6 +37,7 @@
>          REG_S   a5, ABI_A5(sp)
>          REG_S   a6, ABI_A6(sp)
>          REG_S   a7, ABI_A7(sp)
> +       REG_S   t0, ABI_T0(sp)
>          REG_S   ra, ABI_RA(sp)
>          .endm
> 
> @@ -49,24 +50,18 @@
>          REG_L   a5, ABI_A5(sp)
>          REG_L   a6, ABI_A6(sp)
>          REG_L   a7, ABI_A7(sp)
> +       REG_L   t0, ABI_T0(sp)
>          REG_L   ra, ABI_RA(sp)
> 
>          addi    sp, sp, ABI_SIZE_ON_STACK
> -       addi    sp, sp, SZREG
>          .endm
> 
>   #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>          .macro SAVE_ALL
> -       addi    sp, sp, -SZREG
>          addi    sp, sp, -PT_SIZE_ON_STACK
> 
> -       REG_S x1,  PT_EPC(sp)
> -       addi    sp, sp, PT_SIZE_ON_STACK
> -       REG_L x1,  (sp)
> -       addi    sp, sp, -PT_SIZE_ON_STACK
> +       REG_S t0,  PT_EPC(sp)
>          REG_S x1,  PT_RA(sp)
> -       REG_L x1,  PT_EPC(sp)
> -
>          REG_S x2,  PT_SP(sp)
>          REG_S x3,  PT_GP(sp)
>          REG_S x4,  PT_TP(sp)
> @@ -100,11 +95,8 @@
>          .endm
> 
>          .macro RESTORE_ALL
> +       REG_L t0,  PT_EPC(sp)
>          REG_L x1,  PT_RA(sp)
> -       addi    sp, sp, PT_SIZE_ON_STACK
> -       REG_S x1,  (sp)
> -       addi    sp, sp, -PT_SIZE_ON_STACK
> -       REG_L x1,  PT_EPC(sp)
>          REG_L x2,  PT_SP(sp)
>          REG_L x3,  PT_GP(sp)
>          REG_L x4,  PT_TP(sp)
> @@ -137,17 +129,16 @@
>          REG_L x31, PT_T6(sp)
> 
>          addi    sp, sp, PT_SIZE_ON_STACK
> -       addi    sp, sp, SZREG
>          .endm
>   #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> 
>   ENTRY(ftrace_caller)
>          SAVE_ABI
> 
> -       addi    a0, ra, -FENTRY_RA_OFFSET
> +       addi    a0, t0, -FENTRY_RA_OFFSET
>          la      a1, function_trace_op
>          REG_L   a2, 0(a1)
> -       REG_L   a1, ABI_SIZE_ON_STACK(sp)
> +       mv      a1, ra
>          mv      a3, sp
> 
>   ftrace_call:
> @@ -155,8 +146,8 @@ ftrace_call:
>          call    ftrace_stub
> 
>   #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> -       addi    a0, sp, ABI_SIZE_ON_STACK
> -       REG_L   a1, ABI_RA(sp)
> +       addi    a0, sp, ABI_RA
> +       REG_L   a1, ABI_T0(sp)
>          addi    a1, a1, -FENTRY_RA_OFFSET
>   #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
>          mv      a2, s0
> @@ -166,17 +157,17 @@ ftrace_graph_call:
>          call    ftrace_stub
>   #endif
>          RESTORE_ABI
> -       ret
> +       jr t0
>   ENDPROC(ftrace_caller)
> 
>   #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>   ENTRY(ftrace_regs_caller)
>          SAVE_ALL
> 
> -       addi    a0, ra, -FENTRY_RA_OFFSET
> +       addi    a0, t0, -FENTRY_RA_OFFSET
>          la      a1, function_trace_op
>          REG_L   a2, 0(a1)
> -       REG_L   a1, PT_SIZE_ON_STACK(sp)
> +       REG_L   a1, PT_RA(sp)

ra contains the original return address at this point, so, I think, you 
can load it into a1 directly, like you do in ftrace_caller:

	mv      a1, ra

>          mv      a3, sp
> 
>   ftrace_regs_call:
> @@ -185,7 +176,7 @@ ftrace_regs_call:
> 
>   #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>          addi    a0, sp, PT_RA
> -       REG_L   a1, PT_EPC(sp)
> +       REG_L   a1, PT_T0(sp)
>          addi    a1, a1, -FENTRY_RA_OFFSET
>   #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
>          mv      a2, s0
> @@ -196,6 +187,6 @@ ftrace_graph_regs_call:
>   #endif
> 
>          RESTORE_ALL
> -       ret
> +       jr t0
>   ENDPROC(ftrace_regs_caller)
>   #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> --
> 2.36.1

Regards,
Evgenii




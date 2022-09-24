Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE215E8A55
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiIXIyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiIXIyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:54:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D3C22532
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:54:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E45AAB80DE9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62794C433C1;
        Sat, 24 Sep 2022 08:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664009656;
        bh=+ju274AM9n6hgB8c9tXvPyPGjA4eLFHfQ+btIOLNdSc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xo08pNqOYJp/I1N13kVH8JXX2aZWtyQpNK5ZmCs4Hx6RwTn8oU/+QNbuFBqBmDtnV
         0vQMFA0jP+ulqTpjbjL10f3ji3oGsJ++bRpS8NEIAmD+lXGLmW65IRNaTgYV0dkcP2
         U+A/r1eKuMBNAvQrj5OCGVbb4TYQ8aQ2nn0c0JznvCKOA1kuSmIL+A/VpqPKO4AW0v
         F/vrMZv0SHOHHr4whQn4od+LMFwXnwhYubsMojcHhpILA5hiNncXJckn32LUx4UhzR
         q5yIRHq1GV8OEEB46VhTAfwaByMb2a6qp/XpBOk1H9rmruKTu0pcAkKJkgzILTFzYI
         TpGykp2lQoyMg==
Date:   Sat, 24 Sep 2022 17:54:11 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     l3b2w1@gmail.com
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] rethook: add riscv rethook implementation.
Message-Id: <20220924175411.b0e3095b5e44706dd2f8c90f@kernel.org>
In-Reply-To: <20220922134428.19203-1-l3b2w1@gmail.com>
References: <YyxG6wC0mjCUUGDB@wendy>
        <20220922134428.19203-1-l3b2w1@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Binglei,

On Thu, 22 Sep 2022 21:44:28 +0800
l3b2w1@gmail.com wrote:

> From: Binglei Wang <l3b2w1@gmail.com>
> 
> Implement the kretprobes function on riscv arch by
> using rethook machenism which abstracts general kretprobe info
> into the struct rethook_node
> to be embedded in the struct kretprobe_instance

Thanks for working on it.

BTW, you might work on older kernel. Could you check your kernel
has commit 73f9b911faa7 ("kprobes: Use rethook for kretprobe if possible") ?

It replaces the kretprobe implementation in kernel/kprobes.c with
rethook. This means your patch also must remove the arch dependent
kretprobe implementation (arch_prepare_kretprobe(), __kretprobe_trampoline,
trampoline_handler() and arch_kretprobe_fixup_return()), and you
don't need to create kprobes_trampoline.h, but just rename
kprobes_trampoline.S to rethook_trampoline.S.

Thank you,

> 
> Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
> ---
>  arch/riscv/Kconfig                            |  1 +
>  arch/riscv/kernel/probes/Makefile             |  1 +
>  arch/riscv/kernel/probes/kprobes.c            |  8 --
>  arch/riscv/kernel/probes/kprobes_trampoline.S | 73 +----------------
>  arch/riscv/kernel/probes/kprobes_trampoline.h | 79 +++++++++++++++++++
>  arch/riscv/kernel/probes/rethook.c            | 24 ++++++
>  arch/riscv/kernel/probes/rethook_trampoline.S | 22 ++++++
>  include/linux/kprobes.h                       |  6 ++
>  8 files changed, 134 insertions(+), 80 deletions(-)
>  create mode 100644 arch/riscv/kernel/probes/kprobes_trampoline.h
>  create mode 100644 arch/riscv/kernel/probes/rethook.c
>  create mode 100644 arch/riscv/kernel/probes/rethook_trampoline.S
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ed66c31e4..c5cae0825 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -97,6 +97,7 @@ config RISCV
>  	select HAVE_KPROBES if !XIP_KERNEL
>  	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>  	select HAVE_KRETPROBES if !XIP_KERNEL
> +	select HAVE_RETHOOK if !XIP_KERNEL
>  	select HAVE_MOVE_PMD
>  	select HAVE_MOVE_PUD
>  	select HAVE_PCI
> diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
> index 7f0840dcc..ee345e7e9 100644
> --- a/arch/riscv/kernel/probes/Makefile
> +++ b/arch/riscv/kernel/probes/Makefile
> @@ -3,4 +3,5 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
>  obj-$(CONFIG_KPROBES)		+= kprobes_trampoline.o
>  obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
>  obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
> +obj-$(CONFIG_RETHOOK) 		+= rethook.o rethook_trampoline.o
>  CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> index e6e950b7c..04911cc42 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -350,14 +350,6 @@ void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
>  	return (void *)kretprobe_trampoline_handler(regs, NULL);
>  }
>  
> -void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
> -				      struct pt_regs *regs)
> -{
> -	ri->ret_addr = (kprobe_opcode_t *)regs->ra;
> -	ri->fp = NULL;
> -	regs->ra = (unsigned long) &__kretprobe_trampoline;
> -}
> -
>  int __kprobes arch_trampoline_kprobe(struct kprobe *p)
>  {
>  	return 0;
> diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/riscv/kernel/probes/kprobes_trampoline.S
> index 7bdb09ded..54937f342 100644
> --- a/arch/riscv/kernel/probes/kprobes_trampoline.S
> +++ b/arch/riscv/kernel/probes/kprobes_trampoline.S
> @@ -2,78 +2,7 @@
>  /*
>   * Author: Patrick Stählin <me@packi.ch>
>   */
> -#include <linux/linkage.h>
> -
> -#include <asm/asm.h>
> -#include <asm/asm-offsets.h>
> -
> -	.text
> -	.altmacro
> -
> -	.macro save_all_base_regs
> -	REG_S x1,  PT_RA(sp)
> -	REG_S x3,  PT_GP(sp)
> -	REG_S x4,  PT_TP(sp)
> -	REG_S x5,  PT_T0(sp)
> -	REG_S x6,  PT_T1(sp)
> -	REG_S x7,  PT_T2(sp)
> -	REG_S x8,  PT_S0(sp)
> -	REG_S x9,  PT_S1(sp)
> -	REG_S x10, PT_A0(sp)
> -	REG_S x11, PT_A1(sp)
> -	REG_S x12, PT_A2(sp)
> -	REG_S x13, PT_A3(sp)
> -	REG_S x14, PT_A4(sp)
> -	REG_S x15, PT_A5(sp)
> -	REG_S x16, PT_A6(sp)
> -	REG_S x17, PT_A7(sp)
> -	REG_S x18, PT_S2(sp)
> -	REG_S x19, PT_S3(sp)
> -	REG_S x20, PT_S4(sp)
> -	REG_S x21, PT_S5(sp)
> -	REG_S x22, PT_S6(sp)
> -	REG_S x23, PT_S7(sp)
> -	REG_S x24, PT_S8(sp)
> -	REG_S x25, PT_S9(sp)
> -	REG_S x26, PT_S10(sp)
> -	REG_S x27, PT_S11(sp)
> -	REG_S x28, PT_T3(sp)
> -	REG_S x29, PT_T4(sp)
> -	REG_S x30, PT_T5(sp)
> -	REG_S x31, PT_T6(sp)
> -	.endm
> -
> -	.macro restore_all_base_regs
> -	REG_L x3,  PT_GP(sp)
> -	REG_L x4,  PT_TP(sp)
> -	REG_L x5,  PT_T0(sp)
> -	REG_L x6,  PT_T1(sp)
> -	REG_L x7,  PT_T2(sp)
> -	REG_L x8,  PT_S0(sp)
> -	REG_L x9,  PT_S1(sp)
> -	REG_L x10, PT_A0(sp)
> -	REG_L x11, PT_A1(sp)
> -	REG_L x12, PT_A2(sp)
> -	REG_L x13, PT_A3(sp)
> -	REG_L x14, PT_A4(sp)
> -	REG_L x15, PT_A5(sp)
> -	REG_L x16, PT_A6(sp)
> -	REG_L x17, PT_A7(sp)
> -	REG_L x18, PT_S2(sp)
> -	REG_L x19, PT_S3(sp)
> -	REG_L x20, PT_S4(sp)
> -	REG_L x21, PT_S5(sp)
> -	REG_L x22, PT_S6(sp)
> -	REG_L x23, PT_S7(sp)
> -	REG_L x24, PT_S8(sp)
> -	REG_L x25, PT_S9(sp)
> -	REG_L x26, PT_S10(sp)
> -	REG_L x27, PT_S11(sp)
> -	REG_L x28, PT_T3(sp)
> -	REG_L x29, PT_T4(sp)
> -	REG_L x30, PT_T5(sp)
> -	REG_L x31, PT_T6(sp)
> -	.endm
> +#include "kprobes_trampoline.h"
>  
>  ENTRY(__kretprobe_trampoline)
>  	addi sp, sp, -(PT_SIZE_ON_STACK)
> diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.h b/arch/riscv/kernel/probes/kprobes_trampoline.h
> new file mode 100644
> index 000000000..48895a5e3
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/kprobes_trampoline.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef _KPROBES_TRAMPOLINE_H
> +#define _KPROBES_TRAMPOLINE_H
> +/*
> + * Author: Patrick Stählin <me@packi.ch>
> + */
> +#include <linux/linkage.h>
> +
> +#include <asm/asm.h>
> +#include <asm/asm-offsets.h>
> +
> +	.text
> +	.altmacro
> +
> +	.macro save_all_base_regs
> +	REG_S x1,  PT_RA(sp)
> +	REG_S x3,  PT_GP(sp)
> +	REG_S x4,  PT_TP(sp)
> +	REG_S x5,  PT_T0(sp)
> +	REG_S x6,  PT_T1(sp)
> +	REG_S x7,  PT_T2(sp)
> +	REG_S x8,  PT_S0(sp)
> +	REG_S x9,  PT_S1(sp)
> +	REG_S x10, PT_A0(sp)
> +	REG_S x11, PT_A1(sp)
> +	REG_S x12, PT_A2(sp)
> +	REG_S x13, PT_A3(sp)
> +	REG_S x14, PT_A4(sp)
> +	REG_S x15, PT_A5(sp)
> +	REG_S x16, PT_A6(sp)
> +	REG_S x17, PT_A7(sp)
> +	REG_S x18, PT_S2(sp)
> +	REG_S x19, PT_S3(sp)
> +	REG_S x20, PT_S4(sp)
> +	REG_S x21, PT_S5(sp)
> +	REG_S x22, PT_S6(sp)
> +	REG_S x23, PT_S7(sp)
> +	REG_S x24, PT_S8(sp)
> +	REG_S x25, PT_S9(sp)
> +	REG_S x26, PT_S10(sp)
> +	REG_S x27, PT_S11(sp)
> +	REG_S x28, PT_T3(sp)
> +	REG_S x29, PT_T4(sp)
> +	REG_S x30, PT_T5(sp)
> +	REG_S x31, PT_T6(sp)
> +	.endm
> +
> +	.macro restore_all_base_regs
> +	REG_L x3,  PT_GP(sp)
> +	REG_L x4,  PT_TP(sp)
> +	REG_L x5,  PT_T0(sp)
> +	REG_L x6,  PT_T1(sp)
> +	REG_L x7,  PT_T2(sp)
> +	REG_L x8,  PT_S0(sp)
> +	REG_L x9,  PT_S1(sp)
> +	REG_L x10, PT_A0(sp)
> +	REG_L x11, PT_A1(sp)
> +	REG_L x12, PT_A2(sp)
> +	REG_L x13, PT_A3(sp)
> +	REG_L x14, PT_A4(sp)
> +	REG_L x15, PT_A5(sp)
> +	REG_L x16, PT_A6(sp)
> +	REG_L x17, PT_A7(sp)
> +	REG_L x18, PT_S2(sp)
> +	REG_L x19, PT_S3(sp)
> +	REG_L x20, PT_S4(sp)
> +	REG_L x21, PT_S5(sp)
> +	REG_L x22, PT_S6(sp)
> +	REG_L x23, PT_S7(sp)
> +	REG_L x24, PT_S8(sp)
> +	REG_L x25, PT_S9(sp)
> +	REG_L x26, PT_S10(sp)
> +	REG_L x27, PT_S11(sp)
> +	REG_L x28, PT_T3(sp)
> +	REG_L x29, PT_T4(sp)
> +	REG_L x30, PT_T5(sp)
> +	REG_L x31, PT_T6(sp)
> +	.endm
> +#endif
> diff --git a/arch/riscv/kernel/probes/rethook.c b/arch/riscv/kernel/probes/rethook.c
> new file mode 100644
> index 000000000..47853bc36
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/rethook.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Generic return hook for riscv.
> + */
> +
> +#include <linux/kprobes.h>
> +#include <linux/rethook.h>
> +
> +/* This is called from arch_rethook_trampoline() */
> +unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
> +{
> +	return rethook_trampoline_handler(regs, regs->s0);
> +}
> +NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
> +
> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
> +{
> +	rhn->ret_addr = regs->ra;
> +	rhn->frame = regs->s0;
> +
> +	/* replace return addr with trampoline */
> +	regs->ra = (u64)arch_rethook_trampoline;
> +}
> +NOKPROBE_SYMBOL(arch_rethook_prepare);
> diff --git a/arch/riscv/kernel/probes/rethook_trampoline.S b/arch/riscv/kernel/probes/rethook_trampoline.S
> new file mode 100644
> index 000000000..e81c3d4e0
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/rethook_trampoline.S
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Author: Patrick Stählin <me@packi.ch>
> + */
> +#include "kprobes_trampoline.h"
> +
> +ENTRY(arch_rethook_trampoline)
> +	addi sp, sp, -(PT_SIZE_ON_STACK)
> +	save_all_base_regs
> +
> +	move a0, sp /* pt_regs */
> +
> +	call arch_rethook_trampoline_callback
> +
> +	/* use the result as the return-address */
> +	move ra, a0
> +
> +	restore_all_base_regs
> +	addi sp, sp, PT_SIZE_ON_STACK
> +
> +	ret
> +ENDPROC(arch_rethook_trampoline)
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 55041d2f8..a3805b5b2 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -210,6 +210,12 @@ static nokprobe_inline unsigned long get_kretprobe_retaddr(struct kretprobe_inst
>  {
>  	return ri->node.ret_addr;
>  }
> +static nokprobe_inline
> +unsigned long kretprobe_trampoline_handler(struct pt_regs *regs,
> +					   void *frame_pointer)
> +{
> +	return 0;
> +}
>  #else
>  extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
>  				   struct pt_regs *regs);
> 
> base-commit: f30480cdeafc79d1f017d41335a96d8e3b973c91
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

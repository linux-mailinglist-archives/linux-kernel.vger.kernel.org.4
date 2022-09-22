Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B005E6102
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiIVL3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiIVL3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:29:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33A5DF3B2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663846147; x=1695382147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JQhsh7gBqHUfBJhW9aoKqBxbWOGrBgFZ89Y4CitJufc=;
  b=ksU5DOgp8umxks0gl77xAtr+VeRkm8QQEbipX2FN81+YRLP22KAi6B/c
   8L+28vN6m3kZz2STXSdeeWvleezj3OwtJwiF+i1Gjx8lpFyZtz2oQQAkn
   OyOHaf3I2zxbtaRJ5XRh5ICiqWDlmgPhJX4W17Yr1hIrwTP6f4HNlNIia
   FTfjRnuRaaP8zVGj3gdutcENF9A7kf7R8iXbHM1yLUPyj+CM4j38t8iF0
   lil6HCfr2rcPc2CD79vdfuSWBIORpd4CGz+oFzdud8RfvBL+ybcV4M7qn
   aSMOP1quyileJ11HATxF1AYYHuM/koRB1tIBhE66UQr9ngkacsnTZIbDE
   g==;
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="114895997"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Sep 2022 04:29:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 22 Sep 2022 04:29:06 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 22 Sep 2022 04:29:04 -0700
Date:   Thu, 22 Sep 2022 12:28:43 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Binglei Wang <l3b2w1@gmail.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
        <mhiramat@kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rethook: add riscv rethook implementation.
Message-ID: <YyxG6wC0mjCUUGDB@wendy>
References: <20220922040443.605175-1-l3b2w1@gmail.com>
 <20220922111933.607219-1-l3b2w1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220922111933.607219-1-l3b2w1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 07:19:33PM +0800, Binglei Wang wrote:
> From: Binglei Wang <l3b2w1@gmail.com>
> 
> Implement the kretprobes on riscv arch by using rethook machenism
> which abstracts general kretprobe info into a struct rethook_node
> to be embedded in the struct kretprobe_instance.

Hey Binglei,

This is now version 3 of the patch right? You need to run format-patch
with the -v option so you stop confusing tooling (and humans) as to
what they are reviewing. Also, your changelog from the other versions is
missing.

Please take a look at the docs for how to submit subsequent versions:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

> Signed-off-by: Binglei Wang <l3b2w1@gmail.com>

Previously this was your work email - I suspect it still needs to be
your work email here. Your work address can still be the author even if
the mail is not send from that account.

Hope that helps,
Conor.

> ---
>  arch/riscv/Kconfig                            |  1 +
>  arch/riscv/kernel/probes/Makefile             |  1 +
>  arch/riscv/kernel/probes/kprobes.c            |  8 --
>  arch/riscv/kernel/probes/kprobes_trampoline.S | 73 +----------------
>  arch/riscv/kernel/probes/kprobes_trampoline.h | 79 +++++++++++++++++++
>  arch/riscv/kernel/probes/rethook.c            | 26 ++++++
>  arch/riscv/kernel/probes/rethook_trampoline.S | 22 ++++++
>  include/linux/kprobes.h                       |  6 ++
>  8 files changed, 136 insertions(+), 80 deletions(-)
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
> index 000000000..4a41d5eb6
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/rethook.c
> @@ -0,0 +1,26 @@
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
> +
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
> -- 
> 2.27.0
> 
> 

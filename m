Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD59600692
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJQGHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJQGHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:07:51 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9188156B8B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 23:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1665986867; bh=oVI4YB8ceypsKzQ/w4M+NpXDx+u0WmmhjsQ6HlBFcOI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N6XNhQxK2NnHxxZmjMgZEUFNmXu4xKya2Hxfd6ehixOeadaGILPhji4Qrwnympse2
         D9/HM4YtBLUAhE3tfc0AzM2z4MHpta/LUq4DW/gla2sXDPCBG7io4pXGvfEj3SYlSR
         0nLIMZ2sS03pI0xJ+8vosL1Y9PT4BqgyBX5HI0wk=
Received: from [100.100.57.122] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id C8C0B6008C;
        Mon, 17 Oct 2022 14:07:46 +0800 (CST)
Message-ID: <49881dc3-1b74-2895-af45-651e91c4f49c@xen0n.name>
Date:   Mon, 17 Oct 2022 14:07:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:107.0)
 Gecko/20100101 Thunderbird/107.0a1
Subject: Re: [PATCH V2] LoongArch: Add unaligned access support
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
References: <20221017022330.2383060-1-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20221017022330.2383060-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/17 10:23, Huacai Chen wrote:
> Loongson-2 series (Loongson-2K500, Loongson-2K1000) don't support
> unaligned access in hardware, while Loongson-3 series (Loongson-3A5000,
> Loongson-3C5000) are configurable whether support unaligned access in
> hardware. This patch add unaligned access emulation for those LoongArch
> processors without hardware support.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Simplify READ_FPR and WRITE_FPR.
> 
>   arch/loongarch/Kconfig            |   2 +
>   arch/loongarch/include/asm/inst.h |  14 ++
>   arch/loongarch/kernel/Makefile    |   3 +-
>   arch/loongarch/kernel/traps.c     |  27 ++
>   arch/loongarch/kernel/unaligned.c | 393 ++++++++++++++++++++++++++++++
>   arch/loongarch/lib/Makefile       |   2 +-
>   arch/loongarch/lib/unaligned.S    |  93 +++++++
>   7 files changed, 532 insertions(+), 2 deletions(-)
>   create mode 100644 arch/loongarch/kernel/unaligned.c
>   create mode 100644 arch/loongarch/lib/unaligned.S

Please also update Documentation/admin-guide/sysctl/kernel.rst to 
mention loongarch in the respective sysctls' documentation. (Grep for 
ARCH_UNALIGN to see.)

> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 0a6ef613124c..a8dc58e8162a 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -122,6 +122,8 @@ config LOONGARCH
>   	select RTC_LIB
>   	select SMP
>   	select SPARSE_IRQ
> +	select SYSCTL_ARCH_UNALIGN_ALLOW
> +	select SYSCTL_ARCH_UNALIGN_NO_WARN
>   	select SYSCTL_EXCEPTION_TRACE
>   	select SWIOTLB
>   	select TRACE_IRQFLAGS_SUPPORT
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index fce1843ceebb..e96b5345f389 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -76,6 +76,10 @@ enum reg2i12_op {
>   	ldbu_op		= 0xa8,
>   	ldhu_op		= 0xa9,
>   	ldwu_op		= 0xaa,
> +	flds_op		= 0xac,
> +	fsts_op		= 0xad,
> +	fldd_op		= 0xae,
> +	fstd_op		= 0xaf,
>   };
>   
>   enum reg2i14_op {
> @@ -146,6 +150,10 @@ enum reg3_op {
>   	ldxbu_op	= 0x7040,
>   	ldxhu_op	= 0x7048,
>   	ldxwu_op	= 0x7050,
> +	fldxs_op	= 0x7060,
> +	fldxd_op	= 0x7068,
> +	fstxs_op	= 0x7070,
> +	fstxd_op	= 0x7078,
>   	amswapw_op	= 0x70c0,
>   	amswapd_op	= 0x70c1,
>   	amaddw_op	= 0x70c2,
> @@ -566,4 +574,10 @@ static inline void emit_##NAME(union loongarch_instruction *insn,	\
>   
>   DEF_EMIT_REG3SA2_FORMAT(alsld, alsld_op)
>   
> +struct pt_regs;
> +
> +unsigned long unaligned_read(void *addr, void *value, unsigned long n, bool sign);
> +unsigned long unaligned_write(void *addr, unsigned long value, unsigned long n);
> +void emulate_load_store_insn(struct pt_regs *regs, void __user *addr, unsigned int *pc);
> +
>   #endif /* _ASM_INST_H */
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index 42be564278fa..2ad2555b53ea 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -7,7 +7,8 @@ extra-y		:= vmlinux.lds
>   
>   obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
>   		   traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o switch.o \
> -		   elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o
> +		   elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o \
> +		   unaligned.o
>   
>   obj-$(CONFIG_ACPI)		+= acpi.o
>   obj-$(CONFIG_EFI) 		+= efi.o
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> index 1a4dce84ebc6..7ea62faeeadb 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -368,13 +368,40 @@ asmlinkage void noinstr do_ade(struct pt_regs *regs)
>   	irqentry_exit(regs, state);
>   }
>   
> +/* sysctl hooks */
> +int unaligned_enabled __read_mostly = 1;	/* Enabled by default */
> +int no_unaligned_warning __read_mostly = 1;	/* Only 1 warning by default */
> +
>   asmlinkage void noinstr do_ale(struct pt_regs *regs)
>   {
> +	unsigned int *pc;
>   	irqentry_state_t state = irqentry_enter(regs);
>   
> +	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, regs->csr_badvaddr);
> +
> +	/*
> +	 * Did we catch a fault trying to load an instruction?
> +	 */
> +	if (regs->csr_badvaddr == regs->csr_era)
> +		goto sigbus;
> +	if (user_mode(regs) && !test_thread_flag(TIF_FIXADE))
> +		goto sigbus;
> +	if (!unaligned_enabled)
> +		goto sigbus;
> +	if (!no_unaligned_warning)
> +		show_registers(regs);
> +
> +	pc = (unsigned int *)exception_era(regs);
> +
> +	emulate_load_store_insn(regs, (void __user *)regs->csr_badvaddr, pc);
> +
> +	goto out;
> +
> +sigbus:
>   	die_if_kernel("Kernel ale access", regs);
>   	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)regs->csr_badvaddr);
>   
> +out:
>   	irqentry_exit(regs, state);
>   }
>   
> diff --git a/arch/loongarch/kernel/unaligned.c b/arch/loongarch/kernel/unaligned.c
> new file mode 100644
> index 000000000000..f367424b762a
> --- /dev/null
> +++ b/arch/loongarch/kernel/unaligned.c
> @@ -0,0 +1,393 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Handle unaligned accesses by emulation.
> + *
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited

MIPS heritage too?

> + *
> + */
> +#include <linux/mm.h>
> +#include <linux/sched.h>
> +#include <linux/signal.h>
> +#include <linux/debugfs.h>
> +#include <linux/perf_event.h>
> +
> +#include <asm/asm.h>
> +#include <asm/branch.h>
> +#include <asm/fpu.h>
> +#include <asm/inst.h>
> +
> +#include "access-helper.h"
> +
> +#ifdef CONFIG_DEBUG_FS
> +static u32 unaligned_instructions_user;
> +static u32 unaligned_instructions_kernel;
> +#endif
> +
> +static inline unsigned long read_fpr(unsigned int fd)
> +{
> +#define READ_FPR(fd, __value)		\
> +	__asm__ __volatile__("movfr2gr.d %0, $f"#fd"\n\t" : "=r"(__value));
> +
> +	unsigned long __value;
> +
> +	switch (fd) {
> +	case 0:
> +		READ_FPR(0, __value);
> +		break;
> +	case 1:
> +		READ_FPR(1, __value);
> +		break;
> +	case 2:
> +		READ_FPR(2, __value);
> +		break;
> +	case 3:
> +		READ_FPR(3, __value);
> +		break;
> +	case 4:
> +		READ_FPR(4, __value);
> +		break;
> +	case 5:
> +		READ_FPR(5, __value);
> +		break;
> +	case 6:
> +		READ_FPR(6, __value);
> +		break;
> +	case 7:
> +		READ_FPR(7, __value);
> +		break;
> +	case 8:
> +		READ_FPR(8, __value);
> +		break;
> +	case 9:
> +		READ_FPR(9, __value);
> +		break;
> +	case 10:
> +		READ_FPR(10, __value);
> +		break;
> +	case 11:
> +		READ_FPR(11, __value);
> +		break;
> +	case 12:
> +		READ_FPR(12, __value);
> +		break;
> +	case 13:
> +		READ_FPR(13, __value);
> +		break;
> +	case 14:
> +		READ_FPR(14, __value);
> +		break;
> +	case 15:
> +		READ_FPR(15, __value);
> +		break;
> +	case 16:
> +		READ_FPR(16, __value);
> +		break;
> +	case 17:
> +		READ_FPR(17, __value);
> +		break;
> +	case 18:
> +		READ_FPR(18, __value);
> +		break;
> +	case 19:
> +		READ_FPR(19, __value);
> +		break;
> +	case 20:
> +		READ_FPR(20, __value);
> +		break;
> +	case 21:
> +		READ_FPR(21, __value);
> +		break;
> +	case 22:
> +		READ_FPR(22, __value);
> +		break;
> +	case 23:
> +		READ_FPR(23, __value);
> +		break;
> +	case 24:
> +		READ_FPR(24, __value);
> +		break;
> +	case 25:
> +		READ_FPR(25, __value);
> +		break;
> +	case 26:
> +		READ_FPR(26, __value);
> +		break;
> +	case 27:
> +		READ_FPR(27, __value);
> +		break;
> +	case 28:
> +		READ_FPR(28, __value);
> +		break;
> +	case 29:
> +		READ_FPR(29, __value);
> +		break;
> +	case 30:
> +		READ_FPR(30, __value);
> +		break;
> +	case 31:
> +		READ_FPR(31, __value);
> +		break;
> +	default:
> +		panic("unexpected fd '%d'", fd);

So this is a bit misleading, I was thinking of file descriptors when I 
was reading Feiyang's review comments... maybe something as simple as 
"idx", "num" or "regno" will do?

> +	}
> +#undef READ_FPR
> +	return __value;
> +}
> +
> +static inline void write_fpr(unsigned int fd, unsigned long value)
> +{
> +#define WRITE_FPR(fd, value)		\
> +	__asm__ __volatile__("movgr2fr.d $f"#fd", %0\n\t" :: "r"(value));
> +
> +	switch (fd) {
> +	case 0:
> +		WRITE_FPR(0, value);
> +		break;
> +	case 1:
> +		WRITE_FPR(1, value);
> +		break;
> +	case 2:
> +		WRITE_FPR(2, value);
> +		break;
> +	case 3:
> +		WRITE_FPR(3, value);
> +		break;
> +	case 4:
> +		WRITE_FPR(4, value);
> +		break;
> +	case 5:
> +		WRITE_FPR(5, value);
> +		break;
> +	case 6:
> +		WRITE_FPR(6, value);
> +		break;
> +	case 7:
> +		WRITE_FPR(7, value);
> +		break;
> +	case 8:
> +		WRITE_FPR(8, value);
> +		break;
> +	case 9:
> +		WRITE_FPR(9, value);
> +		break;
> +	case 10:
> +		WRITE_FPR(10, value);
> +		break;
> +	case 11:
> +		WRITE_FPR(11, value);
> +		break;
> +	case 12:
> +		WRITE_FPR(12, value);
> +		break;
> +	case 13:
> +		WRITE_FPR(13, value);
> +		break;
> +	case 14:
> +		WRITE_FPR(14, value);
> +		break;
> +	case 15:
> +		WRITE_FPR(15, value);
> +		break;
> +	case 16:
> +		WRITE_FPR(16, value);
> +		break;
> +	case 17:
> +		WRITE_FPR(17, value);
> +		break;
> +	case 18:
> +		WRITE_FPR(18, value);
> +		break;
> +	case 19:
> +		WRITE_FPR(19, value);
> +		break;
> +	case 20:
> +		WRITE_FPR(20, value);
> +		break;
> +	case 21:
> +		WRITE_FPR(21, value);
> +		break;
> +	case 22:
> +		WRITE_FPR(22, value);
> +		break;
> +	case 23:
> +		WRITE_FPR(23, value);
> +		break;
> +	case 24:
> +		WRITE_FPR(24, value);
> +		break;
> +	case 25:
> +		WRITE_FPR(25, value);
> +		break;
> +	case 26:
> +		WRITE_FPR(26, value);
> +		break;
> +	case 27:
> +		WRITE_FPR(27, value);
> +		break;
> +	case 28:
> +		WRITE_FPR(28, value);
> +		break;
> +	case 29:
> +		WRITE_FPR(29, value);
> +		break;
> +	case 30:
> +		WRITE_FPR(30, value);
> +		break;
> +	case 31:
> +		WRITE_FPR(31, value);
> +		break;
> +	default:
> +		panic("unexpected fd '%d'", fd);
> +	}
> +#undef WRITE_FPR
> +}
> +
> +void emulate_load_store_insn(struct pt_regs *regs, void __user *addr, unsigned int *pc)
> +{
> +	bool user = user_mode(regs);
> +	unsigned int res;
> +	unsigned long origpc;
> +	unsigned long origra;
> +	unsigned long value = 0;
> +	union loongarch_instruction insn;
> +
> +	origpc = (unsigned long)pc;
> +	origra = regs->regs[1];
> +
> +	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, 0);
> +
> +	/*
> +	 * This load never faults.
> +	 */
> +	__get_inst(&insn.word, pc, user);
> +	if (user && !access_ok(addr, 8))
> +		goto sigbus;
> +
> +	if (insn.reg2i12_format.opcode == ldd_op ||
> +		insn.reg2i14_format.opcode == ldptrd_op ||
> +		insn.reg3_format.opcode == ldxd_op) {
> +		res = unaligned_read(addr, &value, 8, 1);
> +		if (res)
> +			goto fault;
> +		regs->regs[insn.reg2i12_format.rd] = value;
> +	} else if (insn.reg2i12_format.opcode == ldw_op ||
> +		insn.reg2i14_format.opcode == ldptrw_op ||
> +		insn.reg3_format.opcode == ldxw_op) {
> +		res = unaligned_read(addr, &value, 4, 1);
> +		if (res)
> +			goto fault;
> +		regs->regs[insn.reg2i12_format.rd] = value;
> +	} else if (insn.reg2i12_format.opcode == ldwu_op ||
> +		insn.reg3_format.opcode == ldxwu_op) {
> +		res = unaligned_read(addr, &value, 4, 0);
> +		if (res)
> +			goto fault;
> +		regs->regs[insn.reg2i12_format.rd] = value;
> +	} else if (insn.reg2i12_format.opcode == ldh_op ||
> +		insn.reg3_format.opcode == ldxh_op) {
> +		res = unaligned_read(addr, &value, 2, 1);
> +		if (res)
> +			goto fault;
> +		regs->regs[insn.reg2i12_format.rd] = value;
> +	} else if (insn.reg2i12_format.opcode == ldhu_op ||
> +		insn.reg3_format.opcode == ldxhu_op) {
> +		res = unaligned_read(addr, &value, 2, 0);
> +		if (res)
> +			goto fault;
> +		regs->regs[insn.reg2i12_format.rd] = value;
> +	} else if (insn.reg2i12_format.opcode == std_op ||
> +		insn.reg2i14_format.opcode == stptrd_op ||
> +		insn.reg3_format.opcode == stxd_op) {
> +		value = regs->regs[insn.reg2i12_format.rd];
> +		res = unaligned_write(addr, value, 8);
> +		if (res)
> +			goto fault;
> +	} else if (insn.reg2i12_format.opcode == stw_op ||
> +		insn.reg2i14_format.opcode == stptrw_op ||
> +		insn.reg3_format.opcode == stxw_op) {
> +		value = regs->regs[insn.reg2i12_format.rd];
> +		res = unaligned_write(addr, value, 4);
> +		if (res)
> +			goto fault;
> +	} else if (insn.reg2i12_format.opcode == sth_op ||
> +		insn.reg3_format.opcode == stxh_op) {
> +		value = regs->regs[insn.reg2i12_format.rd];
> +		res = unaligned_write(addr, value, 2);
> +		if (res)
> +			goto fault;
> +	} else if (insn.reg2i12_format.opcode == fldd_op ||
> +		insn.reg3_format.opcode == fldxd_op) {
> +		res = unaligned_read(addr, &value, 8, 1);
> +		if (res)
> +			goto fault;
> +		write_fpr(insn.reg2i12_format.rd, value);
> +	} else if (insn.reg2i12_format.opcode == flds_op ||
> +		insn.reg3_format.opcode == fldxs_op) {
> +		res = unaligned_read(addr, &value, 4, 1);
> +		if (res)
> +			goto fault;
> +		write_fpr(insn.reg2i12_format.rd, value);
> +	} else if (insn.reg2i12_format.opcode == fstd_op ||
> +		insn.reg3_format.opcode == fstxd_op) {
> +		value = read_fpr(insn.reg2i12_format.rd);
> +		res = unaligned_write(addr, value, 8);
> +		if (res)
> +			goto fault;
> +	} else if (insn.reg2i12_format.opcode == fsts_op ||
> +		insn.reg3_format.opcode == fstxs_op) {
> +		value = read_fpr(insn.reg2i12_format.rd);
> +		res = unaligned_write(addr, value, 4);
> +		if (res)
> +			goto fault;
> +	} else
> +		goto sigbus;
> +
> +
> +#ifdef CONFIG_DEBUG_FS
> +	if (user)
> +		unaligned_instructions_user++;
> +	else
> +		unaligned_instructions_kernel++;
> +#endif
> +
> +	compute_return_era(regs);
> +	return;
> +
> +fault:
> +	/* roll back jump/branch */
> +	regs->csr_era = origpc;
> +	regs->regs[1] = origra;
> +	/* Did we have an exception handler installed? */
> +	if (fixup_exception(regs))
> +		return;
> +
> +	die_if_kernel("Unhandled kernel unaligned access", regs);
> +	force_sig(SIGSEGV);
> +
> +	return;
> +
> +sigbus:
> +	die_if_kernel("Unhandled kernel unaligned access", regs);
> +	force_sig(SIGBUS);
> +
> +	return;
> +}
> +
> +#ifdef CONFIG_DEBUG_FS
> +static int __init debugfs_unaligned(void)
> +{
> +	struct dentry *d;
> +
> +	d = debugfs_create_dir("loongarch", NULL);
> +	if (!d)
> +		return -ENOMEM;
> +
> +	debugfs_create_u32("unaligned_instructions_user",
> +				S_IRUGO, d, &unaligned_instructions_user);
> +	debugfs_create_u32("unaligned_instructions_kernel",
> +				S_IRUGO, d, &unaligned_instructions_kernel);
> +
> +	return 0;
> +}
> +arch_initcall(debugfs_unaligned);
> +#endif
> diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
> index e36635fccb69..867895530340 100644
> --- a/arch/loongarch/lib/Makefile
> +++ b/arch/loongarch/lib/Makefile
> @@ -3,4 +3,4 @@
>   # Makefile for LoongArch-specific library files.
>   #
>   
> -lib-y	+= delay.o clear_user.o copy_user.o dump_tlb.o
> +lib-y	+= delay.o clear_user.o copy_user.o dump_tlb.o unaligned.o
> diff --git a/arch/loongarch/lib/unaligned.S b/arch/loongarch/lib/unaligned.S
> new file mode 100644
> index 000000000000..03210cb5a18d
> --- /dev/null
> +++ b/arch/loongarch/lib/unaligned.S
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/linkage.h>
> +
> +#include <asm/asm.h>
> +#include <asm/asmmacro.h>
> +#include <asm/errno.h>
> +#include <asm/export.h>
> +#include <asm/regdef.h>
> +
> +.macro fixup_ex from, to, fix
> +.if \fix
> +	.section .fixup, "ax"
> +\to:	li.w	a0, -EFAULT
> +	jr	ra
> +	.previous
> +.endif
> +	.section __ex_table, "a"
> +	PTR	\from\()b, \to\()b
> +	.previous
> +.endm
> +
> +/*
> + * unsigned long unaligned_read(void *addr, void *value, unsigned long n, bool sign)
> + *
> + * a0: addr
> + * a1: value
> + * a2: n
> + * a3: sign
> + */
> +SYM_FUNC_START(unaligned_read)
> +	beqz	a2, 5f
> +
> +	li.w	t1, 8
> +	li.w	t2, 0
> +
> +	addi.d	t0, a2, -1
> +	mul.d	t1, t0, t1

Remove the `t1 = 8` above, then `slli.d t1, t0, 3` here would be enough 
and one cycle is saved.

> +	add.d 	a0, a0, t0
> +
> +	beq	a3, zero, 2f

beqz

> +1:	ld.b	t3, a0, 0
> +	b	3f
> +
> +2:	ld.bu	t3, a0, 0
> +3:	sll.d	t3, t3, t1
> +	or	t2, t2, t3
> +	addi.d	t1, t1, -8 > +	addi.d	a0, a0, -1
> +	addi.d	a2, a2, -1
> +	bgt	a2, zero, 2b

bgtz

> +4:	st.d	t2, a1, 0
> +
> +	move	a0, a2
> +	jr	ra
> +
> +5:	li.w    a0, -EFAULT
> +	jr	ra
> +
> +	fixup_ex 1, 6, 1
> +	fixup_ex 2, 6, 0
> +	fixup_ex 4, 6, 0
> +SYM_FUNC_END(unaligned_read)
> +
> +/*
> + * unsigned long unaligned_write(void *addr, unsigned long value, unsigned long n)
> + *
> + * a0: addr
> + * a1: value
> + * a2: n
> + */
> +SYM_FUNC_START(unaligned_write)
> +	beqz	a2, 3f
> +
> +	li.w	t0, 0
> +1:	srl.d	t1, a1, t0
> +2:	st.b	t1, a0, 0
> +	addi.d	t0, t0, 8
> +	addi.d	a2, a2, -1
> +	addi.d	a0, a0, 1
> +	bgt	a2, zero, 1b

bgtz

> +
> +	move	a0, a2
> +	jr	ra
> +
> +3:	li.w    a0, -EFAULT
> +	jr	ra
> +
> +	fixup_ex 2, 4, 1
> +SYM_FUNC_END(unaligned_write)

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/


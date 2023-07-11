Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB3174F6A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjGKRLQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 13:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjGKRLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:11:14 -0400
Received: from 7.mo575.mail-out.ovh.net (7.mo575.mail-out.ovh.net [46.105.63.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AA610EA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:11:10 -0700 (PDT)
Received: from director6.ghost.mail-out.ovh.net (unknown [10.108.20.179])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 0775F27100
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 17:11:09 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-bkgm2 (unknown [10.110.171.164])
        by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id A740F1FDBC;
        Tue, 11 Jul 2023 17:11:08 +0000 (UTC)
Received: from courmont.net ([37.59.142.97])
        by ghost-submission-6684bf9d7b-bkgm2 with ESMTPSA
        id ZjJqGCyNrWRlpgEA9KjMjw
        (envelope-from <remi@remlab.net>); Tue, 11 Jul 2023 17:11:08 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-97G00266ae0be0-e4c4-4064-a372-6bb5d03d63ba,
                    BD5993DD31A8D185A8BDB9FDB50A3FED214DC06B) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp: 87.92.194.88
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/12] riscv: Add support for kernel mode vector
Date:   Tue, 11 Jul 2023 20:11:07 +0300
Message-ID: <6573575.5kvhTvEP53@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20230711153743.1970625-2-heiko@sntech.de>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230711153743.1970625-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 10172505658820401627
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrfedtgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkfhojghfggfgtgesthhqredttddtjeenucfhrhhomheptformhhiucffvghnihhsqdevohhurhhmohhnthcuoehrvghmihesrhgvmhhlrggsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhfegfeefvdefueetleefffduuedvjeefheduueekieeltdetueetueeugfevffenucffohhmrghinheprhgvmhhlrggsrdhnvghtnecukfhppeduvdejrddtrddtrddupdekjedrledvrdduleegrdekkedpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgvmhhisehrvghmlhgrsgdrnhgvtheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeehpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

Le tiistaina 11. heinäkuuta 2023, 18.37.32 EEST Heiko Stuebner a écrit :
> From: Greentime Hu <greentime.hu@sifive.com>
> 
> Add kernel_rvv_begin() and kernel_rvv_end() function declarations
> and corresponding definitions in kernel_mode_vector.c
> 
> These are needed to wrap uses of vector in kernel mode.
> 
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/include/asm/vector.h        |  17 ++++
>  arch/riscv/kernel/Makefile             |   1 +
>  arch/riscv/kernel/kernel_mode_vector.c | 132 +++++++++++++++++++++++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 arch/riscv/kernel/kernel_mode_vector.c
> 
> diff --git a/arch/riscv/include/asm/vector.h
> b/arch/riscv/include/asm/vector.h index 3d78930cab51..ac2c23045eec 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -196,6 +196,23 @@ static inline void __switch_to_vector(struct
> task_struct *prev, void riscv_v_vstate_ctrl_init(struct task_struct *tsk);
>  bool riscv_v_vstate_ctrl_user_allowed(void);
> 
> +static inline void riscv_v_flush_cpu_state(void)
> +{
> +	asm volatile (
> +		".option push\n\t"
> +		".option arch, +v\n\t"
> +		"vsetvli	t0, x0, e8, m8, ta, ma\n\t"
> +		"vmv.v.i	v0, 0\n\t"
> +		"vmv.v.i	v8, 0\n\t"
> +		"vmv.v.i	v16, 0\n\t"
> +		"vmv.v.i	v24, 0\n\t"
> +		".option pop\n\t"
> +		: : : "t0");

Why bother with zeroing out the vectors before kernel use? That sounds like it 
will only hide bugs in kernel code - implicitly assuming that everything is 
initially zero. Ditto initialising the vector configuration; if you really want 
to have a fixed initial value rather than "leak" whatever user set, better use 
an invalid configuration (vill=1), IMO.

> +}
> +
> +void kernel_rvv_begin(void);
> +void kernel_rvv_end(void);
> +
>  #else /* ! CONFIG_RISCV_ISA_V  */
> 
>  struct pt_regs;
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 506cc4a9a45a..3f4435746af7 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_MMU) += vdso.o vdso/
>  obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o
>  obj-$(CONFIG_FPU)		+= fpu.o
>  obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
> +obj-$(CONFIG_RISCV_ISA_V)	+= kernel_mode_vector.o
>  obj-$(CONFIG_SMP)		+= smpboot.o
>  obj-$(CONFIG_SMP)		+= smp.o
>  obj-$(CONFIG_SMP)		+= cpu_ops.o
> diff --git a/arch/riscv/kernel/kernel_mode_vector.c
> b/arch/riscv/kernel/kernel_mode_vector.c new file mode 100644
> index 000000000000..2d704190c054
> --- /dev/null
> +++ b/arch/riscv/kernel/kernel_mode_vector.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2012 ARM Ltd.
> + * Author: Catalin Marinas <catalin.marinas@arm.com>
> + * Copyright (C) 2017 Linaro Ltd. <ard.biesheuvel@linaro.org>
> + * Copyright (C) 2021 SiFive
> + */
> +#include <linux/compiler.h>
> +#include <linux/irqflags.h>
> +#include <linux/percpu.h>
> +#include <linux/preempt.h>
> +#include <linux/types.h>
> +
> +#include <asm/vector.h>
> +#include <asm/switch_to.h>
> +
> +DECLARE_PER_CPU(bool, vector_context_busy);
> +DEFINE_PER_CPU(bool, vector_context_busy);
> +
> +/*
> + * may_use_vector - whether it is allowable at this time to issue vector
> + *                instructions or access the vector register file
> + *
> + * Callers must not assume that the result remains true beyond the next
> + * preempt_enable() or return from softirq context.
> + */
> +static __must_check inline bool may_use_vector(void)
> +{
> +	/*
> +	 * vector_context_busy is only set while preemption is disabled,
> +	 * and is clear whenever preemption is enabled. Since
> +	 * this_cpu_read() is atomic w.r.t. preemption, vector_context_busy
> +	 * cannot change under our feet -- if it's set we cannot be
> +	 * migrated, and if it's clear we cannot be migrated to a CPU
> +	 * where it is set.
> +	 */
> +	return !in_irq() && !irqs_disabled() && !in_nmi() &&
> +	       !this_cpu_read(vector_context_busy);
> +}
> +
> +/*
> + * Claim ownership of the CPU vector context for use by the calling
> context. + *
> + * The caller may freely manipulate the vector context metadata until
> + * put_cpu_vector_context() is called.
> + */
> +static void get_cpu_vector_context(void)
> +{
> +	bool busy;
> +
> +	preempt_disable();
> +	busy = __this_cpu_xchg(vector_context_busy, true);
> +
> +	WARN_ON(busy);
> +}
> +
> +/*
> + * Release the CPU vector context.
> + *
> + * Must be called from a context in which get_cpu_vector_context() was
> + * previously called, with no call to put_cpu_vector_context() in the
> + * meantime.
> + */
> +static void put_cpu_vector_context(void)
> +{
> +	bool busy = __this_cpu_xchg(vector_context_busy, false);
> +
> +	WARN_ON(!busy);
> +	preempt_enable();
> +}
> +
> +/*
> + * kernel_rvv_begin(): obtain the CPU vector registers for use by the
> calling + * context
> + *
> + * Must not be called unless may_use_vector() returns true.
> + * Task context in the vector registers is saved back to memory as
> necessary. + *
> + * A matching call to kernel_rvv_end() must be made before returning from
> the + * calling context.
> + *
> + * The caller may freely use the vector registers until kernel_rvv_end() is
> + * called.
> + */
> +void kernel_rvv_begin(void)
> +{
> +	if (WARN_ON(!has_vector()))
> +		return;
> +
> +	WARN_ON(!may_use_vector());
> +
> +	/* Acquire kernel mode vector */
> +	get_cpu_vector_context();
> +
> +	/* Save vector state, if any */
> +	riscv_v_vstate_save(current, task_pt_regs(current));
> +
> +	/* Enable vector */
> +	riscv_v_enable();
> +
> +	/* Invalidate vector regs */
> +	riscv_v_flush_cpu_state();
> +}
> +EXPORT_SYMBOL_GPL(kernel_rvv_begin);
> +
> +/*
> + * kernel_rvv_end(): give the CPU vector registers back to the current task
> + *
> + * Must be called from a context in which kernel_rvv_begin() was previously
> + * called, with no call to kernel_rvv_end() in the meantime.
> + *
> + * The caller must not use the vector registers after this function is
> called, + * unless kernel_rvv_begin() is called again in the meantime.
> + */
> +void kernel_rvv_end(void)
> +{
> +	if (WARN_ON(!has_vector()))
> +		return;
> +
> +	/* Invalidate vector regs */
> +	riscv_v_flush_cpu_state();
> +
> +	/* Restore vector state, if any */
> +	riscv_v_vstate_restore(current, task_pt_regs(current));

I thought that the kernel was already nuking user vectors on every system 
call, since the RVV spec says so.

Are you trying to use vectors from interrupts? Otherwise, isn't this flush & 
restore superfluous?

> +
> +	/* disable vector */
> +	riscv_v_disable();
> +
> +	/* release kernel mode vector */
> +	put_cpu_vector_context();
> +}
> +EXPORT_SYMBOL_GPL(kernel_rvv_end);


-- 
雷米‧德尼-库尔蒙
http://www.remlab.net/




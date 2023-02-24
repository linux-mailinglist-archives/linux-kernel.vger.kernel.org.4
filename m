Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD416A186B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjBXJAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjBXJAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:00:16 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D662163A3B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:00:12 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j2so12970624wrh.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JfbFvgMHMXh5R5bJNhmXm8/75pCWi7sHWu3XP2LXyVw=;
        b=fZdycC8RuwUJG2eZPMQyHptdaGo4UgygIJG2mssmJHOAOHkwQeRLTgYKkGu4mW4lbL
         LjF4+EFDAg/2//JHQBkHrmIH5SVsijtayKYjHSfcmrhCeI19rJacqd+Eje7IwqI6+vwg
         nEOSVwejKqb+jB4gf/yTcVA0d7vo0aCBZ1rgsLwi3PEL7mIMpXLMc8ptxGFxmK622isL
         h7aQ9jXW9Jkwh341F9Onx+m/uLzS08LNwKZ/zsKMXy6BCs9bQvASMaNvpnMfh+mw18O3
         Am+N4s0dC/ArXzGZ+TzmyXiwAMWqbRgeLRY08oUh0giZFfmsis1GdD5S0aaHIJtKyrnm
         52ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfbFvgMHMXh5R5bJNhmXm8/75pCWi7sHWu3XP2LXyVw=;
        b=jZevCsWHmwfIunqM1iDHidZh9r2Zr0OUlTraaLrkSSoh7DdGn02E43kFkrPtWe8Vk8
         4DkIn9HeEOnRD6zp1Qw6dUQQlcR5CrF90rEJvskGBroKigz3WeenJbPwnHXsb9O4A9Fh
         zzqOv/bmu+FBomoaS+ucIPQcXnTiiUIhbPVhS2cT8lCALJfDJoy3/5lvDwbptu7cGp/H
         dXtkN1vf1SxUbjYgR5I751cVrpZ4O1fK868HvGSuiH+zcHKFVV+B/1nfa0fcMv2LZK4W
         tOdknvqcRIk29gyNDj6dpyGU0WS4Cnln8tvsVxplNVKQgpgyfax6z3+w7xwe+8Qy1cX3
         aAlQ==
X-Gm-Message-State: AO0yUKVo+CsiNPGXD7nEd6WgONq3HMSo5dOYnhE+yMnUF6T2To2o98YY
        wgDrSe2FiSUCNKf5770A9k+Ltw==
X-Google-Smtp-Source: AK7set+YlCeacHd5gYPR7CAW3SDPPzTAnWzxEWJULhrSeM6GiUWyJM10Hae1yg87OR4DmzhEDDnGZw==
X-Received: by 2002:a5d:5651:0:b0:2c3:f78f:518f with SMTP id j17-20020a5d5651000000b002c3f78f518fmr12820937wrw.39.1677229211354;
        Fri, 24 Feb 2023 01:00:11 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c219100b003e7f1086660sm2065227wme.15.2023.02.24.01.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 01:00:11 -0800 (PST)
Date:   Fri, 24 Feb 2023 10:00:10 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v4 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Message-ID: <20230224090010.nmy6latszfkdqcft@orel>
References: <20230221023523.1498500-1-jeeheng.sia@starfivetech.com>
 <20230221023523.1498500-5-jeeheng.sia@starfivetech.com>
 <20230223180720.55fgbxzlx6xvzgms@orel>
 <b26264a20b5f4bc5abfc6dd87aa4e38f@EXMBX066.cuchost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b26264a20b5f4bc5abfc6dd87aa4e38f@EXMBX066.cuchost.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 02:05:43AM +0000, JeeHeng Sia wrote:
> 
> 
> > -----Original Message-----
> > From: Andrew Jones <ajones@ventanamicro.com>
> > Sent: Friday, 24 February, 2023 2:07 AM
> > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> > Subject: Re: [PATCH v4 4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> > 
> > On Tue, Feb 21, 2023 at 10:35:23AM +0800, Sia Jee Heng wrote:
> > > Low level Arch functions were created to support hibernation.
> > > swsusp_arch_suspend() relies code from __cpu_suspend_enter() to write
> > > cpu state onto the stack, then calling swsusp_save() to save the memory
> > > image.
> > >
> > > Arch specific hibernation header is implemented and is utilized by the
> > > arch_hibernation_header_restore() and arch_hibernation_header_save()
> > > functions. The arch specific hibernation header consists of satp, hartid,
> > > and the cpu_resume address. The kernel built version is also need to be
> > > saved into the hibernation image header to making sure only the same
> > > kernel is restore when resume.
> > >
> > > swsusp_arch_resume() creates a temporary page table that covering only
> > > the linear map. It copies the restore code to a 'safe' page, then start
> > > to restore the memory image. Once completed, it restores the original
> > > kernel's page table. It then calls into __hibernate_cpu_resume()
> > > to restore the CPU context. Finally, it follows the normal hibernation
> > > path back to the hibernation core.
> > >
> > > To enable hibernation/suspend to disk into RISCV, the below config
> > > need to be enabled:
> > > - CONFIG_ARCH_HIBERNATION_HEADER
> > > - CONFIG_ARCH_HIBERNATION_POSSIBLE
> > >
> > > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > > Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> > > ---
> > >  arch/riscv/Kconfig                 |   7 +
> > >  arch/riscv/include/asm/assembler.h |  20 ++
> > >  arch/riscv/include/asm/suspend.h   |  19 ++
> > >  arch/riscv/kernel/Makefile         |   1 +
> > >  arch/riscv/kernel/asm-offsets.c    |   5 +
> > >  arch/riscv/kernel/hibernate-asm.S  |  77 +++++
> > >  arch/riscv/kernel/hibernate.c      | 447 +++++++++++++++++++++++++++++
> > >  7 files changed, 576 insertions(+)
> > >  create mode 100644 arch/riscv/kernel/hibernate-asm.S
> > >  create mode 100644 arch/riscv/kernel/hibernate.c
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index e2b656043abf..4555848a817f 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -690,6 +690,13 @@ menu "Power management options"
> > >
> > >  source "kernel/power/Kconfig"
> > >
> > > +config ARCH_HIBERNATION_POSSIBLE
> > > +	def_bool y
> > > +
> > > +config ARCH_HIBERNATION_HEADER
> > > +	def_bool y
> > > +	depends on HIBERNATION
> > 
> > nit: I think this can be simplified as def_bool HIBERNATION
> good suggestion. will change it.
> > 
> > > +
> > >  endmenu # "Power management options"
> > >
> > >  menu "CPU Power Management"
> > > diff --git a/arch/riscv/include/asm/assembler.h b/arch/riscv/include/asm/assembler.h
> > > index 727a97735493..68c46c0e0ea8 100644
> > > --- a/arch/riscv/include/asm/assembler.h
> > > +++ b/arch/riscv/include/asm/assembler.h
> > > @@ -59,4 +59,24 @@
> > >  		REG_L	s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
> > >  	.endm
> > >
> > > +/*
> > > + * copy_page - copy 1 page (4KB) of data from source to destination
> > > + * @a0 - destination
> > > + * @a1 - source
> > > + */
> > > +	.macro	copy_page a0, a1
> > > +		lui	a2, 0x1
> > > +		add	a2, a2, a0
> > > +1 :
> >     ^ please remove this space
> can't remove it otherwise checkpatch will throws ERROR: spaces required around that ':'

Oh, right, labels in macros have this requirement.

> > 
> > > +		REG_L	t0, 0(a1)
> > > +		REG_L	t1, SZREG(a1)
> > > +
> > > +		REG_S	t0, 0(a0)
> > > +		REG_S	t1, SZREG(a0)
> > > +
> > > +		addi	a0, a0, 2 * SZREG
> > > +		addi	a1, a1, 2 * SZREG
> > > +		bne	a2, a0, 1b
> > > +	.endm
> > > +
> > >  #endif	/* __ASM_ASSEMBLER_H */
> > > diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
> > > index 75419c5ca272..3362da56a9d8 100644
> > > --- a/arch/riscv/include/asm/suspend.h
> > > +++ b/arch/riscv/include/asm/suspend.h
> > > @@ -21,6 +21,11 @@ struct suspend_context {
> > >  #endif
> > >  };
> > >
> > > +/*
> > > + * Used by hibernation core and cleared during resume sequence
> > > + */
> > > +extern int in_suspend;
> > > +
> > >  /* Low-level CPU suspend entry function */
> > >  int __cpu_suspend_enter(struct suspend_context *context);
> > >
> > > @@ -36,4 +41,18 @@ int __cpu_resume_enter(unsigned long hartid, unsigned long context);
> > >  /* Used to save and restore the csr */
> > >  void suspend_save_csrs(struct suspend_context *context);
> > >  void suspend_restore_csrs(struct suspend_context *context);
> > > +
> > > +/* Low-level API to support hibernation */
> > > +int swsusp_arch_suspend(void);
> > > +int swsusp_arch_resume(void);
> > > +int arch_hibernation_header_save(void *addr, unsigned int max_size);
> > > +int arch_hibernation_header_restore(void *addr);
> > > +int __hibernate_cpu_resume(void);
> > > +
> > > +/* Used to resume on the CPU we hibernated on */
> > > +int hibernate_resume_nonboot_cpu_disable(void);
> > > +
> > > +asmlinkage void hibernate_restore_image(unsigned long resume_satp, unsigned long satp_temp,
> > > +					unsigned long cpu_resume);
> > > +asmlinkage int hibernate_core_restore_code(void);
> > >  #endif
> > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > > index 4cf303a779ab..daab341d55e4 100644
> > > --- a/arch/riscv/kernel/Makefile
> > > +++ b/arch/riscv/kernel/Makefile
> > > @@ -64,6 +64,7 @@ obj-$(CONFIG_MODULES)		+= module.o
> > >  obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
> > >
> > >  obj-$(CONFIG_CPU_PM)		+= suspend_entry.o suspend.o
> > > +obj-$(CONFIG_HIBERNATION)	+= hibernate.o hibernate-asm.o
> > >
> > >  obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
> > >  obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
> > > diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> > > index df9444397908..d6a75aac1d27 100644
> > > --- a/arch/riscv/kernel/asm-offsets.c
> > > +++ b/arch/riscv/kernel/asm-offsets.c
> > > @@ -9,6 +9,7 @@
> > >  #include <linux/kbuild.h>
> > >  #include <linux/mm.h>
> > >  #include <linux/sched.h>
> > > +#include <linux/suspend.h>
> > >  #include <asm/kvm_host.h>
> > >  #include <asm/thread_info.h>
> > >  #include <asm/ptrace.h>
> > > @@ -116,6 +117,10 @@ void asm_offsets(void)
> > >
> > >  	OFFSET(SUSPEND_CONTEXT_REGS, suspend_context, regs);
> > >
> > > +	OFFSET(HIBERN_PBE_ADDR, pbe, address);
> > > +	OFFSET(HIBERN_PBE_ORIG, pbe, orig_address);
> > > +	OFFSET(HIBERN_PBE_NEXT, pbe, next);
> > > +
> > >  	OFFSET(KVM_ARCH_GUEST_ZERO, kvm_vcpu_arch, guest_context.zero);
> > >  	OFFSET(KVM_ARCH_GUEST_RA, kvm_vcpu_arch, guest_context.ra);
> > >  	OFFSET(KVM_ARCH_GUEST_SP, kvm_vcpu_arch, guest_context.sp);
> > > diff --git a/arch/riscv/kernel/hibernate-asm.S b/arch/riscv/kernel/hibernate-asm.S
> > > new file mode 100644
> > > index 000000000000..846affe4dced
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/hibernate-asm.S
> > > @@ -0,0 +1,77 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Hibernation low level support for RISCV.
> > > + *
> > > + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> > > + *
> > > + * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
> > > + */
> > > +
> > > +#include <asm/asm.h>
> > > +#include <asm/asm-offsets.h>
> > > +#include <asm/assembler.h>
> > > +#include <asm/csr.h>
> > > +
> > > +#include <linux/linkage.h>
> > > +
> > > +/*
> > > + * int __hibernate_cpu_resume(void)
> > > + * Switch back to the hibernated image's page table prior to restoring the CPU
> > > + * context.
> > > + *
> > > + * Always returns 0
> > > + */
> > > +ENTRY(__hibernate_cpu_resume)
> > > +	/* switch to hibernated image's page table. */
> > > +	csrw CSR_SATP, s0
> > > +	sfence.vma
> > > +
> > > +	REG_L	a0, hibernate_cpu_context
> > > +
> > > +	restore_csr
> > > +	restore_reg
> > > +
> > > +	/* Return zero value. */
> > > +	add	a0, zero, zero
> > 
> > nit: mv a0, zero
> sure
> > 
> > > +
> > > +	ret
> > > +END(__hibernate_cpu_resume)
> > > +
> > > +/*
> > > + * Prepare to restore the image.
> > > + * a0: satp of saved page tables.
> > > + * a1: satp of temporary page tables.
> > > + * a2: cpu_resume.
> > > + */
> > > +ENTRY(hibernate_restore_image)
> > > +	mv	s0, a0
> > > +	mv	s1, a1
> > > +	mv	s2, a2
> > > +	REG_L	s4, restore_pblist
> > > +	REG_L	a1, relocated_restore_code
> > > +
> > > +	jalr	a1
> > > +END(hibernate_restore_image)
> > > +
> > > +/*
> > > + * The below code will be executed from a 'safe' page.
> > > + * It first switches to the temporary page table, then starts to copy the pages
> > > + * back to the original memory location. Finally, it jumps to __hibernate_cpu_resume()
> > > + * to restore the CPU context.
> > > + */
> > > +ENTRY(hibernate_core_restore_code)
> > > +	/* switch to temp page table. */
> > > +	csrw satp, s1
> > > +	sfence.vma
> > > +.Lcopy:
> > > +	/* The below code will restore the hibernated image. */
> > > +	REG_L	a1, HIBERN_PBE_ADDR(s4)
> > > +	REG_L	a0, HIBERN_PBE_ORIG(s4)
> > 
> > Are we sure restore_pblist will never be NULL?
> restore_pblist is a link-list, it will be null during initialization or during page clean up by hibernation core. During the initial resume process, the hibernation core will check the header and load the pages. If everything works correctly, the page will be linked to the restore_pblist and then invoke swsusp_arch_resume() else hibernation core will throws error and failed to resume from the hibernated image.

I know restore_pblist is a linked-list and this doesn't answer the
question. The comment above restore_pblist says

/*
 * List of PBEs needed for restoring the pages that were allocated before
 * the suspend and included in the suspend image, but have also been
 * allocated by the "resume" kernel, so their contents cannot be written
 * directly to their "original" page frames.
 */

which implies the pages that end up on this list are "special". My
question is whether or not we're guaranteed to have at least one
of these special pages. If not, we shouldn't assume s4 is non-null.
If so, then a comment stating why that's guaranteed would be nice.

> > 
> > > +
> > > +	copy_page a0, a1
> > > +
> > > +	REG_L	s4, HIBERN_PBE_NEXT(s4)
> > > +	bnez	s4, .Lcopy
> > > +
> > > +	jalr	s2
> > > +END(hibernate_core_restore_code)
> > > diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.c
> > > new file mode 100644
> > > index 000000000000..46a2f470db6e
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/hibernate.c
> > > @@ -0,0 +1,447 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Hibernation support for RISCV
> > > + *
> > > + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> > > + *
> > > + * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
> > > + */
> > > +
> > > +#include <asm/barrier.h>
> > > +#include <asm/cacheflush.h>
> > > +#include <asm/mmu_context.h>
> > > +#include <asm/page.h>
> > > +#include <asm/pgalloc.h>
> > > +#include <asm/pgtable.h>
> > > +#include <asm/sections.h>
> > > +#include <asm/set_memory.h>
> > > +#include <asm/smp.h>
> > > +#include <asm/suspend.h>
> > > +
> > > +#include <linux/cpu.h>
> > > +#include <linux/memblock.h>
> > > +#include <linux/pm.h>
> > > +#include <linux/sched.h>
> > > +#include <linux/suspend.h>
> > > +#include <linux/utsname.h>
> > > +
> > > +/* The logical cpu number we should resume on, initialised to a non-cpu number. */
> > > +static int sleep_cpu = -EINVAL;
> > > +
> > > +/* Pointer to the temporary resume page table. */
> > > +static pgd_t *resume_pg_dir;
> > > +
> > > +/* CPU context to be saved. */
> > > +struct suspend_context *hibernate_cpu_context;
> > > +EXPORT_SYMBOL_GPL(hibernate_cpu_context);
> > > +
> > > +unsigned long relocated_restore_code;
> > > +EXPORT_SYMBOL_GPL(relocated_restore_code);
> > > +
> > > +/**
> > > + * struct arch_hibernate_hdr_invariants - container to store kernel build version.
> > > + * @uts_version: to save the build number and date so that the we do not resume with
> > > + *		a different kernel.
> > > + */
> > > +struct arch_hibernate_hdr_invariants {
> > > +	char		uts_version[__NEW_UTS_LEN + 1];
> > > +};
> > > +
> > > +/**
> > > + * struct arch_hibernate_hdr - helper parameters that help us to restore the image.
> > > + * @invariants: container to store kernel build version.
> > > + * @hartid: to make sure same boot_cpu executes the hibernate/restore code.
> > > + * @saved_satp: original page table used by the hibernated image.
> > > + * @restore_cpu_addr: the kernel's image address to restore the CPU context.
> > > + */
> > > +static struct arch_hibernate_hdr {
> > > +	struct arch_hibernate_hdr_invariants invariants;
> > > +	unsigned long	hartid;
> > > +	unsigned long	saved_satp;
> > > +	unsigned long	restore_cpu_addr;
> > > +} resume_hdr;
> > > +
> > > +static inline void arch_hdr_invariants(struct arch_hibernate_hdr_invariants *i)
> > > +{
> > > +	memset(i, 0, sizeof(*i));
> > > +	memcpy(i->uts_version, init_utsname()->version, sizeof(i->uts_version));
> > > +}
> > > +
> > > +/*
> > > + * Check if the given pfn is in the 'nosave' section.
> > > + */
> > > +int pfn_is_nosave(unsigned long pfn)
> > > +{
> > > +	unsigned long nosave_begin_pfn = sym_to_pfn(&__nosave_begin);
> > > +	unsigned long nosave_end_pfn = sym_to_pfn(&__nosave_end - 1);
> > > +
> > > +	return ((pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn));
> > > +}
> > > +
> > > +void notrace save_processor_state(void)
> > > +{
> > > +	WARN_ON(num_online_cpus() != 1);
> > > +}
> > > +
> > > +void notrace restore_processor_state(void)
> > > +{
> > > +}
> > > +
> > > +/*
> > > + * Helper parameters need to be saved to the hibernation image header.
> > > + */
> > > +int arch_hibernation_header_save(void *addr, unsigned int max_size)
> > > +{
> > > +	struct arch_hibernate_hdr *hdr = addr;
> > > +
> > > +	if (max_size < sizeof(*hdr))
> > > +		return -EOVERFLOW;
> > > +
> > > +	arch_hdr_invariants(&hdr->invariants);
> > > +
> > > +	hdr->hartid = cpuid_to_hartid_map(sleep_cpu);
> > > +	hdr->saved_satp = csr_read(CSR_SATP);
> > > +	hdr->restore_cpu_addr = (unsigned long)__hibernate_cpu_resume;
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(arch_hibernation_header_save);
> > > +
> > > +/*
> > > + * Retrieve the helper parameters from the hibernation image header.
> > > + */
> > > +int arch_hibernation_header_restore(void *addr)
> > > +{
> > > +	struct arch_hibernate_hdr_invariants invariants;
> > > +	struct arch_hibernate_hdr *hdr = addr;
> > > +	int ret = 0;
> > > +
> > > +	arch_hdr_invariants(&invariants);
> > > +
> > > +	if (memcmp(&hdr->invariants, &invariants, sizeof(invariants))) {
> > > +		pr_crit("Hibernate image not generated by this kernel!\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	sleep_cpu = riscv_hartid_to_cpuid(hdr->hartid);
> > > +	if (sleep_cpu < 0) {
> > > +		pr_crit("Hibernated on a CPU not known to this kernel!\n");
> > > +		sleep_cpu = -EINVAL;
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +#ifdef CONFIG_SMP
> > > +	ret = bringup_hibernate_cpu(sleep_cpu);
> > > +	if (ret) {
> > > +		sleep_cpu = -EINVAL;
> > > +		return ret;
> > > +	}
> > > +#endif
> > > +	resume_hdr = *hdr;
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(arch_hibernation_header_restore);
> > > +
> > > +int swsusp_arch_suspend(void)
> > > +{
> > > +	int ret = 0;
> > > +
> > > +	if (__cpu_suspend_enter(hibernate_cpu_context)) {
> > > +		sleep_cpu = smp_processor_id();
> > > +		suspend_save_csrs(hibernate_cpu_context);
> > > +		ret = swsusp_save();
> > > +	} else {
> > > +		suspend_restore_csrs(hibernate_cpu_context);
> > > +		flush_tlb_all();
> > > +		flush_icache_all();
> > > +
> > > +		/*
> > > +		 * Tell the hibernation core that we've just restored the memory.
> > > +		 */
> > > +		in_suspend = 0;
> > > +		sleep_cpu = -EINVAL;
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static unsigned long _temp_pgtable_map_pte(pte_t *dst_ptep, pte_t *src_ptep,
> > > +					   unsigned long addr, pgprot_t prot)
> > > +{
> > > +	pte_t pte = READ_ONCE(*src_ptep);
> > > +
> > > +	if (pte_present(pte))
> > > +		set_pte(dst_ptep, __pte(pte_val(pte) | pgprot_val(prot)));
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static unsigned long temp_pgtable_map_pte(pmd_t *dst_pmdp, pmd_t *src_pmdp,
> > > +					  unsigned long start, unsigned long end,
> > > +					  pgprot_t prot)
> > > +{
> > > +	unsigned long addr = start;
> > > +	pte_t *src_ptep;
> > > +	pte_t *dst_ptep;
> > > +
> > > +	if (pmd_none(READ_ONCE(*dst_pmdp))) {
> > > +		dst_ptep = (pte_t *)get_safe_page(GFP_ATOMIC);
> > > +		if (!dst_ptep)
> > > +			return -ENOMEM;
> > > +
> > > +		pmd_populate_kernel(NULL, dst_pmdp, dst_ptep);
> > > +	}
> > > +
> > > +	dst_ptep = pte_offset_kernel(dst_pmdp, start);
> > > +	src_ptep = pte_offset_kernel(src_pmdp, start);
> > > +
> > > +	do {
> > > +		_temp_pgtable_map_pte(dst_ptep, src_ptep, addr, prot);
> > 
> > I think I'd rather have the body of _temp_pgtable_map_pte() here and drop
> > the helper, because the helper does (pte_val(pte) | pgprot_val(prot))
> > which looks strange, until seeing here that 'pte' is only the address
> > bits, so OR'ing in new prot bits without clearing old prot bits makes
> > sense.
> we do not need to clear the old bits since we going to keep those bits but add new bits which are required for resume. Let's hold your question here but I will would like to see how Alex view it.

I confused myself a bit in my first read, so some of what I said isn't
relevant, but I still wonder why we don't want to be more explicit about
what prot bits are present in the end, and I still wonder why we need such
a simple helper function which is used in exactly one place. Indeed, the
pattern of all the other pgtable functions below is to put the set_p*
calls directly in the loop.

Thanks,
drew

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D588E6E515A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjDQUAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjDQUAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:00:38 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11D7C9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 13:00:35 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s23-20020a17090aba1700b00247a8f0dd50so3131516pjr.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681761635; x=1684353635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WxaNTv+G45R6AGfd4FQ/tQ0s93uY3PGqLlYvVLo3WBA=;
        b=5fA9inL6WwOrSojtYS4LJaO0732iVo+lr4Xmd3CqVuRbbEnrOFBJTzb4ZJtAzEeEg9
         PKW4CVDorREYU3FhrrnYFIumQy/wkTiGY7BQ4bLCSy6YlYac1nIezMUhfVs7cdXxAYaI
         DZHMD7a0cXc3r0NXJcMStwYc/x4tLLtsLDzMv+0iVpiXhnYww435S80etzHK/jYM21M+
         q74F7qeGLEcXAaxIB3r7kUTgMwZezh+Tv1jGy/1XNb2jS3Y5cUUs5jxkV6bCvxhNqMP+
         OmKuUXT3gjGPOGAnqq3FtgVBTQsUfeGodZRZy76X5eM3JqG5m7WH2ohpw/Dg7FjsNlxV
         93Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681761635; x=1684353635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WxaNTv+G45R6AGfd4FQ/tQ0s93uY3PGqLlYvVLo3WBA=;
        b=AZ4V1mFSZIVshflI0g6XQi92x7WOgdCmznDjPXQFPEGAfGAxG3jorhpf+45I1ZuGjR
         2wjgTGZKv0FwXBzlcjA16Orciibfw9lZqCjxGR2BzBm+61MGbPONVx86aYjR7UrFyj6R
         w3/w4HbixHp2HritbMYE/Th+Dg0e1N5GQDciKt8z3MUMn0yK5I4USLIDbSDfXt/nXjMG
         0/S+ULLvps+2PNC3aS98/uItIE7Gzj7qLWO+DdhZF8aphlyRct7D+4bCQaqC7IGByMc1
         QbK9wIOyOQ6pbMHCkNi57PYB5PhD+a3NSSyCriICxPGghB+peuKZZnmLL8bxMDevMuGF
         w63w==
X-Gm-Message-State: AAQBX9fWzDRAZlNy78TOS6eqcHjWfklq29HSoGT5MocMFa6fy9BAavry
        RZIN7dKjVk6Wa8CUsYA/MFd8hA==
X-Google-Smtp-Source: AKy350YSEpd+CB+RkSnnzxQ1QIpKvO2z7awmJ3Gud0PHw4ibgRYlQKUXur6RflH0L3ocMoEuOky//w==
X-Received: by 2002:a17:903:1ce:b0:1a0:50bd:31bf with SMTP id e14-20020a17090301ce00b001a050bd31bfmr116558plh.32.1681761635097;
        Mon, 17 Apr 2023 13:00:35 -0700 (PDT)
Received: from x1 ([2607:fb90:33a8:2783:544f:e61d:6278:b35f])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001a1d4a985eesm8081487pld.228.2023.04.17.13.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:00:34 -0700 (PDT)
Date:   Mon, 17 Apr 2023 13:04:11 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        James Morse <james.morse@arm.com>,
        Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>
Subject: Re: [RFC PATCH 2/2] RISC-V: Add support for sqoscfg CSR
Message-ID: <ZD2mO/2BH9Zo3iqO@x1>
References: <20230410043646.3138446-1-dfustini@baylibre.com>
 <20230410043646.3138446-3-dfustini@baylibre.com>
 <20230417-culinary-capillary-4f1efd496691@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230417-culinary-capillary-4f1efd496691@spud>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 08:10:20PM +0100, Conor Dooley wrote:
> Hey Drew,
> 
> (Don't get your hopes up, I don't have anything really meaningful to
> contribute, sorry.)

Hi, thanks for the feedback...

> 
> On Sun, Apr 09, 2023 at 09:36:46PM -0700, Drew Fustini wrote:
> > Add support for the sqoscfg CSR defined in the Ssqosid ISA extension
> > (Supervisor-mode Quality of Service ID). The CSR contains two fields:
> > 
> >   - Resource Control ID (RCID) used determine resource allocation
> >   - Monitoring Counter ID (MCID) used to track resource usage
> > 
> > Requests from a hart to shared resources like cache will be tagged with
> > these IDs. This allows the usage of shared resources to be associated
> > with the task currently running on the hart.
> > 
> > A sqoscfg field is added to thread_struct and has the same format as the
> > sqoscfg CSR. This allows the scheduler to set the hart's sqoscfg CSR to
> > contain the RCID and MCID for the task that is being scheduled in. The
> > sqoscfg CSR is only written to if the thread_struct.sqoscfg is different
> > from the current value of the CSR.
> > 
> > A per-cpu variable cpu_sqoscfg is used to mirror that state of the CSR.
> > This is because access to L1D hot memory should be several times faster
> > than a CSR read. Also, in the case of virtualization, accesses to this
> > CSR are trapped in the hypervisor.
> > 
> > Link: https://github.com/riscv-non-isa/riscv-cmqri/blob/main/riscv-cbqri.pdf
> > Co-developed-by: Kornel Dulęba <mindal@semihalf.com>
> > Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
> > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > ---
> > Note: the Ssqosid extension and CBQRI spec are still in a draft state.
> > The CSR address of sqoscfg is not final.
> > 
> > Changes from the original patch [1]:
> > - Rebase from 6.0 to 6.3
> > - Simplify per-cpu variable from struct to u32 with just sqoscfg
> > - Move qoscfg to thread_struct in arch/riscv/include/asm/processor.h
> >   This avoids changing task_struct in /include/linux/sched.h
> > - Reword commit description
> > - Reword Kconfig description
> > 
> > [1] https://github.com/rivosinc/linux/commit/8454b793a62be21d39e5826ef5241dfa06198ba9
> > 
> >  arch/riscv/Kconfig                 | 19 ++++++++++++++
> >  arch/riscv/include/asm/csr.h       |  8 ++++++
> >  arch/riscv/include/asm/processor.h |  3 +++
> >  arch/riscv/include/asm/qos.h       | 40 ++++++++++++++++++++++++++++++
> >  arch/riscv/include/asm/switch_to.h |  2 ++
> >  5 files changed, 72 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/qos.h
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index cc02eb9eee1f..03f22b7fe34b 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -418,6 +418,25 @@ config RISCV_ISA_SVNAPOT
> >  
> >  	  If you don't know what to do here, say Y.
> >  
> > +config RISCV_ISA_SSQOSID
> > +	bool "Ssqosid extension support"
> > +	default y
> > +	help
> > +	  Adds support for the Ssqosid ISA extension (Supervisor-mode
> > +	  Quality of Service ID).
> 
> Could you add "long form" text in brackets here to the bool line, a la:
> https://patchwork.kernel.org/project/linux-riscv/patch/20230405-pucker-cogwheel-3a999a94a2f2@wendy/

Thanks, that is a good idea. It would make it easier for the person
using menuconfig as they won't have to access the help screen just to
see what the acronym stands for.

> > +
> > +	  Ssqosid defines the sqoscfg CSR which allows the system to tag
> > +	  the running process with RCID (Resource Control ID) and MCID
> > +	  (Monitoring Counter ID). The RCID is used determine resource
> > +	  allocation. The MCID is used to track resource usage in event
> > +	  counters.
> > +
> > +	  For example, a cache controller may use the RCID to apply a
> > +	  cache partitioning scheme and use the MCID to track how much
> > +	  cache a process, or a group of processes, is using.
> > +
> > +	  If you don't know what to do here, say Y.
> > +
> >  config RISCV_ISA_SVPBMT
> >  	bool "SVPBMT extension support"
> >  	depends on 64BIT && MMU
> > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> > index 7c2b8cdb7b77..17d04a0cacd6 100644
> > --- a/arch/riscv/include/asm/csr.h
> > +++ b/arch/riscv/include/asm/csr.h
> > @@ -59,6 +59,13 @@
> >  #define SATP_ASID_MASK	_AC(0xFFFF, UL)
> >  #endif
> >  
> > +/* SQOSCFG fields */
> > +#define SQOSCFG_RCID_MASK	_AC(0x00000FFF, UL)
> > +#define SQOSCFG_MCID_MASK	SQOSCFG_RCID_MASK
> > +#define SQOSCFG_MCID_SHIFT	16
> > +#define SQOSCFG_MASK		((SQOSCFG_MCID_MASK << SQOSCFG_MCID_SHIFT) | \
> > +				  SQOSCFG_RCID_MASK)
> > +
> >  /* Exception cause high bit - is an interrupt if set */
> >  #define CAUSE_IRQ_FLAG		(_AC(1, UL) << (__riscv_xlen - 1))
> >  
> > @@ -245,6 +252,7 @@
> >  #define CSR_STVAL		0x143
> >  #define CSR_SIP			0x144
> >  #define CSR_SATP		0x180
> > +#define CSR_SQOSCFG		0x181
> >  
> >  #define CSR_STIMECMP		0x14D
> >  #define CSR_STIMECMPH		0x15D
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > index 94a0590c6971..724b2aa2732d 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -39,6 +39,9 @@ struct thread_struct {
> >  	unsigned long s[12];	/* s[0]: frame pointer */
> >  	struct __riscv_d_ext_state fstate;
> >  	unsigned long bad_cause;
> > +#ifdef CONFIG_RISCV_ISA_SSQOSID
> > +	u32 sqoscfg;
> > +#endif
> >  };
> >  
> >  /* Whitelist the fstate from the task_struct for hardened usercopy */
> > diff --git a/arch/riscv/include/asm/qos.h b/arch/riscv/include/asm/qos.h
> > new file mode 100644
> > index 000000000000..297e7fb64d80
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/qos.h
> > @@ -0,0 +1,40 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_RISCV_QOS_H
> > +#define _ASM_RISCV_QOS_H
> > +
> > +#ifdef CONFIG_RISCV_ISA_SSQOSID
> > +
> > +#include <linux/sched.h>
> > +#include <linux/jump_label.h>
> > +
> > +#include <asm/barrier.h>
> > +#include <asm/csr.h>
> > +#include <asm/hwcap.h>
> > +
> > +/* cached value of sqoscfg csr for each cpu */
> > +static DEFINE_PER_CPU(u32, cpu_sqoscfg);
> > +
> > +static void __qos_sched_in(struct task_struct *task)
> > +{
> > +	u32 *cpu_sqoscfg_ptr = this_cpu_ptr(&cpu_sqoscfg);
> > +	u32 thread_sqoscfg;
> > +
> > +	thread_sqoscfg = READ_ONCE(task->thread.sqoscfg);
> > +
> > +	if (thread_sqoscfg != *cpu_sqoscfg_ptr) {
> > +		*cpu_sqoscfg_ptr = thread_sqoscfg;
> > +		csr_write(CSR_SQOSCFG, thread_sqoscfg);
> > +	}
> > +}
> > +
> > +static inline void qos_sched_in(struct task_struct *task)
> 
> "qos" is a pretty generic prefix, no? Do you think we'd be better off
> prefixing this (and every other extension related thing) with `riscv_`?

That's a fair point. No harm in adding the 'riscv_' to make the context
clearer.

> 
> > +{
> > +	if (riscv_has_extension_likely(RISCV_ISA_EXT_SSQOSID))
> > +		__qos_sched_in(task);
> > +}
> > +#else
> > +
> > +static inline void qos_sched_in(struct task_struct *task) {}
> > +
> > +#endif /* CONFIG_RISCV_ISA_SSQOSID */
> > +#endif /* _ASM_RISCV_QOS_H */
> > diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> > index 60f8ca01d36e..75d9bfd766af 100644
> > --- a/arch/riscv/include/asm/switch_to.h
> > +++ b/arch/riscv/include/asm/switch_to.h
> > @@ -12,6 +12,7 @@
> >  #include <asm/processor.h>
> >  #include <asm/ptrace.h>
> >  #include <asm/csr.h>
> > +#include <asm/qos.h>
> >  
> >  #ifdef CONFIG_FPU
> >  extern void __fstate_save(struct task_struct *save_to);
> > @@ -79,6 +80,7 @@ do {							\
> >  	if (has_fpu())					\
> >  		__switch_to_aux(__prev, __next);	\
> >  	((last) = __switch_to(__prev, __next));		\
> > +	qos_sched_in(__next);				\
> 
> Both FPU and vector do:
> |	if (has_fpu())					\
> |		__switch_to_fpu(__prev, __next);	\
> |	if (has_vector())				\
> |		__switch_to_vector(__prev, __next);	\
> 
> Is it just my OCD that wants ssqosid to be the same?

Thanks, I had not noticed those changes from the vector patch series [1]
until you pointed it out. The handling of sqoscfg could be converted to
that pattern too.

> It'd also do away with that seems a bit weird to me: having
> qos_sched_in() and __qos_sched_in().
> Even if you don't make them similar, what's the rationale behind not
> inverting the extension check & returning early from a single function.

The goal was so the inline qos_sched_in() would turn into a nop when
Ssqosid extensions not present. If Ssqosid was present, then the "real"
function __qos_sched_in() would be called.

However, having looked at the handling of fpu and vector in the vector
series, I think will redo the sqoscfg handling to follow that pattern.

thanks,
drew

[1] https://lore.kernel.org/linux-riscv/20230414155843.12963-1-andy.chiu@sifive.com/

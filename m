Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C2974BF18
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 22:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjGHUIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 16:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjGHUIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 16:08:32 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1FEE48
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 13:08:30 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso33836635e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 13:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688846909; x=1691438909;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RutQ4CSyC9TMr9OE2a03oHahhhRmfTREbUHdgKMwcBQ=;
        b=SDKM1Pt0Uk1meylrVDxtQ2rRGXQyRYtuUJYZQkAile9hNlPw6snzlAxeTWYn4xqg4Y
         Yet81FByUNgWcVBqafPwz+P9cP6mI4yLyNSejvd8nJYQARA7zPC3I0yVyAfgZSd/ih1J
         ctdTky6pbszsOHiPkETExtpXcyRQ9fbGzkjjrcEABTFzGDtfOD+e13SRa2MeM9D0hwH6
         9GsCj/iCE6Ke0gXX0FYLA4W/2vWQN2/aLcatNm0seybMyw+YMKZLm4vOWyF/HU5UL1fI
         W6iW2Mz9FEz+CYtKHh6ilATibkTkEoD68474sLUBBKHDwrBpM6b8pQlytF8QFaShBGuW
         g6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688846909; x=1691438909;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RutQ4CSyC9TMr9OE2a03oHahhhRmfTREbUHdgKMwcBQ=;
        b=Ly3vOIPp8JzSOUoKMaX/UcNAc1hWEyUHtxo4BH6K4iBtOzg6QNEVqUWQ6Sv0RVY1BB
         vpQEtKhBd3DZb6Q4dUDuJCeGOo+8Vpc0YE/heYgELR6Qf4onbXIV194J9HUKZsddrXW1
         lEoD0igv5fvN2emhh1ESNK52qgO4r2TJOsOi3nBeWd6D7EMQvmiv3PZ3CdRLM94lvnUp
         z5BYtZCGwyVk+y1GBkaEuHLLXswBfL5i36zdWnA7zcq963QEmpjzKbzDMJ00BUPWy3tn
         DdMpZBjIF8U6wSE0Rd2N4rGpIpPWeiyWyJ5xT2KTMiBrTV4PmxyEUZjzoxll2HK6Y3bR
         zT6w==
X-Gm-Message-State: ABy/qLaUfHSTuSs5dtHF5XXtpMRh3mBpEGauFIP5Y6ii3BgTtvnO1E0J
        TGoh5dDtkrdshNBCgjDWV6jiOQCNN5BYCZI0
X-Google-Smtp-Source: APBJJlEVHeGucCDusdHSciNe08Puajo5ZfAOhD6vXo6erWS6pYqUUCMj+LPo+6BVYJGjG4CLcf3Iww==
X-Received: by 2002:a05:600c:214e:b0:3f8:fc2a:c7eb with SMTP id v14-20020a05600c214e00b003f8fc2ac7ebmr6640538wml.5.1688846908474;
        Sat, 08 Jul 2023 13:08:28 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id w4-20020a5d6084000000b00314374145e0sm7576192wrt.67.2023.07.08.13.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 13:08:27 -0700 (PDT)
Date:   Sat, 8 Jul 2023 21:08:26 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 PATCH 3/9] riscv: add support for misaligned handling in
 S-mode
Message-ID: <ZKnCOs0uyzdt7UFf@antec>
References: <20230704140924.315594-1-cleger@rivosinc.com>
 <20230704140924.315594-4-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230704140924.315594-4-cleger@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 04:09:18PM +0200, Clément Léger wrote:
> Misalignment handling is only supported for M-mode and uses direct
> accesses to user memory. in S-mode, this requires to use the
> get_user()/put_user() accessors. Implement load_u8(), store_u8() and
> get_insn() using these accessors.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/kernel/Makefile           |   2 +-
>  arch/riscv/kernel/traps.c            |   7 --
>  arch/riscv/kernel/traps_misaligned.c | 118 ++++++++++++++++++++++++---
>  3 files changed, 106 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 153864e4f399..79b8dafc699d 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -55,10 +55,10 @@ obj-y	+= riscv_ksyms.o
>  obj-y	+= stacktrace.o
>  obj-y	+= cacheinfo.o
>  obj-y	+= patch.o
> +obj-y	+= traps_misaligned.o
>  obj-y	+= probes/
>  obj-$(CONFIG_MMU) += vdso.o vdso/
>  
> -obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o

I think it would be better to combine this wath with "[PATCH 2/9] riscv: avoid
missing prototypes warning" from the series to avoid the breakage on commit 2/9.

Also, it would be a bit more clear of the intent.

>  obj-$(CONFIG_FPU)		+= fpu.o
>  obj-$(CONFIG_SMP)		+= smpboot.o
>  obj-$(CONFIG_SMP)		+= smp.o
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 7fcaf2fd27a1..b2fb2266fb83 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -149,12 +149,6 @@ DO_ERROR_INFO(do_trap_insn_illegal,
>  	SIGILL, ILL_ILLOPC, "illegal instruction");
>  DO_ERROR_INFO(do_trap_load_fault,
>  	SIGSEGV, SEGV_ACCERR, "load access fault");
> -#ifndef CONFIG_RISCV_M_MODE
> -DO_ERROR_INFO(do_trap_load_misaligned,
> -	SIGBUS, BUS_ADRALN, "Oops - load address misaligned");
> -DO_ERROR_INFO(do_trap_store_misaligned,
> -	SIGBUS, BUS_ADRALN, "Oops - store (or AMO) address misaligned");
> -#else
>  
>  asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
>  {
> @@ -197,7 +191,6 @@ asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs
>  		irqentry_nmi_exit(regs, state);
>  	}
>  }
> -#endif
>  DO_ERROR_INFO(do_trap_store_fault,
>  	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault");
>  DO_ERROR_INFO(do_trap_ecall_s,
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 0cccac4822a8..9daed7d756ae 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -152,21 +152,25 @@
>  #define PRECISION_S 0
>  #define PRECISION_D 1
>  
> -static inline u8 load_u8(const u8 *addr)
> +#ifdef CONFIG_RISCV_M_MODE
> +static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
>  {
>  	u8 val;
>  
>  	asm volatile("lbu %0, %1" : "=&r" (val) : "m" (*addr));
> +	*r_val = val;
>  
> -	return val;
> +	return 0;
>  }
>  
> -static inline void store_u8(u8 *addr, u8 val)
> +static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
>  {
>  	asm volatile ("sb %0, %1\n" : : "r" (val), "m" (*addr));
> +
> +	return 0;
>  }
>  
> -static inline ulong get_insn(ulong mepc)
> +static inline int get_insn(struct pt_regs *regs, ulong mepc, ulong *r_insn)
>  {
>  	register ulong __mepc asm ("a2") = mepc;
>  	ulong val, rvc_mask = 3, tmp;
> @@ -195,9 +199,87 @@ static inline ulong get_insn(ulong mepc)
>  	: [addr] "r" (__mepc), [rvc_mask] "r" (rvc_mask),
>  	  [xlen_minus_16] "i" (XLEN_MINUS_16));
>  
> -	return val;
> +	*r_insn = val;
> +
> +	return 0;
> +}
> +#else
> +static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
> +{
> +	if (user_mode(regs)) {
> +		return __get_user(*r_val, addr);
> +	} else {
> +		*r_val = *addr;
> +		return 0;
> +	}
>  }
>  
> +static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
> +{
> +	if (user_mode(regs)) {
> +		return __put_user(val, addr);
> +	} else {
> +		*addr = val;
> +		return 0;
> +	}
> +}
> +
> +#define __read_insn(regs, insn, insn_addr)		\
> +({							\
> +	int __ret;					\
> +							\
> +	if (user_mode(regs)) {				\
> +		__ret = __get_user(insn, insn_addr);	\
> +	} else {					\
> +		insn = *insn_addr;			\
> +		__ret = 0;				\
> +	}						\
> +							\
> +	__ret;						\
> +})
> +
> +static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
> +{
> +	ulong insn = 0;
> +
> +	if (epc & 0x2) {
> +		ulong tmp = 0;
> +		u16 __user *insn_addr = (u16 __user *)epc;
> +
> +		if (__read_insn(regs, insn, insn_addr))
> +			return -EFAULT;
> +		/* __get_user() uses regular "lw" which sign extend the loaded
> +		 * value make sure to clear higher order bits in case we "or" it
> +		 * below with the upper 16 bits half.
> +		 */
> +		insn &= GENMASK(15, 0);
> +		if ((insn & __INSN_LENGTH_MASK) != __INSN_LENGTH_32) {
> +			*r_insn = insn;
> +			return 0;
> +		}
> +		insn_addr++;
> +		if (__read_insn(regs, tmp, insn_addr))
> +			return -EFAULT;
> +		*r_insn = (tmp << 16) | insn;
> +
> +		return 0;
> +	} else {
> +		u32 __user *insn_addr = (u32 __user *)epc;
> +
> +		if (__read_insn(regs, insn, insn_addr))
> +			return -EFAULT;
> +		if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) {
> +			*r_insn = insn;
> +			return 0;
> +		}
> +		insn &= GENMASK(15, 0);
> +		*r_insn = insn;
> +
> +		return 0;
> +	}
> +}
> +#endif
> +
>  union reg_data {
>  	u8 data_bytes[8];
>  	ulong data_ulong;
> @@ -208,10 +290,13 @@ int handle_misaligned_load(struct pt_regs *regs)
>  {
>  	union reg_data val;
>  	unsigned long epc = regs->epc;
> -	unsigned long insn = get_insn(epc);
> -	unsigned long addr = csr_read(mtval);
> +	unsigned long insn;
> +	unsigned long addr = regs->badaddr;

Could your commit messages talk a bit about the change from using mtval to
regs->badaddr?  Will this sill work in M-mode? I think so, but it would be good
to explain the change.

>  	int i, fp = 0, shift = 0, len = 0;
>  
> +	if (get_insn(regs, epc, &insn))
> +		return -1;
> +
>  	regs->epc = 0;
>  
>  	if ((insn & INSN_MASK_LW) == INSN_MATCH_LW) {
> @@ -275,8 +360,10 @@ int handle_misaligned_load(struct pt_regs *regs)
>  	}
>  
>  	val.data_u64 = 0;
> -	for (i = 0; i < len; i++)
> -		val.data_bytes[i] = load_u8((void *)(addr + i));
> +	for (i = 0; i < len; i++) {
> +		if (load_u8(regs, (void *)(addr + i), &val.data_bytes[i]))
> +			return -1;
> +	}
>  
>  	if (fp)
>  		return -1;
> @@ -291,10 +378,13 @@ int handle_misaligned_store(struct pt_regs *regs)
>  {
>  	union reg_data val;
>  	unsigned long epc = regs->epc;
> -	unsigned long insn = get_insn(epc);
> -	unsigned long addr = csr_read(mtval);
> +	unsigned long insn;
> +	unsigned long addr = regs->badaddr;
>  	int i, len = 0;
>  
> +	if (get_insn(regs, epc, &insn))
> +		return -1;
> +
>  	regs->epc = 0;
>  
>  	val.data_ulong = GET_RS2(insn, regs);
> @@ -328,8 +418,10 @@ int handle_misaligned_store(struct pt_regs *regs)
>  		return -1;
>  	}
>  
> -	for (i = 0; i < len; i++)
> -		store_u8((void *)(addr + i), val.data_bytes[i]);
> +	for (i = 0; i < len; i++) {
> +		if (store_u8(regs, (void *)(addr + i), val.data_bytes[i]))
> +			return -1;
> +	}
>  
>  	regs->epc = epc + INSN_LEN(insn);
>  
> -- 
> 2.40.1
> 

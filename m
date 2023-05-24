Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6B871013D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 01:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbjEXXAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 19:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjEXXAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 19:00:47 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B47C90
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:00:45 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d5b4c3ffeso1152387b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1684969244; x=1687561244;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aP4wl0B3gMFtKwigEP6w6ZWg4toXUNvzcDPT8WkLcJ4=;
        b=D16tKsqwt8ymbXwwtHZDxDwjMoVstOsTHYlaQ4TqV5Qh30VV/Jiq6JvD1WIbuA4uMy
         7lOzq8K+mUVFWPYEPDT8sN1XdFDmjxLzMyKcIbfX6tkgVGWMDsGppbLnJJ1+Kriuq6y6
         eWiA8gF3ZfeOaLcW2pKOpba1Bhhd9yJNBBvnrKc9Dx5v5zXIjdr7ARi97ucds38wxNxQ
         5Z4CjsFopqJpOzJPeh33sZvjeSYSfGhwA55JHbdLKR2ZXkPvAUy6l/tUfLpJdsLw/vTJ
         e+OJ1AhoqOTw8K81S64ntexOzGaDoh9wncFmY6iEXRWDTlfLjv5cOyYBJy2/7tU140DD
         0aEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684969244; x=1687561244;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aP4wl0B3gMFtKwigEP6w6ZWg4toXUNvzcDPT8WkLcJ4=;
        b=CrsNsJ7uajxILIkY7L/GFVCmO/ZIpsR+OvQ+D5KPX6kH1LZGVNvQAMR9wTxUTCbg12
         y2yvDrgmNzLG+XLdPymYP9ewxVbF6/DKXX/2pQanZ6N30OEqtxSnu/zmmiMKsRI3DYkj
         FZjvbyycwwGVaa8yIWla6Ru5DNt3Y0JToHEEGEGZ0tmy7d2KKaycNe5GRwgJW9AmjpYM
         QhfB/gwWSgPFkI2nhWd63HhfHA2z57wNG0LB++hxNKkyaNhE5If7ltpl6lyK5Af55ynD
         rTqKF7IjehPdbeNuyyVxT8dMTxRqCQ2nvv+UqaWZQbJvZORFIZcTaOFriHBMKZFFkGuR
         HcBg==
X-Gm-Message-State: AC+VfDzHgjOZOuGkMyW2YnHSSvJqf9iRDaIOMA5RiK4Qi9FOuexXxsRo
        J9s36I+IwRF3Qky2cRXacpefPg==
X-Google-Smtp-Source: ACHHUZ5COTwlsixURQDkRzyT235CuG7mn1HDc2r7mgHwC2IPVd3gmPFiie75TLHuf5LKrRLJApCnLA==
X-Received: by 2002:a05:6a20:3ca7:b0:103:e735:d157 with SMTP id b39-20020a056a203ca700b00103e735d157mr21455907pzj.59.1684969244330;
        Wed, 24 May 2023 16:00:44 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id x7-20020a056a00270700b0062bc045bf4fsm228pfv.19.2023.05.24.16.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 16:00:43 -0700 (PDT)
Date:   Wed, 24 May 2023 16:00:43 -0700 (PDT)
X-Google-Original-Date: Wed, 24 May 2023 16:00:17 PDT (-0700)
Subject:     Re: [PATCH v3 2/2] riscv: Add Zawrs support for spinlocks
In-Reply-To: <20230524-35efcabbbfd6a1ef83865fb4@orel>
CC:     heiko@sntech.de, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, christoph.muellner@vrull.eu,
        David.Laight@aculab.com, heiko.stuebner@vrull.eu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ajones@ventanamicro.com
Message-ID: <mhng-d92f84d8-03db-4fb1-93c3-0d5bfbe7a796@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 10:05:52 PDT (-0700), ajones@ventanamicro.com wrote:
> On Sun, May 21, 2023 at 01:47:15PM +0200, Heiko Stuebner wrote:
>> From: Christoph Müllner <christoph.muellner@vrull.eu>
>>
>> The current RISC-V code uses the generic ticket lock implementation,
>> that calls the macros smp_cond_load_relaxed() and smp_cond_load_acquire().
>> Currently, RISC-V uses the generic implementation of these macros.
>> This patch introduces a RISC-V specific implementation, of these
>> macros, that peels off the first loop iteration
>
> I guess this peeling off of the first iteration is because it's expected
> that the load generated by READ_ONCE() is more efficient than lr.w/d? If
> we're worried about unnecessary use of lr.w/d, then shouldn't we look
> for a solution that doesn't issue those instructions when we don't have
> the Zawrs extension?

It's actually just a consequence of how the Linux hooks are described: 
they're macros that take a C expression to test in the loop, and we 
can't handle C expressions in LR/SC loops as that'd require compiler 
support and nobody's figured out how to do that correctly yet (there 
were some patches, but they had issues).  So we need to do this awkward 
bit of checking without the reservation and then waiting with the 
reservation.

That's kind of a clunky pattern, so happy to hear if you've got a better 
idea.  It's been a year or so since I looked at this last, and from 
looking at the spec I'd need to go dig into the "valid reservations in 
non-constrained loops" bit to see if we can get away with something.  
The semantics aren't clear from just one read of the spec.

Another option would be to call out the common cases of smp_cond_load_* 
as explicit hooks, with generic implementations that just do the C 
expression.  There's only a few of these calls in the kernel and they 
fall into a few patterns, so we might just need ==0, !=0, and 
!=long-in-register.

>> and modifies the waiting
>> loop such, that it is possible to use the WRS.STO instruction of the Zawrs
>> ISA extension to stall the CPU.
>>
>> The resulting implementation of smp_cond_load_*() will only work for
>> 32-bit or 64-bit types for RV64 and 32-bit types for RV32.
>> This is caused by the restrictions of the LR instruction (RISC-V only
>> has LR.W and LR.D). Compiler assertions guard this new restriction.
>>
>> This patch uses the existing RISC-V ISA extension framework
>> to detect the presence of Zawrs at run-time.
>> If available a NOP instruction will be replaced by WRS.NTO or WRS.STO.

I haven't looked at the patch, but I'd expect we NOP out the whole 
LR/WRS sequence?  I don't remember any reason to have the load 
reservation without the WRS, but it's been a while so I might be 
forgetting something.

If we do need the LR, we should really then we replacing the WRS with an 
SC instead to avoid a dangling reservation as IIRC those have a 
performance hit on the SiFive cores (and presumably anyone else who 
locks cache lines).

>>
>> The whole mechanism is gated by Kconfig setting, which defaults to Y.
>>
>> The Zawrs specification can be found here:
>> https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc

IIUC it's ratified?  HEAD is kind of an odd commit saying it's ratified 
and changing some text: 
https://github.com/riscv/riscv-zawrs/commit/861483d99eedc60cbe9fd2ceb18dbf28d0905c9c 

>>
>> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
>> [rebase, update to review comments]
>> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
>> ---
>>  arch/riscv/Kconfig                   | 10 +++++
>>  arch/riscv/include/asm/barrier.h     | 64 ++++++++++++++++++++++++++++
>>  arch/riscv/include/asm/errata_list.h | 14 ++++++
>>  arch/riscv/include/asm/hwcap.h       |  1 +
>>  arch/riscv/kernel/cpu.c              |  1 +
>>  arch/riscv/kernel/cpufeature.c       |  1 +
>>  6 files changed, 91 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 348c0fa1fc8c..60ff303ff58a 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -460,6 +460,16 @@ config RISCV_ISA_SVPBMT
>>
>>  	   If you don't know what to do here, say Y.
>>
>> +config RISCV_ISA_ZAWRS
>> +	bool "Zawrs extension support"
>
> This should be "Zawrs extension support for ..."
>
>> +	depends on RISCV_ALTERNATIVE
>> +	default y
>> +	help
>> +	   Adds support to dynamically detect the presence of the Zawrs extension
>> +	   (wait for reservation set) and enable its usage.
>> +
>> +	   If you don't know what to do here, say Y.
>> +
>>  config TOOLCHAIN_HAS_ZBB
>>  	bool
>>  	default y
>> diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
>> index 110752594228..bd64cfe5ae10 100644
>> --- a/arch/riscv/include/asm/barrier.h
>> +++ b/arch/riscv/include/asm/barrier.h
>> @@ -12,6 +12,8 @@
>>
>>  #ifndef __ASSEMBLY__
>>
>> +#include <asm/errata_list.h>
>> +
>>  #define nop()		__asm__ __volatile__ ("nop")
>>  #define __nops(n)	".rept	" #n "\nnop\n.endr\n"
>>  #define nops(n)		__asm__ __volatile__ (__nops(n))
>> @@ -44,6 +46,36 @@ do {									\
>>  	___p1;								\
>>  })
>>
>> +#define ___smp_load_reservedN(pfx, ptr)					\
>> +({									\
>> +	typeof(*ptr) ___p1;						\
>> +	__asm__ __volatile__ ("lr." pfx "	%[p], %[c]\n"		\
>> +			      : [p]"=&r" (___p1), [c]"+A"(*ptr));	\
>> +	___p1;								\
>> +})
>> +
>> +#define __smp_load_reserved_relaxed(ptr)				\
>> +({									\
>> +	typeof(*ptr) ___p1;						\
>> +	if (sizeof(*ptr) == sizeof(int))				\
>> +		___p1 = ___smp_load_reservedN("w", ptr);		\
>> +	else if (sizeof(*ptr) == sizeof(long))				\
>> +		___p1 = ___smp_load_reservedN("d", ptr);		\
>> +	else								\
>> +		compiletime_assert(0,					\
>> +			"Need type compatible with LR/SC instructions "	\
>> +			"for " __stringify(ptr));			\
>> +	___p1;								\
>
> It's more common to use a switch for these things, embedding the
> lr.w/d asm in each case, something like the macros in
> arch/riscv/include/asm/cmpxchg.h. Can we stick with that pattern?
>
>> +})
>> +
>> +#define __smp_load_reserved_acquire(ptr)				\
>> +({									\
>> +	typeof(*ptr) ___p1;						\
>> +	___p1 = __smp_load_reserved_relaxed(ptr);			\
>> +	RISCV_FENCE(r, rw);						\
>> +	___p1;								\
>> +})
>> +
>>  /*
>>   * This is a very specific barrier: it's currently only used in two places in
>>   * the kernel, both in the scheduler.  See include/linux/spinlock.h for the two
>> @@ -71,6 +103,38 @@ do {									\
>>   */
>>  #define smp_mb__after_spinlock()	RISCV_FENCE(iorw,iorw)
>>
>> +#define smp_cond_load_relaxed(ptr, cond_expr)				\
>> +({									\
>> +	typeof(ptr) __PTR = (ptr);					\
>> +	__unqual_scalar_typeof(*ptr) VAL;				\
>> +	VAL = READ_ONCE(*__PTR);					\
>> +	if (!cond_expr) {						\
>> +		for (;;) {						\
>> +			VAL = __smp_load_reserved_relaxed(__PTR);	\
>> +			if (cond_expr)					\
>> +				break;					\
>> +			ALT_WRS_STO();					\
>> +		}							\
>> +	}								\
>> +	(typeof(*ptr))VAL;						\
>> +})
>> +
>> +#define smp_cond_load_acquire(ptr, cond_expr)				\
>> +({									\
>> +	typeof(ptr) __PTR = (ptr);					\
>> +	__unqual_scalar_typeof(*ptr) VAL;				\
>> +	VAL = smp_load_acquire(__PTR);					\
>> +	if (!cond_expr) {						\
>> +		for (;;) {						\
>> +			VAL = __smp_load_reserved_acquire(__PTR);	\
>> +			if (cond_expr)					\
>> +				break;					\
>> +			ALT_WRS_STO();					\
>> +		}							\
>> +	}								\
>> +	(typeof(*ptr))VAL;						\
>> +})
>> +
>>  #include <asm-generic/barrier.h>
>>
>>  #endif /* __ASSEMBLY__ */
>> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
>> index fb1a810f3d8c..36a72a07d62c 100644
>> --- a/arch/riscv/include/asm/errata_list.h
>> +++ b/arch/riscv/include/asm/errata_list.h
>> @@ -44,6 +44,20 @@ asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
>>  		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
>>  		: : "r" (addr) : "memory")
>>
>> +#define ZAWRS_WRS_NTO	".long 0x00d00073"
>> +#define ALT_WRS_NTO()							\
>> +asm volatile(ALTERNATIVE(						\
>> +	"nop\n\t",							\
>> +	ZAWRS_WRS_NTO "\n\t",						\
>> +	0, RISCV_ISA_EXT_ZAWRS, CONFIG_RISCV_ISA_ZAWRS))
>
> We don't use this. Do we need to define it now?
>
>> +
>> +#define ZAWRS_WRS_STO	".long 0x01d00073"
>
> I'd prefer we use insn-def.h to define instructions, rather than scatter
> .long's around, but since this instruction doesn't have any inputs, then
> I guess it's not so important to use insn-def.h.
>
>> +#define ALT_WRS_STO()							\
>> +asm volatile(ALTERNATIVE(						\
>> +	"nop\n\t",							\
>> +	ZAWRS_WRS_STO "\n\t",						\
>> +	0, RISCV_ISA_EXT_ZAWRS, CONFIG_RISCV_ISA_ZAWRS))
>> +
>
> These alternatives aren't supporting errata, so putting them in
> errata_list.h doesn't seem appropriate. I think cpufeature.h
> would be better.
>
>>  /*
>>   * _val is marked as "will be overwritten", so need to set it to 0
>>   * in the default case.
>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>> index e0c40a4c63d5..4233d87539ab 100644
>> --- a/arch/riscv/include/asm/hwcap.h
>> +++ b/arch/riscv/include/asm/hwcap.h
>> @@ -46,6 +46,7 @@
>>  #define RISCV_ISA_EXT_ZICBOZ		34
>>  #define RISCV_ISA_EXT_SMAIA		35
>>  #define RISCV_ISA_EXT_SSAIA		36
>> +#define RISCV_ISA_EXT_ZAWRS		37
>>
>>  #define RISCV_ISA_EXT_MAX		64
>>  #define RISCV_ISA_EXT_NAME_LEN_MAX	32
>> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
>> index c96aa56cf1c7..ac9c604d8936 100644
>> --- a/arch/riscv/kernel/cpu.c
>> +++ b/arch/riscv/kernel/cpu.c
>> @@ -184,6 +184,7 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
>>  	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
>>  	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
>>  	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>> +	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
>>  	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
>>  	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
>>  	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index b1d6b7e4b829..d4a22a7aed99 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -236,6 +236,7 @@ void __init riscv_fill_hwcap(void)
>>  				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
>>  				SET_ISA_EXT_MAP("svnapot", RISCV_ISA_EXT_SVNAPOT);
>>  				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
>> +				SET_ISA_EXT_MAP("zawrs", RISCV_ISA_EXT_ZAWRS);
>>  				SET_ISA_EXT_MAP("zbb", RISCV_ISA_EXT_ZBB);
>>  				SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
>>  				SET_ISA_EXT_MAP("zicboz", RISCV_ISA_EXT_ZICBOZ);
>> --
>> 2.39.0
>>
>
> Thanks,
> drew

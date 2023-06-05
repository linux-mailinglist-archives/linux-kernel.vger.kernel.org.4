Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C112A7224D9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjFELo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjFELoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6251BDF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685965416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MQUlV/DSEwcUdtFGZI4Rkk19WX9clmv+BXCW6uCxtEg=;
        b=cedoSN5XzFdNpugUjM+Fjaik9uhpA29NmtycD6ZNSiQHbpLuli/nGsE0Z9Zq8eUSHtBSWi
        pwNOEaa2Fd2e090Zm9WWXAF56wdsM0u9w5rRmm8afNh3OfSMDqCPub034GLxd7SrW2om9x
        eC36Lr5E53MkERQOjD0+38xJ0cnq0mI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-UUrP3njROBObyQGNWetihw-1; Mon, 05 Jun 2023 07:43:35 -0400
X-MC-Unique: UUrP3njROBObyQGNWetihw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-656dbbbda20so433255b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685965414; x=1688557414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQUlV/DSEwcUdtFGZI4Rkk19WX9clmv+BXCW6uCxtEg=;
        b=TJ1MZkG7yPlmXs7Ghw9qPInY6d/QD+zD1gJoXhWwyXMG4Yn44Q8zrSy9WBNVb+yfEz
         8Jl/h7NxItnZGcJSdG9G8b6e3ynr6Gc+d9j6Qnr87+kc6wJkEe25avzTYPvoqBfC/wdX
         ljF3k1x+preA2lwkSB5HlF147WZbMOQDHGHHRWQlykVmO1kHVEfj2XMzXVNnQHvhDvDK
         Og393fqSzeu3+HlOmQzMXEflllemK8hAa1+PhIIdMx9zIIDkgRqXoX4p1uTOiM8ZKCK/
         q48tuIzhq6SpCgdKlOGbHRe0/W/ki0oZKhCdzEwdg+xv/mVQuBOGeXkvwCaRNpDaBqMt
         rH1g==
X-Gm-Message-State: AC+VfDw8LA6H/rtt9WChaWQCpvrlRKaWz8wYFjekiPyGvyE8+2OOjJrk
        fufSUBvwpqSsz3niHqFc25C6YG8AnbCQfR5dHHdzXvVsijwkB9ho9+Qlj+58omz/88QjZorRXt9
        Y/cv91Gzfd5Mx+0oCCgHvndav
X-Received: by 2002:a05:6a20:a10c:b0:100:eb1e:3939 with SMTP id q12-20020a056a20a10c00b00100eb1e3939mr20924498pzk.1.1685965414392;
        Mon, 05 Jun 2023 04:43:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5dqHZQ4Wl6XSs6177GtD88PQJeClTkwW71QGxM9iz9W/aRL6Zv7+agwq/J/oKzkPK4dh1IqQ==
X-Received: by 2002:a05:6a20:a10c:b0:100:eb1e:3939 with SMTP id q12-20020a056a20a10c00b00100eb1e3939mr20924486pzk.1.1685965414073;
        Mon, 05 Jun 2023 04:43:34 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q14-20020a65494e000000b00530914c3bc1sm5042185pgs.21.2023.06.05.04.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:43:33 -0700 (PDT)
Message-ID: <628463d5-b9df-51bd-8e1f-b0a41a928d85@redhat.com>
Date:   Mon, 5 Jun 2023 19:43:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 07/11] arm64: mops: handle MOPS exceptions
To:     Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
References: <20230509142235.3284028-1-kristina.martsenko@arm.com>
 <20230509142235.3284028-8-kristina.martsenko@arm.com>
Content-Language: en-US
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20230509142235.3284028-8-kristina.martsenko@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kristina,

On 5/9/23 22:22, Kristina Martsenko wrote:
> The memory copy/set instructions added as part of FEAT_MOPS can take an
> exception (e.g. page fault) part-way through their execution and resume
> execution afterwards.
> 
> If however the task is re-scheduled and execution resumes on a different
> CPU, then the CPU may take a new type of exception to indicate this.
> This is because the architecture allows two options (Option A and Option
> B) to implement the instructions and a heterogeneous system can have
> different implementations between CPUs.
> 
> In this case the OS has to reset the registers and restart execution
> from the prologue instruction. The algorithm for doing this is provided
> as part of the Arm ARM.
What is the Arm ARM? I'm not quite understand it.
> 
> Add an exception handler for the new exception and wire it up for
> userspace tasks.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> ---
>   arch/arm64/include/asm/esr.h       | 11 ++++++-
>   arch/arm64/include/asm/exception.h |  1 +
>   arch/arm64/kernel/entry-common.c   | 11 +++++++
>   arch/arm64/kernel/traps.c          | 52 ++++++++++++++++++++++++++++++
>   4 files changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index 8487aec9b658..ca954f566861 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -47,7 +47,7 @@
>   #define ESR_ELx_EC_DABT_LOW	(0x24)
>   #define ESR_ELx_EC_DABT_CUR	(0x25)
>   #define ESR_ELx_EC_SP_ALIGN	(0x26)
> -/* Unallocated EC: 0x27 */
> +#define ESR_ELx_EC_MOPS		(0x27)
>   #define ESR_ELx_EC_FP_EXC32	(0x28)
>   /* Unallocated EC: 0x29 - 0x2B */
>   #define ESR_ELx_EC_FP_EXC64	(0x2C)
> @@ -356,6 +356,15 @@
>   #define ESR_ELx_SME_ISS_ZA_DISABLED	3
>   #define ESR_ELx_SME_ISS_ZT_DISABLED	4
>   
> +/* ISS field definitions for MOPS exceptions */
> +#define ESR_ELx_MOPS_ISS_MEM_INST	(UL(1) << 24)
> +#define ESR_ELx_MOPS_ISS_FROM_EPILOGUE	(UL(1) << 18)
> +#define ESR_ELx_MOPS_ISS_WRONG_OPTION	(UL(1) << 17)
> +#define ESR_ELx_MOPS_ISS_OPTION_A	(UL(1) << 16)
> +#define ESR_ELx_MOPS_ISS_DESTREG(esr)	(((esr) & (UL(0x1f) << 10)) >> 10)
> +#define ESR_ELx_MOPS_ISS_SRCREG(esr)	(((esr) & (UL(0x1f) << 5)) >> 5)
> +#define ESR_ELx_MOPS_ISS_SIZEREG(esr)	(((esr) & (UL(0x1f) << 0)) >> 0)
> +
>   #ifndef __ASSEMBLY__
>   #include <asm/types.h>
>   
> diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
> index e73af709cb7a..72e83af0135f 100644
> --- a/arch/arm64/include/asm/exception.h
> +++ b/arch/arm64/include/asm/exception.h
> @@ -77,6 +77,7 @@ void do_el0_svc(struct pt_regs *regs);
>   void do_el0_svc_compat(struct pt_regs *regs);
>   void do_el0_fpac(struct pt_regs *regs, unsigned long esr);
>   void do_el1_fpac(struct pt_regs *regs, unsigned long esr);
> +void do_el0_mops(struct pt_regs *regs, unsigned long esr);
>   void do_serror(struct pt_regs *regs, unsigned long esr);
>   void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags);
>   
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 3af3c01c93a6..a8ec174e5b0e 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -611,6 +611,14 @@ static void noinstr el0_bti(struct pt_regs *regs)
>   	exit_to_user_mode(regs);
>   }
>   
> +static void noinstr el0_mops(struct pt_regs *regs, unsigned long esr)
> +{
> +	enter_from_user_mode(regs);
> +	local_daif_restore(DAIF_PROCCTX);
> +	do_el0_mops(regs, esr);
> +	exit_to_user_mode(regs);
> +}
> +
>   static void noinstr el0_inv(struct pt_regs *regs, unsigned long esr)
>   {
>   	enter_from_user_mode(regs);
> @@ -688,6 +696,9 @@ asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
>   	case ESR_ELx_EC_BTI:
>   		el0_bti(regs);
>   		break;
> +	case ESR_ELx_EC_MOPS:
> +		el0_mops(regs, esr);
> +		break;
>   	case ESR_ELx_EC_BREAKPT_LOW:
>   	case ESR_ELx_EC_SOFTSTP_LOW:
>   	case ESR_ELx_EC_WATCHPT_LOW:
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 4bb1b8f47298..32dc692bffd3 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -514,6 +514,57 @@ void do_el1_fpac(struct pt_regs *regs, unsigned long esr)
>   	die("Oops - FPAC", regs, esr);
>   }
>   
> +void do_el0_mops(struct pt_regs *regs, unsigned long esr)
> +{
> +	bool wrong_option = esr & ESR_ELx_MOPS_ISS_WRONG_OPTION;
> +	bool option_a = esr & ESR_ELx_MOPS_ISS_OPTION_A;
> +	int dstreg = ESR_ELx_MOPS_ISS_DESTREG(esr);
> +	int srcreg = ESR_ELx_MOPS_ISS_SRCREG(esr);
> +	int sizereg = ESR_ELx_MOPS_ISS_SIZEREG(esr);
> +	unsigned long dst, src, size;
> +
> +	dst = pt_regs_read_reg(regs, dstreg);
> +	src = pt_regs_read_reg(regs, srcreg);
> +	size = pt_regs_read_reg(regs, sizereg);
> +
> +	/*
> +	 * Put the registers back in the original format suitable for a
> +	 * prologue instruction, using the generic return routine from the
> +	 * Arm ARM (DDI 0487I.a) rules CNTMJ and MWFQH.
> +	 */
> +	if (esr & ESR_ELx_MOPS_ISS_MEM_INST) {
> +		/* SET* instruction */
> +		if (option_a ^ wrong_option) {
> +			/* Format is from Option A; forward set */
> +			pt_regs_write_reg(regs, dstreg, dst + size);
> +			pt_regs_write_reg(regs, sizereg, -size);
> +		}
> +	} else {
> +		/* CPY* instruction */
> +		if (!(option_a ^ wrong_option)) {
> +			/* Format is from Option B */
> +			if (regs->pstate & PSR_N_BIT) {
> +				/* Backward copy */
> +				pt_regs_write_reg(regs, dstreg, dst - size);
> +				pt_regs_write_reg(regs, srcreg, src - size);
> +			}
> +		} else {
> +			/* Format is from Option A */
> +			if (size & BIT(63)) {
> +				/* Forward copy */
> +				pt_regs_write_reg(regs, dstreg, dst + size);
> +				pt_regs_write_reg(regs, srcreg, src + size);
> +				pt_regs_write_reg(regs, sizereg, -size);
> +			}
> +		}
> +	}
> +
> +	if (esr & ESR_ELx_MOPS_ISS_FROM_EPILOGUE)
> +		regs->pc -= 8;
> +	else
> +		regs->pc -= 4;
> +}
> +
>   #define __user_cache_maint(insn, address, res)			\
>   	if (address >= TASK_SIZE_MAX) {				\
>   		res = -EFAULT;					\
> @@ -824,6 +875,7 @@ static const char *esr_class_str[] = {
>   	[ESR_ELx_EC_DABT_LOW]		= "DABT (lower EL)",
>   	[ESR_ELx_EC_DABT_CUR]		= "DABT (current EL)",
>   	[ESR_ELx_EC_SP_ALIGN]		= "SP Alignment",
> +	[ESR_ELx_EC_MOPS]		= "MOPS",
>   	[ESR_ELx_EC_FP_EXC32]		= "FP (AArch32)",
>   	[ESR_ELx_EC_FP_EXC64]		= "FP (AArch64)",
>   	[ESR_ELx_EC_SERROR]		= "SError",

-- 
Shaoqin


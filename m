Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B586899AE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjBCN2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjBCN2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:28:05 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CF39D584;
        Fri,  3 Feb 2023 05:27:56 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313CQqoi014050;
        Fri, 3 Feb 2023 13:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GuT1XoAxhmmkHFVGH+dPrqAA4uAeJIMUX2JBnx6nSQM=;
 b=Wy5DP8T5HKpwtm0Izogmfig88jf/YZAeXKMTS8hGOObkUX/UD6wJM/bWW2xL1cIqQZ5c
 A0eNM+YieCKZIoQ2VFoj6AmDb/HyoIyUY8rc7P0jJ/OyuD8yrGke2BEjuOsChvgYVo0j
 KOtRpn5Tu4VqIf2kGajFQZTJskxQd3KvbJ6TPKtwTfW+3KhNw3BwDKPBP+4eZg2ajwPc
 fC5YyHJ5wvGYharWXyYppVUFLjDIQ0+F3UF5bws+sl+bDaQrN0yzOMxTMz8CCOAdRdGu
 COGvTHMHyhArmRdzLgfC6gSmzTaul7SohsyCF/DiYU1IIcwllMzSJY9IiH7wild8dz6a Tg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ng969ubxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 13:27:34 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 313DRXmv019931
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Feb 2023 13:27:33 GMT
Received: from [10.216.62.140] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 05:27:27 -0800
Message-ID: <8d34de4d-c294-3382-aaa1-683ff657fbaf@quicinc.com>
Date:   Fri, 3 Feb 2023 18:57:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] arm64: Support Clang UBSAN trap codes for better
 reporting
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        John Stultz <jstultz@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        <linux-arm-kernel@lists.infradead.org>, <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20230202223653.never.473-kees@kernel.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230202223653.never.473-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0SFiB21zEzuFIkw5cE8O5eskNUIMWIAO
X-Proofpoint-GUID: 0SFiB21zEzuFIkw5cE8O5eskNUIMWIAO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_13,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030124
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/2023 4:06 AM, Kees Cook wrote:
> On arm64, Clang encodes the UBSAN check type in the esr. Extract this
> and actually report UBSAN traps with some specificity when building with
> CONFIG_UBSAN_TRAP. Before:
> 
>    Internal error: BRK handler: 00000000f20003e8 [#1] PREEMPT SMP
> 
> After:
> 
>    Internal error: UBSAN: shift out of bounds: 00000000f2005514 [#1] PREEMPT SMP
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: John Stultz <jstultz@google.com>
> Cc: Yongqin Liu <yongqin.liu@linaro.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Marco Elver <elver@google.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for handling this,,it will really help in decoding abstracted BRK
handler errors to some extent.

Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
> ---
>   arch/arm64/include/asm/brk-imm.h |  2 ++
>   arch/arm64/kernel/traps.c        | 21 +++++++++++++
>   include/linux/ubsan.h            |  9 ++++++
>   lib/Makefile                     |  2 --
>   lib/ubsan.c                      | 54 ++++++++++++++++++++++++++++++++
>   lib/ubsan.h                      | 28 +++++++++++++++++
>   6 files changed, 114 insertions(+), 2 deletions(-)
>   create mode 100644 include/linux/ubsan.h
> 
> diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/asm/brk-imm.h
> index 6e000113e508..3f0f0d03268b 100644
> --- a/arch/arm64/include/asm/brk-imm.h
> +++ b/arch/arm64/include/asm/brk-imm.h
> @@ -28,6 +28,8 @@
>   #define BUG_BRK_IMM			0x800
>   #define KASAN_BRK_IMM			0x900
>   #define KASAN_BRK_MASK			0x0ff
> +#define UBSAN_BRK_IMM			0x5500
> +#define UBSAN_BRK_MASK			0x00ff
>   
>   #define CFI_BRK_IMM_TARGET		GENMASK(4, 0)
>   #define CFI_BRK_IMM_TYPE		GENMASK(9, 5)
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 4c0caa589e12..87f42eb1c950 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -26,6 +26,7 @@
>   #include <linux/syscalls.h>
>   #include <linux/mm_types.h>
>   #include <linux/kasan.h>
> +#include <linux/ubsan.h>
>   #include <linux/cfi.h>
>   
>   #include <asm/atomic.h>
> @@ -1074,6 +1075,19 @@ static struct break_hook kasan_break_hook = {
>   };
>   #endif
>   
> +#ifdef CONFIG_UBSAN_TRAP
> +static int ubsan_handler(struct pt_regs *regs, unsigned long esr)
> +{
> +	die(report_ubsan_failure(regs, esr & UBSAN_BRK_MASK), regs, esr);
> +	return DBG_HOOK_HANDLED;
> +}
> +
> +static struct break_hook ubsan_break_hook = {
> +	.fn	= ubsan_handler,
> +	.imm	= UBSAN_BRK_IMM,
> +	.mask	= UBSAN_BRK_MASK,
> +};
> +#endif
>   
>   #define esr_comment(esr) ((esr) & ESR_ELx_BRK64_ISS_COMMENT_MASK)
>   
> @@ -1091,6 +1105,10 @@ int __init early_brk64(unsigned long addr, unsigned long esr,
>   #ifdef CONFIG_KASAN_SW_TAGS
>   	if ((esr_comment(esr) & ~KASAN_BRK_MASK) == KASAN_BRK_IMM)
>   		return kasan_handler(regs, esr) != DBG_HOOK_HANDLED;
> +#endif
> +#ifdef CONFIG_UBSAN_TRAP
> +	if ((esr_comment(esr) & ~UBSAN_BRK_MASK) == UBSAN_BRK_IMM)
> +		return ubsan_handler(regs, esr) != DBG_HOOK_HANDLED;
>   #endif
>   	return bug_handler(regs, esr) != DBG_HOOK_HANDLED;
>   }
> @@ -1104,6 +1122,9 @@ void __init trap_init(void)
>   	register_kernel_break_hook(&fault_break_hook);
>   #ifdef CONFIG_KASAN_SW_TAGS
>   	register_kernel_break_hook(&kasan_break_hook);
> +#endif
> +#ifdef CONFIG_UBSAN_TRAP
> +	register_kernel_break_hook(&ubsan_break_hook);
>   #endif
>   	debug_traps_init();
>   }
> diff --git a/include/linux/ubsan.h b/include/linux/ubsan.h
> new file mode 100644
> index 000000000000..bff7445498de
> --- /dev/null
> +++ b/include/linux/ubsan.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_UBSAN_H
> +#define _LINUX_UBSAN_H
> +
> +#ifdef CONFIG_UBSAN_TRAP
> +const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type);
> +#endif
> +
> +#endif
> diff --git a/lib/Makefile b/lib/Makefile
> index 4d9461bfea42..81b988bf9448 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -340,9 +340,7 @@ quiet_cmd_build_OID_registry = GEN     $@
>   clean-files	+= oid_registry_data.c
>   
>   obj-$(CONFIG_UCS2_STRING) += ucs2_string.o
> -ifneq ($(CONFIG_UBSAN_TRAP),y)
>   obj-$(CONFIG_UBSAN) += ubsan.o
> -endif
>   
>   UBSAN_SANITIZE_ubsan.o := n
>   KASAN_SANITIZE_ubsan.o := n
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index 60c7099857a0..98a671ec56e9 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -18,6 +18,58 @@
>   
>   #include "ubsan.h"
>   
> +#ifdef CONFIG_UBSAN_TRAP
> +const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
> +{
> +	switch (check_type) {
> +	case ubsan_add_overflow:
> +		return "UBSAN: addition overflow";
> +	case ubsan_builtin_unreachable:
> +		return "UBSAN: unreachable code";
> +	case ubsan_cfi_check_fail:
> +		return "UBSAN: CFI failure";
> +	case ubsan_divrem_overflow:
> +		return "UBSAN: divide/remainder overflow";
> +	case ubsan_function_type_mismatch:
> +		return "UBSAN: function type mismatch";
> +	case ubsan_implicit_conversion:
> +		return "UBSAN: implicit conversion";
> +	case ubsan_invalid_builtin:
> +		return "UBSAN: invalid builtin";
> +	case ubsan_invalid_objc_cast:
> +		return "UBSAN: invalid object cast";
> +	case ubsan_load_invalid_value:
> +		return "UBSAN: loading invalid value";
> +	case ubsan_missing_return:
> +		return "UBSAN: missing return";
> +	case ubsan_mul_overflow:
> +		return "UBSAN: multiplication overflow";
> +	case ubsan_negate_overflow:
> +		return "UBSAN: negation overflow";
> +	case ubsan_nonnull_arg:
> +		return "UBSAN: non-NULL argument";
> +	case ubsan_nonnull_return:
> +		return "UBSAN: non-NULL return";
> +	case ubsan_out_of_bounds:
> +		return "UBSAN: array index out of bounds";
> +	case ubsan_pointer_overflow:
> +		return "UBSAN: pointer overflow";
> +	case ubsan_shift_out_of_bounds:
> +		return "UBSAN: shift out of bounds";
> +	case ubsan_sub_overflow:
> +		return "UBSAN: subtraction overflow";
> +	case ubsan_type_mismatch:
> +		return "UBSAN: type mismatch";
> +	case ubsan_alignment_assumption:
> +		return "UBSAN: alignment assumption";
> +	case ubsan_vla_bound_not_positive:
> +		return "UBSAN: VLA bounds not positive";
> +	default:
> +		return "UBSAN: unknown failure";
> +	}
> +}
> +
> +#else
>   static const char * const type_check_kinds[] = {
>   	"load of",
>   	"store to",
> @@ -384,3 +436,5 @@ void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
>   	ubsan_epilogue();
>   }
>   EXPORT_SYMBOL(__ubsan_handle_alignment_assumption);
> +
> +#endif /* !CONFIG_UBSAN_TRAP */
> diff --git a/lib/ubsan.h b/lib/ubsan.h
> index 9a0b71c5ff9f..9c7f00f550f5 100644
> --- a/lib/ubsan.h
> +++ b/lib/ubsan.h
> @@ -2,6 +2,34 @@
>   #ifndef _LIB_UBSAN_H
>   #define _LIB_UBSAN_H
>   
> +enum ubsan_checks {
> +	ubsan_add_overflow,
> +	ubsan_builtin_unreachable,
> +	ubsan_cfi_check_fail,
> +	ubsan_divrem_overflow,
> +	ubsan_dynamic_type_cache_miss,
> +	ubsan_float_cast_overflow,
> +	ubsan_function_type_mismatch,
> +	ubsan_implicit_conversion,
> +	ubsan_invalid_builtin,
> +	ubsan_invalid_objc_cast,
> +	ubsan_load_invalid_value,
> +	ubsan_missing_return,
> +	ubsan_mul_overflow,
> +	ubsan_negate_overflow,
> +	ubsan_nullability_arg,
> +	ubsan_nullability_return,
> +	ubsan_nonnull_arg,
> +	ubsan_nonnull_return,
> +	ubsan_out_of_bounds,
> +	ubsan_pointer_overflow,
> +	ubsan_shift_out_of_bounds,
> +	ubsan_sub_overflow,
> +	ubsan_type_mismatch,
> +	ubsan_alignment_assumption,
> +	ubsan_vla_bound_not_positive,
> +};
> +
>   enum {
>   	type_kind_int = 0,
>   	type_kind_float = 1,

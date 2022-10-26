Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B438F60E7B7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiJZSyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiJZSyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:54:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56E11D0C1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:54:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C0816202E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 18:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21A6C433C1;
        Wed, 26 Oct 2022 18:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666810474;
        bh=Ieo52/jNSdW27hzsdTn6oYBvOHTHSgTAdPGfBUcNP4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GC4V3OvnH3tWXaHfzU4RZ+AC9GASpBSuAr3BBHRLfa4KKK58wnV0gYNSxG2b7DL0g
         SUSkIwR9P/3Niskkm33goFHVefozJRt7rQDzkkKl5NDwCwON9dCIabexG4CgzMdeF9
         1Y4lryEp2aDDdHlrIh4oDlQAZj81b18xoNthNokRyS4ftCkhWM+SrpPtjK8sb74nY5
         0n8ZE/ZBP+kAecFdM92q6ErE8xFY5rkCMC+DfZCxz3GUHiBXaUUUAzW3RhHKxrcgQ7
         2STV5dEq5JBMzsnU+3qhAVyoD6WoNXUj3CxjlQ+gwyWJMryi9Iw3mJ/hrLs3lSLOak
         WfxIP9HcOrE3g==
Date:   Wed, 26 Oct 2022 19:54:29 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Wen Yao <haiwenyao@uniontech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] riscv: percpu:Add riscv percpu operations
Message-ID: <Y1mCZT8ejRpvCfw6@spud>
References: <20221026104015.565468-1-haiwenyao@uniontech.com>
 <20221026104015.565468-2-haiwenyao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026104015.565468-2-haiwenyao@uniontech.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Wen Yao,
Couple comments for you.

On Wed, Oct 26, 2022 at 06:40:14PM +0800, Wen Yao wrote:
> riscv: percpu:Add riscv percpu operations

Can you please consistently use ": " between parts of the commit
messages? For both this and patch 2/2.

> This patch use riscv AMO(Atomic Memory Operation) instructions to

nit: s/This patch/Use (or better:
"Optimise some ... using RISC-V AMO (Atomic..."

> optimise some this_cpu_and this_cpu_or this_cpu_add operations.
> It reuse cmpxchg_local() to impletment this_cpu_cmpxchg macros.

s/It Reuse/Reuse, and "impletment" is a typo.

> It reuse xchg_relaxed() to impletment this_cpu_xchg macros.
> 
> Signed-off-by: Wen Yao <haiwenyao@uniontech.com>
> ---
>  arch/riscv/include/asm/percpu.h | 101 ++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 arch/riscv/include/asm/percpu.h
> 
> diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
> new file mode 100644
> index 000000000000..ae796e328442
> --- /dev/null
> +++ b/arch/riscv/include/asm/percpu.h
> @@ -0,0 +1,101 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Union Tech Software Technology Corporation Limited
> + */
> +#ifndef __ASM_PERCPU_H
> +#define __ASM_PERCPU_H
> +
> +#include <asm/cmpxchg.h>
> +
> +#define PERCPU_OP(op, asm_op, c_op)                                            \
> +	static inline unsigned long __percpu_##op(void *ptr,                   \

Can you please make sure that these \s are actually aligned & swap the
spaces you've used for tabs? The other files that I checked in this
directory all use tabs for \ alignment in macros.

Thanks,
Conor.

> +						  unsigned long val, int size) \
> +	{                                                                      \
> +		unsigned long ret;                                             \
> +		switch (size) {                                                \
> +		case 4:                                                        \
> +			__asm__ __volatile__(                                  \
> +				"amo" #asm_op ".w"                             \
> +				" %[ret], %[val], %[ptr]\n"                   \
> +				: [ret] "=&r"(ret), [ptr] "+A"(*(u32 *)ptr)    \
> +				: [val] "r"(val));                             \
> +			break;                                                 \
> +		case 8:                                                        \
> +			__asm__ __volatile__(                                  \
> +				"amo" #asm_op ".d"                             \
> +				" %[ret], %[val], %[ptr]\n"                   \
> +				: [ret] "=&r"(ret), [ptr] "+A"(*(u64 *)ptr)    \
> +				: [val] "r"(val));                             \
> +			break;                                                 \
> +		default:                                                       \
> +			ret = 0;                                               \
> +			BUILD_BUG();                                           \
> +		}                                                              \
> +										\
> +		return ret c_op val;                                           \
> +	}
> +
> +PERCPU_OP(add, add, +)
> +PERCPU_OP(and, and, &)
> +PERCPU_OP(or, or, |)
> +#undef PERCPU_OP
> +
> +/* this_cpu_xchg */
> +#define _protect_xchg_local(pcp, val)                           \
> +	({                                                      \
> +		typeof(*raw_cpu_ptr(&(pcp))) __ret;             \
> +		preempt_disable_notrace();                      \
> +		__ret = xchg_relaxed(raw_cpu_ptr(&(pcp)), val); \
> +		preempt_enable_notrace();                       \
> +		__ret;                                          \
> +	})
> +
> +/* this_cpu_cmpxchg */
> +#define _protect_cmpxchg_local(pcp, o, n)                         \
> +	({                                                        \
> +		typeof(*raw_cpu_ptr(&(pcp))) __ret;               \
> +		preempt_disable_notrace();                        \
> +		__ret = cmpxchg_local(raw_cpu_ptr(&(pcp)), o, n); \
> +		preempt_enable_notrace();                         \
> +		__ret;                                            \
> +	})
> +
> +#define _pcp_protect(operation, pcp, val)                                     \
> +	({                                                                    \
> +		typeof(pcp) __retval;                                         \
> +		preempt_disable_notrace();                                    \
> +		__retval = (typeof(pcp))operation(raw_cpu_ptr(&(pcp)), (val), \
> +						  sizeof(pcp));               \
> +		preempt_enable_notrace();                                     \
> +		__retval;                                                     \
> +	})
> +
> +#define _percpu_add(pcp, val) _pcp_protect(__percpu_add, pcp, val)
> +
> +#define _percpu_add_return(pcp, val) _percpu_add(pcp, val)
> +
> +#define _percpu_and(pcp, val) _pcp_protect(__percpu_and, pcp, val)
> +
> +#define _percpu_or(pcp, val) _pcp_protect(__percpu_or, pcp, val)
> +
> +#define this_cpu_add_4(pcp, val) _percpu_add(pcp, val)
> +#define this_cpu_add_8(pcp, val) _percpu_add(pcp, val)
> +
> +#define this_cpu_add_return_4(pcp, val) _percpu_add_return(pcp, val)
> +#define this_cpu_add_return_8(pcp, val) _percpu_add_return(pcp, val)
> +
> +#define this_cpu_and_4(pcp, val) _percpu_and(pcp, val)
> +#define this_cpu_and_8(pcp, val) _percpu_and(pcp, val)
> +
> +#define this_cpu_or_4(pcp, val) _percpu_or(pcp, val)
> +#define this_cpu_or_8(pcp, val) _percpu_or(pcp, val)
> +
> +#define this_cpu_xchg_4(pcp, val) _protect_xchg_local(pcp, val)
> +#define this_cpu_xchg_8(pcp, val) _protect_xchg_local(pcp, val)
> +
> +#define this_cpu_cmpxchg_4(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
> +#define this_cpu_cmpxchg_8(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
> +
> +#include <asm-generic/percpu.h>
> +
> +#endif /* __ASM_PERCPU_H */
> -- 
> 2.25.1
> 

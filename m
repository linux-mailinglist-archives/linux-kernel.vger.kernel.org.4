Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5CC69DDF9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjBUKhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjBUKhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:37:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFF92252AF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:37:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D716DFEC;
        Tue, 21 Feb 2023 02:37:45 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.16.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 723183F703;
        Tue, 21 Feb 2023 02:37:00 -0800 (PST)
Date:   Tue, 21 Feb 2023 10:36:53 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Lin Yujun <linyujun809@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
        kristina.martsenko@arm.com, james.morse@arm.com, maz@kernel.org,
        ardb@kernel.org, samitolvanen@google.com, andreyknvl@gmail.com,
        masahiroy@kernel.org, joey.gouly@arm.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, wanghai38@huawei.com
Subject: Re: [PATCH -next] arm64: Optimize the comparison of unsigned
 expressions to avoid compiling error
Message-ID: <Y/SewFthY/rGct7C@FVFF77S0Q05N>
References: <20230221012740.2929481-1-linyujun809@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230221012740.2929481-1-linyujun809@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 09:27:40AM +0800, Lin Yujun wrote:
> while compile arch/arm64/include/asm/cpufeature.h with
> -Werror=type-limits enabled, errors shown as below:
> 
> ./arch/arm64/include/asm/cpufeature.h: In function 'system_supports_4kb_granule':
> ./arch/arm64/include/asm/cpufeature.h:653:14: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
>   return (val >= ID_AA64MMFR0_TGRAN4_SUPPORTED_MIN) &&
>               ^~
> ./arch/arm64/include/asm/cpufeature.h: In function 'system_supports_64kb_granule':
> ./arch/arm64/include/asm/cpufeature.h:666:14: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
>   return (val >= ID_AA64MMFR0_TGRAN64_SUPPORTED_MIN) &&
>               ^~

When is the `-Werror=type-limits` flag enabled by the build system?

We have patterns like this all over the kernel, and I don't think this is
indicative of a real problem, and I don't think that we need to change code to
make this warning disappear.

> Modify the return judgment statement, use
> "((val - min) < (val - max - 1))" to confirm that returns
> true in “min <= val <= max” cases, false in other cases.

That expression is far less clear than the existing code, so I do not think
that is a good idea.

> Fixes: 79d82cbcbb3d ("arm64/kexec: Test page size support with new TGRAN range values")

What functional error does this fix?

What configuration is broken?

Thanks,
Mark.

> Signed-off-by: Lin Yujun <linyujun809@huawei.com>
> ---
>  arch/arm64/include/asm/cpufeature.h | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 03d1c9d7af82..0a6bda025141 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -54,6 +54,9 @@ enum ftr_type {
>  #define FTR_VISIBLE_IF_IS_ENABLED(config)		\
>  	(IS_ENABLED(config) ? FTR_VISIBLE : FTR_HIDDEN)
>  
> +#define IN_RANGE_INCLUSIVE(val, min, max)		\
> +	(((val) - (min)) < ((val) - (max) - 1))
> +
>  struct arm64_ftr_bits {
>  	bool		sign;	/* Value is signed ? */
>  	bool		visible;
> @@ -693,8 +696,9 @@ static inline bool system_supports_4kb_granule(void)
>  	val = cpuid_feature_extract_unsigned_field(mmfr0,
>  						ID_AA64MMFR0_EL1_TGRAN4_SHIFT);
>  
> -	return (val >= ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MIN) &&
> -	       (val <= ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MAX);
> +	return IN_RANGE_INCLUSIVE(val,
> +		ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MIN,
> +		ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MAX);
>  }
>  
>  static inline bool system_supports_64kb_granule(void)
> @@ -706,8 +710,9 @@ static inline bool system_supports_64kb_granule(void)
>  	val = cpuid_feature_extract_unsigned_field(mmfr0,
>  						ID_AA64MMFR0_EL1_TGRAN64_SHIFT);
>  
> -	return (val >= ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MIN) &&
> -	       (val <= ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MAX);
> +	return IN_RANGE_INCLUSIVE(val,
> +		ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MIN,
> +		ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MAX);
>  }
>  
>  static inline bool system_supports_16kb_granule(void)
> @@ -719,8 +724,9 @@ static inline bool system_supports_16kb_granule(void)
>  	val = cpuid_feature_extract_unsigned_field(mmfr0,
>  						ID_AA64MMFR0_EL1_TGRAN16_SHIFT);
>  
> -	return (val >= ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MIN) &&
> -	       (val <= ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MAX);
> +	return IN_RANGE_INCLUSIVE(val,
> +		ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MIN,
> +		ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MAX);
>  }
>  
>  static inline bool system_supports_mixed_endian_el0(void)
> -- 
> 2.34.1
> 

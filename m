Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B92619270
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiKDIJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiKDIJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:09:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B4421266
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 01:09:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 154FAB82C3F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639F5C433C1;
        Fri,  4 Nov 2022 08:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667549355;
        bh=nz35tr+hBsbPN5fBvXlpKtAAHzHkRag6EGe1QLpmQp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5wdORS31VqYzOQsOQSfOkydc78TFXctGPFb8etaKnRfNkTNvbXx8L7ModesGjizA
         megKYxIClIQtHB8qWxmjV1aCXcIlKeg/Ml9T3or7wdk9yO7mS+ccqjcAAXH7O46Jdu
         t9+DpKbODZRn1Z5zons1jch1Dd0ZHNbpMkKsHlDANixWL8LXEZDafH0CyW9kZH0NRq
         Awr88EA2j71GcHVw+sxnh7E43/Sm9JAjMkyDAlTv8aIQfjrMNNKExAchPy+B48/fG2
         JplBmKjw2SXg92oY9OnQSkZjYHrMVruZUpZnapj/Bgp8VbvXT9yAZfq4BtrQLhjrTm
         1Mqw6z5el+vCw==
Date:   Fri, 4 Nov 2022 01:09:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adam Langley <agl@google.com>
Subject: Re: [RFC PATCH] arm64: Enable data independent timing (DIT) in the
 kernel
Message-ID: <Y2TIqcfxFaThC4d5@sol.localdomain>
References: <20221027112741.1678057-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027112741.1678057-1-ardb@kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Thu, Oct 27, 2022 at 01:27:41PM +0200, Ard Biesheuvel wrote:
> Given that running privileged code with DIT disabled on a CPU that
> implements support for it may result in a side channel that exposes
> privileged data to unprivileged user space processes, let's enable DIT
> while running in the kernel if supported by all CPUs.

This patch looks good to me, though I'm not an expert in low-level arm64 stuff.
It's a bit unfortunate that we have to manually create the .inst to enable DIT
instead of just using the assembler.  But it looks like there's a reason for it
(it's done for PAN et al. too), and based on the manual it looks correct.

Two nits below:

> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 7d301700d1a9..18e065f5130c 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -94,15 +94,18 @@
>  #define PSTATE_PAN			pstate_field(0, 4)
>  #define PSTATE_UAO			pstate_field(0, 3)
>  #define PSTATE_SSBS			pstate_field(3, 1)
> +#define PSTATE_DIT			pstate_field(3, 2)
>  #define PSTATE_TCO			pstate_field(3, 4)
>  
>  #define SET_PSTATE_PAN(x)		__emit_inst(0xd500401f | PSTATE_PAN | ((!!x) << PSTATE_Imm_shift))
>  #define SET_PSTATE_UAO(x)		__emit_inst(0xd500401f | PSTATE_UAO | ((!!x) << PSTATE_Imm_shift))
>  #define SET_PSTATE_SSBS(x)		__emit_inst(0xd500401f | PSTATE_SSBS | ((!!x) << PSTATE_Imm_shift))
> +#define SET_PSTATE_DIT(x)		__emit_inst(0xd500401f | PSTATE_DIT | ((!!x) << PSTATE_Imm_shift))
>  #define SET_PSTATE_TCO(x)		__emit_inst(0xd500401f | PSTATE_TCO | ((!!x) << PSTATE_Imm_shift))
>  
>  #define set_pstate_pan(x)		asm volatile(SET_PSTATE_PAN(x))
>  #define set_pstate_uao(x)		asm volatile(SET_PSTATE_UAO(x))
> +#define set_pstate_dit(x)		asm volatile(SET_PSTATE_DIT(x))
>  #define set_pstate_ssbs(x)		asm volatile(SET_PSTATE_SSBS(x))

To keep the order consistent, set_pstate_dit() should be defined after
set_pstate_ssbs(), not before.

>  /* Internal helper functions to match cpu capability type */
>  static bool
>  cpucap_late_cpu_optional(const struct arm64_cpu_capabilities *cap)
> @@ -2640,6 +2645,17 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.matches = has_cpuid_feature,
>  		.cpu_enable = cpu_trap_el0_impdef,
>  	},
> +	{
> +		.desc = "Data independent timing control (DIT)",
> +		.capability = ARM64_HAS_DIT,
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.matches = has_cpuid_feature,
> +		.sys_reg = SYS_ID_AA64PFR0_EL1,
> +		.field_pos = ID_AA64PFR0_EL1_DIT_SHIFT,
> +		.field_width = 4,
> +		.min_field_value = 1,
> +		.cpu_enable = cpu_enable_dit,
> +	},

The other entries in this array are explicit about '.sign = FTR_UNSIGNED'
(even though FTR_UNSIGNED is defined to false, so it's the default value).

- Eric

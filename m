Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B62173105A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbjFOHR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243727AbjFOHQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:16:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7155DE69;
        Thu, 15 Jun 2023 00:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFB3961239;
        Thu, 15 Jun 2023 07:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB0EC433C0;
        Thu, 15 Jun 2023 07:14:14 +0000 (UTC)
Date:   Thu, 15 Jun 2023 08:14:11 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <ZIq6Q/TyZZZrJP2e@arm.com>
References: <20230615122201.75e36abd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615122201.75e36abd@canb.auug.org.au>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 12:22:01PM +1000, Stephen Rothwell wrote:
> diff --cc arch/arm64/kernel/cpufeature.c
> index 6ea7f23b1287,f6e3598760f1..000000000000
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@@ -2662,27 -2656,23 +2677,44 @@@ static const struct arm64_cpu_capabilit
>   		.cpu_enable = cpu_enable_dit,
>   		ARM64_CPUID_FIELDS(ID_AA64PFR0_EL1, DIT, IMP)
>   	},
>  +	{
>  +		.desc = "Memory Copy and Memory Set instructions",
>  +		.capability = ARM64_HAS_MOPS,
>  +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>  +		.matches = has_cpuid_feature,
>  +		.cpu_enable = cpu_enable_mops,
>  +		ARM64_CPUID_FIELDS(ID_AA64ISAR2_EL1, MOPS, IMP)
>  +	},
>  +	{
>  +		.capability = ARM64_HAS_TCR2,
>  +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>  +		.matches = has_cpuid_feature,
>  +		ARM64_CPUID_FIELDS(ID_AA64MMFR3_EL1, TCRX, IMP)
>  +	},
>  +	{
>  +		.desc = "Stage-1 Permission Indirection Extension (S1PIE)",
>  +		.capability = ARM64_HAS_S1PIE,
>  +		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
>  +		.matches = has_cpuid_feature,
>  +		ARM64_CPUID_FIELDS(ID_AA64MMFR3_EL1, S1PIE, IMP)
>  +	},
> + 	{
> + 		.desc = "Enhanced Virtualization Traps",
> + 		.capability = ARM64_HAS_EVT,
> + 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> + 		.sys_reg = SYS_ID_AA64MMFR2_EL1,
> + 		.sign = FTR_UNSIGNED,
> + 		.field_pos = ID_AA64MMFR2_EL1_EVT_SHIFT,
> + 		.field_width = 4,
> + 		.min_field_value = ID_AA64MMFR2_EL1_EVT_IMP,
> + 		.matches = has_cpuid_feature,
> + 	},
> + 	{
> + 		.desc = "VHE for hypervisor only",
> + 		.capability = ARM64_KVM_HVHE,
> + 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> + 		.matches = hvhe_possible,
> + 	},
>   	{},
>   };

This looks fine. Thanks Stephen.

-- 
Catalin

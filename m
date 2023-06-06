Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEF1723D0F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbjFFJUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbjFFJUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818D5E6B;
        Tue,  6 Jun 2023 02:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F2A362F85;
        Tue,  6 Jun 2023 09:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3138BC433D2;
        Tue,  6 Jun 2023 09:20:14 +0000 (UTC)
Date:   Tue, 6 Jun 2023 10:20:11 +0100
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
Message-ID: <ZH76SzsUvfYRBx4r@arm.com>
References: <20230606114927.227a66a5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606114927.227a66a5@canb.auug.org.au>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 11:49:27AM +1000, Stephen Rothwell wrote:
> diff --cc arch/arm64/kernel/cpufeature.c
> index a74f41c7280f,4a2ab3f366de..000000000000
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@@ -2662,35 -2641,17 +2662,46 @@@ static const struct arm64_cpu_capabilit
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
>  +		.sys_reg = SYS_ID_AA64MMFR3_EL1,
>  +		.sign = FTR_UNSIGNED,
>  +		.field_pos = ID_AA64MMFR3_EL1_TCRX_SHIFT,
>  +		.field_width = 4,
>  +		.min_field_value = ID_AA64MMFR3_EL1_TCRX_IMP,
>  +		.matches = has_cpuid_feature,
>  +	},
>  +	{
>  +		.desc = "Stage-1 Permission Indirection Extension (S1PIE)",
>  +		.capability = ARM64_HAS_S1PIE,
>  +		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
>  +		.sys_reg = SYS_ID_AA64MMFR3_EL1,
>  +		.sign = FTR_UNSIGNED,
>  +		.field_pos = ID_AA64MMFR3_EL1_S1PIE_SHIFT,
>  +		.field_width = 4,
>  +		.min_field_value = ID_AA64MMFR3_EL1_S1PIE_IMP,
>  +		.matches = has_cpuid_feature,
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
>   	{},
>   };

Thanks Stephen. It looks fine.

-- 
Catalin

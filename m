Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30765612BE9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 18:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJ3RaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 13:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3RaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 13:30:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77853A44C
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 10:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ABE4B80EBC
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 17:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902F3C433C1;
        Sun, 30 Oct 2022 17:30:12 +0000 (UTC)
Date:   Sun, 30 Oct 2022 17:30:09 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     will@kernel.org, jean-philippe@linaro.org, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: remove early archrandom abstraction
Message-ID: <Y160oanRPF3ZLINw@arm.com>
References: <20221028234025.82222-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028234025.82222-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 01:40:25AM +0200, Jason A. Donenfeld wrote:
> diff --git a/arch/arm64/include/asm/archrandom.h b/arch/arm64/include/asm/archrandom.h
> index 109e2a4454be..8a059a9033af 100644
> --- a/arch/arm64/include/asm/archrandom.h
> +++ b/arch/arm64/include/asm/archrandom.h
> @@ -58,6 +58,16 @@ static inline bool __arm64_rndrrs(unsigned long *v)
>  	return ok;
>  }
>  
> +static __always_inline bool __cpu_has_rng(void)
> +{
> +	if (!system_capabilities_finalized()) {
> +		/* Open code as we run prior to the first call to cpufeature. */
> +		unsigned long ftr = read_sysreg_s(SYS_ID_AA64ISAR0_EL1);
> +		return (ftr >> ID_AA64ISAR0_EL1_RNDR_SHIFT) & 0xf;
> +	}
> +	return cpus_have_const_cap(ARM64_HAS_RNG);
> +}

We need to be careful with this check as it is only valid on the CPU it
was called on. Is the result used only on this CPU and with the
preemption disabled? We have big.LITTLE systems where CPUs may differ
and the ARM64_HAS_RNG feature may not be enabled once all the CPUs have
been initialised (capabilities finalised).

We could make this capability an ARM64_CPUCAP_BOOT_CPU_FEATURE, though
I'd have to check whether any systems in the wild have such mixed CPUs.

-- 
Catalin

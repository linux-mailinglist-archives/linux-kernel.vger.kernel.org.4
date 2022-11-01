Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E4E6149BA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiKALrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 07:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiKALrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:47:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188F91A83A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 04:39:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3A21B81CE7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 11:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFA9C433D7;
        Tue,  1 Nov 2022 11:39:15 +0000 (UTC)
Date:   Tue, 1 Nov 2022 11:39:11 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v3] random: remove early archrandom abstraction
Message-ID: <Y2EFX5wGsjLwtO8j@arm.com>
References: <20221030212123.1022049-1-Jason@zx2c4.com>
 <20221031102840.85621-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031102840.85621-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 11:28:40AM +0100, Jason A. Donenfeld wrote:
> Catalin - Though this touches arm64's archrandom.h, I intend to take
> this through the random.git tree, if that's okay. I have other patches
> that will build off of this one. -Jason

I'm fine with the patch going through your tree but I have a comment
below.

> diff --git a/arch/arm64/include/asm/archrandom.h b/arch/arm64/include/asm/archrandom.h
> index 109e2a4454be..4b0f28730ab2 100644
> --- a/arch/arm64/include/asm/archrandom.h
> +++ b/arch/arm64/include/asm/archrandom.h
> @@ -58,6 +58,20 @@ static inline bool __arm64_rndrrs(unsigned long *v)
>  	return ok;
>  }
>  
> +static inline bool __early_cpu_has_rndr(void)
> +{
> +	/* Open code as we run prior to the first call to cpufeature. */
> +	unsigned long ftr = read_sysreg_s(SYS_ID_AA64ISAR0_EL1);
> +	return (ftr >> ID_AA64ISAR0_EL1_RNDR_SHIFT) & 0xf;
> +}
> +
> +static __always_inline bool __cpu_has_rng(void)
> +{
> +	if (!system_capabilities_finalized() && early_boot_irqs_disabled)
> +		return __early_cpu_has_rndr();
> +	return cpus_have_const_cap(ARM64_HAS_RNG);
> +}

I'm not sure about using early_boot_irqs_disabled, it is described as a
debug helper. It's also set to 'false' before
system_capabilities_finalized() (once the full SMP is enabled).

Would something like this work:

	if (system_capabilities_finalized())
		return cpus_have_final_cap(ARM64_HAS_RNG);
	if (!preemptible())
		return __early_cpu_has_rndr();
	return false;

We also have a this_cpu_has_cap() function, though it's likely more
expensive than the hand-coded __early_cpu_has_rndr() (if we care about
performance here).

-- 
Catalin

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DA25B87D7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiINMJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiINMJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:09:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B778B10FE1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:09:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BF6661CC8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 12:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0C0C433C1;
        Wed, 14 Sep 2022 12:09:43 +0000 (UTC)
Date:   Wed, 14 Sep 2022 13:09:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Evgenii Stepanov <eugenis@google.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Kenny Root <kroot@google.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4] arm64: mte: move register initialization to C
Message-ID: <YyHEhIvqY8y/PmTc@arm.com>
References: <20220907003630.1115439-1-eugenis@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907003630.1115439-1-eugenis@google.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 05:36:30PM -0700, Evgenii Stepanov wrote:
> If FEAT_MTE2 is disabled via the arm64.nomte command line argument on a
> CPU that claims to support FEAT_MTE2, the kernel will use Tagged Normal
> in the MAIR. If we interpret arm64.nomte to mean that the CPU does not
> in fact implement FEAT_MTE2, setting the system register like this may
> lead to UNSPECIFIED behavior. Fix it by arranging for MAIR to be set
> in the C function cpu_enable_mte which is called based on the sanitized
> version of the system register.
> 
> There is no need for the rest of the MTE-related system register
> initialization to happen from assembly, with the exception of TCR_EL1,
> which must be set to include at least TBI1 because the secondary CPUs
> access KASan-allocated data structures early. Therefore, make the TCR_EL1
> initialization unconditional and move the rest of the initialization to
> cpu_enable_mte so that we no longer have a dependency on the unsanitized
> ID register value.
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Signed-off-by: Evgenii Stepanov <eugenis@google.com>

Does this need a Co-developed-by from Peter? The sign-off on its own
doesn't make sense unless Peter sent the patch.

If we want this as a fix (though we have an alternative to transfer
mair_el12 to mair_el2), I'd also add:

Fixes: 3b714d24ef17 ("arm64: mte: CPU feature detection and initial sysreg configuration")
Cc: <stable@vger.kernel.org> # 5.10.x

together with some comment what it fixes.

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index af4de817d7123..d7a077b5ccd1c 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2034,7 +2034,8 @@ static void bti_enable(const struct arm64_cpu_capabilities *__unused)
>  static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
>  {
>  	sysreg_clear_set(sctlr_el1, 0, SCTLR_ELx_ATA | SCTLR_EL1_ATA0);

I wonder if we need to keep this here on its own rather than moving it
to mte_cpu_setup(). I guess we avoid writing this register the third
time on the resume path.

> -	isb();
> +
> +	mte_cpu_setup();
>  

So in principle I'm fine with moving the initialisation to C. However,
a concern I have is that we may no longer spot potential SoC issues that
trigger SErrors on tag accesses. The architecture does allow any Normal
Cacheable mapping to fetch tags, even if marked as untagged, though most
current implementations won't do this. In addition, if you run this in a
virtualised environment, a guest without this patch (or a malicious one)
can simply enable tagging in MAIR_EL1. HCR_EL2.ATA==0 does not have any
effect, so you haven't solved the problem.

So if part of RAM in your SoC does not support MTE, I don't think you
should rely on any kernel command-line options, just make sure no
untrusted guest can access memory that may trigger SErrors even if MTE
is disabled and the control registers level. Current behaviour (without
this patch) comes in handy to detect such issues.

-- 
Catalin

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21631665BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjAKMvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjAKMvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:51:11 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329D5DF47
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:51:09 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB20E1EC068D;
        Wed, 11 Jan 2023 13:51:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673441467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vO5zTy5BAn2/tS5FaOPoFVGJ+RHNwETq6LModQlJjBY=;
        b=geq1j2jz4IduM2C983TeYVLyHxWFG5sAfGc2JKecLsTpFYI0fyqx+reKyDhEMmrZN2FqTD
        0kxtTPpqCpHyVuxnfoaflp5KUwkNjggd9pmLX7HTlcd2BhRF72HN2cXl7E4CT20x3sQ1Pl
        539x9nvRpVvLTVxq1JSPLDrdA99VtDk=
Date:   Wed, 11 Jan 2023 13:51:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Breno Leitao <leitao@debian.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, jpoimboe@kernel.org, peterz@infradead.org,
        x86@kernel.org, cascardo@canonical.com, leit@meta.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/bugs: Explicitly clear speculative MSR bits
Message-ID: <Y76wtwWN1+XPbnQx@zn.tnic>
References: <20221128153148.1129350-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221128153148.1129350-1-leitao@debian.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 07:31:48AM -0800, Breno Leitao wrote:
> Currently x86_spec_ctrl_base is read at boot time, and speculative bits
> are set if configs are enable, such as MSR[SPEC_CTRL_IBRS] is enabled if
> CONFIG_CPU_IBRS_ENTRY is configured. These MSR bits are not cleared if
> the mitigations are disabled.
> 
> This is a problem when kexec-ing a kernel that has the mitigation
> disabled, from a kernel that has the mitigation enabled. In this case,
> the MSR bits are carried forward and not cleared at the boot of the new
> kernel. This might have some performance degradation that is hard to
> find.
> 
> This problem does not happen if the machine is (hard) rebooted, because
> the bit will be cleared by default.
> 
> Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/x86/include/asm/msr-index.h |  4 ++++
>  arch/x86/kernel/cpu/bugs.c       | 10 +++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 4a2af82553e4..22986a8f18bc 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -54,6 +54,10 @@
>  #define SPEC_CTRL_RRSBA_DIS_S_SHIFT	6	   /* Disable RRSBA behavior */
>  #define SPEC_CTRL_RRSBA_DIS_S		BIT(SPEC_CTRL_RRSBA_DIS_S_SHIFT)
>  
> +/* A mask for bits which the kernel toggles when controlling mitigations */
> +#define SPEC_CTRL_MITIGATIONS_MASK	(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD \
> +							| SPEC_CTRL_RRSBA_DIS_S)

SPEC_CTRL_RRSBA_DIS_S is a disable bit and I presume it needs to stay enabled.
Only when spec_ctrl_disable_kernel_rrsba() runs. And I'd say perf-wise it
doesn't cost that much...

Pawan?

> +
>  #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
>  #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
>  
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 3e3230cccaa7..4030358216c8 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -137,8 +137,16 @@ void __init check_bugs(void)
>  	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
>  	 * init code as it is not enumerated and depends on the family.
>  	 */
> -	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
> +	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
>  		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> +		/*
> +		 * Previously running software, like kexec for example, may
> +		 * have some controls turned ON.
> +		 * Clear them and let the mitigations setup below set them
> +		 * based on configuration.
> +		 */

                /*
                 * Previously running kernel (kexec), may have some controls
                 * turned ON. Clear them and let the mitigations setup below
                 * rediscover them based on configuration.
                 */

There's no "previously running software, like kexec".

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

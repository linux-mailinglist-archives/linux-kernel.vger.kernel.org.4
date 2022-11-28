Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0262639E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 01:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiK1Amj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 19:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiK1Amh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 19:42:37 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7CBE8A
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 16:42:34 -0800 (PST)
Received: from zn.tnic (p200300ea9733e719329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e719:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E35E41EC053B;
        Mon, 28 Nov 2022 01:42:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669596152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bMLYVDRFQu0xZlrSISkRGflSMD7PVN2QZhUpSDHouPk=;
        b=FZKB1KxuIZfv4kYD/beb2eUzuk3Al9dTZCB0d9UD5VyHPi/VPZnLfuTW66mN6xYW5P/sSl
        sq8oRSmdGLzJU4Wnu8P34D/d18Aan4et5SoXKhHClY4XuVqhu6Ba38DWA8i7tRXBDoPFhc
        KqAcMlzgOXFfpDV6QhqgQskpCzvOVaU=
Date:   Mon, 28 Nov 2022 01:42:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Breno Leitao <leitao@debian.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, jpoimboe@kernel.org, peterz@infradead.org,
        pawan.kumar.gupta@linux.intel.com, x86@kernel.org,
        cascardo@canonical.com, leit@meta.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/bugs: Explicitly clear speculative MSR bits
Message-ID: <Y4QD8o8kWb1V4osq@zn.tnic>
References: <20221124104650.533427-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221124104650.533427-1-leitao@debian.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 02:46:50AM -0800, Breno Leitao wrote:
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
> This patch also defines a SPEC_CTRL_MASK macro, so, we can easily track
> and clear if eventually some new mitigation shows up.

Just remove that sentence - the macro's function is kinda obvious from
the diff itself.

> Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/x86/include/asm/msr-index.h | 3 +++
>  arch/x86/kernel/cpu/bugs.c       | 9 ++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 4a2af82553e4..704f49580ee1 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -54,6 +54,9 @@
>  #define SPEC_CTRL_RRSBA_DIS_S_SHIFT	6	   /* Disable RRSBA behavior */
>  #define SPEC_CTRL_RRSBA_DIS_S		BIT(SPEC_CTRL_RRSBA_DIS_S_SHIFT)
>  
> +#define SPEC_CTRL_MASK			(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD \
> +							| SPEC_CTRL_RRSBA_DIS_S)

Call that SPEC_CTRL_MITIGATIONS_MASK or so to denote what it is - a
mask of the SPEC_CTRL bits which the kernel toggles when controlling
mitigations.

A comment above it wouldn't hurt either.

> +
>  #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
>  #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
>  
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 3e3230cccaa7..88957da1029b 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -137,8 +137,15 @@ void __init check_bugs(void)
>  	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
>  	 * init code as it is not enumerated and depends on the family.
>  	 */
> -	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
> +	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
>  		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> +		/*
> +		 * Previously running software may have some controls turned ON.

"Previously running software, like kexec for example, ..."

> +		 * Clear them and let kernel decide which controls to use.

"Clear them and let the mitigations setup below set them based on configuration."

> +		 */
> +		x86_spec_ctrl_base &= ~SPEC_CTRL_MASK;
> +		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);

So this WRMSR will happen on the BSP only but the SPEC_CTRL MSR is
per-CPU. As is x86_spec_ctrl_current which tracks it.

So I'd say you don't need that WRMSR here - the proper value will get
replicated eventually everywhere...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

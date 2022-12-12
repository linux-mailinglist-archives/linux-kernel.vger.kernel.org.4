Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FD364A8B0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiLLUXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiLLUXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:23:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D507B26DF;
        Mon, 12 Dec 2022 12:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670876617; x=1702412617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cwt1okdWNlX5OjC33VLxJ95ouJ4xQF1dorpCph53eH8=;
  b=V4HZRrSIuKOFtZPTVRiDVVLsGFNJLRZCsPQU61Z7ZljEIOWOiZbLIdR1
   wMvdC0J3w3coxrlmz5rHSfdIRtN43LIS/GToX/2z8mLtKIxGtajjb7Dzh
   b8xIAIJX94chyQIK5T7tS99s4uOuWXtaqFkK3G4CnOXxGVmLrgekAZhqQ
   K+dpSRdbanoBzlbY7Yh+3bhJt9mSM6sa88qzLthTyHhvXz04aCcebJHTv
   Vn5W+iRKQ1lazqn45gbSvbEkjrTbPePXN9hcMmtnVQJY42z52B0lsj6pJ
   /oK468ep8zNsUui1dhRvPJbapvg9HJholWMcVUVwGSanzxWXdrKNZUO5a
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="316655491"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="316655491"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 12:23:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="650471643"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="650471643"
Received: from cwholzwa-mobl.amr.corp.intel.com (HELO desk) ([10.209.108.80])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 12:23:36 -0800
Date:   Mon, 12 Dec 2022 12:23:34 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Zhang Chen <chen.zhang@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Chao Gao <chao.gao@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 5/9] x86/bugs: Use Virtual MSRs to request hardware
 mitigations
Message-ID: <20221212202334.ldrgv7fnkgjtsogg@desk>
References: <20221210160046.2608762-1-chen.zhang@intel.com>
 <20221210160046.2608762-6-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221210160046.2608762-6-chen.zhang@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 12:00:42AM +0800, Zhang Chen wrote:
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> 
> Guests that have different family/model than the host may not be aware
> of hardware mitigations(such as RRSBA_DIS_S) available on host. This is
> particularly true when guests migrate. To solve this problem Intel
> processors have added a virtual MSR interface through which guests can
> report their mitigation status and request VMM to deploy relevant
> hardware mitigations.
> 
> Use this virtualized MSR interface to request relevant hardware controls
> for retpoline mitigation.
> 
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/include/asm/msr-index.h | 23 +++++++++++++++++++++++
>  arch/x86/kernel/cpu/bugs.c       | 24 ++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 1143ac9400c3..1166b472377c 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -165,6 +165,7 @@
>  						 * IA32_XAPIC_DISABLE_STATUS MSR
>  						 * supported
>  						 */
> +#define ARCH_CAP_VIRTUAL_ENUM		BIT(63)	/* MSR_VIRTUAL_ENUMERATION supported */
>  
>  #define MSR_IA32_FLUSH_CMD		0x0000010b
>  #define L1D_FLUSH			BIT(0)	/*
> @@ -1062,6 +1063,28 @@
>  #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
>  #define MSR_IA32_VMX_MISC_VMWRITE_SHADOW_RO_FIELDS (1ULL << 29)
>  #define MSR_IA32_VMX_MISC_PREEMPTION_TIMER_SCALE   0x1F
> +
> +/* Intel virtual MSRs */
> +#define MSR_VIRTUAL_ENUMERATION			0x50000000
> +#define VIRT_ENUM_MITIGATION_CTRL_SUPPORT	BIT(0)	/*
> +							 * Mitigation ctrl via virtual
> +							 * MSRs supported
> +							 */
> +
> +#define MSR_VIRTUAL_MITIGATION_ENUM		0x50000001
> +#define MITI_ENUM_BHB_CLEAR_SEQ_S_SUPPORT	BIT(0)	/* VMM supports BHI_DIS_S */
> +#define MITI_ENUM_RETPOLINE_S_SUPPORT		BIT(1)	/* VMM supports RRSBA_DIS_S */
> +
> +#define MSR_VIRTUAL_MITIGATION_CTRL		0x50000002
> +#define MITI_CTRL_BHB_CLEAR_SEQ_S_USED		BIT(0)	/*
> +							 * Request VMM to deploy
> +							 * BHI_DIS_S mitigation
> +							 */
> +#define MITI_CTRL_RETPOLINE_S_USED		BIT(1)	/*
> +							 * Request VMM to deploy
> +							 * RRSBA_DIS_S mitigation
> +							 */
> +
>  /* AMD-V MSRs */
>  
>  #define MSR_VM_CR                       0xc0010114
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 3e3230cccaa7..a9e869f568ee 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1379,6 +1379,28 @@ static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_
>  	dump_stack();
>  }
>  
> +/* Speculation control using virtualized MSRs */
> +static void __init spec_ctrl_setup_virtualized_msr(void)
> +{
> +	u64 msr_virt_enum, msr_mitigation_enum, msr_mitigation_ctrl;
> +
> +	if (!(x86_read_arch_cap_msr() & ARCH_CAP_VIRTUAL_ENUM))
> +		return;
> +
> +	rdmsrl(MSR_VIRTUAL_ENUMERATION, msr_virt_enum);
> +	if (!(msr_virt_enum & VIRT_ENUM_MITIGATION_CTRL_SUPPORT))
> +		return;
> +
> +	rdmsrl(MSR_VIRTUAL_MITIGATION_ENUM, msr_mitigation_enum);
> +	/* When retpoline is being used, request relevant hardware controls */
> +	if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
> +	    msr_mitigation_enum & MITI_ENUM_RETPOLINE_S_SUPPORT) {
> +		rdmsrl(MSR_VIRTUAL_MITIGATION_CTRL, msr_mitigation_ctrl);
> +		msr_mitigation_ctrl |= MITI_CTRL_RETPOLINE_S_USED;
> +		wrmsrl(MSR_VIRTUAL_MITIGATION_CTRL, msr_mitigation_ctrl);
> +	}
> +}
> +
>  static void __init spectre_v2_select_mitigation(void)
>  {
>  	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
> @@ -1485,6 +1507,8 @@ static void __init spectre_v2_select_mitigation(void)
>  	    mode == SPECTRE_V2_RETPOLINE)
>  		spec_ctrl_disable_kernel_rrsba();
>  
> +	spec_ctrl_setup_virtualized_msr();

I think this also needs to be called during secondary CPU
initialization.

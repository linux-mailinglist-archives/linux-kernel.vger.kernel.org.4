Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB88F712E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242689AbjEZUsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237856AbjEZUsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:48:07 -0400
Received: from out-59.mta1.migadu.com (out-59.mta1.migadu.com [IPv6:2001:41d0:203:375::3b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203D9E49
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:47:59 -0700 (PDT)
Date:   Fri, 26 May 2023 20:47:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685134077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tTm2WcrJtXgUhrQ3ARrtwiMqmV3Xwo18CAjwr9+QLWY=;
        b=uvfcrkBUbEDQTPKSbgcgCTVg5y5DWONMaNXAcOakixAHywg4BZLgE0rXpYTC7kb8HKu3rH
        /iS9JzWfI3CLzV7tEdkKLcCA74Jq7pfpsJX7Aqk1OCDLu7ggVft9xcHX+lFqRcTXjdjLvD
        +GzCLvYPATDFTg7QvVtz2+1A0Dr9Ufc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Mostafa Saleh <smostafa@google.com>
Cc:     maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        tabba@google.com, kaleshsingh@google.com, will@kernel.org,
        catalin.marinas@arm.com, yuzenghui@huawei.com,
        suzuki.poulose@arm.com, james.morse@arm.com
Subject: Re: [PATCH] KVM: arm64: Use different pointer authentication keys
 for pKVM
Message-ID: <ZHEa+HAixbYijQTA@linux.dev>
References: <20230516141531.791492-1-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516141531.791492-1-smostafa@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 02:15:31PM +0000, Mostafa Saleh wrote:
> When the kernel is compiled with CONFIG_ARM64_PTR_AUTH_KERNEL, it
> uses Armv8.3-Pauth for return address protection for the kernel code
> including nvhe code in EL2.
> 
> Same keys are used in both kernel(EL1) and nvhe code(EL2), this is
> fine for nvhe but not when running in protected mode(pKVM) as the host
> can't be trusted.

But we trust it enough to hand pKVM a fresh set of keys before firing
off? I understand there is some degree of initialization required to get
pKVM off the ground, but I question in this case if key handoff is
strictly necessary.

There are potentially other sources of random directly available at EL2,
such as the SMCCC TRNG ABI or FEAT_RNG. Should pKVM prefer one of these
random implementations and only fall back to host-provided keys if
absolutely necessary?

> The keys for the hypervisor are generated from the kernel before it
> de-privileges, each cpu has different keys, this relies on nvhe code
> not being migratable while running.
> 
> This patch adds host/hyp save/restore for the keys.
> For guest/hyp, they are already handled in common kvm code in
> __guest_enter, where they are saved/restored if they are not
> trapped.

Try to avoid "this patch" or any self-referential language in the
changelog. Just directly state what the patch does:

  Similar to guest entry/exit, start context switching the pointer
  authentication keys on host/entry exit if the feature is in use.

> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  arch/arm64/kvm/arm.c           | 26 +++++++++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/host.S | 35 +++++++++++++++++++++++++++++++++-
>  2 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 14391826241c..dd03b52f035d 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -51,6 +51,8 @@ DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
>  DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
>  DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
>  
> +DECLARE_KVM_NVHE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);
> +
>  static bool vgic_present;
>  
>  static DEFINE_PER_CPU(unsigned char, kvm_arm_hardware_enabled);
> @@ -2067,6 +2069,26 @@ static int __init kvm_hyp_init_protection(u32 hyp_va_bits)
>  	return 0;
>  }
>  
> +static void pkvm_hyp_init_ptrauth(void)
> +{
> +	struct kvm_cpu_context *hyp_ctxt;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		hyp_ctxt = per_cpu_ptr_nvhe_sym(kvm_hyp_ctxt, cpu);
> +		hyp_ctxt->sys_regs[APIAKEYLO_EL1] = get_random_long();
> +		hyp_ctxt->sys_regs[APIAKEYHI_EL1] = get_random_long();
> +		hyp_ctxt->sys_regs[APIBKEYLO_EL1] = get_random_long();
> +		hyp_ctxt->sys_regs[APIBKEYHI_EL1] = get_random_long();
> +		hyp_ctxt->sys_regs[APDAKEYLO_EL1] = get_random_long();
> +		hyp_ctxt->sys_regs[APDAKEYHI_EL1] = get_random_long();
> +		hyp_ctxt->sys_regs[APDBKEYLO_EL1] = get_random_long();
> +		hyp_ctxt->sys_regs[APDBKEYHI_EL1] = get_random_long();
> +		hyp_ctxt->sys_regs[APGAKEYLO_EL1] = get_random_long();
> +		hyp_ctxt->sys_regs[APGAKEYHI_EL1] = get_random_long();
> +	}
> +}
> +
>  /* Inits Hyp-mode on all online CPUs */
>  static int __init init_hyp_mode(void)
>  {
> @@ -2228,6 +2250,10 @@ static int __init init_hyp_mode(void)
>  	kvm_hyp_init_symbols();
>  
>  	if (is_protected_kvm_enabled()) {
> +		if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL) &&
> +		    cpus_have_const_cap(ARM64_HAS_ADDRESS_AUTH))
> +			pkvm_hyp_init_ptrauth();
> +
>  		init_cpu_logical_map();
>  
>  		if (!init_psci_relay()) {
> diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
> index b6c0188c4b35..255ba4af911b 100644
> --- a/arch/arm64/kvm/hyp/nvhe/host.S
> +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> @@ -10,6 +10,7 @@
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_mmu.h>
> +#include <asm/kvm_ptrauth.h>
>  
>  	.text
>  
> @@ -37,10 +38,42 @@ SYM_FUNC_START(__host_exit)
>  
>  	/* Save the host context pointer in x29 across the function call */
>  	mov	x29, x0
> +
> +#ifdef CONFIG_ARM64_PTR_AUTH_KERNEL
> +alternative_if_not ARM64_HAS_ADDRESS_AUTH
> +b __skip_pauth_save
> +alternative_else_nop_endif
> +
> +alternative_if ARM64_KVM_PROTECTED_MODE
> +	/* Save kernel ptrauth keys. */
> +	add x18, x29, #CPU_APIAKEYLO_EL1
> +	ptrauth_save_state x18, x19, x20
> +
> +	/* Use hyp keys. */
> +	adr_this_cpu x18, kvm_hyp_ctxt, x19
> +	add x18, x18, #CPU_APIAKEYLO_EL1
> +	ptrauth_restore_state x18, x19, x20
> +alternative_else_nop_endif
> +__skip_pauth_save:
> +#endif /* CONFIG_ARM64_PTR_AUTH_KERNEL */
> +
>  	bl	handle_trap
>  
> -	/* Restore host regs x0-x17 */
>  __host_enter_restore_full:
> +	/* Restore kernel keys. */
> +#ifdef CONFIG_ARM64_PTR_AUTH_KERNEL
> +alternative_if_not ARM64_HAS_ADDRESS_AUTH
> +b __skip_pauth_restore
> +alternative_else_nop_endif
> +
> +alternative_if ARM64_KVM_PROTECTED_MODE
> +	add x18, x29, #CPU_APIAKEYLO_EL1
> +	ptrauth_restore_state x18, x19, x20
> +alternative_else_nop_endif
> +__skip_pauth_restore:
> +#endif /* CONFIG_ARM64_PTR_AUTH_KERNEL */
> +
> +	/* Restore host regs x0-x17 */
>  	ldp	x0, x1,   [x29, #CPU_XREG_OFFSET(0)]
>  	ldp	x2, x3,   [x29, #CPU_XREG_OFFSET(2)]
>  	ldp	x4, x5,   [x29, #CPU_XREG_OFFSET(4)]
> -- 
> 2.40.1.606.ga4b1b128d6-goog
> 

-- 
Thanks,
Oliver

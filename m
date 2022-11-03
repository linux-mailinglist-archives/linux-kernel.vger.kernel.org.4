Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD608617E35
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiKCNmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiKCNm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:42:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19051838E;
        Thu,  3 Nov 2022 06:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667482909; x=1699018909;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8ktU2hu7h0zttKmBJOAlUSnSucgO9UQaEqpRzzyWxqA=;
  b=oBzuEm239SRJo+g5atezmz3D9a6H7pmDcEhnwwbxNqCiF2BsWfKWg/Ci
   G6lH/3fRYbemBkPGyQ2oUcPzVXQhYAtnew5VTitvY/BkURq7AeGJQddWX
   f1uakDa+AKYDpM4AsN7NZc3BaHT+rIciTPGwayih6ZsJKr/VFvU9vbB/W
   tm9DxUoQsB3FXWZ2FehqyHMRhPHW94KzJyULQpri8vRS2YX1/dSyn14cw
   RTs5bpvRZnY7VfJsrIcfXouDc4VSLYOBmbfn3zoi75Cr2d4M/hpMGzIy7
   9YF7X5ztzcifpX7O/+XUo6WNKB5+lO5MhRvHyHemohOgO9HwE2ztLRiWZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="290071080"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="290071080"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 06:41:49 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809670642"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="809670642"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.255.28.201]) ([10.255.28.201])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 06:41:46 -0700
Message-ID: <89ee8b63-bdce-0779-3c05-1a0516076156@linux.intel.com>
Date:   Thu, 3 Nov 2022 21:41:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v10 039/108] KVM: VMX: Introduce test mode related to EPT
 violation VE
To:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        erdemaktas@google.com, Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>
References: <cover.1667110240.git.isaku.yamahata@intel.com>
 <8b3101711c5291246653efb50cc2975863d3a8ab.1667110240.git.isaku.yamahata@intel.com>
From:   Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <8b3101711c5291246653efb50cc2975863d3a8ab.1667110240.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/10/30 14:22, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> To support TDX, KVM is enhanced to operate with #VE.  For TDX, KVM programs
> to inject #VE conditionally and set #VE suppress bit in EPT entry.  For VMX
> case, #VE isn't used.  If #VE happens for VMX, it's a bug.  To be
> defensive (test that VMX case isn't broken), introduce option
> ept_violation_ve_test and when it's set, set error.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   arch/x86/include/asm/vmx.h | 12 +++++++
>   arch/x86/kvm/vmx/vmcs.h    |  5 +++
>   arch/x86/kvm/vmx/vmx.c     | 69 +++++++++++++++++++++++++++++++++++++-
>   arch/x86/kvm/vmx/vmx.h     |  6 +++-
>   4 files changed, 90 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index cdbf12c1a83c..752d53652007 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -68,6 +68,7 @@
>   #define SECONDARY_EXEC_ENCLS_EXITING		VMCS_CONTROL_BIT(ENCLS_EXITING)
>   #define SECONDARY_EXEC_RDSEED_EXITING		VMCS_CONTROL_BIT(RDSEED_EXITING)
>   #define SECONDARY_EXEC_ENABLE_PML               VMCS_CONTROL_BIT(PAGE_MOD_LOGGING)
> +#define SECONDARY_EXEC_EPT_VIOLATION_VE		VMCS_CONTROL_BIT(EPT_VIOLATION_VE)
>   #define SECONDARY_EXEC_PT_CONCEAL_VMX		VMCS_CONTROL_BIT(PT_CONCEAL_VMX)
>   #define SECONDARY_EXEC_XSAVES			VMCS_CONTROL_BIT(XSAVES)
>   #define SECONDARY_EXEC_MODE_BASED_EPT_EXEC	VMCS_CONTROL_BIT(MODE_BASED_EPT_EXEC)
> @@ -223,6 +224,8 @@ enum vmcs_field {
>   	VMREAD_BITMAP_HIGH              = 0x00002027,
>   	VMWRITE_BITMAP                  = 0x00002028,
>   	VMWRITE_BITMAP_HIGH             = 0x00002029,
> +	VE_INFORMATION_ADDRESS		= 0x0000202A,
> +	VE_INFORMATION_ADDRESS_HIGH	= 0x0000202B,
>   	XSS_EXIT_BITMAP                 = 0x0000202C,
>   	XSS_EXIT_BITMAP_HIGH            = 0x0000202D,
>   	ENCLS_EXITING_BITMAP		= 0x0000202E,
> @@ -628,4 +631,13 @@ enum vmx_l1d_flush_state {
>   
>   extern enum vmx_l1d_flush_state l1tf_vmx_mitigation;
>   
> +struct vmx_ve_information {
> +	u32 exit_reason;
> +	u32 delivery;
> +	u64 exit_qualification;
> +	u64 guest_linear_address;
> +	u64 guest_physical_address;
> +	u16 eptp_index;
> +};
> +
>   #endif
> diff --git a/arch/x86/kvm/vmx/vmcs.h b/arch/x86/kvm/vmx/vmcs.h
> index ac290a44a693..9277676057a7 100644
> --- a/arch/x86/kvm/vmx/vmcs.h
> +++ b/arch/x86/kvm/vmx/vmcs.h
> @@ -140,6 +140,11 @@ static inline bool is_nm_fault(u32 intr_info)
>   	return is_exception_n(intr_info, NM_VECTOR);
>   }
>   
> +static inline bool is_ve_fault(u32 intr_info)
> +{
> +	return is_exception_n(intr_info, VE_VECTOR);
> +}
> +
>   /* Undocumented: icebp/int1 */
>   static inline bool is_icebp(u32 intr_info)
>   {
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index f890191e8580..dd3fde9d3c32 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -126,6 +126,9 @@ module_param(error_on_inconsistent_vmcs_config, bool, 0444);
>   static bool __read_mostly dump_invalid_vmcs = 0;
>   module_param(dump_invalid_vmcs, bool, 0644);
>   
> +static bool __read_mostly ept_violation_ve_test;
> +module_param(ept_violation_ve_test, bool, 0444);
> +
>   #define MSR_BITMAP_MODE_X2APIC		1
>   #define MSR_BITMAP_MODE_X2APIC_APICV	2
>   
> @@ -783,6 +786,13 @@ void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu)
>   
>   	eb = (1u << PF_VECTOR) | (1u << UD_VECTOR) | (1u << MC_VECTOR) |
>   	     (1u << DB_VECTOR) | (1u << AC_VECTOR);
> +	/*
> +	 * #VE isn't used for VMX, but for TDX.  To test against unexpected
> +	 * change related to #VE for VMX, intercept unexpected #VE and warn on
> +	 * it.
> +	 */
> +	if (ept_violation_ve_test)
> +		eb |= 1u << VE_VECTOR;
>   	/*
>   	 * Guest access to VMware backdoor ports could legitimately
>   	 * trigger #GP because of TSS I/O permission bitmap.
> @@ -2644,6 +2654,9 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>   					&_cpu_based_2nd_exec_control))
>   			return -EIO;
>   	}
> +	if (!ept_violation_ve_test)
> +		_cpu_based_exec_control &= ~SECONDARY_EXEC_EPT_VIOLATION_VE;

should be _cpu_based_2nd_exec_control


> +
>   #ifndef CONFIG_X86_64
>   	if (!(_cpu_based_2nd_exec_control &
>   				SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES))
> @@ -2668,6 +2681,7 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>   			return -EIO;
>   
>   		vmx_cap->ept = 0;
> +		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_EPT_VIOLATION_VE;
>   	}
>   	if (!(_cpu_based_2nd_exec_control & SECONDARY_EXEC_ENABLE_VPID) &&
>   	    vmx_cap->vpid) {
> @@ -4510,6 +4524,7 @@ static u32 vmx_secondary_exec_control(struct vcpu_vmx *vmx)
>   		exec_control &= ~SECONDARY_EXEC_ENABLE_VPID;
>   	if (!enable_ept) {
>   		exec_control &= ~SECONDARY_EXEC_ENABLE_EPT;
> +		exec_control &= ~SECONDARY_EXEC_EPT_VIOLATION_VE;
>   		enable_unrestricted_guest = 0;
>   	}
>   	if (!enable_unrestricted_guest)
> @@ -4637,8 +4652,40 @@ static void init_vmcs(struct vcpu_vmx *vmx)
>   
>   	exec_controls_set(vmx, vmx_exec_control(vmx));
>   
> -	if (cpu_has_secondary_exec_ctrls())
> +	if (cpu_has_secondary_exec_ctrls()) {
>   		secondary_exec_controls_set(vmx, vmx_secondary_exec_control(vmx));
> +		if (secondary_exec_controls_get(vmx) &
> +		    SECONDARY_EXEC_EPT_VIOLATION_VE) {
> +			if (!vmx->ve_info) {
> +				/* ve_info must be page aligned. */
> +				struct page *page;
> +
> +				BUILD_BUG_ON(sizeof(*vmx->ve_info) > PAGE_SIZE);
> +				page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> +				if (page)
> +					vmx->ve_info = page_to_virt(page);
> +			}
> +			if (vmx->ve_info) {
> +				/*
> +				 * Allow #VE delivery. CPU sets this field to
> +				 * 0xFFFFFFFF on #VE delivery.  Another #VE can
> +				 * occur only if software clears the field.
> +				 */
> +				vmx->ve_info->delivery = 0;
> +				vmcs_write64(VE_INFORMATION_ADDRESS,
> +					     __pa(vmx->ve_info));
> +			} else {
> +				/*
> +				 * Because SECONDARY_EXEC_EPT_VIOLATION_VE is
> +				 * used only when ept_violation_ve_test is true,
> +				 * it's okay to go with the bit disabled.
> +				 */
> +				pr_err("Failed to allocate ve_info. disabling EPT_VIOLATION_VE.\n");
> +				secondary_exec_controls_clearbit(vmx,
> +								 SECONDARY_EXEC_EPT_VIOLATION_VE);
> +			}
> +		}
> +	}
>   
>   	if (cpu_has_tertiary_exec_ctrls())
>   		tertiary_exec_controls_set(vmx, vmx_tertiary_exec_control(vmx));
> @@ -5118,6 +5165,12 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
>   	if (is_invalid_opcode(intr_info))
>   		return handle_ud(vcpu);
>   
> +	/*
> +	 * #VE isn't supposed to happen.  Although vcpu can send
> +	 */
> +	if (KVM_BUG_ON(is_ve_fault(intr_info), vcpu->kvm))
> +		return -EIO;
> +
>   	error_code = 0;
>   	if (intr_info & INTR_INFO_DELIVER_CODE_MASK)
>   		error_code = vmcs_read32(VM_EXIT_INTR_ERROR_CODE);
> @@ -6306,6 +6359,18 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
>   	if (secondary_exec_control & SECONDARY_EXEC_ENABLE_VPID)
>   		pr_err("Virtual processor ID = 0x%04x\n",
>   		       vmcs_read16(VIRTUAL_PROCESSOR_ID));
> +	if (secondary_exec_control & SECONDARY_EXEC_EPT_VIOLATION_VE) {
> +		struct vmx_ve_information *ve_info;
> +
> +		pr_err("VE info address = 0x%016llx\n",
> +		       vmcs_read64(VE_INFORMATION_ADDRESS));
> +		ve_info = __va(vmcs_read64(VE_INFORMATION_ADDRESS));
> +		pr_err("ve_info: 0x%08x 0x%08x 0x%016llx 0x%016llx 0x%016llx 0x%04x\n",
> +		       ve_info->exit_reason, ve_info->delivery,
> +		       ve_info->exit_qualification,
> +		       ve_info->guest_linear_address,
> +		       ve_info->guest_physical_address, ve_info->eptp_index);
> +	}
>   }
>   
>   /*
> @@ -7302,6 +7367,8 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu)
>   	free_vpid(vmx->vpid);
>   	nested_vmx_free_vcpu(vcpu);
>   	free_loaded_vmcs(vmx->loaded_vmcs);
> +	if (vmx->ve_info)
> +		free_page((unsigned long)vmx->ve_info);
>   }
>   
>   int vmx_vcpu_create(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index d49d0ace9fb8..1813caeb24d8 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -359,6 +359,9 @@ struct vcpu_vmx {
>   		DECLARE_BITMAP(read, MAX_POSSIBLE_PASSTHROUGH_MSRS);
>   		DECLARE_BITMAP(write, MAX_POSSIBLE_PASSTHROUGH_MSRS);
>   	} shadow_msr_intercept;
> +
> +	/* ve_info must be page aligned. */
> +	struct vmx_ve_information *ve_info;
>   };
>   
>   struct kvm_vmx {
> @@ -570,7 +573,8 @@ static inline u8 vmx_get_rvi(void)
>   	 SECONDARY_EXEC_ENABLE_VMFUNC |					\
>   	 SECONDARY_EXEC_BUS_LOCK_DETECTION |				\
>   	 SECONDARY_EXEC_NOTIFY_VM_EXITING |				\
> -	 SECONDARY_EXEC_ENCLS_EXITING)
> +	 SECONDARY_EXEC_ENCLS_EXITING |					\
> +	 SECONDARY_EXEC_EPT_VIOLATION_VE)
>   
>   #define KVM_REQUIRED_VMX_TERTIARY_VM_EXEC_CONTROL 0
>   #define KVM_OPTIONAL_VMX_TERTIARY_VM_EXEC_CONTROL			\

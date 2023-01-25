Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA8A67ADE0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbjAYJal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbjAYJaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:30:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8028A1ABCC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674638986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1C+0FjPfVRei4W8vyOzxXVXejQSTWzMmOkH8GQ0Kzi0=;
        b=RhjZpg4mo3P5sZfz7ETPuFs5vACi3jeNiwnvrWpZ6fLhfMfdLtDS81VTWHW1bA/GAi9Bcg
        iJTn28k7oCBBPAMR1vR1roehU0nsfBFZDwL+334O813hfhqjQRSzgjQQ1rrPO8GZFd8sxM
        w8mB+g88mc5DLx4YkA8JVvFVSa9uVds=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-446-rSbftsQwNhuvdSAu5JepxQ-1; Wed, 25 Jan 2023 04:29:45 -0500
X-MC-Unique: rSbftsQwNhuvdSAu5JepxQ-1
Received: by mail-qk1-f198.google.com with SMTP id u10-20020a05620a0c4a00b00705e77d6207so12457381qki.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1C+0FjPfVRei4W8vyOzxXVXejQSTWzMmOkH8GQ0Kzi0=;
        b=y1eDdmL+QLgmgr33CO6PmM2zDVbmZG3jJBrMZLQvLAigRTOFIEuMdv3J8sNDIdImfI
         xYmk1aMCgmKh+Of7Nkg+PwNf6k7T2XO2aHCH3MebFill2JoLTnXcgBvxXXmxA1o173F+
         RgOrkmYsgNLJ2RjAsclKm3+2HIULG2U6QJaT+Pp9dgR9G0X4PHb0WJoAMwT/IrAhd7D6
         GqH9NtAQK0u2P/5rVDu9ZOpbDSjUnhSxQKe3Tq2ZDc6s0/8K+3AamVUpucj15sTfKIJg
         STbSOUWzbD8YSyoUv9QFUYBFrA8lDzUyUTEE9cNEP3hnbBGNYShLirYiidUIZ2QUKZQ9
         v8yg==
X-Gm-Message-State: AO0yUKXjdJT5NWBpkQhZuGcOpzL3Pz3qtuouxdmFe1hYSNEPKo9BJ7jm
        FRGC7lL8cxjep874LPikPtKVcQMGckNY3QptyxHO9S7+ZXud1V0yToe4j0AEUhgBhoksf7we4FB
        RaCR8zPPBFku7z1Fi4JDYLbYn
X-Received: by 2002:a05:622a:1443:b0:3b6:3697:63fa with SMTP id v3-20020a05622a144300b003b6369763famr2710956qtx.28.1674638984656;
        Wed, 25 Jan 2023 01:29:44 -0800 (PST)
X-Google-Smtp-Source: AK7set/miymPmji0URXPaMfKsdTTs4TjY5AMNfwyDVYyvLKm3Pkt4hwn5ydXGIOn6SOEOGveS+o4mQ==
X-Received: by 2002:a05:622a:1443:b0:3b6:3697:63fa with SMTP id v3-20020a05622a144300b003b6369763famr2710937qtx.28.1674638984343;
        Wed, 25 Jan 2023 01:29:44 -0800 (PST)
Received: from ovpn-194-126.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r2-20020ac83b42000000b003b6464eda40sm3003461qtf.25.2023.01.25.01.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 01:29:43 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aaron Lewis <aaronlewis@google.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Like Xu <likexu@tencent.com>
Subject: Re: [PATCH 2/6] KVM: x86/pmu: Gate all "unimplemented MSR" prints
 on report_ignored_msrs
In-Reply-To: <20230124234905.3774678-3-seanjc@google.com>
References: <20230124234905.3774678-1-seanjc@google.com>
 <20230124234905.3774678-3-seanjc@google.com>
Date:   Wed, 25 Jan 2023 10:29:40 +0100
Message-ID: <87bkmn55dn.fsf@ovpn-194-126.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Add helpers to print unimplemented MSR accesses and condition all such
> prints on report_ignored_msrs, i.e. honor userspace's request to not
> print unimplemented MSRs.  Even though vcpu_unimpl() is ratelimited,
> printing can still be problematic, e.g. if a print gets stalled when host
> userspace is writing MSRs during live migration, an effective stall can
> result in very noticeable disruption in the guest.
>
> E.g. the profile below was taken while calling KVM_SET_MSRS on the PMU
> counters while the PMU was disabled in KVM.
>
>   -   99.75%     0.00%  [.] __ioctl
>    - __ioctl
>       - 99.74% entry_SYSCALL_64_after_hwframe
>            do_syscall_64
>            sys_ioctl
>          - do_vfs_ioctl
>             - 92.48% kvm_vcpu_ioctl
>                - kvm_arch_vcpu_ioctl
>                   - 85.12% kvm_set_msr_ignored_check
>                        svm_set_msr
>                        kvm_set_msr_common
>                        printk
>                        vprintk_func
>                        vprintk_default
>                        vprintk_emit
>                        console_unlock
>                        call_console_drivers
>                        univ8250_console_write
>                        serial8250_console_write
>                        uart_console_write
>
> Reported-by: Aaron Lewis <aaronlewis@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/hyperv.c  | 10 ++++------
>  arch/x86/kvm/svm/svm.c |  5 ++---
>  arch/x86/kvm/vmx/vmx.c |  4 +---
>  arch/x86/kvm/x86.c     | 18 +++++-------------
>  arch/x86/kvm/x86.h     | 12 ++++++++++++
>  5 files changed, 24 insertions(+), 25 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 71aff0edc0ed..3eb8caf87ee4 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1430,8 +1430,7 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
>  	case HV_X64_MSR_SYNDBG_CONTROL ... HV_X64_MSR_SYNDBG_PENDING_BUFFER:
>  		return syndbg_set_msr(vcpu, msr, data, host);
>  	default:
> -		vcpu_unimpl(vcpu, "Hyper-V unhandled wrmsr: 0x%x data 0x%llx\n",
> -			    msr, data);
> +		kvm_pr_unimpl_wrmsr(vcpu, msr, data);
>  		return 1;
>  	}
>  	return 0;
> @@ -1552,8 +1551,7 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
>  			return 1;
>  		break;
>  	default:
> -		vcpu_unimpl(vcpu, "Hyper-V unhandled wrmsr: 0x%x data 0x%llx\n",
> -			    msr, data);
> +		kvm_pr_unimpl_wrmsr(vcpu, msr, data);
>  		return 1;
>  	}
>  
> @@ -1608,7 +1606,7 @@ static int kvm_hv_get_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
>  	case HV_X64_MSR_SYNDBG_CONTROL ... HV_X64_MSR_SYNDBG_PENDING_BUFFER:
>  		return syndbg_get_msr(vcpu, msr, pdata, host);
>  	default:
> -		vcpu_unimpl(vcpu, "Hyper-V unhandled rdmsr: 0x%x\n", msr);
> +		kvm_pr_unimpl_rdmsr(vcpu, msr);
>  		return 1;
>  	}
>  
> @@ -1673,7 +1671,7 @@ static int kvm_hv_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
>  		data = APIC_BUS_FREQUENCY;
>  		break;
>  	default:
> -		vcpu_unimpl(vcpu, "Hyper-V unhandled rdmsr: 0x%x\n", msr);
> +		kvm_pr_unimpl_rdmsr(vcpu, msr);
>  		return 1;
>  	}
>  	*pdata = data;
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index d13cf53e7390..dd21e8b1a259 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3015,8 +3015,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  		break;
>  	case MSR_IA32_DEBUGCTLMSR:
>  		if (!lbrv) {
> -			vcpu_unimpl(vcpu, "%s: MSR_IA32_DEBUGCTL 0x%llx, nop\n",
> -				    __func__, data);
> +			kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
>  			break;
>  		}
>  		if (data & DEBUGCTL_RESERVED_BITS)
> @@ -3045,7 +3044,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  	case MSR_VM_CR:
>  		return svm_set_vm_cr(vcpu, data);
>  	case MSR_VM_IGNNE:
> -		vcpu_unimpl(vcpu, "unimplemented wrmsr: 0x%x data 0x%llx\n", ecx, data);
> +		kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
>  		break;
>  	case MSR_AMD64_DE_CFG: {
>  		struct kvm_msr_entry msr_entry;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index c788aa382611..8f0f67c75f35 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2206,9 +2206,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  
>  		invalid = data & ~vmx_get_supported_debugctl(vcpu, msr_info->host_initiated);
>  		if (invalid & (DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR)) {
> -			if (report_ignored_msrs)
> -				vcpu_unimpl(vcpu, "%s: BTF|LBR in IA32_DEBUGCTLMSR 0x%llx, nop\n",
> -					    __func__, data);
> +			kvm_pr_unimpl_wrmsr(vcpu, msr_index, data);
>  			data &= ~(DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR);
>  			invalid &= ~(DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR);
>  		}
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ad95ce92a154..d4a610ffe2b8 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3560,7 +3560,6 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
>  
>  int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  {
> -	bool pr = false;
>  	u32 msr = msr_info->index;
>  	u64 data = msr_info->data;
>  
> @@ -3606,15 +3605,13 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		if (data == BIT_ULL(18)) {
>  			vcpu->arch.msr_hwcr = data;
>  		} else if (data != 0) {
> -			vcpu_unimpl(vcpu, "unimplemented HWCR wrmsr: 0x%llx\n",
> -				    data);
> +			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
>  			return 1;
>  		}
>  		break;
>  	case MSR_FAM10H_MMIO_CONF_BASE:
>  		if (data != 0) {
> -			vcpu_unimpl(vcpu, "unimplemented MMIO_CONF_BASE wrmsr: "
> -				    "0x%llx\n", data);
> +			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
>  			return 1;
>  		}
>  		break;
> @@ -3794,16 +3791,13 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  
>  	case MSR_K7_PERFCTR0 ... MSR_K7_PERFCTR3:
>  	case MSR_P6_PERFCTR0 ... MSR_P6_PERFCTR1:
> -		pr = true;
> -		fallthrough;
>  	case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL3:
>  	case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL1:
>  		if (kvm_pmu_is_valid_msr(vcpu, msr))
>  			return kvm_pmu_set_msr(vcpu, msr_info);
>  
> -		if (pr || data != 0)
> -			vcpu_unimpl(vcpu, "disabled perfctr wrmsr: "
> -				    "0x%x data 0x%llx\n", msr, data);
> +		if (data)
> +			kvm_pr_unimpl_wrmsr(vcpu, msr, data);

The logic here was that "*_PERFCTR*" MSRs are reported even when 'data
== 0' but looking at the commit 5753785fa977 ("KVM: do not #GP on perf
MSR writes when vPMU is disabled") I can't really say why it was needed.

>  		break;
>  	case MSR_K7_CLK_CTL:
>  		/*
> @@ -3831,9 +3825,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		/* Drop writes to this legacy MSR -- see rdmsr
>  		 * counterpart for further detail.
>  		 */
> -		if (report_ignored_msrs)
> -			vcpu_unimpl(vcpu, "ignored wrmsr: 0x%x data 0x%llx\n",
> -				msr, data);
> +		kvm_pr_unimpl_wrmsr(vcpu, msr, data);
>  		break;
>  	case MSR_AMD64_OSVW_ID_LENGTH:
>  		if (!guest_cpuid_has(vcpu, X86_FEATURE_OSVW))
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 9de72586f406..f3554bf05201 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -331,6 +331,18 @@ extern bool report_ignored_msrs;
>  
>  extern bool eager_page_split;
>  
> +static inline void kvm_pr_unimpl_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
> +{
> +	if (report_ignored_msrs)
> +		vcpu_unimpl(vcpu, "Unhandled WRMSR(0x%x) = 0x%llx\n", msr, data);
> +}
> +
> +static inline void kvm_pr_unimpl_rdmsr(struct kvm_vcpu *vcpu, u32 msr)
> +{
> +	if (report_ignored_msrs)
> +		vcpu_unimpl(vcpu, "Unhandled RDMSR(0x%x)\n", msr);
> +}
> +
>  static inline u64 nsec_to_cycles(struct kvm_vcpu *vcpu, u64 nsec)
>  {
>  	return pvclock_scale_delta(nsec, vcpu->arch.virtual_tsc_mult,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly


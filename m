Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0EE69098C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjBINJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjBINJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:09:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5C255BE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675948135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bw39xUm/apggQ1i5X5e78IuyEVEQICuYA4ehNUdLHig=;
        b=e07cf7COJXWZ9df+eAJJhHwMsdckLVNQpadnyLPB0pqlQswEZ9yGLAsxcaZ0EHNJ4ODemP
        K0+q1GeQ7k03lq9zuN3R/7imrE58ncb0HaH0R3DL77miVASh7FKeDAwA6TnHabQZiFqfWp
        6mJ6jlsWgaFDOopRiwZbZ7useu4jpec=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-155-Kp9i9orMOW2SqAKSckaPYg-1; Thu, 09 Feb 2023 08:08:54 -0500
X-MC-Unique: Kp9i9orMOW2SqAKSckaPYg-1
Received: by mail-qv1-f72.google.com with SMTP id ng1-20020a0562143bc100b004bb706b3a27so1199415qvb.20
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bw39xUm/apggQ1i5X5e78IuyEVEQICuYA4ehNUdLHig=;
        b=YOEYBdwkqdje9fGgGiJNP/tIRH0Y7ucBw8cQ0tf9GaH8NHonFzlUBj7s16FmleI+rc
         3BnaPkj+T6UrvYlMMflz3TbL6entwxUOnmI/hpVcXD/qOCmgZuOxANYvu6+eqhrYzWeK
         5jEz7GGqriXIgBPJjVeldTPjLZ0WvBB0IvgoYJBireUn9MQCCn3HB0OL8w7GgCxDQR00
         zJoSEX8xljxhSSPIyVSMAqFOW5dl4e6/MrkSJrxFCV11H3x7TsihcNt+yOzbu4vrOteP
         3avGGNQ2526N+BObteCNRk3H7wwYaqSUxYX+/RsJVhHrd8rPIR6gqaC0JsitleTF0kPs
         valg==
X-Gm-Message-State: AO0yUKXJfD3FOafzIKnYtoowQh2rgSZxZW1Pffpa25vHyPJqbCz9gEvr
        MKJFVKyO+O0vun82MYH46DHn2Wn+8mmfrsHzkqQO3l1BLGi/vultJQcwhllJdmyky/vdKzAQxUq
        C07gjHwBaZ8BHH2B3z7qqjQShtnvnK6blZXaMBx9i2xyNSf9M3RhXKiH9cwh4bSo20bv/ftlPJP
        /MR6Ph0suj
X-Received: by 2002:ac8:5f0d:0:b0:3b8:4cba:e26e with SMTP id x13-20020ac85f0d000000b003b84cbae26emr20066140qta.51.1675948133942;
        Thu, 09 Feb 2023 05:08:53 -0800 (PST)
X-Google-Smtp-Source: AK7set9QS0vKnZmDTVsHXHzq5+tgyb7V+h5PIe/cKTWx1dhZTBnEgvK29rzOogD3eXi+scqWsZ86qQ==
X-Received: by 2002:ac8:5f0d:0:b0:3b8:4cba:e26e with SMTP id x13-20020ac85f0d000000b003b84cbae26emr20066092qta.51.1675948133601;
        Thu, 09 Feb 2023 05:08:53 -0800 (PST)
Received: from fedora (ec2-3-80-233-239.compute-1.amazonaws.com. [3.80.233.239])
        by smtp.gmail.com with ESMTPSA id 17-20020ac82091000000b003b960aad697sm1228102qtd.9.2023.02.09.05.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 05:08:52 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: nVMX: Move EVMCS1_SUPPORT_* macros to hyperv.c
In-Reply-To: <20230208205430.1424667-2-seanjc@google.com>
References: <20230208205430.1424667-1-seanjc@google.com>
 <20230208205430.1424667-2-seanjc@google.com>
Date:   Thu, 09 Feb 2023 14:08:49 +0100
Message-ID: <87pmaj6l5q.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Move the macros that define the set of VMCS controls that are supported
> by eVMCS1 from hyperv.h to hyperv.c, i.e. make them "private".   The
> macros should never be consumed directly by KVM at-large since the "final"
> set of supported controls depends on guest CPUID.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/hyperv.c | 105 ++++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/vmx/hyperv.h | 105 --------------------------------------
>  2 files changed, 105 insertions(+), 105 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
> index 22daca752797..b6748055c586 100644
> --- a/arch/x86/kvm/vmx/hyperv.c
> +++ b/arch/x86/kvm/vmx/hyperv.c
> @@ -13,6 +13,111 @@
>  
>  #define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
>  
> +/*
> + * Enlightened VMCSv1 doesn't support these:
> + *
> + *	POSTED_INTR_NV                  = 0x00000002,
> + *	GUEST_INTR_STATUS               = 0x00000810,
> + *	APIC_ACCESS_ADDR		= 0x00002014,
> + *	POSTED_INTR_DESC_ADDR           = 0x00002016,
> + *	EOI_EXIT_BITMAP0                = 0x0000201c,
> + *	EOI_EXIT_BITMAP1                = 0x0000201e,
> + *	EOI_EXIT_BITMAP2                = 0x00002020,
> + *	EOI_EXIT_BITMAP3                = 0x00002022,
> + *	GUEST_PML_INDEX			= 0x00000812,
> + *	PML_ADDRESS			= 0x0000200e,
> + *	VM_FUNCTION_CONTROL             = 0x00002018,
> + *	EPTP_LIST_ADDRESS               = 0x00002024,
> + *	VMREAD_BITMAP                   = 0x00002026,
> + *	VMWRITE_BITMAP                  = 0x00002028,
> + *
> + *	TSC_MULTIPLIER                  = 0x00002032,
> + *	PLE_GAP                         = 0x00004020,
> + *	PLE_WINDOW                      = 0x00004022,
> + *	VMX_PREEMPTION_TIMER_VALUE      = 0x0000482E,
> + *
> + * Currently unsupported in KVM:
> + *	GUEST_IA32_RTIT_CTL		= 0x00002814,
> + */
> +#define EVMCS1_SUPPORTED_PINCTRL					\
> +	(PIN_BASED_ALWAYSON_WITHOUT_TRUE_MSR |				\
> +	 PIN_BASED_EXT_INTR_MASK |					\
> +	 PIN_BASED_NMI_EXITING |					\
> +	 PIN_BASED_VIRTUAL_NMIS)
> +
> +#define EVMCS1_SUPPORTED_EXEC_CTRL					\
> +	(CPU_BASED_ALWAYSON_WITHOUT_TRUE_MSR |				\
> +	 CPU_BASED_HLT_EXITING |					\
> +	 CPU_BASED_CR3_LOAD_EXITING |					\
> +	 CPU_BASED_CR3_STORE_EXITING |					\
> +	 CPU_BASED_UNCOND_IO_EXITING |					\
> +	 CPU_BASED_MOV_DR_EXITING |					\
> +	 CPU_BASED_USE_TSC_OFFSETTING |					\
> +	 CPU_BASED_MWAIT_EXITING |					\
> +	 CPU_BASED_MONITOR_EXITING |					\
> +	 CPU_BASED_INVLPG_EXITING |					\
> +	 CPU_BASED_RDPMC_EXITING |					\
> +	 CPU_BASED_INTR_WINDOW_EXITING |				\
> +	 CPU_BASED_CR8_LOAD_EXITING |					\
> +	 CPU_BASED_CR8_STORE_EXITING |					\
> +	 CPU_BASED_RDTSC_EXITING |					\
> +	 CPU_BASED_TPR_SHADOW |						\
> +	 CPU_BASED_USE_IO_BITMAPS |					\
> +	 CPU_BASED_MONITOR_TRAP_FLAG |					\
> +	 CPU_BASED_USE_MSR_BITMAPS |					\
> +	 CPU_BASED_NMI_WINDOW_EXITING |					\
> +	 CPU_BASED_PAUSE_EXITING |					\
> +	 CPU_BASED_ACTIVATE_SECONDARY_CONTROLS)
> +
> +#define EVMCS1_SUPPORTED_2NDEXEC					\
> +	(SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |			\
> +	 SECONDARY_EXEC_WBINVD_EXITING |				\
> +	 SECONDARY_EXEC_ENABLE_VPID |					\
> +	 SECONDARY_EXEC_ENABLE_EPT |					\
> +	 SECONDARY_EXEC_UNRESTRICTED_GUEST |				\
> +	 SECONDARY_EXEC_DESC |						\
> +	 SECONDARY_EXEC_ENABLE_RDTSCP |					\
> +	 SECONDARY_EXEC_ENABLE_INVPCID |				\
> +	 SECONDARY_EXEC_XSAVES |					\
> +	 SECONDARY_EXEC_RDSEED_EXITING |				\
> +	 SECONDARY_EXEC_RDRAND_EXITING |				\
> +	 SECONDARY_EXEC_TSC_SCALING |					\
> +	 SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE |				\
> +	 SECONDARY_EXEC_PT_USE_GPA |					\
> +	 SECONDARY_EXEC_PT_CONCEAL_VMX |				\
> +	 SECONDARY_EXEC_BUS_LOCK_DETECTION |				\
> +	 SECONDARY_EXEC_NOTIFY_VM_EXITING |				\
> +	 SECONDARY_EXEC_ENCLS_EXITING)
> +
> +#define EVMCS1_SUPPORTED_3RDEXEC (0ULL)
> +
> +#define EVMCS1_SUPPORTED_VMEXIT_CTRL					\
> +	(VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR |				\
> +	 VM_EXIT_SAVE_DEBUG_CONTROLS |					\
> +	 VM_EXIT_ACK_INTR_ON_EXIT |					\
> +	 VM_EXIT_HOST_ADDR_SPACE_SIZE |					\
> +	 VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |				\
> +	 VM_EXIT_SAVE_IA32_PAT |					\
> +	 VM_EXIT_LOAD_IA32_PAT |					\
> +	 VM_EXIT_SAVE_IA32_EFER |					\
> +	 VM_EXIT_LOAD_IA32_EFER |					\
> +	 VM_EXIT_CLEAR_BNDCFGS |					\
> +	 VM_EXIT_PT_CONCEAL_PIP |					\
> +	 VM_EXIT_CLEAR_IA32_RTIT_CTL)
> +
> +#define EVMCS1_SUPPORTED_VMENTRY_CTRL					\
> +	(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR |				\
> +	 VM_ENTRY_LOAD_DEBUG_CONTROLS |					\
> +	 VM_ENTRY_IA32E_MODE |						\
> +	 VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |				\
> +	 VM_ENTRY_LOAD_IA32_PAT |					\
> +	 VM_ENTRY_LOAD_IA32_EFER |					\
> +	 VM_ENTRY_LOAD_BNDCFGS |					\
> +	 VM_ENTRY_PT_CONCEAL_PIP |					\
> +	 VM_ENTRY_LOAD_IA32_RTIT_CTL)
> +
> +#define EVMCS1_SUPPORTED_VMFUNC (0)
> +
>  DEFINE_STATIC_KEY_FALSE(enable_evmcs);
>  
>  #define EVMCS1_OFFSET(x) offsetof(struct hv_enlightened_vmcs, x)
> diff --git a/arch/x86/kvm/vmx/hyperv.h b/arch/x86/kvm/vmx/hyperv.h
> index 78d17667e7ec..1299143d00df 100644
> --- a/arch/x86/kvm/vmx/hyperv.h
> +++ b/arch/x86/kvm/vmx/hyperv.h
> @@ -22,111 +22,6 @@ DECLARE_STATIC_KEY_FALSE(enable_evmcs);
>  
>  #define KVM_EVMCS_VERSION 1
>  
> -/*
> - * Enlightened VMCSv1 doesn't support these:
> - *
> - *	POSTED_INTR_NV                  = 0x00000002,
> - *	GUEST_INTR_STATUS               = 0x00000810,
> - *	APIC_ACCESS_ADDR		= 0x00002014,
> - *	POSTED_INTR_DESC_ADDR           = 0x00002016,
> - *	EOI_EXIT_BITMAP0                = 0x0000201c,
> - *	EOI_EXIT_BITMAP1                = 0x0000201e,
> - *	EOI_EXIT_BITMAP2                = 0x00002020,
> - *	EOI_EXIT_BITMAP3                = 0x00002022,
> - *	GUEST_PML_INDEX			= 0x00000812,
> - *	PML_ADDRESS			= 0x0000200e,
> - *	VM_FUNCTION_CONTROL             = 0x00002018,
> - *	EPTP_LIST_ADDRESS               = 0x00002024,
> - *	VMREAD_BITMAP                   = 0x00002026,
> - *	VMWRITE_BITMAP                  = 0x00002028,
> - *
> - *	TSC_MULTIPLIER                  = 0x00002032,
> - *	PLE_GAP                         = 0x00004020,
> - *	PLE_WINDOW                      = 0x00004022,
> - *	VMX_PREEMPTION_TIMER_VALUE      = 0x0000482E,
> - *
> - * Currently unsupported in KVM:
> - *	GUEST_IA32_RTIT_CTL		= 0x00002814,
> - */
> -#define EVMCS1_SUPPORTED_PINCTRL					\
> -	(PIN_BASED_ALWAYSON_WITHOUT_TRUE_MSR |				\
> -	 PIN_BASED_EXT_INTR_MASK |					\
> -	 PIN_BASED_NMI_EXITING |					\
> -	 PIN_BASED_VIRTUAL_NMIS)
> -
> -#define EVMCS1_SUPPORTED_EXEC_CTRL					\
> -	(CPU_BASED_ALWAYSON_WITHOUT_TRUE_MSR |				\
> -	 CPU_BASED_HLT_EXITING |					\
> -	 CPU_BASED_CR3_LOAD_EXITING |					\
> -	 CPU_BASED_CR3_STORE_EXITING |					\
> -	 CPU_BASED_UNCOND_IO_EXITING |					\
> -	 CPU_BASED_MOV_DR_EXITING |					\
> -	 CPU_BASED_USE_TSC_OFFSETTING |					\
> -	 CPU_BASED_MWAIT_EXITING |					\
> -	 CPU_BASED_MONITOR_EXITING |					\
> -	 CPU_BASED_INVLPG_EXITING |					\
> -	 CPU_BASED_RDPMC_EXITING |					\
> -	 CPU_BASED_INTR_WINDOW_EXITING |				\
> -	 CPU_BASED_CR8_LOAD_EXITING |					\
> -	 CPU_BASED_CR8_STORE_EXITING |					\
> -	 CPU_BASED_RDTSC_EXITING |					\
> -	 CPU_BASED_TPR_SHADOW |						\
> -	 CPU_BASED_USE_IO_BITMAPS |					\
> -	 CPU_BASED_MONITOR_TRAP_FLAG |					\
> -	 CPU_BASED_USE_MSR_BITMAPS |					\
> -	 CPU_BASED_NMI_WINDOW_EXITING |					\
> -	 CPU_BASED_PAUSE_EXITING |					\
> -	 CPU_BASED_ACTIVATE_SECONDARY_CONTROLS)
> -
> -#define EVMCS1_SUPPORTED_2NDEXEC					\
> -	(SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |			\
> -	 SECONDARY_EXEC_WBINVD_EXITING |				\
> -	 SECONDARY_EXEC_ENABLE_VPID |					\
> -	 SECONDARY_EXEC_ENABLE_EPT |					\
> -	 SECONDARY_EXEC_UNRESTRICTED_GUEST |				\
> -	 SECONDARY_EXEC_DESC |						\
> -	 SECONDARY_EXEC_ENABLE_RDTSCP |					\
> -	 SECONDARY_EXEC_ENABLE_INVPCID |				\
> -	 SECONDARY_EXEC_XSAVES |					\
> -	 SECONDARY_EXEC_RDSEED_EXITING |				\
> -	 SECONDARY_EXEC_RDRAND_EXITING |				\
> -	 SECONDARY_EXEC_TSC_SCALING |					\
> -	 SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE |				\
> -	 SECONDARY_EXEC_PT_USE_GPA |					\
> -	 SECONDARY_EXEC_PT_CONCEAL_VMX |				\
> -	 SECONDARY_EXEC_BUS_LOCK_DETECTION |				\
> -	 SECONDARY_EXEC_NOTIFY_VM_EXITING |				\
> -	 SECONDARY_EXEC_ENCLS_EXITING)
> -
> -#define EVMCS1_SUPPORTED_3RDEXEC (0ULL)
> -
> -#define EVMCS1_SUPPORTED_VMEXIT_CTRL					\
> -	(VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR |				\
> -	 VM_EXIT_SAVE_DEBUG_CONTROLS |					\
> -	 VM_EXIT_ACK_INTR_ON_EXIT |					\
> -	 VM_EXIT_HOST_ADDR_SPACE_SIZE |					\
> -	 VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |				\
> -	 VM_EXIT_SAVE_IA32_PAT |					\
> -	 VM_EXIT_LOAD_IA32_PAT |					\
> -	 VM_EXIT_SAVE_IA32_EFER |					\
> -	 VM_EXIT_LOAD_IA32_EFER |					\
> -	 VM_EXIT_CLEAR_BNDCFGS |					\
> -	 VM_EXIT_PT_CONCEAL_PIP |					\
> -	 VM_EXIT_CLEAR_IA32_RTIT_CTL)
> -
> -#define EVMCS1_SUPPORTED_VMENTRY_CTRL					\
> -	(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR |				\
> -	 VM_ENTRY_LOAD_DEBUG_CONTROLS |					\
> -	 VM_ENTRY_IA32E_MODE |						\
> -	 VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |				\
> -	 VM_ENTRY_LOAD_IA32_PAT |					\
> -	 VM_ENTRY_LOAD_IA32_EFER |					\
> -	 VM_ENTRY_LOAD_BNDCFGS |					\
> -	 VM_ENTRY_PT_CONCEAL_PIP |					\
> -	 VM_ENTRY_LOAD_IA32_RTIT_CTL)
> -
> -#define EVMCS1_SUPPORTED_VMFUNC (0)
> -
>  struct evmcs_field {
>  	u16 offset;
>  	u16 clean_field;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly


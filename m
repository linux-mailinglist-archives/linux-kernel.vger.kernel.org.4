Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFCD60F62B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbiJ0L0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiJ0L0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAE6CC82F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666869980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gwD/VCqaaIgMoFgk+za7ctN3lKoPgxNu0PXew4sZKV0=;
        b=Ilfc7aAdVcnO80HQ9y09S0lErH6X6XYnDuNT/qKjha8inoGTyyNLH6I0GuZ7hSGL25juuN
        uSHe5/P3174oWTozwKz2QVibE2KE1mkY6SNxsHywmpad+JIgx9EBt+Ll/2pvXvfzD6Lfp7
        xDCBMT6ibaSLlSwxccwfEjANfbAh5mQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-256-YmFq2MzjPZeU6NtoQ-lveQ-1; Thu, 27 Oct 2022 07:26:18 -0400
X-MC-Unique: YmFq2MzjPZeU6NtoQ-lveQ-1
Received: by mail-ej1-f72.google.com with SMTP id sd8-20020a1709076e0800b007ac2e1693abso822529ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwD/VCqaaIgMoFgk+za7ctN3lKoPgxNu0PXew4sZKV0=;
        b=564uHFUOLexthOzqjF/5J+FkD96SjxYvKd5kKbyA4IH8D6E1BG2A2DRhsUf1SshLhW
         SwQnz9XE4MpM8xPQtdpcn1C6BS1QSmxMDm1xIFnOOTih6CT/vqXeqxvQW6ZBg9ljZ8lQ
         gyFQyuNoq+gLwqNRINfOgCOqvUgKK2PmYv0KTx/ANj+zMPAnujTwb4uPGoCPLHvMdyUH
         23j2diBpPGsb+SOGuFqReRzlg7RmjaHZJEsx/hj/WQluc8kauuLTLnfgXFe8cD1jqGXF
         kGyRoigMG8/dpqaoCZ5uSQxSDCXrquSGOBqLjXgvP9ql6j9IKOVKGuOZkYWYIlveIKfc
         sjSA==
X-Gm-Message-State: ACrzQf0ggFCksT56EdtG0qeHlJA+3R5zRT5jSqB3ce4wz7xb8r/QMM8F
        DBMyZdMNMGL67BkcwUIrRrUYty7U/Xsvwgpp4rTCi5As4ZUy5JrBFptjq+TcO2syQRavKZSOp9x
        KDnB0HG7aY/18hheZTN5vGoJ7ZiFVqfXE+kZyT9YqcvGIAR9heL9oWMA6ulpU22YDhmIbr3/j3i
        M9
X-Received: by 2002:a17:907:5c2:b0:77e:def7:65d8 with SMTP id wg2-20020a17090705c200b0077edef765d8mr42343953ejb.487.1666869977904;
        Thu, 27 Oct 2022 04:26:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7WJxuWZ43iZYYhZ8MfPXNu3T6tKw0hM2BQl4n9aGq5ITWxA4LN5wc6fGSQb5BUv0s9i2wi1A==
X-Received: by 2002:a17:907:5c2:b0:77e:def7:65d8 with SMTP id wg2-20020a17090705c200b0077edef765d8mr42343917ejb.487.1666869977557;
        Thu, 27 Oct 2022 04:26:17 -0700 (PDT)
Received: from ovpn-194-52.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 24-20020a170906319800b0073d84a321c8sm640878ejy.166.2022.10.27.04.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 04:26:16 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] KVM: VMX: Resurrect vmcs_conf sanitization for
 KVM-on-Hyper-V
In-Reply-To: <Y1nD9QKqa1A1j7t+@google.com>
References: <20221018101000.934413-1-vkuznets@redhat.com>
 <20221018101000.934413-5-vkuznets@redhat.com>
 <Y1nD9QKqa1A1j7t+@google.com>
Date:   Thu, 27 Oct 2022 13:26:15 +0200
Message-ID: <877d0ltsmg.fsf@ovpn-194-52.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Oct 18, 2022, Vitaly Kuznetsov wrote:
>> @@ -362,6 +364,7 @@ uint16_t nested_get_evmcs_version(struct kvm_vcpu *vcpu)
>>  
>>  enum evmcs_revision {
>>  	EVMCSv1_LEGACY,
>> +	EVMCSv1_STRICT,
>
> "strict" isn't really the right word, this is more like "raw" or "unfiltered",
> because unless I'm misunderstanding the intent, this will always track KVM's
> bleeding edge, i.e. everything that KVM can possibly enable.
>

Yes, it's unclear from the patch but this is a pre-requisite to exposing
'updated' eVMCSv1 controls (e.g. TSC scaling) for Hyper-V-on-KVM
case. Previously (https://lore.kernel.org/kvm/20220824030138.3524159-10-seanjc@google.com/)
we called it 'ENFORCED' but I misremembered and called it 'strict'.

> And in that case, we can avoid bikeshedding the name becase bouncing through
> evmcs_supported_ctrls is unnecessary, just use the #defines directly.  And then
> you can just fold the one (or two) #defines from patch 3 into this path.
>

Defines can be used directly indeed and 'strict/enforcing/...'
discussion can happen when we finally come to exposing 'updated'
controls (hope we're almost there). 

>> @@ -511,6 +525,52 @@ int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
>>  	return 0;
>>  }
>>  
>> +#if IS_ENABLED(CONFIG_HYPERV)
>> +/*
>> + * KVM on Hyper-V always uses the newest known eVMCSv1 revision, the assumption
>> + * is: in case a feature has corresponding fields in eVMCS described and it was
>> + * exposed in VMX feature MSRs, KVM is free to use it. Warn if KVM meets a
>> + * feature which has no corresponding eVMCS field, this likely means that KVM
>> + * needs to be updated.
>> + */
>> +#define evmcs_check_vmcs_conf32(field, ctrl)					\
>> +	{									\
>> +		u32 supported, unsupported32;					\
>> +										\
>> +		supported = evmcs_get_supported_ctls(ctrl, EVMCSv1_STRICT);	\
>> +		unsupported32 = vmcs_conf->field & ~supported;			\
>> +		if (unsupported32) {						\
>> +			pr_warn_once(#field " unsupported with eVMCS: 0x%x\n",	\
>> +				     unsupported32);				\
>> +			vmcs_conf->field &= supported;				\
>> +		}								\
>> +	}
>> +
>> +#define evmcs_check_vmcs_conf64(field, ctrl)					\
>> +	{									\
>> +		u32 supported;							\
>> +		u64 unsupported64;						\
>
> Channeling my inner Morpheus: Stop trying to use macros and use macros!  :-D
>
> ---
>  arch/x86/kvm/vmx/evmcs.c | 34 ++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/vmx/evmcs.h |  2 ++
>  arch/x86/kvm/vmx/vmx.c   |  5 +++++
>  3 files changed, 41 insertions(+)
>
> diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
> index 337783675731..f7f8eafeecf7 100644
> --- a/arch/x86/kvm/vmx/evmcs.c
> +++ b/arch/x86/kvm/vmx/evmcs.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#define pr_fmt(fmt) "kvm/hyper-v: " fmt
> +
>  #include <linux/errno.h>
>  #include <linux/smp.h>
>  
> @@ -507,6 +509,38 @@ int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
>  	return 0;
>  }
>  
> +#if IS_ENABLED(CONFIG_HYPERV)
> +/*
> + * KVM on Hyper-V always uses the newest known eVMCSv1 revision, the assumption
> + * is: in case a feature has corresponding fields in eVMCS described and it was
> + * exposed in VMX feature MSRs, KVM is free to use it. Warn if KVM meets a
> + * feature which has no corresponding eVMCS field, this likely means that KVM
> + * needs to be updated.
> + */
> +#define evmcs_check_vmcs_conf(field, ctrl)				\
> +do {									\
> +	typeof(vmcs_conf->field) unsupported;				\
> +									\
> +	unsupported = vmcs_conf->field & EVMCS1_UNSUPPORTED_ ## ctrl;	\
> +	if (unsupported) {						\
> +		pr_warn_once(#field " unsupported with eVMCS: 0x%llx\n",\
> +			     (u64)unsupported);				\
> +		vmcs_conf->field &= ~unsupported;			\
> +	}								\
> +}									\
> +while (0)
> +
> +__init void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf)
> +{
> +	evmcs_check_vmcs_conf(cpu_based_exec_ctrl, EXEC_CTRL);
> +	evmcs_check_vmcs_conf(pin_based_exec_ctrl, PINCTRL);
> +	evmcs_check_vmcs_conf(cpu_based_2nd_exec_ctrl, 2NDEXEC);
> +	evmcs_check_vmcs_conf(cpu_based_3rd_exec_ctrl, 3RDEXEC);
> +	evmcs_check_vmcs_conf(vmentry_ctrl, VMENTRY_CTRL);
> +	evmcs_check_vmcs_conf(vmexit_ctrl, VMEXIT_CTRL);
> +}
> +#endif
> +
>  int nested_enable_evmcs(struct kvm_vcpu *vcpu,
>  			uint16_t *vmcs_version)
>  {
> diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
> index 6f746ef3c038..bc795c6e9059 100644
> --- a/arch/x86/kvm/vmx/evmcs.h
> +++ b/arch/x86/kvm/vmx/evmcs.h
> @@ -58,6 +58,7 @@ DECLARE_STATIC_KEY_FALSE(enable_evmcs);
>  	 SECONDARY_EXEC_SHADOW_VMCS |					\
>  	 SECONDARY_EXEC_TSC_SCALING |					\
>  	 SECONDARY_EXEC_PAUSE_LOOP_EXITING)
> +#define EVMCS1_UNSUPPORTED_3RDEXEC (~0ULL)
>  #define EVMCS1_UNSUPPORTED_VMEXIT_CTRL					\
>  	(VM_EXIT_SAVE_VMX_PREEMPTION_TIMER)
>  #define EVMCS1_UNSUPPORTED_VMENTRY_CTRL (0)
> @@ -209,6 +210,7 @@ static inline void evmcs_load(u64 phys_addr)
>  	vp_ap->enlighten_vmentry = 1;
>  }
>  
> +__init void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf);
>  #else /* !IS_ENABLED(CONFIG_HYPERV) */
>  static __always_inline void evmcs_write64(unsigned long field, u64 value) {}
>  static inline void evmcs_write32(unsigned long field, u32 value) {}
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 9dba04b6b019..7fd21b1fae1d 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2720,6 +2720,11 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>  	vmcs_conf->vmentry_ctrl        = _vmentry_control;
>  	vmcs_conf->misc	= misc_msr;
>  
> +#if IS_ENABLED(CONFIG_HYPERV)
> +	if (enlightened_vmcs)
> +		evmcs_sanitize_exec_ctrls(vmcs_conf);
> +#endif
> +
>  	return 0;
>  }
>  
>
> base-commit: 5b6b6bcc0ef138b55fdd17dc8f9d43dfd26f8bd7

-- 
Vitaly


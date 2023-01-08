Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115466617CB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbjAHSIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbjAHSI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:08:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19024F45
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 10:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673201266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KTf5PU9DkBq3cJnr0rfouR0Ki+jixnDZ8xbnkzYq8a8=;
        b=B1MZ1XpJ/0HoDEdjyugWL5ddhRNE00E8MQDuRw7gwTonsuSTV8E0yHlcRZ/1KLyg1D+FXP
        iAFPScp4HveytreArOUMIHNzQO3DW37nA5dlUsYVkOdnwou4IV9o9vvHU3Va/dj6PJsrkj
        oXVKkiVCdjl0avg7/iisRedWMNKsqwQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-iJGiNQqVOcaxxD56WKSuAA-1; Sun, 08 Jan 2023 13:07:45 -0500
X-MC-Unique: iJGiNQqVOcaxxD56WKSuAA-1
Received: by mail-ej1-f72.google.com with SMTP id nc21-20020a1709071c1500b0084d469ff392so357828ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 10:07:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KTf5PU9DkBq3cJnr0rfouR0Ki+jixnDZ8xbnkzYq8a8=;
        b=McDvEQTCrP+zzQR8sYIWSoE3dYRpNJa1hX2k6C/to6Nc1/ThRiyzYZcCljKQOpg6+V
         UIcXJjfzOYDtELExiPdxX8K8srSyQPS91sFcFeLswS5+DjFcwCgm4qcTaM3W9okEI51P
         vhNRqcPde6WO25C7HlkPBCfzHEvNVVxDIMTKru3sdxmPThja8qC9lZlCm1vJ+FxqFnG/
         Zj1eJOEjZGd4JMQq0qzfzWBSExY7sc5f/02OvXpWBfpwJ/4j5CRws6vmG9CNLo1YzXn1
         75pgZpkRCSx5NDnWtSuXabouVwtlwRJXuRuyoricol17G3EDDexMisigS17VnfZZtseM
         BvEg==
X-Gm-Message-State: AFqh2koKUQHqLV+Ysx2OLDn+AObMViHtn7SJdOYgtC5fqIbbjBXz4Quc
        3YKysqBE1w5mA4oBz0nlo9NDEoT1a2XbBOofOSTpIIE9keUps4KALjAEfyWMQq2Z/iNWXKhyo6z
        SGiqrmBSMoq6dFH+vEd+D5dM3
X-Received: by 2002:a05:6402:5167:b0:497:1b2:5f88 with SMTP id d7-20020a056402516700b0049701b25f88mr7891485ede.16.1673201263902;
        Sun, 08 Jan 2023 10:07:43 -0800 (PST)
X-Google-Smtp-Source: AMrXdXshWuvWvz6+gViRZUO8dIbFsnYlnt5CBvHZi0yROoV2o6BosPlbQN9ZjCO1iAMwCAwcXg1xGg==
X-Received: by 2002:a05:6402:5167:b0:497:1b2:5f88 with SMTP id d7-20020a056402516700b0049701b25f88mr7891471ede.16.1673201263694;
        Sun, 08 Jan 2023 10:07:43 -0800 (PST)
Received: from starship ([89.237.103.62])
        by smtp.gmail.com with ESMTPSA id l10-20020aa7d94a000000b0048ebf8a5736sm2770651eds.21.2023.01.08.10.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:07:43 -0800 (PST)
Message-ID: <5e50b87a4c7d19f9386bac1aa7061675018a2caa.camel@redhat.com>
Subject: Re: [PATCH 5/6] KVM: VMX: Always intercept accesses to unsupported
 "extended" x2APIC regs
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Orr <marcorr@google.com>, Ben Gardon <bgardon@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>
Date:   Sun, 08 Jan 2023 20:07:41 +0200
In-Reply-To: <20230107011025.565472-6-seanjc@google.com>
References: <20230107011025.565472-1-seanjc@google.com>
         <20230107011025.565472-6-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-01-07 at 01:10 +0000, Sean Christopherson wrote:
> Don't clear the "read" bits for x2APIC registers above SELF_IPI (APIC regs
> 0x400 - 0xff0, MSRs 0x840 - 0x8ff).  KVM doesn't emulate registers in that
> space (there are a smattering of AMD-only extensions) and so should
> intercept reads in order to inject #GP.  When APICv is fully enabled,
> Intel hardware doesn't validate the registers on RDMSR and instead blindly
> retrieves data from the vAPIC page, i.e. it's software's responsibility to
> intercept reads to non-existent MSRs.
> 
> Fixes: 8d14695f9542 ("x86, apicv: add virtual x2apic support")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index c788aa382611..82c61c16f8f5 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4018,26 +4018,17 @@ void vmx_enable_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type)
>  		vmx_set_msr_bitmap_write(msr_bitmap, msr);
>  }
>  
> -static void vmx_reset_x2apic_msrs(struct kvm_vcpu *vcpu, u8 mode)
> -{
> -	unsigned long *msr_bitmap = to_vmx(vcpu)->vmcs01.msr_bitmap;
> -	unsigned long read_intercept;
> -	int msr;
> -
> -	read_intercept = (mode & MSR_BITMAP_MODE_X2APIC_APICV) ? 0 : ~0;
> -
> -	for (msr = 0x800; msr <= 0x8ff; msr += BITS_PER_LONG) {
> -		unsigned int read_idx = msr / BITS_PER_LONG;
> -		unsigned int write_idx = read_idx + (0x800 / sizeof(long));
> -
> -		msr_bitmap[read_idx] = read_intercept;
> -		msr_bitmap[write_idx] = ~0ul;
> -	}
> -}
> -
>  static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu)
>  {
> +	/*
> +	 * x2APIC indices for 64-bit accesses into the RDMSR and WRMSR halves
> +	 * of the MSR bitmap.  KVM emulates APIC registers up through 0x3f0,
> +	 * i.e. MSR 0x83f, and so only needs to dynamically manipulate 64 bits.
> +	 */
The above comment is better to be placed down below, near the actual write,
otherwise it is confusing.

> +	const int read_idx = APIC_BASE_MSR / BITS_PER_LONG_LONG;
> +	const int write_idx = read_idx + (0x800 / sizeof(u64));
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	u64 *msr_bitmap = (u64 *)vmx->vmcs01.msr_bitmap;
>  	u8 mode;
>  
>  	if (!cpu_has_vmx_msr_bitmap())
> @@ -4058,7 +4049,18 @@ static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu)
>  
>  	vmx->x2apic_msr_bitmap_mode = mode;
>  
> -	vmx_reset_x2apic_msrs(vcpu, mode);
> +	/*
> +	 * Reset the bitmap for MSRs 0x800 - 0x83f.  Leave AMD's uber-extended
> +	 * registers (0x840 and above) intercepted, KVM doesn't support them.

I don't think AMD calls them uber-extended. Just extended.

From a quick glance, these could have beeing very useful for VFIO passthrough of INT-X interrupts,
removing the need to mask the interrupt on per PCI device basis - instead you can just leave
the IRQ pending in ISR, while using SEOI and IER to ignore this pending bit for host.

I understand that the days of INT-X are long gone (and especially days of shared IRQ lines...)
and every sane device uses MSI/-X instead, but still.


> +	 * Intercept all writes by default and poke holes as needed.  Pass
> +	 * through all reads by default in x2APIC+APICv mode, as all registers
> +	 * except the current timer count are passed through for read.
> +	 */
> +	if (mode & MSR_BITMAP_MODE_X2APIC_APICV)
> +		msr_bitmap[read_idx] = 0;
> +	else
> +		msr_bitmap[read_idx] = ~0ull;
> +	msr_bitmap[write_idx] = ~0ull;
>  
>  	/*
>  	 * TPR reads and writes can be virtualized even if virtual interrupt

Other than the note about the comment,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>


Best regards,
	Maxim Levitsky


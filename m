Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E34661795
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 18:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjAHRjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 12:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjAHRjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 12:39:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B72F5AB
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 09:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673199517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ospAaWs2G/JeimFgX2rChYxXvF/0gkVJgZbjj+MuJNE=;
        b=OwKR8MNcogCqmB147f5tGBvFGhK5GioO3YKO/Jr49pYo8pOFWpisQXl6aR4Rf/suT5Uknq
        ozUIksj17X38t735J44z1+BUByz2gF8PSaAxQd+ySvfsO6c2M8zPSdyH2iZe2v/uJy+sbl
        ldQQpeZS77qvn/24P+NUHaQRXdpGqKo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-575-YImhTAoPNq6fgUAyGUG-ew-1; Sun, 08 Jan 2023 12:38:35 -0500
X-MC-Unique: YImhTAoPNq6fgUAyGUG-ew-1
Received: by mail-ed1-f70.google.com with SMTP id y20-20020a056402271400b0046c9a6ec30fso3981374edd.14
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 09:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ospAaWs2G/JeimFgX2rChYxXvF/0gkVJgZbjj+MuJNE=;
        b=PdYEc7BgXtoi44C7djm1o2UWq4+dPOWn7PdW28fm5Z+04ef8Bbi5t5gEBDXN3zrBWt
         QIlZB1VG4uzYxYHwpoBZm2maidsWHjPCfHqmB4w+H+GgLm6147+xKC8wxMC8eLZ2ojdx
         xOxGJq5ne/5YEJpii4bYO7uKFAqFA1jeywPIX1du1j5h3cKnbhh253Mx8tB10DX/RB6g
         2ynhcb+reo81YnA58IXFKeG3CqngLqro9x1hNLBNLjav7g9hYYxH3C5Ho/UNC7mGReaP
         yrM6DIK6bJKMWD6w7uhAcA+LFupcDo+Q+GXGMN/y8hJUSeLI01TfasjbXllkSinAavd0
         3Zpg==
X-Gm-Message-State: AFqh2krcQ0wMSSfloQTzh5aUEmAptWAIB6xfzUDC+C6Rp7aBMTpm9F/j
        AoZHPTc+3nuEj4S41AmfWO2Ok+01fl0KamJymTfybTwwCN69kUffOJxB9tnUVWM/sNlTXlrPNzE
        VaHsBCglACKFlIr+vIUULOK+T
X-Received: by 2002:a17:907:6e16:b0:7c0:9f6f:6d8 with SMTP id sd22-20020a1709076e1600b007c09f6f06d8mr68968962ejc.2.1673199514518;
        Sun, 08 Jan 2023 09:38:34 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs8XML+gYNBuoTC6l6oUvO1lDn1E1It03N6XT+5yMwdlbQ8IGFTStMzOSvIv+eI/F20YPTC1w==
X-Received: by 2002:a17:907:6e16:b0:7c0:9f6f:6d8 with SMTP id sd22-20020a1709076e1600b007c09f6f06d8mr68968950ejc.2.1673199514359;
        Sun, 08 Jan 2023 09:38:34 -0800 (PST)
Received: from starship ([89.237.103.62])
        by smtp.gmail.com with ESMTPSA id sb25-20020a1709076d9900b007b2a58e31dasm2703474ejc.145.2023.01.08.09.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 09:38:33 -0800 (PST)
Message-ID: <5dbe58d89f8a65ecfebdaf5cb263b9b4e359ce55.camel@redhat.com>
Subject: Re: [PATCH 4/6] KVM: x86: Split out logic to generate "readable"
 APIC regs mask to helper
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Orr <marcorr@google.com>, Ben Gardon <bgardon@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>
Date:   Sun, 08 Jan 2023 19:38:32 +0200
In-Reply-To: <20230107011025.565472-5-seanjc@google.com>
References: <20230107011025.565472-1-seanjc@google.com>
         <20230107011025.565472-5-seanjc@google.com>
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
> Move the generation of the readable APIC regs bitmask to a standalone
> helper so that VMX can use the mask for its MSR interception bitmaps.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/lapic.c | 34 +++++++++++++++++++++-------------
>  arch/x86/kvm/lapic.h |  2 ++
>  2 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index c49b13418638..19697fe9b2c7 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1529,12 +1529,9 @@ static inline struct kvm_lapic *to_lapic(struct kvm_io_device *dev)
>  #define APIC_REGS_MASK(first, count) \
>  	(APIC_REG_MASK(first) * ((1ull << (count)) - 1))
>  
> -static int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
> -			      void *data)
> +u64 kvm_lapic_readable_reg_mask(struct kvm_lapic *apic)
>  {
> -	unsigned char alignment = offset & 0xf;
> -	u32 result;
> -	/* this bitmask has a bit cleared for each reserved register */
> +	/* Leave bits '0' for reserved and write-only registers. */
>  	u64 valid_reg_mask =
>  		APIC_REG_MASK(APIC_ID) |
>  		APIC_REG_MASK(APIC_LVR) |
> @@ -1560,22 +1557,33 @@ static int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
>  	if (kvm_lapic_lvt_supported(apic, LVT_CMCI))
>  		valid_reg_mask |= APIC_REG_MASK(APIC_LVTCMCI);
>  
> -	/*
> -	 * ARBPRI, DFR, and ICR2 are not valid in x2APIC mode.  WARN if KVM
> -	 * reads ICR in x2APIC mode as it's an 8-byte register in x2APIC and
> -	 * needs to be manually handled by the caller.
> -	 */
> +	/* ARBPRI, DFR, and ICR2 are not valid in x2APIC mode. */
>  	if (!apic_x2apic_mode(apic))
>  		valid_reg_mask |= APIC_REG_MASK(APIC_ARBPRI) |
>  				  APIC_REG_MASK(APIC_DFR) |
>  				  APIC_REG_MASK(APIC_ICR2);
> -	else
> -		WARN_ON_ONCE(offset == APIC_ICR);
> +
> +	return valid_reg_mask;
> +}
> +EXPORT_SYMBOL_GPL(kvm_lapic_readable_reg_mask);
> +
> +static int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
> +			      void *data)
> +{
> +	unsigned char alignment = offset & 0xf;
> +	u32 result;
> +
> +	/*
> +	 * WARN if KVM reads ICR in x2APIC mode, as it's an 8-byte register in
> +	 * x2APIC and needs to be manually handled by the caller.
> +	 */
> +	WARN_ON_ONCE(apic_x2apic_mode(apic) && offset == APIC_ICR);
>  
>  	if (alignment + len > 4)
>  		return 1;
>  
> -	if (offset > 0x3f0 || !(valid_reg_mask & APIC_REG_MASK(offset)))
> +	if (offset > 0x3f0 ||
> +	    !(kvm_lapic_readable_reg_mask(apic) & APIC_REG_MASK(offset)))
>  		return 1;
>  
>  	result = __apic_read(apic, offset & ~0xf);
> diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> index df316ede7546..0a0ea4b5dd8c 100644
> --- a/arch/x86/kvm/lapic.h
> +++ b/arch/x86/kvm/lapic.h
> @@ -146,6 +146,8 @@ int kvm_hv_vapic_msr_read(struct kvm_vcpu *vcpu, u32 msr, u64 *data);
>  int kvm_lapic_set_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned long len);
>  void kvm_lapic_exit(void);
>  
> +u64 kvm_lapic_readable_reg_mask(struct kvm_lapic *apic);
> +
>  #define VEC_POS(v) ((v) & (32 - 1))
>  #define REG_POS(v) (((v) >> 5) << 4)
>  

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


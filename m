Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163AA5BF0C5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 01:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiITXDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 19:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiITXDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 19:03:21 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF114621F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:03:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t3so3906382ply.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=E44LtxBb4cFW/kLPJw1A0jZf+CX5zmSzX5uonY/R+VY=;
        b=IOM5LD7O5hlft6bVTbnyuQNGfvNbk1tT0zAkLCkQrG9RL+KlHK7IBeI07Gwz3pd1rc
         AFWuaYGAP5lYDyCmtmovpVFnHDgtM6h3RKVwUJ5XCL+1NP8DPkdZgDvmZFFz1DKxPki1
         0MGNCE717O6FC3c7L+2pGtFUMsuAMAvqaIQqgWKKi4O8afhI6jWTSHlA16FrwPK7Kz8z
         0+MuM1Y1518bJMC8pF+wWcVjFXUuGlW5tyPGIQJ0uvLzlG1SM3suBQkGVzXLcyUyvQwh
         uBdbpFIzLK3vlFbj5cj17yswtSmDTj7NnapWm4/sFacKVhEBoryWBkbDESAzmEhpO5X9
         T7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=E44LtxBb4cFW/kLPJw1A0jZf+CX5zmSzX5uonY/R+VY=;
        b=p7qBSnWScc0LtgW8Gnb3WZt6AbJDseru8x7u2bE1PIFRk+DoQBmbQdd8F/fQvxtoaO
         DJNg9MI2UI4kgyEBYfJO9ABgJSHzTPQa4hcFAio8yG5W/dA+1da7+N1FY81VAp4sdOmi
         ZyVDl8WmUi3XUDnO2523bFTrYRzwqpljm0UIDPwJTYcR771YY8jP5RXx2sAhvhhST/R2
         PRS9SjeMuSlZ32Z41NXsBf4J/KKNVHRIilASBtWZFdsockEaY4bFHfQAz/3qaWDIxN3s
         4IVi/4upMVCLJlm4yJJafS9PHa2hUExTCt9F+EiBnkM5COroRyTw7vs55awc44q3EAO+
         SUcA==
X-Gm-Message-State: ACrzQf37MsRO+XBqlz9Pey4UAM9J1LFP6X9Qq1h+aIHhUAlJUX+IVbui
        LALbZf8WfJ0jm3u4oywdY3NVRA==
X-Google-Smtp-Source: AMsMyM45dkTMa7ElEzbUnT3/VtdsrsuQn4Slxp7unEvmZyXmajo2YjikD9tCxViypUzSK++/JNqFTA==
X-Received: by 2002:a17:90b:3ec7:b0:202:b984:8436 with SMTP id rm7-20020a17090b3ec700b00202b9848436mr6324651pjb.4.1663714999365;
        Tue, 20 Sep 2022 16:03:19 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090276c600b001789b724712sm409491plt.232.2022.09.20.16.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 16:03:18 -0700 (PDT)
Date:   Tue, 20 Sep 2022 23:03:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] KVM: x86: Hyper-V invariant TSC control
Message-ID: <YypGs6BOX7Wvtl/H@google.com>
References: <20220916135205.3185973-1-vkuznets@redhat.com>
 <20220916135205.3185973-4-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916135205.3185973-4-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022, Vitaly Kuznetsov wrote:
> Normally, genuine Hyper-V doesn't expose architectural invariant TSC
> (CPUID.80000007H:EDX[8]) to its guests by default. A special PV MSR
> (HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x40000118) and corresponding CPUID
> feature bit (CPUID.0x40000003.EAX[15]) were introduced. When bit 0 of the
> PV MSR is set, invariant TSC bit starts to show up in CPUID. When the
> feature is exposed to Hyper-V guests, reenlightenment becomes unneeded.
> 
> Add the feature to KVM. Keep CPUID output intact when the feature
> wasn't exposed to L1 and implement the required logic for hiding
> invariant TSC when the feature was exposed and invariant TSC control
> MSR wasn't written to. Copy genuine Hyper-V behavior and forbid to
> disable the feature once it was enabled.

...

> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> index da2737f2a956..8be6dc3d76af 100644
> --- a/arch/x86/kvm/hyperv.h
> +++ b/arch/x86/kvm/hyperv.h
> @@ -133,6 +133,21 @@ static inline bool kvm_hv_has_stimer_pending(struct kvm_vcpu *vcpu)
>  			     HV_SYNIC_STIMER_COUNT);
>  }
>  
> +/*
> + * With HV_ACCESS_TSC_INVARIANT feature, invariant TSC (CPUID.80000007H:EDX[8])
> + * is only observed after HV_X64_MSR_TSC_INVARIANT_CONTROL was written to.
> + */
> +static inline bool kvm_hv_invtsc_suppressed(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
> +
> +	if (!hv_vcpu)
> +		return false;
> +
> +	return (hv_vcpu->cpuid_cache.features_eax & HV_ACCESS_TSC_INVARIANT) &&
> +		!(to_kvm_hv(vcpu->kvm)->hv_invtsc_control & HV_INVARIANT_TSC_EXPOSED);

It's still not obvious to me why KVM shouldn't do:

	if (!hv_vcpu)
		return false;

	return !(hv_vcpu->cpuid_cache.features_eax & HV_ACCESS_TSC_INVARIANT) ||
	       !(to_kvm_hv(vcpu->kvm)->hv_invtsc_control & HV_INVARIANT_TSC_EXPOSED);

I.e. why is invariant TSC _not_ suppressed on Hyper-V by default?

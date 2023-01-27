Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E4867F0E4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjA0WHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjA0WHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:07:41 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414A72E83D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:07:40 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id jm10so6314522plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TzQRCX+PVF8ExmxCtRtKuVa5dWjWhK6hNfkOiY6LP94=;
        b=ZsPnds5uiSJSgPfWj6uB2v0X1isPsbwhmou0thao6id+wBNbhjMx/UHvwcwitzVaOA
         PeLZsoJ0L9poYmgvFmGUPJczYzBpdRjkJy+P0epzVvHLgWe20ShNEKJOb5m/8nJUG2Pp
         i7ZTvjQ13rFzzFFPudN2X18EiXXGYauaXHn1ttb6aUu2pQ4DUKk5hIARccXn9GorkooZ
         fnEaFJnokdrnW4DrWCOwSHnh43YqcUvrdsyiaHXBjwv4/UWbZV+T17YgcTTMN8ArFL2Z
         9ZxoerQ5bcuJo01VJeqtKGrotS+duuw58/9B0jqZGawnI57GgTaeo5uIS6SEmtOHwEAH
         tEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzQRCX+PVF8ExmxCtRtKuVa5dWjWhK6hNfkOiY6LP94=;
        b=1USjv1wuTglDpHi1hhP7tf+XZEWxFFkW+XRsFIf/sPP6sr/E6ZGDjnR1V2xiFLjx5y
         jqYWULLlA6G3VNzijGtSSnfZDy29mnlGf9VqRby0118xoq3nPXYycOvUDongWAuOOAMb
         NmRIXlvarv5rdOInji7XjLhXdNqqTYRIFLIG4bT4lsbGmDiYy3SIoWa9eY2XwYFCjMxM
         U/XA7ikxU8SNPNabXbBT9Esut2/SVPlknztqH8VmGOiLDMYq6dRfSad4jOKfF1HSEP+q
         GTMrCzE6k2t1mPIwmNz48Ur4HTThij2vHWJlLOUeadZjqMZfj7+f5AS2z9GEIfBSeYpc
         8XDw==
X-Gm-Message-State: AO0yUKV1lUGyNU9Z/UUASQKbiyJpp6DWGEtoaAMzRSfPvKoio49Ji8NU
        7V2rtCyrpvjcQh4atuOJbKAw4w==
X-Google-Smtp-Source: AK7set+ScQzB4bLs6IE/mjC9PlfkgmNmLrgleBrv8cUovW567UA/kkrOuHvfzZ97U0K2vEprIByYFw==
X-Received: by 2002:a17:90a:6949:b0:219:f970:5119 with SMTP id j9-20020a17090a694900b00219f9705119mr153479pjm.1.1674857259613;
        Fri, 27 Jan 2023 14:07:39 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id em6-20020a17090b014600b00217090ece49sm3168655pjb.31.2023.01.27.14.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 14:07:38 -0800 (PST)
Date:   Fri, 27 Jan 2023 22:07:34 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, jmattson@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, like.xu.linux@gmail.com,
        kan.liang@linux.intel.com, wei.w.wang@intel.com,
        Like Xu <like.xu@linux.intel.com>
Subject: Re: [PATCH v2 11/15] KVM: x86: Add XSAVE Support for Architectural
 LBR
Message-ID: <Y9RLJsEGjXQ0IAlX@google.com>
References: <20221125040604.5051-1-weijiang.yang@intel.com>
 <20221125040604.5051-12-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125040604.5051-12-weijiang.yang@intel.com>
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

On Thu, Nov 24, 2022, Yang Weijiang wrote:
> From: Like Xu <like.xu@linux.intel.com>
> 
> On processors supporting XSAVES and XRSTORS, Architectural LBR XSAVE
> support is enumerated from CPUID.(EAX=0DH, ECX=1):ECX[bit 15].
> The detailed sub-leaf for Arch LBR is enumerated in CPUID.(0DH, 0FH).
> 
> XSAVES provides a faster means than RDMSR for guest to read all LBRs.
> When guest IA32_XSS[bit 15] is set, the Arch LBR state can be saved using
> XSAVES and restored by XRSTORS with the appropriate RFBM.
> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 4 ++++
>  arch/x86/kvm/x86.c     | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 359da38a19a1..3bc892e8cf7a 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7733,6 +7733,10 @@ static __init void vmx_set_cpu_caps(void)
>  		kvm_cpu_cap_check_and_set(X86_FEATURE_DS);
>  		kvm_cpu_cap_check_and_set(X86_FEATURE_DTES64);
>  	}
> +	if (!cpu_has_vmx_arch_lbr()) {
> +		kvm_cpu_cap_clear(X86_FEATURE_ARCH_LBR);

No, this needs to be opt-in, not opt-out.  I.e. omit the flag from common CPUID
code and set it if and only if it's fully supported.  It's not out of the realm
of possibilities that AMD might want to support arch LBRs, at which point those
CPUs would explode.

> +		kvm_caps.supported_xss &= ~XFEATURE_MASK_LBR;
> +	}
>  
>  	if (!enable_pmu)
>  		kvm_cpu_cap_clear(X86_FEATURE_PDCM);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 889be0c9176d..38df08d9d0cb 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -217,7 +217,7 @@ static struct kvm_user_return_msrs __percpu *user_return_msrs;
>  				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
>  				| XFEATURE_MASK_PKRU | XFEATURE_MASK_XTILE)
>  
> -#define KVM_SUPPORTED_XSS     0
> +#define KVM_SUPPORTED_XSS     XFEATURE_MASK_LBR
>  
>  u64 __read_mostly host_efer;
>  EXPORT_SYMBOL_GPL(host_efer);
> -- 
> 2.27.0
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B253F6915E8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjBJAxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjBJAww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:52:52 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F365A6D8E7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 16:52:51 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id a8-20020a17090a6d8800b002336b48f653so2079891pjk.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 16:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uPnpayA4k08OEBHz79JiJxvBceRHpyDlUNn6O4SbBXM=;
        b=DAjkg83djacSX43ga4PHCZIXBl5AJ+i8nMN3DwZjYz+0P4P61Sy30VaC8DrMbNionw
         QtMe7vTvgxp7gafl8KS5hLhG2mk+swZVjxnCQAmXG8yLzcxPkNL5jTiPOSgy9QxYL7Yd
         DXT/e0xNbJKGgQzZG1v6w9TU2n1JRulPgg2mNajTdZxy6QoIvoINI/NYRb214OjBcdrE
         dWc8NcyKwi20umJ4LL/YOqmis+tF7Kkh0cY9XcJmF84X1+Q5jzz4C8Eh6ab9sdBLSYf0
         P8J28egns+z8LnN+Rt2SBmSSwgRbwZlu5LKMck1j4wHlTTBjj+1ptvU9IBW1J+YWvlGg
         UwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPnpayA4k08OEBHz79JiJxvBceRHpyDlUNn6O4SbBXM=;
        b=tKkXBywXTzUPsDLZP6XoFrFISwY3heBAUsnH0sxRlmM2gzMPm1mkguozT+egAgo4XR
         Ma3YEeb2aME1HnDbq9qUHyj2zhMbvWw5PXwz1NpQjFa31vi621jkzoo46bOGpa94t9V/
         q1kDBW/4bhcC46RewrB1/zKRskzs2MYWHIzE49594aMC+d22HMT1ez7fLBulBE7b5Xb4
         a49AtONke/Ua8yah9ATgNYqpz0lcKIVoASlNdIWOgbQCMDhjpFDUXCtJvOb5J11LyrAm
         Sy+6ip20MFURWSJSlwdCMcKM4TRbMR+r+HwUfT4qH/2xH2cTaw342Ox7v6tgN55BuI9k
         HJDg==
X-Gm-Message-State: AO0yUKVpJ0jOnD++ur1/EWkm/398qlYC2clbYSSWHaeShMEwpByRGzI0
        t86XM40ue4bTg2ivDopMhADB33LwOb6O9ongf5g=
X-Google-Smtp-Source: AK7set/rrd1jvokSMvyG1LpUcfWA6gx8UT/73O8fJki7NEMiWEMuwjAJDr59ptVxoJulQKBpb1lkGg==
X-Received: by 2002:a17:903:1203:b0:19a:6cf2:3a08 with SMTP id l3-20020a170903120300b0019a6cf23a08mr43810plh.1.1675990371289;
        Thu, 09 Feb 2023 16:52:51 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902768400b00194c1281ca9sm2123535pll.166.2023.02.09.16.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 16:52:50 -0800 (PST)
Date:   Fri, 10 Feb 2023 00:52:47 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
Subject: Re: [PATCH V2 3/8] kvm: x86/mmu: Use kvm_mmu_invalidate_gva() in
 nested_ept_invalidate_addr()
Message-ID: <Y+WVX7Q1pw6ofgS+@google.com>
References: <20230207155735.2845-1-jiangshanlai@gmail.com>
 <20230207155735.2845-4-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207155735.2845-4-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> Use kvm_mmu_invalidate_gva() instead open calls to mmu->invlpg().
> 
> No functional change intended.
> 
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  arch/x86/kvm/mmu/mmu.c    | 1 +
>  arch/x86/kvm/vmx/nested.c | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 8563b52b8bb7..e03cf5558773 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5734,6 +5734,7 @@ void kvm_mmu_invalidate_gva(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
>  			mmu->invlpg(vcpu, gva, mmu->prev_roots[i].hpa);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(kvm_mmu_invalidate_gva);
>  
>  void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
>  {
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 557b9c468734..f552f3c454b1 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -358,6 +358,7 @@ static bool nested_ept_root_matches(hpa_t root_hpa, u64 root_eptp, u64 eptp)
>  static void nested_ept_invalidate_addr(struct kvm_vcpu *vcpu, gpa_t eptp,
>  				       gpa_t addr)
>  {
> +	unsigned long roots = 0;
>  	uint i;
>  	struct kvm_mmu_root_info *cached_root;
>  
> @@ -368,8 +369,10 @@ static void nested_ept_invalidate_addr(struct kvm_vcpu *vcpu, gpa_t eptp,
>  
>  		if (nested_ept_root_matches(cached_root->hpa, cached_root->pgd,
>  					    eptp))
> -			vcpu->arch.mmu->invlpg(vcpu, addr, cached_root->hpa);
> +			roots |= KVM_MMU_ROOT_PREVIOUS(i);
>  	}
> +	if (roots)
> +		kvm_mmu_invalidate_gva(vcpu, vcpu->arch.mmu, addr, roots);

This is subtly buggy.  On 32-bit kernels, the upper 32 bits of the GPA will get
dropped.  "addr" here is a gpa_t, i.e. u64, whereas kvm_mmu_invalidate_gva() takes
a gva_t, i.e. unsigned long.

FNAME(gva_to_gpa) just eats the misnomer, but I think I'd rather rename this path,
e.g. kvm_mmu_invalidate_addr()?

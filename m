Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523325BEF2E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 23:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiITVdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 17:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiITVdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 17:33:08 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DE17539A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 14:33:08 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c198so3926030pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 14:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=qWwy1T8n8n9Tdvr/DoRypsDG6NkS92TiQuapV97dptc=;
        b=rr/PyHgkYMcKbfqM25TQNVASBHHOBEQkboP19XA1vMntPblYqzwOIut6VRxQw8KnAb
         ET0SHpQmfmNYDiQNzROGuIyFhrXSR80luXEw+gPjsgLRFvOKRbyDnuZCWxX2FcOdX8AU
         ITD3WMMfDbH94Wt6mt+Z7yloO5UVwhHa1QERIfAQrLe5SDSBnJDYieTNfMEz4Rh+EnaX
         URCnxCR+46yzz8fZwtIyQHagefWs89TrrZiV4gfl2BrKyw91f/zgIjxDnAV1m9MkweJ0
         fHGy1w/997SH1yfQONaFlYmt8sTNIAaYw0w74gv6u9MpTOOUKiVuPp3b7zZOAdZp7H6R
         HaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qWwy1T8n8n9Tdvr/DoRypsDG6NkS92TiQuapV97dptc=;
        b=1SBhg9l4jCkBErDY7sdPoB5g0Ra4u5Jf8cQISfg3KQLc8d6qXq5oNothVFbqyq9ap+
         tR+BfZAvxOgthGSWa6dFeuuYgDcDeHNKG3TgKiCynhShwlcY4SQja5VLB73Qb8jMJi9S
         nEuhNoZTzdb2goMlARilKCsQoaoBrfLxl9DFSXDndQ6qxHDCpaqCahCx50jQ3OxT5L7p
         l2Hu0bnLzMpw+Ip9woAPc40OyJ4BKZrThovhuxwJPMSXz1B2IseCvB5IlNwj9OTXfvwx
         HH5NdBxnmX3VVGB8SSH2gINH8Seppqcf9k0uVTLFnlzbiJ3qBzYEY+989i9laWl/ZXEY
         qw5g==
X-Gm-Message-State: ACrzQf2M4PZIQ6Wbk8YtdibJ2vcRLj1hQondY9EbQzynYb5q5kBT9Mx4
        7URmyrJTLPI1OpGLdfhGXql9+g==
X-Google-Smtp-Source: AMsMyM4Youx+wm+8ZwytM+QL6YFCmfmIzS9qtDmO5B6oTXCy6kEUvUc/ikMI8Wcejri5VupgWi5YpA==
X-Received: by 2002:a62:4e4c:0:b0:53e:22b6:6869 with SMTP id c73-20020a624e4c000000b0053e22b66869mr24959226pfb.29.1663709587388;
        Tue, 20 Sep 2022 14:33:07 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id s16-20020aa78bd0000000b0053e7d3b8d6dsm407223pfd.1.2022.09.20.14.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 14:33:06 -0700 (PDT)
Date:   Tue, 20 Sep 2022 21:33:03 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Justinien Bouron <justinien.bouron@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Handle MXCSR in
 kvm_arch_vcpu_ioctl_{get,set}_fpu.
Message-ID: <YyoxjwuCVTsbmpYv@google.com>
References: <20220917000928.118-1-justinien.bouron@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917000928.118-1-justinien.bouron@gmail.com>
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

On Sat, Sep 17, 2022, Justinien Bouron wrote:
> kvm_arch_vcpu_ioctl_get_fpu does not set the mxcsr in the kvm_fpu
> struct; conversely kvm_arch_vcpu_ioctl_set_fpu does not set the mxcsr
> value in the fxregs_state struct of the vcpu.
> This leads to the KVM_GET_FPU ioctl returning 0 as the mxcsr value,
> regardless of the actual value on the vcpu; while KVM_SET_FPU leaves the
> MXCSR on the vcpu untouched.
> 
> Fix kvm_arch_vcpu_ioctl_{get,set}_fpu to properly handle MXCSR.
> 
> Signed-off-by: Justinien Bouron <justinien.bouron@gmail.com>
> ---
>  arch/x86/kvm/x86.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 43a6a7efc6ec..c33a2599a497 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11462,6 +11462,7 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
>  	fpu->last_ip = fxsave->rip;
>  	fpu->last_dp = fxsave->rdp;
>  	memcpy(fpu->xmm, fxsave->xmm_space, sizeof(fxsave->xmm_space));
> +	fpu->mxcsr = fxsave->mxcsr;
>  
>  	vcpu_put(vcpu);
>  	return 0;
> @@ -11486,6 +11487,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
>  	fxsave->rip = fpu->last_ip;
>  	fxsave->rdp = fpu->last_dp;
>  	memcpy(fxsave->xmm_space, fpu->xmm, sizeof(fxsave->xmm_space));
> +	fxsave->mxcsr = fpu->mxcsr;

The incoming MXCSR needs to be vetted, e.g. see fpu_copy_uabi_to_guest_fpstate().

That said, this code is incredibly ancient and has been obsolete for years.  I
wonder if we can get away with deprecating KVM_{G,S}ET_FPU on x86 and leaving the
broken behavior as-is.

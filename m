Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2291267F387
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 02:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjA1BKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 20:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjA1BKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 20:10:38 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A04F84969
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 17:10:24 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id k18so6645534pll.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 17:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LPvFlv1qzhhMXZX/ngrrOPisxT3heAqNxxBRWY5RHo4=;
        b=EgFI+yOs/yfi2HdTXGjZsF+hrwc+8ky35BUgVxLaGBgJ1U/hThYr4VEBInDLXoxmIn
         zRDX37DlidS31/gdWFu7bjXElG4hfwi6QK313s19jlgsxJk3uTSDBolwAGXb7uFK4msV
         yrgLwkY/7skMi+a7r8rrwTYpyqeoce9Mg+BmAwrbHr+0wjUNGG1eAu9xO1ZU+LxgL4Gt
         uUwjM8Rdmhw43X38qR2wdRvSRZAEZXu8anQkdtEcW8DpXU+dG2AKuEbehza6r1rAex4n
         mObZ6f16sPloR45C83h5SFhodjt/x1Q1hQUoOqM2NoomM9ysVh8EBhfSd+zphL8LsOZw
         4Eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPvFlv1qzhhMXZX/ngrrOPisxT3heAqNxxBRWY5RHo4=;
        b=MIeTcyqJiztiZV4XywtClFKxzlLPTt4K1HtFl4n6Y4TJ2qigKwU2fGBePCojAckjcL
         EvmmJy/fanf2vUKpZDJiDqQzBtiRsLvpDPuu9tR8Wts5EX1UmrPA1KH0qNrIenQGJNN2
         G8hAtmZZUvYOunX2rOukbJjAlv6fi7vQFfDhpKU/TkmEY3d+eyVt4fKgRQ1nPpu/9L1r
         CxGfEjk9e6/bGl7O7V12kZWRRNZcZmCaXoesfKraZMKJBNPqfOz8UMTEOKAm/lo88wPA
         78H8/rcP8h0DDfarLKBRsHuqcGm4IjmgkwNOEmaHtU0oBLa/taTVI2jjxIr3BpCOtji3
         YfeQ==
X-Gm-Message-State: AO0yUKWmMaCLPgss6hhIQSw+b1rFhVy4HtgX+nPb1DP+XEA9G3dU9WWT
        oLXtkZKpxupFiWO3uzTusgoirg==
X-Google-Smtp-Source: AK7set8l7hUNo3mVF+naXijiH0TKQBOGAhZv1aMbsaHi7dRuKzgwWV6Y6Rgwey6ELM1/KP0llRqj/w==
X-Received: by 2002:a17:902:d70a:b0:193:256d:8afe with SMTP id w10-20020a170902d70a00b00193256d8afemr209149ply.2.1674868223140;
        Fri, 27 Jan 2023 17:10:23 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a13-20020a637f0d000000b004cd1e132865sm2857397pgd.84.2023.01.27.17.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 17:10:22 -0800 (PST)
Date:   Sat, 28 Jan 2023 01:10:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Sandipan Das <sandipan.das@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        Jing Liu <jing2.liu@intel.com>,
        Wyes Karny <wyes.karny@amd.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Santosh Shukla <santosh.shukla@amd.com>
Subject: Re: [PATCH v2 10/11] KVM: SVM: implement support for vNMI
Message-ID: <Y9R1+hPaTWcEZMOX@google.com>
References: <20221129193717.513824-1-mlevitsk@redhat.com>
 <20221129193717.513824-11-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129193717.513824-11-mlevitsk@redhat.com>
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

On Tue, Nov 29, 2022, Maxim Levitsky wrote:
> This patch implements support for injecting pending
> NMIs via the .kvm_x86_set_hw_nmi_pending using new AMD's vNMI
> feature.
> 
> Note that the vNMI can't cause a VM exit, which is needed
> when a nested guest intercepts NMIs.
> 
> Therefore to avoid breaking nesting, the vNMI is inhibited while
> a nested guest is running and instead, the legacy NMI window
> detection and delivery method is used.
> 
> While it is possible to passthrough the vNMI if a nested guest
> doesn't intercept NMIs, such usage is very uncommon, and it's
> not worth to optimize for.
> 
> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/svm/nested.c |  42 +++++++++++++++
>  arch/x86/kvm/svm/svm.c    | 111 ++++++++++++++++++++++++++++++--------
>  arch/x86/kvm/svm/svm.h    |  10 ++++
>  3 files changed, 140 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index e891318595113e..5bea672bf8b12d 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -623,6 +623,42 @@ static bool is_evtinj_nmi(u32 evtinj)
>  	return type == SVM_EVTINJ_TYPE_NMI;
>  }
>  
> +static void nested_svm_save_vnmi(struct vcpu_svm *svm)
> +{
> +	struct vmcb *vmcb01 = svm->vmcb01.ptr;
> +
> +	/*
> +	 * Copy the vNMI state back to software NMI tracking state
> +	 * for the duration of the nested run
> +	 */
> +

Unecessary newline.

> +	svm->nmi_masked = vmcb01->control.int_ctl & V_NMI_MASK;
> +	svm->vcpu.arch.nmi_pending += vmcb01->control.int_ctl & V_NMI_PENDING;
> +}
> +
> +static void nested_svm_restore_vnmi(struct vcpu_svm *svm)
> +{
> +	struct kvm_vcpu *vcpu = &svm->vcpu;
> +	struct vmcb *vmcb01 = svm->vmcb01.ptr;
> +
> +	/*
> +	 * Restore the vNMI state from the software NMI tracking state
> +	 * after a nested run
> +	 */
> +

Unnecessary newline.

> +	if (svm->nmi_masked)
> +		vmcb01->control.int_ctl |= V_NMI_MASK;
> +	else
> +		vmcb01->control.int_ctl &= ~V_NMI_MASK;
> +
> +	if (vcpu->arch.nmi_pending) {
> +		vcpu->arch.nmi_pending--;
> +		vmcb01->control.int_ctl |= V_NMI_PENDING;
> +	} else
> +		vmcb01->control.int_ctl &= ~V_NMI_PENDING;

Needs curly braces.


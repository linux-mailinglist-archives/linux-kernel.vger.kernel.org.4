Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A801663CC68
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 01:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiK3ANt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 19:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiK3ANe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 19:13:34 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4983A73422
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 16:13:14 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id x66so15300020pfx.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 16:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z0DM5tDpbilfkWF6HtGDZ6Fwkblmq8euBR/PI59m22k=;
        b=X+w2SodLZ4zP5jI4YvydN9gYtqkXs6XJ17MfOs3yOVYADmyFGcbFekq7l8eDLqRUMq
         TUgj6BA5D7ot9TR25Hc7JDITCAU1AdIQvCrYviFAd+ovUkQzdFs23sujnZksSbzMhl+O
         8OWtHcmC6O+tqSAnBpdOakp5kPHN2Tr/NL/JJ1vryKqj4omcMULgCm3e7uluZklaGVoN
         /FC5pesPAm4r4KgZrqojhAEvvtgE1dSbVSqSfevhpfnxNLeNB/RDKjADBEMPnUdi/pU1
         ONn9d2ZRzlwwQssbmp5dSBs1hLLwxV6RtyqSB9smw+5qPpDc7tXOzIe8F23mLyVtXA6C
         1SVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0DM5tDpbilfkWF6HtGDZ6Fwkblmq8euBR/PI59m22k=;
        b=AHZoOf9OhT3uSDXuC9oaNixRfGvS7k9ZmpZOyx9yvd8DuYp6jQPfjxC4A2u41W1ePP
         6kKrr6VzPiqbn2aW9TrxOWMP3PPGhKdje0ChdvEMYCd3HWIRGNGLPurI/gEllN8ot1Xg
         UKGqFkaDAWl8VPwN2LtCmXWmRaXeSL5P9SNbR57BiA/Quo8F7sTmb7Y+fQ/m3korj0SB
         F2iuoUMdZmrd7KRauID1CD+y70p//jCuJWYXQgzF1SL3Z+5RqOxW+egLBLV9q16oa31f
         ECn9IB3blQuqdGxauTNcceFwQT4ForriLzVUBDSsQ1WcKKuTS7ltDodMSHTR2l+sJyXu
         fAOA==
X-Gm-Message-State: ANoB5pmmgfYDBacW+fQGiMYTXr553LBEpE5htU1/9vCDe85jI+HnHA+t
        nLMLXJ3dIhxixY9LLCckG8A8xA==
X-Google-Smtp-Source: AA0mqf7vrtO27kyWB7weCDRH7BmwrG65H7VSwLRzv7tocPo6tUmL4wlIXj3ONf+Fdd/lvfXEKTP2Hw==
X-Received: by 2002:a63:1a48:0:b0:477:786:f557 with SMTP id a8-20020a631a48000000b004770786f557mr35233251pgm.476.1669767193543;
        Tue, 29 Nov 2022 16:13:13 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 15-20020a630f4f000000b0047702d44861sm8617542pgp.18.2022.11.29.16.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 16:13:13 -0800 (PST)
Date:   Wed, 30 Nov 2022 00:13:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     x86@kernel.org, Babu Moger <Babu.Moger@amd.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Alexey Kardashevskiy <aik@amd.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] x86/cpu, kvm: Move CPUID 0x80000021 EAX feature
 bits propagation to kvm_set_cpu_caps
Message-ID: <Y4agFT6OwvZzSgn1@google.com>
References: <20221129235816.188737-1-kim.phillips@amd.com>
 <20221129235816.188737-5-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129235816.188737-5-kim.phillips@amd.com>
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

() after function names, i.e. kvm_set_cpu_caps().

On Tue, Nov 29, 2022, Kim Phillips wrote:
> Since they're now all scattered, group CPUID 0x80000021 EAX feature bits

Nit, scattering feature bits isn't required to use KVM's reverse CPUID magic,
e.g. see commit 047c72299061 ("KVM: x86: Update KVM-only leaf handling to allow
for 100% KVM-only leafs") that's sitting in kvm/queue.

The real justification for this patch is that open coding numbers is error prone
and is very frowned upon in KVM.

> propagation to kvm_set_cpu_caps instead of open-coding them in

kvm_set_cpu_caps()

> __do_cpuid_func().
> 
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---
>  arch/x86/kvm/cpuid.c         | 35 ++++++++++++++++++++---------------
>  arch/x86/kvm/reverse_cpuid.h | 22 ++++++++++++++++------
>  2 files changed, 36 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index c92c49a0b35b..8e37760cea1b 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -730,6 +730,25 @@ void kvm_set_cpu_caps(void)
>  		0 /* SME */ | F(SEV) | 0 /* VM_PAGE_FLUSH */ | F(SEV_ES) |
>  		F(SME_COHERENT));
>  
> +	/*
> +	 * Pass down these bits:
> +	 *    EAX      0      NNDBP, Processor ignores nested data breakpoints
> +	 *    EAX      2      LAS, LFENCE always serializing
> +	 *    EAX      6      NSCB, Null selector clear base
> +	 *    EAX      8      Automatic IBRS

Automatic IBRS isn't advertised as of this patch.  Just drop the comment, it's
guaranteed to become stale at some point, and one of the main reasons for the
flag magic is so that the code is self-documenting, i.e. so that we don't need
comments like this.

> +	 *
> +	 * Other defined bits are for MSRs that KVM does not expose:
> +	 *   EAX      3      SPCL, SMM page configuration lock
> +	 *   EAX      13     PCMSR, Prefetch control MSR
> +	 */
> +	kvm_cpu_cap_init_scattered(CPUID_8000_0021_EAX,
> +				   SF(NO_NESTED_DATA_BP) | SF(LFENCE_RDTSC) |
> +				   SF(NULL_SEL_CLR_BASE));

Please follow the established style, e.g.

	kvm_cpu_cap_init_scattered(CPUID_8000_0021_EAX,                         
		SF(NO_NESTED_DATA_BP) | SF(LFENCE_RDTSC) | SF(NULL_SEL_CLR_BASE)
	);

> +	if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))

I highly doubt it matters, but using cpu_feature_enabled() instead of static_cpu_has()
is an unrelated change.  At the very least, it should be mentioned in the changelog.

> +		kvm_cpu_cap_set(X86_FEATURE_LFENCE_RDTSC);
> +	if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
> +		kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE);
> +
>  	kvm_cpu_cap_mask(CPUID_C000_0001_EDX,
>  		F(XSTORE) | F(XSTORE_EN) | F(XCRYPT) | F(XCRYPT_EN) |
>  		F(ACE2) | F(ACE2_EN) | F(PHE) | F(PHE_EN) |

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C02063CC27
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 01:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiK3AFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 19:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiK3AFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 19:05:32 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9929711A1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 16:05:27 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id a9so11840206pfr.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 16:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=78xkKmjZdcyJJX/EKydkrCgU4mT4d8eXN6PXwFhDQLo=;
        b=KODgIpqJyt1Ud4fI+DS6czurLJ2VemQmXk7RbZDL+iUqI65PIa3EciFifTfHv/qTyD
         dy55U+P5bZkaiQdnkx0xfwIzCCQjg4N/DtzbuYZzXYtY6Mv1qWDJ/MG1zwsYs6SNC0fU
         tu0IYWFej3VY3GPYQmYhd1Ts6JjfnMBjzAnKZjFNb4XbhBiUncuxoy8HWjVWMTKyimPv
         SotKeN8JI+UpTEtSWJ23Zhu+meSIAFJL2NG52t4KW3a/i7AXzMU99HLIadJ4fODoOWcJ
         sq5jaYtobOA9KzfparlEoR3TwmrROzQ91ajJQL6zbpS34giRUA9VPDDSGiPOt85RAQ/+
         DDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78xkKmjZdcyJJX/EKydkrCgU4mT4d8eXN6PXwFhDQLo=;
        b=NpSBl5Z1tr5DSCYBQ0vt3N0Wn7k80ruy9iiIhkeu9nYN2aZQt8M9tnfEkO6XU85tkq
         QBQrlOGSiJRj1BWN1MhYzBx9KnQOizGIv/LHvpf+lkL8purdQSnvA06vlGkI9cHK5JMB
         IguPgFj8b3xZUuLsrCukQ6X5Pu2YohdJqZ8KMe3LMCq7sgOl+CdcmjWUhFOQv4HQdd4o
         sqePAix4e0XPdSZ45ViYvtwD45VA0wefpFt/6fy6hXkmaXm3dCD+kQ1B4lbK0IGv7JAH
         VJHM0vwU6GsUHtNPaYnvNL36fGXg6veeaIW3nIxFQfZiTxE37qoI0KGSO9OZ9q/FZH/I
         o1oQ==
X-Gm-Message-State: ANoB5plrhjKuq1zSox7o0+1rCT+Z+rjw8ieoMlD/X2gKEnoPrrgQ8cnv
        TRBxQh2wJWSpSQvIqUvB17eMfA==
X-Google-Smtp-Source: AA0mqf5KWdC4uvoi15DjzFozbTNWpAR+P62QvcL1C1e/IzMkBVRINdThD0PS4d1bisH1+7NMOyP9RA==
X-Received: by 2002:a63:4946:0:b0:477:7c87:1087 with SMTP id y6-20020a634946000000b004777c871087mr38965938pgk.452.1669766727210;
        Tue, 29 Nov 2022 16:05:27 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id e4-20020aa79804000000b0056bb0357f5bsm38826pfl.192.2022.11.29.16.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 16:05:26 -0800 (PST)
Date:   Wed, 30 Nov 2022 00:05:23 +0000
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
Subject: Re: [PATCH v3 1/7] x86/cpu, kvm: Define a scattered No Nested Data
 Breakpoints feature bit
Message-ID: <Y4aeQ5Qyu1Y3QtaJ@google.com>
References: <20221129235816.188737-1-kim.phillips@amd.com>
 <20221129235816.188737-2-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129235816.188737-2-kim.phillips@amd.com>
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

No need for "kvm" in the shortlog, this doesn't affect KVM behavior in any way,
let alone touch KVM code.  Ditto for all the other patches that don't touch KVM.

On Tue, Nov 29, 2022, Kim Phillips wrote:
> It's a part of the CPUID 0x80000021 leaf, and this allows us to
> group this and other CPUID 0x80000021 EAX feature bits to being
> propagated via kvm_set_cpu_caps instead of open-coding them in
> __do_cpuid_func().
> 
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 2 +-
>  arch/x86/kernel/cpu/scattered.c    | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index b6525491a41b..b16fdcedc2b5 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -306,8 +306,8 @@
>  #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
>  #define X86_FEATURE_SGX_EDECCSSA	(11*32+18) /* "" SGX EDECCSSA user leaf function */
>  #define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth tracking for RSB stuffing */
> -
>  #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
> +#define X86_FEATURE_NO_NESTED_DATA_BP	(11*32+21) /* "" AMD No Nested Data Breakpoints */
>  
>  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
>  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index f53944fb8f7f..079e253e1049 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -45,6 +45,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>  	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
>  	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
>  	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
> +	{ X86_FEATURE_NO_NESTED_DATA_BP,CPUID_EAX,  0, 0x80000021, 0 },
>  	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
>  	{ 0, 0, 0, 0, 0 }
> -- 
> 2.34.1
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7343B6748E4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjATBd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjATBd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:33:26 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44FFB743
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 17:33:23 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id b6so3022581pgi.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 17:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp68jZKRyQvb1CWCfr7ryxkqu7zJ892bk7TwE8UhDeg=;
        b=H/l0Obt0lE8Dt7WZH0dN6w05VSK2+qVutkVXC28jA6GVboKJkdOb6dy6flHfifS3eA
         twQ2J0d4UNa0dl1Qn8gm0ibDLWgmNTpA6plkncRthFcZHjH7D4BuCq1cps6AxIk7yQ1g
         tTeOqX8tMIymvL4hVtxnDU0TIUkwKcq9pgR7K1TYOAuiDS/S7HQdFY2ixosd08LKKT/n
         dv1ykJakGnF3GMus+uWOXqpvdPfQxtjgpP7Uwk+lCEiRNFef8uXCERWuIZN7wfmpIkzK
         K6bSXy0hREjSgP4rqdKLOnspmtPZnZ+ZW04ugucxZwzVgxxZVvo3hmwe9b4FgtHFFm09
         GPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kp68jZKRyQvb1CWCfr7ryxkqu7zJ892bk7TwE8UhDeg=;
        b=yfGnyGJIle4zXhxBvtV0OMYZCf6aGSN2M6u6tQ0J/I5CnnN4gt8Z5z/mG0JdT3J0I7
         AQ0HpZ5oE+Ny2xLh/TyyUnQWFE/IYvb+wHwg5Wx8pJkFlMar6dSTDO6bk06bRgFt61Ya
         BlY43pkHzEp+vZgqAARRhlfRAeVV3keadVIcwt9xyxMf5047hKXVuf103pjbhwy8Akl/
         wTbX8hOPTaQS2hkeD/2ug2y4Qq+3hS5qRRhRWGIdtOp4/zEbHygP7WpFTckRDQz0nSYo
         Omt39q/fFkrOyBJjHhF0v4MXbxfHs7guUzZwz/2RoMHRT8T1BYM7sAJfniKKbY4CTCMF
         p9aA==
X-Gm-Message-State: AFqh2koNph1eYLCf1gnMVGwkazLKichTiPMzWIx7o7tgj3XjU6KZWDcY
        FvrBXMb8+Iro9mamtHwUyTy0FQ==
X-Google-Smtp-Source: AMrXdXuj+pEzgczWgpSXc9mTAUie4xUf244aRmyLrVfENL9pUUqVg7frR07KJZR3dR0VXrbhEpML/A==
X-Received: by 2002:aa7:84d8:0:b0:58b:cb1b:978f with SMTP id x24-20020aa784d8000000b0058bcb1b978fmr18689pfn.1.1674178403000;
        Thu, 19 Jan 2023 17:33:23 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id f129-20020a623887000000b0058bf2ae9694sm10265600pfa.156.2023.01.19.17.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 17:33:22 -0800 (PST)
Date:   Fri, 20 Jan 2023 01:33:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Borislav Petkov <borislav.petkov@amd.com>,
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
Subject: Re: [PATCH v6 2/7] x86/cpu, kvm: Add the NO_NESTED_DATA_BP feature
Message-ID: <Y8nvXj0//cImdTJQ@google.com>
References: <20230110224643.452273-1-kim.phillips@amd.com>
 <20230110224643.452273-4-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110224643.452273-4-kim.phillips@amd.com>
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

On Tue, Jan 10, 2023, Kim Phillips wrote:
> The "Processor ignores nested data breakpoints" feature was being
> open-coded for KVM in __do_cpuid_func().  Add it to its newly added
> CPUID leaf 0x80000021 EAX proper, and propagate it in kvm_set_cpu_caps()
> instead.
> 
> Also drop the bit description comments now it's more self-describing.
> 
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 3 +++
>  arch/x86/kvm/cpuid.c               | 8 ++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index d53e13048d2e..0cd7b4afd528 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -426,6 +426,9 @@
>  #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
>  #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
>  
> +/* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
> +#define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* "" AMD No Nested Data Breakpoints */
> +
>  /*
>   * BUG word(s)
>   */
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index b14653b61470..69e433e4e9ff 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -741,6 +741,10 @@ void kvm_set_cpu_caps(void)
>  		0 /* SME */ | F(SEV) | 0 /* VM_PAGE_FLUSH */ | F(SEV_ES) |
>  		F(SME_COHERENT));
>  
> +	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
> +		F(NO_NESTED_DATA_BP)
> +	);
> +
>  	kvm_cpu_cap_mask(CPUID_C000_0001_EDX,
>  		F(XSTORE) | F(XSTORE_EN) | F(XCRYPT) | F(XCRYPT_EN) |
>  		F(ACE2) | F(ACE2_EN) | F(PHE) | F(PHE_EN) |
> @@ -1222,9 +1226,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		break;
>  	case 0x80000021:
>  		entry->ebx = entry->ecx = entry->edx = 0;
> +		cpuid_entry_override(entry, CPUID_8000_0021_EAX);
>  		/*
>  		 * Pass down these bits:
> -		 *    EAX      0      NNDBP, Processor ignores nested data breakpoints
>  		 *    EAX      2      LAS, LFENCE always serializing
>  		 *    EAX      6      NSCB, Null selector clear base
>  		 *
> @@ -1235,7 +1239,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		 * KVM doesn't support SMM_CTL.
>  		 *   EAX       9     SMM_CTL MSR is not supported
>  		 */
> -		entry->eax &= BIT(0) | BIT(2) | BIT(6);
> +		entry->eax &= BIT(2) | BIT(6);

This is broken.  It gets fixed by the end of the series, but between here and
commit b1366f515fd6 ("x86/cpu, kvm: Add the Null Selector Clears Base feature"),
the AND with open coded bits means any bits preserved/set by cpuid_entry_override()
are wiped out.  E.g. NO_NESTED_DATA_BP will never be advertised as of this patch.

The proper way to do this is to first convert all supported bits away from magic
numbers in a single patch, and then introduce newly supported bits one by one.
That one patch will be larger, but I don't see a better approach.

Is it too late to back this out?  Not a huge deal, but it seems easy enough to
clean up.

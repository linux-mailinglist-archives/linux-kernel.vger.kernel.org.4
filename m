Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E21067A765
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 01:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjAYAQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 19:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjAYAQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:16:19 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A29748A35
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:16:18 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 88so5241713pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9UlKt43E2njAMel5lTeV0RuiH54jP6JJgn/MaI87eQ=;
        b=cyFg0CY1a5zRqK3gFsPgIys+tUEPnqtZZaYV3DwtP9wfJu+7xfjHVrVWUVEk01LhbJ
         r5NOBKSPcBovb2dtCaYS0Z4U4znoDB8IdUFGyaJs9JNjcmbRrLL/WPF0gDYFAxtTOmZj
         aEf0q31XK0ahsnsMjj3U6s4Cvu/XniLAuHXjwjE7hXxZiGa7m6IE88QA5sO0N46/lNDb
         kT9TsvR7OU+ZFMweWL3lLiJUU2sQcTvUH4LghIsWpGUqlinaSOZQC3nZlw6X0xvtnhHp
         cU0JLCDpf1yErVyWz7+P7CEzToh0qks2W5K9I9I32BxoO2RJ8ijl5fBmJkMCz2xAL1pV
         HkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9UlKt43E2njAMel5lTeV0RuiH54jP6JJgn/MaI87eQ=;
        b=xDfYS+5BG0A94ziFMwlMYh0QUXXN51diiGeoaqRLv43S+Y6eS1rCy8OPAsya66s7j5
         cNBv3neBvmUJ7RkuAZ7BOcEpJ5BGG2nh1ayWka7rp016Ve5z5Z3vxJtB0WbpYdbqNwmj
         YX3P42sdbbIOepKPifs0jdbW3cSZyIBO2cuOXuH7JXaj0KP5FSKP/QCB1fPNvNQPnLNv
         2n3bXhyoplet0pi24tUF3EAaXACoYSeZzRaqf96yIfBkz+9A4W5T1E21hjh3eowcUyNm
         vTq4Qj4VScD12zldBTNKVb5Pa/KiSnrqBG8ruiSd58nKpnvmGpyaZBjL+dsuXdSpw6Fr
         bfuQ==
X-Gm-Message-State: AO0yUKW3VL8I5c1BlxYfOQDnOBp6w4kTLoPUh1x7/acBqXxwDh/N7zFO
        Cpk5HqHg3B8sjZmDo0AN6p0+PA==
X-Google-Smtp-Source: AK7set/AMNTF4jXokNQGO71KPoa9jLj3jvaQLmywQ8hQPHYq56x4QBTyElEB6w670GQz8xIC8lIGrA==
X-Received: by 2002:a05:6a20:9d90:b0:b8:e33c:f160 with SMTP id mu16-20020a056a209d9000b000b8e33cf160mr510562pzb.0.1674605777916;
        Tue, 24 Jan 2023 16:16:17 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a8-20020a656548000000b0048988ed9e4bsm2024351pgw.19.2023.01.24.16.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 16:16:17 -0800 (PST)
Date:   Wed, 25 Jan 2023 00:16:14 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v3 7/8] KVM: x86/cpuid: Add AMD CPUID ExtPerfMonAndDbg
 leaf 0x80000022
Message-ID: <Y9B0zgliB9BMPK1l@google.com>
References: <20221111102645.82001-1-likexu@tencent.com>
 <20221111102645.82001-8-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111102645.82001-8-likexu@tencent.com>
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

On Fri, Nov 11, 2022, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> CPUID leaf 0x80000022 i.e. ExtPerfMonAndDbg advertises some new
> performance monitoring features for AMD processors.
> 
> Bit 0 of EAX indicates support for Performance Monitoring Version 2
> (PerfMonV2) features. If found to be set during PMU initialization,
> the EBX bits of the same CPUID function can be used to determine
> the number of available PMCs for different PMU types.
> 
> Expose the relevant bits via KVM_GET_SUPPORTED_CPUID so that
> guests can make use of the PerfMonV2 features.
> 
> Co-developed-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  arch/x86/kvm/cpuid.c   | 30 +++++++++++++++++++++++++++++-
>  arch/x86/kvm/svm/svm.c | 11 ++++++++---
>  2 files changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 6b5912578edd..df551fa66ccc 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1113,7 +1113,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		entry->edx = 0;
>  		break;
>  	case 0x80000000:
> -		entry->eax = min(entry->eax, 0x80000021);
> +		entry->eax = min(entry->eax, 0x80000022);
>  		/*
>  		 * Serializing LFENCE is reported in a multitude of ways, and
>  		 * NullSegClearsBase is not reported in CPUID on Zen2; help
> @@ -1229,6 +1229,34 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
>  			entry->eax |= BIT(6);
>  		break;
> +	/* AMD Extended Performance Monitoring and Debug */
> +	case 0x80000022: {
> +		union cpuid_0x80000022_ebx ebx;
> +
> +		entry->ecx = entry->edx = 0;
> +		if (!enable_pmu || !kvm_cpu_cap_has(X86_FEATURE_AMD_PMU_V2)) {
> +			entry->eax = entry->ebx;
> +			break;
> +		}
> +
> +		cpuid_entry_override(entry, CPUID_8000_0022_EAX);
> +
> +		if (kvm_cpu_cap_has(X86_FEATURE_AMD_PMU_V2))
> +			ebx.split.num_core_pmc = min(kvm_pmu_cap.num_counters_gp,
> +						     KVM_AMD_PMC_MAX_GENERIC);

Similar to the previous patch, sanitizing kvm_pmu_cap.num_counters_gp should be
handled during PMU initialization.

> +
> +		if (kvm_cpu_cap_has(X86_FEATURE_PERFCTR_CORE))
> +			ebx.split.num_core_pmc = max_t(unsigned int,
> +						       ebx.split.num_core_pmc,
> +						       AMD64_NUM_COUNTERS_CORE);
> +		else
> +			ebx.split.num_core_pmc = max_t(unsigned int,
> +						       ebx.split.num_core_pmc,
> +						       AMD64_NUM_COUNTERS);

Again like the previous patch, I would expect this to be an if-elif-else sequence.

> +
> +		entry->ebx = ebx.full;
> +		break;
> +	}
>  	/*Add support for Centaur's CPUID instruction*/
>  	case 0xC0000000:
>  		/*Just support up to 0xC0000004 now*/
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 527f18d8cc44..127983ab8307 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4914,9 +4914,14 @@ static __init void svm_set_cpu_caps(void)
>  	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
>  		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD);
>  
> -	/* AMD PMU PERFCTR_CORE CPUID */
> -	if (enable_pmu && boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
> -		kvm_cpu_cap_set(X86_FEATURE_PERFCTR_CORE);

Another existing wart.  This existing code can be:

	if (enable_pmu)
		kvm_cpu_cap_check_and_set(X86_FEATURE_PERFCTR_CORE)

Can you add a patch to do that minor cleanup?  Then this patch can yield:

	if (enable_pmu) {
		kvm_cpu_cap_check_and_set(X86_FEATURE_PERFCTR_CORE);
		kvm_cpu_cap_check_and_set(X86_FEATURE_PERFMON_V2);
	}

KVM's reverse-CPUID magic should Just Work for PERFMON_V2 even though it's scattered.
		

> +	if (enable_pmu) {
> +		/* AMD PMU PERFCTR_CORE CPUID */
> +		if (boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
> +			kvm_cpu_cap_set(X86_FEATURE_PERFCTR_CORE);
> +		/* KVM only support AMD PerfMon V2 */
> +		if (kvm_pmu_cap.version > 1)
> +			kvm_cpu_cap_set(X86_FEATURE_AMD_PMU_V2);
> +	}
>  
>  	/* CPUID 0x8000001F (SME/SEV features) */
>  	sev_set_cpu_caps();
> -- 
> 2.38.1
> 

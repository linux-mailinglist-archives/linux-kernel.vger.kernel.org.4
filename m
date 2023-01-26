Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511DC67D82E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjAZWKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjAZWJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:09:59 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927921D934
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:09:57 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id v3so2051898pgh.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WdW90n+kwnV1pzuVps23T0zKS22ZoSCKUIqPec2DmVc=;
        b=PnnhMF+eGepK2yApIP6l8EhDHGyOpJprf7HVVROTWmLyRKR7cc0hJC6inxV4hWV3LP
         Avgjm36jC3IjvALxWy2gEQkEadPStHiqj9N4IIzbWhwVqhSFCetq77Gy2LPlb4V3vgLI
         ncNMXFWymmOAcZ9MxVHd5ooc+QCHsaAcz7vL0L30qqfNZsU5Tj9v/Xus5GbJhaFNjPXB
         gkyC0KXy8Z3FQ9c1TNI6Wd1cMpSro/hfuaiNidj3ZiqYHZm2WCJ2WumhnbNBNVu38r5G
         30zbsxHvE8cQpACs55OxhEfvAWpqvAbxzNu30+alXzg9v7kNDDnDEU214wJjiygy8jUd
         2e4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdW90n+kwnV1pzuVps23T0zKS22ZoSCKUIqPec2DmVc=;
        b=SD3VxavYwIbky17nd+ANewDGjGxJpnG3GWSttnd2qpulERQ2HMXxL1QcoCxLgKkMN3
         UV07qGqbNV4QzJRU9ZsjHx8jeQdh7kygWujJcwte/mBksJFSiZ425Q+WQVmQt1oMODQl
         fnXH7qBCgImb3/JlOQtOVnnNkoQNlM+V2eyjMVrrtluflOau/bVcya52Ihs7qe8HVnQL
         cbidB+rjBe4W58mghMTySxgpzreOiZhnETexINX3mIzxD/Za1nlKWd/k9jCk88ZoPRVf
         drj5m7bpIsJT9QGLq5Xc88w6laSf3JK/3IK8mbR72FYvcda35Hw/fDhbwGK2o43Foson
         jZMw==
X-Gm-Message-State: AO0yUKWWx47CMXE3Il630E2Pv3Y3c+6yFSaQ5+gQfsqr5zdVN+Yf0SEl
        Tken3QEhNT4wdpIF7VExcXWRIQ==
X-Google-Smtp-Source: AK7set9eAxMdrcPicjJy6qyqaoJdZls+8MVHGe2auLHA0QriQM2qRTYhRMoPI0u6quriYQf5HhzdPw==
X-Received: by 2002:a05:6a00:b55:b0:576:9252:d06 with SMTP id p21-20020a056a000b5500b0057692520d06mr1579645pfo.0.1674770996846;
        Thu, 26 Jan 2023 14:09:56 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id k9-20020aa78209000000b0058bcb7b437bsm1264467pfi.215.2023.01.26.14.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:09:56 -0800 (PST)
Date:   Thu, 26 Jan 2023 22:09:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/pmu: Drop event_type and rename "struct
 kvm_event_hw_type_mapping"
Message-ID: <Y9L6MLgaV2v4sUR2@google.com>
References: <20221205122048.16023-1-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205122048.16023-1-likexu@tencent.com>
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

On Mon, Dec 05, 2022, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> After commit ("02791a5c362b KVM: x86/pmu: Use PERF_TYPE_RAW
> to merge reprogram_{gp,fixed}counter()"), vPMU starts to directly
> use the hardware event eventsel and unit_mask to reprogram perf_event,
> and the event_type field in the "struct kvm_event_hw_type_mapping"
> is simply no longer being used.
> 
> After discarding this field, the name of the structure also lost
> its mapping semantics, renaming it "struct kvm_pmu_hw_event" and
> reorganizing the comments to continue to help newcomers.
> 
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  arch/x86/kvm/pmu.h           |  3 +--
>  arch/x86/kvm/vmx/pmu_intel.c | 34 +++++++++++++++++++++++++---------
>  2 files changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 85ff3c0588ba..2aef09eafb70 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -18,10 +18,9 @@
>  #define VMWARE_BACKDOOR_PMC_REAL_TIME		0x10001
>  #define VMWARE_BACKDOOR_PMC_APPARENT_TIME	0x10002
>  
> -struct kvm_event_hw_type_mapping {
> +struct kvm_pmu_hw_event {

The only user of the struct is the array, just make it anonymous struct and
constify the array.  No need to send a v2, I'll fixup when applying.

>  	u8 eventsel;
>  	u8 unit_mask;
> -	unsigned event_type;
>  };
>  
>  struct kvm_pmu_ops {
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 28b0a784f6e9..d34e9f85bdce 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -20,16 +20,32 @@
>  
>  #define MSR_PMC_FULL_WIDTH_BIT      (MSR_IA32_PMC0 - MSR_IA32_PERFCTR0)
>  
> -static struct kvm_event_hw_type_mapping intel_arch_events[] = {
> -	[0] = { 0x3c, 0x00, PERF_COUNT_HW_CPU_CYCLES },
> -	[1] = { 0xc0, 0x00, PERF_COUNT_HW_INSTRUCTIONS },
> -	[2] = { 0x3c, 0x01, PERF_COUNT_HW_BUS_CYCLES  },
> -	[3] = { 0x2e, 0x4f, PERF_COUNT_HW_CACHE_REFERENCES },
> -	[4] = { 0x2e, 0x41, PERF_COUNT_HW_CACHE_MISSES },
> -	[5] = { 0xc4, 0x00, PERF_COUNT_HW_BRANCH_INSTRUCTIONS },
> -	[6] = { 0xc5, 0x00, PERF_COUNT_HW_BRANCH_MISSES },
> +/*
> + * The first part of hw_events in the following array represent Intel's
> + * Pre-defined Architectural Performance Events in an ordered manner:
> + *
> + * 0 - PERF_COUNT_HW_CPU_CYCLES
> + * 1 - PERF_COUNT_HW_INSTRUCTIONS
> + * 2 - PERF_COUNT_HW_BUS_CYCLES
> + * 3 - PERF_COUNT_HW_CACHE_REFERENCES
> + * 4 - PERF_COUNT_HW_CACHE_MISSES
> + * 5 - PERF_COUNT_HW_BRANCH_INSTRUCTIONS
> + * 6 - PERF_COUNT_HW_BRANCH_MISSES
> + *
> + * the second part of hw_events is defined by the generic kernel perf:
> + *
> + * 7 - PERF_COUNT_HW_REF_CPU_CYCLES
> + */
> +static struct kvm_pmu_hw_event intel_arch_events[] = {
> +	[0] = { 0x3c, 0x00 },

*sigh*

This made me actually look at all the code, and it just about broke my WTF-o-meter.
The fragility of this code is mind-bogglingly unnecessary.  Instead of adding a
comment to document magic numbers, express that information in code.

E.g. there's zero excuses for us to have code like this

	static int fixed_pmc_events[] = {1, 0, 7};

and this

	/* disable event that reported as not present by cpuid */
	if ((i < 7) && !(pmu->available_event_types & (1 << i)))
		return false;

I'll post patches to clean this up so that we have the following, which is (a)
self-documenting and (b) won't break or require updating magic numbers when the
next architectural event comes along.


enum intel_pmu_architectural_events {
	/*
	 * The order of the architectural events matters as support for each
	 * event is enumerated via CPUID using the index of the event.
	 */
	INTEL_ARCH_CPU_CYCLES,
	INTEL_ARCH_INSTRUCTIONS_RETIRED,
	INTEL_ARCH_REFERENCE_CYCLES,
	INTEL_ARCH_LLC_REFERNCES,
	INTEL_ARCH_LLC_MISSES,
	INTEL_ARCH_BRANCHES_RETIRED,
	INTEL_ARCH_BRANCHES_MISPREDICTED,

	NR_INTEL_ARCH_EVENTS,

	/*
	 * Pseudo-architectural event used to implement IA32_FIXED_CTR2, a.k.a.
	 * TSC reference cycles.  The architectural reference cycles event may
	 * or may not actually use the TSC as the reference, e.g. might use the
	 * core crystal clock or the bus clock (yeah, "architectural").
	 */
	PSEUDO_ARCH_REFERENCE_CYCLES = NR_INTEL_ARCH_EVENTS,
};

static struct {
	u8 eventsel;
	u8 unit_mask;
} const intel_arch_events[] = {
	[INTEL_ARCH_CPU_CYCLES]			= { 0x3c, 0x00 },
	[INTEL_ARCH_INSTRUCTIONS_RETIRED]	= { 0xc0, 0x00 },
	[INTEL_ARCH_REFERENCE_CYCLES]		= { 0x3c, 0x01 },
	[INTEL_ARCH_LLC_REFERNCES] 		= { 0x2e, 0x4f },
	[INTEL_ARCH_LLC_MISSES]			= { 0x2e, 0x41 },
	[INTEL_ARCH_BRANCHES_RETIRED]		= { 0xc4, 0x00 },
	[INTEL_ARCH_BRANCHES_MISPREDICTED]	= { 0xc5, 0x00 },
	[PSEUDO_ARCH_REFERENCE_CYCLES]		= { 0x00, 0x03 },
};

/* mapping between fixed pmc index and intel_arch_events array */
static int fixed_pmc_events[] = {
	[0] = INTEL_ARCH_INSTRUCTIONS_RETIRED,
	[1] = INTEL_ARCH_CPU_CYCLES,
	[2] = PSEUDO_ARCH_REFERENCE_CYCLES,
};

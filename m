Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6632A675EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjATUef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjATUee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:34:34 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5628A70F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:34:32 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so10167978pjm.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bT0exfL2pOKi0xt4FhrfGLLtzWZfbcFblNTV0SEshzQ=;
        b=Tcd//d7YcoNuM520XTfHbxmyMMltffffOsTLtxZnRPwR7rBlqxPB00I3n+DQjZI/Js
         Hu9yE+B3Mt8YoP4A2VqG9RKIwGTaJLwnLk73q+OzOGJP6X/+AT/UUvDoQUY52PY3tS/l
         Rk9lvgUdgTGy2YeTR2Q1QnfliAYY9RiVQq0sDBCHSsAzTGJfhgIUpE9tkQaSg56FvE/d
         UqvQ0T29chqIoTYOYaLidmuIxl7gX2V0Gj/YrZpEE1tfc2QolpT/t4B0ekkFZWOcoM60
         98eb/RCSFuXel14+wJy6uVfxNrEWaMa8gnCbLbOcIKB+P0YFqk0ruM63jfkd52DsLgS7
         tnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bT0exfL2pOKi0xt4FhrfGLLtzWZfbcFblNTV0SEshzQ=;
        b=Y815RYbG1F63z/4/2P150udmpSlMMnQIquJ1Vkea890kdJ476pdWjQyKW/D0qXKJ5J
         GSelBgKiAoZ00KysYDdqOuXlG6EbccvJ4tWJOU/fMpoYXkSDkylCwtUi9AV4Pw4CFcZa
         ctRX0+Sip1AtkM9L1GCPIowyTgTPWoqQ+jrNU1nDWZOeMcRgGqtNG1YTEaOcAnqWW10c
         eunjEH4ZZ31MWj9JgnLi9WxuyJ7s9dxVS+a8QdzIVV5phHTXxl4Uo9jQtf15JH7NsyQq
         8TKEilGJC3xpMUfu2V8pQaHF1gsQe8F5eIcIWKS2wE0IrSP37sQppx6i/Jn2vryUD3rQ
         HQhg==
X-Gm-Message-State: AFqh2koQu9Ief9OErASun+7/1JsRm4aIrHourjIlp7g6NOVV7G58aFO+
        D4CSlgcwSsvy4bJTJwf+STaNyw==
X-Google-Smtp-Source: AMrXdXtKfB1gixAGDNIia7czeJuwlVVzApr+MveVmp4Xm7r05IuazKw5Td29cCugf/4St8vC68HMHQ==
X-Received: by 2002:a17:902:d64f:b0:189:b910:c6d2 with SMTP id y15-20020a170902d64f00b00189b910c6d2mr323843plh.1.1674246871699;
        Fri, 20 Jan 2023 12:34:31 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902a38100b0019254c19697sm16673497pla.289.2023.01.20.12.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 12:34:31 -0800 (PST)
Date:   Fri, 20 Jan 2023 20:34:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jianfeng Gao <jianfeng.gao@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf/x86: KVM: Disable vPMU support on hybrid CPUs (host
 PMUs)
Message-ID: <Y8r604tRexxWlF8F@google.com>
References: <20230120004051.2043777-1-seanjc@google.com>
 <1dec071d-c010-cd89-9e58-d643e71e775c@linux.intel.com>
 <Y8rQJf3ki8a1aRjW@google.com>
 <50e840ea-ce9c-9290-2187-d3ff0d9a6709@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50e840ea-ce9c-9290-2187-d3ff0d9a6709@linux.intel.com>
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

On Fri, Jan 20, 2023, Liang, Kan wrote:
> On 2023-01-20 12:32 p.m., Sean Christopherson wrote:
> > On Fri, Jan 20, 2023, Liang, Kan wrote:
> >> There is nothing wrong for the information provided by the kernel. I
> >> think it should be a KVM issue (my guess is the CPUID enumeration.) we
> >> should fix rather than simply disable the PMU for entire hybrid machines.
> > 
> > I'm not arguing this isn't KVM's problem, and I'm all for proper enabling in KVM,
> > but I'm not seeing any patches being posted.  In the meantime, we've got bug reports
> > coming in about KVM guests having PMU problems on hybrid hosts, and a pile of
> > evidence that strongly suggests this isn't going to be fixed by a one-line patch.
> > 
> > Again, I'm not against enabling vPMU on hybrid CPUs, but AFAICT the enabling is
> > non-trivial and may require new uAPI to provide the necessary information to
> > userspace.  As a short term fix, and something that can be backported to stable
> > trees, I don't see a better alternative than disabling vPMU support.
> 
> I just did some tests with the latest kernel on a RPL machine, and
> observed the below error in the guest.
> 
> [    0.118214] unchecked MSR access error: WRMSR to 0x38f (tried to
> write 0x00011000f0000003f) at rIP: 0xffffffff83082124
> (native_write_msr+0x4/0x30)
> [    0.118949] Call Trace:
> [    0.119092]  <TASK>
> [    0.119215]  ? __intel_pmu_enable_all.constprop.0+0x88/0xe0
> [    0.119533]  intel_pmu_enable_all+0x15/0x20
> [    0.119778]  x86_pmu_enable+0x17c/0x320
> 
> 
> The error is caused by the access to an unsupported bit (bit 48).
> The bit is to enable the Perf Metrics feature, which is a p-core only
> feature.
> 
> KVM doesn't support the feature, so the corresponding bit of
> PERF_CAPABILITIES MSR is not exposed to the guest. For a non-hybrid
> platform, guest checks the bit. Everything works well.
> 
> However, the current implementation in perf kernel for ADL and RPL
> doesn't check the bit. Because the bit is not reliable on ADL and RPL.
> Perf assumes that the p-core hardware always has the feature enabled.
> There is no problem for the bare metal, but seems bring troubles on KVM.
> 
> There is no such issue for the later platforms anymore, e.g., MTL, since
> we enhance the PMU features enumeration for the hybrid platforms.
> Please find the enhancement in Chapter 10 NEXT GENERATION PERFORMANCE
> MONITORING UNIT (PMU)
> https://cdrdv2-public.intel.com/671368/architecture-instruction-set-extensions-programming-reference.pdf
> 
> I think, for a short term fix, we should fix the issue in the perf
> kernel for ADL and RPL, rather than disable the entire vPMU on a hybrid
> platform.
> 
> How about the below patch?

No, fudging around this in the guest isn't a viable fix, even as a short term fix.
Linux isn't the only guest supported by KVM, the VMM isn't strictly required to
set HYPERVISOR in guest CPUID, and it doesn't fix the problems with trying to use
microarchitectural events.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index dfd2c124cdf8..d667e8b79286 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -6459,7 +6459,13 @@ __init int intel_pmu_init(void)
>  					__EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
>  							   0, pmu->num_counters, 0, 0);
>  		pmu->intel_cap.capabilities = x86_pmu.intel_cap.capabilities;
> -		pmu->intel_cap.perf_metrics = 1;
> +		/*
> +		 * The perf metrics bit is not reliable on ADL and RPL. For bare
> +		 * metal, it's safe to assume that the feature is always enabled
> +		 * on p-core, but we cannot do the same assumption for KVM.
> +		 */
> +		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +			pmu->intel_cap.perf_metrics = 1;
>  		pmu->intel_cap.pebs_output_pt_available = 0;
> 
>  		memcpy(pmu->hw_cache_event_ids, spr_hw_cache_event_ids,
> sizeof(pmu->hw_cache_event_ids));
> 
> 
> Thanks,
> Kan

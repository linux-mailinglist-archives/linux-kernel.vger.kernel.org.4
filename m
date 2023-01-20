Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D50675E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjATT5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjATT5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:57:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC80393704;
        Fri, 20 Jan 2023 11:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674244630; x=1705780630;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iC9Sku/1FS8bS0BEe/bVvaJpcv483oSNkneLcUSbwA8=;
  b=NdZHn/owOOY8y8tkwmNblDm2KmeTDNPkAXg8J3j76nvtsnQTIUX7sh1E
   ISdkrh48GstWv66LMGYyV/ILXpBax840af5LaSSTEfXezy6DkFwQMHcXw
   CGDP4sKFX3E5v+mx7Fl32ax/Jc7lqoyax+ca0SxJsahU11BauOMqMiTEI
   xeGK2p746Xguv1b+ukrRE67EnhnYPcviXXTG5Ju1hbaa4uCaC/9jk9syn
   WIh6Axe6gCCDoOyNOo0J05ceZ8M6WdnB9MAgGfus0Sz3s08Mlm9c1dIh5
   Ohao1gPVyaut+0FF5/dh7BTTgc8EhvrdYl2EHTl7c5Pauxou0zRFBI0jM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="309250650"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="309250650"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 11:55:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="638267527"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="638267527"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 20 Jan 2023 11:55:58 -0800
Received: from [10.212.214.233] (kliang2-mobl1.ccr.corp.intel.com [10.212.214.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id ABCB9580AA4;
        Fri, 20 Jan 2023 11:55:56 -0800 (PST)
Message-ID: <50e840ea-ce9c-9290-2187-d3ff0d9a6709@linux.intel.com>
Date:   Fri, 20 Jan 2023 14:55:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] perf/x86: KVM: Disable vPMU support on hybrid CPUs (host
 PMUs)
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
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
References: <20230120004051.2043777-1-seanjc@google.com>
 <1dec071d-c010-cd89-9e58-d643e71e775c@linux.intel.com>
 <Y8rQJf3ki8a1aRjW@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Y8rQJf3ki8a1aRjW@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-01-20 12:32 p.m., Sean Christopherson wrote:
> On Fri, Jan 20, 2023, Liang, Kan wrote:
>>
>> On 2023-01-19 7:40 p.m., Sean Christopherson wrote:
>>> Disable KVM support for virtualizing PMUs on hosts with hybrid PMUs until
>>> KVM gains a sane way to enumeration the hybrid vPMU to userspace and/or
>>> gains a mechanism to let userspace opt-in to the dangers of exposing a
>>> hybrid vPMU to KVM guests.
>>>
>>> Virtualizing a hybrid PMU, or at least part of a hybrid PMU, is possible,
>>> but it requires userspace to pin vCPUs to pCPUs to prevent migrating a
>>> vCPU between a big core and a little core, requires the VMM to accurately
>>> enumerate the topology to the guest (if exposing a hybrid CPU to the
>>> guest), and also requires the VMM to accurately enumerate the vPMU
>>> capabilities to the guest.
>>
>> Current kernel only return the common counters to KVM, which is
>> available on both e-core and p-core. In theory, there should be no
>> problem with the migration between cores. You don't have to pin vCPU.
>> The only problem is that you probably can only use the architecture events.
> 
> And how exactly is KVM supposed to tell the guest that it can only use
> architectural events?  I see CPUID bits that enumerate which architectural events
> are supported, but I'm not seeing anything that says _only_ architectural events
> are supported.

I think we have to use a white list in KVM. For the unsupported event,
KVM will not create the event.

> 
>> There is nothing wrong for the information provided by the kernel. I
>> think it should be a KVM issue (my guess is the CPUID enumeration.) we
>> should fix rather than simply disable the PMU for entire hybrid machines.
> 
> I'm not arguing this isn't KVM's problem, and I'm all for proper enabling in KVM,
> but I'm not seeing any patches being posted.  In the meantime, we've got bug reports
> coming in about KVM guests having PMU problems on hybrid hosts, and a pile of
> evidence that strongly suggests this isn't going to be fixed by a one-line patch.
> 
> Again, I'm not against enabling vPMU on hybrid CPUs, but AFAICT the enabling is
> non-trivial and may require new uAPI to provide the necessary information to
> userspace.  As a short term fix, and something that can be backported to stable
> trees, I don't see a better alternative than disabling vPMU support.

I just did some tests with the latest kernel on a RPL machine, and
observed the below error in the guest.

[    0.118214] unchecked MSR access error: WRMSR to 0x38f (tried to
write 0x00011000f0000003f) at rIP: 0xffffffff83082124
(native_write_msr+0x4/0x30)
[    0.118949] Call Trace:
[    0.119092]  <TASK>
[    0.119215]  ? __intel_pmu_enable_all.constprop.0+0x88/0xe0
[    0.119533]  intel_pmu_enable_all+0x15/0x20
[    0.119778]  x86_pmu_enable+0x17c/0x320


The error is caused by the access to an unsupported bit (bit 48).
The bit is to enable the Perf Metrics feature, which is a p-core only
feature.

KVM doesn't support the feature, so the corresponding bit of
PERF_CAPABILITIES MSR is not exposed to the guest. For a non-hybrid
platform, guest checks the bit. Everything works well.

However, the current implementation in perf kernel for ADL and RPL
doesn't check the bit. Because the bit is not reliable on ADL and RPL.
Perf assumes that the p-core hardware always has the feature enabled.
There is no problem for the bare metal, but seems bring troubles on KVM.

There is no such issue for the later platforms anymore, e.g., MTL, since
we enhance the PMU features enumeration for the hybrid platforms.
Please find the enhancement in Chapter 10 NEXT GENERATION PERFORMANCE
MONITORING UNIT (PMU)
https://cdrdv2-public.intel.com/671368/architecture-instruction-set-extensions-programming-reference.pdf

I think, for a short term fix, we should fix the issue in the perf
kernel for ADL and RPL, rather than disable the entire vPMU on a hybrid
platform.

How about the below patch?


diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index dfd2c124cdf8..d667e8b79286 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6459,7 +6459,13 @@ __init int intel_pmu_init(void)
 					__EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
 							   0, pmu->num_counters, 0, 0);
 		pmu->intel_cap.capabilities = x86_pmu.intel_cap.capabilities;
-		pmu->intel_cap.perf_metrics = 1;
+		/*
+		 * The perf metrics bit is not reliable on ADL and RPL. For bare
+		 * metal, it's safe to assume that the feature is always enabled
+		 * on p-core, but we cannot do the same assumption for KVM.
+		 */
+		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
+			pmu->intel_cap.perf_metrics = 1;
 		pmu->intel_cap.pebs_output_pt_available = 0;

 		memcpy(pmu->hw_cache_event_ids, spr_hw_cache_event_ids,
sizeof(pmu->hw_cache_event_ids));


Thanks,
Kan

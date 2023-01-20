Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B33675795
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjATOlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjATOlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:41:19 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD7080B97;
        Fri, 20 Jan 2023 06:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674225657; x=1705761657;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iqBg1CPWUOIeSmCo4LHZfXmDvaRq/z8yWiScjetjGsM=;
  b=K7XANq3bNl3bZQ9BmETJV5LJQGb6QEI2j9i1NMUl1nrPqQQpSGcD5Vs9
   fP34OF0pYDP4bsz4bq16GvlpG2pCaivcU5XwrW3/XMHr5267FaHiUfEWb
   INreD+ZHNb4vtrJoDIXvQqvTgYT0g+BxVY5DhgLE/lPUR3GYMEHs3gMOY
   TKjx6JEazNm+n51FrPNlppkya3SQKWcXCarrLUu2YB2dMCrLzgPcUsqn3
   7CoK//GcHtpQd7FcvYZ2nFwdkK6It4WlNwFAXnpF2rIOSFMoQ5y5f6/br
   3ONmy4DXiEHZ1xwtl84iXGyXA3tSnkqoIPu+sYim1vLnjpRLaLWpnqdQ8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305957424"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="305957424"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 06:39:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="660597117"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="660597117"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 20 Jan 2023 06:39:45 -0800
Received: from [10.212.214.233] (kliang2-mobl1.ccr.corp.intel.com [10.212.214.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 248F0580BB9;
        Fri, 20 Jan 2023 06:39:43 -0800 (PST)
Message-ID: <1dec071d-c010-cd89-9e58-d643e71e775c@linux.intel.com>
Date:   Fri, 20 Jan 2023 09:39:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] perf/x86: KVM: Disable vPMU support on hybrid CPUs (host
 PMUs)
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jianfeng Gao <jianfeng.gao@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20230120004051.2043777-1-seanjc@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230120004051.2043777-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-01-19 7:40 p.m., Sean Christopherson wrote:
> Disable KVM support for virtualizing PMUs on hosts with hybrid PMUs until
> KVM gains a sane way to enumeration the hybrid vPMU to userspace and/or
> gains a mechanism to let userspace opt-in to the dangers of exposing a
> hybrid vPMU to KVM guests.
> 
> Virtualizing a hybrid PMU, or at least part of a hybrid PMU, is possible,
> but it requires userspace to pin vCPUs to pCPUs to prevent migrating a
> vCPU between a big core and a little core, requires the VMM to accurately
> enumerate the topology to the guest (if exposing a hybrid CPU to the
> guest), and also requires the VMM to accurately enumerate the vPMU
> capabilities to the guest.

Current kernel only return the common counters to KVM, which is
available on both e-core and p-core. In theory, there should be no
problem with the migration between cores. You don't have to pin vCPU.
The only problem is that you probably can only use the architecture events.

There is nothing wrong for the information provided by the kernel. I
think it should be a KVM issue (my guess is the CPUID enumeration.) we
should fix rather than simply disable the PMU for entire hybrid machines.

Thanks,
Kan
> 
> The last point is especially problematic, as KVM doesn't control which
> pCPU it runs on when enumerating KVM's vPMU capabilities to userspace.
> For now, simply disable vPMU support on hybrid CPUs to avoid inducing
> seemingly random #GPs in guests.
> 
> Reported-by: Jianfeng Gao <jianfeng.gao@intel.com>
> Cc: stable@vger.kernel.org
> Cc: Andrew Cooper <Andrew.Cooper3@citrix.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Link: https://lore.kernel.org/all/20220818181530.2355034-1-kan.liang@linux.intel.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> Lightly tested as I don't have hybrid hardware.  For the record, I'm not
> against supporting hybrid vPMUs in KVM, but it needs to be a dedicated
> effort and not implicitly rely on userspace to do the right thing (or get
> lucky).
> 
>  arch/x86/events/core.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 85a63a41c471..a67667c41cc8 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2974,17 +2974,18 @@ unsigned long perf_misc_flags(struct pt_regs *regs)
>  
>  void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
>  {
> -	if (!x86_pmu_initialized()) {
> +	/*
> +	 * Hybrid PMUs don't play nice with virtualization unless userspace
> +	 * pins vCPUs _and_ can enumerate accurate information to the guest.
> +	 * Disable vPMU support for hybrid PMUs until KVM gains a way to let
> +	 * userspace opt into the dangers of hybrid vPMUs.
> +	 */
> +	if (!x86_pmu_initialized() || is_hybrid()) {
>  		memset(cap, 0, sizeof(*cap));
>  		return;
>  	}
>  
>  	cap->version		= x86_pmu.version;
> -	/*
> -	 * KVM doesn't support the hybrid PMU yet.
> -	 * Return the common value in global x86_pmu,
> -	 * which available for all cores.
> -	 */
>  	cap->num_counters_gp	= x86_pmu.num_counters;
>  	cap->num_counters_fixed	= x86_pmu.num_counters_fixed;
>  	cap->bit_width_gp	= x86_pmu.cntval_bits;
> 
> base-commit: de60733246ff4545a0483140c1f21426b8d7cb7f

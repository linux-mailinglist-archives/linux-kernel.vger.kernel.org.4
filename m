Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C486C6D16D4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 07:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjCaFez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 01:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCaFex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 01:34:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A4D83C8;
        Thu, 30 Mar 2023 22:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680240891; x=1711776891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dFJBTEI0i8alvBIKkAgPGcwUbxekbkcw2MQoL9eKAOk=;
  b=N3apkt2cChnko4CQGHD/Xj69cXSh+Zaz2/PeNZP/Sky6T4zpWIf95iL7
   BhQHcoTwk3E4Q3M/fLLrBRWrfv2pOHHoIT9mSxojsnxDUoRcuVFpU2mcq
   NWXmQg7ryorx9X2PTOIL5wC1hyJDYyK/3bewd2ErL8DfJMjfKH1FE3gXl
   Cn3dvL/+2NuybmIhbgwsbtpSiIgIiTikDwZHXvm7mV4sefU/4Fj3FnW1q
   NV4ez/xctQ1HyjFzWjYULa2TcBnMN7T+l3L1rFMvlndc5rqCnyJuTxStK
   GrpDFitXhN5TAv+hwKwfMTOO18XAI8FEjnaba2W2hgLDbOvjeYWmDZeku
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="406372370"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="406372370"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 22:34:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="635168694"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="635168694"
Received: from dmi-pnp-i7.sh.intel.com (HELO localhost) ([10.239.159.155])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2023 22:34:47 -0700
Date:   Fri, 31 Mar 2023 13:40:11 +0800
From:   Dapeng Mi <dapeng1.mi@linux.intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhang Tinghao <tinghao.zhang@intel.com>,
        Zhuocheng Ding <zhuocheng.ding@intel.com>
Subject: Re: [PATCH] perf/x86/intel: Define bit macros for FixCntrCtl MSR
Message-ID: <ZCZyOyvfNgKsYVLy@dmi-pnp-i7>
References: <20230330012846.2927220-1-dapeng1.mi@linux.intel.com>
 <20230330130702.GF124812@hirez.programming.kicks-ass.net>
 <2bba1909-dac8-321f-e685-a793f1a4e170@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bba1909-dac8-321f-e685-a793f1a4e170@linux.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 10:46:01AM -0400, Liang, Kan wrote:
> Date: Thu, 30 Mar 2023 10:46:01 -0400
> From: "Liang, Kan" <kan.liang@linux.intel.com>
> Subject: Re: [PATCH] perf/x86/intel: Define bit macros for FixCntrCtl MSR
> 
> 
> 
> On 2023-03-30 9:07 a.m., Peter Zijlstra wrote:
> > On Thu, Mar 30, 2023 at 09:28:46AM +0800, Dapeng Mi wrote:
> >> Define bit macros for FixCntrCtl MSR and replace the bit hardcoding
> >> with these bit macros. This would make code be more human-readable.
> >>
> >> Perf commands 'perf stat -e "instructions,cycles,ref-cycles"' and
> >> 'perf record -e "instructions,cycles,ref-cycles"' pass.
> >>
> >> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> ---
> >>  arch/x86/events/intel/core.c      | 18 +++++++++---------
> >>  arch/x86/include/asm/perf_event.h | 10 ++++++++++
> >>  2 files changed, 19 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> >> index 070cc4ef2672..b7c0bb78ed59 100644
> >> --- a/arch/x86/events/intel/core.c
> >> +++ b/arch/x86/events/intel/core.c
> >> @@ -2451,7 +2451,7 @@ static void intel_pmu_disable_fixed(struct perf_event *event)
> >>  
> >>  	intel_clear_masks(event, idx);
> >>  
> >> -	mask = 0xfULL << ((idx - INTEL_PMC_IDX_FIXED) * 4);
> >> +	mask = intel_fixed_bits(idx - INTEL_PMC_IDX_FIXED, INTEL_FIXED_BITS_MASK);
> >>  	cpuc->fixed_ctrl_val &= ~mask;
> > 
> > So maybe it's me, but I find the original far easier to read :/ That new
> > things I need to look up every single identifier before I can tell wth
> > it does.
> 
> The intel_fixed_bits() tries to replace the duplicate "bit << (idx *
> 4);". I think it should be a good improvement. Maybe we should rename it
> to intel_shift_fixed_bits_by_idx(). Is it better?
> 
> If not, I think at least we should use some macros to replace the magic
> number.
> 
> Thanks,
> Kan

Comparing previous magic numbers, the following macros can help developers
to know the meaning of the piece of code rapidly and don't need to
check the hardware specs and get its meaning, and developers could more
easily confirm his code logic is correct and don't confirm with spec
again.

+#define INTEL_FIXED_0_KERNEL				(1ULL << 0)
+#define INTEL_FIXED_0_USER				(1ULL << 1)
+#define INTEL_FIXED_0_ANYTHREAD			(1ULL << 2)
+#define INTEL_FIXED_0_ENABLE_PMI			(1ULL << 3)

As for the macro intel_fixed_bits, it indeed hides some details, but it
make the code looks cleaner and developer can use it more easily and don't
worry about the details. Like what Kan said, maybe we can get a new name to
make it be more understandably. 
-- 
Thanks,
Dapeng Mi

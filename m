Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2386C9F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjC0JML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjC0JMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:12:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FD8CA;
        Mon, 27 Mar 2023 02:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679908325; x=1711444325;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zwYVDyBScBvmHn6CqlqF0q715WS9mRUwOHAV6jvv1tU=;
  b=eWzasY2q5wXr/GLXINR8kskI0FE6ujbf60JPPNRevQwqvMddVh+vMKS1
   G24fWP4sPD9psAAzNwK0ultlms7FRYwc/r/5uI5L3Hz7hKDr6qPOs7oYT
   IbOUs0Evnbm0cgox+6lNH+HKuCqsuCgC5unaJ2lygip02ESSm1+QW5iAZ
   dVrYsNNDRi0kwS9Y1xil2eECfjGqt/UhSDAX5hB5zTrUvaG4WqxKJdFmT
   HPYeYSzvEmdY8JOS8koOTLcaWaYQrcYyC3WHunlQqvCXZ6MANfNz8KtKo
   e/m7SAmnj7U9I2Q7f9QD91uMAWkK5X6e96bq1DEe8oZnkVDI0XnXND07l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="324102834"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="324102834"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 02:12:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="857594201"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="857594201"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.63.101])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 02:11:59 -0700
Message-ID: <d691d740-c172-a5cb-e4f0-5bc5687c8464@intel.com>
Date:   Mon, 27 Mar 2023 12:11:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH resent] perf/x86/amd/uncore: Fix exception handling in
 amd_uncore_cpu_up_prepare()
To:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>, x86@kernel.org
Cc:     cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <ab860edf-79ca-2035-c5a3-d25be6fd9dac@web.de>
 <3a35fb28-5937-72f8-b2e8-b1d9899b5e43@web.de>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <3a35fb28-5937-72f8-b2e8-b1d9899b5e43@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/23 16:15, Markus Elfring wrote:
> Date: Fri, 17 Mar 2023 13:13:14 +0100
> 
> The label “fail” was used to jump to another pointer check despite of
> the detail in the implementation of the function “amd_uncore_cpu_up_prepare”
> that it was determined already that the corresponding variable contained
> a null pointer (because of a failed function call in two cases).
> 
> 1. Thus return directly after a call of the function “amd_uncore_alloc”
>    failed in the first if branch.
> 
> 2. Use more appropriate labels instead.
> 
> 3. Reorder jump targets at the end.
> 
> 4. Delete a redundant check and kfree() call.
> 
> 5. Omit an explicit initialisation for the local variable “uncore_llc”.
> 
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 39621c5808f5dda75d03dc4b2d4d2b13a5a1c34b ("perf/x86/amd/uncore: Use dynamic events array")
> Fixes: 503d3291a937b726757c1f7c45fa02389d2f4324 ("perf/x86/amd: Try to fix some mem allocation failure handling")

Commit should be only the first 12 characters of the hash.
Refer:	https://docs.kernel.org/process/submitting-patches.html

But this is not a fix. Redundant calls to kfree do not break
anything.

Also avoid using the term "exception" since, in x86, exceptions are
hardware events.  Better to just call it "error handling".

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/x86/events/amd/uncore.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index 83f15fe411b3..0a9b5cb97bb4 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -440,13 +440,13 @@ amd_uncore_events_alloc(unsigned int num, unsigned int cpu)
> 
>  static int amd_uncore_cpu_up_prepare(unsigned int cpu)
>  {
> -	struct amd_uncore *uncore_nb = NULL, *uncore_llc = NULL;
> +	struct amd_uncore *uncore_nb = NULL, *uncore_llc;
> 
>  	if (amd_uncore_nb) {
>  		*per_cpu_ptr(amd_uncore_nb, cpu) = NULL;
>  		uncore_nb = amd_uncore_alloc(cpu);
>  		if (!uncore_nb)
> -			goto fail;
> +			return -ENOMEM;
>  		uncore_nb->cpu = cpu;
>  		uncore_nb->num_counters = num_counters_nb;
>  		uncore_nb->rdpmc_base = RDPMC_BASE_NB;
> @@ -455,7 +455,7 @@ static int amd_uncore_cpu_up_prepare(unsigned int cpu)
>  		uncore_nb->pmu = &amd_nb_pmu;
>  		uncore_nb->events = amd_uncore_events_alloc(num_counters_nb, cpu);
>  		if (!uncore_nb->events)
> -			goto fail;
> +			goto free_nb;
>  		uncore_nb->id = -1;
>  		*per_cpu_ptr(amd_uncore_nb, cpu) = uncore_nb;
>  	}
> @@ -464,7 +464,7 @@ static int amd_uncore_cpu_up_prepare(unsigned int cpu)
>  		*per_cpu_ptr(amd_uncore_llc, cpu) = NULL;
>  		uncore_llc = amd_uncore_alloc(cpu);
>  		if (!uncore_llc)
> -			goto fail;
> +			goto check_uncore_nb;
>  		uncore_llc->cpu = cpu;
>  		uncore_llc->num_counters = num_counters_llc;
>  		uncore_llc->rdpmc_base = RDPMC_BASE_LLC;
> @@ -473,24 +473,22 @@ static int amd_uncore_cpu_up_prepare(unsigned int cpu)
>  		uncore_llc->pmu = &amd_llc_pmu;
>  		uncore_llc->events = amd_uncore_events_alloc(num_counters_llc, cpu);
>  		if (!uncore_llc->events)
> -			goto fail;
> +			goto free_llc;
>  		uncore_llc->id = -1;
>  		*per_cpu_ptr(amd_uncore_llc, cpu) = uncore_llc;
>  	}
> 
>  	return 0;
> 
> -fail:
> +free_llc:
> +	kfree(uncore_llc);
> +check_uncore_nb:
>  	if (uncore_nb) {
>  		kfree(uncore_nb->events);
> +free_nb:
>  		kfree(uncore_nb);
>  	}
> 
> -	if (uncore_llc) {
> -		kfree(uncore_llc->events);
> -		kfree(uncore_llc);
> -	}
> -
>  	return -ENOMEM;
>  }
> 
> --
> 2.40.0
> 


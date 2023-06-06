Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4736724D8A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjFFTye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbjFFTyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:54:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618AD10F0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686081260; x=1717617260;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IpgW2kKx9v9WenipgVcw+7ushaFee/ShsBpYaNYBoBI=;
  b=gbuDVQfQ3ccBr0CPaELWWemX8lpmoePPxV5ue8ZV9vOGfyaSTLuDBrdz
   M00ImtrRKypxY3rKVHV2whCkYeGMhbhnQWHez+eRcQRRCJ2qGWn30D0ZG
   m43B4CESVER4SJzJs5mF023uC6WlS9Lorz9w/GauW5GjnAIIsVoaKuebW
   /eNwpSE4thVJ9R3U7PaqoPthTclAyhsmeoitLdE+9dClSq7GmZ7OsNocd
   34+GKWx0odvs3ISEXBjjYAoqmiDAfSVPBx9GfBz73vMETzCZMG8lUCiiT
   PWS3p7+gmAPP1v8lbRleZZC0TQEwu/pVV8KbfpigST6zzEyk5M4ehYOJb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="341435282"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="341435282"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 12:54:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="853563714"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="853563714"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jun 2023 12:54:19 -0700
Received: from [10.212.191.33] (kliang2-mobl1.ccr.corp.intel.com [10.212.191.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7009C580377;
        Tue,  6 Jun 2023 12:54:17 -0700 (PDT)
Message-ID: <8088ef88-d440-fd7b-16c8-92690a656264@linux.intel.com>
Date:   Tue, 6 Jun 2023 15:54:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2 1/6] perf/x86/intel: Add Grand Ridge and Sierra Forest
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
 <2b2e7308-edeb-2977-596a-f638d19174d6@linux.intel.com>
 <20230606132432.GD905437@hirez.programming.kicks-ass.net>
 <3c187521-0686-1204-7b3e-e8f183c50938@linux.intel.com>
 <20230606181757.GB942082@hirez.programming.kicks-ass.net>
 <ea1c56f9-fc93-ff1e-2102-757e7e9c0dd7@linux.intel.com>
 <20230606193712.GY83892@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230606193712.GY83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-06-06 3:37 p.m., Peter Zijlstra wrote:
> On Tue, Jun 06, 2023 at 02:34:47PM -0400, Liang, Kan wrote:
>>
>>
>> On 2023-06-06 2:17 p.m., Peter Zijlstra wrote:
>>> On Tue, Jun 06, 2023 at 12:16:29PM -0400, Liang, Kan wrote:
>>>
>>>>> names for a reason, so that enums like the above become something
>>>>> sensible like:
>>>>>
>>>>> 	case INTEL_FAM6_ATOM_CRESTMONT:
>>>>> 	case INTEL_FAM6_ATOM_CRESTMONT_X:
>>>>>
>>>>> and now it's super obvious why they're grouped.
>>>>>
>>>>>>> +		pr_cont("Crestmont events, ");
>>>>
>>>> The Sierra Forest should not be a platform name. I think it's the code
>>>> name of the processor.
>>>>
>>>> The problem is that the uarch name doesn't work for the hybrid, since it
>>>> has different uarchs in the same processors. To make the naming rules
>>>> consistent among big core, atom, and hybrid, maybe we should use the
>>>> code name of the processor in intel-family.h.
>>>
>>> I obviously disagree; these are not hybrid and calling them both
>>> CRESTMONT makes *far* more sense than the random gibberish they're
>>> called now.
>>>
>>> Yes, hybrid made a complete mess of things (in many ways), but we should
>>> then not do the obvious correct thing for when we can.
>>
>> Besides hybrid, it seems there is a bigger problem for the big core.
>>
>> The big core uses the processor code name since Ice Lake. In the perf
>> code, we also uses the processor code name for the big core.
>> 	pr_cont("Icelake events, ");
> 
> Yeah, it's a mess :/ Ideally that would print "Sunny Cove", but I think
> there's userspace looking at that string :-(

Yes, for the existing names, we probably cannot change it. I will try to
only use the micro-architecture name for the future platforms in perf.

> 
>> Is it OK to leave the big core as is (using processor code name), but
>> only change the name for Grand Ridge and Sierra Forest?
> 
> Arguably we should also rename ALDERLAKE_N to ATOM_GRACEMONT
> 
> 
> We should also do something about that whole hybrid init thing, the
> meteorlake stuff is quite a mess as well. Perhaps we can add hybrid_pmu
> next to intel_pmu to have a better start in life for x86_pmu.
>

I will think about it and try to clean up the hybrid init.

> Anyway, we should really try not to make a bigger mess and try and clean
> up where we can.

Sure.

Thanks,
Kan

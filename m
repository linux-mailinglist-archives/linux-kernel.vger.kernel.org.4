Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0E07248D5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjFFQTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjFFQTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:19:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3EB10F7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 09:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686068355; x=1717604355;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U4b+1goI0to0eyH7X0X8IORTd4oXQSsOoP6CweXb0G4=;
  b=Kt1G1a0yaOmVxQ4jnxOsGcl6JNNvp31kq28PMVAl56hQcDVEH7htRVE7
   czhBuFZkVcDf1Op965awzdyx1fNPpES1g5m4y/sQuUgX/K0pvf6MoMKPd
   WgJ7e0YaiRVgchiHuaENDMcBJY6xMtJ/z9bJHcbKuXlHuN9gs7XcZ6Fqt
   NIYOubdz4fWS6LoVHSnHfOQOBUDsgcd5Y8hTXyZ7LLW8LvVS+aVCfPojO
   HjrQDXIDcnTN6uQqjTxubcV58TEMBAxvSvZwd7/xuo7pmaGRvggY5Bnoo
   Ie4pLqL/QaoZ6dfM3lelyB4VjxYzEYpkwVuQOqAQsjGbM9JQ8wK3nJjM+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="354221490"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="354221490"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 09:16:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="703221733"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="703221733"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 06 Jun 2023 09:16:32 -0700
Received: from [10.212.191.33] (kliang2-mobl1.ccr.corp.intel.com [10.212.191.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C2417580377;
        Tue,  6 Jun 2023 09:16:30 -0700 (PDT)
Message-ID: <3c187521-0686-1204-7b3e-e8f183c50938@linux.intel.com>
Date:   Tue, 6 Jun 2023 12:16:29 -0400
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
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230606132432.GD905437@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-06-06 9:24 a.m., Peter Zijlstra wrote:
> On Tue, Jun 06, 2023 at 08:42:42AM -0400, Liang, Kan wrote:
>> Hi Peter,
>>
>> On 2023-05-22 7:30 a.m., kan.liang@linux.intel.com wrote:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> The Grand Ridge and Sierra Forest are successors to Snow Ridge. They
>>> both have Crestmont core. From the core PMU's perspective, they are
>>> similar to the e-core of MTL. The only difference is the LBR event
>>> logging feature, which will be implemented in the following patches.
>>>
>>> Create a non-hybrid PMU setup for Grand Ridge and Sierra Forest.
>>>
>>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>> ---
>>>
>>
>>
>> Gentle ping.
>>
>> Do you have any comments for the patch set?
>>
>> The patch set based on the perf/core branch which doesn't
>> include the latest fix, 90befef5a9e8 ("perf/x86: Fix missing sample size
>> update on AMD BRS").
>> https://lore.kernel.org/lkml/2f09023a-cccb-35df-da0a-d245ee5238be@linux.intel.com/
>>
>> Should I rebase it on the perf/urgent and send the V3?
>>
> 
> I can pull urgent into perf/core, but:

Thanks.

> 
>>> +	case INTEL_FAM6_GRANDRIDGE:
>>> +	case INTEL_FAM6_SIERRAFOREST_X:
>                         ^^^^^^^^^^^^^^^
> 
> Those are just plain wrong; please fix up the intel-family.h thing like
> suggested earlier in this thread.
>> And Tony, please no more of that platform name nonsense.. we want uarch
> names for a reason, so that enums like the above become something
> sensible like:
> 
> 	case INTEL_FAM6_ATOM_CRESTMONT:
> 	case INTEL_FAM6_ATOM_CRESTMONT_X:
> 
> and now it's super obvious why they're grouped.
> 
>>> +		pr_cont("Crestmont events, ");

The Sierra Forest should not be a platform name. I think it's the code
name of the processor.

The problem is that the uarch name doesn't work for the hybrid, since it
has different uarchs in the same processors. To make the naming rules
consistent among big core, atom, and hybrid, maybe we should use the
code name of the processor in intel-family.h.

I will propose a patch to update the rules of using the processor name.
I think we may want to have further discussion there.

Thanks,
Kan

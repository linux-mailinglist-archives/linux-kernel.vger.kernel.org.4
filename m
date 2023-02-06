Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65BA68C020
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjBFOcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBFOcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:32:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A8230C4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675693923; x=1707229923;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qr9vx3IpAUwBWr+VsACiwydJAMaoFxp7yRhq4gFHICk=;
  b=Zd8lKSCM2fa/P9TV1siSpJoWClufn/WQzSehHymoGiZpJIunQhbjiKcl
   lXhLZwvGB8vIQJDdYw9Im1TvaOdjrsqQZEnyS6Pc+efkcCd+MnGGac0aR
   OhtMJLRxCm2r2ksx4RECg71iYI4ejTgaw7Wch2l1NMNE87voLQrCuQpML
   TOYn6g88F4B6J7Kf3w/5vD//kp/0RSfMP55uTrE9OTscQJcUeOo+W2/ZX
   19qnWnh20vJ786CingmNMFk3og2jn7SCi3nRB7vxnRjjpYQJKhA9F/wpf
   e2h0T1b4NaZPsay98NV1AmoVfoFvGD8gOO6LIDZ4vbcRWElM7cGURp6qe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="415435251"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="415435251"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 06:32:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="840367659"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="840367659"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 06 Feb 2023 06:32:02 -0800
Received: from [10.212.205.76] (kliang2-mobl1.ccr.corp.intel.com [10.212.205.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D96C7580C75;
        Mon,  6 Feb 2023 06:32:01 -0800 (PST)
Message-ID: <47f5639d-a64e-9c85-a62b-40160d02d3ff@linux.intel.com>
Date:   Mon, 6 Feb 2023 09:32:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V2 7/9] perf/x86/msr: Add Meteor Lake support
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        eranian@google.com, irogers@google.com
References: <20230104201349.1451191-1-kan.liang@linux.intel.com>
 <20230104201349.1451191-7-kan.liang@linux.intel.com>
 <Y9sWImm4v5I/MZId@kernel.org>
 <79807730-73ac-c8c2-fc9d-b7cd00f9336e@linux.intel.com>
 <Y91su757r43jgdle@kernel.org> <Y91uWj6PiGQqI48J@kernel.org>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Y91uWj6PiGQqI48J@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-02-03 3:28 p.m., Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 03, 2023 at 05:21:15PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Thu, Feb 02, 2023 at 09:34:02AM -0500, Liang, Kan escreveu:
>>> Hi Arnaldo,
>>>
>>> On 2023-02-01 8:47 p.m., Arnaldo Carvalho de Melo wrote:
>>>> Em Wed, Jan 04, 2023 at 12:13:47PM -0800, kan.liang@linux.intel.com escreveu:
>>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>>
>>>>> Meteor Lake is Intel's successor to Raptor lake. PPERF and SMI_COUNT MSRs
>>>>> are also supported.
>>>>>
>>>>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>>>> ---
>>>>
>>>> Did the kernel bits land upstream?
>>> Yes, the kernel part has been merged into the tip.git perf/core branch.
>>>
>>> Thanks for checking the status. There are two perf tool patches in this
>>> series, which hasn't been merged. Should I resend them?
>>
>> Lemme try cherry-picking just the tooling bits from this series.
>

Sorry, I forgot to mention it in this thread.
I sent V3 with only perf tool patches.

https://lore.kernel.org/lkml/20230202192209.1795329-1-kan.liang@linux.intel.com/


> There was a clash with:
> 
> commit 3fd7a168bf51497909dbfb7347af28b5c57e74a6
> Author: Namhyung Kim <namhyung@kernel.org>
> Date:   Thu Jan 26 13:36:10 2023 -0800
> 
>     perf script: Add 'cgroup' field for output
> 
> And a minor fuzz on the first patch, I applied manually and resolved the
> conflict,

The V3 add a perf test case for the new field. Could you please apply it
as well?

Sorry for the inconvenience.

Thanks,
Kan
> 
> Thanks,
> 
> - Arnaldo
>   
>>> Thanks,
>>> Kan
>>>>
>>>> - Arnaldo
>>>>  
>>>>> No change since V1
>>>>>
>>>>>  arch/x86/events/msr.c | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
>>>>> index ecced3a52668..074150d28fa8 100644
>>>>> --- a/arch/x86/events/msr.c
>>>>> +++ b/arch/x86/events/msr.c
>>>>> @@ -107,6 +107,8 @@ static bool test_intel(int idx, void *data)
>>>>>  	case INTEL_FAM6_RAPTORLAKE:
>>>>>  	case INTEL_FAM6_RAPTORLAKE_P:
>>>>>  	case INTEL_FAM6_RAPTORLAKE_S:
>>>>> +	case INTEL_FAM6_METEORLAKE:
>>>>> +	case INTEL_FAM6_METEORLAKE_L:
>>>>>  		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
>>>>>  			return true;
>>>>>  		break;
>>>>> -- 
>>>>> 2.35.1
>>>>
>>
>> -- 
>>
>> - Arnaldo
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3DB6D0897
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjC3OqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjC3OqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:46:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F2F7D91;
        Thu, 30 Mar 2023 07:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680187569; x=1711723569;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5mKDr2z6KLzoFeta8l6hBRMMWoy+ScTEsc0zNTJUEpQ=;
  b=fCVOoNfHfef/prgqhEyCMj3kb9zTsTOWdgIKsqcquLV15MLY3maPSUUm
   TUvEvDnRnoZF8xCnt7fJNYdnfOh1yH1gEhjEX0jUsUHUP233T1Cz9FemR
   TSboCd1IN0qrf4e2L6vI13Szbgp4q/dAgJ5V+Pfv5/YGpatCMJywOcYwe
   CMb6Yg1sFlaNzIrgRx/DkAUm0dlEqAN4eBQ0yUqPnsVvGdcEsu2btSTSk
   c11jzZw1aEWbKRwjrLWFgYp5MLvA3TNv31smbo/oG64xnJrTisnrafFC5
   cKie0GtsKMMS1u434UbQoVlFDBmb0RpkB77UAak8RYMFbYj8OzOrC72s5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="320837250"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="320837250"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 07:46:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="687254198"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="687254198"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 30 Mar 2023 07:46:05 -0700
Received: from [10.212.220.88] (kliang2-mobl1.ccr.corp.intel.com [10.212.220.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 3F76C580919;
        Thu, 30 Mar 2023 07:46:03 -0700 (PDT)
Message-ID: <2bba1909-dac8-321f-e685-a793f1a4e170@linux.intel.com>
Date:   Thu, 30 Mar 2023 10:46:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] perf/x86/intel: Define bit macros for FixCntrCtl MSR
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
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
References: <20230330012846.2927220-1-dapeng1.mi@linux.intel.com>
 <20230330130702.GF124812@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230330130702.GF124812@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-30 9:07 a.m., Peter Zijlstra wrote:
> On Thu, Mar 30, 2023 at 09:28:46AM +0800, Dapeng Mi wrote:
>> Define bit macros for FixCntrCtl MSR and replace the bit hardcoding
>> with these bit macros. This would make code be more human-readable.
>>
>> Perf commands 'perf stat -e "instructions,cycles,ref-cycles"' and
>> 'perf record -e "instructions,cycles,ref-cycles"' pass.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c      | 18 +++++++++---------
>>  arch/x86/include/asm/perf_event.h | 10 ++++++++++
>>  2 files changed, 19 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 070cc4ef2672..b7c0bb78ed59 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -2451,7 +2451,7 @@ static void intel_pmu_disable_fixed(struct perf_event *event)
>>  
>>  	intel_clear_masks(event, idx);
>>  
>> -	mask = 0xfULL << ((idx - INTEL_PMC_IDX_FIXED) * 4);
>> +	mask = intel_fixed_bits(idx - INTEL_PMC_IDX_FIXED, INTEL_FIXED_BITS_MASK);
>>  	cpuc->fixed_ctrl_val &= ~mask;
> 
> So maybe it's me, but I find the original far easier to read :/ That new
> things I need to look up every single identifier before I can tell wth
> it does.

The intel_fixed_bits() tries to replace the duplicate "bit << (idx *
4);". I think it should be a good improvement. Maybe we should rename it
to intel_shift_fixed_bits_by_idx(). Is it better?

If not, I think at least we should use some macros to replace the magic
number.

Thanks,
Kan

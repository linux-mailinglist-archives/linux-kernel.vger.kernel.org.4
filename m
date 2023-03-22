Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29666C4D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjCVOP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjCVOPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:15:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CB764864;
        Wed, 22 Mar 2023 07:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679494541; x=1711030541;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xQRrzlxhecTD5AMTnfLJZr21kEYVnBrnkCCGyzDt+j8=;
  b=IWfFU/G/PndH96tvTPaPN8+WqstvbzzbDwWQbOAy1lfmxA5Dnw43u/9o
   EbA0agS9kYbwf3F7yq6UFkxL4jxft9KasXImSWVEAR/WQy+ZVQjBxtPpN
   YF6+x8jsBzAeEwquFHDn+NKpuThWmdSPIPlH8VFGpzHoKGvyUOZzDihMd
   SOGdDlCPPNsJi5rTF4qeFNozZrZMou7/sLUYM73y2FLjPtGmt3Xh3TUY9
   QC2E9GReUelVdWGQhywK4kE0wWQ4PM0keJwIoHTs0E3WUHSKAHqyrF+uH
   Q3/0VmHMWluPloeen03QL0cXI074CGvOidalA6Q7wxOc4+qbO+xj+RFDl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="340758720"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="340758720"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:15:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="927845152"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="927845152"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.222.47])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:15:11 -0700
Message-ID: <c89fa4b3-f1f9-58f6-f14d-69e37dd4ab4c@intel.com>
Date:   Wed, 22 Mar 2023 16:15:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH] perf/core: Fix the same task check in
 perf_event_set_output
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, kan.liang@linux.intel.com
Cc:     alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        nadav.amit@gmail.com,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        jolsa@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        mingo@redhat.com, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
References: <20220711180706.3418612-1-kan.liang@linux.intel.com>
 <be7e6a74-4863-d5eb-51ff-26aa2890f2bd@intel.com>
 <20230322134203.GB2357380@hirez.programming.kicks-ass.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230322134203.GB2357380@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/23 15:42, Peter Zijlstra wrote:
> On Wed, Mar 22, 2023 at 12:59:28PM +0200, Adrian Hunter wrote:
>> On 11/07/22 21:07, kan.liang@linux.intel.com wrote:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> With the --per-thread option, perf record errors out when sampling with
>>> a hardware event and a software event as below.
>>>
>>>  $ perf record -e cycles,dummy --per-thread ls
>>>  failed to mmap with 22 (Invalid argument)
>>>
>>> The same task is sampled with the two events. The IOC_OUTPUT is invoked
>>> to share the mmap memory of the task between the events. In the
>>> perf_event_set_output(), the event->ctx is used to check whether the
>>> two events are attached to the same task. However, a hardware event and
>>> a software event are from different task context. The check always
>>> fails.
>>>
>>> The task struct is stored in the event->hw.target for each per-thread
>>> event. It can be used to determine whether two events are attached to
>>> the same task.
>>>
>>> The patch can also fix another issue reported months ago.
>>> https://lore.kernel.org/all/92645262-D319-4068-9C44-2409EF44888E@gmail.com/
>>> The event->ctx is not ready when the perf_event_set_output() is invoked
>>> in the perf_event_open(), while the event->hw.target has been assigned
>>> at the moment.
>>>
>>> The problem should be a long time issue since commit c3f00c70276d
>>> ("perf: Separate find_get_context() from event initialization"). The
>>> event->hw.target doesn't exist at that time. Here, the patch which
>>> introduces the event->hw.target is used by the Fixes tag.
>>>
>>> The problem should still exists between the broken patch and the
>>> event->hw.target patch. This patch does not intend to fix that case.
>>>
>>> Fixes: 50f16a8bf9d7 ("perf: Remove type specific target pointers")
>>> Reviewed-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>
>> Did this slip through the cracks, or is there more complexity
>> to this case than just sharing the rb?
> 
> Both; I very much missed it, but looking at it now, I'm not at all sure
> it is correct prior to the whole context rewrite we did recently.
> 
> So after the rewrite every cpu/task only has a single
> perf_event_context, and your change below is actually an equivalence.
> 
> But prior to that a task could have multiple contexts. Now they got
> co-scheduled most of the times and it will probably work, but I'm not
> entirely sure.
> 
> So how about we change the Fixes tag to something like:
> 
> Fixes: c3f00c70276d ("perf: Separate find_get_context() from event initialization") # >= v6.2
> 
> And anybody that wants to back-port this further gets to either do the
> full audit and/or keep the pieces.
> 
> Hmm?

Seems reasonable to me.  Kan?

> 
>>> ---
>>>  kernel/events/core.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index b4d62210c3e5..22df79d3f19d 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -12080,7 +12080,7 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
>>>  	/*
>>>  	 * If its not a per-cpu rb, it must be the same task.
>>>  	 */
>>> -	if (output_event->cpu == -1 && output_event->ctx != event->ctx)
>>> +	if (output_event->cpu == -1 && output_event->hw.target != event->hw.target)
>>>  		goto out;
>>>  
>>>  	/*
>>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D186C54B9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 20:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjCVTRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 15:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCVTRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:17:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090AE60436;
        Wed, 22 Mar 2023 12:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679512625; x=1711048625;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tx1Kcuf4QpLRjDayD+eITxUGYHkLN5dVzHW4VE152Xs=;
  b=YW9agoSQznCtVYvxLTvUZIBCwqLE6DCamK08BqbPoo90D/+bOwyi8uy2
   A9bW+v80epiB2jRgZdJQYvR/hhrQzbwrjN9GQ6x/1RsA8wJD14zj1ESc3
   YQgtL3SGjEB50dxdkvuF4iLzESbxjU9mtXw0f5bDbM/VBHDbhhyzQy/8n
   XqgAPE9vFJ+4kEJvHcyFdIH9mBgN+NsRCWl+ORJageF9geqIOPVlgAVzo
   P6sS70c1oL0GUtN/n2QtBf9x8TgQISNm9d5SDzWNZghqab2pM6WF6BSTJ
   JYutmp5aSSmt8i1o2uTyZLDtXfOHIH5Rv43rMVR6mcuQNxsdQ5BmNIy9I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="404202562"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="404202562"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 12:17:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="927945513"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="927945513"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 22 Mar 2023 12:17:03 -0700
Received: from [10.209.109.162] (kliang2-mobl1.ccr.corp.intel.com [10.209.109.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1F258580C35;
        Wed, 22 Mar 2023 12:17:02 -0700 (PDT)
Message-ID: <72b9cb37-dc6b-a802-2506-693c75180434@linux.intel.com>
Date:   Wed, 22 Mar 2023 15:17:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] perf/core: Fix the same task check in
 perf_event_set_output
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
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
 <c89fa4b3-f1f9-58f6-f14d-69e37dd4ab4c@intel.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <c89fa4b3-f1f9-58f6-f14d-69e37dd4ab4c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-22 10:15 a.m., Adrian Hunter wrote:
> On 22/03/23 15:42, Peter Zijlstra wrote:
>> On Wed, Mar 22, 2023 at 12:59:28PM +0200, Adrian Hunter wrote:
>>> On 11/07/22 21:07, kan.liang@linux.intel.com wrote:
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> With the --per-thread option, perf record errors out when sampling with
>>>> a hardware event and a software event as below.
>>>>
>>>>  $ perf record -e cycles,dummy --per-thread ls
>>>>  failed to mmap with 22 (Invalid argument)
>>>>
>>>> The same task is sampled with the two events. The IOC_OUTPUT is invoked
>>>> to share the mmap memory of the task between the events. In the
>>>> perf_event_set_output(), the event->ctx is used to check whether the
>>>> two events are attached to the same task. However, a hardware event and
>>>> a software event are from different task context. The check always
>>>> fails.
>>>>
>>>> The task struct is stored in the event->hw.target for each per-thread
>>>> event. It can be used to determine whether two events are attached to
>>>> the same task.
>>>>
>>>> The patch can also fix another issue reported months ago.
>>>> https://lore.kernel.org/all/92645262-D319-4068-9C44-2409EF44888E@gmail.com/
>>>> The event->ctx is not ready when the perf_event_set_output() is invoked
>>>> in the perf_event_open(), while the event->hw.target has been assigned
>>>> at the moment.
>>>>
>>>> The problem should be a long time issue since commit c3f00c70276d
>>>> ("perf: Separate find_get_context() from event initialization"). The
>>>> event->hw.target doesn't exist at that time. Here, the patch which
>>>> introduces the event->hw.target is used by the Fixes tag.
>>>>
>>>> The problem should still exists between the broken patch and the
>>>> event->hw.target patch. This patch does not intend to fix that case.
>>>>
>>>> Fixes: 50f16a8bf9d7 ("perf: Remove type specific target pointers")
>>>> Reviewed-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> Did this slip through the cracks, or is there more complexity
>>> to this case than just sharing the rb?
>>
>> Both; I very much missed it, but looking at it now, I'm not at all sure
>> it is correct prior to the whole context rewrite we did recently.
>>
>> So after the rewrite every cpu/task only has a single
>> perf_event_context, and your change below is actually an equivalence.
>>

Right, they are equivalent after the rewrite. I cannot reproduce the
"failed to mmap with 22 (Invalid argument)" issue with 6.2 and later
anymore.

But the issue reported by Nadav* can still be reproduced with the latest
6.3-rc.*
https://lore.kernel.org/all/92645262-D319-4068-9C44-2409EF44888E@gmail.com/
Because the event->ctx is still not set when the perf_event_set_output()
is invoked
in the perf_event_open(). The rewrite doesn't change with it.


>> But prior to that a task could have multiple contexts. Now they got
>> co-scheduled most of the times and it will probably work, but I'm not
>> entirely sure.
>>
>> So how about we change the Fixes tag to something like:
>>
>> Fixes: c3f00c70276d ("perf: Separate find_get_context() from event initialization") # >= v6.2
>>

Not sure if we want the # >= v6.2.

For v6.2 and later, the patch can fixes Nadav's issue.

For v6.1 and earlier, the patch fixes both Nadav's issue and the issue
described in the description.

I think I can send a V2 patch to make the history clear in the description.

Thanks,
Kan

>> And anybody that wants to back-port this further gets to either do the
>> full audit and/or keep the pieces.
>>
>> Hmm?
> 
> Seems reasonable to me.  Kan?
> 
>>
>>>> ---
>>>>  kernel/events/core.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>>> index b4d62210c3e5..22df79d3f19d 100644
>>>> --- a/kernel/events/core.c
>>>> +++ b/kernel/events/core.c
>>>> @@ -12080,7 +12080,7 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
>>>>  	/*
>>>>  	 * If its not a per-cpu rb, it must be the same task.
>>>>  	 */
>>>> -	if (output_event->cpu == -1 && output_event->ctx != event->ctx)
>>>> +	if (output_event->cpu == -1 && output_event->hw.target != event->hw.target)
>>>>  		goto out;
>>>>  
>>>>  	/*
>>>
> 

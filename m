Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724AF6817C3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbjA3Rg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237818AbjA3RgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:36:00 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7C9BB80;
        Mon, 30 Jan 2023 09:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675100158; x=1706636158;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RdadY7n7+q4UkWkrD7WyOBDORBaYWzj8UsjFJAsxf84=;
  b=NJFFNNBxMZqGdldWonbOl2EnUn2i0WrEr5Vua2lls5rPcZH0IhqclgoA
   2Z7v1fCQ68EtjCUG2riSa3EzOoVHysYz9embo7J1hG8oqgQx55Mkn/sxz
   c4D67OD+awUINXKL6eGWKHogK/VUXH1229rXwnXkhko/s9fcmeD4l8wN7
   gMfow5pZNWMHbRCsNaeR9oyfEJN1IBBxymDLxabOLD62Wtc2IyfY+qrEm
   Uo9NeftNlPLOfVhf7cnBIqV+8ZYTj+8KujidmyGAOZiK1ELv1lbcl+e54
   r6Y76oAcKfdPiInb2L7UWdhFnbjb88Lybm9UIkdIjfdYYAeELC0312Xwc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="311246854"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="311246854"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 09:35:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="788105520"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="788105520"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.33.106])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 09:35:48 -0800
Message-ID: <5676a1b7-885c-e8d9-1809-8bedcf1ff995@intel.com>
Date:   Mon, 30 Jan 2023 19:35:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 0/4] perf intel-pt: Fix the pipe mode (v1)
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Stephane Eranian <eranian@google.com>
References: <20230127001951.3432374-1-namhyung@kernel.org>
 <bda606c2-2b1b-de9f-1386-8ee2bf925b4b@intel.com>
 <CAM9d7cg_7LNKrXtBuo2QUR1Voi9NKM98qYLC+pznMf4-5yo4Dg@mail.gmail.com>
 <Y9fREY3BxROqYYBO@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Y9fREY3BxROqYYBO@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/23 16:15, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jan 27, 2023 at 02:54:36PM -0800, Namhyung Kim escreveu:
>> Hi Adrian,
>>
>> On Thu, Jan 26, 2023 at 11:22 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>
>>> On 27/01/23 02:19, Namhyung Kim wrote:
>>>> Hello,
>>>>
>>>> I found some problems in Intel-PT and auxtrace in general with pipe.
>>>> In the past it used to work with pipe, but recent code fails.
>>>
>>> Pipe mode is a problem for Intel PT and possibly other auxtrace users.
>>> Essentially the auxtrace buffers do not behave like the regular perf
>>> event buffers.  That is because the head and tail are updated by
>>> software, but in the auxtrace case the data is written by hardware.
>>> So the head and tail do not get updated as data is written.  In the
>>> Intel PT case, the head and tail are updated only when the trace is
>>> disabled by software, for example:
>>>     - full-trace, system wide : when buffer passes watermark
>>>     - full-trace, not system-wide : when buffer passes watermark or
>>>     context switches
>>>     - snapshot mode : as above but also when a snapshot is made
>>>     - sample mode : as above but also when a sample is made
>>>
>>> That means finished-round ordering doesn't work.  An auxtrace buffer
>>> can turn up that has data that extends back in time, possibly to the
>>> very beginning of tracing.
>>
>> Ok, IIUC we want to process the main buffer and auxtrace buffer
>> together in time order but there's no guarantee to get the auxtrace
>> data in time, right?

Yes

>>
>> I wonder if it's possible to use 2 pass processing for pipe mode.
>> We may keep the events in the ordered queue and auxtrace queue
>> in the first pass, and process together from the beginning in the
>> second pass. But I guess the data size would be a problem.
>>
>> Or, assuming that the auxtrace buffer comes later than (or equal to)
>> the main buffer, we may start processing the main buffer as soon as
>> every auxtrace queue gets some data.  Thoughts?

That sounds like it would require figuring out a timestamp up to
which there is Intel PT trace data in all queues.  That would
be very complicated.

>>
>>>
>>> For a perf.data file, that problem is solved by going through the trace
>>> and queuing up the auxtrace buffers in advance.
>>>
>>> For pipe mode, the order of events and timestamps can presumably
>>> be messed up.
>>>
>>> For Intel PT, it is a bit of a surprise that there is not
>>> validation to error out in pipe mode.
>>
>> What kind of validation do you have in mind?  Checking pid/tid?

Validation to kill pipe mode for Intel PT entirely.  But a warning
is ok.

>>
>>>
>>> At the least, a warning is needed, and the above explanation needs
>>> to be added to the documentation.
>>
>> Thanks, I'll add it to the documentation.
> 
> Ok, so I'll wait for v2 of this patch series, Adrian, apart from what
> you mentioned, are you ok with the patches, or a subset of them? The
> first ones looks ok, right?

Yes they are ok.

> 
> - Arnaldo
>  
>> How about showing something like this for pipe mode?
>>
>>   WARNING: Intel-PT with pipe mode may not work correctly.

Perhaps:

WARNING: Intel PT with pipe mode is not recommended. The output cannot be relied upon. In particular, time stamps and the order of events may be incorrect.

>>
>> Thanks,
>> Namhyung
>>
>>
>>>
>>>>                                                                As it
>>>> also touches the generic code, other auxtrace users like ARM SPE will
>>>> be affected too.  I added a test case to verify it works with pipes.
>>>>
>>>> At last, I can run this command without a problem.
>>>>
>>>>   $ perf record -o- -e intel_pt// true | perf inject -b | perf report -i- --itrace=i1000
>>>>
>>>> The code is available at 'perf/auxtrace-pipe-v1' branch in
>>>>
>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>>>>
>>>> Thanks,
>>>> Namhyung
>>>>
>>>> Namhyung Kim (4):
>>>>   perf inject: Use perf_data__read() for auxtrace
>>>>   perf intel-pt: Do not try to queue auxtrace data on pipe
>>>>   perf session: Avoid calling lseek(2) for pipe
>>>>   perf test: Add pipe mode test to the Intel PT test suite
>>>>
>>>>  tools/perf/builtin-inject.c             |  6 +++---
>>>>  tools/perf/tests/shell/test_intel_pt.sh | 17 +++++++++++++++++
>>>>  tools/perf/util/auxtrace.c              |  3 +++
>>>>  tools/perf/util/session.c               |  9 +++++++--
>>>>  4 files changed, 30 insertions(+), 5 deletions(-)
>>>>
>>>>
>>>> base-commit: 5670ebf54bd26482f57a094c53bdc562c106e0a9
>>>> prerequisite-patch-id: 4ccdf9c974a3909075051f4ffe498faecab7567b
>>>
> 


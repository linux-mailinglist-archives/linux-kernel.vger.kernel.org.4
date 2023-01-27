Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0CE67E881
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjA0Omf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjA0Ome (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:42:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F2B41711;
        Fri, 27 Jan 2023 06:42:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC58A2B;
        Fri, 27 Jan 2023 06:43:13 -0800 (PST)
Received: from [10.57.48.133] (unknown [10.57.48.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 728C13F5A1;
        Fri, 27 Jan 2023 06:42:30 -0800 (PST)
Message-ID: <317a91ff-70c5-57a5-8447-7543057e4055@arm.com>
Date:   Fri, 27 Jan 2023 14:42:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/4] perf intel-pt: Fix the pipe mode (v1)
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Stephane Eranian <eranian@google.com>
References: <20230127001951.3432374-1-namhyung@kernel.org>
 <bda606c2-2b1b-de9f-1386-8ee2bf925b4b@intel.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <bda606c2-2b1b-de9f-1386-8ee2bf925b4b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/01/2023 07:22, Adrian Hunter wrote:
> On 27/01/23 02:19, Namhyung Kim wrote:
>> Hello,
>>
>> I found some problems in Intel-PT and auxtrace in general with pipe.
>> In the past it used to work with pipe, but recent code fails.
> 
> Pipe mode is a problem for Intel PT and possibly other auxtrace users.

Just some info from my side: For Arm Coresight we ended up deprecating
pipe mode, then not supporting it altogether. First was when we added an
optional step to peek through all of the data to help with an edge case.
Then we added a requirement to receive a HW_ID packet before decoding
which necessitated the peek. You can't peek in pipe mode because you
need to be able to seek, so it's not supported at all anymore.

For Arm SPE I never tested it with piped data. I suppose I could add a
test at some point, but I don't really see the usecase.

James

> Essentially the auxtrace buffers do not behave like the regular perf
> event buffers.  That is because the head and tail are updated by
> software, but in the auxtrace case the data is written by hardware.
> So the head and tail do not get updated as data is written.  In the
> Intel PT case, the head and tail are updated only when the trace is
> disabled by software, for example:
>     - full-trace, system wide : when buffer passes watermark
>     - full-trace, not system-wide : when buffer passes watermark or
>     context switches
>     - snapshot mode : as above but also when a snapshot is made
>     - sample mode : as above but also when a sample is made
> 
> That means finished-round ordering doesn't work.  An auxtrace buffer
> can turn up that has data that extends back in time, possibly to the
> very beginning of tracing.
> 
> For a perf.data file, that problem is solved by going through the trace
> and queuing up the auxtrace buffers in advance.
> 
> For pipe mode, the order of events and timestamps can presumably
> be messed up.
> 
> For Intel PT, it is a bit of a surprise that there is not 
> validation to error out in pipe mode.
> 
> At the least, a warning is needed, and the above explanation needs
> to be added to the documentation.
> 
>>                                                                As it
>> also touches the generic code, other auxtrace users like ARM SPE will
>> be affected too.  I added a test case to verify it works with pipes.
>>
>> At last, I can run this command without a problem.
>>
>>   $ perf record -o- -e intel_pt// true | perf inject -b | perf report -i- --itrace=i1000
>>
>> The code is available at 'perf/auxtrace-pipe-v1' branch in
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>>
>> Thanks,
>> Namhyung
>>
>> Namhyung Kim (4):
>>   perf inject: Use perf_data__read() for auxtrace
>>   perf intel-pt: Do not try to queue auxtrace data on pipe
>>   perf session: Avoid calling lseek(2) for pipe
>>   perf test: Add pipe mode test to the Intel PT test suite
>>
>>  tools/perf/builtin-inject.c             |  6 +++---
>>  tools/perf/tests/shell/test_intel_pt.sh | 17 +++++++++++++++++
>>  tools/perf/util/auxtrace.c              |  3 +++
>>  tools/perf/util/session.c               |  9 +++++++--
>>  4 files changed, 30 insertions(+), 5 deletions(-)
>>
>>
>> base-commit: 5670ebf54bd26482f57a094c53bdc562c106e0a9
>> prerequisite-patch-id: 4ccdf9c974a3909075051f4ffe498faecab7567b
> 

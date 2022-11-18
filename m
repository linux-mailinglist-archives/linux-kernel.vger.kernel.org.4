Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5DB62F3CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbiKRLds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241738AbiKRLcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:32:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2A529BA11;
        Fri, 18 Nov 2022 03:32:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7EE023A;
        Fri, 18 Nov 2022 03:32:53 -0800 (PST)
Received: from [10.1.26.29] (e121896.cambridge.arm.com [10.1.26.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0A8B3F587;
        Fri, 18 Nov 2022 03:32:44 -0800 (PST)
Message-ID: <13f1a15c-b14f-b4cd-a523-2ec6df168224@arm.com>
Date:   Fri, 18 Nov 2022 11:32:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 05/12] perf test: Add 'leafloop' test workload
To:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        German Gomez <german.gomez@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
References: <20221116233854.1596378-1-namhyung@kernel.org>
 <20221116233854.1596378-6-namhyung@kernel.org> <Y3Zb+JChHoq+89yM@kernel.org>
 <Y3ZeOuNnk0xclY2x@kernel.org>
 <CAP-5=fVh0cQDeqSgVkLHbuiZKoFAp628oggQKwN6KxfUusA01Q@mail.gmail.com>
 <Y3ZuW2IxVWp9yoaD@kernel.org>
 <CAP-5=fWYi2ASE=v0UgrqbBDA2+jC0qmNX2_4r0wbFLV3Dw2nYw@mail.gmail.com>
 <CAM9d7cioaqjPgp+-UyUwzg7J3OQRC8DNMP0T1h5ro=yNgr128w@mail.gmail.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAM9d7cioaqjPgp+-UyUwzg7J3OQRC8DNMP0T1h5ro=yNgr128w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/11/2022 18:11, Namhyung Kim wrote:
> Hi,
> 
> On Thu, Nov 17, 2022 at 9:42 AM Ian Rogers <irogers@google.com> wrote:
>>
>> On Thu, Nov 17, 2022 at 9:24 AM Arnaldo Carvalho de Melo
>> <acme@kernel.org> wrote:
>>>
>>> Em Thu, Nov 17, 2022 at 09:16:58AM -0800, Ian Rogers escreveu:
>>>> On Thu, Nov 17, 2022 at 8:15 AM Arnaldo Carvalho de Melo
>>>> <acme@kernel.org> wrote:
>>>>>
>>>>> Em Thu, Nov 17, 2022 at 01:06:16PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>>> Em Wed, Nov 16, 2022 at 03:38:47PM -0800, Namhyung Kim escreveu:
>>>>>>> The leafloop workload is to run an infinite loop in the test_leaf
>>>>>>> function.  This is needed for the ARM fp callgraph test to verify if it
>>>>>>> gets the correct callchains.
>>>>>>>
>>>>>>>   $ perf test -w leafloop
>>>>>>
>>>>>> On fedora:36
>>>>>>
>>>>>> In file included from /usr/include/bits/libc-header-start.h:33,
>>>>>>                  from /usr/include/stdlib.h:26,
>>>>>>                  from tests/workloads/leafloop.c:2:
>>>>>> /usr/include/features.h:412:4: error: #warning _FORTIFY_SOURCE requires compiling with optimization (-O) [-Werror=cpp]
>>>>>>   412 | #  warning _FORTIFY_SOURCE requires compiling with optimization (-O)
>>>>>>       |    ^~~~~~~
>>>>>> cc1: all warnings being treated as errors
>>>>>> make[5]: *** [/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/tests/workloads/leafloop.o] Error 1
>>>>>> make[5]: *** Waiting for unfinished jobs....
>>>>>>
>>>>>> I'll try removing the _FORTIFY_SOURCE
>>>>>
>>>>> Works after I added this to datasym.c, leafloop.c and brstack.c:
>>>>
>>>> Is there a reason we are compiling without -O ? Perhaps we can filter
>>>
>>> I assumed so as Namhyung added it, perhaps he is just carrying it from
>>> the pre-existing shell tests?
> 
> Exactly :)
> 
>>>
>>> I wonder its to have a predictable binary output that the test expects
>>> when doing things like hardware tracing? As it come from the coresight
>>> tests, IIRC.
> 
> I think it just checks frame-pointer based callstacks on ARM to have the
> precise results for leaves and their parents.
> 
> 
>>
>> Would the following in the Build be better:
>>
>> ```
>> # Undefine _FORTIFY_SOURCE as it doesn't work with -O0
>> CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer
>> -U_FORTIFY_SOURCE
>> ```
>>
>> We could also use make's `filter-out`. If we are disabling inlining
>> then there is also `-fno-optimize-sibling-calls` otherwise we can
>> still lose stack frames.
> 
> I wonder if it's enough to use -O0 as it's enabled from -O2.
> Maybe we can get rid of -fno-inline as well.
> 
> German, did you have any concerns for those options?
> 

Is it possible to go with the -U_FORTIFY_SOURCE option? From looking at
the disassembly, changing -O and the other -f options makes quite a bit
of difference.

It's fairly important to that test because it's testing that the
combination of both frame pointer unwinding and dwarf unwinding result
in the complete stack.

If we change the options I'd have to go back and double check with
different compiler versions that it's still doing the right thing. For
example if a frame pointer is included for the last frame, then the
dwarf bit doesn't get tested.


> Thanks,
> Namhyung

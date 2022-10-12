Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E4E5FC9BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 19:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJLRMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 13:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJLRMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 13:12:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2C05CD5FE;
        Wed, 12 Oct 2022 10:12:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C78AA165C;
        Wed, 12 Oct 2022 10:12:48 -0700 (PDT)
Received: from [10.57.2.148] (unknown [10.57.2.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E07B3F766;
        Wed, 12 Oct 2022 10:12:39 -0700 (PDT)
Message-ID: <e0b47b51-87f0-42db-4a76-b240bf07cd41@arm.com>
Date:   Wed, 12 Oct 2022 18:12:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] perf: Fix "Track with sched_switch" test by not printing
 warnings in quiet mode
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20221012111025.30609-1-james.clark@arm.com>
 <62f485df-4f5e-64a2-1294-6e162de25556@arm.com>
 <CAM9d7cgNrZ6iwRQsGHWGLWCd7cJm+L6UOU9BiGGgTVPdJ0_GJQ@mail.gmail.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAM9d7cgNrZ6iwRQsGHWGLWCd7cJm+L6UOU9BiGGgTVPdJ0_GJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/2022 17:50, Namhyung Kim wrote:
> On Wed, Oct 12, 2022 at 4:13 AM James Clark <james.clark@arm.com> wrote:
>>
>>
>>
>> On 12/10/2022 12:10, James Clark wrote:
>>> Especially when CONFIG_LOCKDEP and other debug configs are enabled,
>>> Perf can print the following warning when running the "Track with
>>> sched_switch" test:
>>
>> Oops got the wrong test name here and in the title. Should be "kernel
>> lock contention analysis test"
> 
> Could you please resend?
> 
>>
>>>
>>>   Warning:
>>>   Processed 1378918 events and lost 4 chunks!
>>>
>>>   Check IO/CPU overload!
>>>
>>>   Warning:
>>>   Processed 4593325 samples and lost 70.00%!
>>>
>>> The test already supplies -q to run in quiet mode, so extend quiet mode
>>> to perf_stdio__warning() and also ui__warning() for consistency.
> 
> I'm not sure if suppressing the warnings with -q is a good thing.
> Maybe we need to separate warning/debug messages from the output.

I don't see the issue with warnings being suppressed in quiet mode as
long as errors are still printed. In other cases warnings have already
been suppressed by quiet mode and this site is the odd one out.

What use case are you thinking of where someone explicitly adds -q but
wants to see non fatal warnings?

Thanks
James

> 
> Thanks,
> Namhyung
> 
> 
>>>
>>> This fixes the following failure due to the extra lines counted:
>>>
>>>   perf test "lock cont" -vvv
>>>
>>>   82: kernel lock contention analysis test                            :
>>>   --- start ---
>>>   test child forked, pid 3125
>>>   Testing perf lock record and perf lock contention
>>>   [Fail] Recorded result count is not 1: 9
>>>   test child finished with -1
>>>   ---- end ----
>>>   kernel lock contention analysis test: FAILED!
>>>
>>> Fixes: ec685de25b67 ("perf test: Add kernel lock contention test")
>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>> ---
>>>  tools/perf/ui/util.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/tools/perf/ui/util.c b/tools/perf/ui/util.c
>>> index 689b27c34246..1d38ddf01b60 100644
>>> --- a/tools/perf/ui/util.c
>>> +++ b/tools/perf/ui/util.c
>>> @@ -15,6 +15,9 @@ static int perf_stdio__error(const char *format, va_list args)
>>>
>>>  static int perf_stdio__warning(const char *format, va_list args)
>>>  {
>>> +     if (quiet)
>>> +             return 0;
>>> +
>>>       fprintf(stderr, "Warning:\n");
>>>       vfprintf(stderr, format, args);
>>>       return 0;
>>> @@ -45,6 +48,8 @@ int ui__warning(const char *format, ...)
>>>  {
>>>       int ret;
>>>       va_list args;
>>> +     if (quiet)
>>> +             return 0;
>>>
>>>       va_start(args, format);
>>>       ret = perf_eops->warning(format, args);

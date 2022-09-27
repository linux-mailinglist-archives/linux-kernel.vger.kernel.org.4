Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56F65EBDBD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiI0Isj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiI0Is3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:48:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28D378049B;
        Tue, 27 Sep 2022 01:48:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41EC81042;
        Tue, 27 Sep 2022 01:48:34 -0700 (PDT)
Received: from [10.32.36.24] (e121896.Emea.Arm.com [10.32.36.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A26E63F66F;
        Tue, 27 Sep 2022 01:48:25 -0700 (PDT)
Message-ID: <849703ed-ef66-f622-a5b0-10107fbe7c10@arm.com>
Date:   Tue, 27 Sep 2022 09:48:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] perf test: Skip sigtrap test on old kernels
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
References: <20220903000210.1112014-1-namhyung@kernel.org>
 <CANpmjNMPh5QjdxXtrCc5FApjgzV=81CNNiwbeg_rE3NxN_WCZw@mail.gmail.com>
 <c4f7e14b-a229-6b23-b28d-880b8369e6d8@arm.com>
 <CAM9d7ch36RGYJJEg2dnrauQnVX_f9MiE0RB99EU4ynNL-8CUVA@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAM9d7ch36RGYJJEg2dnrauQnVX_f9MiE0RB99EU4ynNL-8CUVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/09/2022 17:19, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Sep 26, 2022 at 8:06 AM James Clark <james.clark@arm.com> wrote:
>>
>>
>>
>> On 03/09/2022 07:52, Marco Elver wrote:
>>> On Sat, 3 Sept 2022 at 02:02, Namhyung Kim <namhyung@kernel.org> wrote:
>>>>
>>>> If it runs on an old kernel, perf_event_open would fail because of the
>>>> new fields sigtrap and sig_data.  Just skip the test if it failed.
>>>>
>>>> Cc: Marco Elver <elver@google.com>
>>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>>> ---
>>>>  tools/perf/tests/sigtrap.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
>>>> index e32ece90e164..7057566e6ae4 100644
>>>> --- a/tools/perf/tests/sigtrap.c
>>>> +++ b/tools/perf/tests/sigtrap.c
>>>> @@ -140,6 +140,7 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
>>>>         fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
>>>>         if (fd < 0) {
>>>>                 pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
>>>> +               ret = TEST_SKIP;
>>>
>>> Wouldn't we be interested if perf_event_open() fails because it could
>>> actually be a bug? By skipping we'll be more likely to miss the fact
>>> there's a real problem.
>>>
>>> That's my naive thinking at least - what do other perf tests usually
>>> do in this case?
>>
>> I missed this discussion but I just submitted a patch with a similar
>> issue [1]. To me, it doesn't make sense to have the tests pass on older
>> kernels if this lowers the value of the tests by accepting possibly
>> invalid values. If you want to test older kernels then just use older
>> tests, but maybe there is some use case that I'm not aware of.
> 
> Thanks for your opinion.  But my test environment is running the tests
> on random machines which may run some old kernel.  I agree that it
> should not skip the real problems but I think we can find a good way
> to detect old, unsupported kernels reliably like using BTF.

I'm currently adding a test for the new VG user register [1]. I'd like
to test that it's available when the system has SVE but not when it
hasn't so that the ABI is locked down. But that test will also depend on
the kernel version, because it will never be available on older ones.

So for new tests should we always add two versions of the test, one for
newer and one for older kernels? That seems like that has not been done
so far in the tests. I'd still question the value of running the new
tests on old kernels because they are mainly to validate that new code
doesn't cause regressions. It's a lot of work to keep them backwards
compatible for the case of running them on old kernels when old tests
can be used instead.

If I am do add a version check would just looking at the uname be
enough? Or how would the BTF version of that look?

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/perf&id=cbb0c02caf4bd98b9e0cd6d7420734b8e9a35703

> 
> Thanks,
> Namhyung

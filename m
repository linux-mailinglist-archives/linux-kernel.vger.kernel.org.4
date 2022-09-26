Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5142C5EAC4C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbiIZQSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbiIZQRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:17:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A17C1B867E;
        Mon, 26 Sep 2022 08:06:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10C521042;
        Mon, 26 Sep 2022 08:06:34 -0700 (PDT)
Received: from [10.57.0.51] (unknown [10.57.0.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A6683F66F;
        Mon, 26 Sep 2022 08:06:26 -0700 (PDT)
Message-ID: <c4f7e14b-a229-6b23-b28d-880b8369e6d8@arm.com>
Date:   Mon, 26 Sep 2022 16:06:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] perf test: Skip sigtrap test on old kernels
Content-Language: en-US
To:     Marco Elver <elver@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
References: <20220903000210.1112014-1-namhyung@kernel.org>
 <CANpmjNMPh5QjdxXtrCc5FApjgzV=81CNNiwbeg_rE3NxN_WCZw@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CANpmjNMPh5QjdxXtrCc5FApjgzV=81CNNiwbeg_rE3NxN_WCZw@mail.gmail.com>
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



On 03/09/2022 07:52, Marco Elver wrote:
> On Sat, 3 Sept 2022 at 02:02, Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> If it runs on an old kernel, perf_event_open would fail because of the
>> new fields sigtrap and sig_data.  Just skip the test if it failed.
>>
>> Cc: Marco Elver <elver@google.com>
>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>> ---
>>  tools/perf/tests/sigtrap.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
>> index e32ece90e164..7057566e6ae4 100644
>> --- a/tools/perf/tests/sigtrap.c
>> +++ b/tools/perf/tests/sigtrap.c
>> @@ -140,6 +140,7 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
>>         fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
>>         if (fd < 0) {
>>                 pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
>> +               ret = TEST_SKIP;
> 
> Wouldn't we be interested if perf_event_open() fails because it could
> actually be a bug? By skipping we'll be more likely to miss the fact
> there's a real problem.
> 
> That's my naive thinking at least - what do other perf tests usually
> do in this case?

I missed this discussion but I just submitted a patch with a similar
issue [1]. To me, it doesn't make sense to have the tests pass on older
kernels if this lowers the value of the tests by accepting possibly
invalid values. If you want to test older kernels then just use older
tests, but maybe there is some use case that I'm not aware of.

[1]: "[PATCH 0/1] perf test: Fix attr tests for PERF_FORMAT_LOST"

> 
> Thanks,
> -- Marco

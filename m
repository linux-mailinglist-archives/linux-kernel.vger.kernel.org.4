Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66A263ED30
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiLAKG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiLAKGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:06:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CE081DF0A;
        Thu,  1 Dec 2022 02:06:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73BDFD6E;
        Thu,  1 Dec 2022 02:06:54 -0800 (PST)
Received: from [10.57.7.90] (unknown [10.57.7.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6644E3F67D;
        Thu,  1 Dec 2022 02:06:46 -0800 (PST)
Message-ID: <a0745ad9-c21e-2c93-9af4-46e60bc301fc@arm.com>
Date:   Thu, 1 Dec 2022 10:06:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] perf stat: Fix invalid output handle
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>
References: <20221130111521.334152-1-james.clark@arm.com>
 <20221130111521.334152-2-james.clark@arm.com>
 <CAM9d7cj0Zrv32CgJ7jSjCY=CsOcF40zC2kxE+NSixG4qZDpXqQ@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAM9d7cj0Zrv32CgJ7jSjCY=CsOcF40zC2kxE+NSixG4qZDpXqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/11/2022 18:32, Namhyung Kim wrote:
> On Wed, Nov 30, 2022 at 3:15 AM James Clark <james.clark@arm.com> wrote:
>>
>> In this context, 'os' is already a pointer so the extra dereference
>> isn't required. This fixes the following test failure on aarch64:
>>
>>   $ ./perf test "json output" -vvv
>>   92: perf stat JSON output linter                                    :
>>   --- start ---
>>   Checking json output: no args Test failed for input:
>>   ...
>>   Fatal error: glibc detected an invalid stdio handle
>>   ---- end ----
>>   perf stat JSON output linter: FAILED!
>>
>> Fixes: e7f4da312259 ("perf stat: Pass struct outstate to printout()")
>> Signed-off-by: James Clark <james.clark@arm.com>
> 
> Thanks for fixing this.  I'm not sure how I missed it.. :(
> 

It seems to only go down that path on some configuration. At least on
x86 the test was passing fine for me.

> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks for the review!

> 
> Thanks,
> Namhyung
> 
> 
>> ---
>>  tools/perf/util/stat-display.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
>> index 847acdb5dc40..eac5ac3a734c 100644
>> --- a/tools/perf/util/stat-display.c
>> +++ b/tools/perf/util/stat-display.c
>> @@ -741,7 +741,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
>>                 perf_stat__print_shadow_stats(config, counter, uval, map_idx,
>>                                               &out, &config->metric_events, &rt_stat);
>>         } else {
>> -               pm(config, &os, /*color=*/NULL, /*format=*/NULL, /*unit=*/"", /*val=*/0);
>> +               pm(config, os, /*color=*/NULL, /*format=*/NULL, /*unit=*/"", /*val=*/0);
>>         }
>>
>>         if (!config->metric_only) {
>> --
>> 2.25.1
>>

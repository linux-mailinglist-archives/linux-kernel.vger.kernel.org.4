Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB77E5F6A56
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJFPLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiJFPLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:11:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29891A59B7;
        Thu,  6 Oct 2022 08:11:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C937D6E;
        Thu,  6 Oct 2022 08:11:16 -0700 (PDT)
Received: from [10.57.0.62] (unknown [10.57.0.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BF843F67D;
        Thu,  6 Oct 2022 08:11:07 -0700 (PDT)
Message-ID: <cce859cc-f25b-b4e8-70c5-917569aec050@arm.com>
Date:   Thu, 6 Oct 2022 16:11:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] perf test: Fix test_arm_coresight.sh failures on Juno
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     coresight@lists.linaro.org, acme@kernel.org,
        suzuki.poulose@arm.com, linux-perf-users@vger.kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20221005140508.1537277-1-james.clark@arm.com>
 <Yz7qx+4BxNYOCgvL@leoy-yangtze.lan>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <Yz7qx+4BxNYOCgvL@leoy-yangtze.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/10/2022 15:48, Leo Yan wrote:
> Hi James,
> 
> On Wed, Oct 05, 2022 at 03:05:08PM +0100, James Clark wrote:
>> This test commonly fails on Arm Juno because the instruction interval
>> is large enough to miss generating any samples for Perf in system-wide
>> mode.
>>
>> Fix this by lowering the interval until a comfortable number of Perf
>> instructions are generated. The test is still quick to run because only
>> a small amount of trace is gathered.
>>
>> Before:
>>
>>   sudo ./perf test coresight -vvv
>>   ...
>>   Recording trace with system wide mode
>>   Looking at perf.data file for dumping branch samples:
>>   Looking at perf.data file for reporting branch samples:
>>   Looking at perf.data file for instruction samples:
>>   CoreSight system wide testing: FAIL
>>   ...
>>
>> After:
>>
>>   sudo ./perf test coresight -vvv
>>   ...
>>   Recording trace with system wide mode
>>   Looking at perf.data file for dumping branch samples:
>>   Looking at perf.data file for reporting branch samples:
>>   Looking at perf.data file for instruction samples:
>>   CoreSight system wide testing: PASS
>>   ...
> 
> Since Arm Juno board has zero timestamp for CoreSight, I don't think
> now arm_cs_etm.sh can really work on it.
> 
> If we want to pass the test on Juno board, we need to add option
> "--itrace=Zi1000i" for "perf report" and "perf script"; but seems
> to me "--itrace=Z..." is not a general case for testing ...

Unfortunately I now think that adding the Z option didn't improve
anything in Coresight decoding other than removing the warning. I've
never seen the zero timestamp issue on Juno though. I thought that was
on some Qualcomm device? I'm not getting the warning on this test anyway.

The problem is that timeless mode assumes per thread mode, and in per
thread mode there is a separate buffer per thread, so the Coresight
channel IDs are ignored. In systemwide mode the channel ID is important
to know which CPU the trace came from. If this info is thrown away then
not much works correctly.

I plan to overhaul the whole decoder and remove all the assumptions
about per-thread and timeless mode. It would be better if they were
completely separate concepts.

> 
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/tests/shell/test_arm_coresight.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
>> index e4cb4f1806ff..daad786cf48d 100755
>> --- a/tools/perf/tests/shell/test_arm_coresight.sh
>> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
>> @@ -70,7 +70,7 @@ perf_report_instruction_samples() {
>>  	#   68.12%  touch    libc-2.27.so   [.] _dl_addr
>>  	#    5.80%  touch    libc-2.27.so   [.] getenv
>>  	#    4.35%  touch    ld-2.27.so     [.] _dl_fixup
>> -	perf report --itrace=i1000i --stdio -i ${perfdata} 2>&1 | \
>> +	perf report --itrace=i20i --stdio -i ${perfdata} 2>&1 | \
>>  		egrep " +[0-9]+\.[0-9]+% +$1" > /dev/null 2>&1
> 
> So here I am suspect that changing to "--itrace=i20i" can allow the test
> to pass on Juno board.  Could you confirm for this?

On Juno:

  ./perf record -e cs_etm// -a -- ls

With interval 20, 23 instruction samples are generated:

  ./perf report --stdio --itrace=i20i | egrep " +[0-9]+\.[0-9]+% +perf "
| wc -l

  23

With interval 1000, 0 are generated:

  ./perf report --stdio --itrace=i1000i | egrep " +[0-9]+\.[0-9]+% +perf
" | wc -l

  Error:
  The perf.data data has no samples!
  0

I think the issue is that ls is quite quick to run, so not much trace is
generated for Perf. And it just depends on the scheduling which is
slightly different on Juno. I don't think it's a bug. On N1SDP there are
only 134 samples generated with i1000i, so it could probably end up with
a random run generating 0 there too.


> 
> Thanks,
> Leo

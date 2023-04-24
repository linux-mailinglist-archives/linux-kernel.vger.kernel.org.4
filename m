Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0C16E0001
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjDLUjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDLUjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:39:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655139C;
        Wed, 12 Apr 2023 13:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681331950; x=1712867950;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0aDMsbb3mfTOBR3LQyQVs9U6WyNa0/OfsArUCEDIk0g=;
  b=L5EutHeHlL7uaD6Kr0CDr9qgzH7fr8G+nBY5dYNI2NaUHLXIuxn0ebhx
   wnBR30m0Jv5hK7ECVVZTEvqPRqlG5Ns63du9i9VOQB/PX301339v290Vi
   kGBe+DDBctVmxTLxDEalRptFAoSoQ5x8HWsKQ2BjJEWig3y3VrlkboU2n
   Y6pDdXjUXgW/q2f7+0I5DjkEWjuGsC2Yr2Ub1Soe1BKQS/zLfH8PPmj2p
   5mhpk8Tcdt7b7P6F/jEbN+5rlX3FPukH+1rH8rQOfWybYa4cW6dQN7/9M
   exXUwfhX/4msoh/6zWi0+EO89UR+2Juo7HqjmJc/90F+KieDngicyuZLe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="406849007"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="406849007"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 13:39:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="666500670"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="666500670"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 12 Apr 2023 13:39:09 -0700
Received: from [10.209.99.204] (kliang2-mobl1.ccr.corp.intel.com [10.209.99.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 67C77580BEE;
        Wed, 12 Apr 2023 13:39:07 -0700 (PDT)
Message-ID: <ebd32500-9baa-425f-8355-d2cdd04a53ae@linux.intel.com>
Date:   Wed, 12 Apr 2023 16:39:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] perf tests: Fix tests in 'Parse event definition strings'
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        "Zhang, Tinghao" <tinghao.zhang@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        "Yi, Ammy" <ammy.yi@intel.com>
References: <20230411094330.653965-1-tinghao.zhang@intel.com>
 <CAP-5=fVWx7F9D0MvU=tCJ4nQ3QjaB7fVaCjvD8j4F-1yo5piDA@mail.gmail.com>
 <edd1d807-b28d-f6a3-d6fb-af39e7909744@intel.com>
 <CAP-5=fV20jibAu82Q3U8FnavHp7dxG=5UvKgMBp7YBe5FG+gXw@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fV20jibAu82Q3U8FnavHp7dxG=5UvKgMBp7YBe5FG+gXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-12 12:35 p.m., Ian Rogers wrote:
> On Wed, Apr 12, 2023 at 3:16 AM Zhang, Tinghao <tinghao.zhang@intel.com> wrote:
>>
>>
>> On 4/11/2023 9:50 PM, Ian Rogers wrote:
>>
>> On Tue, Apr 11, 2023, 2:49 AM <tinghao.zhang@intel.com> wrote:
>>>
>>> From: Tinghao Zhang <tinghao.zhang@intel.com>
>>>
>>> The 'Test event parsing' test set under 'Parse event definion strings'
>>> does not apply to hybrid events. Since hybrid events have a dedicated
>>> test set 'Test parsing of hybrid CPU events', skip these tests on hybrid
>>> platforms.
>>>
>>> Fixes: 7741e03e808a ("perf test: Parse events break apart tests")
>>> Reported-by: Yi Ammy <ammy.yi@intel.com>
>>> Signed-off-by: Tinghao Zhang <tinghao.zhang@intel.com>
>>
>>
>> This feels wrong and could make a different problem. Could you send the failure you are seeing? There is a verbose flag (-vv) that you can pass to perf test.
>>
>> Thanks,
>> Ian
>>
>> Hi Ian,
>>
>> I think these test cases are not designed for hybrid platforms.  As the current implementation, if one general event type is used on hybrid platform,
>> perf tool would generate seperate event for each pmu. But tests in 'Test event parsing' asserts only one evlist entry per event type. Another problem is that for
> 
> 
> Hi Tinghao,
> 
> So you are right that the tests weren't designed for hybrid platforms
> because they didn't exist when the tests were created, but the bigger
> issue is what should perf be doing in these cases. On ARM's BIG.little
> version of "hybrid" there is a single PMU and generic events that work
> on both kind of core. 

But we have different PMUs for Intel hybrid. The event list is quite
different between e-core and p-core. There are some features which only
available for one type of core. I don't think we can have a single PMU
for Intel hybrid.

> But even with a single core we can get into
> issues that an event can be defined for more than one PMU. For
> example, a GPU may have an instructions-retired count. In sysfs we'd
> have /sys/devices/my-gpu and /sys/devices/cpu. If the user asks for
> instructions-retired and has suitable permission, should the perf tool
> display instructions-retired for the GPU or just the cpu? My belief is
> that we should display my-gpu/instructions-retired/ and
> cpu/instructions-retired/. If the user wants to then limit to the CPU
> one, they can use the full PMU and event name
> cpu/instructions-retired/.
>> Why does this matter? Well if we have a common plan for how to deal
> with events that match on more than 1 PMU then hybrid can just follow
> the plan and we can remove all of the hybrid code from the perf tool.
> Yes, the tests made an assumption there'd only be 1 of a kind of PMU
> for an event, so we need to change the test to assume that there will
> be at least 1, or that the number should match the number of PMUs or
> core PMUs.

How about the group? Using weak group?

> 
>> PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE, attr.config has a different format for hybrid events, so we see attr.config errors. Also, it is not applicable
>> to put events from different PMUs to one group, but here some tests put general events in one group. As for the patch that first introduces hybrid test cases
>> 2541cb63ac0c ("perf tests: Add hybrid cases for 'Parse event definition strings' test") , this test set is skipped. I think it's better if we skip this test set for hybrid pmus.
> 
> So I think:
> 2541cb63ac0c ("perf tests: Add hybrid cases for 'Parse event
> definition strings' test")
> was added quickly in order that nothing be blocked, but with hindsight
> it regrettably didn't make a generic solution that could be used for a
> range of PMUs. You may be interested to see that the problem of being
> too CPU centric for perf is something reported by Intel's GPU team:
> https://www.kernel.org/doc/html/next/gpu/i915.html#issues-hit-with-first-prototype-based-on-core-perf
> I'd rather that the code were not hybrid or CPU specific, but
> everything was based off the PMU abstraction. For the attributes we'll
> need to improve the test to make it more generic to handle matching on
> multiple PMUs.

The current "test__events" doesn't generic enough. There is
L1-dcache-load-miss which apparently CPU specific. Also ARCH specific
events, e.g., kvm-s390, intel_pt. And groups.

How should we make it generic? Any suggestions?

Thanks,
Kan

> 
>> Below is the perf test result on one Intel Meteor Lake platform
>>
>>   6: Parse event definition strings                                  :
>>   6.1: Test event parsing                                            :
>> --- start ---
>> test child forked, pid 44965
>> running test 0 'syscalls:sys_enter_openat'
>> Using CPUID GenuineIntel-6-AA-2
>> intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
>> running test 1 'syscalls:*'
>> running test 2 'r1a'
>> FAILED tests/parse-events.c:87 wrong number of entries
>> Event test failure: test 2 'r1a'running test 3 '1:1'
>> running test 4 'instructions'
>> FAILED tests/parse-events.c:107 wrong number of entries
>> Event test failure: test 4 'instructions'running test 5 'cycles/period=100000,config2/'
>> FAILED tests/parse-events.c:118 wrong number of entries
>> Event test failure: test 5 'cycles/period=100000,config2/'running test 6 'faults'
>> running test 7 'L1-dcache-load-miss'
>> ------------------------------------------------------------
>> perf_event_attr:
>>   type                             3
>>   config                           0x400010000
>>   disabled                         1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 3
>> ------------------------------------------------------------
>> perf_event_attr:
>>   type                             3
>>   config                           0x800010000
>>   disabled                         1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
>> sys_perf_event_open failed, error -2
>> FAILED tests/parse-events.c:152 wrong config
>> Event test failure: test 7 'L1-dcache-load-miss'running test 8 'mem:0'
>> running test 9 'mem:0:x'
>> running test 10 'mem:0:r'
>> running test 11 'mem:0:w'
>> running test 12 'syscalls:sys_enter_openat:k'
>> running test 13 'syscalls:*:u'
>> running test 14 'r1a:kp'
>> FAILED tests/parse-events.c:87 wrong number of entries
>> Event test failure: test 14 'r1a:kp'running test 15 '1:1:hp'
>> running test 16 'instructions:h'
>> FAILED tests/parse-events.c:107 wrong number of entries
>> Event test failure: test 16 'instructions:h'running test 17 'faults:u'
>> running test 18 'L1-dcache-load-miss:kp'
>> ------------------------------------------------------------
>> perf_event_attr:
>>   type                             3
>>   config                           0x400010000
>>   disabled                         1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 39
>> ------------------------------------------------------------
>> perf_event_attr:
>>   type                             3
>>   config                           0x800010000
>>   disabled                         1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
>> sys_perf_event_open failed, error -2
>> FAILED tests/parse-events.c:152 wrong config
>> Event test failure: test 18 'L1-dcache-load-miss:kp'running test 19 'mem:0:u'
>> running test 20 'mem:0:x:k'
>> running test 21 'mem:0:r:hp'
>> running test 22 'mem:0:w:up'
>> running test 23 'r1,syscalls:sys_enter_openat:k,1:1:hp'
>> FAILED tests/parse-events.c:466 wrong number of entries
>> Event test failure: test 23 'r1,syscalls:sys_enter_openat:k,1:1:hp'running test 24 'instructions:G'
>> FAILED tests/parse-events.c:107 wrong number of entries
>> Event test failure: test 24 'instructions:G'running test 25 'instructions:H'
>> FAILED tests/parse-events.c:107 wrong number of entries
>> Event test failure: test 25 'instructions:H'running test 26 'mem:0:rw'
>> running test 27 'mem:0:rw:kp'
>> running test 28 '{instructions:k,cycles:upp}'
>> FAILED tests/parse-events.c:679 wrong number of entries
>> Event test failure: test 28 '{instructions:k,cycles:upp}'running test 29 '{faults:k,cache-references}:u,cycles:k'
>> FAILED tests/parse-events.c:721 wrong number of entries
>> Event test failure: test 29 '{faults:k,cache-references}:u,cycles:k'running test 30 'group1{syscalls:sys_enter_openat:H,cycles:kppp},group2{cycles,1:3}:G,instructions:u'
>> FAILED tests/parse-events.c:777 wrong number of entries
>> Event test failure: test 30 'group1{syscalls:sys_enter_openat:H,cycles:kppp},group2{cycles,1:3}:G,instructions:u'running test 31 '{cycles:u,instructions:kp}:p'
>> FAILED tests/parse-events.c:870 wrong number of entries
>> Event test failure: test 31 '{cycles:u,instructions:kp}:p'running test 32 '{cycles,instructions}:G,{cycles:G,instructions:G},cycles'
>> FAILED tests/parse-events.c:914 wrong number of entries
>> Event test failure: test 32 '{cycles,instructions}:G,{cycles:G,instructions:G},cycles'running test 33 '*:*'
>> running test 34 '{cycles,cache-misses:G}:H'
>> FAILED tests/parse-events.c:1000 wrong number of entries
>> Event test failure: test 34 '{cycles,cache-misses:G}:H'running test 35 '{cycles,cache-misses:H}:G'
>> FAILED tests/parse-events.c:1040 wrong number of entries
>> Event test failure: test 35 '{cycles,cache-misses:H}:G'running test 36 '{cycles:G,cache-misses:H}:u'
>> FAILED tests/parse-events.c:1080 wrong number of entries
>> Event test failure: test 36 '{cycles:G,cache-misses:H}:u'running test 37 '{cycles:G,cache-misses:H}:uG'
>> FAILED tests/parse-events.c:1120 wrong number of entries
>> Event test failure: test 37 '{cycles:G,cache-misses:H}:uG'running test 38 '{cycles,cache-misses,branch-misses}:S'
>> FAILED tests/parse-events.c:1160 wrong number of entries
>> Event test failure: test 38 '{cycles,cache-misses,branch-misses}:S'running test 39 '{instructions,branch-misses}:Su'
>> FAILED tests/parse-events.c:1213 wrong number of entries
>> Event test failure: test 39 '{instructions,branch-misses}:Su'running test 40 'instructions:uDp'
>> FAILED tests/parse-events.c:107 wrong number of entries
>> Event test failure: test 40 'instructions:uDp'running test 41 '{cycles,cache-misses,branch-misses}:D'
>> FAILED tests/parse-events.c:1265 wrong number of entries
>> Event test failure: test 41 '{cycles,cache-misses,branch-misses}:D'running test 42 'mem:0/1'
>> running test 43 'mem:0/2:w'
>> running test 44 'mem:0/4:rw:u'
>> running test 45 'instructions:I'
>> FAILED tests/parse-events.c:107 wrong number of entries
>> Event test failure: test 45 'instructions:I'running test 46 'instructions:kIG'
>> FAILED tests/parse-events.c:107 wrong number of entries
>> Event test failure: test 46 'instructions:kIG'running test 47 'task-clock:P,cycles'
>> FAILED tests/parse-events.c:1382 wrong number of entries
>> Event test failure: test 47 'task-clock:P,cycles'running test 48 'instructions/name=insn/'
>> running test 49 'r1234/name=rawpmu/'
>> running test 50 '4:0x6530160/name=numpmu/'
>> WARNING: event 'numpmu' not valid (bits 16-17,20,22 of config '6530160' not supported by kernel)!
>> running test 51 'L1-dcache-misses/name=cachepmu/'
>> ------------------------------------------------------------
>> perf_event_attr:
>>   type                             3
>>   config                           0x400010000
>>   disabled                         1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 40
>> ------------------------------------------------------------
>> perf_event_attr:
>>   type                             3
>>   config                           0x800010000
>>   disabled                         1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
>> sys_perf_event_open failed, error -2
>> running test 52 'intel_pt//u'
>> running test 53 'cycles/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk'
>> running test 54 'cycles//u'
>> FAILED tests/parse-events.c:1457 wrong config
>> Event test failure: test 54 'cycles//u'running test 55 'cycles:k'
>> FAILED tests/parse-events.c:1467 wrong config
>> Event test failure: test 55 'cycles:k'running test 56 'instructions:uep'
>> FAILED tests/parse-events.c:107 wrong number of entries
>> Event test failure: test 56 'instructions:uep'running test 57 '{cycles,cache-misses,branch-misses}:e'
>> FAILED tests/parse-events.c:1309 wrong number of entries
>> Event test failure: test 57 '{cycles,cache-misses,branch-misses}:e'test child finished with -1
>> ---- end ----
>>
>> Parse event definition strings subtest 1: FAILED!
> 
> Thanks! So "wrong number of entries" is the dominant failure and
> should be straightforward to make more PMU agnostic. Tests that are
> tied to a PMU like:
> 
> running test 52 'intel_pt//u'
> 
> succeed and it seems sad to lose coverage of them with this change.
> Overall, I think we should work to remove the hybrid test and make
> sure we get coverage in the general test. That means just skipping the
> test is the wrong thing to do.
> 
> Thanks,
> Ian
> 
>> Thanks,
>>
>> Tinghao
>>>
>>> ---
>>>  tools/perf/tests/parse-events.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
>>> index 71a5cb343311..c6949e458e61 100644
>>> --- a/tools/perf/tests/parse-events.c
>>> +++ b/tools/perf/tests/parse-events.c
>>> @@ -2146,6 +2146,9 @@ static int test_events(const struct evlist_test *events, int cnt)
>>>
>>>  static int test__events2(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>>>  {
>>> +       if (perf_pmu__has_hybrid())
>>> +               return TEST_SKIP;
>>> +
>>>         return test_events(test__events, ARRAY_SIZE(test__events));
>>>  }
>>>
>>> @@ -2421,7 +2424,7 @@ static int test__pmu_events_alias2(struct test_suite *test __maybe_unused,
>>>  static struct test_case tests__parse_events[] = {
>>>         TEST_CASE_REASON("Test event parsing",
>>>                          events2,
>>> -                        "permissions"),
>>> +                        "permissions or hybrid"),
>>>         TEST_CASE_REASON("Test parsing of \"hybrid\" CPU events",
>>>                          hybrid,
>>>                         "not hybrid"),
>>> --
>>> 2.34.1
>>>

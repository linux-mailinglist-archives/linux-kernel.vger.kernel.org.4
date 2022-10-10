Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866DA5F9BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiJJJVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiJJJV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:21:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D1F73A15C;
        Mon, 10 Oct 2022 02:21:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E610C1570;
        Mon, 10 Oct 2022 02:21:31 -0700 (PDT)
Received: from [10.57.3.59] (unknown [10.57.3.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6CD93F881;
        Mon, 10 Oct 2022 02:21:23 -0700 (PDT)
Message-ID: <7dcf8bc5-4182-cf73-59ec-86e113ab2c17@arm.com>
Date:   Mon, 10 Oct 2022 10:21:22 +0100
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
 <cce859cc-f25b-b4e8-70c5-917569aec050@arm.com>
 <Y0PMj4V4MBh4J/ao@leoy-yangtze.lan>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <Y0PMj4V4MBh4J/ao@leoy-yangtze.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2022 08:41, Leo Yan wrote:
> On Thu, Oct 06, 2022 at 04:11:05PM +0100, James Clark wrote:
> 
> [...]
> 
>>>> Before:
>>>>
>>>>   sudo ./perf test coresight -vvv
>>>>   ...
>>>>   Recording trace with system wide mode
>>>>   Looking at perf.data file for dumping branch samples:
>>>>   Looking at perf.data file for reporting branch samples:
>>>>   Looking at perf.data file for instruction samples:
>>>>   CoreSight system wide testing: FAIL
>>>>   ...
>>>>
>>>> After:
>>>>
>>>>   sudo ./perf test coresight -vvv
>>>>   ...
>>>>   Recording trace with system wide mode
>>>>   Looking at perf.data file for dumping branch samples:
>>>>   Looking at perf.data file for reporting branch samples:
>>>>   Looking at perf.data file for instruction samples:
>>>>   CoreSight system wide testing: PASS
>>>>   ...
>>>
>>> Since Arm Juno board has zero timestamp for CoreSight, I don't think
>>> now arm_cs_etm.sh can really work on it.
>>>
>>> If we want to pass the test on Juno board, we need to add option
>>> "--itrace=Zi1000i" for "perf report" and "perf script"; but seems
>>> to me "--itrace=Z..." is not a general case for testing ...
>>
>> Unfortunately I now think that adding the Z option didn't improve
>> anything in Coresight decoding other than removing the warning. I've
>> never seen the zero timestamp issue on Juno though. I thought that was
>> on some Qualcomm device? I'm not getting the warning on this test anyway.
> 
> No, on my Juno-r2 board I can observe the timestamp is always zero
> from CoreSight trace data, this is why everytime I must use
> "--itrace=Zi1000i" for reporting results.

Ah I have r0 which could explain it. But it's good to know that r2 has
that issue. I still wouldn't expect you to have to use the option
though, because it should only make the warning go away.

> 
>> The problem is that timeless mode assumes per thread mode, and in per
>> thread mode there is a separate buffer per thread, so the Coresight
>> channel IDs are ignored. In systemwide mode the channel ID is important
>> to know which CPU the trace came from. If this info is thrown away then
>> not much works correctly.
>>
>> I plan to overhaul the whole decoder and remove all the assumptions
>> about per-thread and timeless mode. It would be better if they were
>> completely separate concepts.
> 
> Okay, good to know this.
> 
> [...]
> 
>>> So here I am suspect that changing to "--itrace=i20i" can allow the test
>>> to pass on Juno board.  Could you confirm for this?
>>
>> On Juno:
>>
>>   ./perf record -e cs_etm// -a -- ls
>>
>> With interval 20, 23 instruction samples are generated:
>>
>>   ./perf report --stdio --itrace=i20i | egrep " +[0-9]+\.[0-9]+% +perf "
>> | wc -l
>>
>>   23
>>
>> With interval 1000, 0 are generated:
>>
>>   ./perf report --stdio --itrace=i1000i | egrep " +[0-9]+\.[0-9]+% +perf
>> " | wc -l
>>
>>   Error:
>>   The perf.data data has no samples!
>>   0
> 
> Thanks for confirmation.  It's a bit weird that your Juno board doesn't
> produce all zeros for timestamp packets.
> 
>> I think the issue is that ls is quite quick to run, so not much trace is
>> generated for Perf. And it just depends on the scheduling which is
>> slightly different on Juno. I don't think it's a bug. On N1SDP there are
>> only 134 samples generated with i1000i, so it could probably end up with
>> a random run generating 0 there too.
> 
> Agreed, changing to smaller interval makes sense for me.
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks for the review Leo

> 
> Thanks,
> Leo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9A765C3DA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjACQXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbjACQWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:22:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C269BC72;
        Tue,  3 Jan 2023 08:22:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E69B1516;
        Tue,  3 Jan 2023 08:22:45 -0800 (PST)
Received: from [10.32.36.24] (e121896.Emea.Arm.com [10.32.36.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA3AD3F71A;
        Tue,  3 Jan 2023 08:21:59 -0800 (PST)
Message-ID: <469f20fe-44c3-6089-796e-2db1b10b95ea@arm.com>
Date:   Tue, 3 Jan 2023 16:21:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/7] perf: Remove duplication around
 EVENT_SOURCE_DEVICE_PATH
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221222160328.3639989-1-james.clark@arm.com>
 <20221222160328.3639989-2-james.clark@arm.com>
 <Y6UUxUEmO1ucwBzV@leoy-yangtze.lan>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <Y6UUxUEmO1ucwBzV@leoy-yangtze.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/12/2022 02:39, Leo Yan wrote:
> On Thu, Dec 22, 2022 at 04:03:21PM +0000, James Clark wrote:
>> The pattern for accessing EVENT_SOURCE_DEVICE_PATH is duplicated in a
>> few places, so add two utility functions to cover it. Also just use
>> perf_pmu__scan_file() instead of pmu_type() which already does the same
>> thing.
>>
>> No functional changes.
> 
> After I read the article: https://lwn.net/Articles/69419/, good to see
> this patch uses scnprintf() to replace snprintf().
> 
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/arch/arm/util/auxtrace.c |   5 +-
>>  tools/perf/arch/x86/util/pmu.c      |  12 +--
>>  tools/perf/util/pmu.c               | 110 +++++++++++-----------------
>>  tools/perf/util/pmu.h               |   5 +-
>>  4 files changed, 49 insertions(+), 83 deletions(-)
>>
>> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
>> index deeb163999ce..3cb4a6a16112 100644
>> --- a/tools/perf/arch/arm/util/auxtrace.c
>> +++ b/tools/perf/arch/arm/util/auxtrace.c
>> @@ -55,17 +55,16 @@ static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
>>  
>>  static struct perf_pmu **find_all_hisi_ptt_pmus(int *nr_ptts, int *err)
>>  {
>> -	const char *sysfs = sysfs__mountpoint();
>>  	struct perf_pmu **hisi_ptt_pmus = NULL;
>>  	struct dirent *dent;
>>  	char path[PATH_MAX];
>>  	DIR *dir = NULL;
>>  	int idx = 0;
>>  
>> -	snprintf(path, PATH_MAX, "%s" EVENT_SOURCE_DEVICE_PATH, sysfs);
>> +	perf_pmu__event_source_devices_scnprintf(path, PATH_MAX);
> 
> Nitpick: since 'path' is an array, a good practice is to use
> 'sizeof(path)' rather than 'PATH_MAX' for passing the length.

Done

[...]

>>  
>> @@ -983,9 +931,14 @@ static struct perf_pmu *pmu_lookup(const char *lookup_name)
>>  
>>  	pmu->cpus = pmu_cpumask(name);
>>  	pmu->name = strdup(name);
>> +
>>  	if (!pmu->name)
>>  		goto err;
>>  
>> +	/* Read type, and ensure that 1 value (type) is successfully assigned */
> 
> Maybe I don't understand well, seems to me a better comment is:
> 
> /* Read type, and ensure that type value is successfully assigned (return 1) */
> 

Changed it in V3. I was trying to portray that the function returns how
many variables were successfully assigned, which is slightly different
to 1 == success. But it's probably clearer your way.

> 
> The rest looks good to me.  With addressing above two comments:

> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks for the review.


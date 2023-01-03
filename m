Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B8565C3D4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbjACQXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238144AbjACQWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:22:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3FEA6244;
        Tue,  3 Jan 2023 08:21:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18EE21570;
        Tue,  3 Jan 2023 08:22:29 -0800 (PST)
Received: from [10.32.36.24] (e121896.Emea.Arm.com [10.32.36.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F57E3F882;
        Tue,  3 Jan 2023 08:21:43 -0800 (PST)
Message-ID: <800a1f42-319c-9098-ef1a-cb1e57159d13@arm.com>
Date:   Tue, 3 Jan 2023 16:21:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/7] perf: Use perf_pmu__open_file() and
 perf_pmu__scan_file()
Content-Language: en-US
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
 <20221222160328.3639989-3-james.clark@arm.com>
 <Y6UkUQ9dcQQwvRpz@leoy-yangtze.lan>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <Y6UkUQ9dcQQwvRpz@leoy-yangtze.lan>
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



On 23/12/2022 03:45, Leo Yan wrote:
> On Thu, Dec 22, 2022 at 04:03:22PM +0000, James Clark wrote:
>> Remove some code that duplicates existing methods. This requires that
>> some consts are removed because one of the existing helper methods takes
>> a struct perf_pmu instead of a name which has a non const name field.
>> But except for the tests, the strings were already non const.
>>
>> No functional changes.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/tests/evsel-roundtrip-name.c |  3 +-
>>  tools/perf/tests/parse-events.c         |  3 +-
>>  tools/perf/util/cputopo.c               |  9 +-----
>>  tools/perf/util/pmu-hybrid.c            | 27 +++-------------
>>  tools/perf/util/pmu-hybrid.h            |  2 +-
>>  tools/perf/util/pmu.c                   | 42 +++++++------------------
>>  tools/perf/util/pmu.h                   |  3 +-
>>  7 files changed, 24 insertions(+), 65 deletions(-)
>>
>> diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
>> index e94fed901992..9bccf177f481 100644
>> --- a/tools/perf/tests/evsel-roundtrip-name.c
>> +++ b/tools/perf/tests/evsel-roundtrip-name.c
>> @@ -103,8 +103,9 @@ static int test__perf_evsel__roundtrip_name_test(struct test_suite *test __maybe
>>  						 int subtest __maybe_unused)
>>  {
>>  	int err = 0, ret = 0;
>> +	char cpu_atom[] = "cpu_atom";
>>  
>> -	if (perf_pmu__has_hybrid() && perf_pmu__hybrid_mounted("cpu_atom"))
>> +	if (perf_pmu__has_hybrid() && perf_pmu__hybrid_mounted(cpu_atom))
> 
> After change the parameter 'name' to non const type in function
> perf_pmu__hybrid_mounted(), at here we still can pass string "cpu_atom"
> without warning, right?  If so, we don't need to define a local
> variable 'cpu_atom'.
> 
> [...]
> 
>> -bool perf_pmu__hybrid_mounted(const char *name)
>> +bool perf_pmu__hybrid_mounted(char *name)
>>  {
>> -	char path[PATH_MAX];
>> -	const char *sysfs;
>> -	FILE *file;
>> -	int n, cpu;
>> +	int cpu;
>> +	struct perf_pmu pmu = {.name = name};
>>  
>>  	if (strncmp(name, "cpu_", 4))
>>  		return false;
>>  
>> -	sysfs = sysfs__mountpoint();
>> -	if (!sysfs)
>> -		return false;
>> -
>> -	snprintf(path, PATH_MAX, CPUS_TEMPLATE_CPU, sysfs, name);
>> -	if (!file_available(path))
>> -		return false;
>> -
>> -	file = fopen(path, "r");
>> -	if (!file)
>> -		return false;
>> -
>> -	n = fscanf(file, "%u", &cpu);
>> -	fclose(file);
>> -	if (n <= 0)
>> -		return false;
>> -
>> -	return true;
>> +	return perf_pmu__scan_file(&pmu, "cpus", "%u", &cpu) > 0;
> 
> It's not necessarily to change the parameter 'name' to non const type,
> we can handle this case in two different ways.
> 
> The first option is to refine the code with using the function
> perf_pmu__pathname_scnprintf() which is introduced in patch 01, thus
> we can keep using fopen() and fscanf() to read out value from 'cpus'
> entry.
> 
> Another option is to define a local array 'pmu_name[PATH_MAX]' and
> then copy the input string to this array, something like:
> 
> bool perf_pmu__hybrid_mounted(const char *name)
> {
>   char pmu_name[PATH_MAX];
>   struct perf_pmu pmu;
>   int cpu;
> 
>   strncpy(pmu_name, name, sizeof(pmu_name));
>   pmu.name = pmu_name;
> 
>   return perf_pmu__scan_file(&pmu, "cpus", "%u", &cpu) > 0;
> }
> 
> We even can consider to dynamically allocate buffer and copy string from
> 'name' to the allocated buffer.
> 

I went with the string copy way and put the consts back in V3. One minor
difference is that I had to use strlcpy() instead of strncpy() to avoid
a compiler warning about the destination buffer being the same size.

James

[...]

>> -static struct perf_cpu_map *pmu_cpumask(const char *name)
>> +static struct perf_cpu_map *pmu_cpumask(char *name)
>>  {
>> -	char path[PATH_MAX];
>>  	struct perf_cpu_map *cpus;
>> -	const char *sysfs = sysfs__mountpoint();
>>  	const char *templates[] = {
>> -		CPUS_TEMPLATE_UNCORE,
>> -		CPUS_TEMPLATE_CPU,
>> +		"cpumask",
>> +		"cpus",
>>  		NULL
>>  	};
>>  	const char **template;
>> -
>> -	if (!sysfs)
>> -		return NULL;
>> +	struct perf_pmu pmu = {.name = name};
> 
> Here we also can define a local array and copy string from 'name' to
> the local array.  This can allow us to provide a friendly function and
> caller doesn't need to explictly pass non const string.
> 

Done


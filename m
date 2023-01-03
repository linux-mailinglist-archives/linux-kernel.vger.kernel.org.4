Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DCF65C3D8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbjACQX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238107AbjACQWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:22:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F7BF10B4A;
        Tue,  3 Jan 2023 08:22:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5D5C152B;
        Tue,  3 Jan 2023 08:22:58 -0800 (PST)
Received: from [10.32.36.24] (e121896.Emea.Arm.com [10.32.36.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02EE43F71A;
        Tue,  3 Jan 2023 08:22:12 -0800 (PST)
Message-ID: <150442e1-4717-2b18-8f7d-febbd95ae570@arm.com>
Date:   Tue, 3 Jan 2023 16:22:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 4/7] perf pmu: Add function to check if a pmu file
 exists
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com, German Gomez <german.gomez@arm.com>,
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
 <20221222160328.3639989-5-james.clark@arm.com>
 <Y6VKEfsGu0Pteb8e@leoy-yangtze.lan>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <Y6VKEfsGu0Pteb8e@leoy-yangtze.lan>
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



On 23/12/2022 06:26, Leo Yan wrote:
> On Thu, Dec 22, 2022 at 04:03:24PM +0000, James Clark wrote:
>> From: German Gomez <german.gomez@arm.com>
>>
>> Add a utility function perf_pmu__file_exists() to check if a given pmu
>> file exists in the sysfs filesystem.
>>
>> Signed-off-by: German Gomez <german.gomez@arm.com>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/util/pmu.c | 14 ++++++++++++++
>>  tools/perf/util/pmu.h |  2 ++
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 15b852b3c401..b72b2d892949 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -1739,6 +1739,20 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
>>  	return ret;
>>  }
>>  
>> +bool perf_pmu__file_exists(struct perf_pmu *pmu, const char *name)
>> +{
>> +	char path[PATH_MAX];
>> +	struct stat statbuf;
>> +
>> +	if (!perf_pmu__pathname_scnprintf(path, PATH_MAX, pmu->name, name))
>> +		return false;
>> +
>> +	if (!file_available(path))
>> +		return false;
>> +
>> +	return stat(path, &statbuf) == 0;
> 
> Can we simply return the returned value from file_available() and skip
> calling stat()?  Because file_available() invokes access() to detect if
> a file is existed or not, so here calling stat() is redundant.
> 

Yep that works. Fixed in V3.

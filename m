Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954D4673F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjASQuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjASQuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:50:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A88276A4C;
        Thu, 19 Jan 2023 08:50:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2F2C176A;
        Thu, 19 Jan 2023 08:50:45 -0800 (PST)
Received: from [10.57.47.54] (unknown [10.57.47.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D4403F445;
        Thu, 19 Jan 2023 08:50:01 -0800 (PST)
Message-ID: <17f226e1-271e-e16d-596a-a0fb955de586@arm.com>
Date:   Thu, 19 Jan 2023 16:49:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 6/8] perf cs_etm: Record ts_source in AUXTRACE_INFO for
 ETMv4 and ETE
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com, German Gomez <german.gomez@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        leo.yan@linaro.org, mike.leach@linaro.org
References: <20230119154308.3815108-1-james.clark@arm.com>
 <20230119154308.3815108-7-james.clark@arm.com>
 <fb6564d3-c3a2-08c1-32c5-79ba22c69200@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <fb6564d3-c3a2-08c1-32c5-79ba22c69200@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/01/2023 15:56, Suzuki K Poulose wrote:
> On 19/01/2023 15:43, James Clark wrote:
>> From: German Gomez <german.gomez@arm.com>
>>
>> Read the value of ts_source exposed by the driver and store it in the
>> ETMv4 and ETE header. If the interface doesn't exist (such as in older
>> Kernels), defaults to a safe value of -1.
> 
> Super minor nits feel free to ignore.
> 
>>
>> Signed-off-by: German Gomez <german.gomez@arm.com>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   tools/perf/arch/arm/util/cs-etm.c | 48 +++++++++++++++++++++++++++++++
>>   tools/perf/util/cs-etm-base.c     |  2 ++
>>   tools/perf/util/cs-etm.h          |  2 ++
>>   3 files changed, 52 insertions(+)
>>
>> diff --git a/tools/perf/arch/arm/util/cs-etm.c
>> b/tools/perf/arch/arm/util/cs-etm.c
>> index b526ffe550a5..481e170cd3f1 100644
>> --- a/tools/perf/arch/arm/util/cs-etm.c
>> +++ b/tools/perf/arch/arm/util/cs-etm.c
>> @@ -53,6 +53,7 @@ static const char * const metadata_etmv4_ro[] = {
>>       [CS_ETMV4_TRCIDR2]        = "trcidr/trcidr2",
>>       [CS_ETMV4_TRCIDR8]        = "trcidr/trcidr8",
>>       [CS_ETMV4_TRCAUTHSTATUS]    = "mgmt/trcauthstatus",
>> +    [CS_ETMV4_TS_SOURCE]        = "ts_source",
>>   };
>>     static const char * const metadata_ete_ro[] = {
>> @@ -62,6 +63,7 @@ static const char * const metadata_ete_ro[] = {
>>       [CS_ETE_TRCIDR8]        = "trcidr/trcidr8",
>>       [CS_ETE_TRCAUTHSTATUS]        = "mgmt/trcauthstatus",
>>       [CS_ETE_TRCDEVARCH]        = "mgmt/trcdevarch",
>> +    [CS_ETE_TS_SOURCE]        = "ts_source",
>>   };
>>     static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
>> @@ -613,6 +615,32 @@ static int cs_etm_get_ro(struct perf_pmu *pmu,
>> int cpu, const char *path)
>>       return val;
>>   }
>>   +static int cs_etm_get_ro_signed(struct perf_pmu *pmu, int cpu,
>> const char *path)
> 
> minor nit: This doesn't necessarily care if it is RO ?
> Also, does it make sense to rename to include cpu relation :
> 
> say,  cs_etm_pmu_cpu_get_signed() ?
> 
>> +{
>> +    char pmu_path[PATH_MAX];
>> +    int scan;
>> +    int val = 0;
>> +
>> +    /* Get RO metadata from sysfs */
>> +    snprintf(pmu_path, PATH_MAX, "cpu%d/%s", cpu, path);
>> +
>> +    scan = perf_pmu__scan_file(pmu, pmu_path, "%d", &val);
>> +    if (scan != 1)
>> +        pr_err("%s: error reading: %s\n", __func__, pmu_path);
>> +
>> +    return val;
>> +}
>> +
>> +static bool cs_etm_pmu_path_exists(struct perf_pmu *pmu, int cpu,
>> const char *path)
> 
> nit: cs_etm_pmu_cpu_path_exists() ? To make the "cpu" relation explicit ?
> 

For both of these points, I think it was just trying to be consistent
with what is already there.

There is already cs_etm_is_etmv4() and cs_etm_get_ro() which don't
mention the cpu part, and also the metadata_etmv4_ro variable which has
_ro. You're right that it doesn't matter that they're read only, but at
the moment everything is so it's probably easiest to leave it for now
rather than go and update everything.


> Otherwise looks good to me.
> 
> Suzuki
> 

Thanks for the review.

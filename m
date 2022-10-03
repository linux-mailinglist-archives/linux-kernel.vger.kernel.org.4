Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6F25F2E52
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiJCJn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiJCJm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:42:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8A385E647;
        Mon,  3 Oct 2022 02:37:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 233C513D5;
        Mon,  3 Oct 2022 02:37:36 -0700 (PDT)
Received: from [10.57.65.226] (unknown [10.57.65.226])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B28833F792;
        Mon,  3 Oct 2022 02:37:27 -0700 (PDT)
Message-ID: <8f865045-aa95-46b6-a455-c3d9c6d26494@arm.com>
Date:   Mon, 3 Oct 2022 10:37:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v3 04/13] coresight: etm4x: Update ETM4 driver to use
 Trace ID API
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20220809223401.24599-1-mike.leach@linaro.org>
 <20220809223401.24599-5-mike.leach@linaro.org>
 <01570ba2-81c9-e4b5-6669-0e4087a4bd1f@arm.com>
In-Reply-To: <01570ba2-81c9-e4b5-6669-0e4087a4bd1f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2022 10:31, Suzuki K Poulose wrote:
> On 09/08/2022 23:33, Mike Leach wrote:
>> The trace ID API is now used to allocate trace IDs for ETM4.x / ETE
>> devices.
>>
>> For perf sessions, these will be allocated on enable, and released on
>> disable.
>>
>> For sysfs sessions, these will be allocated on enable, but only released
>> on reset. This allows the sysfs session to interrogate the Trace ID used
>> after the session is over - maintaining functional consistency with the
>> previous allocation scheme.
>>
>> The trace ID will also be allocated on read of the mgmt/trctraceid file.
>> This ensures that if perf or sysfs read this before enabling trace, the
>> value will be the one used for the trace session.
>>
>> Trace ID initialisation is removed from the _probe() function.
>>
>> Signed-off-by: Mike Leach <mike.leach@linaro.org>
>> ---
>>   .../coresight/coresight-etm4x-core.c          | 79 +++++++++++++++++--
>>   .../coresight/coresight-etm4x-sysfs.c         | 27 ++++++-
>>   drivers/hwtracing/coresight/coresight-etm4x.h |  3 +
>>   3 files changed, 100 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c 
>> b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index cf249ecad5a5..b4fb28ce89fd 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -42,6 +42,7 @@
>>   #include "coresight-etm4x-cfg.h"
>>   #include "coresight-self-hosted-trace.h"
>>   #include "coresight-syscfg.h"
>> +#include "coresight-trace-id.h"
>>   static int boot_enable;
>>   module_param(boot_enable, int, 0444);
>> @@ -234,6 +235,50 @@ static int etm4_trace_id(struct coresight_device 
>> *csdev)
>>       return drvdata->trcid;
>>   }
>> +int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata)
>> +{
>> +    int trace_id;
>> +
>> +    /*
>> +     * This will allocate a trace ID to the cpu,
>> +     * or return the one currently allocated.
>> +     */
>> +    /* trace id function has its own lock */
>> +    trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
>> +    if (IS_VALID_ID(trace_id))
>> +        drvdata->trcid = (u8)trace_id;
>> +    else
>> +        dev_err(&drvdata->csdev->dev,
>> +            "Failed to allocate trace ID for %s on CPU%d\n",
>> +            dev_name(&drvdata->csdev->dev), drvdata->cpu);
>> +    return trace_id;
>> +}
>> +
>> +static int etm4_set_current_trace_id(struct etmv4_drvdata *drvdata)
>> +{
>> +    int trace_id;
>> +
>> +    /*
>> +     * Set the currently allocated trace ID - perf allocates IDs
>> +     * as part of setup_aux for all CPUs it may use.
>> +     */
>> +    trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu);
>> +    if (IS_VALID_ID(trace_id)) {
>> +        drvdata->trcid = (u8)trace_id;
>> +        return 0;
>> +    }
>> +
>> +    dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on 
>> CPU%d\n",
>> +        dev_name(&drvdata->csdev->dev), drvdata->cpu);
>> +
>> +    return -EINVAL;
>> +}
> 
> 
>> +
>> +void etm4_release_trace_id(struct etmv4_drvdata *drvdata)
>> +{
>> +    coresight_trace_id_put_cpu_id(drvdata->cpu);
>> +}
>> +
>>   struct etm4_enable_arg {
>>       struct etmv4_drvdata *drvdata;
>>       int rc;
>> @@ -729,6 +774,15 @@ static int etm4_enable_perf(struct 
>> coresight_device *csdev,
>>       ret = etm4_parse_event_config(csdev, event);
>>       if (ret)
>>           goto out;
>> +
>> +    /*
>> +     * perf allocates cpu ids as part of setup - device needs to use
>> +     * the allocated ID.
>> +     */
>> +    ret = etm4_set_current_trace_id(drvdata);
> 
> So, when do we allocate an id in perf mode ? As far as I can see, this
> should be the same as etm4_read_alloc_trace_id() ? Why are they any
> different ?
> 
>> +    if (ret < 0)
>> +        goto out;
>> +
>>       /* And enable it */
>>       ret = etm4_enable_hw(drvdata);
>> @@ -753,6 +807,11 @@ static int etm4_enable_sysfs(struct 
>> coresight_device *csdev)
>>       spin_lock(&drvdata->spinlock);
>> +    /* sysfs needs to read and allocate a trace ID */
>> +    ret = etm4_read_alloc_trace_id(drvdata);
>> +    if (ret < 0)
>> +        goto unlock_sysfs_enable;
>> +
>>       /*
>>        * Executing etm4_enable_hw on the cpu whose ETM is being enabled
>>        * ensures that register writes occur when cpu is powered.
>> @@ -764,6 +823,11 @@ static int etm4_enable_sysfs(struct 
>> coresight_device *csdev)
>>           ret = arg.rc;
>>       if (!ret)
>>           drvdata->sticky_enable = true;
>> +
>> +    if (ret)
>> +        etm4_release_trace_id(drvdata);
>> +
>> +unlock_sysfs_enable:
>>       spin_unlock(&drvdata->spinlock);
>>       if (!ret)
>> @@ -895,6 +959,8 @@ static int etm4_disable_perf(struct 
>> coresight_device *csdev,
>>       /* TRCVICTLR::SSSTATUS, bit[9] */
>>       filters->ssstatus = (control & BIT(9));
>> +    /* The perf event will release trace ids when it is destroyed */
>> +
> 
> At this patch level, there is no release of trace id ? Is that missed in
> this patch ? Or am I missing something ?

I think the above change only comes in PATCH 7. May be that patch needs 
to be rearranged in order ? Otherwise git-bisect can break running a 
perf session on cs_etm, with missing traceid.

Suzuki

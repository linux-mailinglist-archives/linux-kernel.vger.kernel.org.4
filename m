Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B69D621F40
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiKHW3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiKHW3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:29:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C393166C8A;
        Tue,  8 Nov 2022 14:25:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA8F11FB;
        Tue,  8 Nov 2022 14:25:54 -0800 (PST)
Received: from [10.57.68.207] (unknown [10.57.68.207])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBD4D3F73D;
        Tue,  8 Nov 2022 14:25:46 -0800 (PST)
Message-ID: <bffacfbb-9623-4aa9-a3f7-6c850b8941bc@arm.com>
Date:   Tue, 8 Nov 2022 22:25:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v5 06/14] coresight: etm3x: Update ETM3 driver to use
 Trace ID API
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20221101163103.17921-1-mike.leach@linaro.org>
 <20221101163103.17921-7-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20221101163103.17921-7-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2022 16:30, Mike Leach wrote:
> Use the TraceID API to allocate ETM trace IDs dynamically.
> 
> As with the etm4x we allocate on enable / disable for perf,
> allocate on enable / reset for sysfs.
> 
> Additionally we allocate on sysfs file read as both perf and sysfs
> can read the ID before enabling the hardware.
> 
> Remove sysfs option to write trace ID - which is inconsistent with
> both the dynamic allocation method and the fixed allocation method
> previously used.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-etm.h   |  2 +
>   .../coresight/coresight-etm3x-core.c          | 69 +++++++++++++++++--
>   .../coresight/coresight-etm3x-sysfs.c         | 27 ++------
>   3 files changed, 72 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
> index f3ab96eaf44e..3667428d38b6 100644
> --- a/drivers/hwtracing/coresight/coresight-etm.h
> +++ b/drivers/hwtracing/coresight/coresight-etm.h
> @@ -287,4 +287,6 @@ int etm_get_trace_id(struct etm_drvdata *drvdata);
>   void etm_set_default(struct etm_config *config);
>   void etm_config_trace_mode(struct etm_config *config);
>   struct etm_config *get_etm_config(struct etm_drvdata *drvdata);
> +int etm_read_alloc_trace_id(struct etm_drvdata *drvdata);
> +void etm_release_trace_id(struct etm_drvdata *drvdata);
>   #endif
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index d0ab9933472b..9a7a9e974d41 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -32,6 +32,7 @@
>   
>   #include "coresight-etm.h"
>   #include "coresight-etm-perf.h"
> +#include "coresight-trace-id.h"
>   
>   /*
>    * Not really modular but using module_param is the easiest way to
> @@ -490,16 +491,59 @@ static int etm_trace_id(struct coresight_device *csdev)
>   	return etm_get_trace_id(drvdata);
>   }
>   
> +int etm_read_alloc_trace_id(struct etm_drvdata *drvdata)
> +{
> +	int trace_id;
> +
> +	/*
> +	 * This will allocate a trace ID to the cpu,
> +	 * or return the one currently allocated.
> +	 *
> +	 * trace id function has its own lock
> +	 */
> +	trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
> +	if (IS_VALID_ID(trace_id))
> +		drvdata->traceid = (u8)trace_id;
> +	else
> +		dev_err(&drvdata->csdev->dev,
> +			"Failed to allocate trace ID for %s on CPU%d\n",
> +			dev_name(&drvdata->csdev->dev), drvdata->cpu);
> +	return trace_id;
> +}
> +
> +void etm_release_trace_id(struct etm_drvdata *drvdata)
> +{
> +	coresight_trace_id_put_cpu_id(drvdata->cpu);
> +}
> +
>   static int etm_enable_perf(struct coresight_device *csdev,
>   			   struct perf_event *event)
>   {
>   	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	int trace_id;
>   
>   	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
>   		return -EINVAL;
>   
>   	/* Configure the tracer based on the session's specifics */
>   	etm_parse_event_config(drvdata, event);
> +
> +	/*
> +	 * perf allocates cpu ids as part of _setup_aux() - device needs to use
> +	 * the allocated ID. This reads the current version without allocation.
> +	 *
> +	 * This does not use the trace id lock to prevent lock_dep issues
> +	 * with perf locks - we know the ID cannot change until perf shuts down
> +	 * the session
> +	 */
> +	trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu);
> +	if (!IS_VALID_ID(trace_id)) {
> +		dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on CPU%d\n",
> +			dev_name(&drvdata->csdev->dev), drvdata->cpu);
> +		return -EINVAL;
> +	}
> +	drvdata->traceid = (u8)trace_id;
> +
>   	/* And enable it */
>   	return etm_enable_hw(drvdata);
>   }
> @@ -512,6 +556,11 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
>   
>   	spin_lock(&drvdata->spinlock);
>   
> +	/* sysfs needs to allocate and set a trace ID */
> +	ret = etm_read_alloc_trace_id(drvdata);
> +	if (ret < 0)
> +		goto unlock_enable_sysfs;
> +
>   	/*
>   	 * Configure the ETM only if the CPU is online.  If it isn't online
>   	 * hw configuration will take place on the local CPU during bring up.
> @@ -528,6 +577,10 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
>   		ret = -ENODEV;
>   	}
>   
> +	if (ret)
> +		etm_release_trace_id(drvdata);
> +
> +unlock_enable_sysfs:
>   	spin_unlock(&drvdata->spinlock);
>   
>   	if (!ret)
> @@ -611,6 +664,9 @@ static void etm_disable_perf(struct coresight_device *csdev)
>   	coresight_disclaim_device_unlocked(csdev);
>   
>   	CS_LOCK(drvdata->base);
> +
> +	/* perf will release trace ids when _free_aux() is called at the end of the session */

Minor nit: Please split the line.

With that

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC8F621F3E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiKHW2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiKHW2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:28:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97F3668ADB;
        Tue,  8 Nov 2022 14:25:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D57701FB;
        Tue,  8 Nov 2022 14:24:37 -0800 (PST)
Received: from [10.57.68.207] (unknown [10.57.68.207])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CC4E3F73D;
        Tue,  8 Nov 2022 14:24:29 -0800 (PST)
Message-ID: <ce50327b-d42c-713f-2529-74eac8d1e5b9@arm.com>
Date:   Tue, 8 Nov 2022 22:24:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v5 05/14] coresight: etm4x: Update ETM4 driver to use
 Trace ID API
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20221101163103.17921-1-mike.leach@linaro.org>
 <20221101163103.17921-6-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20221101163103.17921-6-mike.leach@linaro.org>
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
> The trace ID API is now used to allocate trace IDs for ETM4.x / ETE
> devices.
> 
> For perf sessions, these will be allocated on enable, and released on
> disable.
> 
> For sysfs sessions, these will be allocated on enable, but only released
> on reset. This allows the sysfs session to interrogate the Trace ID used
> after the session is over - maintaining functional consistency with the
> previous allocation scheme.
> 
> The trace ID will also be allocated on read of the mgmt/trctraceid file.
> This ensures that if perf or sysfs read this before enabling trace, the
> value will be the one used for the trace session.
> 
> Trace ID initialisation is removed from the _probe() function.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   .../coresight/coresight-etm4x-core.c          | 70 +++++++++++++++++--
>   .../coresight/coresight-etm4x-sysfs.c         | 27 ++++++-
>   drivers/hwtracing/coresight/coresight-etm4x.h |  3 +
>   3 files changed, 90 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 80fefaba58ee..0e361d35c611 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -42,6 +42,7 @@
>   #include "coresight-etm4x-cfg.h"
>   #include "coresight-self-hosted-trace.h"
>   #include "coresight-syscfg.h"
> +#include "coresight-trace-id.h"
>   
>   static int boot_enable;
>   module_param(boot_enable, int, 0444);
> @@ -234,6 +235,30 @@ static int etm4_trace_id(struct coresight_device *csdev)
>   	return drvdata->trcid;
>   }
>   
> +int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata)
> +{
> +	int trace_id;
> +
> +	/*
> +	 * This will allocate a trace ID to the cpu,
> +	 * or return the one currently allocated.
> +	 * The trace id function has its own lock
> +	 */
> +	trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
> +	if (IS_VALID_ID(trace_id))
> +		drvdata->trcid = (u8)trace_id;
> +	else
> +		dev_err(&drvdata->csdev->dev,
> +			"Failed to allocate trace ID for %s on CPU%d\n",
> +			dev_name(&drvdata->csdev->dev), drvdata->cpu);
> +	return trace_id;
> +}
> +
> +void etm4_release_trace_id(struct etmv4_drvdata *drvdata)
> +{
> +	coresight_trace_id_put_cpu_id(drvdata->cpu);
> +}
> +
>   struct etm4_enable_arg {
>   	struct etmv4_drvdata *drvdata;
>   	int rc;
> @@ -717,7 +742,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   static int etm4_enable_perf(struct coresight_device *csdev,
>   			    struct perf_event *event)
>   {
> -	int ret = 0;
> +	int ret = 0, trace_id;
>   	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>   
>   	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id())) {
> @@ -729,6 +754,24 @@ static int etm4_enable_perf(struct coresight_device *csdev,
>   	ret = etm4_parse_event_config(csdev, event);
>   	if (ret)
>   		goto out;
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
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	drvdata->trcid = (u8)trace_id;
> +
>   	/* And enable it */
>   	ret = etm4_enable_hw(drvdata);
>   
> @@ -753,6 +796,11 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
>   
>   	spin_lock(&drvdata->spinlock);
>   
> +	/* sysfs needs to read and allocate a trace ID */
> +	ret = etm4_read_alloc_trace_id(drvdata);
> +	if (ret < 0)
> +		goto unlock_sysfs_enable;
> +
>   	/*
>   	 * Executing etm4_enable_hw on the cpu whose ETM is being enabled
>   	 * ensures that register writes occur when cpu is powered.
> @@ -764,6 +812,11 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
>   		ret = arg.rc;
>   	if (!ret)
>   		drvdata->sticky_enable = true;
> +
> +	if (ret)
> +		etm4_release_trace_id(drvdata);
> +
> +unlock_sysfs_enable:
>   	spin_unlock(&drvdata->spinlock);
>   
>   	if (!ret)
> @@ -895,6 +948,8 @@ static int etm4_disable_perf(struct coresight_device *csdev,
>   	/* TRCVICTLR::SSSTATUS, bit[9] */
>   	filters->ssstatus = (control & BIT(9));
>   
> +	/* perf will release trace ids when _free_aux() is called at the end of the session */

minor nit: Please split this to multi-line.

With that:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


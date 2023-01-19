Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F244B67364C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjASLDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjASLCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:02:48 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0666F47EC9;
        Thu, 19 Jan 2023 03:02:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4968E176A;
        Thu, 19 Jan 2023 03:03:26 -0800 (PST)
Received: from [10.57.75.229] (unknown [10.57.75.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8DC43F71A;
        Thu, 19 Jan 2023 03:02:42 -0800 (PST)
Message-ID: <b14b7507-e20a-2223-b772-fc865e5c9558@arm.com>
Date:   Thu, 19 Jan 2023 11:02:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v7 13/15] coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID
 used for Trace ID
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20230116124928.5440-1-mike.leach@linaro.org>
 <20230116124928.5440-14-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230116124928.5440-14-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike

On 16/01/2023 12:49, Mike Leach wrote:
> Use the perf_report_aux_output_id() call to output the CoreSight trace ID
> and associated CPU as a PERF_RECORD_AUX_OUTPUT_HW_ID record in the
> perf.data file.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c |  7 +++++++
>   include/linux/coresight-pmu.h                    | 14 ++++++++++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index bdb9ab86173a..12fff661456e 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -4,6 +4,7 @@
>    * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>    */
>   
> +#include <linux/bitfield.h>
>   #include <linux/coresight.h>
>   #include <linux/coresight-pmu.h>
>   #include <linux/cpumask.h>
> @@ -448,6 +449,7 @@ static void etm_event_start(struct perf_event *event, int flags)
>   	struct perf_output_handle *handle = &ctxt->handle;
>   	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
>   	struct list_head *path;
> +	u64 hw_id;
>   
>   	if (!csdev)
>   		goto fail;
> @@ -493,6 +495,11 @@ static void etm_event_start(struct perf_event *event, int flags)
>   	if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
>   		goto fail_disable_path;
>   
> +	/* output cpu / trace ID in perf record */
> +	hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK, CS_AUX_HW_ID_CURR_VERSION);
> +	hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, coresight_trace_id_read_cpu_id(cpu));
> +	perf_report_aux_output_id(event, hw_id);
> +

One minor nit:

This ends up putting the HWID packet for every single time the event is 
scheduled on the CPU and thus we have :

$ perf report -D | grep OUTPUT_HW_ID
...
AUX_OUTPUT_HW_ID events:         55  (18.3%)

We could do the above step only once per CPU for the lifetime of the 
event by book keeping the info in event_data. With that we get, one
record per CPU and:

$ perf report -D | grep OUTPUT_HW_ID
...
AUX_OUTPUT_HW_ID events:          5  ( 1.9%)

Here is a quick patch. We can queue this separately if you all are Ok 
with this. Thoughts ?

---8>---

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c 
b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 12fff661456e..5335f3a2b010 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -495,10 +495,16 @@ static void etm_event_start(struct perf_event 
*event, int flags)
         if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
                 goto fail_disable_path;

-       /* output cpu / trace ID in perf record */
-       hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK, 
CS_AUX_HW_ID_CURR_VERSION);
-       hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, 
coresight_trace_id_read_cpu_id(cpu));
-       perf_report_aux_output_id(event, hw_id);
+       /*
+        * output cpu / trace ID in perf record, once for the lifetime
+        * of the event.
+        */
+       if (!cpumask_test_cpu(cpu, &event_data->aux_hwid_done)) {
+               cpumask_set_cpu(cpu, &event_data->aux_hwid_done);
+               hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK, 
CS_AUX_HW_ID_CURR_VERSION);
+               hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, 
coresight_trace_id_read_cpu_id(cpu));
+               perf_report_aux_output_id(event, hw_id);
+       }

  out:
         /* Tell the perf core the event is alive */
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h 
b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 468f7799ab4f..9b11bb3d96d9 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -55,6 +55,7 @@ struct etm_filters {
  struct etm_event_data {
         struct work_struct work;
         cpumask_t mask;
+       cpumask_t aux_hwid_done;
         void *snk_config;
         u32 cfg_hash;
         struct list_head * __percpu *path;



>   out:
>   	/* Tell the perf core the event is alive */
>   	event->hw.state = 0;
> diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> index 624f4843453e..51ac441a37c3 100644
> --- a/include/linux/coresight-pmu.h
> +++ b/include/linux/coresight-pmu.h
> @@ -7,6 +7,8 @@
>   #ifndef _LINUX_CORESIGHT_PMU_H
>   #define _LINUX_CORESIGHT_PMU_H
>   
> +#include <linux/bits.h>
> +
>   #define CORESIGHT_ETM_PMU_NAME "cs_etm"
>   
>   /*
> @@ -43,4 +45,16 @@
>   #define ETM4_CFG_BIT_RETSTK	12
>   #define ETM4_CFG_BIT_VMID_OPT	15
>   
> +/*
> + * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
> + * Used to associate a CPU with the CoreSight Trace ID.
> + * [07:00] - Trace ID - uses 8 bits to make value easy to read in file.
> + * [59:08] - Unused (SBZ)
> + * [63:60] - Version
> + */
> +#define CS_AUX_HW_ID_TRACE_ID_MASK	GENMASK_ULL(7, 0)
> +#define CS_AUX_HW_ID_VERSION_MASK	GENMASK_ULL(63, 60)
> +
> +#define CS_AUX_HW_ID_CURR_VERSION 0
> +
>   #endif


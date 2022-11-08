Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7865621F86
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiKHWtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKHWtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:49:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 692286035B;
        Tue,  8 Nov 2022 14:49:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56F2F1FB;
        Tue,  8 Nov 2022 14:49:25 -0800 (PST)
Received: from [10.57.68.207] (unknown [10.57.68.207])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83CFB3F703;
        Tue,  8 Nov 2022 14:49:17 -0800 (PST)
Message-ID: <994b80f8-5c92-f82c-d43a-cc24fb002c98@arm.com>
Date:   Tue, 8 Nov 2022 22:49:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v5 13/14] coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID
 used for Trace ID
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20221101163103.17921-1-mike.leach@linaro.org>
 <20221101163103.17921-14-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20221101163103.17921-14-mike.leach@linaro.org>
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

On 01/11/2022 16:31, Mike Leach wrote:
> Use the perf_report_aux_output_id() call to output the CoreSight trace ID
> and associated CPU as a PERF_RECORD_AUX_OUTPUT_HW_ID record in the
> perf.data file.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c |  7 +++++++
>   include/linux/coresight-pmu.h                    | 14 ++++++++++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 6166f716a6ac..59a2ad95c1dc 100644
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
> +	hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK, CS_AUX_HW_ID_CURR_VERSION) |
> +		FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, coresight_trace_id_read_cpu_id(cpu));

super minor nit: You may split this for better readability.

	traceid = coresight_trace_id_read_cpu_id(cpu);

	hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK, CS_AUX_HW_ID_CURR_VERSION);
	hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, traceid);


Either ways,

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943DE66C259
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjAPOiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjAPOiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:38:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BAE92FCF6;
        Mon, 16 Jan 2023 06:17:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77F94C14;
        Mon, 16 Jan 2023 06:17:24 -0800 (PST)
Received: from [10.57.89.182] (unknown [10.57.89.182])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE3B43F67D;
        Mon, 16 Jan 2023 06:16:40 -0800 (PST)
Message-ID: <1896a73b-eb7b-7ffb-272d-115a10adeb71@arm.com>
Date:   Mon, 16 Jan 2023 14:16:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v7 01/15] coresight: trace-id: Add API to dynamically
 assign Trace ID values
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20230116124928.5440-1-mike.leach@linaro.org>
 <20230116124928.5440-2-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230116124928.5440-2-mike.leach@linaro.org>
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
> The existing mechanism to assign Trace ID values to sources is limited
> and does not scale for larger multicore / multi trace source systems.
> 
> The API introduces functions that reserve IDs based on availabilty
> represented by a coresight_trace_id_map structure. This records the
> used and free IDs in a bitmap.
> 
> CPU bound sources such as ETMs use the coresight_trace_id_get_cpu_id
> coresight_trace_id_put_cpu_id pair of functions. The API will record
> the ID associated with the CPU. This ensures that the same ID will be
> re-used while perf events are active on the CPU. The put_cpu_id function
> will pend release of the ID until all perf cs_etm sessions are complete.
> 
> For backward compatibility the functions will attempt to use the same
> CPU IDs as the legacy system would have used if these are still available.
> 
> Non-cpu sources, such as the STM can use coresight_trace_id_get_system_id /
> coresight_trace_id_put_system_id.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   drivers/hwtracing/coresight/Makefile          |   2 +-
>   .../hwtracing/coresight/coresight-trace-id.c  | 265 ++++++++++++++++++
>   .../hwtracing/coresight/coresight-trace-id.h  | 156 +++++++++++
>   include/linux/coresight-pmu.h                 |  10 +
>   4 files changed, 432 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
>   create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h
> 
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index b6c4a48140ec..329a0c704b87 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -6,7 +6,7 @@ obj-$(CONFIG_CORESIGHT) += coresight.o
>   coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
>   		coresight-sysfs.o coresight-syscfg.o coresight-config.o \
>   		coresight-cfg-preload.o coresight-cfg-afdo.o \
> -		coresight-syscfg-configfs.o
> +		coresight-syscfg-configfs.o coresight-trace-id.o
>   obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
>   coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
>   		      coresight-tmc-etr.o
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> new file mode 100644
> index 000000000000..9b85c376cb12
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> @@ -0,0 +1,265 @@
> +// SPDX-License-Identifier: GPL-2.0

...

> +int coresight_trace_id_read_cpu_id(int cpu)
> +{
> +	return _coresight_trace_id_read_cpu_id(cpu);
> +}
> +EXPORT_SYMBOL_GPL(coresight_trace_id_read_cpu_id);
> +
> +int coresight_trace_id_get_system_id(void)
> +{
> +	return coresight_trace_id_map_get_system_id(&id_map_default);
> +}
> +EXPORT_SYMBOL_GPL(coresight_trace_id_get_system_id);
> +
> +void coresight_trace_id_put_system_id(int id)
> +{
> +	coresight_trace_id_map_put_system_id(&id_map_default, id);
> +}
> +EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
> +
> +void coresight_trace_id_perf_start(void)
> +{
> +	atomic_inc(&perf_cs_etm_session_active);
> +}
> +EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
> +
> +void coresight_trace_id_perf_stop(void)
> +{
> +	if (!atomic_dec_return(&perf_cs_etm_session_active))
> +		coresight_trace_id_release_all_pending();
> +}
> +EXPORT_SYMBOL_GPL(coresight_trace_id_perf_stop);
> +

This blank new line at the end of the file generates a checkpatch
warning for me. I have fixed it locally and applied it.

> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h



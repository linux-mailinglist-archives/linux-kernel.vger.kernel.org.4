Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C1A5F2CBD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJCJEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJCJDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:03:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62B5F2E9FA;
        Mon,  3 Oct 2022 01:55:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD87C139F;
        Mon,  3 Oct 2022 01:55:52 -0700 (PDT)
Received: from [192.168.4.86] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C5B83F792;
        Mon,  3 Oct 2022 01:55:44 -0700 (PDT)
Message-ID: <14411a02-5058-1c03-b98c-9a17975110cd@arm.com>
Date:   Mon, 3 Oct 2022 09:55:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v3 01/13] coresight: trace-id: Add API to dynamically
 assign Trace ID values
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20220809223401.24599-1-mike.leach@linaro.org>
 <20220809223401.24599-2-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220809223401.24599-2-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2022 23:33, Mike Leach wrote:
> The existing mechanism to assign Trace ID values to sources is limited
> and does not scale for larger multicore / multi trace source systems.
> 
> The API introduces functions that reserve IDs based on availabilty
> represented by a coresight_trace_id_map structure. This records the
> used and free IDs in a bitmap.
> 
> CPU bound sources such as ETMs use the coresight_trace_id_get_cpu_id /
> coresight_trace_id_put_cpu_id pair of functions. The API will record
> the ID associated with the CPU. This ensures that the same ID will be
> re-used while perf events are active on the CPU. The put_cpu_id function
> will pend release of the ID until all perf cs_etm sessions are complete.
> 
> Non-cpu sources, such as the STM can use coresight_trace_id_get_system_id /
> coresight_trace_id_put_system_id.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   drivers/hwtracing/coresight/Makefile          |   2 +-
>   drivers/hwtracing/coresight/coresight-core.c  |   4 +
>   .../hwtracing/coresight/coresight-trace-id.c  | 230 ++++++++++++++++++
>   .../hwtracing/coresight/coresight-trace-id.h  |  78 ++++++
>   include/linux/coresight-pmu.h                 |  23 +-
>   5 files changed, 324 insertions(+), 13 deletions(-)
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
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 1edfec1e9d18..c7b7c518a0a3 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -22,6 +22,7 @@
>   #include "coresight-etm-perf.h"
>   #include "coresight-priv.h"
>   #include "coresight-syscfg.h"
> +#include "coresight-trace-id.h"
>   
>   static DEFINE_MUTEX(coresight_mutex);
>   static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
> @@ -1775,6 +1776,9 @@ static int __init coresight_init(void)
>   	if (ret)
>   		goto exit_bus_unregister;
>   
> +	/* initialise the trace ID allocator */
> +	coresight_trace_id_init();
> +
>   	/* initialise the coresight syscfg API */
>   	ret = cscfg_init();
>   	if (!ret)
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> new file mode 100644
> index 000000000000..ac9092896dec
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022, Linaro Limited, All rights reserved.
> + * Author: Mike Leach <mike.leach@linaro.org>
> + */
> +#include <linux/coresight-pmu.h>
> +#include <linux/kernel.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#include "coresight-trace-id.h"
> +
> +/* need to keep data on ids & association with cpus. */
> +struct cpu_id_info {
> +	atomic_t id;
> +	bool pend_rel;
> +};
> +
> +/* default trace ID map. Used for systems that do not require per sink mappings */
> +static struct coresight_trace_id_map id_map_default;
> +
> +/* maintain a record of the current mapping of cpu IDs */
> +static DEFINE_PER_CPU(struct cpu_id_info, cpu_ids);
> +
> +/* perf session active counter */
> +static atomic_t perf_cs_etm_session_active = ATOMIC_INIT(0);
> +
> +/* lock to protect id_map and cpu data  */
> +static DEFINE_SPINLOCK(id_map_lock);
> +
> +/*
> + * allocate new ID and set in use
> + * if @preferred_id is a valid id then try to use that value if available.
> + */
> +static int coresight_trace_id_alloc_new_id(struct coresight_trace_id_map *id_map,
> +					   int preferred_id)
> +{
> +	int id;
> +
> +	/* for backwards compatibility reasons, cpu Ids may have a preferred value */
> +	if (IS_VALID_ID(preferred_id) && !test_bit(preferred_id, id_map->used_ids))
> +		id = preferred_id;
> +	else {
> +		/* skip reserved bit 0, look from bit 1 to CORESIGHT_TRACE_ID_RES_TOP */
> +		id = find_next_zero_bit(id_map->used_ids, 1, CORESIGHT_TRACE_ID_RES_TOP);
> +		if (id >= CORESIGHT_TRACE_ID_RES_TOP)
> +			return -EINVAL;
> +	}
> +
> +	/* mark as used */
> +	set_bit(id, id_map->used_ids);
> +	return id;
> +}
> +
> +static void coresight_trace_id_free(int id, struct coresight_trace_id_map *id_map)
> +{
> +	if (WARN(!IS_VALID_ID(id), "%s: Invalid Trace ID %d\n", __func__, id))
> +		return;
> +	if (WARN(!test_bit(id, id_map->used_ids),
> +		 "%s: Freeing unused ID %d\n", __func__, id))
> +		return;
> +	clear_bit(id, id_map->used_ids);
> +}
> +
> +static void coresight_trace_id_set_pend_rel(int id, struct coresight_trace_id_map *id_map)
> +{
> +	if (WARN(!IS_VALID_ID(id), "%s: Invalid Trace ID %d\n", __func__, id))
> +		return;
> +	set_bit(id, id_map->pend_rel_ids);
> +}
> +
> +/* release all pending IDs for all current maps & clear CPU associations */
> +static void coresight_trace_id_release_all_pending(void)
> +{
> +	struct coresight_trace_id_map *id_map = &id_map_default;
> +	unsigned long flags;
> +	int cpu, bit;
> +
> +	spin_lock_irqsave(&id_map_lock, flags);
> +	for_each_set_bit(bit, id_map->pend_rel_ids, CORESIGHT_TRACE_ID_RES_TOP) {
> +		clear_bit(bit, id_map->used_ids);
> +		clear_bit(bit, id_map->pend_rel_ids);
> +	}


> +	for_each_possible_cpu(cpu) {
> +		if (per_cpu(cpu_ids, cpu).pend_rel) {
> +			per_cpu(cpu_ids, cpu).pend_rel = false;
> +			atomic_set(&per_cpu(cpu_ids, cpu).id, 0);
> +		}
> +	}

Could we use a bitmask for the pending CPUs and use that to track
the pending CPUs ? Looping over the "possible" CPUs could be quite
time consuming for large system with spin lock held.

DECLARE_BITMAP(cpuid_release_pending, NR_CPUS);


> +	spin_unlock_irqrestore(&id_map_lock, flags);
> +}
> +
> +static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
> +{
> +	unsigned long flags;
> +	int id;
> +
> +	spin_lock_irqsave(&id_map_lock, flags);
> +
> +	/* check for existing allocation for this CPU */
> +	id = atomic_read(&per_cpu(cpu_ids, cpu).id);
> +	if (id)
> +		goto get_cpu_id_out;
> +
> +	/*
> +	 * Find a new ID.
> +	 *
> +	 * Use legacy values where possible in the dynamic trace ID allocator to
> +	 * allow tools like Android simpleperf to continue working if they are not

I would rather not mention tools name in here. Could we say :

	 * keep as much backward compatibility as possible with the
	 * older userspace tools, by requesting the "legacy" traceid
	 * if available.

> +	 * upgraded at the same time as the kernel drivers.
> +	 *
> +	 * If the generated legacy ID is invalid, or not available then the next
> +	 * available dynamic ID will be used.
> +	 */
> +	id = coresight_trace_id_alloc_new_id(id_map, CORESIGHT_LEGACY_CPU_TRACE_ID(cpu));
> +	if (IS_VALID_ID(id)) {
> +		/* got a valid new ID - save details */
> +		atomic_set(&per_cpu(cpu_ids, cpu).id, id);
> +		per_cpu(cpu_ids, cpu).pend_rel = false;


> +		clear_bit(id, id_map->pend_rel_ids);

Couldn't this be moved to coresight_trace_id_alloc_new_id() ? For system 
pool this is ignored anyways and doesn't matter.

> +	}
> +
> +get_cpu_id_out:
> +	spin_unlock_irqrestore(&id_map_lock, flags);
> +
> +	return id;
> +}
> +
> +static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
> +{
> +	unsigned long flags;
> +	int id;
> +
> +	/* check for existing allocation for this CPU */
> +	id = atomic_read(&per_cpu(cpu_ids, cpu).id);
> +	if (!id)
> +		goto put_cpu_id_out;

nit: return; ?

> +
> +	spin_lock_irqsave(&id_map_lock, flags);
> +
> +	if (atomic_read(&perf_cs_etm_session_active)) {


> +		/* set release at pending if perf still active */
> +		coresight_trace_id_set_pend_rel(id, id_map);
> +		per_cpu(cpu_ids, cpu).pend_rel = true;
> +	} else {

What prevents another refcount on perf_cs_etm_session_active, after
the above read and before we clear this out ? As far as I can see
the spinlock doesn't prevent this situation.

> +		/* otherwise clear id */
> +		coresight_trace_id_free(id, id_map);
> +		atomic_set(&per_cpu(cpu_ids, cpu).id, 0);
> +	}
> +
> +	spin_unlock_irqrestore(&id_map_lock, flags);

> +put_cpu_id_out:

This can be removed ?

> +}
> +

Suzuki

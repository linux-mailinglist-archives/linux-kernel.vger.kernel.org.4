Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0487F6214A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbiKHODs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbiKHODo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:03:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93B8BC24;
        Tue,  8 Nov 2022 06:03:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC19B1FB;
        Tue,  8 Nov 2022 06:03:44 -0800 (PST)
Received: from [10.1.34.13] (FVFF763DQ05P.cambridge.arm.com [10.1.34.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CEF23F73D;
        Tue,  8 Nov 2022 06:03:37 -0800 (PST)
Message-ID: <2873baa4-b8b5-0f3a-92ff-2f15b95520cf@arm.com>
Date:   Tue, 8 Nov 2022 14:03:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v5 01/14] coresight: trace-id: Add API to dynamically
 assign Trace ID values
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20221101163103.17921-1-mike.leach@linaro.org>
 <20221101163103.17921-2-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20221101163103.17921-2-mike.leach@linaro.org>
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

Hi Mike

On 01/11/2022 16:30, Mike Leach wrote:
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

Thanks for the rework, patch looks good to me. Most of the comments are
style related or nits.

The important one is about the allocation of trace id for system 
components, where a legacy_cpu_id(cpu) could be allocated to a
system component. It would be good to skip this (and we can do that
with minimal changes, see below).

There are many lines crossing the 80 characters width, please intend
them if possible. Not strict about all of them, but some of the function
definitions could be split into new lines.


> ---
>   drivers/hwtracing/coresight/Makefile          |   2 +-
>   drivers/hwtracing/coresight/coresight-core.c  |   4 +
>   .../hwtracing/coresight/coresight-trace-id.c  | 225 ++++++++++++++++++
>   .../hwtracing/coresight/coresight-trace-id.h  | 154 ++++++++++++
>   include/linux/coresight-pmu.h                 |  10 +
>   5 files changed, 394 insertions(+), 1 deletion(-)
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
> index f3068175ca9d..554a18039e10 100644
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
> @@ -1804,6 +1805,9 @@ static int __init coresight_init(void)
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
> index 000000000000..8e05a244c9d6
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> @@ -0,0 +1,225 @@
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
> +/* default trace ID map. Used for systems that do not require per sink mappings */
> +static struct coresight_trace_id_map id_map_default;
> +
> +/* maintain a record of the current mapping of cpu IDs and pending releases per cpu */
> +static DEFINE_PER_CPU(atomic_t, cpu_id);

We can statically initialise the cpu_id as below and get rid of the
coresight_trace_id_init() altogether.

static DEFINE_PER_CPU(atomic_t, cpu_id) = ATOMIC_INIT(0);

> +static DECLARE_BITMAP(cpu_id_release_pending, NR_CPUS);

If you do respin this, please consider switching to a cpumask_t.
Apologies, should have said that this last time. Then, we could
do :

for_each_cpu(cpu, &cpui_id_release_pending) {
..
}

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

minor nit: line width exceeds 80.

	if (IS_VALID_ID(preferred_id) &&
	    !test_bit(preferred_id, id_map->used_ids)) {
> +		id = preferred_id;
	} else {

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

minor nit: __func__ is not be need as the WARN would already give you
the file+line number of the warning and also a stack trace. This could 
simply be:

	  if (!WARN_ON(!IS_VALID_ID(id))
		clear_bit(id, id_map->used_ids);


> +	if (WARN(!test_bit(id, id_map->used_ids),
> +		 "%s: Freeing unused ID %d\n", __func__, id))
> +		return;
> +	clear_bit(id, id_map->used_ids);
> +}
> +
> +static void coresight_trace_id_set_pend_rel(int id, struct coresight_trace_id_map *id_map)

minor nit: exceeds 80

> +{
> +	if (WARN(!IS_VALID_ID(id), "%s: Invalid Trace ID %d\n", __func__, id))
> +		return;
> +	set_bit(id, id_map->pend_rel_ids);
> +}
> +
> +/* release all pending IDs for all current maps & clear CPU associations */

Minor nit: This function operates on the "default id map" and as such
it may be a good idea to call that out in the comment or even in the
function name to make it explicit. Every other function accepts an
id_map.

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
> +	for_each_set_bit(cpu, cpu_id_release_pending, NR_CPUS) {
> +		atomic_set(&per_cpu(cpu_id, cpu), 0);
> +		clear_bit(cpu, cpu_id_release_pending);
> +	}
> +	spin_unlock_irqrestore(&id_map_lock, flags);
> +}
> +
> +static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)

minor nit: Please split the line

> +{
> +	unsigned long flags;
> +	int id;
> +
> +	spin_lock_irqsave(&id_map_lock, flags);

> +
> +	/* check for existing allocation for this CPU */
> +	id = atomic_read(&per_cpu(cpu_id, cpu));
> +	if (id)

Please could we use coresight_trace_id_read_cpu_id() ?
i.e  Could we keep the code abstracted as much as possible, than open
coding at different places ?

i.e.,

      id = coresight_trace_id_read_cpu_id()

we could move the definition around. That way, it is easier to fix
potential changes in the future.

> +		goto get_cpu_id_clr_pend;
> +
> +	/*
> +	 * Find a new ID.
> +	 *
> +	 * Use legacy values where possible in the dynamic trace ID allocator to
> +	 * allow older tools to continue working if they are not upgraded at the same
> +	 * time as the kernel drivers.
> +	 *
> +	 * If the generated legacy ID is invalid, or not available then the next
> +	 * available dynamic ID will be used.
> +	 */

Thanks, this will help the legacy perf tools. One question here though.
In order to make sure we get the legacy allocated to CPUs, do we need
to tweak the "get_system_id" to "prefer"  "odd" traceIDs ? e.g., I see
that the TPDA requests a trace-id at "probe" time and keeps that
forever. If the TPDA gets to the trace-id first and gets the trace-id
of CPU0, we may break the legacy id scheme here. We could live with it,
but having this sort of a scheme may help to avoid the situation.

e.g., we could use


	coresight_trace_id_alloc_preferred(id_map, 
CORESIGHT_LEGACY_CPU_TRACE_ID(cpu));

  where:

	coresight_trace_id_alloc_mask(id_map, mask, match)
	{
		for_each_clear_bit(id, id_map->used_ids) {
			if ((id & mask) == match)
				allocate_id and return id;
		}
	}

	coresight_trace_id_alloc_new_id(id_map)
	{
		return coresight_trace_id_alloc_mask(id_map, 0, 0);
	}

	coresight_trace_id_alloc_preferred(id_map, preferred)
	 {
		if (prefered is free) {
			allocate preferred and mark as used;
		} else {
			coresight_trace_id_alloc_new_id(id_map);
		}
	}

	/* Prefer Odd traceid values for system components) */
	coresight_trace_id_alloc_mask(id_map, 0x1, 0x1);

Thoughts ?

> +	id = coresight_trace_id_alloc_new_id(id_map, CORESIGHT_LEGACY_CPU_TRACE_ID(cpu));
> +	if (!IS_VALID_ID(id))
> +		goto get_cpu_id_out_unlock;
> +
> +	/* allocate the new id to the cpu */
> +	atomic_set(&per_cpu(cpu_id, cpu), id);
> +
> +get_cpu_id_clr_pend:
> +	/* we are (re)using this ID - so ensure it is not marked for release */
> +	clear_bit(cpu, cpu_id_release_pending);
> +	clear_bit(id, id_map->pend_rel_ids);
> +
> +get_cpu_id_out_unlock:
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
> +	id = atomic_read(&per_cpu(cpu_id, cpu));

same as above, coresight_trace_id_read_cpu_id();

> +	if (!id)
> +		return;
> +
> +	spin_lock_irqsave(&id_map_lock, flags);
> +
> +	if (atomic_read(&perf_cs_etm_session_active)) {
> +		/* set release at pending if perf still active */
> +		coresight_trace_id_set_pend_rel(id, id_map);
> +		set_bit(cpu, cpu_id_release_pending);
> +	} else {
> +		/* otherwise clear id */
> +		coresight_trace_id_free(id, id_map);
> +		atomic_set(&per_cpu(cpu_id, cpu), 0);
> +	}
> +
> +	spin_unlock_irqrestore(&id_map_lock, flags);
> +}
> +
> +static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *id_map)
> +{
> +	unsigned long flags;
> +	int id;
> +
> +	spin_lock_irqsave(&id_map_lock, flags);
> +	id = coresight_trace_id_alloc_new_id(id_map, 0);
> +	spin_unlock_irqrestore(&id_map_lock, flags);
> +
> +	return id;
> +}
> +
> +static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *id_map, int id)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&id_map_lock, flags);
> +	coresight_trace_id_free(id, id_map);
> +	spin_unlock_irqrestore(&id_map_lock, flags);
> +}
> +
> +/* API functions */
> +
> +int coresight_trace_id_get_cpu_id(int cpu)
> +{
> +	return coresight_trace_id_map_get_cpu_id(cpu, &id_map_default);
> +}
> +EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id);
> +
> +void coresight_trace_id_put_cpu_id(int cpu)
> +{
> +	coresight_trace_id_map_put_cpu_id(cpu, &id_map_default);
> +}
> +EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id);
> +
> +int coresight_trace_id_read_cpu_id(int cpu)
> +{
> +	return atomic_read(&per_cpu(cpu_id, cpu));
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


> +void coresight_trace_id_init(void)
> +{
> +	int cpu;
> +
> +	/* initialise the atomic trace ID values */
> +	for_each_possible_cpu(cpu)
> +		atomic_set(&per_cpu(cpu_id, cpu), 0);
> +}
> +EXPORT_SYMBOL_GPL(coresight_trace_id_init);

As mentioned above, we could remove this.

> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
> new file mode 100644
> index 000000000000..1d27977346b3
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.h
> @@ -0,0 +1,154 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright(C) 2022 Linaro Limited. All rights reserved.
> + * Author: Mike Leach <mike.leach@linaro.org>
> + */
> +
> +#ifndef _CORESIGHT_TRACE_ID_H
> +#define _CORESIGHT_TRACE_ID_H
> +
> +/*
> + * Coresight trace ID allocation API
> + *
> + * With multi cpu systems, and more additional trace sources a scalable
> + * trace ID reservation system is required.
> + *
> + * The system will allocate Ids on a demand basis, and allow them to be
> + * released when done.
> + *
> + * In order to ensure that a consistent cpu / ID matching is maintained
> + * throughout a perf cs_etm event session - a session in progress flag will
> + * be maintained, and released IDs not cleared until the perf session is
> + * complete. This allows the same CPU to be re-allocated its prior ID.
> + *
> + *
> + * Trace ID maps will be created and initialised to prevent architecturally
> + * reserved IDs from being allocated.
> + *
> + * API permits multiple maps to be maintained - for large systems where
> + * different sets of cpus trace into different independent sinks.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/types.h>
> +
> +
> +/* architecturally we have 128 IDs some of which are reserved */
> +#define CORESIGHT_TRACE_IDS_MAX 128
> +
> +/* ID 0 is reserved */
> +#define CORESIGHT_TRACE_ID_RES_0 0
> +
> +/* ID 0x70 onwards are reserved */
> +#define CORESIGHT_TRACE_ID_RES_TOP 0x70

super minor nit: Could we make this CORESIGHT_TRACE_ID_MAX ?



Rest looks fine to me.

Suzuki

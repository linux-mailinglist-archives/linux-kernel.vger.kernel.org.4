Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3699563386C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiKVJ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiKVJ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:28:51 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EAB4C246
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:28:49 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 6so13576257pgm.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HRg/W5/1x0JCWgKQzlv6NKGx+zdQ0FE5juo0nvnXjYc=;
        b=ddkoSzjfwaaV0yJU8AajENHHlh1N6wdUi0KtkwOrMgW8PCAVMZdYONLERrNCB5OME/
         RoaZ5kVlaVI5C9mTa6IyOV5dmHUcCms+P84875HLQMgEhaBBzQSWo5QE96NRBX6QT2yv
         WPaoJ+4ICJEhtxnOzB+JGGwhEGm0CQNsm6gjIZkvcIexhMz0hzy0soItPCEc2OBseDyF
         qJLq48ZK2+uSac+q8l0Y6TSk5YxXYx43JiHvndJH0pCp8lVOTb2meILlSxFBcpa6qHr2
         GZwapfZd6VW8E+cBRqeO/t2y9fyJCHYR+Doy2W27gky7xXx0DXvFtbhnBPve9DnPubIa
         6YHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRg/W5/1x0JCWgKQzlv6NKGx+zdQ0FE5juo0nvnXjYc=;
        b=cVXgHiJ4lfhdNLMfq0dKPMGpvGpvB3tzBR7zMIXTJKI38LtV/b5GvaNImlrDp2nEyh
         Sx66vCFOprKBrQC8e6K7FBUARSmTOet/GbJoI2ci5BV7jfrY6YdkgYZgUOaXB6q6lcTc
         ITYaMBLW8RPguqf2xHx8LzOLgkA1MgHQotjiiHv3Jk7Qe9Bokjx2LNeKtAvt1Ru4hoJK
         wM3yCE1J9N4dwoAScGgAZ/4nunYkZTPXF8+YDyjHyZLj5Hzgv808eWirEXqA/DzPbNdD
         lGr3aAvUvxX63nmuZSF8mbSWa8xmfMKCVlMZjQcQ7kqKHY4yO1cT9u3+QoEWPl3Lpn6X
         62cw==
X-Gm-Message-State: ANoB5pnqhwpNqqXYs+7bQuXHogNGgErskkrhMSlUS/Im7ADLp10szNbb
        YJ90NcQ500yZFs2ITQslcNQxR24boy6JuJpB88tZiQ==
X-Google-Smtp-Source: AA0mqf4iArtUXKqniwxjZOexxHxYko6g3hhtPHj5/nIrAclcyh5qcqKGy1TEslhT2/aDWgopzb7utfvPeD263Qfq9wU=
X-Received: by 2002:a63:4b24:0:b0:476:e640:d016 with SMTP id
 y36-20020a634b24000000b00476e640d016mr21249999pga.205.1669109328953; Tue, 22
 Nov 2022 01:28:48 -0800 (PST)
MIME-Version: 1.0
References: <20221101163103.17921-1-mike.leach@linaro.org> <20221101163103.17921-2-mike.leach@linaro.org>
 <2873baa4-b8b5-0f3a-92ff-2f15b95520cf@arm.com>
In-Reply-To: <2873baa4-b8b5-0f3a-92ff-2f15b95520cf@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 22 Nov 2022 09:28:21 +0000
Message-ID: <CAJ9a7Vg1-rnC2Z2CnmdhqL1T3yFMpVefOoSXd4LjCMNR-hijqQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] coresight: trace-id: Add API to dynamically
 assign Trace ID values
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki

On Tue, 8 Nov 2022 at 14:03, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Mike
>
> On 01/11/2022 16:30, Mike Leach wrote:
> > The existing mechanism to assign Trace ID values to sources is limited
> > and does not scale for larger multicore / multi trace source systems.
> >
> > The API introduces functions that reserve IDs based on availabilty
> > represented by a coresight_trace_id_map structure. This records the
> > used and free IDs in a bitmap.
> >
> > CPU bound sources such as ETMs use the coresight_trace_id_get_cpu_id
> > coresight_trace_id_put_cpu_id pair of functions. The API will record
> > the ID associated with the CPU. This ensures that the same ID will be
> > re-used while perf events are active on the CPU. The put_cpu_id function
> > will pend release of the ID until all perf cs_etm sessions are complete.
> >
> > For backward compatibility the functions will attempt to use the same
> > CPU IDs as the legacy system would have used if these are still available.
> >
> > Non-cpu sources, such as the STM can use coresight_trace_id_get_system_id /
> > coresight_trace_id_put_system_id.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
>
> Thanks for the rework, patch looks good to me. Most of the comments are
> style related or nits.
>
> The important one is about the allocation of trace id for system
> components, where a legacy_cpu_id(cpu) could be allocated to a
> system component. It would be good to skip this (and we can do that
> with minimal changes, see below).
>

Agreed - good idea!

> There are many lines crossing the 80 characters width, please intend
> them if possible. Not strict about all of them, but some of the function
> definitions could be split into new lines.
>

checkpatch.pl now allows <=100 - I believe the rationale for this
increase was to reduce the number of unnecessary newlines.

Where I have gone over 80 I tend to do so to avoid unnecessarily
splitting lines which otherwise read perfectly well without the split

So my emacs is now adjusted to highlight > 100 in whitespace mode.

In the past when I have split a function definition that could fit
into 80 chars I have been told to unsplit it - so to split it when it
exceeds the old limit, but not the new is pretty counter-intuitive.


>
> > ---
> >   drivers/hwtracing/coresight/Makefile          |   2 +-
> >   drivers/hwtracing/coresight/coresight-core.c  |   4 +
> >   .../hwtracing/coresight/coresight-trace-id.c  | 225 ++++++++++++++++++
> >   .../hwtracing/coresight/coresight-trace-id.h  | 154 ++++++++++++
> >   include/linux/coresight-pmu.h                 |  10 +
> >   5 files changed, 394 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
> >   create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h
> >
> > diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> > index b6c4a48140ec..329a0c704b87 100644
> > --- a/drivers/hwtracing/coresight/Makefile
> > +++ b/drivers/hwtracing/coresight/Makefile
> > @@ -6,7 +6,7 @@ obj-$(CONFIG_CORESIGHT) += coresight.o
> >   coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
> >               coresight-sysfs.o coresight-syscfg.o coresight-config.o \
> >               coresight-cfg-preload.o coresight-cfg-afdo.o \
> > -             coresight-syscfg-configfs.o
> > +             coresight-syscfg-configfs.o coresight-trace-id.o
> >   obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
> >   coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
> >                     coresight-tmc-etr.o
> > diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> > index f3068175ca9d..554a18039e10 100644
> > --- a/drivers/hwtracing/coresight/coresight-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-core.c
> > @@ -22,6 +22,7 @@
> >   #include "coresight-etm-perf.h"
> >   #include "coresight-priv.h"
> >   #include "coresight-syscfg.h"
> > +#include "coresight-trace-id.h"
> >
> >   static DEFINE_MUTEX(coresight_mutex);
> >   static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
> > @@ -1804,6 +1805,9 @@ static int __init coresight_init(void)
> >       if (ret)
> >               goto exit_bus_unregister;
> >
> > +     /* initialise the trace ID allocator */
> > +     coresight_trace_id_init();
> > +
> >       /* initialise the coresight syscfg API */
> >       ret = cscfg_init();
> >       if (!ret)
> > diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> > new file mode 100644
> > index 000000000000..8e05a244c9d6
> > --- /dev/null
> > +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> > @@ -0,0 +1,225 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2022, Linaro Limited, All rights reserved.
> > + * Author: Mike Leach <mike.leach@linaro.org>
> > + */
> > +#include <linux/coresight-pmu.h>
> > +#include <linux/kernel.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/types.h>
> > +
> > +#include "coresight-trace-id.h"
> > +
> > +/* default trace ID map. Used for systems that do not require per sink mappings */
> > +static struct coresight_trace_id_map id_map_default;
> > +
> > +/* maintain a record of the current mapping of cpu IDs and pending releases per cpu */
> > +static DEFINE_PER_CPU(atomic_t, cpu_id);
>
> We can statically initialise the cpu_id as below and get rid of the
> coresight_trace_id_init() altogether.
>
> static DEFINE_PER_CPU(atomic_t, cpu_id) = ATOMIC_INIT(0);
>
> > +static DECLARE_BITMAP(cpu_id_release_pending, NR_CPUS);
>
> If you do respin this, please consider switching to a cpumask_t.
> Apologies, should have said that this last time. Then, we could
> do :
>
> for_each_cpu(cpu, &cpui_id_release_pending) {
> ..
> }
>

agreed and implemented with the cpumask_... fns where required.

> > +
> > +/* perf session active counter */
> > +static atomic_t perf_cs_etm_session_active = ATOMIC_INIT(0);
> > +
> > +/* lock to protect id_map and cpu data  */
> > +static DEFINE_SPINLOCK(id_map_lock);
> > +
> > +/*
> > + * allocate new ID and set in use
> > + * if @preferred_id is a valid id then try to use that value if available.
> > + */
> > +static int coresight_trace_id_alloc_new_id(struct coresight_trace_id_map *id_map,
> > +                                        int preferred_id)
> > +{
> > +     int id;
> > +
> > +     /* for backwards compatibility reasons, cpu Ids may have a preferred value */
> > +     if (IS_VALID_ID(preferred_id) && !test_bit(preferred_id, id_map->used_ids))
>
> minor nit: line width exceeds 80.
>
>         if (IS_VALID_ID(preferred_id) &&
>             !test_bit(preferred_id, id_map->used_ids)) {
> > +             id = preferred_id;
>         } else {
>
> > +     else {
> > +             /* skip reserved bit 0, look from bit 1 to CORESIGHT_TRACE_ID_RES_TOP */
> > +             id = find_next_zero_bit(id_map->used_ids, 1, CORESIGHT_TRACE_ID_RES_TOP);
> > +             if (id >= CORESIGHT_TRACE_ID_RES_TOP)
> > +                     return -EINVAL;
> > +     }
> > +
> > +     /* mark as used */
> > +     set_bit(id, id_map->used_ids);
> > +     return id;
> > +}
> > +
> > +static void coresight_trace_id_free(int id, struct coresight_trace_id_map *id_map)
> > +{
> > +     if (WARN(!IS_VALID_ID(id), "%s: Invalid Trace ID %d\n", __func__, id))
> > +             return;
>
> minor nit: __func__ is not be need as the WARN would already give you
> the file+line number of the warning and also a stack trace. This could
> simply be:
>
>           if (!WARN_ON(!IS_VALID_ID(id))
>                 clear_bit(id, id_map->used_ids);
>

Done

>
> > +     if (WARN(!test_bit(id, id_map->used_ids),
> > +              "%s: Freeing unused ID %d\n", __func__, id))
> > +             return;
> > +     clear_bit(id, id_map->used_ids);
> > +}
> > +
> > +static void coresight_trace_id_set_pend_rel(int id, struct coresight_trace_id_map *id_map)
>
> minor nit: exceeds 80
>
> > +{
> > +     if (WARN(!IS_VALID_ID(id), "%s: Invalid Trace ID %d\n", __func__, id))
> > +             return;
> > +     set_bit(id, id_map->pend_rel_ids);
> > +}
> > +
> > +/* release all pending IDs for all current maps & clear CPU associations */
>
> Minor nit: This function operates on the "default id map" and as such
> it may be a good idea to call that out in the comment or even in the
> function name to make it explicit. Every other function accepts an
> id_map.
>
> > +static void coresight_trace_id_release_all_pending(void)
> > +{
> > +     struct coresight_trace_id_map *id_map = &id_map_default;
> > +     unsigned long flags;
> > +     int cpu, bit;
> > +
> > +     spin_lock_irqsave(&id_map_lock, flags);
> > +     for_each_set_bit(bit, id_map->pend_rel_ids, CORESIGHT_TRACE_ID_RES_TOP) {
> > +             clear_bit(bit, id_map->used_ids);
> > +             clear_bit(bit, id_map->pend_rel_ids);
> > +     }
> > +     for_each_set_bit(cpu, cpu_id_release_pending, NR_CPUS) {
> > +             atomic_set(&per_cpu(cpu_id, cpu), 0);
> > +             clear_bit(cpu, cpu_id_release_pending);
> > +     }
> > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > +}
> > +
> > +static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
>
> minor nit: Please split the line

splitting after .. int cpu still leaves the end of the line > 80 chars!

>
> > +{
> > +     unsigned long flags;
> > +     int id;
> > +
> > +     spin_lock_irqsave(&id_map_lock, flags);
>
> > +
> > +     /* check for existing allocation for this CPU */
> > +     id = atomic_read(&per_cpu(cpu_id, cpu));
> > +     if (id)
>
> Please could we use coresight_trace_id_read_cpu_id() ?
> i.e  Could we keep the code abstracted as much as possible, than open
> coding at different places ?
>
> i.e.,
>
>       id = coresight_trace_id_read_cpu_id()
>
> we could move the definition around. That way, it is easier to fix
> potential changes in the future.
>

agreed - used an internal fn for the read then used it at these
locations + api fn at the end of the file

> > +             goto get_cpu_id_clr_pend;
> > +
> > +     /*
> > +      * Find a new ID.
> > +      *
> > +      * Use legacy values where possible in the dynamic trace ID allocator to
> > +      * allow older tools to continue working if they are not upgraded at the same
> > +      * time as the kernel drivers.
> > +      *
> > +      * If the generated legacy ID is invalid, or not available then the next
> > +      * available dynamic ID will be used.
> > +      */
>
> Thanks, this will help the legacy perf tools. One question here though.
> In order to make sure we get the legacy allocated to CPUs, do we need
> to tweak the "get_system_id" to "prefer"  "odd" traceIDs ? e.g., I see
> that the TPDA requests a trace-id at "probe" time and keeps that
> forever. If the TPDA gets to the trace-id first and gets the trace-id
> of CPU0, we may break the legacy id scheme here. We could live with it,
> but having this sort of a scheme may help to avoid the situation.
>
> e.g., we could use
>
>
>         coresight_trace_id_alloc_preferred(id_map,
> CORESIGHT_LEGACY_CPU_TRACE_ID(cpu));
>
>   where:
>
>         coresight_trace_id_alloc_mask(id_map, mask, match)
>         {
>                 for_each_clear_bit(id, id_map->used_ids) {
>                         if ((id & mask) == match)
>                                 allocate_id and return id;
>                 }
>         }
>
>         coresight_trace_id_alloc_new_id(id_map)
>         {
>                 return coresight_trace_id_alloc_mask(id_map, 0, 0);
>         }
>
>         coresight_trace_id_alloc_preferred(id_map, preferred)
>          {
>                 if (prefered is free) {
>                         allocate preferred and mark as used;
>                 } else {
>                         coresight_trace_id_alloc_new_id(id_map);
>                 }
>         }
>
>         /* Prefer Odd traceid values for system components) */
>         coresight_trace_id_alloc_mask(id_map, 0x1, 0x1);
>
> Thoughts ?
>

fixed up to prefer odd IDs for system components.

> > +     id = coresight_trace_id_alloc_new_id(id_map, CORESIGHT_LEGACY_CPU_TRACE_ID(cpu));
> > +     if (!IS_VALID_ID(id))
> > +             goto get_cpu_id_out_unlock;
> > +
> > +     /* allocate the new id to the cpu */
> > +     atomic_set(&per_cpu(cpu_id, cpu), id);
> > +
> > +get_cpu_id_clr_pend:
> > +     /* we are (re)using this ID - so ensure it is not marked for release */
> > +     clear_bit(cpu, cpu_id_release_pending);
> > +     clear_bit(id, id_map->pend_rel_ids);
> > +
> > +get_cpu_id_out_unlock:
> > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > +
> > +     return id;
> > +}
> > +
> > +static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
> > +{
> > +     unsigned long flags;
> > +     int id;
> > +
> > +     /* check for existing allocation for this CPU */
> > +     id = atomic_read(&per_cpu(cpu_id, cpu));
>
> same as above, coresight_trace_id_read_cpu_id();
>
> > +     if (!id)
> > +             return;
> > +
> > +     spin_lock_irqsave(&id_map_lock, flags);
> > +
> > +     if (atomic_read(&perf_cs_etm_session_active)) {
> > +             /* set release at pending if perf still active */
> > +             coresight_trace_id_set_pend_rel(id, id_map);
> > +             set_bit(cpu, cpu_id_release_pending);
> > +     } else {
> > +             /* otherwise clear id */
> > +             coresight_trace_id_free(id, id_map);
> > +             atomic_set(&per_cpu(cpu_id, cpu), 0);
> > +     }
> > +
> > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > +}
> > +
> > +static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *id_map)
> > +{
> > +     unsigned long flags;
> > +     int id;
> > +
> > +     spin_lock_irqsave(&id_map_lock, flags);
> > +     id = coresight_trace_id_alloc_new_id(id_map, 0);
> > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > +
> > +     return id;
> > +}
> > +
> > +static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *id_map, int id)
> > +{
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&id_map_lock, flags);
> > +     coresight_trace_id_free(id, id_map);
> > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > +}
> > +
> > +/* API functions */
> > +
> > +int coresight_trace_id_get_cpu_id(int cpu)
> > +{
> > +     return coresight_trace_id_map_get_cpu_id(cpu, &id_map_default);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id);
> > +
> > +void coresight_trace_id_put_cpu_id(int cpu)
> > +{
> > +     coresight_trace_id_map_put_cpu_id(cpu, &id_map_default);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id);
> > +
> > +int coresight_trace_id_read_cpu_id(int cpu)
> > +{
> > +     return atomic_read(&per_cpu(cpu_id, cpu));
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_read_cpu_id);
> > +
> > +int coresight_trace_id_get_system_id(void)
> > +{
> > +     return coresight_trace_id_map_get_system_id(&id_map_default);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_get_system_id);
> > +
> > +void coresight_trace_id_put_system_id(int id)
> > +{
> > +     coresight_trace_id_map_put_system_id(&id_map_default, id);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
> > +
> > +void coresight_trace_id_perf_start(void)
> > +{
> > +     atomic_inc(&perf_cs_etm_session_active);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
> > +
> > +void coresight_trace_id_perf_stop(void)
> > +{
> > +     if (!atomic_dec_return(&perf_cs_etm_session_active))
> > +             coresight_trace_id_release_all_pending();
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_perf_stop);
> > +
>
>
> > +void coresight_trace_id_init(void)
> > +{
> > +     int cpu;
> > +
> > +     /* initialise the atomic trace ID values */
> > +     for_each_possible_cpu(cpu)
> > +             atomic_set(&per_cpu(cpu_id, cpu), 0);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_init);
>
> As mentioned above, we could remove this.
>

done

> > diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
> > new file mode 100644
> > index 000000000000..1d27977346b3
> > --- /dev/null
> > +++ b/drivers/hwtracing/coresight/coresight-trace-id.h
> > @@ -0,0 +1,154 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright(C) 2022 Linaro Limited. All rights reserved.
> > + * Author: Mike Leach <mike.leach@linaro.org>
> > + */
> > +
> > +#ifndef _CORESIGHT_TRACE_ID_H
> > +#define _CORESIGHT_TRACE_ID_H
> > +
> > +/*
> > + * Coresight trace ID allocation API
> > + *
> > + * With multi cpu systems, and more additional trace sources a scalable
> > + * trace ID reservation system is required.
> > + *
> > + * The system will allocate Ids on a demand basis, and allow them to be
> > + * released when done.
> > + *
> > + * In order to ensure that a consistent cpu / ID matching is maintained
> > + * throughout a perf cs_etm event session - a session in progress flag will
> > + * be maintained, and released IDs not cleared until the perf session is
> > + * complete. This allows the same CPU to be re-allocated its prior ID.
> > + *
> > + *
> > + * Trace ID maps will be created and initialised to prevent architecturally
> > + * reserved IDs from being allocated.
> > + *
> > + * API permits multiple maps to be maintained - for large systems where
> > + * different sets of cpus trace into different independent sinks.
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/types.h>
> > +
> > +
> > +/* architecturally we have 128 IDs some of which are reserved */
> > +#define CORESIGHT_TRACE_IDS_MAX 128
> > +
> > +/* ID 0 is reserved */
> > +#define CORESIGHT_TRACE_ID_RES_0 0
> > +
> > +/* ID 0x70 onwards are reserved */
> > +#define CORESIGHT_TRACE_ID_RES_TOP 0x70
>
> super minor nit: Could we make this CORESIGHT_TRACE_ID_MAX ?
>
>

actually prefer it as it as as this value is not in fact the MAX ID -
either usable (0x6f is the highest allocatable) or theoretical (0x7f -
which is not permitted anyway)
The value also acts as the number of bits to scan for when searching
the bitmaps for usable ids, in the C code.

>
> Rest looks fine to me.
>
> Suzuki

also changed IS_VALID_ID to something more relevant to Coresight.

Thanks for the review

Mike

--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

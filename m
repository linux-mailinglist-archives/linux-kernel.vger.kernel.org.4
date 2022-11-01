Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F70E614F47
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiKAQbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiKAQb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:31:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E41B1CFDE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:31:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so4036194wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=01HzRHVXEtsQePy5MUh5KjUIoIybwQ7UjUNynMGQ3Eo=;
        b=eHDpHWaO/fVWvGoR02QYa/dnPpxM+uxWx2BYSazW83Evi65Ef2BbZd9m2eE5it9dEu
         OU1VdcbKQUUzJ0BKoBwRi+pOjhPue+P3bVelRG/5T/D2WI62SArxpLX3vMhVCQoNeLKV
         yvRjVRowzkxPbsrfYZgaUj8WexOh1WVfnNs3VdPW8ttwsRKTElFlyBItG6ZbSIw78/vq
         jUI0F32HqBU07ilmxkup2osEuxYDImJdi/6DpT+vLmehtywyP32N/yLUvoiRnGbWGoya
         JXOagZAGC5j5XHaUT2QWMNx8v8fHTdPo9Qn/5hLlL9nI8xXAANBVlzOTHsOEAsyldHcO
         A+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=01HzRHVXEtsQePy5MUh5KjUIoIybwQ7UjUNynMGQ3Eo=;
        b=K3bm5Sr+vdlzx671qvAMpwOp7kdt3Mu7ruiZT4rXw0Qbp/5VO3Ludm0zcW8dhPAfTd
         Zg80S5jxVK97L0fNUsjaN0z8Y3isciTR7A2ZUqMjLKdj6yLC/D3bJe1ro6IImCegh8ai
         orKzTOWMneAVceUjJUN3qEeWYgG0PsJYnYu2z6JLqJLiQDQbvmPAr2q3HTT4HvARnb1J
         RObRQ5V4cy3/vYD3bjiHvNB2AY5E86jc05UlY7Bz9xi39d9ujnDHgnwyBZftG8RiwjFr
         AsbZFrFhrGVyo9/MWCXn7nGAqo8pBRnivZqrve1kcrG/7NlTvxxevfFIkxgZqKRBPkc1
         MwhQ==
X-Gm-Message-State: ACrzQf1J30vHMptyc0trGqpHL0uKWsUl/96Y6OCg2YA/P9+1QOVUoXun
        bImvggYC5P6FyXrK3NN1nLS2jw==
X-Google-Smtp-Source: AMsMyM4oBWMPDBw3A4GziuogBj2MK4VvGxYTwLjN1ZvAu82LPl7/rVNayPWZRtyJd9ZPZG8Vxo9PNw==
X-Received: by 2002:a05:600c:3107:b0:3c6:ff0a:c42 with SMTP id g7-20020a05600c310700b003c6ff0a0c42mr22177330wmo.141.1667320282012;
        Tue, 01 Nov 2022 09:31:22 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:e844:18b6:fc5:bbc9])
        by smtp.gmail.com with ESMTPSA id bu15-20020a056000078f00b0022ac1be009esm8339844wrb.16.2022.11.01.09.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:31:21 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 01/14] coresight: trace-id: Add API to dynamically assign Trace ID values
Date:   Tue,  1 Nov 2022 16:30:50 +0000
Message-Id: <20221101163103.17921-2-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221101163103.17921-1-mike.leach@linaro.org>
References: <20221101163103.17921-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing mechanism to assign Trace ID values to sources is limited
and does not scale for larger multicore / multi trace source systems.

The API introduces functions that reserve IDs based on availabilty
represented by a coresight_trace_id_map structure. This records the
used and free IDs in a bitmap.

CPU bound sources such as ETMs use the coresight_trace_id_get_cpu_id
coresight_trace_id_put_cpu_id pair of functions. The API will record
the ID associated with the CPU. This ensures that the same ID will be
re-used while perf events are active on the CPU. The put_cpu_id function
will pend release of the ID until all perf cs_etm sessions are complete.

For backward compatibility the functions will attempt to use the same
CPU IDs as the legacy system would have used if these are still available.

Non-cpu sources, such as the STM can use coresight_trace_id_get_system_id /
coresight_trace_id_put_system_id.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/Makefile          |   2 +-
 drivers/hwtracing/coresight/coresight-core.c  |   4 +
 .../hwtracing/coresight/coresight-trace-id.c  | 225 ++++++++++++++++++
 .../hwtracing/coresight/coresight-trace-id.h  | 154 ++++++++++++
 include/linux/coresight-pmu.h                 |  10 +
 5 files changed, 394 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
 create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index b6c4a48140ec..329a0c704b87 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_CORESIGHT) += coresight.o
 coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
 		coresight-sysfs.o coresight-syscfg.o coresight-config.o \
 		coresight-cfg-preload.o coresight-cfg-afdo.o \
-		coresight-syscfg-configfs.o
+		coresight-syscfg-configfs.o coresight-trace-id.o
 obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
 coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
 		      coresight-tmc-etr.o
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index f3068175ca9d..554a18039e10 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -22,6 +22,7 @@
 #include "coresight-etm-perf.h"
 #include "coresight-priv.h"
 #include "coresight-syscfg.h"
+#include "coresight-trace-id.h"
 
 static DEFINE_MUTEX(coresight_mutex);
 static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
@@ -1804,6 +1805,9 @@ static int __init coresight_init(void)
 	if (ret)
 		goto exit_bus_unregister;
 
+	/* initialise the trace ID allocator */
+	coresight_trace_id_init();
+
 	/* initialise the coresight syscfg API */
 	ret = cscfg_init();
 	if (!ret)
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
new file mode 100644
index 000000000000..8e05a244c9d6
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022, Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+#include <linux/coresight-pmu.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "coresight-trace-id.h"
+
+/* default trace ID map. Used for systems that do not require per sink mappings */
+static struct coresight_trace_id_map id_map_default;
+
+/* maintain a record of the current mapping of cpu IDs and pending releases per cpu */
+static DEFINE_PER_CPU(atomic_t, cpu_id);
+static DECLARE_BITMAP(cpu_id_release_pending, NR_CPUS);
+
+/* perf session active counter */
+static atomic_t perf_cs_etm_session_active = ATOMIC_INIT(0);
+
+/* lock to protect id_map and cpu data  */
+static DEFINE_SPINLOCK(id_map_lock);
+
+/*
+ * allocate new ID and set in use
+ * if @preferred_id is a valid id then try to use that value if available.
+ */
+static int coresight_trace_id_alloc_new_id(struct coresight_trace_id_map *id_map,
+					   int preferred_id)
+{
+	int id;
+
+	/* for backwards compatibility reasons, cpu Ids may have a preferred value */
+	if (IS_VALID_ID(preferred_id) && !test_bit(preferred_id, id_map->used_ids))
+		id = preferred_id;
+	else {
+		/* skip reserved bit 0, look from bit 1 to CORESIGHT_TRACE_ID_RES_TOP */
+		id = find_next_zero_bit(id_map->used_ids, 1, CORESIGHT_TRACE_ID_RES_TOP);
+		if (id >= CORESIGHT_TRACE_ID_RES_TOP)
+			return -EINVAL;
+	}
+
+	/* mark as used */
+	set_bit(id, id_map->used_ids);
+	return id;
+}
+
+static void coresight_trace_id_free(int id, struct coresight_trace_id_map *id_map)
+{
+	if (WARN(!IS_VALID_ID(id), "%s: Invalid Trace ID %d\n", __func__, id))
+		return;
+	if (WARN(!test_bit(id, id_map->used_ids),
+		 "%s: Freeing unused ID %d\n", __func__, id))
+		return;
+	clear_bit(id, id_map->used_ids);
+}
+
+static void coresight_trace_id_set_pend_rel(int id, struct coresight_trace_id_map *id_map)
+{
+	if (WARN(!IS_VALID_ID(id), "%s: Invalid Trace ID %d\n", __func__, id))
+		return;
+	set_bit(id, id_map->pend_rel_ids);
+}
+
+/* release all pending IDs for all current maps & clear CPU associations */
+static void coresight_trace_id_release_all_pending(void)
+{
+	struct coresight_trace_id_map *id_map = &id_map_default;
+	unsigned long flags;
+	int cpu, bit;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+	for_each_set_bit(bit, id_map->pend_rel_ids, CORESIGHT_TRACE_ID_RES_TOP) {
+		clear_bit(bit, id_map->used_ids);
+		clear_bit(bit, id_map->pend_rel_ids);
+	}
+	for_each_set_bit(cpu, cpu_id_release_pending, NR_CPUS) {
+		atomic_set(&per_cpu(cpu_id, cpu), 0);
+		clear_bit(cpu, cpu_id_release_pending);
+	}
+	spin_unlock_irqrestore(&id_map_lock, flags);
+}
+
+static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
+{
+	unsigned long flags;
+	int id;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+
+	/* check for existing allocation for this CPU */
+	id = atomic_read(&per_cpu(cpu_id, cpu));
+	if (id)
+		goto get_cpu_id_clr_pend;
+
+	/*
+	 * Find a new ID.
+	 *
+	 * Use legacy values where possible in the dynamic trace ID allocator to
+	 * allow older tools to continue working if they are not upgraded at the same
+	 * time as the kernel drivers.
+	 *
+	 * If the generated legacy ID is invalid, or not available then the next
+	 * available dynamic ID will be used.
+	 */
+	id = coresight_trace_id_alloc_new_id(id_map, CORESIGHT_LEGACY_CPU_TRACE_ID(cpu));
+	if (!IS_VALID_ID(id))
+		goto get_cpu_id_out_unlock;
+
+	/* allocate the new id to the cpu */
+	atomic_set(&per_cpu(cpu_id, cpu), id);
+
+get_cpu_id_clr_pend:
+	/* we are (re)using this ID - so ensure it is not marked for release */
+	clear_bit(cpu, cpu_id_release_pending);
+	clear_bit(id, id_map->pend_rel_ids);
+
+get_cpu_id_out_unlock:
+	spin_unlock_irqrestore(&id_map_lock, flags);
+
+	return id;
+}
+
+static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
+{
+	unsigned long flags;
+	int id;
+
+	/* check for existing allocation for this CPU */
+	id = atomic_read(&per_cpu(cpu_id, cpu));
+	if (!id)
+		return;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+
+	if (atomic_read(&perf_cs_etm_session_active)) {
+		/* set release at pending if perf still active */
+		coresight_trace_id_set_pend_rel(id, id_map);
+		set_bit(cpu, cpu_id_release_pending);
+	} else {
+		/* otherwise clear id */
+		coresight_trace_id_free(id, id_map);
+		atomic_set(&per_cpu(cpu_id, cpu), 0);
+	}
+
+	spin_unlock_irqrestore(&id_map_lock, flags);
+}
+
+static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *id_map)
+{
+	unsigned long flags;
+	int id;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+	id = coresight_trace_id_alloc_new_id(id_map, 0);
+	spin_unlock_irqrestore(&id_map_lock, flags);
+
+	return id;
+}
+
+static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *id_map, int id)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+	coresight_trace_id_free(id, id_map);
+	spin_unlock_irqrestore(&id_map_lock, flags);
+}
+
+/* API functions */
+
+int coresight_trace_id_get_cpu_id(int cpu)
+{
+	return coresight_trace_id_map_get_cpu_id(cpu, &id_map_default);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id);
+
+void coresight_trace_id_put_cpu_id(int cpu)
+{
+	coresight_trace_id_map_put_cpu_id(cpu, &id_map_default);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id);
+
+int coresight_trace_id_read_cpu_id(int cpu)
+{
+	return atomic_read(&per_cpu(cpu_id, cpu));
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_read_cpu_id);
+
+int coresight_trace_id_get_system_id(void)
+{
+	return coresight_trace_id_map_get_system_id(&id_map_default);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_get_system_id);
+
+void coresight_trace_id_put_system_id(int id)
+{
+	coresight_trace_id_map_put_system_id(&id_map_default, id);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
+
+void coresight_trace_id_perf_start(void)
+{
+	atomic_inc(&perf_cs_etm_session_active);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
+
+void coresight_trace_id_perf_stop(void)
+{
+	if (!atomic_dec_return(&perf_cs_etm_session_active))
+		coresight_trace_id_release_all_pending();
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_perf_stop);
+
+void coresight_trace_id_init(void)
+{
+	int cpu;
+
+	/* initialise the atomic trace ID values */
+	for_each_possible_cpu(cpu)
+		atomic_set(&per_cpu(cpu_id, cpu), 0);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_init);
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
new file mode 100644
index 000000000000..1d27977346b3
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-trace-id.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright(C) 2022 Linaro Limited. All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#ifndef _CORESIGHT_TRACE_ID_H
+#define _CORESIGHT_TRACE_ID_H
+
+/*
+ * Coresight trace ID allocation API
+ *
+ * With multi cpu systems, and more additional trace sources a scalable
+ * trace ID reservation system is required.
+ *
+ * The system will allocate Ids on a demand basis, and allow them to be
+ * released when done.
+ *
+ * In order to ensure that a consistent cpu / ID matching is maintained
+ * throughout a perf cs_etm event session - a session in progress flag will
+ * be maintained, and released IDs not cleared until the perf session is
+ * complete. This allows the same CPU to be re-allocated its prior ID.
+ *
+ *
+ * Trace ID maps will be created and initialised to prevent architecturally
+ * reserved IDs from being allocated.
+ *
+ * API permits multiple maps to be maintained - for large systems where
+ * different sets of cpus trace into different independent sinks.
+ */
+
+#include <linux/bitops.h>
+#include <linux/types.h>
+
+
+/* architecturally we have 128 IDs some of which are reserved */
+#define CORESIGHT_TRACE_IDS_MAX 128
+
+/* ID 0 is reserved */
+#define CORESIGHT_TRACE_ID_RES_0 0
+
+/* ID 0x70 onwards are reserved */
+#define CORESIGHT_TRACE_ID_RES_TOP 0x70
+
+/* check an ID is in the valid range */
+#define IS_VALID_ID(id)	\
+	((id > CORESIGHT_TRACE_ID_RES_0) && (id < CORESIGHT_TRACE_ID_RES_TOP))
+
+/**
+ * Trace ID map.
+ *
+ * @used_ids:	Bitmap to register available (bit = 0) and in use (bit = 1) IDs.
+ *		Initialised so that the reserved IDs are permanently marked as in use.
+ * @pend_rel_ids: CPU IDs that have been released by the trace source but not yet marked
+ *                as available, to allow re-allocation to the same CPU during a perf session.
+ */
+struct coresight_trace_id_map {
+	DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
+	DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
+};
+
+/* Allocate and release IDs for a single default trace ID map */
+
+/**
+ * Read and optionally allocate a CoreSight trace ID and associate with a CPU.
+ *
+ * Function will read the current trace ID for the associated CPU,
+ * allocating an new ID if one is not currently allocated.
+ *
+ * Numeric ID values allocated use legacy allocation algorithm if possible,
+ * otherwise any available ID is used.
+ *
+ * @cpu: The CPU index to allocate for.
+ *
+ * return: CoreSight trace ID or -EINVAL if allocation impossible.
+ */
+int coresight_trace_id_get_cpu_id(int cpu);
+
+/**
+ * Release an allocated trace ID associated with the CPU.
+ *
+ * This will release the CoreSight trace ID associated with the CPU,
+ * unless a perf session is in operation.
+ *
+ * If a perf session is in operation then the ID will be marked as pending release.
+ *
+ * @cpu: The CPU index to release the associated trace ID.
+ */
+void coresight_trace_id_put_cpu_id(int cpu);
+
+/**
+ * Read the current allocated CoreSight Trace ID value for the CPU.
+ *
+ * Fast read of the current value that does not allocate if no ID allocated for the CPU.
+
+ * Used in perf context  where it is known that the value for the CPU will not be changing,
+ * when perf starts and event on a core and outputs the Trace ID for the CPU
+ * as a packet in the data file. IDs cannot change during a perf session.
+ *
+ * This function does not take the lock protecting the ID lists, avoiding locking dependency
+ * issues with perf locks.
+ *
+ * @cpu: The CPU index to read.
+ *
+ * return: current value, will be 0 if unallocated.
+ */
+int coresight_trace_id_read_cpu_id(int cpu);
+
+/**
+ * Allocate a CoreSight trace ID for a system component.
+ *
+ * Unconditionally allocates as Trace ID, without associating the ID with any CPU.
+ *
+ * Used to allocate IDs for system trace sources such as STM.
+ *
+ * return: Trace ID or -EINVAL if allocation is impossible.
+ */
+int coresight_trace_id_get_system_id(void);
+
+/**
+ * Release an allocated system trace ID.
+ *
+ * Unconditionally release a trace ID previously allocated to a system component.
+ *
+ * @id: value of trace ID allocated.
+ */
+void coresight_trace_id_put_system_id(int id);
+
+/* notifiers for perf session start and stop */
+
+/**
+ * Notify the Trace ID allocator that a perf session is starting.
+ *
+ * Increase the perf session reference count - called by perf when setting up
+ * a trace event.
+ *
+ * This reference count is used by the ID allocator to ensure that trace IDs associated with
+ * a CPU cannot change or be released during a perf session.
+ */
+void coresight_trace_id_perf_start(void);
+
+/**
+ * Notify the ID allocator that a perf session is stopping.
+ *
+ * Decrease the perf session reference count.
+ * if this causes the count to go to zero, then all Trace IDs marked as pending release
+ * will be released.
+ */
+void coresight_trace_id_perf_stop(void);
+
+/* initialisation */
+void coresight_trace_id_init(void);
+
+#endif /* _CORESIGHT_TRACE_ID_H */
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 6c2fd6cc5a98..ffff4e6277e5 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -10,6 +10,16 @@
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
 #define CORESIGHT_ETM_PMU_SEED  0x10
 
+/*
+ * The legacy Trace ID system based on fixed calculation from the cpu
+ * number. This has been replaced by drivers using a dynamic allocation
+ * system - but need to retain the legacy algorithm for backward comparibility
+ * in certain situations:-
+ * a) new perf running on older systems that generate the legacy mapping
+ * b) older tools that may not update at the same time as the kernel.
+ */
+#define CORESIGHT_LEGACY_CPU_TRACE_ID(cpu)  (0x10 + (cpu * 2))
+
 /*
  * Below are the definition of bit offsets for perf option, and works as
  * arbitrary values for all ETM versions.
-- 
2.17.1


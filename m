Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265E766BE24
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjAPMts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbjAPMti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:49:38 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE541E5E2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:36 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so2555341wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=71Qc7NdqE+vOIwrKti0fEKXkbrxyF/DZyAYqjBspK70=;
        b=UMw5f8qGCf/rlTwaNDjugAXf8EG3ZO5VXjRThRel94xSOkPOm6kV5+JOgCB65DT/HR
         rK+rLcTxjQX4wH5KgnA8qsNAp1RmRZogCZl3BMklp6S7dVUcj6bf+ggbdkDfWGaQguXa
         cHx9lWvIojog440Vk2MazwybKiPClqgIFFZiPXHGYl+hGemZVsQuRfTF6fGk4ylCUrow
         lS/2T5F0N589sun56yI5wcq+qWKmRjo0nTp1e4H3ap7hOgDcpgEXhID4XAf3HRwIKbcr
         JEHbRHHERKCnkTKqXV7MqeK6cRTzdFiAcMIg16Uf7YCzdEguX3EYUnr4/ZRa2AYWma7t
         RzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71Qc7NdqE+vOIwrKti0fEKXkbrxyF/DZyAYqjBspK70=;
        b=YK4sah/vgacPCyqMnISkIqFLPNW3Kgx2P4uZ8fBYQyqHkkIliKMVTV1UbYinkI2vzL
         OLjYn1hQhC8NfCNoxjYqjIdTzh4PAMnyb6nqpQBFpTl5sQt6bN10ZAbsgDxngZwVaBS2
         CzjpY5TrHIuiFlJQk/Ir0+U/IVfsTIssbYlRXTc/68Q/uzAZ1uVCWSTJk2f2GGv7w9LM
         2FLUbloncWtS23k9jsPRpVHHX1cyDJUXp0X8j1jrIi1HKniu4uPt0zd6mdLNhusSXmJw
         8C4N5Ea+20e1SATlrctlpYtt26YF2Ep8oT/OZu9gbHLOxkYr8kalXJi5TFohVULy29lY
         0I+Q==
X-Gm-Message-State: AFqh2kqeA6UbmU5J5DCIe3+8T7pqBRYM7jx540O+RDOnYNAW9sci3KPs
        5AonPD35xWj7rGH+M0HsBO3x5Q==
X-Google-Smtp-Source: AMrXdXvU+ZkDBJDD4w/QUItGJvYhE8j3rM7R4rivD5QcUjb7oTzhg6bTdY/uy3PnjXOAv/M9nRb72Q==
X-Received: by 2002:a05:600c:1c1b:b0:3da:fada:e38a with SMTP id j27-20020a05600c1c1b00b003dafadae38amr3547636wms.24.1673873375295;
        Mon, 16 Jan 2023 04:49:35 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:6c91:710d:9433:e868])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b003dab40f9eafsm6896832wmb.35.2023.01.16.04.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:49:34 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 01/15] coresight: trace-id: Add API to dynamically assign Trace ID values
Date:   Mon, 16 Jan 2023 12:49:14 +0000
Message-Id: <20230116124928.5440-2-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230116124928.5440-1-mike.leach@linaro.org>
References: <20230116124928.5440-1-mike.leach@linaro.org>
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
 .../hwtracing/coresight/coresight-trace-id.c  | 265 ++++++++++++++++++
 .../hwtracing/coresight/coresight-trace-id.h  | 156 +++++++++++
 include/linux/coresight-pmu.h                 |  10 +
 4 files changed, 432 insertions(+), 1 deletion(-)
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
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
new file mode 100644
index 000000000000..9b85c376cb12
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022, Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+#include <linux/coresight-pmu.h>
+#include <linux/cpumask.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "coresight-trace-id.h"
+
+/* Default trace ID map. Used on systems that don't require per sink mappings */
+static struct coresight_trace_id_map id_map_default;
+
+/* maintain a record of the mapping of IDs and pending releases per cpu */
+static DEFINE_PER_CPU(atomic_t, cpu_id) = ATOMIC_INIT(0);
+static cpumask_t cpu_id_release_pending;
+
+/* perf session active counter */
+static atomic_t perf_cs_etm_session_active = ATOMIC_INIT(0);
+
+/* lock to protect id_map and cpu data  */
+static DEFINE_SPINLOCK(id_map_lock);
+
+/* unlocked read of current trace ID value for given CPU */
+static int _coresight_trace_id_read_cpu_id(int cpu)
+{
+	return atomic_read(&per_cpu(cpu_id, cpu));
+}
+
+/* look for next available odd ID, return 0 if none found */
+static int coresight_trace_id_find_odd_id(struct coresight_trace_id_map *id_map)
+{
+	int found_id = 0, bit = 1, next_id;
+
+	while ((bit < CORESIGHT_TRACE_ID_RES_TOP) && !found_id) {
+		/*
+		 * bitmap length of CORESIGHT_TRACE_ID_RES_TOP,
+		 * search from offset `bit`.
+		 */
+		next_id = find_next_zero_bit(id_map->used_ids,
+					     CORESIGHT_TRACE_ID_RES_TOP, bit);
+		if ((next_id < CORESIGHT_TRACE_ID_RES_TOP) && (next_id & 0x1))
+			found_id = next_id;
+		else
+			bit = next_id + 1;
+	}
+	return found_id;
+}
+
+/*
+ * Allocate new ID and set in use
+ *
+ * if @preferred_id is a valid id then try to use that value if available.
+ * if @preferred_id is not valid and @prefer_odd_id is true, try for odd id.
+ *
+ * Otherwise allocate next available ID.
+ */
+static int coresight_trace_id_alloc_new_id(struct coresight_trace_id_map *id_map,
+					   int preferred_id, bool prefer_odd_id)
+{
+	int id = 0;
+
+	/* for backwards compatibility, cpu IDs may use preferred value */
+	if (IS_VALID_CS_TRACE_ID(preferred_id) &&
+	    !test_bit(preferred_id, id_map->used_ids)) {
+		id = preferred_id;
+		goto trace_id_allocated;
+	} else if (prefer_odd_id) {
+	/* may use odd ids to avoid preferred legacy cpu IDs */
+		id = coresight_trace_id_find_odd_id(id_map);
+		if (id)
+			goto trace_id_allocated;
+	}
+
+	/*
+	 * skip reserved bit 0, look at bitmap length of
+	 * CORESIGHT_TRACE_ID_RES_TOP from offset of bit 1.
+	 */
+	id = find_next_zero_bit(id_map->used_ids, CORESIGHT_TRACE_ID_RES_TOP, 1);
+	if (id >= CORESIGHT_TRACE_ID_RES_TOP)
+		return -EINVAL;
+
+	/* mark as used */
+trace_id_allocated:
+	set_bit(id, id_map->used_ids);
+	return id;
+}
+
+static void coresight_trace_id_free(int id, struct coresight_trace_id_map *id_map)
+{
+	if (WARN(!IS_VALID_CS_TRACE_ID(id), "Invalid Trace ID %d\n", id))
+		return;
+	if (WARN(!test_bit(id, id_map->used_ids), "Freeing unused ID %d\n", id))
+		return;
+	clear_bit(id, id_map->used_ids);
+}
+
+static void coresight_trace_id_set_pend_rel(int id, struct coresight_trace_id_map *id_map)
+{
+	if (WARN(!IS_VALID_CS_TRACE_ID(id), "Invalid Trace ID %d\n", id))
+		return;
+	set_bit(id, id_map->pend_rel_ids);
+}
+
+/*
+ * release all pending IDs for all current maps & clear CPU associations
+ *
+ * This currently operates on the default id map, but may be extended to
+ * operate on all registered id maps if per sink id maps are used.
+ */
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
+	for_each_cpu(cpu, &cpu_id_release_pending) {
+		atomic_set(&per_cpu(cpu_id, cpu), 0);
+		cpumask_clear_cpu(cpu, &cpu_id_release_pending);
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
+	id = _coresight_trace_id_read_cpu_id(cpu);
+	if (id)
+		goto get_cpu_id_clr_pend;
+
+	/*
+	 * Find a new ID.
+	 *
+	 * Use legacy values where possible in the dynamic trace ID allocator to
+	 * allow older tools to continue working if they are not upgraded at the
+	 * same time as the kernel drivers.
+	 *
+	 * If the generated legacy ID is invalid, or not available then the next
+	 * available dynamic ID will be used.
+	 */
+	id = coresight_trace_id_alloc_new_id(id_map,
+					     CORESIGHT_LEGACY_CPU_TRACE_ID(cpu),
+					     false);
+	if (!IS_VALID_CS_TRACE_ID(id))
+		goto get_cpu_id_out_unlock;
+
+	/* allocate the new id to the cpu */
+	atomic_set(&per_cpu(cpu_id, cpu), id);
+
+get_cpu_id_clr_pend:
+	/* we are (re)using this ID - so ensure it is not marked for release */
+	cpumask_clear_cpu(cpu, &cpu_id_release_pending);
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
+	id = _coresight_trace_id_read_cpu_id(cpu);
+	if (!id)
+		return;
+
+	spin_lock_irqsave(&id_map_lock, flags);
+
+	if (atomic_read(&perf_cs_etm_session_active)) {
+		/* set release at pending if perf still active */
+		coresight_trace_id_set_pend_rel(id, id_map);
+		cpumask_set_cpu(cpu, &cpu_id_release_pending);
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
+	/* prefer odd IDs for system components to avoid legacy CPU IDS */
+	id = coresight_trace_id_alloc_new_id(id_map, 0, true);
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
+	return _coresight_trace_id_read_cpu_id(cpu);
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
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
new file mode 100644
index 000000000000..3797777d367e
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-trace-id.h
@@ -0,0 +1,156 @@
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
+#define IS_VALID_CS_TRACE_ID(id)	\
+	((id > CORESIGHT_TRACE_ID_RES_0) && (id < CORESIGHT_TRACE_ID_RES_TOP))
+
+/**
+ * Trace ID map.
+ *
+ * @used_ids:	Bitmap to register available (bit = 0) and in use (bit = 1) IDs.
+ *		Initialised so that the reserved IDs are permanently marked as
+ *		in use.
+ * @pend_rel_ids: CPU IDs that have been released by the trace source but not
+ *		  yet marked as available, to allow re-allocation to the same
+ *		  CPU during a perf session.
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
+ * If a perf session is in operation then the ID will be marked as pending
+ * release.
+ *
+ * @cpu: The CPU index to release the associated trace ID.
+ */
+void coresight_trace_id_put_cpu_id(int cpu);
+
+/**
+ * Read the current allocated CoreSight Trace ID value for the CPU.
+ *
+ * Fast read of the current value that does not allocate if no ID allocated
+ * for the CPU.
+ *
+ * Used in perf context  where it is known that the value for the CPU will not
+ * be changing, when perf starts and event on a core and outputs the Trace ID
+ * for the CPU as a packet in the data file. IDs cannot change during a perf
+ * session.
+ *
+ * This function does not take the lock protecting the ID lists, avoiding
+ * locking dependency issues with perf locks.
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
+ * Unconditionally allocates a Trace ID, without associating the ID with a CPU.
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
+ * Unconditionally release a trace ID allocated to a system component.
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
+ * This reference count is used by the ID allocator to ensure that trace IDs
+ * associated with a CPU cannot change or be released during a perf session.
+ */
+void coresight_trace_id_perf_start(void);
+
+/**
+ * Notify the ID allocator that a perf session is stopping.
+ *
+ * Decrease the perf session reference count.
+ * if this causes the count to go to zero, then all Trace IDs marked as pending
+ * release, will be released.
+ */
+void coresight_trace_id_perf_stop(void);
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


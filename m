Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DE270047B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbjELJ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240637AbjELJ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:58:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D23FB12081;
        Fri, 12 May 2023 02:58:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C8291688;
        Fri, 12 May 2023 02:58:57 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DFDC63F5A1;
        Fri, 12 May 2023 02:58:09 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Subject: [PATCH v2 05/17] trace: energy_model: Add trace event for EM runtime modifications
Date:   Fri, 12 May 2023 10:57:31 +0100
Message-Id: <20230512095743.3393563-6-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512095743.3393563-1-lukasz.luba@arm.com>
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Energy Model (EM) supports runtime modifications. Track the changes
in order to do post-processing analysis. Don't use arrays in the trace
event, since they are not properly supported by the tools. Instead use
simple "unroll" with emitting the trace event for each EM array entry
with proper ID information. The older debugging mechanism which was
the simple debugfs which dumping the EM content won't be sufficient for
the modifiable EM purpose. This trace event mechanism would address the
needs.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/trace/events/energy_model.h | 46 +++++++++++++++++++++++++++++
 kernel/power/energy_model.c         |  3 ++
 2 files changed, 49 insertions(+)
 create mode 100644 include/trace/events/energy_model.h

diff --git a/include/trace/events/energy_model.h b/include/trace/events/energy_model.h
new file mode 100644
index 000000000000..f70babeb5dde
--- /dev/null
+++ b/include/trace/events/energy_model.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM energy_model
+
+#if !defined(_TRACE_ENERGY_MODEL_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_ENERGY_MODEL_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(em_perf_state,
+	TP_PROTO(const char *dev_name, int nr_perf_states, int state,
+		 unsigned long ps_frequency, unsigned long ps_power,
+		 unsigned long ps_cost, unsigned long ps_flags),
+
+	TP_ARGS(dev_name, nr_perf_states, state, ps_frequency, ps_power, ps_cost,
+		ps_flags),
+
+	TP_STRUCT__entry(
+		__string(name, dev_name)
+		__field(int, num_states)
+		__field(int, state)
+		__field(unsigned long, frequency)
+		__field(unsigned long, power)
+		__field(unsigned long, cost)
+		__field(unsigned long, flags)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, dev_name);
+		__entry->num_states = nr_perf_states;
+		__entry->state = state;
+		__entry->frequency = ps_frequency;
+		__entry->power = ps_power;
+		__entry->cost = ps_cost;
+		__entry->flags = ps_flags;
+	),
+
+	TP_printk("dev_name=%s nr_perf_states=%d state=%d frequency=%lu power=%lu cost=%lu flags=%lu",
+		__get_str(name), __entry->num_states, __entry->state,
+		__entry->frequency, __entry->power, __entry->cost,
+		__entry->flags)
+);
+#endif /* _TRACE_ENERGY_MODEL_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index fd1066dcf38b..61d349fec545 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -17,6 +17,9 @@
 #include <linux/sched/topology.h>
 #include <linux/slab.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/energy_model.h>
+
 /*
  * Mutex serializing the registrations of performance domains and letting
  * callbacks defined by drivers sleep.
-- 
2.25.1


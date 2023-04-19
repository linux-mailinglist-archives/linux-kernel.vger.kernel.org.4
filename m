Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F5A6E79CB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjDSMbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjDSMbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:31:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4379ECE;
        Wed, 19 Apr 2023 05:31:15 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q1g5k6ldxzSst9;
        Wed, 19 Apr 2023 20:27:06 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 20:31:13 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <anshuman.khandual@arm.com>,
        <jesussanp@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 4/4] perf tools: Add printing perf_event_attr->config symbol in perf_event_attr__fprintf()
Date:   Wed, 19 Apr 2023 12:29:12 +0000
Message-ID: <20230419122912.73746-5-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230419122912.73746-1-yangjihong1@huawei.com>
References: <20230419122912.73746-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When printing perf_event_attr, always display attr->config and its symbol
to improve the readability of debugging information.

Before:

  # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101 -C 0 true
  <SNIP>
  ------------------------------------------------------------
  perf_event_attr:
    size                             136
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
  ------------------------------------------------------------
  perf_event_attr:
    type                             1
    size                             136
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
  ------------------------------------------------------------
  perf_event_attr:
    type                             2
    size                             136
    config                           0x131
    { sample_period, sample_freq }   1
    sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 8
  ------------------------------------------------------------
  perf_event_attr:
    type                             3
    size                             136
    config                           0x10005
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
  ------------------------------------------------------------
  perf_event_attr:
    type                             4
    size                             136
    config                           0x101
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 11
  <SNIP>

After:

  # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101 -C 0 true
  <SNIP>
  ------------------------------------------------------------
  perf_event_attr:
    type                             0 (PERF_TYPE_HARDWARE)
    size                             136
    config                           0 (PERF_COUNT_HW_CPU_CYCLES)
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
  ------------------------------------------------------------
  perf_event_attr:
    type                             1 (PERF_TYPE_SOFTWARE)
    size                             136
    config                           0 (PERF_COUNT_SW_CPU_CLOCK)
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
  ------------------------------------------------------------
  perf_event_attr:
    type                             2 (PERF_TYPE_TRACEPOINT)
    size                             136
    config                           0x131 (sched:sched_switch)
    { sample_period, sample_freq }   1
    sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 8
  ------------------------------------------------------------
  perf_event_attr:
    type                             3 (PERF_TYPE_HW_CACHE)
    size                             136
    config                           0x10005 (PERF_COUNT_HW_CACHE_RESULT_MISS | PERF_COUNT_HW_CACHE_OP_READ | PERF_COUNT_HW_CACHE_BPU)
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
  ------------------------------------------------------------
  perf_event_attr:
    type                             4 (PERF_TYPE_RAW)
    size                             136
    config                           0x101
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 11
  <SNIP>

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/util/perf_event_attr_fprintf.c | 131 +++++++++++++++++++++-
 1 file changed, 130 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index d9d70126d505..e2ce4a737ef7 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -7,6 +7,11 @@
 #include <linux/perf_event.h>
 #include "util/evsel_fprintf.h"
 
+#ifdef HAVE_LIBTRACEEVENT
+#include <stdlib.h>
+#include "trace-event.h"
+#endif
+
 struct bit_names {
 	int bit;
 	const char *name;
@@ -92,6 +97,129 @@ static void __p_type_id(char *buf, size_t size, u64 value)
 	}
 }
 
+static void __p_config_hw_cache_id(char *buf, size_t size, u64 value)
+{
+	const char *hw_cache_str, *hw_cache_op_str, *hw_cache_op_result_str;
+
+#define ENUM_PERF_HW_CACHE_ID_CASE(x, s) case x: s = (#x); break;
+#define ENUM_PERF_HW_CACHE_ID_CASE_DEFAULT(s) default: s = NULL; break;
+
+	/* sync with enum perf_hw_cache_id in perf_event.h */
+	switch (value & 0xff) {
+	ENUM_PERF_HW_CACHE_ID_CASE(PERF_COUNT_HW_CACHE_L1D, hw_cache_str)
+	ENUM_PERF_HW_CACHE_ID_CASE(PERF_COUNT_HW_CACHE_L1I, hw_cache_str)
+	ENUM_PERF_HW_CACHE_ID_CASE(PERF_COUNT_HW_CACHE_LL, hw_cache_str)
+	ENUM_PERF_HW_CACHE_ID_CASE(PERF_COUNT_HW_CACHE_DTLB, hw_cache_str)
+	ENUM_PERF_HW_CACHE_ID_CASE(PERF_COUNT_HW_CACHE_ITLB, hw_cache_str)
+	ENUM_PERF_HW_CACHE_ID_CASE(PERF_COUNT_HW_CACHE_BPU, hw_cache_str)
+	ENUM_PERF_HW_CACHE_ID_CASE(PERF_COUNT_HW_CACHE_NODE, hw_cache_str)
+	ENUM_PERF_HW_CACHE_ID_CASE_DEFAULT(hw_cache_str)
+	}
+
+	/* sync with enum perf_hw_cache_op_id in perf_event.h */
+	switch ((value & 0xff00) >> 8) {
+	ENUM_PERF_HW_CACHE_ID_CASE(PERF_COUNT_HW_CACHE_OP_READ, hw_cache_op_str)
+	ENUM_PERF_HW_CACHE_ID_CASE(PERF_COUNT_HW_CACHE_OP_WRITE, hw_cache_op_str)
+	ENUM_PERF_HW_CACHE_ID_CASE(PERF_COUNT_HW_CACHE_OP_PREFETCH, hw_cache_op_str)
+	ENUM_PERF_HW_CACHE_ID_CASE_DEFAULT(hw_cache_op_str)
+	}
+
+	/* sync with enum perf_hw_cache_op_result_id in perf_event.h */
+	switch ((value & 0xff0000) >> 16) {
+	ENUM_PERF_HW_CACHE_ID_CASE(PERF_COUNT_HW_CACHE_RESULT_ACCESS, hw_cache_op_result_str)
+	ENUM_PERF_HW_CACHE_ID_CASE(PERF_COUNT_HW_CACHE_RESULT_MISS, hw_cache_op_result_str)
+	ENUM_PERF_HW_CACHE_ID_CASE_DEFAULT(hw_cache_op_result_str)
+	}
+
+#undef ENUM_PERF_HW_CACHE_ID_CASE
+#undef ENUM_PERF_HW_CACHE_ID_CASE_DEFULT
+
+	if (hw_cache_str == NULL || hw_cache_op_str == NULL ||
+	    hw_cache_op_result_str == NULL) {
+		snprintf(buf, size, "%#"PRIx64, value);
+	} else {
+		snprintf(buf, size, "%#"PRIx64" (%s | %s | %s)", value,
+			 hw_cache_op_result_str, hw_cache_op_str, hw_cache_str);
+	}
+}
+
+#ifdef HAVE_LIBTRACEEVENT
+static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
+{
+	char *name = tracepoint_id_to_name(value);
+
+	if (name != NULL) {
+		snprintf(buf, size, "%#"PRIx64" (%s)", value, name);
+		free(name);
+	} else {
+		snprintf(buf, size, "%#"PRIx64, value);
+	}
+}
+#endif
+
+static void __p_config_id(char *buf, size_t size, u32 type, u64 value)
+{
+#define PRINT_ENUM_PERF_CONFIG_ID_CASE(x)				\
+	case x:								\
+		snprintf(buf, size, "%#"PRIx64" (%s)", value, #x);	\
+		return;
+
+#define PRINT_ENUM_PERF_CONFIG_ID_DEFAULT_CASE				\
+	default:							\
+		snprintf(buf, size, "%#"PRIx64, value);			\
+		return;
+
+	switch (type) {
+	case PERF_TYPE_HARDWARE:
+		/* sync with enum perf_hw_cache_id in perf_event.h */
+		switch (value & PERF_HW_EVENT_MASK) {
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_HW_CPU_CYCLES)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_HW_INSTRUCTIONS)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_HW_CACHE_REFERENCES)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_HW_CACHE_MISSES)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_HW_BRANCH_INSTRUCTIONS)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_HW_BRANCH_MISSES)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_HW_BUS_CYCLES)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_HW_STALLED_CYCLES_FRONTEND)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_HW_STALLED_CYCLES_BACKEND)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_HW_REF_CPU_CYCLES)
+		PRINT_ENUM_PERF_CONFIG_ID_DEFAULT_CASE
+		}
+
+	case PERF_TYPE_SOFTWARE:
+		/* sync with enum perf_sw_ids in perf_event.h */
+		switch (value) {
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_SW_CPU_CLOCK)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_SW_TASK_CLOCK)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_SW_PAGE_FAULTS)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_SW_CONTEXT_SWITCHES)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_SW_CPU_MIGRATIONS)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_SW_PAGE_FAULTS_MIN)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_SW_PAGE_FAULTS_MAJ)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_SW_ALIGNMENT_FAULTS)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_SW_EMULATION_FAULTS)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_SW_DUMMY)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_SW_BPF_OUTPUT)
+		PRINT_ENUM_PERF_CONFIG_ID_CASE(PERF_COUNT_SW_CGROUP_SWITCHES)
+		PRINT_ENUM_PERF_CONFIG_ID_DEFAULT_CASE
+		}
+#undef PRINT_ENUM_PERF_CONFIG_ID_CASE
+
+	case PERF_TYPE_HW_CACHE:
+		return __p_config_hw_cache_id(buf, size, value);
+
+	case PERF_TYPE_TRACEPOINT:
+#ifdef HAVE_LIBTRACEEVENT
+		return __p_config_tracepoint_id(buf, size, value);
+#endif
+	case PERF_TYPE_RAW:
+	case PERF_TYPE_BREAKPOINT:
+	PRINT_ENUM_PERF_CONFIG_ID_DEFAULT_CASE
+	}
+
+#undef PRINT_ENUM_PERF_CONFIG_ID_DEFAULT_CASE
+}
+
 #define BUF_SIZE		1024
 
 #define p_hex(val)		snprintf(buf, BUF_SIZE, "%#"PRIx64, (uint64_t)(val))
@@ -101,6 +229,7 @@ static void __p_type_id(char *buf, size_t size, u64 value)
 #define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
 #define p_read_format(val)	__p_read_format(buf, BUF_SIZE, val)
 #define p_type_id(val)		__p_type_id(buf, BUF_SIZE, val)
+#define p_config_id(val)	__p_config_id(buf, BUF_SIZE, attr->type, val)
 
 #define PRINT_ATTRn(_n, _f, _p, _a)			\
 do {							\
@@ -120,7 +249,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 
 	PRINT_ATTRn("type", type, p_type_id, true);
 	PRINT_ATTRf(size, p_unsigned);
-	PRINT_ATTRf(config, p_hex);
+	PRINT_ATTRn("config", config, p_config_id, true);
 	PRINT_ATTRn("{ sample_period, sample_freq }", sample_period, p_unsigned, false);
 	PRINT_ATTRf(sample_type, p_sample_type);
 	PRINT_ATTRf(read_format, p_read_format);
-- 
2.30.GIT


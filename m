Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A4873B04A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjFWFrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjFWFqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:46:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3216B26B8;
        Thu, 22 Jun 2023 22:46:17 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QnR435cKhztQnc;
        Fri, 23 Jun 2023 13:43:31 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 13:46:10 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <anshuman.khandual@arm.com>,
        <jesussanp@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v5 4/4] perf tools: Add printing perf_event_attr config symbol in perf_event_attr__fprintf()
Date:   Fri, 23 Jun 2023 05:44:16 +0000
Message-ID: <20230623054416.160858-5-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230623054416.160858-1-yangjihong1@huawei.com>
References: <20230623054416.160858-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

When printing perf_event_attr, always display perf_event_attr config and
its symbol to improve the readability of debugging information.

Before:

  # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101,mem:0x0 -C 0 true
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
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
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
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
  ------------------------------------------------------------
  perf_event_attr:
    type                             2
    size                             136
    config                           0x143
    { sample_period, sample_freq }   1
    sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
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
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 9
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
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
  ------------------------------------------------------------
  perf_event_attr:
    type                             5
    size                             136
    { sample_period, sample_freq }   1
    sample_type                      IP|TID|TIME|CPU|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    sample_id_all                    1
    exclude_guest                    1
    bp_type                          3
    { bp_len, config2 }              0x4
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 11
  <SNIP>

After:

  # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101,mem:0x0 -C 0 true
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
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
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
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
  ------------------------------------------------------------
  perf_event_attr:
    type                             2 (PERF_TYPE_TRACEPOINT)
    size                             136
    config                           0x143 (sched:sched_switch)
    { sample_period, sample_freq }   1
    sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
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
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 9
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
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
  ------------------------------------------------------------
  perf_event_attr:
    type                             5 (PERF_TYPE_BREAKPOINT)
    size                             136
    config                           0
    { sample_period, sample_freq }   1
    sample_type                      IP|TID|TIME|CPU|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    sample_id_all                    1
    exclude_guest                    1
    bp_type                          3
    { bp_len, config2 }              0x4
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 11
  ------------------------------------------------------------
  perf_event_attr:
    type                             1 (PERF_TYPE_SOFTWARE)
    size                             136
    config                           0x9 (PERF_COUNT_SW_DUMMY)
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
    read_format                      ID
    inherit                          1
    mmap                             1
    comm                             1
    freq                             1
    task                             1
    sample_id_all                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
    bpf_event                        1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 12
  <SNIP>

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/perf_event_attr_fprintf.c | 138 +++++++++++++++++++++-
 1 file changed, 137 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index b16521afc31d..2247991451f3 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -1,11 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <inttypes.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <stdbool.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/perf_event.h>
 #include "util/evsel_fprintf.h"
+#include "trace-event.h"
 
 struct bit_names {
 	int bit;
@@ -85,6 +87,80 @@ static const char *stringify_perf_type_id(u64 value)
 		return NULL;
 	}
 }
+
+static const char *stringify_perf_hw_id(u64 value)
+{
+	switch (value) {
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CPU_CYCLES)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_INSTRUCTIONS)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_REFERENCES)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_MISSES)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_BRANCH_INSTRUCTIONS)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_BRANCH_MISSES)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_BUS_CYCLES)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_STALLED_CYCLES_FRONTEND)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_STALLED_CYCLES_BACKEND)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_REF_CPU_CYCLES)
+	default:
+		return NULL;
+	}
+}
+
+static const char *stringify_perf_hw_cache_id(u64 value)
+{
+	switch (value) {
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_L1D)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_L1I)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_LL)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_DTLB)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_ITLB)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_BPU)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_NODE)
+	default:
+		return NULL;
+	}
+}
+
+static const char *stringify_perf_hw_cache_op_id(u64 value)
+{
+	switch (value) {
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_OP_READ)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_OP_WRITE)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_OP_PREFETCH)
+	default:
+		return NULL;
+	}
+}
+
+static const char *stringify_perf_hw_cache_op_result_id(u64 value)
+{
+	switch (value) {
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_RESULT_ACCESS)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_RESULT_MISS)
+	default:
+		return NULL;
+	}
+}
+
+static const char *stringify_perf_sw_id(u64 value)
+{
+	switch (value) {
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_CPU_CLOCK)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_TASK_CLOCK)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_PAGE_FAULTS)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_CONTEXT_SWITCHES)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_CPU_MIGRATIONS)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_PAGE_FAULTS_MIN)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_PAGE_FAULTS_MAJ)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_ALIGNMENT_FAULTS)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_EMULATION_FAULTS)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_DUMMY)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_BPF_OUTPUT)
+	ENUM_ID_TO_STR_CASE(PERF_COUNT_SW_CGROUP_SWITCHES)
+	default:
+		return NULL;
+	}
+}
 #undef ENUM_ID_TO_STR_CASE
 
 #define PRINT_ID(_s, _f)					\
@@ -96,12 +172,71 @@ do {								\
 		snprintf(buf, size, _f" (%s)", value, __s);	\
 } while (0)
 #define print_id_unsigned(_s)	PRINT_ID(_s, "%"PRIu64)
+#define print_id_hex(_s)	PRINT_ID(_s, "%#"PRIx64)
 
 static void __p_type_id(char *buf, size_t size, u64 value)
 {
 	print_id_unsigned(stringify_perf_type_id(value));
 }
 
+static void __p_config_hw_id(char *buf, size_t size, u64 value)
+{
+	print_id_hex(stringify_perf_hw_id(value));
+}
+
+static void __p_config_sw_id(char *buf, size_t size, u64 value)
+{
+	print_id_hex(stringify_perf_sw_id(value));
+}
+
+static void __p_config_hw_cache_id(char *buf, size_t size, u64 value)
+{
+	const char *hw_cache_str = stringify_perf_hw_cache_id(value & 0xff);
+	const char *hw_cache_op_str =
+		stringify_perf_hw_cache_op_id((value & 0xff00) >> 8);
+	const char *hw_cache_op_result_str =
+		stringify_perf_hw_cache_op_result_id((value & 0xff0000) >> 16);
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
+	char *str = tracepoint_id_to_name(value);
+
+	print_id_hex(str);
+	free(str);
+}
+#endif
+
+static void __p_config_id(char *buf, size_t size, u32 type, u64 value)
+{
+	switch (type) {
+	case PERF_TYPE_HARDWARE:
+		return __p_config_hw_id(buf, size, value);
+	case PERF_TYPE_SOFTWARE:
+		return __p_config_sw_id(buf, size, value);
+	case PERF_TYPE_HW_CACHE:
+		return __p_config_hw_cache_id(buf, size, value);
+	case PERF_TYPE_TRACEPOINT:
+#ifdef HAVE_LIBTRACEEVENT
+		return __p_config_tracepoint_id(buf, size, value);
+#endif
+	case PERF_TYPE_RAW:
+	case PERF_TYPE_BREAKPOINT:
+	default:
+		snprintf(buf, size, "%#"PRIx64, value);
+		return;
+	}
+}
+
 #define BUF_SIZE		1024
 
 #define p_hex(val)		snprintf(buf, BUF_SIZE, "%#"PRIx64, (uint64_t)(val))
@@ -111,6 +246,7 @@ static void __p_type_id(char *buf, size_t size, u64 value)
 #define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
 #define p_read_format(val)	__p_read_format(buf, BUF_SIZE, val)
 #define p_type_id(val)		__p_type_id(buf, BUF_SIZE, val)
+#define p_config_id(val)	__p_config_id(buf, BUF_SIZE, attr->type, val)
 
 #define PRINT_ATTRn(_n, _f, _p, _a)			\
 do {							\
@@ -130,7 +266,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 
 	PRINT_ATTRn("type", type, p_type_id, true);
 	PRINT_ATTRf(size, p_unsigned);
-	PRINT_ATTRf(config, p_hex);
+	PRINT_ATTRn("config", config, p_config_id, true);
 	PRINT_ATTRn("{ sample_period, sample_freq }", sample_period, p_unsigned, false);
 	PRINT_ATTRf(sample_type, p_sample_type);
 	PRINT_ATTRf(read_format, p_read_format);
-- 
2.30.GIT


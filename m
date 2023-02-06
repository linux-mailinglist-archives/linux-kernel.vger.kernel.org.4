Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F9C68B5D8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 07:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBFGxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 01:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBFGxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:53:10 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2969A768D;
        Sun,  5 Feb 2023 22:53:07 -0800 (PST)
Received: from dggpeml500019.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4P9H0F6GJczkXsZ;
        Mon,  6 Feb 2023 14:48:29 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Feb 2023 14:53:04 +0800
From:   Jie Zhan <zhanjie9@hisilicon.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <john.g.garry@oracle.com>, <james.clark@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <corbet@lwn.net>, <jonathan.cameron@huawei.com>
CC:     <zhangshaokun@hisilicon.com>, <shenyang39@huawei.com>,
        <hejunhao3@huawei.com>, <yangyicong@hisilicon.com>,
        <prime.zeng@huawei.com>, <zhanjie9@hisilicon.com>,
        <suntao25@huawei.com>, <jiazhao4@hisilicon.com>,
        <linuxarm@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
Subject: [RFC PATCH v1 4/4] perf tool: Add HiSilicon PMCU data decoding support
Date:   Mon, 6 Feb 2023 14:51:46 +0800
Message-ID: <20230206065146.645505-5-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230206065146.645505-1-zhanjie9@hisilicon.com>
References: <20230206065146.645505-1-zhanjie9@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for dumping raw trace of HiSilicon PMCU data using 'perf-report'
or 'perf-script'

Example usage:

 # perf report -D

Output will contain the raw PMCU data with notes, such as:

. ... HISI PMCU data: size 0x9630 bytes
. ... Header: size 0x30 bytes
.  00000000:  00 00 40 00 04 00 00 00 08 00 00 00 00 00 00 00
.  00000010:  80 01 00 00 01 00 00 00 04 00 00 00 10 00 00 00
.  00000020:  11 00 00 00 12 00 00 00 13 00 00 00 00 00 00 00
.  Auxtrace buffer max size: 0x400000
.  Number of PMU counters in parallel: 4
.  Number of monitored CPUs: 8
.  Compatible mode: no
.  Subsample size: 0x180
.  Number of subsamples per sample: 1
.  Number of events: 4
.  Event   0: 0x0010
.  Event   1: 0x0011
.  Event   2: 0x0012
.  Event   3: 0x0013
. ... Data: size 0x9600 bytes
.  Sample 0
.    Subsample 0
.    00000030:  00000000            PMCID0SR CPU 0
.    00000034:  00000000            PMCID0SR CPU 1
.    00000038:  00000000            PMCID0SR CPU 2
.    0000003c:  00000000            PMCID0SR CPU 3
.    00000040:  00000000            PMCID0SR CPU 4
.    00000044:  00000000            PMCID0SR CPU 5
.    00000048:  00000000            PMCID0SR CPU 6
.    0000004c:  00000000            PMCID0SR CPU 7
.    00000050:  000000ba            PMCID1SR CPU 0
.    00000054:  000056fe            PMCID1SR CPU 1
.    00000058:  00000000            PMCID1SR CPU 2
.    0000005c:  00000000            PMCID1SR CPU 3
.    00000060:  00000195            PMCID1SR CPU 4
.    00000064:  000056fc            PMCID1SR CPU 5
.    00000068:  00000000            PMCID1SR CPU 6
.    0000006c:  00000000            PMCID1SR CPU 7
.    00000070:  0000000000000000    Event 0010 CPU 0
.    00000078:  0000000000000000    Event 0010 CPU 1
.    00000080:  0000000000000000    Event 0010 CPU 2
.    00000088:  0000000000000000    Event 0010 CPU 3
.    00000090:  0000000000000000    Event 0010 CPU 4
.    00000098:  0000000000000001    Event 0010 CPU 5
.    000000a0:  0000000000000000    Event 0010 CPU 6
.    000000a8:  0000000000000000    Event 0010 CPU 7
.    000000b0:  0000000000000000    Event 0011 CPU 0
.    000000b8:  0000000000000000    Event 0011 CPU 1
.    000000c0:  0000000000000000    Event 0011 CPU 2
.    000000c8:  0000000000000000    Event 0011 CPU 3
.    000000d0:  000000000000d614    Event 0011 CPU 4
.    000000d8:  000000000000046b    Event 0011 CPU 5
.    000000e0:  0000000000000000    Event 0011 CPU 6
.    000000e8:  0000000000000000    Event 0011 CPU 7
.    000000f0:  0000000000000000    Event 0012 CPU 0
.    000000f8:  0000000000000000    Event 0012 CPU 1
.    00000100:  0000000000000000    Event 0012 CPU 2
.    00000108:  0000000000000000    Event 0012 CPU 3
.    00000110:  00000000000000f4    Event 0012 CPU 4
.    00000118:  0000000000000003    Event 0012 CPU 5
.    00000120:  0000000000000000    Event 0012 CPU 6
.    00000128:  0000000000000000    Event 0012 CPU 7
.    00000130:  0000000000000000    Event 0013 CPU 0
.    00000138:  0000000000000000    Event 0013 CPU 1
.    00000140:  0000000000000000    Event 0013 CPU 2
.    00000148:  0000000000000000    Event 0013 CPU 3
.    00000150:  00000000000000f4    Event 0013 CPU 4
.    00000158:  0000000000000004    Event 0013 CPU 5
.    00000160:  0000000000000000    Event 0013 CPU 6
.    00000168:  0000000000000000    Event 0013 CPU 7
.    00000170:  000000000000d614    Cycle count CPU 0
.    00000178:  000000000000d614    Cycle count CPU 1
.    00000180:  0000000000000000    Cycle count CPU 2
.    00000188:  0000000000000000    Cycle count CPU 3
.    00000190:  000000000000d614    Cycle count CPU 4
.    00000198:  000000000000d614    Cycle count CPU 5
.    000001a0:  0000000000000000    Cycle count CPU 6
.    000001a8:  0000000000000000    Cycle count CPU 7
(...more data follows)

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 tools/perf/util/Build       |   1 +
 tools/perf/util/auxtrace.c  |   4 +
 tools/perf/util/hisi-pmcu.c | 305 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/hisi-pmcu.h |   2 +
 4 files changed, 312 insertions(+)
 create mode 100644 tools/perf/util/hisi-pmcu.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index e315ecaec323..e062a2c1b962 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -120,6 +120,7 @@ perf-$(CONFIG_AUXTRACE) += arm-spe.o
 perf-$(CONFIG_AUXTRACE) += arm-spe-decoder/
 perf-$(CONFIG_AUXTRACE) += hisi-ptt.o
 perf-$(CONFIG_AUXTRACE) += hisi-ptt-decoder/
+perf-$(CONFIG_AUXTRACE) += hisi-pmcu.o
 perf-$(CONFIG_AUXTRACE) += s390-cpumsf.o
 
 ifdef CONFIG_LIBOPENCSD
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 46ada5ec3f9a..ac19220d307e 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -53,6 +53,7 @@
 #include "intel-bts.h"
 #include "arm-spe.h"
 #include "hisi-ptt.h"
+#include "hisi-pmcu.h"
 #include "s390-cpumsf.h"
 #include "util/mmap.h"
 
@@ -1324,6 +1325,9 @@ int perf_event__process_auxtrace_info(struct perf_session *session,
 	case PERF_AUXTRACE_HISI_PTT:
 		err = hisi_ptt_process_auxtrace_info(event, session);
 		break;
+	case PERF_AUXTRACE_HISI_PMCU:
+		err = hisi_pmcu_process_auxtrace_info(event, session);
+		break;
 	case PERF_AUXTRACE_UNKNOWN:
 	default:
 		return -EINVAL;
diff --git a/tools/perf/util/hisi-pmcu.c b/tools/perf/util/hisi-pmcu.c
new file mode 100644
index 000000000000..7e0b41cd464d
--- /dev/null
+++ b/tools/perf/util/hisi-pmcu.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * HiSilicon Performance Monitor Control Unit (PMCU) support
+ *
+ * Copyright (C) 2022 HiSilicon Limited
+ */
+
+#include <errno.h>
+#include <linux/math.h>
+#include <linux/types.h>
+#include <linux/zalloc.h>
+#include <perf/event.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "auxtrace.h"
+#include "color.h"
+#include "debug.h"
+#include "event.h"
+#include "evsel.h"
+#include "hisi-pmcu.h"
+#include "session.h"
+#include "tool.h"
+#include <internal/lib.h>
+
+#define HISI_PMCU_AUX_HEADER_ALIGN	0x10
+#define HISI_PMCU_NR_CPU_CLUSTER	8
+#define dump_print(fmt, ...) \
+	color_fprintf(stdout, PERF_COLOR_BLUE, fmt, ##__VA_ARGS__)
+
+enum hisi_pmcu_auxtrace_header_index {
+	HISI_PMCU_HEADER_BUFFER_SIZE,
+	HISI_PMCU_HEADER_NR_PMU,
+	HISI_PMCU_HEADER_NR_CPU,
+	HISI_PMCU_HEADER_COMP_MODE,
+	HISI_PMCU_HEADER_SUBSAMPLE_SIZE,
+	HISI_PMCU_HEADER_NR_SUBSAMPLE_PER_SAMPLE,
+	HISI_PMCU_HEADER_NR_EVENT,
+	HISI_PMCU_HEADER_MAX
+};
+
+struct hisi_pmcu_aux_header_info {
+	u32 buffer_size;
+	u32 nr_pmu;
+	u32 nr_cpu;
+	u32 comp_mode;
+	u32 subsample_size;
+	u32 nr_subsample_per_sample;
+	u32 nr_event;
+	u32 events[];
+};
+
+struct hisi_pmcu_process {
+	u32 pmu_type;
+	struct auxtrace auxtrace;
+	struct hisi_pmcu_aux_header_info *header;
+};
+
+static int hisi_pmcu_process_event(struct perf_session *session __maybe_unused,
+				   union perf_event *event __maybe_unused,
+				   struct perf_sample *sample __maybe_unused,
+				   struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static int hisi_pmcu_process_header(struct hisi_pmcu_process *pmcu,
+				    const unsigned char *__data, u64 size)
+{
+	struct hisi_pmcu_aux_header_info *header;
+	const u32 *data = (const u32 *) __data;
+	unsigned int i, j;
+	u32 read_size;
+
+	read_size = HISI_PMCU_HEADER_MAX * sizeof(*data);
+	if (size < read_size)
+		return -EINVAL;
+
+	read_size += data[HISI_PMCU_HEADER_NR_EVENT] * sizeof(*data);
+	if (size < read_size)
+		return -EINVAL;
+
+	pmcu->header = malloc(read_size);
+	header = pmcu->header;
+	memcpy(header, data, read_size);
+	read_size = round_up(read_size, HISI_PMCU_AUX_HEADER_ALIGN);
+
+	dump_print(". ... Header: size 0x%lx bytes\n", read_size);
+	for (i = 0; i < read_size; i += HISI_PMCU_AUX_HEADER_ALIGN) {
+		dump_print(".  %08lx:  ", i);
+		for (j = 0; j < HISI_PMCU_AUX_HEADER_ALIGN; j++)
+			dump_print("%02x ", __data[i + j]);
+		dump_print("\n");
+	}
+
+	dump_print(".  Auxtrace buffer max size: 0x%lx\n", header->buffer_size);
+	dump_print(".  Number of PMU counters in parallel: %d\n", header->nr_pmu);
+	dump_print(".  Number of monitored CPUs: %d\n", header->nr_cpu);
+	dump_print(".  Compatible mode: %s\n", header->comp_mode ? "yes" : "no");
+	dump_print(".  Subsample size: 0x%lx\n", header->subsample_size);
+	dump_print(".  Number of subsamples per sample: %d\n", header->nr_subsample_per_sample);
+	dump_print(".  Number of events: %d\n", header->nr_event);
+
+	for (i = 0; i < header->nr_event; i++)
+		dump_print(".  Event %3d: 0x%04x\n", i, header->events[i]);
+
+	return read_size;
+}
+
+static int hisi_pmcu_dump_subsample(struct hisi_pmcu_aux_header_info *header,
+				    const unsigned char *data, u64 offset,
+				    u32 evoffset)
+{
+	int nr_cluster, core, cid, i;
+	u32 pos = 0, event;
+
+	nr_cluster = header->nr_cpu / HISI_PMCU_NR_CPU_CLUSTER;
+
+	for (cid = 0; cid < 2; cid++) {
+		for (core = 0; core < HISI_PMCU_NR_CPU_CLUSTER; core++) {
+			for (i = 0; i < nr_cluster; i++) {
+				dump_print(".    %08lx:  %08lx            PMCID%dSR CPU %d\n",
+					   offset + pos, *(u32 *) (data + pos),
+					   cid,
+					   core + i * HISI_PMCU_NR_CPU_CLUSTER);
+				pos += sizeof(u32);
+			}
+		}
+	}
+
+	for (event = 0; event < header->nr_pmu; event++) {
+		for (core = 0; core < HISI_PMCU_NR_CPU_CLUSTER; core++) {
+			for (i = 0; i < nr_cluster; i++) {
+				dump_print(".    %08lx:  %016llx    Event %04lx CPU %d\n",
+					   offset + pos, *(u64 *) (data + pos),
+					   header->events[event + evoffset],
+					   core + i * HISI_PMCU_NR_CPU_CLUSTER);
+				pos += sizeof(u64);
+			}
+		}
+	}
+
+	if (!header->comp_mode) {
+		for (core = 0; core < HISI_PMCU_NR_CPU_CLUSTER; core++) {
+			for (i = 0; i < nr_cluster; i++) {
+				dump_print(".    %08lx:  %016llx    Cycle count CPU %d\n",
+					   offset + pos, *(u64 *) (data + pos),
+					   core + i * HISI_PMCU_NR_CPU_CLUSTER);
+				pos += sizeof(u64);
+			}
+		}
+	}
+
+	return pos;
+}
+
+static int hisi_pmcu_dump_sample(struct hisi_pmcu_aux_header_info *header,
+				 const unsigned char *data, u64 offset)
+{
+	u32 pos = 0, i = 0;
+
+	while (i < header->nr_subsample_per_sample) {
+		dump_print(".    Subsample %d\n", i + 1);
+		pos += hisi_pmcu_dump_subsample(header, data + pos,
+						offset + pos,
+						i * header->nr_pmu);
+		i++;
+	}
+
+	return pos;
+}
+
+static int hisi_pmcu_dump_data(struct hisi_pmcu_process *pmcu,
+			       const unsigned char *data, u64 size)
+{
+	struct hisi_pmcu_aux_header_info *header;
+	u32 sample_size;
+	u32 nr_sample;
+	u64 pos = 0;
+	int ret;
+
+	dump_print(". ... HISI PMCU data: size 0x%lx bytes\n", size);
+
+	ret = hisi_pmcu_process_header(pmcu, data, size);
+	if (ret < 0)
+		return ret;
+
+	pos += ret;
+
+	header = pmcu->header;
+	sample_size = header->subsample_size * header->nr_subsample_per_sample;
+	nr_sample = 1;
+	dump_print(". ... Data: size 0x%lx bytes\n", size - pos);
+	while (pos < size) {
+		u32 buf_remain;
+
+		dump_print(".  Sample %d\n", nr_sample);
+		pos += hisi_pmcu_dump_sample(header, data + pos, pos);
+		nr_sample++;
+
+		// Skip gap at the end of an auxtrace buffer
+		buf_remain = header->buffer_size - pos % header->buffer_size;
+		if (buf_remain < sample_size)
+			pos += buf_remain;
+	}
+
+	return 0;
+}
+
+static int hisi_pmcu_process_auxtrace_event(struct perf_session *session,
+					    union perf_event *event,
+					    struct perf_tool *tool __maybe_unused)
+{
+	struct hisi_pmcu_process *pmcu_process;
+	void *data;
+	u64 size;
+	int fd;
+
+	if (!dump_trace)
+		return 0;
+
+	size = event->auxtrace.size;
+	if (!size)
+		return 0;
+
+	data = malloc(size);
+	if (!data)
+		return -errno;
+
+	fd = perf_data__fd(session->data);
+
+	if (readn(fd, data, size) < 0) {
+		free(data);
+		return -errno;
+	}
+
+	pmcu_process = container_of(session->auxtrace,
+				    struct hisi_pmcu_process, auxtrace);
+
+	return hisi_pmcu_dump_data(pmcu_process, data, size);
+}
+
+static int hisi_pmcu_flush_events(struct perf_session *session __maybe_unused,
+				  struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static void hisi_pmcu_free_events(struct perf_session *session __maybe_unused)
+{
+}
+
+static void hisi_pmcu_free(struct perf_session *session)
+{
+	struct hisi_pmcu_process *pmcu_process;
+
+	pmcu_process = container_of(session->auxtrace,
+				    struct hisi_pmcu_process, auxtrace);
+
+	session->auxtrace = NULL;
+	free(pmcu_process);
+}
+
+static bool hisi_pmcu_evsel_is_auxtrace(struct perf_session *session,
+					struct evsel *evsel)
+{
+	struct hisi_pmcu_process *pmcu_process;
+
+	pmcu_process = container_of(session->auxtrace,
+				    struct hisi_pmcu_process, auxtrace);
+
+	return evsel->core.attr.type == pmcu_process->pmu_type;
+}
+
+int hisi_pmcu_process_auxtrace_info(union perf_event *event,
+				    struct perf_session *session)
+{
+	struct perf_record_auxtrace_info *auxtrace_info;
+	struct hisi_pmcu_process *pmcu_process;
+
+	auxtrace_info = &event->auxtrace_info;
+
+	if (auxtrace_info->header.size < sizeof(*auxtrace_info) +
+					 HISI_PMCU_AUXTRACE_PRIV_SIZE)
+		return -EINVAL;
+
+	pmcu_process = zalloc(sizeof(*pmcu_process));
+	if (!pmcu_process)
+		return -ENOMEM;
+
+	pmcu_process->pmu_type = auxtrace_info->priv[0];
+
+	pmcu_process->auxtrace = (struct auxtrace) {
+		.process_event =  hisi_pmcu_process_event,
+		.process_auxtrace_event = hisi_pmcu_process_auxtrace_event,
+		.flush_events = hisi_pmcu_flush_events,
+		.free_events = hisi_pmcu_free_events,
+		.free = hisi_pmcu_free,
+		.evsel_is_auxtrace = hisi_pmcu_evsel_is_auxtrace,
+	};
+
+	session->auxtrace = &pmcu_process->auxtrace;
+
+	return 0;
+}
diff --git a/tools/perf/util/hisi-pmcu.h b/tools/perf/util/hisi-pmcu.h
index d46d523a3aee..8df74695164b 100644
--- a/tools/perf/util/hisi-pmcu.h
+++ b/tools/perf/util/hisi-pmcu.h
@@ -14,4 +14,6 @@
 struct auxtrace_record *hisi_pmcu_recording_init(int *err,
 					struct perf_pmu *hisi_pmcu_pmu);
 
+int hisi_pmcu_process_auxtrace_info(union perf_event *event,
+				    struct perf_session *session);
 #endif
-- 
2.30.0


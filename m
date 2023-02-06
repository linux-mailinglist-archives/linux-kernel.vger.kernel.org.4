Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0B368B5D0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 07:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjBFGxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 01:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjBFGxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:53:08 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4389C7691;
        Sun,  5 Feb 2023 22:53:06 -0800 (PST)
Received: from dggpeml500019.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P9H3262JJznW2L;
        Mon,  6 Feb 2023 14:50:54 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Feb 2023 14:53:03 +0800
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
Subject: [RFC PATCH v1 3/4] perf tool: Add HiSilicon PMCU data recording support
Date:   Mon, 6 Feb 2023 14:51:45 +0800
Message-ID: <20230206065146.645505-4-zhanjie9@hisilicon.com>
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

Support for HiSilicon PMCU data recording using 'perf-record'.

Users can start PMCU profiling through 'perf-record'. Event numbers are
passed by a sysfs interface. The following optional parameters can be
passed through 'perf-record':
- nr_sample: number of samples to take
- sample_period_ms: time in ms for PMU counters to stay on for an event
- pmccfiltr: bits[31-24] of system register PMCCFILTR_EL0

Example usage:

1. Enter event numbers in the 'user_events' file:

	echo "0x10 0x11" > /sys/devices/hisi_pmcu_sccl3/user_events

2. Start the sampling with 'perf-record':

	perf record -e hisi_pmcu_sccl3/nr_sample=1000,sample_period_ms=1/

In this example, the PMCU takes 1000 samples of event 0x0010 and 0x0011
with a sampling period of 1ms. Data will be written to a 'perf.data' file.

Co-developed-by: Yang Shen <shenyang39@huawei.com>
Signed-off-by: Yang Shen <shenyang39@huawei.com>
Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 tools/perf/arch/arm/util/auxtrace.c    |  61 +++++++++++
 tools/perf/arch/arm64/util/Build       |   2 +-
 tools/perf/arch/arm64/util/hisi-pmcu.c | 145 +++++++++++++++++++++++++
 tools/perf/util/auxtrace.h             |   1 +
 tools/perf/util/hisi-pmcu.h            |  17 +++
 5 files changed, 225 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/arch/arm64/util/hisi-pmcu.c
 create mode 100644 tools/perf/util/hisi-pmcu.h

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index deeb163999ce..05307c325137 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -17,6 +17,7 @@
 #include "cs-etm.h"
 #include "arm-spe.h"
 #include "hisi-ptt.h"
+#include "hisi-pmcu.h"
 
 static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
 {
@@ -99,6 +100,52 @@ static struct perf_pmu **find_all_hisi_ptt_pmus(int *nr_ptts, int *err)
 	return hisi_ptt_pmus;
 }
 
+static struct perf_pmu **find_all_hisi_pmcu_pmus(int *nr_pmcus, int *err)
+{
+	const char *sysfs = sysfs__mountpoint();
+	struct perf_pmu **hisi_pmcu_pmus = NULL;
+	struct dirent *dent;
+	char path[PATH_MAX];
+	DIR *dir = NULL;
+	int idx = 0;
+
+	snprintf(path, PATH_MAX, "%s" EVENT_SOURCE_DEVICE_PATH, sysfs);
+	dir = opendir(path);
+	if (!dir) {
+		pr_err("can't read directory '%s'\n", EVENT_SOURCE_DEVICE_PATH);
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	while ((dent = readdir(dir))) {
+		if (strstr(dent->d_name, HISI_PMCU_PMU_NAME))
+			(*nr_pmcus)++;
+	}
+
+	if (!(*nr_pmcus))
+		goto out;
+
+	hisi_pmcu_pmus = zalloc(sizeof(struct perf_pmu *) * (*nr_pmcus));
+	if (!hisi_pmcu_pmus) {
+		pr_err("hisi_pmcu alloc failed\n");
+		*err = -ENOMEM;
+		goto out;
+	}
+
+	rewinddir(dir);
+	while ((dent = readdir(dir))) {
+		if (strstr(dent->d_name, HISI_PMCU_PMU_NAME) && idx < *nr_pmcus) {
+			hisi_pmcu_pmus[idx] = perf_pmu__find(dent->d_name);
+			if (hisi_pmcu_pmus[idx])
+				idx++;
+		}
+	}
+
+out:
+	closedir(dir);
+	return hisi_pmcu_pmus;
+}
+
 static struct perf_pmu *find_pmu_for_event(struct perf_pmu **pmus,
 					   int pmu_nr, struct evsel *evsel)
 {
@@ -121,13 +168,16 @@ struct auxtrace_record
 	struct perf_pmu	*cs_etm_pmu = NULL;
 	struct perf_pmu **arm_spe_pmus = NULL;
 	struct perf_pmu **hisi_ptt_pmus = NULL;
+	struct perf_pmu **hisi_pmcu_pmus = NULL;
 	struct evsel *evsel;
 	struct perf_pmu *found_etm = NULL;
 	struct perf_pmu *found_spe = NULL;
 	struct perf_pmu *found_ptt = NULL;
+	struct perf_pmu *found_pmcu = NULL;
 	int auxtrace_event_cnt = 0;
 	int nr_spes = 0;
 	int nr_ptts = 0;
+	int nr_pmcus = 0;
 
 	if (!evlist)
 		return NULL;
@@ -135,6 +185,7 @@ struct auxtrace_record
 	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
 	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
 	hisi_ptt_pmus = find_all_hisi_ptt_pmus(&nr_ptts, err);
+	hisi_pmcu_pmus = find_all_hisi_pmcu_pmus(&nr_pmcus, err);
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (cs_etm_pmu && !found_etm)
@@ -145,10 +196,14 @@ struct auxtrace_record
 
 		if (hisi_ptt_pmus && !found_ptt)
 			found_ptt = find_pmu_for_event(hisi_ptt_pmus, nr_ptts, evsel);
+
+		if (hisi_pmcu_pmus && !found_pmcu)
+			found_pmcu = find_pmu_for_event(hisi_pmcu_pmus, nr_pmcus, evsel);
 	}
 
 	free(arm_spe_pmus);
 	free(hisi_ptt_pmus);
+	free(hisi_pmcu_pmus);
 
 	if (found_etm)
 		auxtrace_event_cnt++;
@@ -159,6 +214,9 @@ struct auxtrace_record
 	if (found_ptt)
 		auxtrace_event_cnt++;
 
+	if (found_pmcu)
+		auxtrace_event_cnt++;
+
 	if (auxtrace_event_cnt > 1) {
 		pr_err("Concurrent AUX trace operation not currently supported\n");
 		*err = -EOPNOTSUPP;
@@ -174,6 +232,9 @@ struct auxtrace_record
 
 	if (found_ptt)
 		return hisi_ptt_recording_init(err, found_ptt);
+
+	if (found_pmcu)
+		return hisi_pmcu_recording_init(err, found_pmcu);
 #endif
 
 	/*
diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 337aa9bdf905..daba9e6ae054 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -11,4 +11,4 @@ perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 perf-$(CONFIG_AUXTRACE) += ../../arm/util/pmu.o \
 			      ../../arm/util/auxtrace.o \
 			      ../../arm/util/cs-etm.o \
-			      arm-spe.o mem-events.o hisi-ptt.o
+			      arm-spe.o mem-events.o hisi-ptt.o hisi-pmcu.o
diff --git a/tools/perf/arch/arm64/util/hisi-pmcu.c b/tools/perf/arch/arm64/util/hisi-pmcu.c
new file mode 100644
index 000000000000..7c33abf1182d
--- /dev/null
+++ b/tools/perf/arch/arm64/util/hisi-pmcu.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * HiSilicon Performance Monitor Control Unit (PMCU) support
+ *
+ * Copyright (C) 2022 HiSilicon Limited
+ */
+
+#include <linux/kernel.h>
+#include <linux/log2.h>
+#include <linux/types.h>
+#include <linux/zalloc.h>
+#include <time.h>
+#include <math.h>
+#include <internal/lib.h>
+#include <internal/threadmap.h>
+
+#include "../../../util/auxtrace.h"
+#include "../../../util/debug.h"
+#include "../../../util/event.h"
+#include "../../../util/evlist.h"
+#include "../../../util/hisi-pmcu.h"
+#include "../../../util/pmu.h"
+#include "../../../util/record.h"
+#include "../../../util/session.h"
+#include "../../../util/thread_map.h"
+
+#define KiB(x) ((x) * 1024)
+#define MiB(x) ((x) * 1024 * 1024)
+#define HISI_PMCU_DATA_ALIGNMENT	4
+
+struct hisi_pmcu_record {
+	struct auxtrace_record itr;
+	struct perf_pmu *hisi_pmcu_pmu;
+	struct evlist *evlist;
+};
+
+static int hisi_pmcu_recording_options(struct auxtrace_record *itr,
+				       struct evlist *evlist,
+				       struct record_opts *opts)
+{
+	struct hisi_pmcu_record *pmcu_record =
+			container_of(itr, struct hisi_pmcu_record, itr);
+	struct perf_pmu *hisi_pmcu_pmu = pmcu_record->hisi_pmcu_pmu;
+	struct evsel *hisi_pmcu_evsel = NULL;
+	struct evsel *evsel;
+
+	if (!perf_event_paranoid_check(-1))
+		return -EPERM;
+
+	pmcu_record->evlist = evlist;
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.attr.type == hisi_pmcu_pmu->type) {
+			if (hisi_pmcu_evsel) {
+				pr_err("Only one event allowed on a PMCU\n");
+				return -EINVAL;
+			}
+			evsel->core.attr.sample_period = 1;
+			evsel->core.attr.freq = false;
+			evsel->needs_auxtrace_mmap = true;
+			opts->full_auxtrace = true;
+			hisi_pmcu_evsel = evsel;
+		}
+	}
+
+	opts->auxtrace_mmap_pages = MiB(16) / page_size;
+
+	/*
+	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
+	 * must come first.
+	 */
+	evlist__to_front(evlist, hisi_pmcu_evsel);
+	evsel__set_sample_bit(hisi_pmcu_evsel, TIME);
+
+	return 0;
+}
+
+static size_t hisi_pmcu_info_priv_size(struct auxtrace_record *itr __maybe_unused,
+				       struct evlist *evlist __maybe_unused)
+{
+	return HISI_PMCU_AUXTRACE_PRIV_SIZE;
+}
+
+static int hisi_pmcu_info_fill(struct auxtrace_record *itr,
+			       struct perf_session *session,
+			       struct perf_record_auxtrace_info *auxtrace_info,
+			       size_t priv_size)
+{
+	struct hisi_pmcu_record *pmcu_record =
+			container_of(itr, struct hisi_pmcu_record, itr);
+	struct perf_pmu *hisi_pmcu_pmu = pmcu_record->hisi_pmcu_pmu;
+
+	if (priv_size != HISI_PMCU_AUXTRACE_PRIV_SIZE)
+		return -EINVAL;
+
+	if (!session->evlist->core.nr_mmaps)
+		return -EINVAL;
+
+	auxtrace_info->type = PERF_AUXTRACE_HISI_PMCU;
+	auxtrace_info->priv[0] = hisi_pmcu_pmu->type;
+
+	return 0;
+}
+
+static void hisi_pmcu_record_free(struct auxtrace_record *itr)
+{
+	struct hisi_pmcu_record *pmcu_record =
+			container_of(itr, struct hisi_pmcu_record, itr);
+
+	free(pmcu_record);
+}
+
+static u64 hisi_pmcu_reference(struct auxtrace_record *itr __maybe_unused)
+{
+	return 0;
+}
+
+struct auxtrace_record *hisi_pmcu_recording_init(int *err,
+						 struct perf_pmu *hisi_pmcu_pmu)
+{
+	struct hisi_pmcu_record *pmcu_record;
+
+	if (!hisi_pmcu_pmu) {
+		*err = -ENODEV;
+		return NULL;
+	}
+
+	pmcu_record = zalloc(sizeof(*pmcu_record));
+	if (!pmcu_record) {
+		*err = -ENOMEM;
+		return NULL;
+	}
+
+	pmcu_record->hisi_pmcu_pmu = hisi_pmcu_pmu;
+	pmcu_record->itr.recording_options = hisi_pmcu_recording_options;
+	pmcu_record->itr.info_priv_size = hisi_pmcu_info_priv_size;
+	pmcu_record->itr.info_fill = hisi_pmcu_info_fill;
+	pmcu_record->itr.free = hisi_pmcu_record_free;
+	pmcu_record->itr.reference = hisi_pmcu_reference;
+	pmcu_record->itr.read_finish = auxtrace_record__read_finish;
+	pmcu_record->itr.alignment = HISI_PMCU_DATA_ALIGNMENT;
+	pmcu_record->itr.pmu = hisi_pmcu_pmu;
+
+	*err = 0;
+	return &pmcu_record->itr;
+}
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 6a0f9b98f059..89b2b14407f5 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -49,6 +49,7 @@ enum auxtrace_type {
 	PERF_AUXTRACE_ARM_SPE,
 	PERF_AUXTRACE_S390_CPUMSF,
 	PERF_AUXTRACE_HISI_PTT,
+	PERF_AUXTRACE_HISI_PMCU,
 };
 
 enum itrace_period_type {
diff --git a/tools/perf/util/hisi-pmcu.h b/tools/perf/util/hisi-pmcu.h
new file mode 100644
index 000000000000..d46d523a3aee
--- /dev/null
+++ b/tools/perf/util/hisi-pmcu.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * HiSilicon Performance Monitor Control Unit (PMCU) support
+ *
+ * Copyright (C) 2022 HiSilicon Limited
+ */
+
+#ifndef INCLUDE__PERF_HISI_PMCU_H__
+#define INCLUDE__PERF_HISI_PMCU_H__
+
+#define HISI_PMCU_PMU_NAME		"hisi_pmcu"
+#define HISI_PMCU_AUXTRACE_PRIV_SIZE	sizeof(u64)
+
+struct auxtrace_record *hisi_pmcu_recording_init(int *err,
+					struct perf_pmu *hisi_pmcu_pmu);
+
+#endif
-- 
2.30.0


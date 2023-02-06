Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE17568B5D5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 07:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjBFGxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 01:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjBFGxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:53:10 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C7B11179;
        Sun,  5 Feb 2023 22:53:05 -0800 (PST)
Received: from dggpeml500019.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4P9H3339Dfz16NNC;
        Mon,  6 Feb 2023 14:50:55 +0800 (CST)
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
Subject: [RFC PATCH v1 2/4] drivers/perf: hisi: Add driver support for HiSilicon PMCU
Date:   Mon, 6 Feb 2023 14:51:44 +0800
Message-ID: <20230206065146.645505-3-zhanjie9@hisilicon.com>
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

HiSilicon Performance Monitor Control Unit (PMCU) is a device that offloads
PMU accesses from CPUs, handling the configuration, event switching, and
counter reading of core PMUs on Kunpeng SoC. It facilitates fine-grained
and multi-PMU-event CPU profiling, in which scenario the current 'perf'
scheme may lose events or drop sampling frequency. With PMCU, users can
reliably obtain the data of up to 240 PMU events with the sample interval
of events down to 1ms, while the software overhead of accessing PMUs, as
well as its impact on target workloads, is reduced.

This driver enables the usage of PMCU through the perf_event framework.
PMCU is registered as a PMU device and utilises the AUX buffer to dump data
directly. Users can start PMCU sampling through 'perf-record'. Event
numbers are passed by a sysfs interface.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/perf/hisilicon/Kconfig     |   15 +
 drivers/perf/hisilicon/Makefile    |    1 +
 drivers/perf/hisilicon/hisi_pmcu.c | 1096 ++++++++++++++++++++++++++++
 3 files changed, 1112 insertions(+)
 create mode 100644 drivers/perf/hisilicon/hisi_pmcu.c

diff --git a/drivers/perf/hisilicon/Kconfig b/drivers/perf/hisilicon/Kconfig
index 171bfc1b6bc2..d7728fbe8519 100644
--- a/drivers/perf/hisilicon/Kconfig
+++ b/drivers/perf/hisilicon/Kconfig
@@ -24,3 +24,18 @@ config HNS3_PMU
 	  devices.
 	  Adds the HNS3 PMU into perf events system for monitoring latency,
 	  bandwidth etc.
+
+config HISI_PMCU
+	tristate "HiSilicon PMCU"
+	depends on ARM64 && PID_IN_CONTEXTIDR
+	help
+	  Support for HiSilicon Performance Monitor Control Unit (PMCU).
+	  HiSilicon Performance Monitor Control Unit (PMCU) is a device that
+	  offloads PMU accesses from CPUs, handling the configuration, event
+	  switching, and counter reading of core PMUs on Kunpeng SoC. It
+	  facilitates fine-grained and multi-PMU-event CPU profiling, in which
+	  scenario the current 'perf' scheme may lose events or drop sampling
+	  frequency. With PMCU, users can reliably obtain the data of up to 240
+	  PMU events with the sample interval of events down to 1ms, while the
+	  software overhead of accessing PMUs, as well as its impact on target
+	  workloads, is reduced.
diff --git a/drivers/perf/hisilicon/Makefile b/drivers/perf/hisilicon/Makefile
index 4d2c9abe3372..93e4e6f2816a 100644
--- a/drivers/perf/hisilicon/Makefile
+++ b/drivers/perf/hisilicon/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_HISI_PMU) += hisi_uncore_pmu.o hisi_uncore_l3c_pmu.o \
 
 obj-$(CONFIG_HISI_PCIE_PMU) += hisi_pcie_pmu.o
 obj-$(CONFIG_HNS3_PMU) += hns3_pmu.o
+obj-$(CONFIG_HISI_PMCU) += hisi_pmcu.o
diff --git a/drivers/perf/hisilicon/hisi_pmcu.c b/drivers/perf/hisilicon/hisi_pmcu.c
new file mode 100644
index 000000000000..6ec5d6c31e1f
--- /dev/null
+++ b/drivers/perf/hisilicon/hisi_pmcu.c
@@ -0,0 +1,1096 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * HiSilicon Performance Monitor Control Unit (PMCU) driver
+ *
+ * Copyright (C) 2022 HiSilicon Limited
+ * Author: Jie Zhan <zhanjie9@hisilicon.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cpumask.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/gfp_types.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mm_types.h>
+#include <linux/module.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/threads.h>
+#include <linux/vmalloc.h>
+
+#include <asm/cputype.h>
+#include <asm/sysreg.h>
+
+/* Registers */
+#define HISI_PMCU_REG_FSM_STATUS	0x0000
+#define HISI_PMCU_REG_FSM_CFG		0x0004
+#define HISI_PMCU_REG_EVENT_BASE_H	0x0008
+#define HISI_PMCU_REG_EVENT_BASE_L	0x000C
+#define HISI_PMCU_REG_KILL_BASE_H	0x0010
+#define HISI_PMCU_REG_KILL_BASE_L	0x0014
+#define HISI_PMCU_REG_STORE_BASE_H	0x0018
+#define HISI_PMCU_REG_STORE_BASE_L	0x001C
+#define HISI_PMCU_REG_WAIT_CNT		0x0020
+#define HISI_PMCU_REG_FSM_CTRL		0x0038
+#define HISI_PMCU_REG_FSM_BRK		0x003C
+#define HISI_PMCU_REG_COMP		0x0044
+#define HISI_PMCU_REG_INT_EN		0x0100
+#define HISI_PMCU_REG_INT_MSK		0x0104
+#define HISI_PMCU_REG_INT_STAT		0x0108
+#define HISI_PMCU_REG_INT_CLR		0x010C
+#define HISI_PMCU_REG_PMCR		0x0200
+#define HISI_PMCU_REG_PMCCFILTR		0x0204
+
+/* Register related configs */
+#define HISI_PMCU_FSM_CFG_EV_LEN_MSK	GENMASK(7, 0)
+#define HISI_PMCU_FSM_CFG_NR_LOOP_MSK	GENMASK(15, 8)
+#define HISI_PMCU_FSM_CFG_NR_PMU_MSK	GENMASK(19, 16)
+#define HISI_PMCU_FSM_CFG_MAX_EV_LEN	240
+#define HISI_PMCU_FSM_CFG_MAX_NR_LOOP	255
+#define HISI_PMCU_FSM_CFG_MAX_NR_PMU	8
+#define HISI_PMCU_FSM_CFG_MAX_NR_PMU_C	5
+#define HISI_PMCU_WAIT_CNT_DEFAULT	0x249F0
+#define HISI_PMCU_FSM_CTRL_TRIGGER	BIT(0)
+#define HISI_PMCU_FSM_BRK_BRK		BIT(0)
+#define HISI_PMCU_COMP_HPMN_THR		3
+#define HISI_PMCU_COMP_ENABLE		BIT(0)
+#define HISI_PMCU_INT_DONE		BIT(0)
+#define HISI_PMCU_INT_BRK		BIT(1)
+#define HISI_PMCU_INT_ALL		GENMASK(1, 0)
+#define HISI_PMCU_PMCR_DEFAULT		0xC1
+#define HISI_PMCU_PMCCFILTR_MSK		GENMASK(31, 24)
+
+/* User perf_event_attr configs */
+#define HISI_PMCU_PERF_ATTR_NR_SAMPLE		GENMASK(31, 0)
+#define HISI_PMCU_PERF_NR_SAMPLE_DEFAULT	0x80
+#define HISI_PMCU_PERF_ATTR_SAMPLE_PERIOD_MS	GENMASK(63, 32)
+#define HISI_PMCU_PERF_MS_TO_WAIT_CNT		50000
+#define HISI_PMCU_PERF_MAX_SAMPLE_PERIOD_MS	(U32_MAX / \
+						 HISI_PMCU_PERF_MS_TO_WAIT_CNT)
+#define HISI_PMCU_PERF_ATTR_PMCCFILTR		GENMASK(7, 0)
+
+/* Others */
+#define HISI_PMCU_AUX_HEADER_ALIGN	0x10
+#define HISI_PMCU_BRK_DELAY_PERIOD_US	10
+#define HISI_PMCU_BRK_TIMEOUT_US	2000
+#define HISI_PMCU_DRV_NAME		"hisi-pmcu"
+#define NR_CPU_CLUSTER			8
+#define PMU_NULL_EVENT_ID		0xC000
+
+/**
+ * struct hisi_pmcu_sbuf - A single contiguous memory buffer
+ * @page:	starting page of this buffer
+ * @size:	size of this buffer
+ * @remain:	size of remaining space in this buffer
+ */
+struct hisi_pmcu_sbuf {
+	struct page *page;
+	u32 size;
+	u32 remain;
+};
+
+/**
+ * struct hisi_pmcu_buf - Management of multiple contiguous buffers
+ * @nr_buf:	number of buffers
+ * @cur_buf:	current working buffer
+ * @sbuf:	array of contiguous buffers
+ */
+struct hisi_pmcu_buf {
+	u32 nr_buf;
+	u32 cur_buf;
+	struct hisi_pmcu_sbuf sbuf[];
+};
+
+struct hisi_pmcu_auxtrace_header {
+	u32 buffer_size;
+	u32 nr_pmu;
+	u32 nr_cpu;
+	u32 comp_mode;
+	u32 subsample_size;
+	u32 nr_subsample_per_sample;
+	u32 nr_event;
+};
+
+/**
+ * struct hisi_pmcu_events - PMCU events and sampling configuration
+ * @nr_pmu:		number of core PMU counters that run in parallel
+ * @padding:		number of padding events in a sample
+ * @nr_ev:		number of events passed by users in a sample
+ * @nr_ev_per_sample:	number of events passed to hardware for a sample
+ *			This equals nr_ev + padding and should be evenly
+ *			divisible by nr_pmu.
+ * @max_sample_loop:	max number of samples that can be done in a loop
+ * @ev_len:		event length for hardware to read in a loop
+ * @nr_loop:		number of loops in one trigger
+ * @comp_mode:		compatibility mode
+ * @nr_sample:		number of samples that the current trigger takes
+ * @nr_pending_sample:	number of pending samples
+ * @subsample_size:	size of a subsample
+ * @sample_size:	size of a sample
+ * @output_size:	size of output from one trigger
+ * @sample_period:	sample period passed to hardware
+ * @nr_cpu:		number of hardware threads (logical CPUs)
+ * @events:		event IDs passed from users
+ */
+struct hisi_pmcu_events {
+	u8 nr_pmu;
+	u8 padding;
+	u8 nr_ev;
+	u8 nr_ev_per_sample;
+	u8 max_sample_loop;
+	u8 ev_len;
+	u8 nr_loop;
+	u8 comp_mode;
+	u32 nr_sample;
+	u32 nr_pending_sample;
+	u32 subsample_size;
+	u32 sample_size;
+	u32 output_size;
+	u32 sample_period;
+	u32 nr_cpu;
+	u32 events[HISI_PMCU_FSM_CFG_MAX_EV_LEN];
+};
+
+enum hisi_pmcu_comp_mode {
+	HISI_PMCU_COMP_MODE_DISABLED,
+	HISI_PMCU_COMP_MODE_ENABLED,
+	HISI_PMCU_COMP_MODE_UNDEFINE,
+};
+
+/**
+ * struct hisi_pmcu_user_events - Data interacting with sysfs interface
+ * @nr_ev:	number of events written
+ * @ev:		event IDs
+ */
+struct hisi_pmcu_user_events {
+	u32 nr_ev;
+	u16 ev[HISI_PMCU_FSM_CFG_MAX_EV_LEN];
+};
+
+/**
+ * struct hisi_pmcu - PMCU device data
+ * @pmu:	PMU device of this PMCU
+ * @dev:	device of this PMCU
+ * @regbase:	base IO address of registers
+ * @lock:	spinlock for serialising hardware operations
+ * @busy:	PMCU sampling running indicator
+ * @irq:	IRQ number
+ * @scclid:	CPU die (SCCL) ID where this PMCU is on
+ * @on_cpu:	CPU that handles perf_event and IRQ
+ * @cpus:	CPUs monitored by this PMCU
+ * @cpuhp_node:	CPU hotplug node
+ * @handle:	perf output handle for interacting with AUX buffers
+ * @ev:		PMCU events and sampling configuration
+ * @user_ev:	user events passed from sysfs
+ */
+struct hisi_pmcu {
+	struct pmu pmu;
+	struct device *dev;
+	void __iomem *regbase;
+	spinlock_t lock;
+	bool busy;
+	int irq;
+	int scclid;
+	int on_cpu;
+	cpumask_t cpus;
+	struct hlist_node cpuhp_node;
+	struct perf_output_handle handle;
+	struct hisi_pmcu_events ev;
+	struct hisi_pmcu_user_events user_ev;
+};
+
+#define to_hisi_pmcu(p) container_of(p, struct hisi_pmcu, pmu)
+
+static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
+						char *buf)
+{
+	struct hisi_pmcu *hisi_pmcu = to_hisi_pmcu(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "%d\n", hisi_pmcu->on_cpu);
+}
+
+static DEVICE_ATTR_ADMIN_RO(cpumask);
+
+static struct attribute *hisi_pmcu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL
+};
+
+static const struct attribute_group hisi_pmcu_cpumask_attr_group = {
+	.attrs = hisi_pmcu_cpumask_attrs,
+};
+
+PMU_FORMAT_ATTR(nr_sample, "config:0-31");
+PMU_FORMAT_ATTR(sample_period_ms, "config:32-63");
+PMU_FORMAT_ATTR(pmccfiltr, "config1:0-7");
+
+static struct attribute *hisi_pmcu_format_attrs[] = {
+	&format_attr_nr_sample.attr,
+	&format_attr_sample_period_ms.attr,
+	&format_attr_pmccfiltr.attr,
+	NULL
+};
+
+static const struct attribute_group hisi_pmcu_format_attr_group = {
+	.name = "format",
+	.attrs = hisi_pmcu_format_attrs,
+};
+
+static ssize_t monitored_cpus_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct hisi_pmcu *hisi_pmcu = to_hisi_pmcu(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "%d-%d\n",
+			  cpumask_first(&hisi_pmcu->cpus),
+			  cpumask_last(&hisi_pmcu->cpus));
+}
+
+static DEVICE_ATTR_ADMIN_RO(monitored_cpus);
+
+static struct attribute *hisi_pmcu_monitored_cpus_attrs[] = {
+	&dev_attr_monitored_cpus.attr,
+	NULL
+};
+
+static const struct attribute_group hisi_pmcu_monitored_cpus_attr_group = {
+	.attrs = hisi_pmcu_monitored_cpus_attrs,
+};
+
+static ssize_t user_events_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct hisi_pmcu *hisi_pmcu = to_hisi_pmcu(dev_get_drvdata(dev));
+	struct hisi_pmcu_user_events *user_ev = &hisi_pmcu->user_ev;
+	int at = 0;
+	int i;
+
+	for (i = 0; i < user_ev->nr_ev; i++)
+		at += sysfs_emit_at(buf, at, "0x%04x\n", user_ev->ev[i]);
+
+	return at;
+};
+
+static ssize_t user_events_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct hisi_pmcu *hisi_pmcu = to_hisi_pmcu(dev_get_drvdata(dev));
+	struct hisi_pmcu_user_events *user_ev = &hisi_pmcu->user_ev;
+	u32 head, tail, nr_ev;
+	char *line;
+	int err;
+
+	line = kcalloc(count + 1, sizeof(*line), GFP_KERNEL);
+	nr_ev = 0;
+	head = 0;
+	tail = 0;
+	while (nr_ev < HISI_PMCU_FSM_CFG_MAX_EV_LEN) {
+		while (head < count && isspace(buf[head]))
+			head++;
+		if (!isxdigit(buf[head]))
+			break;
+		tail = head + 1;
+
+		while (tail < count && isalnum(buf[tail]))
+			tail++;
+
+		strncpy(line, buf + head, tail - head);
+		line[tail - head] = '\0';
+		err = kstrtou16(line, 16, &user_ev->ev[nr_ev]);
+		if (err) {
+			user_ev->nr_ev = 0;
+			return err;
+		}
+		nr_ev++;
+		head = tail;
+	}
+	user_ev->nr_ev = nr_ev;
+
+	return count;
+}
+
+static DEVICE_ATTR_ADMIN_RW(user_events);
+
+static struct attribute *hisi_pmcu_user_events_attrs[] = {
+	&dev_attr_user_events.attr,
+	NULL
+};
+
+static const struct attribute_group hisi_pmcu_user_events_attr_group = {
+	.attrs = hisi_pmcu_user_events_attrs,
+};
+
+static const struct attribute_group *hisi_pmcu_attr_groups[] = {
+	&hisi_pmcu_cpumask_attr_group,
+	&hisi_pmcu_format_attr_group,
+	&hisi_pmcu_monitored_cpus_attr_group,
+	&hisi_pmcu_user_events_attr_group,
+	NULL
+};
+
+static int hisi_pmcu_pmu_event_init(struct perf_event *event)
+{
+	struct hisi_pmcu *hisi_pmcu = to_hisi_pmcu(event->pmu);
+	struct hisi_pmcu_events *ev = &hisi_pmcu->ev;
+	void __iomem *base = hisi_pmcu->regbase;
+	u64 cfg;
+	u32 val;
+
+	if (event->attr.type != hisi_pmcu->pmu.type)
+		return -ENOENT;
+
+	if (hisi_pmcu->busy)
+		return -EBUSY;
+
+	cfg = event->attr.config;
+
+	val = FIELD_GET(HISI_PMCU_PERF_ATTR_NR_SAMPLE, cfg);
+	ev->nr_pending_sample = val ? val : HISI_PMCU_PERF_NR_SAMPLE_DEFAULT;
+
+	val = FIELD_GET(HISI_PMCU_PERF_ATTR_SAMPLE_PERIOD_MS, cfg);
+	if (val > HISI_PMCU_PERF_MAX_SAMPLE_PERIOD_MS) {
+		dev_err(hisi_pmcu->dev, "sample period too long (max=0x%x)\n",
+			HISI_PMCU_PERF_MAX_SAMPLE_PERIOD_MS);
+		return -EINVAL;
+	}
+	ev->sample_period = val ? val * HISI_PMCU_PERF_MS_TO_WAIT_CNT :
+				  HISI_PMCU_WAIT_CNT_DEFAULT;
+
+	cfg = event->attr.config1;
+
+	val = FIELD_GET(HISI_PMCU_PERF_ATTR_PMCCFILTR, cfg);
+	val = FIELD_PREP(HISI_PMCU_PMCCFILTR_MSK, val);
+	writel(val, base + HISI_PMCU_REG_PMCCFILTR);
+
+	return 0;
+}
+
+static void *hisi_pmcu_pmu_setup_aux(struct perf_event *event, void **pages,
+				     int nr_pages, bool overwrite)
+{
+	int pg, nr_pg, nbuf;
+	struct hisi_pmcu_buf *buf;
+	struct page *page;
+
+	if (overwrite) {
+		dev_warn(event->pmu->dev, "Overwrite mode is not supported\n");
+		return NULL;
+	}
+
+	/* Count buffers */
+	nbuf = 0;
+	for (pg = 0; pg < nr_pages;) {
+		page = virt_to_page(pages[pg]);
+		pg += 1 << page_private(page);
+		nbuf++;
+	}
+
+	buf = kzalloc(struct_size(buf, sbuf, nbuf), GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	/* Set up buffers */
+	buf->nr_buf = nbuf;
+	buf->cur_buf = 0;
+	for (pg = 0, nbuf = 0; nbuf < buf->nr_buf; nbuf++) {
+		page = virt_to_page(pages[pg]);
+		nr_pg = 1 << page_private(page);
+		buf->sbuf[nbuf].page = page;
+		buf->sbuf[nbuf].size = nr_pg << PAGE_SHIFT;
+		buf->sbuf[nbuf].remain = nr_pg << PAGE_SHIFT;
+		pg += nr_pg;
+	}
+
+	return buf;
+}
+
+static void hisi_pmcu_pmu_free_aux(void *aux)
+{
+	kfree(aux);
+}
+
+static void hisi_pmcu_setup_events(struct hisi_pmcu_events *ev,
+				   struct hisi_pmcu_user_events *user_ev)
+{
+	u8 max_nr_pmu;
+	int i;
+
+	/* Copy events from user's sysfs interface */
+	ev->nr_ev = user_ev->nr_ev;
+	for (i = 0; i < ev->nr_ev; i++)
+		ev->events[i] = user_ev->ev[i];
+
+	/*
+	 * Set nr_pmu and pad events.
+	 *
+	 * PMCU takes nr_pmu events per "subsample", and nr_pmu is limited by
+	 * the number of available PMU counters (nr_pmu <= max_nr_pmu). If
+	 * nr_ev <= max_nr_pmu, we just set nr_pmu = ev->nr_ev and we do not
+	 * need to pad events.
+	 *
+	 * However, if nr_ev > max_nr_pmu, so that a "sample" of nr_ev events
+	 * is formed of multiple subsamples. In this case, we set nr_pmu =
+	 * max_nr_pmu and, if nr_ev % nr_pmu != 0, we pad null events, i.e.
+	 * reserved events that do not count, in the last subsample. Thus, one
+	 * subsample accounts for only one sample, making user space data
+	 * decoding easier.
+	 */
+	max_nr_pmu = ev->comp_mode ? HISI_PMCU_FSM_CFG_MAX_NR_PMU_C :
+				     HISI_PMCU_FSM_CFG_MAX_NR_PMU;
+
+	ev->nr_pmu = min(ev->nr_ev, max_nr_pmu);
+
+	ev->padding = ev->nr_ev % ev->nr_pmu ?
+		      ev->nr_pmu - ev->nr_ev % ev->nr_pmu : 0;
+
+	ev->nr_ev_per_sample = ev->nr_ev + ev->padding;
+
+	for (i = ev->nr_ev; i < ev->nr_ev_per_sample; i++)
+		ev->events[i] = PMU_NULL_EVENT_ID;
+
+	/*
+	 * Duplicate events in ev->events in case of needing many samples
+	 * (> MAX_NR_LOOP) in a trigger. See hisi_pmcu_config_sample().
+	 */
+	ev->max_sample_loop = HISI_PMCU_FSM_CFG_MAX_EV_LEN /
+			      ev->nr_ev_per_sample;
+	for (i = 1; i < ev->max_sample_loop; i++)
+		memcpy(ev->events + i * ev->nr_ev_per_sample,
+		       ev->events, ev->nr_ev_per_sample * sizeof(u32));
+
+	/* Update sample size */
+	ev->subsample_size = (ev->nr_pmu + (ev->comp_mode ? 1 : 2))
+			     * sizeof(u64) * ev->nr_cpu;
+	ev->sample_size = ev->nr_ev_per_sample / ev->nr_pmu
+			  * ev->subsample_size;
+}
+
+static int hisi_pmcu_config_sample(struct hisi_pmcu_events *ev, u32 buf_size)
+{
+	int nr_sample_loop, nr_max;
+
+	if (buf_size < ev->sample_size)
+		return 1;
+
+	/* Number of events that this buf can take or to take */
+	nr_max = min(buf_size / ev->sample_size, ev->nr_pending_sample);
+
+	/*
+	 * Determine ev->ev_len and ev->nr_loop, update ev->nr_sample
+	 *
+	 * NOTE: We haven't implemented an algorithm to find a pair of
+	 * [nr_loop, nr_sample_loop] that exactly delivers nr_max samples.
+	 *
+	 * We use nr_loop to do multiple samples if nr_max <= MAX_NR_LOOP.
+	 * Otherwise, we utilise the duplicate events in the event buffer to
+	 * get more samples. If there are any pending samples not going to be
+	 * taken in this trigger, e.g. due to the limit of (max_sample_loop *
+	 * MAX_NR_LOOP) or the round down of division (nr_max / MAX_NR_LOOP),
+	 * they will be handled in the next trigger from ISR.
+	 */
+	if (nr_max <= HISI_PMCU_FSM_CFG_MAX_NR_LOOP) {
+		nr_sample_loop = 1;
+		ev->nr_loop = nr_max;
+		ev->nr_sample = ev->nr_loop;
+	} else {
+		nr_sample_loop = nr_max / HISI_PMCU_FSM_CFG_MAX_NR_LOOP;
+		if (nr_sample_loop > ev->max_sample_loop)
+			nr_sample_loop = ev->max_sample_loop;
+		ev->nr_loop = HISI_PMCU_FSM_CFG_MAX_NR_LOOP;
+		ev->nr_sample = nr_sample_loop * ev->nr_loop;
+	}
+
+	ev->ev_len = ev->nr_ev_per_sample * nr_sample_loop;
+
+	ev->output_size = ev->sample_size * ev->nr_sample;
+
+	return 0;
+}
+
+static void hisi_pmcu_hw_sample_start(struct hisi_pmcu *hisi_pmcu,
+				      struct hisi_pmcu_buf *buf)
+{
+	struct hisi_pmcu_sbuf *sbuf = &buf->sbuf[buf->cur_buf];
+	struct hisi_pmcu_events *ev = &hisi_pmcu->ev;
+	void __iomem *base = hisi_pmcu->regbase;
+	u64 addr, end;
+	u32 val;
+
+	/* FSM CFG */
+	val = FIELD_PREP(HISI_PMCU_FSM_CFG_EV_LEN_MSK, ev->ev_len);
+	val |= FIELD_PREP(HISI_PMCU_FSM_CFG_NR_LOOP_MSK, ev->nr_loop);
+	val |= FIELD_PREP(HISI_PMCU_FSM_CFG_NR_PMU_MSK, ev->nr_pmu);
+	writel(val, base + HISI_PMCU_REG_FSM_CFG);
+
+	/* Sample period */
+	writel(ev->sample_period, base + HISI_PMCU_REG_WAIT_CNT);
+
+	/* Event ID base */
+	addr = virt_to_phys(ev->events);
+	val = upper_32_bits(addr);
+	writel(val, base + HISI_PMCU_REG_EVENT_BASE_H);
+	val = lower_32_bits(addr);
+	writel(val, base + HISI_PMCU_REG_EVENT_BASE_L);
+
+	/* sbuf end */
+	end = page_to_phys(sbuf->page) + sbuf->size;
+
+	/* Data output address */
+	addr = end - sbuf->remain;
+	val = upper_32_bits(addr);
+	writel(val, base + HISI_PMCU_REG_STORE_BASE_H);
+	val = lower_32_bits(addr);
+	writel(val, base + HISI_PMCU_REG_STORE_BASE_L);
+
+	/* Stop data output if sbuf end is reached (abnormally) */
+	addr = end;
+	val = upper_32_bits(addr);
+	writel(val, base + HISI_PMCU_REG_KILL_BASE_H);
+	val = lower_32_bits(addr);
+	writel(val, base + HISI_PMCU_REG_KILL_BASE_L);
+
+	/* Trigger */
+	writel(HISI_PMCU_FSM_CTRL_TRIGGER, base + HISI_PMCU_REG_FSM_CTRL);
+}
+
+/*
+ * Break hardware sampling process and poll hisi_pmcu->busy. hisi_pmcu->busy
+ * will be cleared in ISR when hardware successfully handles the break request.
+ */
+static int hisi_pmcu_hw_sample_stop(struct hisi_pmcu *hisi_pmcu)
+{
+	ktime_t ddl;
+
+	writel(HISI_PMCU_FSM_BRK_BRK,
+	       hisi_pmcu->regbase + HISI_PMCU_REG_FSM_BRK);
+
+	ddl = ktime_add_us(ktime_get(), HISI_PMCU_BRK_TIMEOUT_US);
+
+	while (ktime_before(ktime_get(), ddl)) {
+		udelay(HISI_PMCU_BRK_DELAY_PERIOD_US);
+		if (!hisi_pmcu->busy)
+			return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static void hisi_pmcu_write_auxtrace_header(struct hisi_pmcu_events *ev,
+					    struct hisi_pmcu_buf *buf)
+{
+	struct hisi_pmcu_auxtrace_header header;
+	struct hisi_pmcu_sbuf *sbuf;
+	u32 *data;
+	u32 sz;
+
+	sbuf = &buf->sbuf[buf->cur_buf];
+
+	header.buffer_size = sbuf->size;
+	header.nr_pmu = ev->nr_pmu;
+	header.nr_cpu = ev->nr_cpu;
+	header.comp_mode = ev->comp_mode;
+	header.subsample_size = ev->subsample_size;
+	header.nr_subsample_per_sample = ev->nr_ev_per_sample / ev->nr_pmu;
+	header.nr_event = ev->nr_ev_per_sample;
+
+	data = page_to_virt(sbuf->page);
+	memcpy(data, &header, sizeof(header));
+	memcpy(data + sizeof(header) / sizeof(*data), ev->events,
+	       ev->nr_ev_per_sample * sizeof(u32));
+
+	sz = sizeof(header) + ev->nr_ev_per_sample * sizeof(u32);
+	sz = round_up(sz, HISI_PMCU_AUX_HEADER_ALIGN);
+
+	sbuf->remain -= sz;
+}
+
+static void hisi_pmcu_pmu_start(struct perf_event *event, int flags)
+{
+	struct hisi_pmcu *hisi_pmcu = to_hisi_pmcu(event->pmu);
+	struct perf_output_handle *handle = &hisi_pmcu->handle;
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pmcu_buf *buf;
+	int err;
+
+	spin_lock(&hisi_pmcu->lock);
+
+	if (hisi_pmcu->busy) {
+		dev_info(hisi_pmcu->dev,
+			 "Sampling is running, pmu->start() ignored\n");
+		goto out;
+	}
+
+	buf = perf_aux_output_begin(handle, event);
+	if (!buf) {
+		dev_err(hisi_pmcu->dev, "Failed to begin perf aux output\n");
+		goto out;
+	}
+
+	if (handle->head) {
+		dev_err(hisi_pmcu->dev, "got handle->head=0x%lx, should be 0\n",
+			handle->head);
+		goto out;
+	}
+
+	hisi_pmcu_setup_events(&hisi_pmcu->ev, &hisi_pmcu->user_ev);
+
+	hisi_pmcu_write_auxtrace_header(&hisi_pmcu->ev, buf);
+
+	err = hisi_pmcu_config_sample(&hisi_pmcu->ev,
+				      buf->sbuf[buf->cur_buf].remain);
+	if (err) {
+		dev_err(hisi_pmcu->dev,
+			"Failed to start sampling, buffer too small\n");
+		perf_aux_output_end(handle, 0);
+		goto out;
+	}
+
+	hisi_pmcu->busy = true;
+	hwc->state &= ~PERF_HES_STOPPED;
+
+	hisi_pmcu_hw_sample_start(hisi_pmcu, buf);
+
+	dev_dbg(hisi_pmcu->dev, "Sampling started\n");
+
+out:
+	spin_unlock(&hisi_pmcu->lock);
+}
+
+static void hisi_pmcu_pmu_stop(struct perf_event *event, int flags)
+{
+	struct hisi_pmcu *hisi_pmcu = to_hisi_pmcu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	struct perf_output_handle *handle;
+	struct hisi_pmcu_sbuf *sbuf;
+	struct hisi_pmcu_buf *buf;
+	int err;
+
+	spin_lock(&hisi_pmcu->lock);
+
+	handle = &hisi_pmcu->handle;
+
+	/* If PMCU is running, break it */
+	if (hisi_pmcu->busy) {
+		dev_info(hisi_pmcu->dev, "Stopping PMCU sampling\n");
+		err = hisi_pmcu_hw_sample_stop(hisi_pmcu);
+		if (err)
+			dev_err(hisi_pmcu->dev,
+				"Timed out for stopping PMCU!\n");
+	}
+
+	buf = perf_get_aux(handle);
+	sbuf = &buf->sbuf[buf->cur_buf];
+	perf_aux_output_end(handle, sbuf->size - sbuf->remain);
+
+	spin_unlock(&hisi_pmcu->lock);
+
+	hwc->state |= PERF_HES_STOPPED;
+	perf_event_update_userpage(event);
+}
+
+static int hisi_pmcu_pmu_add(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	hwc->state |= PERF_HES_STOPPED;
+
+	hisi_pmcu_pmu_start(event, flags);
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void hisi_pmcu_pmu_del(struct perf_event *event, int flags)
+{
+	hisi_pmcu_pmu_stop(event, flags);
+}
+
+static int hisi_pmcu_init_data(struct platform_device *pdev,
+			       struct hisi_pmcu *hisi_pmcu)
+{
+	int ret;
+
+	hisi_pmcu->regbase = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(hisi_pmcu->regbase))
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "Failed to map device register space\n");
+
+	ret = device_property_read_u32(&pdev->dev, "hisilicon,scl-id",
+				       &hisi_pmcu->scclid);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to read sccl-id!\n");
+
+	/*
+	 * Obtain the number of CPUs that contributes to the sample size.
+	 * NR_CPU_CLUSTER is now hard coded as the hardware accesses a certain
+	 * number of CPUs in a cluster regardless of how many CPUs are actually
+	 * implemented/available.
+	 */
+	ret = device_property_read_u32(&pdev->dev, "hisilicon,nr-cluster",
+				       &hisi_pmcu->ev.nr_cpu);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to read nr-cluster!\n");
+	hisi_pmcu->ev.nr_cpu *= NR_CPU_CLUSTER;
+
+	return 0;
+}
+
+static irqreturn_t hisi_pmcu_isr(int irq, void *data)
+{
+	struct hisi_pmcu *hisi_pmcu = data;
+	void __iomem *base = hisi_pmcu->regbase;
+	u32 irq_status;
+
+	irq_status = FIELD_GET(HISI_PMCU_INT_ALL,
+			       readl(base + HISI_PMCU_REG_INT_STAT));
+
+	if (!irq_status)
+		return IRQ_NONE;
+
+	if (irq_status & HISI_PMCU_INT_DONE) {
+		/*
+		 * Buffers and perf_output_handle should be up-to-date
+		 * for hisi_pmcu_pmu_stop() before exiting ISR
+		 */
+		struct perf_output_handle *handle = &hisi_pmcu->handle;
+		struct hisi_pmcu_buf *buf = perf_get_aux(handle);
+		struct hisi_pmcu_sbuf *sbuf = &buf->sbuf[buf->cur_buf];
+		struct hisi_pmcu_events *ev = &hisi_pmcu->ev;
+		int err;
+
+		spin_lock(&hisi_pmcu->lock);
+
+		ev->nr_pending_sample -= ev->nr_sample;
+		sbuf->remain -= ev->output_size;
+
+		if (!ev->nr_pending_sample) {
+			hisi_pmcu->busy = false;
+			dev_dbg(hisi_pmcu->dev, "Sampling finished\n");
+			goto skip;
+		}
+
+		err = hisi_pmcu_config_sample(ev, sbuf->remain);
+		if (err) {
+			/* This sbuf is full. Commit it, switch to the next. */
+			struct perf_event *event = handle->event;
+
+			perf_aux_output_end(handle, sbuf->size);
+
+			sbuf->remain = sbuf->size;
+
+			perf_aux_output_begin(handle, event);
+
+			if (++buf->cur_buf == buf->nr_buf)
+				buf->cur_buf = 0;
+			sbuf = &buf->sbuf[buf->cur_buf];
+
+			err = hisi_pmcu_config_sample(ev, sbuf->remain);
+			if (err) {
+				dev_err(hisi_pmcu->dev,
+					"Sampling stopped at AUX buffer %d, buffer size is probably tainted\n",
+					buf->cur_buf);
+				hisi_pmcu->busy = false;
+				goto skip;
+			}
+		}
+
+		hisi_pmcu_hw_sample_start(hisi_pmcu, buf);
+
+skip:
+		spin_unlock(&hisi_pmcu->lock);
+		writel(HISI_PMCU_INT_DONE, base + HISI_PMCU_REG_INT_CLR);
+	}
+
+	if (irq_status & HISI_PMCU_INT_BRK) {
+		hisi_pmcu->busy = false;
+		writel(HISI_PMCU_INT_BRK, base + HISI_PMCU_REG_INT_CLR);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int hisi_pmcu_init_irq(struct platform_device *pdev,
+			      struct hisi_pmcu *hisi_pmcu)
+{
+	int irq, ret;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(&pdev->dev, irq, hisi_pmcu_isr,
+			       IRQF_NOBALANCING | IRQF_NO_THREAD,
+			       dev_name(&pdev->dev), hisi_pmcu);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to request IRQ line %d\n", irq);
+
+	hisi_pmcu->irq = irq;
+
+	return 0;
+}
+
+static void hisi_pmcu_init_hw(struct hisi_pmcu *hisi_pmcu)
+{
+	void __iomem *base = hisi_pmcu->regbase;
+
+	writel(HISI_PMCU_INT_ALL, base + HISI_PMCU_REG_INT_EN);
+	writel(0, base + HISI_PMCU_REG_INT_MSK);
+	writel(HISI_PMCU_INT_ALL, base + HISI_PMCU_REG_INT_CLR);
+
+	writel(HISI_PMCU_PMCR_DEFAULT, base + HISI_PMCU_REG_PMCR);
+
+	if (hisi_pmcu->ev.comp_mode)
+		writel(HISI_PMCU_COMP_ENABLE, base + HISI_PMCU_REG_COMP);
+}
+
+static void hisi_pmcu_init_cpu_config(void *info)
+{
+	struct hisi_pmcu *hisi_pmcu = info;
+	u64 val, hpmn;
+	int cpu, sccl;
+
+	val = read_cpuid_mpidr();
+
+	if (FIELD_GET(MPIDR_MT_BITMASK, val))
+		sccl = MPIDR_AFFINITY_LEVEL(val, 3);
+	else
+		sccl = MPIDR_AFFINITY_LEVEL(val, 2);
+
+	if (sccl == hisi_pmcu->scclid) {
+		cpu = smp_processor_id();
+		cpumask_set_cpu(cpu, &hisi_pmcu->cpus);
+
+		val = read_sysreg(mdcr_el2);
+		hpmn = FIELD_GET(MDCR_EL2_HPMN_MASK, val);
+		if (hpmn > HISI_PMCU_COMP_HPMN_THR) {
+			hisi_pmcu->ev.comp_mode = HISI_PMCU_COMP_MODE_DISABLED;
+			dev_warn(hisi_pmcu->dev,
+				 "CPU%d MDCR_EL2.HPMN=%lld (> %d), PMCU may mess up VM's counter accesses\n",
+				 cpu, hpmn, HISI_PMCU_COMP_HPMN_THR);
+		}
+	}
+}
+
+static void hisi_pmcu_set_mdcr_el2_hpme(void *info)
+{
+	write_sysreg(read_sysreg(mdcr_el2) | MDCR_EL2_HPME, mdcr_el2);
+}
+
+static enum cpuhp_state hisi_pmcu_cpuhp_state;
+
+static void hisi_pmcu_remove_cpuhp_instance(void *cpuhp_node)
+{
+	cpuhp_state_remove_instance_nocalls(hisi_pmcu_cpuhp_state, cpuhp_node);
+}
+
+static int hisi_pmcu_init(struct platform_device *pdev,
+			  struct hisi_pmcu *hisi_pmcu)
+{
+	int ret;
+
+	hisi_pmcu->dev = &pdev->dev;
+
+	spin_lock_init(&hisi_pmcu->lock);
+
+	ret = hisi_pmcu_init_data(pdev, hisi_pmcu);
+	if (ret)
+		return ret;
+
+	ret = hisi_pmcu_init_irq(pdev, hisi_pmcu);
+	if (ret)
+		return ret;
+
+	hisi_pmcu_init_hw(hisi_pmcu);
+
+	/*
+	 * ARM64 sysreg MDCR_EL2.HPMN defines the number of core PMU counters
+	 * that are accessible from VMs. If HPMN > 0, PMCU may access PMU
+	 * counters at the same time with VMs, messing up the counter control.
+	 * PMCU supports a "compatibility mode", where it restricts itself to
+	 * use counters starting from an index of HISI_PMCU_COMP_HPMN_THR.
+	 * Hence, if HPMN <= HISI_PMCU_COMP_HPMN_THR on all CPUs, PMCU enables
+	 * the "compatibility mode" to resolve the conflict with VMs;
+	 * otherwise, we print a message to warn potential conflicts.
+	 */
+	hisi_pmcu->ev.comp_mode = HISI_PMCU_COMP_MODE_UNDEFINE;
+	on_each_cpu(hisi_pmcu_init_cpu_config, hisi_pmcu, 1);
+	if (hisi_pmcu->ev.comp_mode != HISI_PMCU_COMP_MODE_DISABLED) {
+		hisi_pmcu->ev.comp_mode = HISI_PMCU_COMP_MODE_ENABLED;
+		on_each_cpu(hisi_pmcu_set_mdcr_el2_hpme, NULL, 1);
+	}
+
+	ret = cpuhp_state_add_instance(hisi_pmcu_cpuhp_state,
+				       &hisi_pmcu->cpuhp_node);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(hisi_pmcu->dev,
+					hisi_pmcu_remove_cpuhp_instance,
+					&hisi_pmcu->cpuhp_node);
+}
+
+static void hisi_pmcu_unregister_pmu(void *pmu)
+{
+	perf_pmu_unregister(pmu);
+}
+
+static int hisi_pmcu_register_pmu(struct hisi_pmcu *hisi_pmcu)
+{
+	char *name;
+	int ret;
+
+	hisi_pmcu->pmu = (struct pmu) {
+		.module		= THIS_MODULE,
+		.attr_groups	= hisi_pmcu_attr_groups,
+		.capabilities	= PERF_PMU_CAP_EXCLUSIVE |
+				  PERF_PMU_CAP_AUX_OUTPUT,
+		.task_ctx_nr	= perf_invalid_context,
+		.event_init	= hisi_pmcu_pmu_event_init,
+		.add		= hisi_pmcu_pmu_add,
+		.del		= hisi_pmcu_pmu_del,
+		.start		= hisi_pmcu_pmu_start,
+		.stop		= hisi_pmcu_pmu_stop,
+		.setup_aux	= hisi_pmcu_pmu_setup_aux,
+		.free_aux	= hisi_pmcu_pmu_free_aux,
+	};
+
+	name = devm_kasprintf(hisi_pmcu->dev, GFP_KERNEL, "hisi_pmcu_sccl%d",
+			      hisi_pmcu->scclid);
+	if (!name)
+		return -ENOMEM;
+
+	ret = perf_pmu_register(&hisi_pmcu->pmu, name, -1);
+	if (ret)
+		return dev_err_probe(hisi_pmcu->dev, ret,
+				     "Failed to register PMU\n");
+
+	return devm_add_action_or_reset(hisi_pmcu->dev,
+					hisi_pmcu_unregister_pmu,
+					&hisi_pmcu->pmu);
+}
+
+static int hisi_pmcu_probe(struct platform_device *pdev)
+{
+	struct hisi_pmcu *hisi_pmcu;
+	int ret;
+
+	hisi_pmcu = devm_kzalloc(&pdev->dev, sizeof(*hisi_pmcu), GFP_KERNEL);
+	if (!hisi_pmcu)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, hisi_pmcu);
+
+	ret = hisi_pmcu_init(pdev, hisi_pmcu);
+	if (ret)
+		return ret;
+
+	return hisi_pmcu_register_pmu(hisi_pmcu);
+}
+
+static const struct acpi_device_id hisi_pmcu_acpi_match[] = {
+	{ "HISI0451", },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, hisi_pmcu_acpi_match);
+
+static struct platform_driver hisi_pmcu_driver = {
+	.driver = {
+		.name = HISI_PMCU_DRV_NAME,
+		.acpi_match_table = hisi_pmcu_acpi_match,
+		/*
+		 * Unbinding driver is not yet supported as we have not worked
+		 * out a safe bind/unbind process.
+		 */
+		.suppress_bind_attrs = true,
+	},
+	.probe = hisi_pmcu_probe,
+};
+
+static int hisi_pmcu_cpuhp_startup(unsigned int cpu, struct hlist_node *node)
+{
+	struct hisi_pmcu *hisi_pmcu;
+
+	hisi_pmcu = hlist_entry_safe(node, struct hisi_pmcu, cpuhp_node);
+
+	if (hisi_pmcu->on_cpu != -1)
+		return 0;
+
+	if (!cpumask_test_cpu(cpu, &hisi_pmcu->cpus))
+		return 0;
+
+	WARN_ON(irq_set_affinity(hisi_pmcu->irq, cpumask_of(cpu)));
+	hisi_pmcu->on_cpu = cpu;
+
+	return 0;
+}
+
+static int hisi_pmcu_cpuhp_teardown(unsigned int cpu, struct hlist_node *node)
+{
+	struct hisi_pmcu *hisi_pmcu;
+	cpumask_t available_cpus;
+	unsigned int target;
+
+	hisi_pmcu = hlist_entry_safe(node, struct hisi_pmcu, cpuhp_node);
+
+	if (hisi_pmcu->on_cpu != cpu)
+		return 0;
+
+	hisi_pmcu->on_cpu = -1;
+
+	cpumask_and(&available_cpus, &hisi_pmcu->cpus, cpu_online_mask);
+	target = cpumask_any_but(&available_cpus, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+	perf_pmu_migrate_context(&hisi_pmcu->pmu, cpu, target);
+	WARN_ON(irq_set_affinity(hisi_pmcu->irq, cpumask_of(target)));
+	hisi_pmcu->on_cpu = target;
+
+	return 0;
+}
+
+static int __init hisi_pmcu_module_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, HISI_PMCU_DRV_NAME,
+				      hisi_pmcu_cpuhp_startup,
+				      hisi_pmcu_cpuhp_teardown);
+	if (ret < 0)
+		return ret;
+	hisi_pmcu_cpuhp_state = ret;
+
+	ret = platform_driver_register(&hisi_pmcu_driver);
+	if (ret)
+		cpuhp_remove_multi_state(hisi_pmcu_cpuhp_state);
+
+	return ret;
+}
+
+static void __exit hisi_pmcu_module_exit(void)
+{
+	platform_driver_unregister(&hisi_pmcu_driver);
+	cpuhp_remove_multi_state(hisi_pmcu_cpuhp_state);
+}
+
+module_init(hisi_pmcu_module_init);
+module_exit(hisi_pmcu_module_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jie Zhan <zhanjie9@hisilicon.com>");
+MODULE_DESCRIPTION("HiSilicon PMCU driver");
-- 
2.30.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD5B743B6D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjF3MEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjF3MEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:04:22 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E54E4F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 05:04:20 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TMYJac001329;
        Fri, 30 Jun 2023 05:04:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=Rpp8jwOrqEAld18Vm3OMAUEHw0TX7nPklkyzcGyspmg=;
 b=WZMAz+zJdlulLtEeULMY77NCJsjH0DitYmQGPSV1Az+JALo5kv4KT9QrApIZh5fg5nV1
 95yMgKqeCHSCYMclTqDl4IkfpoBPVZC8Pe7Ct45V5+dPSStyupo6TsgxT0cdU898RrDK
 JNBqdou1VTbFO1Chg+4jTIuZTYRMy2nPcRWNTEL7sVwGH+vYt3uLO0h5FG5Kmt2WTuip
 5l0DbhR8NHCE3ysPBx8Tszm+DhzFb9meGHvm8M7iolG0bUBzOBrYIBXY8QEiQ/T3E2Av
 0mMZCcAALAe2INKLbw5enxDaLx2jFQafTVkNNIq5ajyqcNOwlSwaQ6VxLSmDc1wXaGYg tg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rgvpc63bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 05:04:11 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 30 Jun
 2023 05:04:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 30 Jun 2023 05:04:09 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
        by maili.marvell.com (Postfix) with ESMTP id C8E083F7059;
        Fri, 30 Jun 2023 05:04:06 -0700 (PDT)
From:   Gowthami Thiagarajan <gthiagarajan@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <bbhushan2@marvell.com>,
        <gcherian@marvell.com>, <lcherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH 3/6] perf/marvell : Odyssey LLC-TAD performance monitor support
Date:   Fri, 30 Jun 2023 17:33:48 +0530
Message-ID: <20230630120351.1143773-4-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630120351.1143773-1-gthiagarajan@marvell.com>
References: <20230630120351.1143773-1-gthiagarajan@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: jcOiTHugENb-c0TYoKNogLSaTRBwp6cg
X-Proofpoint-ORIG-GUID: jcOiTHugENb-c0TYoKNogLSaTRBwp6cg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each TAD provides eight 64-bit counters for monitoring
cache behavior.The driver always configures the same counter for
all the TADs. The user would end up effectively reserving one of
eight counters in every TAD to look across all TADs.
The occurrences of events are aggregated and presented to the user
at the end of running the workload. The driver does not provide a
way for the user to partition TADs so that different TADs are used for
different applications.

The performance events reflect various internal or interface activities.
By combining the values from multiple performance counters, cache
performance can be measured in terms such as: cache miss rate, cache
allocations, interface retry rate, internal resource occupancy, etc.

Each supported counter's event and formatting information is exposed
to sysfs at /sys/devices/tad/. Use perf tool stat command to measure
the pmu events. For instance:

perf stat -e tad_hit_ltg,tad_hit_dtg <workload>

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 MAINTAINERS                            |   8 +
 drivers/perf/Kconfig                   |   7 +
 drivers/perf/Makefile                  |   1 +
 drivers/perf/marvell_odyssey_tad_pmu.c | 406 +++++++++++++++++++++++++
 4 files changed, 422 insertions(+)
 create mode 100644 drivers/perf/marvell_odyssey_tad_pmu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 55a2a9b6f346..bbf3a97502db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12512,6 +12512,14 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/marvell/octeon_ep
 
+MARVELL ODYSSEY TAD PMU DRIVER
+M:	Gowthami Thiagarajan <gthiagarajan@marvell.com>
+M:	Bharat Bhushan <bbhushan2@marvell.com>
+M:	Linu Cherian <lcherian@marvell.com>
+M:	George Cherian <gcherian@marvell.com>
+S:	Supported
+F:	drivers/perf/marvell_odyssey_tad_pmu.c
+
 MATROX FRAMEBUFFER DRIVER
 L:	linux-fbdev@vger.kernel.org
 S:	Orphan
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 1cd8d07ffefd..2dc649768c1b 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -210,4 +210,11 @@ config MARVELL_PEM_PMU
 	  Enable support for PCIe Interface performance monitoring
 	  on Marvell platform.
 
+config MARVELL_ODYSSEY_TAD_PMU
+        tristate "MARVELL ODYSSEY LLC-TAD PMU"
+        depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
+        help
+          Provides support for Last-Level cache Tag-and-data Units (LLC-TAD)
+          performance monitor on Odyssey platform
+
 endmenu
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index bf9fe9cacad9..5dc1438e7d3d 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
 obj-$(CONFIG_MARVELL_PEM_PMU) += marvell_pem_pmu.o
+obj-$(CONFIG_MARVELL_ODYSSEY_TAD_PMU) += marvell_odyssey_tad_pmu.o
 obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
 obj-$(CONFIG_ALIBABA_UNCORE_DRW_PMU) += alibaba_uncore_drw_pmu.o
 obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu/
diff --git a/drivers/perf/marvell_odyssey_tad_pmu.c b/drivers/perf/marvell_odyssey_tad_pmu.c
new file mode 100644
index 000000000000..8f0204c88539
--- /dev/null
+++ b/drivers/perf/marvell_odyssey_tad_pmu.c
@@ -0,0 +1,406 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell Odyssey LLC-TAD perf driver
+ *
+ * Copyright (C) 2023 Marvell.
+ */
+
+#define pr_fmt(fmt) "tad_pmu: " fmt
+
+#include <linux/acpi.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/cpuhotplug.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+
+#define TAD_PFC_OFFSET		0x0800
+#define TAD_PFC(counter)	(TAD_PFC_OFFSET | ((counter) << 3))
+#define TAD_PRF_OFFSET		0x0900
+#define TAD_PRF(counter)	(TAD_PRF_OFFSET | ((counter) << 3))
+#define TAD_PRF_CNTSEL_MASK	0xFF
+#define TAD_MAX_COUNTERS	8
+
+#define to_tad_pmu(p) (container_of(p, struct tad_pmu, pmu))
+
+struct tad_region {
+	void __iomem	*base;
+};
+
+struct tad_pmu {
+	struct pmu pmu;
+	struct tad_region *regions;
+	u32 region_cnt;
+	unsigned int cpu;
+	struct hlist_node node;
+	struct perf_event *events[TAD_MAX_COUNTERS];
+	DECLARE_BITMAP(counters_map, TAD_MAX_COUNTERS);
+};
+
+static int tad_pmu_cpuhp_state;
+
+static void tad_pmu_event_counter_read(struct perf_event *event)
+{
+	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u32 counter_idx = hwc->idx;
+	u64 delta, prev, new;
+	int tad_region;
+
+	do {
+		prev = local64_read(&hwc->prev_count);
+		for (tad_region = 0, new = 0; tad_region < tad_pmu->region_cnt; tad_region++)
+			new += readq(tad_pmu->regions[tad_region].base +
+				     TAD_PFC(counter_idx));
+	} while (local64_cmpxchg(&hwc->prev_count, prev, new) != prev);
+
+	delta = (new - prev) & GENMASK_ULL(63, 0);
+	local64_add(delta, &event->count);
+}
+
+static void tad_pmu_event_counter_stop(struct perf_event *event, int flags)
+{
+	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u32 counter_idx = hwc->idx;
+	int tad_region;
+
+	/* TAD()_PFC() stop counting on the write
+	 * which sets TAD()_PRF()[CNTSEL] == 0
+	 */
+	for (tad_region = 0; tad_region < tad_pmu->region_cnt; tad_region++)
+		writeq(0, tad_pmu->regions[tad_region].base + TAD_PRF(counter_idx));
+
+	tad_pmu_event_counter_read(event);
+	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+static void tad_pmu_event_counter_start(struct perf_event *event, int flags)
+{
+	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u32 event_idx = event->attr.config;
+	u32 counter_idx = hwc->idx;
+	u64 reg_val;
+	int tad_region;
+
+	hwc->state = 0;
+
+	/* Typically TAD_PFC() are zeroed to start counting */
+	for (tad_region = 0; tad_region < tad_pmu->region_cnt; tad_region++)
+		writeq(0, tad_pmu->regions[tad_region].base + TAD_PFC(counter_idx));
+
+	/* TAD()_PFC() start counting on the write
+	 * which sets TAD()_PRF()[CNTSEL] != 0
+	 */
+	for (tad_region = 0; tad_region < tad_pmu->region_cnt; tad_region++) {
+		reg_val = (event_idx & 0xFF);
+		writeq(reg_val,	tad_pmu->regions[tad_region].base +
+				TAD_PRF(counter_idx));
+	}
+}
+
+static void tad_pmu_event_counter_del(struct perf_event *event, int flags)
+{
+	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	tad_pmu_event_counter_stop(event, flags | PERF_EF_UPDATE);
+	tad_pmu->events[idx] = NULL;
+	clear_bit(idx, tad_pmu->counters_map);
+}
+
+static int tad_pmu_event_counter_add(struct perf_event *event, int flags)
+{
+	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+
+	/* Get a free counter for this event */
+	idx = find_first_zero_bit(tad_pmu->counters_map, TAD_MAX_COUNTERS);
+	if (idx == TAD_MAX_COUNTERS)
+		return -EAGAIN;
+
+	set_bit(idx, tad_pmu->counters_map);
+
+	hwc->idx = idx;
+	hwc->state = PERF_HES_STOPPED;
+	tad_pmu->events[idx] = event;
+
+	if (flags & PERF_EF_START)
+		tad_pmu_event_counter_start(event, flags);
+
+	return 0;
+}
+
+static int tad_pmu_event_init(struct perf_event *event)
+{
+	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (!event->attr.disabled)
+		return -EINVAL;
+
+	if (event->state != PERF_EVENT_STATE_OFF)
+		return -EINVAL;
+
+	event->cpu = tad_pmu->cpu;
+	event->hw.idx = -1;
+	event->hw.config_base = event->attr.config;
+
+	return 0;
+}
+
+static ssize_t tad_pmu_event_show(struct device *dev,
+				  struct device_attribute *attr, char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
+#define TAD_PMU_EVENT_ATTR(_name, _id)					\
+	(&((struct perf_pmu_events_attr[]) {				\
+		{ .attr = __ATTR(_name, 0444, tad_pmu_event_show, NULL),\
+		  .id = _id, }						\
+	})[0].attr.attr)
+
+static struct attribute *tad_pmu_event_attrs[] = {
+	TAD_PMU_EVENT_ATTR(tad_none, 0x0),
+	TAD_PMU_EVENT_ATTR(tad_req_msh_in_exlmn, 0x3),
+	TAD_PMU_EVENT_ATTR(tad_alloc_dtg, 0x1a),
+	TAD_PMU_EVENT_ATTR(tad_alloc_ltg, 0x1b),
+	TAD_PMU_EVENT_ATTR(tad_alloc_any, 0x1c),
+	TAD_PMU_EVENT_ATTR(tad_hit_dtg, 0x1d),
+	TAD_PMU_EVENT_ATTR(tad_hit_ltg, 0x1e),
+	TAD_PMU_EVENT_ATTR(tad_hit_any, 0x1f),
+	TAD_PMU_EVENT_ATTR(tad_tag_rd, 0x20),
+	TAD_PMU_EVENT_ATTR(tad_tot_cycle, 0xFF),
+	NULL
+};
+
+static const struct attribute_group tad_pmu_events_attr_group = {
+	.name = "events",
+	.attrs = tad_pmu_event_attrs,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-7");
+
+static struct attribute *tad_pmu_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group tad_pmu_format_attr_group = {
+	.name = "format",
+	.attrs = tad_pmu_format_attrs,
+};
+
+static ssize_t tad_pmu_cpumask_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct tad_pmu *tad_pmu = to_tad_pmu(dev_get_drvdata(dev));
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(tad_pmu->cpu));
+}
+
+static DEVICE_ATTR(cpumask, 0444, tad_pmu_cpumask_show, NULL);
+
+static struct attribute *tad_pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL
+};
+
+static struct attribute_group tad_pmu_cpumask_attr_group = {
+	.attrs = tad_pmu_cpumask_attrs,
+};
+
+static const struct attribute_group *tad_pmu_attr_groups[] = {
+	&tad_pmu_events_attr_group,
+	&tad_pmu_format_attr_group,
+	&tad_pmu_cpumask_attr_group,
+	NULL
+};
+
+static int tad_pmu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct tad_region *regions;
+	struct tad_pmu *tad_pmu;
+	struct resource *res;
+	u32 tad_pmu_page_size;
+	u32 tad_page_size;
+	u32 tad_cnt;
+	int i, ret;
+	char *name;
+
+	tad_pmu = devm_kzalloc(&pdev->dev, sizeof(*tad_pmu), GFP_KERNEL);
+	if (!tad_pmu)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, tad_pmu);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Mem resource not found\n");
+		return -ENODEV;
+	}
+
+	ret = device_property_read_u32(dev, "marvell,tad-page-size", &tad_page_size);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't find tad-page-size property\n");
+		return ret;
+	}
+
+	ret = device_property_read_u32(dev, "marvell,tad-pmu-page-size",
+				       &tad_pmu_page_size);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't find tad-pmu-page-size property\n");
+		return ret;
+	}
+
+	ret = device_property_read_u32(dev, "marvell,tad-cnt", &tad_cnt);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't find tad-cnt property\n");
+		return ret;
+	}
+
+	regions = kcalloc(tad_cnt, sizeof(*regions), GFP_KERNEL);
+	if (!regions)
+		return -ENOMEM;
+
+	/* ioremap the distributed TAD pmu regions */
+	for (i = 0; i < tad_cnt && res->start < res->end; i++) {
+		regions[i].base = devm_ioremap(&pdev->dev,
+					       res->start,
+					       tad_pmu_page_size);
+		if (IS_ERR(regions[i].base)) {
+			dev_err(&pdev->dev, "TAD%d ioremap fail\n", i);
+			return -ENOMEM;
+		}
+		res->start += tad_page_size;
+	}
+
+	tad_pmu->regions = regions;
+	tad_pmu->region_cnt = tad_cnt;
+
+	tad_pmu->pmu = (struct pmu) {
+		.module		= THIS_MODULE,
+		.attr_groups	= tad_pmu_attr_groups,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+		.task_ctx_nr	= perf_invalid_context,
+
+		.event_init	= tad_pmu_event_init,
+		.add		= tad_pmu_event_counter_add,
+		.del		= tad_pmu_event_counter_del,
+		.start		= tad_pmu_event_counter_start,
+		.stop		= tad_pmu_event_counter_stop,
+		.read		= tad_pmu_event_counter_read,
+	};
+
+	tad_pmu->cpu = raw_smp_processor_id();
+
+	/* Register pmu instance for cpu hotplug */
+	ret = cpuhp_state_add_instance_nocalls(tad_pmu_cpuhp_state,
+					       &tad_pmu->node);
+	if (ret) {
+		dev_err(&pdev->dev, "Error %d registering hotplug\n", ret);
+		return ret;
+	}
+
+	name = "tad";
+	ret = perf_pmu_register(&tad_pmu->pmu, name, -1);
+	if (ret)
+		cpuhp_state_remove_instance_nocalls(tad_pmu_cpuhp_state,
+						    &tad_pmu->node);
+
+	return ret;
+}
+
+static int tad_pmu_remove(struct platform_device *pdev)
+{
+	struct tad_pmu *pmu = platform_get_drvdata(pdev);
+
+	cpuhp_state_remove_instance_nocalls(tad_pmu_cpuhp_state,
+					    &pmu->node);
+	perf_pmu_unregister(&pmu->pmu);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id tad_pmu_of_match[] = {
+	{ .compatible = "marvell,odyssey-tad-pmu", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, tad_pmu_of_match);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id tad_pmu_acpi_match[] = {
+	{"MRVL000D", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, tad_pmu_acpi_match);
+#endif
+
+static struct platform_driver odyssey_tad_pmu_driver = {
+	.driver         = {
+		.name   = "odyssey_tad_pmu",
+		.of_match_table = of_match_ptr(tad_pmu_of_match),
+		.acpi_match_table = ACPI_PTR(tad_pmu_acpi_match),
+		.suppress_bind_attrs = true,
+	},
+	.probe          = tad_pmu_probe,
+	.remove         = tad_pmu_remove,
+};
+
+static int odyssey_tad_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct tad_pmu *pmu = hlist_entry_safe(node, struct tad_pmu, node);
+	unsigned int target;
+
+	if (cpu != pmu->cpu)
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&pmu->pmu, cpu, target);
+	pmu->cpu = target;
+
+	return 0;
+}
+
+static int __init odyssey_tad_pmu_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				      "perf/odyssey/tadpmu:online",
+				      NULL,
+				      odyssey_tad_pmu_offline_cpu);
+	if (ret < 0)
+		return ret;
+	tad_pmu_cpuhp_state = ret;
+	return platform_driver_register(&odyssey_tad_pmu_driver);
+}
+
+static void __exit odyssey_tad_pmu_exit(void)
+{
+	platform_driver_unregister(&odyssey_tad_pmu_driver);
+	cpuhp_remove_multi_state(tad_pmu_cpuhp_state);
+}
+
+module_init(odyssey_tad_pmu_init);
+module_exit(odyssey_tad_pmu_exit);
+
+MODULE_DESCRIPTION("Marvell ODYSSEY LLC-TAD Perf driver");
+MODULE_AUTHOR("Gowthami Thiagarajan <gthiagarajan@marvell.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E233743B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjF3MEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjF3MEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:04:23 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FCE1FE8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 05:04:21 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U2CEdA013690;
        Fri, 30 Jun 2023 05:04:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=rQpQqNsFmEnWKYjTLxFnFgvFWXJuywrbtqpJn/1A1Lc=;
 b=Omr5PnAQCpa/vlmzfLuCaIPOOiQa54rUqal7P9qOhGOOxQC8/Ht7abLGiElFGEt8qutK
 W2X+BfptGXGQQn/3HVZR0R6aM1HerXTvV4vLO3H3uedTFe6a4V3joNH7dlAuitVue6Mr
 Db0a6uQDaiBMc+TWW5LNUNQg9Mqfzz0Xp1L+NEZeLvy3e4O0qWSPsEabdfjMhVy5zWrZ
 YriJC0O/6cCQ3OtqZ5B4IiTMzBqpKTWLgvgZdVByNrs/YO3+P2Wh10Qk2oMOu/3GmyVW
 i5SpS4HJprHcHiTcGp/3H74r12HTEhuEEDu5lwk8TXxzufUA5Qho6lwVFuJ/fQkRmz/r qQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rhp2ehnkx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 05:04:03 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 30 Jun
 2023 05:04:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 30 Jun 2023 05:04:02 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
        by maili.marvell.com (Postfix) with ESMTP id 0CC693F7059;
        Fri, 30 Jun 2023 05:03:58 -0700 (PDT)
From:   Gowthami Thiagarajan <gthiagarajan@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <bbhushan2@marvell.com>,
        <gcherian@marvell.com>, <lcherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH 1/6] perf/marvell: Marvell PEM performance monitor support
Date:   Fri, 30 Jun 2023 17:33:46 +0530
Message-ID: <20230630120351.1143773-2-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630120351.1143773-1-gthiagarajan@marvell.com>
References: <20230630120351.1143773-1-gthiagarajan@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xX5VeyxQPjjbE_kIV4hzeRB1nbmbeUSW
X-Proofpoint-GUID: xX5VeyxQPjjbE_kIV4hzeRB1nbmbeUSW
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

PCI Express Interface PMU includes various performance counters to monitor
the data that is transmitted over the PCIe link. The counters track various
inbound and outbound transactions which includes separate counters for
posted/non-posted/completion TLPs. Also, inbound and outbound memory read
requests along with their latencies can also be monitored. Address
Translation Services(ATS)events such as ATS Translation, ATS Page Request,
ATS Invalidation along with their corresponding latencies are also
supported.

The performance counters are 64 bits wide.

For instance,
perf stat -e ib_tlp_pr <workload>
tracks the inbound posted TLPs for the workload.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 MAINTAINERS                    |   7 +
 drivers/perf/Kconfig           |   7 +
 drivers/perf/Makefile          |   1 +
 drivers/perf/marvell_pem_pmu.c | 433 +++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h     |   1 +
 5 files changed, 449 insertions(+)
 create mode 100644 drivers/perf/marvell_pem_pmu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c6545eb54104..55a2a9b6f346 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12473,6 +12473,13 @@ S:	Supported
 F:	Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
 F:	drivers/net/ethernet/marvell/octeontx2/af/
 
+MARVELL PEM PMU DRIVER
+M:	Linu Cherian <lcherian@marvell.com>
+M:	Gowthami Thiagarajan <gthiagarajan@marvell.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/perf/marvell-odyssey-pem.yaml
+F:	drivers/perf/marvell_pem_pmu.c
+
 MARVELL PRESTERA ETHERNET SWITCH DRIVER
 M:	Taras Chornyi <taras.chornyi@plvision.eu>
 S:	Supported
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 66c259000a44..1cd8d07ffefd 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -203,4 +203,11 @@ source "drivers/perf/arm_cspmu/Kconfig"
 
 source "drivers/perf/amlogic/Kconfig"
 
+config MARVELL_PEM_PMU
+	tristate "MARVELL PEM PMU Support"
+	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
+	help
+	  Enable support for PCIe Interface performance monitoring
+	  on Marvell platform.
+
 endmenu
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 13e45da61100..bf9fe9cacad9 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
 obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
+obj-$(CONFIG_MARVELL_PEM_PMU) += marvell_pem_pmu.o
 obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
 obj-$(CONFIG_ALIBABA_UNCORE_DRW_PMU) += alibaba_uncore_drw_pmu.o
 obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu/
diff --git a/drivers/perf/marvell_pem_pmu.c b/drivers/perf/marvell_pem_pmu.c
new file mode 100644
index 000000000000..fb27112aa7d4
--- /dev/null
+++ b/drivers/perf/marvell_pem_pmu.c
@@ -0,0 +1,433 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell PEM(PCIe RC) Performance Monitor Driver
+ *
+ * Copyright (C) 2023 Marvell.
+ */
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/perf_event.h>
+
+/* Each of these events maps to a free running 64 bit counter
+ * with no event control, but can be reset.
+ *
+ */
+enum pem_events {
+	IB_TLP_NPR,
+	IB_TLP_PR,
+	IB_TLP_CPL,
+	IB_TLP_DWORDS_NPR,
+	IB_TLP_DWORDS_PR,
+	IB_TLP_DWORDS_CPL,
+	IB_INFLIGHT,
+	IB_READS,
+	IB_REQ_NO_RO_NCB,
+	IB_REQ_NO_RO_EBUS,
+	OB_TLP_NPR,
+	OB_TLP_PR,
+	OB_TLP_CPL,
+	OB_TLP_DWORDS_NPR,
+	OB_TLP_DWORDS_PR,
+	OB_TLP_DWORDS_CPL,
+	OB_INFLIGHT,
+	OB_READS,
+	OB_MERGES_NPR,
+	OB_MERGES_PR,
+	OB_MERGES_CPL,
+	ATS_TRANS,
+	ATS_TRANS_LATENCY,
+	ATS_PRI,
+	ATS_PRI_LATENCY,
+	ATS_INV,
+	ATS_INV_LATENCY,
+	PEM_EVENTIDS_MAX,
+};
+
+static u64 eventid_to_offset_table[] = {
+	0x0,
+	0x8,
+	0x10,
+	0x100,
+	0x108,
+	0x110,
+	0x200,
+	0x300,
+	0x400,
+	0x408,
+	0x500,
+	0x508,
+	0x510,
+	0x600,
+	0x608,
+	0x610,
+	0x700,
+	0x800,
+	0x900,
+	0x908,
+	0x910,
+	0x2D18,
+	0x2D20,
+	0x2D28,
+	0x2D30,
+	0x2D38,
+	0x2D40,
+};
+
+struct pem_pmu {
+	struct pmu pmu;
+	void __iomem *base;
+	unsigned int cpu;
+	struct	device *dev;
+	struct hlist_node node;
+};
+
+#define to_pem_pmu(p)	container_of(p, struct pem_pmu, pmu)
+
+static int eventid_to_offset(int eventid)
+{
+	return eventid_to_offset_table[eventid];
+}
+
+/* Events */
+static ssize_t pem_pmu_event_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
+#define PEM_EVENT_ATTR(_name, _id)					\
+	(&((struct perf_pmu_events_attr[]) {				\
+	{ .attr = __ATTR(_name, 0444, pem_pmu_event_show, NULL),	\
+		.id = _id, }						\
+	})[0].attr.attr)
+
+static struct attribute *pem_perf_events_attrs[] = {
+	PEM_EVENT_ATTR(ib_tlp_npr, IB_TLP_NPR),
+	PEM_EVENT_ATTR(ib_tlp_pr, IB_TLP_PR),
+	PEM_EVENT_ATTR(ib_tlp_cpl_partid, IB_TLP_CPL),
+	PEM_EVENT_ATTR(ib_tlp_dwords_npr, IB_TLP_DWORDS_NPR),
+	PEM_EVENT_ATTR(ib_tlp_dwords_pr, IB_TLP_DWORDS_PR),
+	PEM_EVENT_ATTR(ib_tlp_dwords_cpl_partid, IB_TLP_DWORDS_CPL),
+	PEM_EVENT_ATTR(ib_inflight, IB_INFLIGHT),
+	PEM_EVENT_ATTR(ib_reads, IB_READS),
+	PEM_EVENT_ATTR(ib_req_no_ro_ncb, IB_REQ_NO_RO_NCB),
+	PEM_EVENT_ATTR(ib_req_no_ro_ebus, IB_REQ_NO_RO_EBUS),
+	PEM_EVENT_ATTR(ob_tlp_npr_partid, OB_TLP_NPR),
+	PEM_EVENT_ATTR(ob_tlp_pr_partid, OB_TLP_PR),
+	PEM_EVENT_ATTR(ob_tlp_cpl_partid, OB_TLP_CPL),
+	PEM_EVENT_ATTR(ob_tlp_dwords_npr_partid, OB_TLP_DWORDS_NPR),
+	PEM_EVENT_ATTR(ob_tlp_dwords_pr_partid, OB_TLP_DWORDS_PR),
+	PEM_EVENT_ATTR(ob_tlp_dwords_cpl_partid, OB_TLP_DWORDS_CPL),
+	PEM_EVENT_ATTR(ob_inflight_partid, OB_INFLIGHT),
+	PEM_EVENT_ATTR(ob_reads_partid, OB_READS),
+	PEM_EVENT_ATTR(ob_merges_npr_partid, OB_MERGES_NPR),
+	PEM_EVENT_ATTR(ob_merges_pr_partid, OB_MERGES_PR),
+	PEM_EVENT_ATTR(ob_merges_cpl_partid, OB_MERGES_CPL),
+	PEM_EVENT_ATTR(ats_trans, ATS_TRANS),
+	PEM_EVENT_ATTR(ats_trans_latency, ATS_TRANS_LATENCY),
+	PEM_EVENT_ATTR(ats_pri, ATS_PRI),
+	PEM_EVENT_ATTR(ats_pri_latency, ATS_PRI_LATENCY),
+	PEM_EVENT_ATTR(ats_inv, ATS_INV),
+	PEM_EVENT_ATTR(ats_inv_latency, ATS_INV_LATENCY),
+	NULL
+};
+
+static struct attribute_group pem_perf_events_attr_group = {
+	.name = "events",
+	.attrs = pem_perf_events_attrs,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-5");
+
+static struct attribute *pem_perf_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL
+};
+
+static struct attribute_group pem_perf_format_attr_group = {
+	.name = "format",
+	.attrs = pem_perf_format_attrs,
+};
+
+/* cpumask */
+static ssize_t pem_perf_cpumask_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct pem_pmu *pmu = dev_get_drvdata(dev);
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
+}
+
+static struct device_attribute pem_perf_cpumask_attr =
+	__ATTR(cpumask, 0444, pem_perf_cpumask_show, NULL);
+
+static struct attribute *pem_perf_cpumask_attrs[] = {
+	&pem_perf_cpumask_attr.attr,
+	NULL
+};
+
+static struct attribute_group pem_perf_cpumask_attr_group = {
+	.attrs = pem_perf_cpumask_attrs,
+};
+
+static const struct attribute_group *pem_perf_attr_groups[] = {
+	&pem_perf_events_attr_group,
+	&pem_perf_cpumask_attr_group,
+	&pem_perf_format_attr_group,
+	NULL
+};
+
+static int pem_perf_event_init(struct perf_event *event)
+{
+	struct pem_pmu *pmu = to_pem_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (is_sampling_event(event)) {
+		dev_info(pmu->dev, "Sampling not supported!\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (event->cpu < 0) {
+		dev_warn(pmu->dev, "Can't provide per-task data!\n");
+		return -EOPNOTSUPP;
+	}
+
+	/*  We must NOT create groups containing mixed PMUs */
+	if (event->group_leader->pmu != event->pmu &&
+	    !is_software_event(event->group_leader))
+		return -EINVAL;
+
+	/* Set ownership of event to one CPU, same event can not be observed
+	 * on multiple cpus at same time.
+	 */
+	event->cpu = pmu->cpu;
+	hwc->idx = -1;
+	return 0;
+}
+
+static void pem_perf_counter_reset(struct pem_pmu *pmu,
+				   struct perf_event *event, int eventid)
+{
+	writeq_relaxed(0x0, pmu->base + eventid_to_offset(eventid));
+}
+
+static u64 pem_perf_read_counter(struct pem_pmu *pmu,
+				 struct perf_event *event, int eventid)
+{
+	return readq_relaxed(pmu->base + eventid_to_offset(eventid));
+}
+
+static void pem_perf_event_update(struct perf_event *event)
+{
+	struct pem_pmu *pmu = to_pem_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev_count, new_count;
+
+	do {
+		prev_count = local64_read(&hwc->prev_count);
+		new_count = pem_perf_read_counter(pmu, event, hwc->idx);
+	} while (local64_xchg(&hwc->prev_count, new_count) != prev_count);
+
+	local64_add((new_count - prev_count), &event->count);
+}
+
+static void pem_perf_event_start(struct perf_event *event, int flags)
+{
+	struct pem_pmu *pmu = to_pem_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int eventid = hwc->idx;
+
+	local64_set(&hwc->prev_count, 0);
+
+	pem_perf_counter_reset(pmu, event, eventid);
+
+	hwc->state = 0;
+}
+
+static int pem_perf_event_add(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	hwc->idx = event->attr.config;
+	if (hwc->idx >= PEM_EVENTIDS_MAX)
+		return -EINVAL;
+	hwc->state |= PERF_HES_STOPPED;
+
+	if (flags & PERF_EF_START)
+		pem_perf_event_start(event, flags);
+
+	return 0;
+}
+
+static void pem_perf_event_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (flags & PERF_EF_UPDATE)
+		pem_perf_event_update(event);
+
+	hwc->state |= PERF_HES_STOPPED;
+}
+
+static void pem_perf_event_del(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	pem_perf_event_stop(event, PERF_EF_UPDATE);
+	hwc->idx = -1;
+}
+
+static int pem_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct pem_pmu *pmu = hlist_entry_safe(node, struct pem_pmu,
+					       node);
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
+	return 0;
+}
+
+static int pem_perf_probe(struct platform_device *pdev)
+{
+	struct pem_pmu *pem_pmu;
+	struct resource *res;
+	void __iomem *base;
+	char *name;
+	int ret;
+
+	pem_pmu = devm_kzalloc(&pdev->dev, sizeof(*pem_pmu), GFP_KERNEL);
+	if (!pem_pmu)
+		return -ENOMEM;
+
+	pem_pmu->dev = &pdev->dev;
+	platform_set_drvdata(pdev, pem_pmu);
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	pem_pmu->base = base;
+
+	pem_pmu->pmu = (struct pmu) {
+		.module	      = THIS_MODULE,
+		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+		.task_ctx_nr = perf_invalid_context,
+		.attr_groups = pem_perf_attr_groups,
+		.event_init  = pem_perf_event_init,
+		.add	     = pem_perf_event_add,
+		.del	     = pem_perf_event_del,
+		.start	     = pem_perf_event_start,
+		.stop	     = pem_perf_event_stop,
+		.read	     = pem_perf_event_update,
+	};
+
+	/* Choose this cpu to collect perf data */
+	pem_pmu->cpu = raw_smp_processor_id();
+
+	name = devm_kasprintf(pem_pmu->dev, GFP_KERNEL, "mrvl_pcie_rc_pmu_%llx",
+			      res->start);
+	if (!name)
+		return -ENOMEM;
+
+	cpuhp_state_add_instance_nocalls(CPUHP_AP_PERF_ARM_MARVELL_PEM_ONLINE,
+					 &pem_pmu->node);
+
+	ret = perf_pmu_register(&pem_pmu->pmu, name, -1);
+	if (ret)
+		goto error;
+
+	pr_info("Marvell PEM(PCIe RC) PMU Driver for pem@%llx\n", res->start);
+	return 0;
+error:
+	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_MARVELL_PEM_ONLINE,
+					    &pem_pmu->node);
+	return ret;
+}
+
+static int pem_perf_remove(struct platform_device *pdev)
+{
+	struct pem_pmu *pem_pmu = platform_get_drvdata(pdev);
+
+	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_MARVELL_PEM_ONLINE,
+					    &pem_pmu->node);
+
+	perf_pmu_unregister(&pem_pmu->pmu);
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id pem_pmu_of_match[] = {
+	{ .compatible = "marvell,pem-pmu", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, pem_pmu_of_match);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id pem_pmu_acpi_match[] = {
+	{"MRVL000E", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, pem_pmu_acpi_match);
+#endif
+
+static struct platform_driver pem_pmu_driver = {
+	.driver	= {
+		.name   = "pem-pmu",
+		.of_match_table = of_match_ptr(pem_pmu_of_match),
+		.acpi_match_table = ACPI_PTR(pem_pmu_acpi_match),
+		.suppress_bind_attrs = true,
+	},
+	.probe		= pem_perf_probe,
+	.remove		= pem_perf_remove,
+};
+
+static int __init pem_pmu_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_MARVELL_PEM_ONLINE,
+				      "perf/marvell/pem:online", NULL,
+				       pem_pmu_offline_cpu);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&pem_pmu_driver);
+	if (ret)
+		cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_MARVELL_PEM_ONLINE);
+	return ret;
+}
+
+static void __exit pem_pmu_exit(void)
+{
+	platform_driver_unregister(&pem_pmu_driver);
+	cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_MARVELL_PEM_ONLINE);
+}
+
+module_init(pem_pmu_init);
+module_exit(pem_pmu_exit);
+
+MODULE_DESCRIPTION("Marvell PEM Perf driver");
+MODULE_AUTHOR("Linu Cherian <lcherian@marvell.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 0f1001dca0e0..f7710c03d24e 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -235,6 +235,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_APM_XGENE_ONLINE,
 	CPUHP_AP_PERF_ARM_CAVIUM_TX2_UNCORE_ONLINE,
 	CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
+	CPUHP_AP_PERF_ARM_MARVELL_PEM_ONLINE,
 	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
-- 
2.25.1


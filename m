Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90402729210
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbjFIIBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239723AbjFIIAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:00:35 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E99435A7;
        Fri,  9 Jun 2023 00:58:54 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Qctgt5CJXzLmj3;
        Fri,  9 Jun 2023 15:56:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 15:58:11 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <will@kernel.org>, <jonathan.cameron@huawei.com>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
        <yangyicong@huawei.com>, <shenyang39@huawei.com>,
        <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>
Subject: [PATCH v4 1/3] drivers/perf: hisi: Add support for HiSilicon H60PA and PAv3 PMU driver
Date:   Fri, 9 Jun 2023 15:56:06 +0800
Message-ID: <20230609075608.36559-2-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230609075608.36559-1-hejunhao3@huawei.com>
References: <20230609075608.36559-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compared to the original PA device, H60PA offers higher bandwidth.
The H60PA is a new device and we use HID to differentiate them.

The events supported by PAv3 and PAv2 are different. They use the
same HID. The PMU version register is used in the driver to
distinguish different versions.

For each H60PA PMU, except for the overflow interrupt register, other
functions of the H60PA PMU are the same as the original PA PMU module.
It has 8-programable counters and each counter is free-running.
Interrupt is supported to handle counter (64-bits) overflow.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c | 142 +++++++++++++++++---
 drivers/perf/hisilicon/hisi_uncore_pmu.h    |   9 ++
 2 files changed, 136 insertions(+), 15 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
index 71b6687d6696..c1b7180aadc1 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
@@ -22,9 +22,15 @@
 #define PA_TT_CTRL			0x1c08
 #define PA_TGTID_CTRL			0x1c14
 #define PA_SRCID_CTRL			0x1c18
+
+/* H32 PA interrupt registers */
 #define PA_INT_MASK			0x1c70
 #define PA_INT_STATUS			0x1c78
 #define PA_INT_CLEAR			0x1c7c
+
+#define H60PA_INT_STATUS		0x1c70
+#define H60PA_INT_MASK			0x1c74
+
 #define PA_EVENT_TYPE0			0x1c80
 #define PA_PMU_VERSION			0x1cf0
 #define PA_EVENT_CNT0_L			0x1d00
@@ -46,6 +52,12 @@ HISI_PMU_EVENT_ATTR_EXTRACTOR(srcid_cmd, config1, 32, 22);
 HISI_PMU_EVENT_ATTR_EXTRACTOR(srcid_msk, config1, 43, 33);
 HISI_PMU_EVENT_ATTR_EXTRACTOR(tracetag_en, config1, 44, 44);
 
+struct hisi_pa_pmu_int_regs {
+	u32 mask_offset;
+	u32 clear_offset;
+	u32 status_offset;
+};
+
 static void hisi_pa_pmu_enable_tracetag(struct perf_event *event)
 {
 	struct hisi_pmu *pa_pmu = to_hisi_pmu(event->pmu);
@@ -219,44 +231,50 @@ static void hisi_pa_pmu_disable_counter(struct hisi_pmu *pa_pmu,
 static void hisi_pa_pmu_enable_counter_int(struct hisi_pmu *pa_pmu,
 					   struct hw_perf_event *hwc)
 {
+	struct hisi_pa_pmu_int_regs *regs = pa_pmu->dev_info->private;
 	u32 val;
 
 	/* Write 0 to enable interrupt */
-	val = readl(pa_pmu->base + PA_INT_MASK);
+	val = readl(pa_pmu->base + regs->mask_offset);
 	val &= ~(1 << hwc->idx);
-	writel(val, pa_pmu->base + PA_INT_MASK);
+	writel(val, pa_pmu->base + regs->mask_offset);
 }
 
 static void hisi_pa_pmu_disable_counter_int(struct hisi_pmu *pa_pmu,
 					    struct hw_perf_event *hwc)
 {
+	struct hisi_pa_pmu_int_regs *regs = pa_pmu->dev_info->private;
 	u32 val;
 
 	/* Write 1 to mask interrupt */
-	val = readl(pa_pmu->base + PA_INT_MASK);
+	val = readl(pa_pmu->base + regs->mask_offset);
 	val |= 1 << hwc->idx;
-	writel(val, pa_pmu->base + PA_INT_MASK);
+	writel(val, pa_pmu->base + regs->mask_offset);
 }
 
 static u32 hisi_pa_pmu_get_int_status(struct hisi_pmu *pa_pmu)
 {
-	return readl(pa_pmu->base + PA_INT_STATUS);
+	struct hisi_pa_pmu_int_regs *regs = pa_pmu->dev_info->private;
+
+	return readl(pa_pmu->base + regs->status_offset);
 }
 
 static void hisi_pa_pmu_clear_int_status(struct hisi_pmu *pa_pmu, int idx)
 {
-	writel(1 << idx, pa_pmu->base + PA_INT_CLEAR);
-}
+	struct hisi_pa_pmu_int_regs *regs = pa_pmu->dev_info->private;
 
-static const struct acpi_device_id hisi_pa_pmu_acpi_match[] = {
-	{ "HISI0273", },
-	{}
-};
-MODULE_DEVICE_TABLE(acpi, hisi_pa_pmu_acpi_match);
+	writel(1 << idx, pa_pmu->base + regs->clear_offset);
+}
 
 static int hisi_pa_pmu_init_data(struct platform_device *pdev,
 				   struct hisi_pmu *pa_pmu)
 {
+	const struct hisi_pmu_dev_info *pa_pmu_info;
+
+	pa_pmu_info = device_get_match_data(&pdev->dev);
+	if (!pa_pmu_info)
+		return -ENODEV;
+
 	/*
 	 * As PA PMU is in a SICL, use the SICL_ID and the index ID
 	 * to identify the PA PMU.
@@ -284,6 +302,15 @@ static int hisi_pa_pmu_init_data(struct platform_device *pdev,
 
 	pa_pmu->identifier = readl(pa_pmu->base + PA_PMU_VERSION);
 
+	/* When running on v3 or later, returns the largest version supported */
+	if (pa_pmu->identifier >= HISI_PMU_V3)
+		pa_pmu->dev_info = &pa_pmu_info[2];
+	else if (pa_pmu->identifier == HISI_PMU_V2)
+		pa_pmu->dev_info = &pa_pmu_info[1];
+
+	if (!pa_pmu->dev_info || !pa_pmu->dev_info->name)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -314,6 +341,32 @@ static const struct attribute_group hisi_pa_pmu_v2_events_group = {
 	.attrs = hisi_pa_pmu_v2_events_attr,
 };
 
+static struct attribute *hisi_pa_pmu_v3_events_attr[] = {
+	HISI_PMU_EVENT_ATTR(tx_req,	0x0),
+	HISI_PMU_EVENT_ATTR(tx_dat,	0x1),
+	HISI_PMU_EVENT_ATTR(tx_snp,	0x2),
+	HISI_PMU_EVENT_ATTR(rx_req,	0x7),
+	HISI_PMU_EVENT_ATTR(rx_dat,	0x8),
+	HISI_PMU_EVENT_ATTR(rx_snp,	0x9),
+	NULL
+};
+
+static const struct attribute_group hisi_pa_pmu_v3_events_group = {
+	.name = "events",
+	.attrs = hisi_pa_pmu_v3_events_attr,
+};
+
+static struct attribute *hisi_h60pa_pmu_events_attr[] = {
+	HISI_PMU_EVENT_ATTR(rx_flit,	0x50),
+	HISI_PMU_EVENT_ATTR(tx_flit,	0x65),
+	NULL
+};
+
+static const struct attribute_group hisi_h60pa_pmu_events_group = {
+	.name = "events",
+	.attrs = hisi_h60pa_pmu_events_attr,
+};
+
 static DEVICE_ATTR(cpumask, 0444, hisi_cpumask_sysfs_show, NULL);
 
 static struct attribute *hisi_pa_pmu_cpumask_attrs[] = {
@@ -345,6 +398,57 @@ static const struct attribute_group *hisi_pa_pmu_v2_attr_groups[] = {
 	NULL
 };
 
+static const struct attribute_group *hisi_pa_pmu_v3_attr_groups[] = {
+	&hisi_pa_pmu_v2_format_group,
+	&hisi_pa_pmu_v3_events_group,
+	&hisi_pa_pmu_cpumask_attr_group,
+	&hisi_pa_pmu_identifier_group,
+	NULL
+};
+
+static struct hisi_pa_pmu_int_regs hisi_pa_pmu_regs = {
+	.mask_offset = PA_INT_MASK,
+	.clear_offset = PA_INT_CLEAR,
+	.status_offset = PA_INT_STATUS,
+};
+
+static const struct hisi_pmu_dev_info hisi_h32pa[] = {
+	[1] = {
+		.name = "pa",
+		.attr_groups = hisi_pa_pmu_v2_attr_groups,
+		.private = &hisi_pa_pmu_regs,
+	},
+	[2] = {
+		.name = "pa",
+		.attr_groups = hisi_pa_pmu_v3_attr_groups,
+		.private = &hisi_pa_pmu_regs,
+	},
+	{}
+};
+
+static const struct attribute_group *hisi_h60pa_pmu_attr_groups[] = {
+	&hisi_pa_pmu_v2_format_group,
+	&hisi_h60pa_pmu_events_group,
+	&hisi_pa_pmu_cpumask_attr_group,
+	&hisi_pa_pmu_identifier_group,
+	NULL
+};
+
+static struct hisi_pa_pmu_int_regs hisi_h60pa_pmu_regs = {
+	.mask_offset = H60PA_INT_MASK,
+	.clear_offset = H60PA_INT_STATUS, /* Clear on write */
+	.status_offset = H60PA_INT_STATUS,
+};
+
+static const struct hisi_pmu_dev_info hisi_h60pa[] = {
+	[1] = {
+		.name = "h60pa",
+		.attr_groups = hisi_h60pa_pmu_attr_groups,
+		.private = &hisi_h60pa_pmu_regs,
+	},
+	{}
+};
+
 static const struct hisi_uncore_ops hisi_uncore_pa_ops = {
 	.write_evtype		= hisi_pa_pmu_write_evtype,
 	.get_event_idx		= hisi_uncore_pmu_get_event_idx,
@@ -375,7 +479,7 @@ static int hisi_pa_pmu_dev_probe(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	pa_pmu->pmu_events.attr_groups = hisi_pa_pmu_v2_attr_groups;
+	pa_pmu->pmu_events.attr_groups = pa_pmu->dev_info->attr_groups;
 	pa_pmu->num_counters = PA_NR_COUNTERS;
 	pa_pmu->ops = &hisi_uncore_pa_ops;
 	pa_pmu->check_event = 0xB0;
@@ -400,8 +504,9 @@ static int hisi_pa_pmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sicl%u_pa%u",
-			      pa_pmu->sicl_id, pa_pmu->index_id);
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sicl%d_%s%u",
+			      pa_pmu->sicl_id, pa_pmu->dev_info->name,
+			      pa_pmu->index_id);
 	if (!name)
 		return -ENOMEM;
 
@@ -435,6 +540,13 @@ static int hisi_pa_pmu_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct acpi_device_id hisi_pa_pmu_acpi_match[] = {
+	{ "HISI0273", (kernel_ulong_t)hisi_h32pa },
+	{ "HISI0274", (kernel_ulong_t)hisi_h60pa },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, hisi_pa_pmu_acpi_match);
+
 static struct platform_driver hisi_pa_pmu_driver = {
 	.driver = {
 		.name = "hisi_pa_pmu",
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index 07890a8e96ca..a8d6d6905f3f 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -24,6 +24,7 @@
 #define pr_fmt(fmt)     "hisi_pmu: " fmt
 
 #define HISI_PMU_V2		0x30
+#define HISI_PMU_V3		0x40
 #define HISI_MAX_COUNTERS 0x10
 #define to_hisi_pmu(p)	(container_of(p, struct hisi_pmu, pmu))
 
@@ -62,6 +63,13 @@ struct hisi_uncore_ops {
 	void (*disable_filter)(struct perf_event *event);
 };
 
+/* Describes the HISI PMU chip features information */
+struct hisi_pmu_dev_info {
+	const char *name;
+	const struct attribute_group **attr_groups;
+	void *private;
+};
+
 struct hisi_pmu_hwevents {
 	struct perf_event *hw_events[HISI_MAX_COUNTERS];
 	DECLARE_BITMAP(used_mask, HISI_MAX_COUNTERS);
@@ -72,6 +80,7 @@ struct hisi_pmu_hwevents {
 struct hisi_pmu {
 	struct pmu pmu;
 	const struct hisi_uncore_ops *ops;
+	const struct hisi_pmu_dev_info *dev_info;
 	struct hisi_pmu_hwevents pmu_events;
 	/* associated_cpus: All CPUs associated with the PMU */
 	cpumask_t associated_cpus;
-- 
2.33.0


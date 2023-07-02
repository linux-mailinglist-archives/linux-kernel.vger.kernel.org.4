Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE227451BD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjGBT5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjGBT4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:56:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6A13C0B;
        Sun,  2 Jul 2023 12:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A91260D27;
        Sun,  2 Jul 2023 19:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BD1C433CC;
        Sun,  2 Jul 2023 19:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688327540;
        bh=9VkuWl9UM6MVMiyckygtIkCLIlpNPO5vMeq9NlAXafg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1VSYYIhQxo9YA8Yiw7Hhb/U9VdXWyPLT78mDnPbeg944PD8e9vPrFFybbwiQ7/kQ
         EcjCtE0z7QNN2mZsGZmiqiblYHgbtP9jYZpBZSUjirwQBRIge3M2DzsbBmXorj33mV
         iXCgEueaPv/0HKA71XyRv5SnXFns6uKCppp3VnE0qh+EJV7f9gf1XuGVO8gPD3XCQs
         4Zmz7ZlbEF0vwtfY84Ob1KPj0rmXEKYCiHrX+dYldzYX5X+y15Gha/hvY1KJXkxW9h
         1qDLiz+TJOrC1uNkQXhFkAijZJVRJ80kGuRKFvoXv5Rg1aLpRKN8s/5whJ67xX39LW
         MaLwlyryi85/Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Junhao He <hejunhao3@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        zhangshaokun@hisilicon.com, jonathan.cameron@huawei.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 8/9] drivers/perf: hisi: Add support for HiSilicon H60PA and PAv3 PMU driver
Date:   Sun,  2 Jul 2023 15:51:55 -0400
Message-Id: <20230702195159.1788402-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702195159.1788402-1-sashal@kernel.org>
References: <20230702195159.1788402-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.37
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junhao He <hejunhao3@huawei.com>

[ Upstream commit 1a51688474c0d395b864e98236335fba712e29bf ]

Compared to the original PA device, H60PA offers higher bandwidth.
The H60PA is a new device and we use HID to differentiate them.

The events supported by PAv3 and PAv2 are different. The PAv3 PMU
removed some events which are supported by PAv2 PMU. The older PA
PMU driver will probe v3 as v2. Therefore PA events displayed by
"perf list" cannot work properly. We add the HISI0275 HID for PAv3
PMU to distinguish different.

For each H60PA PMU, except for the overflow interrupt register, other
functions of the H60PA PMU are the same as the original PA PMU module.
It has 8-programable counters and each counter is free-running.
Interrupt is supported to handle counter (64-bits) overflow.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20230615125926.29832-2-hejunhao3@huawei.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c | 127 +++++++++++++++++---
 drivers/perf/hisilicon/hisi_uncore_pmu.h    |   8 ++
 2 files changed, 120 insertions(+), 15 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
index 47d3cc9b6eecd..00a773cbc9712 100644
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
@@ -219,40 +231,40 @@ static void hisi_pa_pmu_disable_counter(struct hisi_pmu *pa_pmu,
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
@@ -276,6 +288,10 @@ static int hisi_pa_pmu_init_data(struct platform_device *pdev,
 	pa_pmu->ccl_id = -1;
 	pa_pmu->sccl_id = -1;
 
+	pa_pmu->dev_info = device_get_match_data(&pdev->dev);
+	if (!pa_pmu->dev_info)
+		return -ENODEV;
+
 	pa_pmu->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pa_pmu->base)) {
 		dev_err(&pdev->dev, "ioremap failed for pa_pmu resource.\n");
@@ -314,6 +330,32 @@ static const struct attribute_group hisi_pa_pmu_v2_events_group = {
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
@@ -337,6 +379,12 @@ static const struct attribute_group hisi_pa_pmu_identifier_group = {
 	.attrs = hisi_pa_pmu_identifier_attrs,
 };
 
+static struct hisi_pa_pmu_int_regs hisi_pa_pmu_regs = {
+	.mask_offset = PA_INT_MASK,
+	.clear_offset = PA_INT_CLEAR,
+	.status_offset = PA_INT_STATUS,
+};
+
 static const struct attribute_group *hisi_pa_pmu_v2_attr_groups[] = {
 	&hisi_pa_pmu_v2_format_group,
 	&hisi_pa_pmu_v2_events_group,
@@ -345,6 +393,46 @@ static const struct attribute_group *hisi_pa_pmu_v2_attr_groups[] = {
 	NULL
 };
 
+static const struct hisi_pmu_dev_info hisi_h32pa_v2 = {
+	.name = "pa",
+	.attr_groups = hisi_pa_pmu_v2_attr_groups,
+	.private = &hisi_pa_pmu_regs,
+};
+
+static const struct attribute_group *hisi_pa_pmu_v3_attr_groups[] = {
+	&hisi_pa_pmu_v2_format_group,
+	&hisi_pa_pmu_v3_events_group,
+	&hisi_pa_pmu_cpumask_attr_group,
+	&hisi_pa_pmu_identifier_group,
+	NULL
+};
+
+static const struct hisi_pmu_dev_info hisi_h32pa_v3 = {
+	.name = "pa",
+	.attr_groups = hisi_pa_pmu_v3_attr_groups,
+	.private = &hisi_pa_pmu_regs,
+};
+
+static struct hisi_pa_pmu_int_regs hisi_h60pa_pmu_regs = {
+	.mask_offset = H60PA_INT_MASK,
+	.clear_offset = H60PA_INT_STATUS, /* Clear on write */
+	.status_offset = H60PA_INT_STATUS,
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
+static const struct hisi_pmu_dev_info hisi_h60pa = {
+	.name = "h60pa",
+	.attr_groups = hisi_h60pa_pmu_attr_groups,
+	.private = &hisi_h60pa_pmu_regs,
+};
+
 static const struct hisi_uncore_ops hisi_uncore_pa_ops = {
 	.write_evtype		= hisi_pa_pmu_write_evtype,
 	.get_event_idx		= hisi_uncore_pmu_get_event_idx,
@@ -375,7 +463,7 @@ static int hisi_pa_pmu_dev_probe(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	pa_pmu->pmu_events.attr_groups = hisi_pa_pmu_v2_attr_groups;
+	pa_pmu->pmu_events.attr_groups = pa_pmu->dev_info->attr_groups;
 	pa_pmu->num_counters = PA_NR_COUNTERS;
 	pa_pmu->ops = &hisi_uncore_pa_ops;
 	pa_pmu->check_event = 0xB0;
@@ -400,8 +488,9 @@ static int hisi_pa_pmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sicl%u_pa%u",
-			      pa_pmu->sicl_id, pa_pmu->index_id);
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sicl%d_%s%u",
+			      pa_pmu->sicl_id, pa_pmu->dev_info->name,
+			      pa_pmu->index_id);
 	if (!name)
 		return -ENOMEM;
 
@@ -435,6 +524,14 @@ static int hisi_pa_pmu_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct acpi_device_id hisi_pa_pmu_acpi_match[] = {
+	{ "HISI0273", (kernel_ulong_t)&hisi_h32pa_v2 },
+	{ "HISI0275", (kernel_ulong_t)&hisi_h32pa_v3 },
+	{ "HISI0274", (kernel_ulong_t)&hisi_h60pa },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, hisi_pa_pmu_acpi_match);
+
 static struct platform_driver hisi_pa_pmu_driver = {
 	.driver = {
 		.name = "hisi_pa_pmu",
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index b59de33cd0596..49a0808db70e8 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -62,6 +62,13 @@ struct hisi_uncore_ops {
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
@@ -72,6 +79,7 @@ struct hisi_pmu_hwevents {
 struct hisi_pmu {
 	struct pmu pmu;
 	const struct hisi_uncore_ops *ops;
+	const struct hisi_pmu_dev_info *dev_info;
 	struct hisi_pmu_hwevents pmu_events;
 	/* associated_cpus: All CPUs associated with the PMU */
 	cpumask_t associated_cpus;
-- 
2.39.2


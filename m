Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21AF677F95
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjAWPYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjAWPYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:24:23 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36F319773
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:23:52 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id 009E320E2D18;
        Mon, 23 Jan 2023 07:23:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 009E320E2D18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1674487414;
        bh=6yVfbftlAEMVDoy2/KKdGqDFHRZaTDzPvLDX+11tzNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kArLyiRwH+OznKs79i5G67uEcgHmCnUZbMnLN0JL1ZXdhJhmVOmfef7eambtIiwpu
         /NTl2+i5amoldWk4AHR3xPs/NtPrijLuGLfZg91lpbkRmo+jw2E2NwDi3XfcDyhIlO
         ZI8pb/3yStKSmRegYbSVGDNMdLVoQwg3u7XxQ0ik=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: [PATCH v1 4/8] x86/psp: Add IRQ support
Date:   Mon, 23 Jan 2023 15:22:46 +0000
Message-Id: <20230123152250.26413-5-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACPI PSP device provides a mailbox irq that needs to be configured
through the ACPI mailbox register first. This requires passing a CPU
vector and physical CPU id and then enabling interrupt delivery.
Allocate the irq directly from the default irq domain
(x86_vector_domain) to get access to the required information. By
passing a cpumask through irq_alloc_info the vector is immediately
allocated (and not later during activation) and can be retrieved.

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 arch/x86/kernel/psp.c | 179 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 175 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/psp.c b/arch/x86/kernel/psp.c
index d404df47cc04..24181d132bae 100644
--- a/arch/x86/kernel/psp.c
+++ b/arch/x86/kernel/psp.c
@@ -1,8 +1,176 @@
 // SPDX-License-Identifier: GPL-2.0-only
-
+#define pr_fmt(fmt) "psp: " fmt
 #include <linux/platform_data/psp.h>
 #include <linux/platform_device.h>
+#include <linux/iopoll.h>
+#include <linux/irq.h>
 #include <asm/hypervisor.h>
+#include <asm/irqdomain.h>
+
+#define PSP_ACPI_DATA_SHIFT 0
+#define PSP_ACPI_DATA_MASK GENMASK(15, 0)
+#define PSP_ACPI_CMDID_SHIFT 16
+#define PSP_ACPI_CMDID_MASK GENMASK(25, 16)
+#define PSP_ACPI_STATUS_SHIFT 26
+#define PSP_ACPI_STATUS_MASK GENMASK(30, 26)
+#define PSP_ACPI_RESPONSE_BIT BIT(31)
+
+#define PSP_ACPI_VECTOR_SHIFT 0
+#define PSP_ACPI_VECTOR_MASK GENMASK(7, 0)
+#define PSP_ACPI_MBOX_IRQID_SHIFT 10
+#define PSP_ACPI_MBOX_IRQID_MASK GENMASK(15, 10)
+
+#define PSP_ACPI_IRQ_EN_BIT BIT(0)
+#define PSP_ACPI_IRQ_EN_MBOX_IRQID_SHIFT 10
+#define PSP_ACPI_IRQ_EN_MBOX_IRQID_MASK GENMASK(15, 10)
+
+// AMD Secure Processor
+enum ASP_CMDID {
+	ASP_CMDID_PART1  = 0x82,
+	ASP_CMDID_PART2  = 0x83,
+	ASP_CMDID_PART3  = 0x84,
+	ASP_CMDID_IRQ_EN = 0x85,
+};
+
+enum ASP_CMD_STATUS {
+	ASP_CMD_STATUS_SUCCESS = 0x0,
+	ASP_CMD_STATUS_INVALID_CMD = 0x1,
+	ASP_CMD_STATUS_INVALID_PARAM = 0x2,
+	ASP_CMD_STATUS_INVALID_FW_STATE = 0x3,
+	ASP_CMD_STATUS_FAILURE = 0x1F,
+};
+
+struct psp_irq_data {
+	void __iomem *base;
+	int mbox_irq_id;
+	int acpi_cmd_resp_reg;
+};
+
+static int psp_sync_cmd(void __iomem *reg, u8 cmd, u16 data)
+{
+	u32 val = 0;
+	int err;
+
+	val |= data & PSP_ACPI_DATA_MASK;
+	val |= (cmd << PSP_ACPI_CMDID_SHIFT) & PSP_ACPI_CMDID_MASK;
+	writel(val, reg);
+	err = readl_poll_timeout_atomic(reg, val, val & PSP_ACPI_RESPONSE_BIT, 2, 10000);
+	if (err < 0)
+		return err;
+	return (val & PSP_ACPI_STATUS_MASK) >> PSP_ACPI_STATUS_SHIFT;
+}
+
+static int psp_set_irq_enable(struct psp_irq_data *data, bool irq_en)
+{
+	void __iomem *reg = data->base + data->acpi_cmd_resp_reg;
+	u8 mbox_irq_id = data->mbox_irq_id;
+	u16 val = 0;
+	int err;
+
+	val |= irq_en ? PSP_ACPI_IRQ_EN_BIT : 0;
+	val |= (mbox_irq_id << PSP_ACPI_IRQ_EN_MBOX_IRQID_SHIFT) & PSP_ACPI_IRQ_EN_MBOX_IRQID_MASK;
+	err = psp_sync_cmd(reg, ASP_CMDID_IRQ_EN, val);
+	if (err != ASP_CMD_STATUS_SUCCESS) {
+		pr_err("ASP_CMDID_IRQ_EN failed: %d\n", err);
+		return -EIO;
+	}
+	return 0;
+}
+
+static int psp_configure_irq(struct psp_irq_data *data, int vector, unsigned int cpu)
+{
+	void __iomem *reg = data->base + data->acpi_cmd_resp_reg;
+	unsigned int dest_cpu = cpu_physical_id(cpu);
+	u8 mbox_irq_id = data->mbox_irq_id;
+	u16 part1, part2, part3;
+	int err;
+
+	part1 = dest_cpu;
+	part2 = dest_cpu >> 16;
+	part3 = vector & PSP_ACPI_VECTOR_MASK;
+	part3 |= (mbox_irq_id << PSP_ACPI_MBOX_IRQID_SHIFT) & PSP_ACPI_MBOX_IRQID_MASK;
+
+	err = psp_sync_cmd(reg, ASP_CMDID_PART1, part1);
+	if (err != ASP_CMD_STATUS_SUCCESS) {
+		pr_err("ASP_CMDID_PART1 failed: %d\n", err);
+		return -EIO;
+	}
+	err = psp_sync_cmd(reg, ASP_CMDID_PART2, part2);
+	if (err != ASP_CMD_STATUS_SUCCESS) {
+		pr_err("ASP_CMDID_PART2 failed: %d\n", err);
+		return -EIO;
+	}
+	err = psp_sync_cmd(reg, ASP_CMDID_PART3, part3);
+	if (err != ASP_CMD_STATUS_SUCCESS) {
+		pr_err("ASP_CMDID_PART3 failed: %d\n", err);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+
+static int psp_init_irq(const struct psp_platform_data *pdata,
+	const struct resource *reg, struct resource *irq)
+{
+	struct psp_irq_data pspirqd;
+	struct irq_alloc_info info;
+	struct irq_data *data = NULL;
+	struct irq_cfg *cfg = NULL;
+	void __iomem *base = NULL;
+	int virq;
+	int err;
+
+	base = ioremap(reg->start, resource_size(reg));
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+	if (!base)
+		return -ENOMEM;
+	pspirqd.mbox_irq_id = pdata->mbox_irq_id;
+	pspirqd.acpi_cmd_resp_reg = pdata->acpi_cmd_resp_reg;
+	pspirqd.base = base;
+	init_irq_alloc_info(&info, cpumask_of(0));
+	virq = irq_domain_alloc_irqs(NULL, 1, NUMA_NO_NODE, &info);
+	if (virq <= 0) {
+		pr_err("failed to allocate vector: %d\n", virq);
+		err = -ENOMEM;
+		goto unmap;
+	}
+	irq_set_handler(virq, handle_edge_irq);
+	data = irq_get_irq_data(virq);
+	if (!data) {
+		pr_err("no irq data\n");
+		err = -ENODEV;
+		goto freeirq;
+
+	}
+	cfg = irqd_cfg(data);
+	if (!data) {
+		pr_err("no irq cfg\n");
+		err = -ENODEV;
+		goto freeirq;
+	}
+	err = psp_configure_irq(&pspirqd, cfg->vector, 0);
+	if (err) {
+		pr_err("failed to configure irq: %d\n", err);
+		goto freeirq;
+	}
+	err = psp_set_irq_enable(&pspirqd, true);
+	if (err) {
+		pr_err("failed to enable irq: %d\n", err);
+		goto freeirq;
+	}
+
+	*irq = (struct resource)DEFINE_RES_IRQ(virq);
+	iounmap(base);
+	return 0;
+
+freeirq:
+	irq_domain_free_irqs(virq, 1);
+unmap:
+	iounmap(base);
+	return err;
+}
 
 static struct platform_device psp_device = {
 	.name           = "psp",
@@ -12,7 +180,7 @@ static struct platform_device psp_device = {
 static int __init psp_init_platform_device(void)
 {
 	struct psp_platform_data pdata = {};
-	struct resource res[1];
+	struct resource res[2];
 	int err;
 
 	/*
@@ -24,10 +192,13 @@ static int __init psp_init_platform_device(void)
 	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
 		return -ENODEV;
 
-	err = acpi_parse_aspt(res, &pdata);
+	err = acpi_parse_aspt(&res[0], &pdata);
+	if (err)
+		return err;
+	err = psp_init_irq(&pdata, &res[0], &res[1]);
 	if (err)
 		return err;
-	err = platform_device_add_resources(&psp_device, res, 1);
+	err = platform_device_add_resources(&psp_device, res, 2);
 	if (err)
 		return err;
 
-- 
2.25.1


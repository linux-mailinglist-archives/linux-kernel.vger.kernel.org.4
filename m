Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1896CCA04
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 20:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjC1S3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 14:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjC1S3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:29:43 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8FAB1997
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:29:41 -0700 (PDT)
Received: from vm02.guest.corp.microsoft.com (unknown [167.220.197.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id 934E320FD938;
        Tue, 28 Mar 2023 11:29:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 934E320FD938
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680028181;
        bh=sX9Zu1E5yOJ8Rss02P0MXjSSVU7WYK0blqK720xrnhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPOemHSj41bWp6BijeKoXzFMb8o0S7OZZX3ORAIJ/b7OKOc4nHBSW9GWryH3g41UP
         OY79wtAIPgFE8/vzNEypIKCfFHYJaSJWbc8XNMnuYoqcv2bWsutc07Cb6tVRwU1i0x
         +yio3UD2sW04qnVB39SNgN++TDvbsXAu81X4THk8=
Date:   Tue, 28 Mar 2023 18:29:33 +0000
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v3 4/8] x86/psp: Add IRQ support
Message-ID: <20230328182933.GA1403032@vm02.guest.corp.microsoft.com>
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
 <20230320191956.1354602-5-jpiotrowski@linux.microsoft.com>
 <87h6ue9z0p.ffs@tglx>
 <89c227a5-0db6-7cbe-6beb-4035f58f036b@linux.microsoft.com>
 <877cv99k0y.ffs@tglx>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <877cv99k0y.ffs@tglx>
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 22, 2023 at 11:07:25AM +0100, Thomas Gleixner wrote:
> On Tue, Mar 21 2023 at 20:16, Jeremi Piotrowski wrote:
> > On 21/03/2023 11:31, Thomas Gleixner wrote:
> >  
> >>  1) What's so special about this PSP device that it requires a vector
> >>     directly from the vector domain and evades interrupt remapping?
> >
> > The PSP interrupt configuration requires passing an APIC id and interrupt
> > vector that it will assert. The closest thing I found that provides me with
> > those was the x86_vector_domain. Here's the link to the ACPI interface, the
> > relevant info is on pages 13-15 (it's not very detailed, but that's all I
> > had when implementing this):
> > https://www.amd.com/system/files/TechDocs/58028_1.00-PUB.pdf
> 
> That seriously expects an (extended) APIC-ID so that firmware can fiddle
> with X2APIC ICR directly.
> 
> Why can't firmware people just use something which is properly
> manageable by the OS, e.g. a MSI message or something like the ACPI
> interrupt? Because that would just be too useful and not require
> horrible hacks.
> 
> So my initial suggestion to piggy pack that on device MSI is moot. Let
> me think about it.
> 
> Thanks,
> 
>         tglx
> 
> 

So this is what it looks when done properly with an irq_domain. It definitely
feels less like a hack to me now (thank you): setting affinity works and the
irq is enabled only when requested. The lack of support for interrupt remapping
and the need to configure with APIC-ID/vector comes from the fact that for
firmware designers this PSP operates at the same level as the AMD IOMMU (and
the IOMMU is responsible for interrupt remapping).

Let me know what you think.

Jeremi

--SUOF0GtieIMvvwua
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline;
	filename="0001-Drivers-hv-psp-Add-IRQ-support.patch"

From 5879fe35f88d987952443ce4f62076817b65a711 Mon Sep 17 00:00:00 2001
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Date: Wed, 18 Jan 2023 10:04:56 +0000
Subject: [PATCH] Drivers: hv: psp: Add IRQ support

The ACPI PSP device provides a mailbox irq that needs to be configured
through the ACPI mailbox register. The PSP IRQ functionality is similar
to the intcapxt mechanism used by AMD IOMMU (drivers/iommu/amd/init.c)
and configuring the interrupt requires direct access to the interrupt
vector and APIC-ID.

Setup an irq domain with the x86_vector_domain as a parent and allocate
the irq from there. The domain is sized to one irq since there can only
be a single ASPT table and therefore a single ACPI PSP device. The
driver that handles the psp command set (drivers/crypto/ccp) can then
request_irq() as usual.

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 drivers/hv/psp.c | 240 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 236 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/psp.c b/drivers/hv/psp.c
index 64f3bfc5c9ff..18e4c1045c64 100644
--- a/drivers/hv/psp.c
+++ b/drivers/hv/psp.c
@@ -1,8 +1,237 @@
 // SPDX-License-Identifier: GPL-2.0-only
-
+#define pr_fmt(fmt) "psp: " fmt
 #include <linux/platform_data/psp.h>
 #include <linux/platform_device.h>
+#include <linux/iopoll.h>
+#include <linux/irq.h>
+#include <asm/apic.h>
 #include <asm/hypervisor.h>
+#include <asm/irqdomain.h>
+
+#define PSP_ACPI_CMDID_SHIFT 16
+#define PSP_ACPI_STATUS_SHIFT 26
+#define PSP_ACPI_STATUS_MASK GENMASK(30, 26)
+#define PSP_ACPI_RESPONSE_BIT BIT(31)
+#define PSP_ACPI_VECTOR_MASK GENMASK(7, 0)
+#define PSP_ACPI_DEST_MODE_SHIFT 9
+#define PSP_ACPI_MBOX_IRQID_SHIFT 10
+#define PSP_ACPI_IRQ_EN_BIT BIT(0)
+#define PSP_ACPI_IRQ_EN_MBOX_IRQID_SHIFT 10
+
+#define PSP_CMD_DELAY_US 2
+#define PSP_CMD_TIMEOUT_US 10000
+
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
+	u8 mbox_irq_id;
+	int acpi_cmd_resp_reg;
+	struct irq_domain *domain;
+};
+
+static struct psp_irq_data pspirqd;
+
+static int psp_sync_cmd(void __iomem *reg, u8 cmd, u16 data)
+{
+	u32 val;
+	int err;
+
+	val  = data;
+	val |= cmd << PSP_ACPI_CMDID_SHIFT;
+	writel(val, reg);
+	err = readl_poll_timeout_atomic(reg, val, val & PSP_ACPI_RESPONSE_BIT, PSP_CMD_DELAY_US,
+					PSP_CMD_TIMEOUT_US);
+	if (err)
+		return err;
+
+	return (val & PSP_ACPI_STATUS_MASK) >> PSP_ACPI_STATUS_SHIFT;
+}
+
+static int psp_set_irq_enable(struct psp_irq_data *data, bool irq_en)
+{
+	void __iomem *reg = data->base + data->acpi_cmd_resp_reg;
+	u16 val = 0;
+	int err;
+
+	if (data->mbox_irq_id > 63)
+		return -EINVAL;
+
+	val  = irq_en ? PSP_ACPI_IRQ_EN_BIT : 0;
+	val |= data->mbox_irq_id << PSP_ACPI_IRQ_EN_MBOX_IRQID_SHIFT;
+	err = psp_sync_cmd(reg, ASP_CMDID_IRQ_EN, val);
+	if (err != ASP_CMD_STATUS_SUCCESS) {
+		pr_err("ASP_CMDID_IRQ_EN failed: %d\n", err);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int psp_configure_irq(struct psp_irq_data *data, unsigned int vector, unsigned int apicid)
+{
+	void __iomem *reg = data->base + data->acpi_cmd_resp_reg;
+	u16 part1, part2, part3;
+	int err;
+
+	if (data->mbox_irq_id > 63)
+		return -EINVAL;
+
+	part1  = apicid;
+	part2  = apicid >> 16;
+	part3  = vector & PSP_ACPI_VECTOR_MASK;
+	part3 |= apic->dest_mode_logical << PSP_ACPI_DEST_MODE_SHIFT;
+	part3 |= data->mbox_irq_id << PSP_ACPI_MBOX_IRQID_SHIFT;
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
+static int psp_irq_set_affinity(struct irq_data *data, const struct cpumask *mask, bool force)
+{
+	struct psp_irq_data *pspirqd = irq_data_get_irq_chip_data(data);
+	struct irq_cfg *cfg;
+	int err;
+
+	err = irq_chip_set_affinity_parent(data, mask, force);
+	if (err < 0 || err == IRQ_SET_MASK_OK_DONE)
+		return err;
+
+	cfg = irqd_cfg(data);
+	err = psp_configure_irq(pspirqd, cfg->vector, cfg->dest_apicid);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void psp_irq_unmask(struct irq_data *data)
+{
+	struct psp_irq_data *pspirqd = irq_data_get_irq_chip_data(data);
+
+	psp_set_irq_enable(pspirqd, true);
+}
+
+static void psp_irq_mask(struct irq_data *data)
+{
+	struct psp_irq_data *pspirqd = irq_data_get_irq_chip_data(data);
+
+	psp_set_irq_enable(pspirqd, false);
+}
+
+static const struct irq_chip psp_irq_chip = {
+	.name			= "PSP-IRQ",
+	.irq_set_affinity	= psp_irq_set_affinity,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_mask		= psp_irq_mask,
+	.irq_unmask		= psp_irq_unmask,
+	.flags			= IRQCHIP_AFFINITY_PRE_STARTUP,
+};
+
+static int psp_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				unsigned int nr_irqs, void *args)
+{
+	int err;
+	int i;
+
+	err = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, args);
+	if (err)
+		return err;
+
+	for (i = virq; i < virq + nr_irqs; i++) {
+		irq_set_chip_and_handler_name(i, &psp_irq_chip, handle_edge_irq, "edge");
+		irq_set_chip_data(i, domain->host_data);
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops psp_irq_domain_ops = {
+	.alloc	= psp_irq_domain_alloc,
+	.free	= irq_domain_free_irqs_top,
+};
+
+static int psp_init_irq(const struct psp_platform_data *pdata, const struct resource *reg,
+			struct resource *irq)
+{
+	struct irq_alloc_info info;
+	struct fwnode_handle *fn;
+	void __iomem *base;
+	int virq;
+	int err;
+
+	base = ioremap(reg->start, resource_size(reg));
+	if (!base)
+		return -ENOMEM;
+
+	pspirqd.mbox_irq_id = pdata->mbox_irq_id;
+	pspirqd.acpi_cmd_resp_reg = pdata->acpi_cmd_resp_reg;
+	pspirqd.base = base;
+
+	fn = irq_domain_alloc_named_fwnode("AMD-PSP-IRQ");
+	if (!fn) {
+		err = -ENOMEM;
+		goto unmap;
+	}
+
+	pspirqd.domain = irq_domain_create_hierarchy(x86_vector_domain, 0, 1,
+						     fn,
+						     &psp_irq_domain_ops,
+						     &pspirqd);
+	if (!pspirqd.domain) {
+		err = -ENOMEM;
+		goto freefwnode;
+	}
+
+	init_irq_alloc_info(&info, NULL);
+	virq = irq_domain_alloc_irqs(pspirqd.domain, 1, NUMA_NO_NODE, &info);
+	if (virq < 0) {
+		err = virq;
+		goto freedomain;
+	}
+	*irq = (struct resource)DEFINE_RES_IRQ(virq);
+
+	return 0;
+
+freedomain:
+	irq_domain_remove(pspirqd.domain);
+	pspirqd.domain = NULL;
+freefwnode:
+	irq_domain_free_fwnode(fn);
+unmap:
+	iounmap(base);
+
+	return err;
+}
 
 static struct platform_device psp_device = {
 	.name           = "psp",
@@ -12,7 +241,7 @@ static struct platform_device psp_device = {
 static int __init psp_init_platform_device(void)
 {
 	struct psp_platform_data pdata = {};
-	struct resource res[1];
+	struct resource res[2];
 	int err;
 
 	/*
@@ -24,10 +253,13 @@ static int __init psp_init_platform_device(void)
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
 	err = platform_device_add_data(&psp_device, &pdata, sizeof(pdata));
-- 
2.34.1


--SUOF0GtieIMvvwua--

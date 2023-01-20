Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF426760B8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjATWuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjATWt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:49:57 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5115B71794;
        Fri, 20 Jan 2023 14:49:14 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KMaweS014407;
        Fri, 20 Jan 2023 22:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=BXEnrXwGqTI3T1+o30DwR+yNP1d/WEZFOXygxs9Y0i8=;
 b=ADCNWxZoWV59UDRYWq4rF7anCGhhgsL/t1sjwmJKC51V3q+lWhHmXHAgK094SCKu26uj
 q+peRENGy7F6VBZ4Kqiw6UGY3ySQYPie4id/XRrn0ohEVurG5rvuaz+0F7CLS9ZQ6vm6
 /v3lVYWvihY7YXw0YYdVgMDypgdWlbdkCiPgrOqx0bxralurseOPXw4/XjwRZu29zN4K
 PnBj2fRFZahnlQ7+n3LCAM/ELia+RHBx8VJbIIoumP6WTDPmqRLyNLYQRvxwHqrnn2o2
 vCUSBBJvqUaqcN8gYHXXVzlltXcQplyr5qZQanbIFjn0XV65umAukq2/32Zx9wHPEqm+ nA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n75w3kmxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:48:02 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KMm1S2032328
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:48:01 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 14:48:00 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v9 20/27] virt: gunyah: Translate gh_rm_hyp_resource into gunyah_resource
Date:   Fri, 20 Jan 2023 14:46:19 -0800
Message-ID: <20230120224627.4053418-21-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120224627.4053418-1-quic_eberman@quicinc.com>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qxB0EkfttoQjpmgn9t4K3XNc4oSlS_wl
X-Proofpoint-GUID: qxB0EkfttoQjpmgn9t4K3XNc4oSlS_wl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=992
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting a Gunyah virtual machine, the host VM may gain capabilities
to interact with resources for the guest virtual machine. Examples of
such resources are vCPUs or message queues. To use those resources, we
need to translate the RM response into a gunyah_resource structure which
are useful to Linux drivers. Presently, Linux drivers need only to know
the type of resource, the capability ID, and an interrupt.

On ARM64 systems, the interrupt reported by Gunyah is the GIC interrupt
ID number and always a SPI.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/include/asm/gunyah.h |  23 +++++
 drivers/virt/gunyah/rsc_mgr.c   | 170 +++++++++++++++++++++++++++++++-
 include/linux/gunyah_rsc_mgr.h  |   4 +
 3 files changed, 196 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/gunyah.h

diff --git a/arch/arm64/include/asm/gunyah.h b/arch/arm64/include/asm/gunyah.h
new file mode 100644
index 000000000000..64cfb964efee
--- /dev/null
+++ b/arch/arm64/include/asm/gunyah.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef __ASM_GUNYAH_H_
+#define __ASM_GUNYAH_H_
+
+#include <linux/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+static inline int arch_gh_fill_irq_fwspec_params(u32 virq, struct irq_fwspec *fwspec)
+{
+	if (virq < 32 || virq > 1019)
+		return -EINVAL;
+
+	fwspec->param_count = 3;
+	fwspec->param[0] = GIC_SPI;
+	fwspec->param[1] = virq - 32;
+	fwspec->param[2] = IRQ_TYPE_EDGE_RISING;
+	return 0;
+}
+
+#endif
diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
index 95f4aa928aaf..b9ee8fa71ccf 100644
--- a/drivers/virt/gunyah/rsc_mgr.c
+++ b/drivers/virt/gunyah/rsc_mgr.c
@@ -18,6 +18,8 @@
 #include <linux/platform_device.h>
 #include <linux/miscdevice.h>
 
+#include <asm/gunyah.h>
+
 #include "rsc_mgr.h"
 #include "vm_mgr.h"
 
@@ -108,9 +110,146 @@ struct gh_rm {
 	struct mutex send_lock;
 
 	struct miscdevice miscdev;
+	struct irq_domain *irq_domain;
+
 	struct work_struct recv_work;
 };
 
+struct gh_irq_chip_data {
+	u32 gh_virq;
+};
+
+static struct irq_chip gh_rm_irq_chip = {
+	.name			= "Gunyah",
+	.irq_enable		= irq_chip_enable_parent,
+	.irq_disable		= irq_chip_disable_parent,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_mask_ack		= irq_chip_mask_ack_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_wake		= irq_chip_set_wake_parent,
+	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_get_irqchip_state	= irq_chip_get_parent_state,
+	.irq_set_irqchip_state	= irq_chip_set_parent_state,
+	.flags			= IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int gh_rm_irq_domain_alloc(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs,
+				 void *arg)
+{
+	struct irq_fwspec parent_fwspec;
+	struct gh_irq_chip_data *chip_data, *spec = arg;
+	u32 gh_virq = spec->gh_virq;
+	struct gh_rm *rm = d->host_data;
+	int ret;
+
+	if (nr_irqs != 1 || gh_virq == U32_MAX)
+		return -EINVAL;
+
+	chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL);
+	if (!chip_data)
+		return -ENOMEM;
+
+	chip_data->gh_virq = gh_virq;
+
+	ret = irq_domain_set_hwirq_and_chip(d, virq, chip_data->gh_virq, &gh_rm_irq_chip,
+						chip_data);
+	if (ret)
+		return ret;
+
+	parent_fwspec.fwnode = d->parent->fwnode;
+	ret = arch_gh_fill_irq_fwspec_params(chip_data->gh_virq, &parent_fwspec);
+	if (ret) {
+		dev_err(rm->dev, "virq translation failed %u: %d\n", chip_data->gh_virq, ret);
+		goto err_free_irq_data;
+	}
+
+	ret = irq_domain_alloc_irqs_parent(d, virq, nr_irqs, &parent_fwspec);
+	if (ret)
+		goto err_free_irq_data;
+
+	return ret;
+err_free_irq_data:
+	kfree(chip_data);
+	return ret;
+}
+
+static void gh_rm_irq_domain_free_single(struct irq_domain *d, unsigned int virq)
+{
+	struct irq_data *irq_data;
+	struct gh_irq_chip_data *chip_data;
+
+	irq_data = irq_domain_get_irq_data(d, virq);
+	if (!irq_data)
+		return;
+
+	chip_data = irq_data->chip_data;
+
+	kfree(chip_data);
+	irq_data->chip_data = NULL;
+}
+
+static void gh_rm_irq_domain_free(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr_irqs; i++)
+		gh_rm_irq_domain_free_single(d, virq);
+}
+
+static const struct irq_domain_ops gh_rm_irq_domain_ops = {
+	.alloc		= gh_rm_irq_domain_alloc,
+	.free		= gh_rm_irq_domain_free,
+};
+
+struct gunyah_resource *gh_rm_alloc_resource(struct gh_rm *rm,
+						struct gh_rm_hyp_resource *hyp_resource)
+{
+	struct gunyah_resource *ghrsc;
+
+	ghrsc = kzalloc(sizeof(*ghrsc), GFP_KERNEL);
+	if (!ghrsc)
+		return NULL;
+
+	ghrsc->type = hyp_resource->type;
+	ghrsc->capid = le64_to_cpu(hyp_resource->cap_id);
+	ghrsc->irq = IRQ_NOTCONNECTED;
+	ghrsc->rm_label = le32_to_cpu(hyp_resource->resource_label);
+	/* Gunyah doesn't send us virq_handle anymore and will always give us an interrupt
+	 * that's ready to be used. Defensively check that it's not set.
+	 */
+	if (hyp_resource->virq_handle) {
+		pr_warn_once("Unexpected virq handle.\n");
+	} else if (hyp_resource->virq && le32_to_cpu(hyp_resource->virq) != U32_MAX) {
+		struct gh_irq_chip_data irq_data = {
+			.gh_virq = le32_to_cpu(hyp_resource->virq),
+		};
+
+		ghrsc->irq = irq_domain_alloc_irqs(rm->irq_domain, 1, NUMA_NO_NODE, &irq_data);
+		if (ghrsc->irq < 0) {
+			pr_err("Failed to allocate interrupt for resource %d label: %d: %d\n",
+				ghrsc->type, ghrsc->rm_label, ghrsc->irq);
+			ghrsc->irq = IRQ_NOTCONNECTED;
+		}
+	}
+
+	return ghrsc;
+}
+EXPORT_SYMBOL_GPL(gh_rm_alloc_resource);
+
+void gh_rm_free_resource(struct gunyah_resource *ghrsc)
+{
+	irq_dispose_mapping(ghrsc->irq);
+	kfree(ghrsc);
+}
+EXPORT_SYMBOL_GPL(gh_rm_free_resource);
+
 static struct gh_rm_connection *gh_rm_alloc_connection(__le32 msg_id, u8 type)
 {
 	struct gh_rm_connection *connection;
@@ -582,6 +721,9 @@ static int gh_msgq_platform_probe_direction(struct platform_device *pdev,
 static int gh_rm_drv_probe(struct platform_device *pdev)
 {
 	struct gh_rm *rm;
+	struct device_node *parent_irq_node;
+	struct irq_domain *parent_irq_domain;
+	struct gh_msgq_tx_data *msg;
 	int ret;
 
 	rm = devm_kzalloc(&pdev->dev, sizeof(*rm), GFP_KERNEL);
@@ -616,15 +758,40 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_cache;
 
+	parent_irq_node = of_irq_find_parent(pdev->dev.of_node);
+	if (!parent_irq_node) {
+		dev_err(&pdev->dev, "Failed to find interrupt parent of resource manager\n");
+		ret = -ENODEV;
+		goto err_msgq;
+	}
+
+	parent_irq_domain = irq_find_host(parent_irq_node);
+	if (!parent_irq_domain) {
+		dev_err(&pdev->dev, "Failed to find interrupt parent domain of resource manager\n");
+		ret = -ENODEV;
+		goto err_msgq;
+	}
+
+	rm->irq_domain = irq_domain_add_hierarchy(parent_irq_domain, 0, 0, pdev->dev.of_node,
+							&gh_rm_irq_domain_ops, NULL);
+	if (!rm->irq_domain) {
+		dev_err(&pdev->dev, "Failed to add irq domain\n");
+		ret = -ENODEV;
+		goto err_msgq;
+	}
+	rm->irq_domain->host_data = rm;
+
 	rm->miscdev.name = "gunyah";
 	rm->miscdev.minor = MISC_DYNAMIC_MINOR;
 	rm->miscdev.fops = &gh_dev_fops;
 
 	ret = misc_register(&rm->miscdev);
 	if (ret)
-		goto err_msgq;
+		goto err_irq_domain;
 
 	return 0;
+err_irq_domain:
+	irq_domain_remove(rm->irq_domain);
 err_msgq:
 	mbox_free_channel(gh_msgq_chan(&rm->msgq));
 	gh_msgq_remove(&rm->msgq);
@@ -638,6 +805,7 @@ static int gh_rm_drv_remove(struct platform_device *pdev)
 	struct gh_rm *rm = platform_get_drvdata(pdev);
 
 	misc_deregister(&rm->miscdev);
+	irq_domain_remove(rm->irq_domain);
 	mbox_free_channel(gh_msgq_chan(&rm->msgq));
 	gh_msgq_remove(&rm->msgq);
 	kmem_cache_destroy(rm->cache);
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index dd94bb3f378b..39d0c3d2dbc1 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -120,6 +120,10 @@ int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
 				struct gh_rm_hyp_resources **resources);
 int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid);
 
+struct gunyah_resource *gh_rm_alloc_resource(struct gh_rm *rm,
+						struct gh_rm_hyp_resource *hyp_resource);
+void gh_rm_free_resource(struct gunyah_resource *ghrsc);
+
 struct gunyah_rm_platform_ops {
 	int (*pre_mem_share)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
 	int (*post_mem_reclaim)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
-- 
2.39.0


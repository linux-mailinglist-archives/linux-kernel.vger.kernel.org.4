Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB96651671
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiLSXFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiLSXDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:03:06 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22840167E2;
        Mon, 19 Dec 2022 15:01:07 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJM0L6d032477;
        Mon, 19 Dec 2022 23:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Lrw4Tx4Z1cIpjGCdnAs+WPPB4YmlfGnD0l2AfnEQN6o=;
 b=dJ1GfEr80ZsvTgC27xJYV2Tsjtd4HpvFQYkKVdaKX4DBq7Q5NBWgDVsC0RyOPqbsLiq0
 T1In1KQxrjSvSU5/XyW6Rzbe2Z/nx0YzbxatiJCakLzPxoo03jiPQCaVLnU5UNVf9NI0
 IOCK1SsdQxaD7QkTGJxfaEobp8vOuvWNfNa3re3fzKCxrZjm1VqxQ1fIW3+jsKHJJrEq
 2p9wWqcPlDq5YNrbi9T+0GzQEQZxlCdlTu7QBpoO+zJVoD8GW7X/0KMcm8qwtC/nEzW7
 RDHhELl1mMt3NIQwtsHKtyxwqyTRdRXfzy2/KQGFJxnb1Co+1N4gbO7yA67i3V/6ATNw DQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mh3fpne0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:47 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BJN0k6p019209
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:46 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 15:00:45 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v8 21/28] virt: gunyah: Translate gh_rm_hyp_resource into gunyah_resource
Date:   Mon, 19 Dec 2022 14:58:42 -0800
Message-ID: <20221219225850.2397345-22-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219225850.2397345-1-quic_eberman@quicinc.com>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PeJWdzlLywY9nqjNAIgu7oDGTrBda3Mp
X-Proofpoint-GUID: PeJWdzlLywY9nqjNAIgu7oDGTrBda3Mp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212190202
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/virt/gunyah/rsc_mgr.c   | 168 +++++++++++++++++++++++++++++++-
 include/linux/gunyah.h          |   3 +
 include/linux/gunyah_rsc_mgr.h  |   4 +
 4 files changed, 197 insertions(+), 1 deletion(-)
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
index 49d7939bbe36..1010e725f1bd 100644
--- a/drivers/virt/gunyah/rsc_mgr.c
+++ b/drivers/virt/gunyah/rsc_mgr.c
@@ -18,6 +18,8 @@
 #include <linux/platform_device.h>
 #include <linux/miscdevice.h>
 
+#include <asm/gunyah.h>
+
 #include "rsc_mgr.h"
 #include "vm_mgr.h"
 
@@ -99,9 +101,145 @@ struct gh_rm_rpc {
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
+	struct gh_rm_rpc *rsc_mgr = d->host_data;
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
+		dev_err(rsc_mgr->dev, "virq translation failed %u: %d\n", chip_data->gh_virq, ret);
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
+struct gunyah_resource *gh_rm_alloc_resource(struct gh_rm_rpc *rm,
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
+			pr_err("Failed to allocate interrupt: %d\n", ghrsc->irq);
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
 static struct gh_rm_connection *gh_rm_alloc_connection(u32 msg_id, u8 type)
 {
 	struct gh_rm_connection *connection;
@@ -552,6 +690,8 @@ static int gh_msgq_platform_probe_direction(struct platform_device *pdev,
 static int gh_rm_drv_probe(struct platform_device *pdev)
 {
 	struct gh_rm_rpc *rsc_mgr;
+	struct device_node *parent_irq_node;
+	struct irq_domain *parent_irq_domain;
 	int ret;
 
 	rsc_mgr = devm_kzalloc(&pdev->dev, sizeof(*rsc_mgr), GFP_KERNEL);
@@ -583,15 +723,40 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
 	ret = gh_msgq_init(&pdev->dev, &rsc_mgr->msgq, &rsc_mgr->msgq_client,
 				&rsc_mgr->tx_ghrsc, &rsc_mgr->rx_ghrsc);
 
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
+	rsc_mgr->irq_domain = irq_domain_add_hierarchy(parent_irq_domain, 0, 0, pdev->dev.of_node,
+							&gh_rm_irq_domain_ops, NULL);
+	if (!rsc_mgr->irq_domain) {
+		dev_err(&pdev->dev, "Failed to add irq domain\n");
+		ret = -ENODEV;
+		goto err_msgq;
+	}
+	rsc_mgr->irq_domain->host_data = rsc_mgr;
+
 	rsc_mgr->miscdev.name = "gunyah";
 	rsc_mgr->miscdev.minor = MISC_DYNAMIC_MINOR;
 	rsc_mgr->miscdev.fops = &gh_dev_fops;
 
 	ret = misc_register(&rsc_mgr->miscdev);
 	if (ret)
-		goto err_msgq;
+		goto err_irq_domain;
 
 	return 0;
+err_irq_domain:
+	irq_domain_remove(rsc_mgr->irq_domain);
 err_msgq:
 	mbox_free_channel(gh_msgq_chan(&rsc_mgr->msgq));
 	gh_msgq_remove(&rsc_mgr->msgq);
@@ -603,6 +768,7 @@ static int gh_rm_drv_remove(struct platform_device *pdev)
 	struct gh_rm_rpc *rm = platform_get_drvdata(pdev);
 
 	misc_deregister(&rm->miscdev);
+	irq_domain_remove(rm->irq_domain);
 	mbox_free_channel(gh_msgq_chan(&rm->msgq));
 	gh_msgq_remove(&rm->msgq);
 
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index e317d7ac938f..8cb6af88c75d 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -26,6 +26,9 @@ struct gunyah_resource {
 	enum gunyah_resource_type type;
 	u64 capid;
 	int irq;
+
+	/* To help allocator in resource manager */
+	u32 rm_label;
 };
 
 /**
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index be434bcf9b4e..eee993a33971 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -115,6 +115,10 @@ ssize_t gh_rm_get_hyp_resources(struct gh_rm_rpc *rm, u16 vmid,
 				struct gh_rm_hyp_resource **resources);
 int gh_rm_get_vmid(struct gh_rm_rpc *rm, u16 *vmid);
 
+struct gunyah_resource *gh_rm_alloc_resource(struct gh_rm_rpc *rm,
+						struct gh_rm_hyp_resource *hyp_resource);
+void gh_rm_free_resource(struct gunyah_resource *ghrsc);
+
 struct gunyah_rm_platform_ops {
 	int (*pre_mem_share)(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *mem_parcel);
 	int (*post_mem_reclaim)(struct gh_rm_rpc *rm, struct gh_rm_mem_parcel *mem_parcel);
-- 
2.25.1

